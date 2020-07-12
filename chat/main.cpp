#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>

#include "backend.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<BackEnd>("io.qt.examples.backend", 1, 0, "BackEnd");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    /*BackEnd backend;
       QQuickView view;
       view.engine()->rootContext()->setContextProperty("backend", &backend);
       view.setSource(QUrl::fromLocalFile("main.qml"));

       QQuickView viewC;
       viewC.engine()->rootContext()->setContextProperty("backend", &backend);
       viewC.setSource(QUrl::fromLocalFile("client.qml"));
       //view.show();
*/
    return app.exec();
}
