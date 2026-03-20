import QtQuick 6.5
import "../ButtonComponents"
//import QtQuick.Controls 6.5

Item {
    id: page2
    // Rectangle {
    //     anchors.fill: parent
    //     color: "#ffffff"
    // }

    Text {
        text: "通讯录页面"
        font.pixelSize: 24
        color: "#07C160"
        anchors.centerIn: parent
    }
    MaterialButton {
        text: "MaterialButton按钮"
        anchors.centerIn: parent
    }
}
