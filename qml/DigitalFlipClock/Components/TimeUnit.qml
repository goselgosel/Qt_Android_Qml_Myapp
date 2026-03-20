// qml/components/TimeUnit.qml
// 时间单位组件：将两个数字放在同一个底框内
// 用于显示时、分、秒（每个都是两位数）

import QtQuick

Item {
    id: timeUnitContainer           // 组件 ID

    // === 可绑定属性 ===
    property int value: 0                // 当前显示的时间值（0-99）
    property string digitColor: "#FFFFFF"  // 数字颜色
    property int unitWidth: 200          // 组件宽度（默认）
    property int unitHeight: 200         // 组件高度（默认）

    // 自动计算数字大小
    property int digitSize: Math.min(unitWidth, unitHeight) * 0.6  // 数字大小为组件的60%

    // === 背景矩形 ===
    // 一个底框包含两个数字
    Rectangle {
        id: unitBackground
        width: parent.width              // 使用父组件的宽度
        height: parent.height            // 使用父组件的高度
        anchors.centerIn: parent         // 在父容器中居中

        radius: 15                       // 圆角半径
        color: "#1A1A1A"                 // 背景颜色（深灰色）
        opacity: 0.5                     // 透明度 90%
        border.color: "#333333"          // 边框颜色
        border.width: 2                  // 边框宽度
    }

    // === 数字显示行 ===
    // 水平排列两个数字
    Row {
        id: digitRow
        anchors.centerIn: parent         // 在背景中居中
        spacing: 0                       // 数字之间无间距

        // 十位数字
        Text {
            id: tensDigit
            width: timeUnitContainer.unitWidth * 0.4  // 宽度为组件的一半
            height: timeUnitContainer.unitHeight
            text: Math.floor(timeUnitContainer.value / 10)  // 计算十位数
            color: timeUnitContainer.digitColor
            font.pixelSize: timeUnitContainer.digitSize
            font.bold: true
            font.family: "Monospace"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        // 个位数字
        Text {
            id: onesDigit
            width: timeUnitContainer.unitWidth * 0.4
            height: timeUnitContainer.unitHeight
            text: timeUnitContainer.value % 10  // 计算个位数
            color: timeUnitContainer.digitColor
            font.pixelSize: timeUnitContainer.digitSize
            font.bold: true
            font.family: "Monospace"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
