import QtQuick 6.5
import "../ButtonComponents"

Item {
    id: page2

    Text {
        text: "Contacts Page"
        font.pixelSize: 24
        color: "#07C160"
        anchors.centerIn: parent
    }

    MaterialButton {
        text: "Material Button"
        anchors.centerIn: parent
    }
}