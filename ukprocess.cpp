#include "ukprocess.h"

UKProcess::UKProcess(QObject *parent) : QThread(parent)
{
    cl = "";
}

void UKProcess::run()
{
    QProcess *p=new QProcess(this);
    connect(p,SIGNAL(finished(int)),this,SLOT(quit()));
    connect(p,SIGNAL(finished(int,QProcess::ExitStatus)),this,SLOT(quit()));

    p->start(cl);
    //p->deleteLater();
    exec();
}
