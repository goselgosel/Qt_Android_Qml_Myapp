import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "随机选择"
    property string resultText: ""

    function optionsList() {
        return optionsArea.text.split(/[\n,]+/)
            .map(function(v) { return v.trim() })
            .filter(function(v) { return v.length > 0 })
    }

    function pickOne() {
        var list = optionsList()
        if (list.length === 0) {
            resultText = "请先输入候选项"
            return
        }
        var index = Math.floor(Math.random() * list.length)
        resultText = list[index]
    }

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        Label {
            text: "支持逗号或换行分隔，例如：火锅, 烧烤, 日料"
            color: "#5b667d"
            font.pixelSize: 12 * root.scaleFactor
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 10
            TextArea {
                id: optionsArea
                anchors.fill: parent
                wrapMode: TextArea.Wrap
                placeholderText: "输入候选项..."
                font.pixelSize: 14 * root.scaleFactor
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Button { text: "随机抽取"; Layout.fillWidth: true; onClicked: root.pickOne() }
            Button {
                text: "清空"
                Layout.fillWidth: true
                onClicked: {
                    optionsArea.clear()
                    root.resultText = ""
                }
            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 92 * root.scaleFactor
            Label {
                anchors.centerIn: parent
                text: root.resultText.length > 0 ? root.resultText : "结果显示区域"
                color: root.resultText.length > 0 ? "#1f2a44" : "#8f96a8"
                font.pixelSize: 22 * root.scaleFactor
                font.bold: root.resultText.length > 0
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }
        }
    }
}
