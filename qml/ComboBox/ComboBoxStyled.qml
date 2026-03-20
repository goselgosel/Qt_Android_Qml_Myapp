// ComboBoxComponents.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

// 1. 美化下拉框
ComboBox {
    id: styledComboBox
    width: 200
    model: ["选项1", "选项2", "选项3", "选项4", "选项5"]
    currentIndex: 0
    
    // 样式属性
    property color backgroundColor: "white"        // 背景颜色
    property color borderColor: "#E0E0E0"        // 边框颜色
    property color focusBorderColor: "#007AFF"    // 聚焦边框颜色
    property color textColor: "#333333"           // 文字颜色
    property color dropdownColor: "white"         // 下拉框颜色
    property int borderRadius: 8                  // 圆角半径
    property int fontSize: 14                     // 字体大小
    property int itemHeight: 40                   // 项高度
    property bool hasShadow: true                 // 是否有阴影
    
    // 背景
    background: Rectangle {
        id: comboBg
        radius: styledComboBox.borderRadius
        color: styledComboBox.backgroundColor
        border.width: 1
        border.color: styledComboBox.activeFocus ? styledComboBox.focusBorderColor : styledComboBox.borderColor
        
        layer.enabled: styledComboBox.hasShadow
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#20000000"
            radius: 4
            samples: 9
            verticalOffset: 1
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }
    }
    
    // 内容
    contentItem: Text {
        leftPadding: 12
        rightPadding: arrowIcon.width + 20
        text: styledComboBox.displayText
        font.pixelSize: styledComboBox.fontSize
        font.family: "Microsoft YaHei"
        color: styledComboBox.textColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    
    // 下拉箭头
    Image {
        id: arrowIcon
        source: "qrc:/icons/arrow_down.svg"
        width: 12
        height: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        
        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: styledComboBox.textColor
        }
        
        rotation: styledComboBox.popup.visible ? 180 : 0
        
        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }
    
    // 下拉框样式
    popup: Popup {
        id: comboPopup
        y: styledComboBox.height
        width: styledComboBox.width
        implicitHeight: contentItem.implicitHeight
        padding: 0
        
        background: Rectangle {
            radius: styledComboBox.borderRadius
            color: styledComboBox.dropdownColor
            border.color: styledComboBox.borderColor
            border.width: 1
            
            layer.enabled: styledComboBox.hasShadow
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#40000000"
                radius: 8
                samples: 16
                verticalOffset: 2
            }
        }
        
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: styledComboBox.popup.visible ? styledComboBox.delegateModel : null
            currentIndex: styledComboBox.highlightedIndex
            
            ScrollIndicator.vertical: ScrollIndicator { }
        }
        
        // 下拉项代理
        delegate: ItemDelegate {
            id: comboDelegate
            width: styledComboBox.width
            height: styledComboBox.itemHeight
            
            // 项样式属性
            property bool isCurrent: styledComboBox.currentIndex === index
            property bool isHovered: hovered
            
            background: Rectangle {
                color: {
                    if (comboDelegate.isCurrent) return "#007AFF20"
                    else if (comboDelegate.isHovered) return "#F5F5F5"
                    else return "transparent"
                }
            }
            
            contentItem: Text {
                text: modelData
                font.pixelSize: styledComboBox.fontSize
                font.family: "Microsoft YaHei"
                color: comboDelegate.isCurrent ? "#007AFF" : "#333333"
                verticalAlignment: Text.AlignVCenter
                leftPadding: 12
                elide: Text.ElideRight
            }
        }
    }
}
