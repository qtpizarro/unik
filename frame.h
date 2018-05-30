#ifndef FRAME_H
#define FRAME_H

#include <QObject>
#include <QQuickItem>
#include <QQuickImageProvider>
#include <QQuickItemGrabResult>

#include<QDebug>

class Frame : public QQuickImageProvider
{

public:
    Frame();
    QImage requestImage (const QString &id, QSize *size, const QSize &requestedSize);

signals:

public slots:
    void itemToFrame(QQuickItem *item);
    void loadFrame(const QByteArray url);

private:
    QImage _frame;

};

#endif // FRAME_H
