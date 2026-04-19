import QtQuick
import "../../ButtonComponents"

Item {
    id: timeSetPageSon

    Rectangle {
        id: settingsButton
        width: 50
        height: 50
        radius: 25
        color: "#80000000"
        opacity: 0.3

        anchors {
            top: parent.top
            left: parent.left
            margins: 20
        }

        Text {
            anchors.centerIn: parent
            text: "S"
            color: "white"
            font.pixelSize: 24
        }

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
                console.log("Settings button clicked")
                mainStack.pop()
            }
        }

        Behavior on scale {
            NumberAnimation { duration: 200; easing.type: Easing.OutBack }
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    FlatButton {
        id: qiehuanButton
        baseColor: "#606060"
        text: "Switch Background"
        x: 242
        y: 25
        opacity: 0.7
        onClicked: {
            console.log("Switch background clicked")
            var nextIndex = (currentBackgroundIndex + 1) % backgroundImages.length
            currentBackgroundIndex = nextIndex
        }
    }
}