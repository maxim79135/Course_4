/********************************************************************************
** Form generated from reading UI file 'widget.ui'
**
** Created by: Qt User Interface Compiler version 5.13.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WIDGET_H
#define UI_WIDGET_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QSlider>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QGridLayout *gridLayout;
    QLabel *label_2;
    QSlider *slider;
    QLabel *label;
    QLabel *label_3;
    QLabel *label_4;
    QSlider *slider2;
    QLabel *label_5;
    QLabel *label_6;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName(QString::fromUtf8("Widget"));
        Widget->resize(515, 92);
        gridLayout = new QGridLayout(Widget);
        gridLayout->setSpacing(6);
        gridLayout->setContentsMargins(11, 11, 11, 11);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        label_2 = new QLabel(Widget);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        gridLayout->addWidget(label_2, 1, 2, 1, 1);

        slider = new QSlider(Widget);
        slider->setObjectName(QString::fromUtf8("slider"));
        slider->setOrientation(Qt::Horizontal);

        gridLayout->addWidget(slider, 1, 1, 1, 1);

        label = new QLabel(Widget);
        label->setObjectName(QString::fromUtf8("label"));

        gridLayout->addWidget(label, 1, 0, 1, 1);

        label_3 = new QLabel(Widget);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        gridLayout->addWidget(label_3, 3, 0, 1, 1);

        label_4 = new QLabel(Widget);
        label_4->setObjectName(QString::fromUtf8("label_4"));

        gridLayout->addWidget(label_4, 3, 2, 1, 1);

        slider2 = new QSlider(Widget);
        slider2->setObjectName(QString::fromUtf8("slider2"));
        slider2->setOrientation(Qt::Horizontal);

        gridLayout->addWidget(slider2, 3, 1, 1, 1);

        label_5 = new QLabel(Widget);
        label_5->setObjectName(QString::fromUtf8("label_5"));

        gridLayout->addWidget(label_5, 0, 0, 1, 3);

        label_6 = new QLabel(Widget);
        label_6->setObjectName(QString::fromUtf8("label_6"));

        gridLayout->addWidget(label_6, 2, 0, 1, 3);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QCoreApplication::translate("Widget", "\320\241\320\270\320\275\321\205\321\200\320\276\320\275\320\270\320\267\320\260\321\206\320\270\321\217 \320\277\321\200\320\276\321\206\320\265\321\201\321\201\320\276\320\262", nullptr));
        label_2->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        label_3->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        label_4->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_5->setText(QCoreApplication::translate("Widget", "1-\320\271 \320\277\320\276\321\202\320\276\320\272 \320\277\320\270\321\210\320\265\321\202 \321\201\320\273\321\203\321\207\320\260\320\271\320\275\321\203\321\216 \321\201\321\202\321\200\320\276\320\272\321\203 \320\262 \321\204\320\260\320\271\320\273 output.txt", nullptr));
        label_6->setText(QCoreApplication::translate("Widget", "2-\320\271 \320\277\320\276\321\202\320\276\320\272 \320\277\320\270\321\210\320\265\321\202 \320\262 \321\204\320\260\320\271\320\273 output.txt \320\265\320\263\320\276 \321\201\320\276\320\261\321\201\321\202\320\262\320\265\320\275\320\275\321\213\320\271 \321\200\320\260\320\267\320\274\320\265\321\200 \320\262 \320\261\320\260\320\271\321\202\320\260\321\205", nullptr));
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H
