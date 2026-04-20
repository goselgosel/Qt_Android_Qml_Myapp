#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 维持资源导入路径，方便 QML 相对引用 qrc 模块。
    engine.addImportPath("qrc:/qml/");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // 直接加载打包后的主 QML，避免模块路径差异导致的启动失败。
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/myapp/Main.qml")));

    return QCoreApplication::exec();
}
