#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QtConcurrent>
#include <thread>

namespace Ui {
class Widget;
}

class Widget : public QWidget {
  Q_OBJECT

public:
  explicit Widget(QWidget *parent = nullptr);
  ~Widget();

private:
  Ui::Widget *ui;

  std::thread* t1;

  std::thread* t2;
};

#endif // WIDGET_H
