import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

// 首页：工具入口总览
// 横屏时增加列数，提升空间利用率；竖屏保持两列以保证点击目标大小。
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "工具总览"

    signal openTool(string toolId)

    readonly property int gridColumns: isLandscape ? 3 : 2

    ListModel {
        id: toolModel
        ListElement { toolId: "digitalClock"; title: "数字时钟"; subtitle: "横屏全屏显示"; iconText: "时"; accent: "#4f79ff" }
        ListElement { toolId: "notes"; title: "记事本"; subtitle: "本地持久化保存"; iconText: "记"; accent: "#5f6cf9" }
        ListElement { toolId: "todo"; title: "待办清单"; subtitle: "每日任务追踪"; iconText: "办"; accent: "#3f9d6f" }
        ListElement { toolId: "calculator"; title: "计算器"; subtitle: "基础四则计算"; iconText: "算"; accent: "#ef7c42" }
        ListElement { toolId: "stopwatch"; title: "计时器"; subtitle: "支持 Lap 记录"; iconText: "表"; accent: "#d85da3" }
        ListElement { toolId: "countdown"; title: "倒计时"; subtitle: "任务提醒倒计时"; iconText: "倒"; accent: "#5b7bff" }
        ListElement { toolId: "converter"; title: "单位换算"; subtitle: "长/重/温度"; iconText: "换"; accent: "#00a5a8" }
        ListElement { toolId: "currency"; title: "汇率换算"; subtitle: "支持手动汇率"; iconText: "汇"; accent: "#7e66ff" }
        ListElement { toolId: "tip"; title: "小费平摊"; subtitle: "聚餐快速结算"; iconText: "费"; accent: "#f15c4f" }
        ListElement { toolId: "picker"; title: "随机选择"; subtitle: "帮你做选择"; iconText: "选"; accent: "#f58d2a" }
        ListElement { toolId: "dateCalc"; title: "日期计算"; subtitle: "计算相差天数"; iconText: "日"; accent: "#2f9c84" }
        ListElement { toolId: "quickAccess"; title: "快捷功能"; subtitle: "手电筒/扫码占位"; iconText: "快"; accent: "#8866dd" }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        Column {
            width: root.width
            spacing: 16 * root.scaleFactor
            padding: 16 * root.scaleFactor

            Rectangle {
                width: parent.width - 2 * parent.padding
                height: (root.isLandscape ? 122 : 146) * root.scaleFactor
                radius: 22 * root.scaleFactor
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#3f6fff" }
                    GradientStop { position: 1.0; color: "#7b46f4" }
                }

                Column {
                    anchors.fill: parent
                    anchors.margins: 18 * root.scaleFactor
                    spacing: 8 * root.scaleFactor

                    Label {
                        text: "多功能日常工具箱"
                        color: "white"
                        font.pixelSize: 24 * root.scaleFactor
                        font.bold: true
                        wrapMode: Text.WordWrap
                    }

                    Label {
                        text: "横竖屏自适应 + 本地持久化 + 安卓返回键统一处理"
                        color: "#edf2ff"
                        font.pixelSize: 13 * root.scaleFactor
                        wrapMode: Text.WordWrap
                    }
                }
            }

            GridLayout {
                width: parent.width - 2 * parent.padding
                columns: root.gridColumns
                columnSpacing: 12 * root.scaleFactor
                rowSpacing: 12 * root.scaleFactor

                Repeater {
                    model: toolModel

                    ToolCard {
                        required property var modelData

                        Layout.fillWidth: true
                        Layout.preferredHeight: 126 * root.scaleFactor

                        title: modelData.title
                        subtitle: modelData.subtitle
                        iconText: modelData.iconText
                        accentColor: modelData.accent

                        onClicked: root.openTool(modelData.toolId)
                    }
                }
            }
        }
    }
}