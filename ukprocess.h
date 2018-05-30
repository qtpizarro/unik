#ifndef UKPROCESS_H
#define UKPROCESS_H

#include <QObject>
#include <QThread>
#include <QProcess>

class UKProcess : public QThread
{
    Q_OBJECT
public:
    explicit UKProcess(QObject *parent = nullptr);
    QByteArray cl;
    void run();
signals:
    //void fini
public slots:
};

#endif // UKPROCESS_H
