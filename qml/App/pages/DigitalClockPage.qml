import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import QtQuick.Window 6.5

// 数字时钟页面
// 目标：
// 1) 进入时切换到全屏无边框
// 2) 强制以横屏布局呈现（竖屏设备会旋转渲染）
// 3) 离开页面时恢复原窗口状态
Item {
    id: root

    property real scaleFactor: 1.0
    property string pageTitle: "数字时钟"
    property bool hideAppHeader: true

    // 主窗口对象由 Main.qml 注入，用于切换全屏/无边框。
    property var appWindow

    // 保存进入前窗口状态，退出时恢复，避免影响其它页面。
    property int previousVisibility: Window.Windowed
    property int previousFlags: Qt.Window

    readonly property bool deviceLandscape: width >= height

    function pad2(v) {
        return (v < 10 ? "0" : "") + v
    }

    function updateTime() {
        var now = new Date()
        hourLabel.text = pad2(now.getHours())
        minuteLabel.text = pad2(now.getMinutes())
        secondLabel.text = pad2(now.getSeconds())
        dateLabel.text = now.getFullYear() + "-" + pad2(now.getMonth() + 1) + "-" + pad2(now.getDate())
    }

    Component.onCompleted: {
        if (appWindow) {
            previousVisibility = appWindow.visibility
            previousFlags = appWindow.flags
            appWindow.flags = Qt.Window | Qt.FramelessWindowHint
            appWindow.visibility = Window.FullScreen
            appWindow.contentOrientation = Qt.LandscapeOrientation
        }
        updateTime()
    }

    Component.onDestruction: {
        if (appWindow) {
            appWindow.flags = previousFlags
            appWindow.visibility = previousVisibility
            appWindow.contentOrientation = Qt.PrimaryOrientation
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: root.updateTime()
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0f1a35" }
            GradientStop { position: 1.0; color: "#1f2d5a" }
        }
    }

    // 横屏容器：竖屏时旋转 90 度后居中，保持横屏观感。
    Item {
        id: landscapeContainer
        anchors.centerIn: parent
        width: root.deviceLandscape ? root.width : root.height
        height: root.deviceLandscape ? root.height : root.width
        rotation: root.deviceLandscape ? 0 : 90

        Column {
            anchors.centerIn: parent
            spacing: 10 * root.scaleFactor

            Row {
                spacing: 8 * root.scaleFactor
                Label {
                    id: hourLabel
                    text: "00"
                    color: "#ffffff"
                    font.pixelSize: 114 * root.scaleFactor
                    font.bold: true
                }
                Label {
                    text: ":"
                    color: "#77d6ff"
                    font.pixelSize: 114 * root.scaleFactor
                    font.bold: true
                }
                Label {
                    id: minuteLabel
                    text: "00"
                    color: "#ffffff"
                    font.pixelSize: 114 * root.scaleFactor
                    font.bold: true
                }
                Label {
                    text: ":"
                    color: "#77d6ff"
                    font.pixelSize: 114 * root.scaleFactor
                    font.bold: true
                }
                Label {
                    id: secondLabel
                    text: "00"
                    color: "#b6e4ff"
                    font.pixelSize: 92 * root.scaleFactor
                    font.bold: true
                    anchors.verticalCenter: minuteLabel.verticalCenter
                }
            }

            Label {
                id: dateLabel
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#d9e3ff"
                font.pixelSize: 24 * root.scaleFactor
            }
        }

        Button {
            text: "退出时钟"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 18 * root.scaleFactor
            onClicked: {
                if (root.appWindow && root.appWindow.handleBackAction) {
                    root.appWindow.handleBackAction()
                }
            }
        }
    }
}