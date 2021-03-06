#include <algorithm>
#include <atomic>
#include <ctime>
#include <fstream>
#include <random>
#include <string>
#include <type_traits>
#include <mutex>
#include <condition_variable>

#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QString>
#include <QtConcurrent>

#include "ui_widget.h"
#include "widget.h"

template <class I, typename = std::enable_if_t<std::is_integral_v<I>>>
inline I randRange(I a, I b) {
  if (a > b) {
    std::swap(a, b);
  }
  static std::mt19937 e(static_cast<unsigned int>(std::time(nullptr)));
  std::uniform_int_distribution<I> dist(a, b);
  return dist(e);
}

std::mutex m;
std::atomic<bool> ready;
std::condition_variable cv;

static unsigned int timeout{2000}, timeout2{2000};

static bool needstostop;

static QString path("output.txt");

static void proc1() {
  while (!needstostop) {
    size_t len = randRange(40u, 50u);
    std::string str;
    str.reserve(len);

    for (size_t i = 0; i < len; ++i) {
      char c = static_cast<char>(randRange(65, 122));
      str.push_back(c);
    }

    std::unique_lock<std::mutex> lock(m);
    while (!ready.load()) cv.wait(lock);

    std::ofstream out(path.toStdString(),
                      std::ios_base::out | std::ios_base::app);
    qDebug() << QString("Writing: %1").arg(QString::fromStdString(str));
    out << str << std::endl;
    ready.store(true);
    cv.notify_all();
    out.flush();
    out.close();

    QThread::msleep(timeout);
  }
}

static void proc2() {
  while (!needstostop) {
    std::unique_lock<std::mutex> lock(m);
    while (!ready.load()) cv.wait(lock);

    QFile file(path);
    auto size = file.size();

    std::ofstream out(path.toStdString(),
                      std::ios_base::out | std::ios_base::app);
    auto str =
        QString("%1; %2 bytes")
            .arg(QDateTime::currentDateTime().toString("dd.MM.yyyy, HH:mm:ss"))
            .arg(size);
    qDebug() << QString("Writing: %1").arg(str);
    out << str.toStdString() << std::endl;
    ready.store(true);
    cv.notify_all();
    out.flush();
    out.close();

    QThread::msleep(timeout2);
  }
}

Widget::Widget(QWidget *parent) : QWidget(parent), ui(new Ui::Widget) {
  ui->setupUi(this);

  connect(ui->slider, &QSlider::valueChanged, this, [](int value) {
    auto value_u = static_cast<unsigned int>(value);
    unsigned int time = 300 + 2700 * value_u / 100;
    timeout = time;
  });
  connect(ui->slider2, &QSlider::valueChanged, this, [](int value) {
    auto value_u = static_cast<unsigned int>(value);
    unsigned int time = 300 + 2700 * value_u / 100;
    timeout2 = time;
  });
  ui->slider->setValue(60);
  ui->slider2->setValue(60);

  needstostop = false;

  // Clean up file
  std::ofstream out(path.toStdString());
  out.flush();
  out.close();

  t1 = QtConcurrent::run(&proc1);
  t2 = QtConcurrent::run(&proc2);
}

Widget::~Widget() {
  delete ui;
  needstostop = true;
  if (t1.isRunning()) {
    t1.waitForFinished();
  }
  if (t2.isRunning()) {
    t2.waitForFinished();
  }
}
