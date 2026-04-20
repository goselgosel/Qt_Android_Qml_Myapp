import QtQuick 6.5
import QtQuick.Controls 6.5

// 首页工具卡片组件。
// 用统一视觉规范减少页面样式分叉，后续新增工具只改 HomePage 数据模型即可。
Rectangle {
    id: root

    property string title: "工具"
    property string subtitle: "说明"
    property string iconText: "*"
    property color accentColor: "#5f6cf9"

    signal clicked()

    radius: 18
    color: "white"
    border.width: 1
    border.color: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.22)

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: parent.radius - 1
        color: Qt.lighter(root.accentColor, 1.9)
        opacity: 0.22
    }

    Column {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 8

        Rectangle {
            width: 36
            height: 36
            radius: 10
            color: root.accentColor

            Label {
                anchors.centerIn: parent
                text: root.iconText
                color: "white"
                font.pixelSize: 15
                font.bold: true
            }
        }

        Label {
            text: root.title
            color: "#1f2a44"
            font.pixelSize: 16
            font.bold: true
            elide: Text.ElideRight
        }

        Label {
            text: root.subtitle
            color: "#5b667d"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}