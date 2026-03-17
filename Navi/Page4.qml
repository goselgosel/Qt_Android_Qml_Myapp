import QtQuick 6.5
import "../ButtonComponents"
import QtQuick.Layouts 1.15

Item {
    id: page4
    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        // Material 风格按钮
        MaterialButton {
            text: "Material 按钮"
            primaryColor: "#e74c3c"
            hoverColor: "#c0392b"
            Layout.alignment: Qt.AlignHCenter

            onClicked: console.log("Material 按钮被点击")
        }

        // 扁平化按钮
        FlatButton {
            text: "扁平化按钮"
            baseColor: "#2ecc71"
            Layout.alignment: Qt.AlignHCenter

            onClicked: console.log("扁平按钮被点击")
        }

        // 3D 按钮
        ThreeDButton {
            text: "3D 按钮"
            topColor: "#9b59b6"
            sideColor: "#8e44ad"
            Layout.alignment: Qt.AlignHCenter

            onClicked: console.log("3D 按钮被点击")
        }

        // 图标按钮
        IconButton {
            iconSource: "qrc:/icons/heart.svg"
            color: "#e74c3c"
            size: 60
            Layout.alignment: Qt.AlignHCenter

            onClicked: console.log("图标按钮被点击")
        }
        Text {
            text: "我页面"
            font.pixelSize: 24
            color: "#07C160"
            //anchors.centerIn: parent
        }
    }
}
