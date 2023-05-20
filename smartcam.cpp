#include "smartcam.h"
#include "qforeach.h"
#include <QJsonDocument>
#include <QJsonObject>>
#include <QJsonArray>
#include <QFile>
#include <QDir>
#include <QUrl>

smartcam::smartcam(QObject *parent)
    : QObject{parent}
{
    QUrl u = QUrl("liste_smart_cams");
    QFile f("liste_smart_cams.json");
    f.open(QFile::ReadOnly);
    QByteArray bytearray = f.readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(bytearray);
    QJsonObject json_obj = jsonDoc.object();

    if (json_obj.isEmpty()) {
        qDebug() << "JSON object is empty.";
    }
    QJsonArray jsonArray = json_obj["data"].toArray();
    mCams.clear();
    foreach (const QJsonValue & v, jsonArray)
    {
        QString pos = v.toObject().value("position_gps").toString();
        QStringList pieces = pos.split( "," );
        QGeoCoordinate g;
        QStringList data;
        g.setLatitude(pieces[0].toDouble());
        QString lon = pieces[1].removeFirst();
        g.setLongitude(lon.toDouble());
        data.append(v.toObject().value("id").toString());
        data.append(pieces[0]);
        data.append(lon);
        data.append(v.toObject().value("etat_marche").toString());
        data.append(v.toObject().value("niveau_batterie").toString());
        data.append(v.toObject().value("version_software").toString());
        data.append(v.toObject().value("derniere_image_url").toString());

        mCams.append(data);
        qDebug()<<mCams;
    }

}

