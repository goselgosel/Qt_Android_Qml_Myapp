import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"
import "../services/Storage.js" as Storage

// 汇率换算页
// 说明：离线场景下不拉外网汇率，使用手动输入汇率并本地保存。
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "汇率换算"

    property real savedRate: 7.20

    function parseNum(t, fallback) {
        var n = Number(t)
        return isFinite(n) ? n : fallback
    }

    Component.onCompleted: {
        savedRate = Storage.loadNumber("currency_rate", 7.20)
        rateField.text = savedRate.toFixed(4)
    }

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        Label {
            text: "默认示例：1 美元 = 人民币汇率"
            color: "#5b667d"
            font.pixelSize: 12 * root.scaleFactor
        }

        TextField {
            id: amountField
            Layout.fillWidth: true
            placeholderText: "输入金额"
            text: "100"
            inputMethodHints: Qt.ImhFormattedNumbersOnly
        }

        TextField {
            id: rateField
            Layout.fillWidth: true
            placeholderText: "输入汇率（USD -> CNY）"
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            onEditingFinished: {
                var r = root.parseNum(text, root.savedRate)
                root.savedRate = r
                text = r.toFixed(4)
                Storage.saveNumber("currency_rate", r)
            }
        }

        ComboBox {
            id: directionBox
            Layout.fillWidth: true
            model: ["美元 -> 人民币", "人民币 -> 美元"]
        }

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 98 * root.scaleFactor

            Label {
                anchors.centerIn: parent
                text: {
                    var amount = root.parseNum(amountField.text, 0)
                    var rate = root.parseNum(rateField.text, root.savedRate)
                    var out = directionBox.currentIndex === 0 ? amount * rate : amount / Math.max(rate, 0.000001)
                    return "结果：" + out.toFixed(4)
                }
                color: "#1f2a44"
                font.pixelSize: 26 * root.scaleFactor
                font.bold: true
            }
        }
        }
    }
}
