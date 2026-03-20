// MaterialButton.qml
import QtQuick 6.5
import QtQuick.Controls 6.5

Button {
    id: control

    // 自定义属性
    property color primaryColor: "#3498db"
    property color hoverColor: "#2980b9"
    property color pressedColor: "#21618c"
    property color textColor: "white"
    property int borderRadius: 8
    property bool enableShadow: true
    property bool enableRipple: true

    // 尺寸动画
    property bool scaleOnClick: true
    property real normalScale: 1.0
    property real pressedScale: 0.95

    implicitWidth: 120
    implicitHeight: 48

    // 背景
    background: Rectangle {
        id: bgRect
        implicitWidth: 100
        implicitHeight: 40
        radius: control.borderRadius
        color: control.down ? control.pressedColor :
               control.hovered ? control.hoverColor : control.primaryColor

        // 渐变效果
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.lighter(bgRect.color, 1.2) }
            GradientStop { position: 1.0; color: bgRect.color }
        }

        // 边框
        border.width: 1
        border.color: Qt.darker(bgRect.color, 1.2)

        // 阴影
        layer.enabled: control.enableShadow && !control.down
        /*layer.effect: DropShadow {
            id: shadow
            horizontalOffset: 0
            verticalOffset: control.down ? 2 : 4
            radius: control.down ? 3 : 8
            samples: 13
            color: "#40000000"
            Behavior on verticalOffset { NumberAnimation { duration: 150 } }
            Behavior on radius { NumberAnimation { duration: 150 } }
        }*/

        // 涟漪效果
        Rectangle {
            id: ripple
            property real size: 0
            property point mousePos: Qt.point(0, 0)

            x: mousePos.x - size/2
            y: mousePos.y - size/2
            width: size
            height: size
            radius: size/2
            color: Qt.rgba(1, 1, 1, 0.3)
            opacity: 0
            visible: control.enableRipple
        }

        // 状态变化动画
        states: [
            State {
                name: "PRESSED"
                when: control.down
                PropertyChanges { target: bgRect; scale: control.pressedScale }
            }
        ]

        transitions: [
            Transition {
                from: ""; to: "PRESSED"
                PropertyAnimation {
                    target: bgRect;
                    properties: "scale"
                    duration: 100
                    easing.type: Easing.OutCubic
                }
            },
            Transition {
                from: "PRESSED"; to: ""
                PropertyAnimation {
                    target: bgRect;
                    properties: "scale"
                    duration: 200
                    easing.type: Easing.OutElastic
                    easing.amplitude: 2.0
                    easing.period: 1.5
                }
            }
        ]
    }

    // 文本
    contentItem: Text {
        text: control.text
        font: control.font
        color: control.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: {
            if (control.enableRipple) {
                rippleEffect(mouseX, mouseY)
            }
            control.clicked()
        }

        onPressed: {
            if (control.scaleOnClick) {
                bgRect.state = "PRESSED"
            }
        }

        onReleased: {
            if (control.scaleOnClick) {
                bgRect.state = ""
            }
        }
    }

    // 涟漪效果函数
    function rippleEffect(x, y) {
        ripple.mousePos = Qt.point(x, y)
        ripple.opacity = 1
        ripple.size = 0

        var anim = Qt.createQmlObject('
            import QtQuick 2.15
            SequentialAnimation {
                id: rippleAnim
                PropertyAnimation {
                    target: ripple
                    property: "size"
                    to: Math.max(control.width, control.height) * 2
                    duration: 600
                    easing.type: Easing.OutCubic
                }
                PropertyAnimation {
                    target: ripple
                    property: "opacity"
                    to: 0
                    duration: 300
                }
            }
        ', control)

        anim.start()
        anim.destroy(1000)
    }
}
