import QtQuick 6.5
import QtQuick.Controls 6.5
import "../ButtonComponents"

Page {
    id: page1  // 页面ID

    // Rectangle: 矩形背景
    // Rectangle {
    //     anchors.fill: parent  // 填充整个页面
    //     color: "#ffffff"      // 白色背景
    //     opacity: 0.5
    // }

    // Text: 显示文本
    Text {
        text: "微信页面"       // 文本内容
        font.pixelSize: 24    // 字体大小
        color: "#07C160"      // 微信绿色
        anchors.centerIn: parent  // 居中显示
    }
    FlatButton {
        text: "FlatButton按钮测试"
        anchors.centerIn: parent
        onClicked: {
            mainStack.push(digitalPage)
        }
    }
}
