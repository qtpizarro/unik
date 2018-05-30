#include "frame.h"

Frame::Frame() : QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage Frame::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    _frame.load("H:/aaaa.png");
    QImage i;
    i=_frame;
    return i;
    qDebug()<<"..........."<<id<<" "<<i.size().width();
    //return _frame;

}

void Frame::itemToFrame(QQuickItem *item)
{
    qDebug()<<"DDDDDDDDDDD--------"<<item->width();
    auto grabResult = item->grabToImage();
    QObject::connect(grabResult.data(), &QQuickItemGrabResult::ready, [=]() {
        qDebug()<<"DDDDDDDDDDD"<<grabResult->image().width();
        _frame = grabResult->image();
        _frame.save("H:/aaaa.png");
    });
}

void Frame::loadFrame(const QByteArray url)
{
    _frame.load(url);
}
