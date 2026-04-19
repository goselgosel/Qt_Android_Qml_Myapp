import QtQuick 6.5
import "../ButtonComponents"
import QtQuick.Layouts 1.15

Item {
    id: page4

    MaterialButton {
        text: "Flip Clock"
        primaryColor: "#e74c3c"
        hoverColor: "#c0392b"
        x: parent.width * 0.1
        y: parent.height * 0.1
        width: parent.width * 0.4
        height: parent.height * 0.07

        onClicked: {
            console.log("Material button clicked")
            mainStack.push(digitalPage)
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        MaterialButton {
            text: "Material Button"
            primaryColor: "#e74c3c"
            hoverColor: "#c0392b"
            Layout.alignment: Qt.AlignHCenter
            onClicked: console.log("Material button clicked")
        }

        FlatButton {
            text: "Flat Button"
            baseColor: "#2ecc71"
            Layout.alignment: Qt.AlignHCenter
            onClicked: console.log("Flat button clicked")
        }

        ThreeDButton {
            text: "3D Button"
            topColor: "#9b59b6"
            sideColor: "#8e44ad"
            Layout.alignment: Qt.AlignHCenter
            onClicked: console.log("3D button clicked")
        }

        IconButton {
            iconSource: "qrc:/icons/heart.svg"
            color: "#e74c3c"
            size: 60
            Layout.alignment: Qt.AlignHCenter
            onClicked: console.log("Icon button clicked")
        }

        Text {
            text: "Me Page"
            font.pixelSize: 24
            color: "#07C160"
        }
    }
}