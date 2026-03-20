import QtQuick
//import Navis 1.0
import "../../ButtonComponents"

Item {
    id:timeSetPageSon
    Rectangle {

        id: settingsButton
        width: 50
        height: 50
        radius: 25
        color: "#80000000"  // 半透明黑色
        opacity: 0.3

        anchors {
            top: parent.top
            left: parent.left
            margins: 20
        }

        // 齿轮图标
        Text {
            anchors.centerIn: parent
            text: "⚙"  // 齿轮符号
            color: "white"
            font.pixelSize: 24
        }

        // 鼠标悬停效果
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                settingsButton.opacity = 0.9
                settingsButton.scale = 1.1
            }

            onExited: {
                settingsButton.opacity = 0.7
                settingsButton.scale = 1.0
            }

            onClicked: {
                console.log("点击设置按钮")
                // 跳转到设置页面
                mainStack.pop()
            }
        }

        // 点击动画
        Behavior on scale {
            NumberAnimation { duration: 200; easing.type: Easing.OutBack }
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    FlatButton {
        id:qiehuanButton
        baseColor: "#606060"
        text: "切换背景"
        // width: 100
        // height: 50
        // height: parent.height*0.1
        // width: parent.width*0.1
        x: 242
        y: 25
        opacity: 0.7
        onClicked: {
            console.log("切换背景 按钮被点击")
            var nextIndex = (currentBackgroundIndex + 1) % backgroundImages.length
            currentBackgroundIndex = nextIndex
        }
    }
}
