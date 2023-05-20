#ifndef SMARTCAM_H
#define SMARTCAM_H

#include <QObject>
#include <QGeoCoordinate>
#include <QList>
#include <QPair>

class smartcam : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QStringList> cam READ getCam NOTIFY camChanged)

public:
    explicit smartcam(QObject *parent = nullptr);

    Q_INVOKABLE QList<QStringList> getCam(){return mCams;}

signals:
    void camChanged();

private:
    QList<QStringList> mCams;

};

#endif // SMARTCAM_H
