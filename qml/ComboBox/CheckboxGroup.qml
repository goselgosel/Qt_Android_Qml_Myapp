// ComboBoxComponents.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material


// 2. 多选框组
Rectangle {
    id: checkboxGroup
    width: 200
    height: childrenRect.height
    color: "transparent"
    
    // 样式属性
    property var options: ["选项A", "选项B", "选项C", "选项D"]
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
                
                // 自定义多选框
                Rectangle {
                    id: checkBox
                    width: 18
                    height: 18
                    radius: 4
                    border.width: 2
                    border.color: isChecked ? checkboxGroup.checkedColor : "#CCCCCC"
                    color: isChecked ? checkboxGroup.checkedColor : "transparent"
                    
                    // 勾选图标
                    Text {
                        anchors.centerIn: parent
                        text: "✓"
                        color: "white"
                        font.pixelSize: 12
                        font.bold: true
                        visible: isChecked
                    }
                }
                
                // 选项文本
                Text {
                    text: modelData
                    font.pixelSize: checkboxGroup.fontSize
                    font.family: "Microsoft YaHei"
                    color: checkboxGroup.textColor
                    anchors.verticalCenter: checkBox.verticalCenter
                    anchors.left: checkBox.right
                    anchors.leftMargin: 8
                }
                
                // 点击区域
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        isChecked = !isChecked
                        updateSelectedOptions()
                    }
                }
                
                // 是否选中
                property bool isChecked: false
                
                Component.onCompleted: {
                    isChecked = checkboxGroup.selectedOptions.includes(modelData)
                }
            }
        }
    }
    
    // 更新选中项
    function updateSelectedOptions() {
        var selected = []
        for (var i = 0; i < children[0].children.length; i++) {
            var item = children[0].children[i]
            if (item.isChecked) {
                selected.push(item.children[1].text)
            }
        }
        checkboxGroup.selectedOptions = selected
        console.log("选中项:", selected)
    }
}