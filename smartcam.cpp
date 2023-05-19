#include "smartcam.h"
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QUrl>

smartcam::smartcam(QObject *parent)
    : QObject{parent}
{
  QUrl u = QUrl("qrc:/liste_smart_cams");
    qDebug()<<u;

}
