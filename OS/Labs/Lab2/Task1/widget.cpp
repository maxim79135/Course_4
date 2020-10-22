#include <algorithm>
#include <atomic>
#include <ctime>
#include <fstream>
#include <random>
#include <string>
#include <type_traits>
#include <cmath>

#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QString>
#include <QtConcurrent>

#include "ui_widget.h"
#include "widget.h"

class PetersonMutex {
private:
  std::atomic_bool wants[2];

  std::atomic_ullong waiting;

public:
  PetersonMutex() {
    wants[0] = wants[1] = false;
    waiting = 0;
  }

  void lock(size_t id) {
    wants[id] = true;
    size_t other = 1u - id;
    waiting = id;

    while (wants[other].load() && waiting.load() == id) {
    }
  }

  void unlock(size_t id) { wants[id] = false; }
};

static PetersonMutex mutex;

static unsigned int timeout{2000}, timeout2{2000};

static bool needstostop;

static double x = 1;
static int h = 1;

static QString path("output.txt");

static void proc1() {
  while (!needstostop && x <= 15) {
    mutex.lock(0);

    double y = log(x) / 3;
    QString str = QString::number(y);
    std::ofstream out;
    qDebug() << QString("Writing: x = %1, y = %2").arg(QString::number(x), str);
    x += h;
    out.open(path.toStdString(), std::ios_base::app);
    out << y << "\n";
    out.close();

    mutex.unlock(0);

    QThread::msleep(timeout);
  }
}

static void proc2() {
  while (!needstostop) {
    mutex.lock(1);

    std::ifstream in;
    in.open(path.toStdString(), std::ios_base::in);
    double tmp;
    std::string str;
    double z = 0;
    while (!in.eof()) {
        in >> tmp;
        z += tmp;
    }

    in.close();

    qDebug() << QString("Reading: %1").arg(QString::number(z));

    mutex.unlock(1);

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
  std::ofstream out;
  out.open(path.toStdString());
  out.clear();
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
