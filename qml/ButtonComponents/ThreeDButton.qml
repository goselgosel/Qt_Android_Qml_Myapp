// ThreeDButton.qml
import QtQuick 6.5
import QtQuick.Controls 6.5

Item {
    id: root

    property string text: "3D Button"
    property color topColor: "#3498db"
    property color sideColor: "#2980b9"
    property int depth: 8

    signal clicked()

    width: 150
    height: 60

    // 3D 效果 - 顶部
    Rectangle {
        id: topFace
        anchors.fill: parent
        color: topColor
        radius: 8

        // 内阴影
        layer.enabled: true
        /*layer.effect: InnerShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 4
            samples: 9
            color: "#20000000"
        }*/

        // 文字
        Text {
            anchors.centerIn: parent
            text: root.text
            color: "white"
            font.pixelSize: 16
            font.bold: true
        }
    }

    // 3D 效果 - 侧面
    Rectangle {
        id: sideFace
        anchors {
            top: topFace.bottom
            left: topFace.left
            right: topFace.right
        }
        height: root.depth
        color: sideColor
        radius: 8

        // 渐变
        gradient: Gradient {
            GradientStop { position: 0.0; color: sideColor }
            GradientStop { position: 1.0; color: Qt.darker(sideColor, 1.3) }
        }
    }

    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        // 按下动画
        onPressed: {
            pressAnim.start()
        }

        onReleased: {
            releaseAnim.start()
        }

        onClicked: {
            root.clicked()
        }
    }

    // 按下动画
    ParallelAnimation {
        id: pressAnim
        NumberAnimation {
            target: topFace
            property: "y"
            to: root.depth
            duration: 100
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: sideFace
            property: "height"
            to: 2
            duration: 100
            easing.type: Easing.OutCubic
        }
    }

    // 释放动画
    ParallelAnimation {
        id: releaseAnim
        NumberAnimation {
            target: topFace
            property: "y"
            to: 0
            duration: 200
            easing.type: Easing.OutElastic
            easing.amplitude: 2.0
        }
        NumberAnimation {
            target: sideFace
            property: "height"
            to: root.depth
            duration: 200
            easing.type: Easing.OutElastic
        }
    }
}
