// IconButton.qml
import QtQuick 6.5
import QtQuick.Controls 6.5

Item {
    id: root

    property alias iconSource: icon.source
    property string tooltip: ""
    property color color: "#3498db"
    property int size: 48

    signal clicked()

    width: size
    height: size

    // 背景圆
    Rectangle {
        id: background
        anchors.fill: parent
        radius: width / 2
        color: root.color
        opacity: 0.1

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    // 图标
    Image {
        id: icon
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: width
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectFit
    }

    // 悬停效果
    Rectangle {
        id: hoverEffect
        anchors.fill: parent
        radius: parent.width / 2
        color: root.color
        opacity: 0
        scale: 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        Behavior on scale {
            NumberAnimation { duration: 300; easing.type: Easing.OutBack }
        }
    }

    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            hoverEffect.opacity = 0.2
            hoverEffect.scale = 1
        }

        onExited: {
            hoverEffect.opacity = 0
            hoverEffect.scale = 0
        }

        onPressed: {
            background.opacity = 0.3
            scaleAnim.start()
        }

        onReleased: {
            background.opacity = 0.1
        }

        onClicked: {
            root.clicked()
        }
    }

    // 缩放动画
    SequentialAnimation {
        id: scaleAnim
        NumberAnimation {
            target: root
            property: "scale"
            to: 0.9
            duration: 100
        }
        NumberAnimation {
            target: root
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.OutElastic
        }
    }
}
