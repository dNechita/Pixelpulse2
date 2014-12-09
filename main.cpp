#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "SMU.h"

int main(int argc, char *argv[])
{
    registerTypes();

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SessionItem smu_session;
    smu_session.openAllDevices();
    engine.rootContext()->setContextProperty("session", &smu_session);

	engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    int r = app.exec();

    smu_session.closeAllDevices();

    return r;
}
