import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Rectangle {
    id: checkboxGroup
    width: 200
    height: childrenRect.height
    color: "transparent"

    property var options: ["Option A", "Option B", "Option C", "Option D"]
    property var selectedOptions: []
    property color textColor: "#333333"
    property color checkedColor: "#007AFF"
    property int fontSize: 14
    property int spacing: 8

    Column {
        width: parent.width
        spacing: checkboxGroup.spacing

        Repeater {
            model: checkboxGroup.options

            delegate: Rectangle {
                width: parent.width
                height: 30
                color: "transparent"

                Rectangle {
                    id: checkBox
                    width: 18
                    height: 18
                    radius: 4
                    border.width: 2
                    border.color: isChecked ? checkboxGroup.checkedColor : "#CCCCCC"
                    color: isChecked ? checkboxGroup.checkedColor : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "v"
                        color: "white"
                        font.pixelSize: 12
                        font.bold: true
                        visible: isChecked
                    }
                }

                Text {
                    text: modelData
                    font.pixelSize: checkboxGroup.fontSize
                    font.family: "Microsoft YaHei"
                    color: checkboxGroup.textColor
                    anchors.verticalCenter: checkBox.verticalCenter
                    anchors.left: checkBox.right
                    anchors.leftMargin: 8
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        isChecked = !isChecked
                        updateSelectedOptions()
                    }
                }

                property bool isChecked: false

                Component.onCompleted: {
                    isChecked = checkboxGroup.selectedOptions.includes(modelData)
                }
            }
        }
    }

    function updateSelectedOptions() {
        var selected = []
        for (var i = 0; i < children[0].children.length; i++) {
            var item = children[0].children[i]
            if (item.isChecked) {
                selected.push(item.children[1].text)
            }
        }
        checkboxGroup.selectedOptions = selected
        console.log("Selected:", selected)
    }
}