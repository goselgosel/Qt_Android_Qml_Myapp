// qml/components/TimeDisplay.qml
// 完整时间显示组件
// 包含时、分、秒三个时间单位，用冒号分隔

import QtQuick

Item {
    id: timeDisplay

    // === 时间属性 ===
    property date currentTime: new Date()
    property int hours: currentTime.getHours()
    property int minutes: currentTime.getMinutes()
    property int seconds: currentTime.getSeconds()

    // === 组件尺寸参数 ===
    // 可以根据需要调整这些参数
    property int unitWidth: 180           // 时间单位宽度（包含两个数字）
    property int unitHeight: 260          // 时间单位高度
    property int colonWidth: 30           // 冒号宽度（减少占用位置）
    property int spacing: 10              // 组件间距（减小间距）

    // 计算总宽度
    width: (unitWidth * 3) + (colonWidth * 2) + (spacing * 2)
    height: unitHeight

    // === 定时器 ===
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var now = new Date();
            timeDisplay.currentTime = now;
            timeDisplay.hours = now.getHours();
            timeDisplay.minutes = now.getMinutes();
            timeDisplay.seconds = now.getSeconds();
        }
    }

    // === 水平布局 ===
    Row {
        id: timeRow
        anchors.centerIn: parent
        spacing: timeDisplay.spacing  // 使用自定义间距

        // === 小时单位 ===
        // 显示小时（两位数在一个底框内）
        TimeUnit {
            id: hourUnit
            width: timeDisplay.unitWidth
            height: timeDisplay.unitHeight
            value: hours
            digitColor: "#FFFFFF"
        }

        // === 第一个冒号 ===
        // 时:分之间的冒号
        Item {
            width: timeDisplay.colonWidth
            height: timeDisplay.unitHeight

            Text {
                anchors.centerIn: parent
                text: ":"
                color: "#333333"
                font.pixelSize: timeDisplay.unitHeight * 0.5  // 冒号大小为高度的50%
                font.bold: true
            }
        }

        // === 分钟单位 ===
        // 显示分钟（两位数在一个底框内）
        TimeUnit {
            id: minuteUnit
            width: timeDisplay.unitWidth
            height: timeDisplay.unitHeight
            value: minutes
            digitColor: "#FFFFFF"
        }

        // === 第二个冒号 ===
        // 分:秒之间的冒号
        Item {
            width: timeDisplay.colonWidth
            height: timeDisplay.unitHeight

            Text {
                anchors.centerIn: parent
                text: ":"
                color: "#333333"
                font.pixelSize: timeDisplay.unitHeight * 0.5
                font.bold: true
            }
        }

        // === 秒单位 ===
        // 显示秒（两位数在一个底框内）
        TimeUnit {
            id: secondUnit
            width: timeDisplay.unitWidth
            height: timeDisplay.unitHeight
            value: seconds
            digitColor: "#FFFFFF"
        }
    }
}
