// FlatButton.qml
import QtQuick 6.5
import QtQuick.Controls 6.5
import  QtQuick.Effects  // 也可以指定版本

Rectangle {
    id: root

    // 属性
    property string text: "Button"
    property color baseColor: "#3498db"
    property color textColor: "white"
    property alias font: label.font
    property int padding: 20

    signal clicked()

    width: label.width + padding * 2
    height: label.height + padding
    radius: height / 2
    color: mouseArea.pressed ? Qt.darker(baseColor, 1.2) :
           mouseArea.containsMouse ? Qt.darker(baseColor, 1.1) : baseColor

    // 背景动画
    Behavior on color {
        ColorAnimation { duration: 150 }
    }

    // 文字
    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: textColor
        font.pixelSize: 16
        font.weight: Font.Medium
    }

    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        // 点击动画
        onClicked: {
            // 缩放动画
            scaleAnim.start()
            // 透明度动画
            opacityAnim.start()
            root.clicked()
        }

        // 缩放动画序列
        SequentialAnimation {
            id: scaleAnim
            NumberAnimation {
                target: root
                property: "scale"
                to: 0.95
                duration: 100
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: root
                property: "scale"
                to: 1.0
                duration: 200
                easing.type: Easing.OutElastic
                easing.amplitude: 2.0
                easing.period: 1.5
            }
        }

        // 闪烁动画
        SequentialAnimation {
            id: opacityAnim
            NumberAnimation {
                target: flashRect
                property: "opacity"
                to: 0.4
                duration: 50
            }
            NumberAnimation {
                target: flashRect
                property: "opacity"
                to: 0
                duration: 300
            }
        }
    }

    // 闪烁层
    Rectangle {
        id: flashRect
        anchors.fill: parent
        radius: parent.radius
        color: "white"
        opacity: 0
    }

    // 悬停阴影
    layer.enabled: true
    layer.effect: MultiEffect {
            id: multiEffect

            // 通过绑定控制阴影是否启用
            shadowEnabled: mouseArea.containsMouse && !mouseArea.pressed

            // 阴影属性
            shadowColor: "#40000000"
            shadowBlur: 0.8  // 对应 radius: 8 (值范围 0.0-1.0，8/10≈0.8)
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 4

            // 注意：MultiEffect 不支持 samples 属性

            // MultiEffect 支持阴影不透明度控制
            shadowOpacity: 1.0
        }
}
