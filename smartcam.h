#ifndef SMARTCAM_H
#define SMARTCAM_H

#include <QObject>

class smartcam : public QObject
{
    Q_OBJECT
public:
    explicit smartcam(QObject *parent = nullptr);

signals:

};

#endif // SMARTCAM_H
