import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: root
    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "小费平摊"

    function parseNumber(text, fallback) {
        var n = Number(text)
        return isFinite(n) ? n : fallback
    }

    readonly property real billValue: parseNumber(billField.text, 0)
    readonly property real tipPercent: tipSlider.value
    readonly property int peopleCount: Math.max(1, splitBox.value)
    readonly property real tipValue: billValue * tipPercent / 100
    readonly property real totalValue: billValue + tipValue
    readonly property real perPersonValue: totalValue / peopleCount

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        TextField {
            id: billField
            Layout.fillWidth: true
            placeholderText: "账单金额"
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            text: "0"
        }

        Label { text: "小费比例：" + Math.round(root.tipPercent) + "%"; color: "#1f2a44"; font.bold: true }
        Slider { id: tipSlider; Layout.fillWidth: true; from: 0; to: 30; value: 15 }

        RowLayout {
            Label { text: "人数"; color: "#1f2a44" }
            SpinBox { id: splitBox; from: 1; to: 20; value: 1 }
        }

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 150 * root.scaleFactor
            Column {
                anchors.centerIn: parent
                spacing: 6 * root.scaleFactor
                Label { text: "小费：" + root.tipValue.toFixed(2); color: "#1f2a44" }
                Label { text: "总计：" + root.totalValue.toFixed(2); color: "#1f2a44" }
                Label {
                    text: "人均：" + root.perPersonValue.toFixed(2)
                    color: "#2a7d5d"
                    font.pixelSize: 24 * root.scaleFactor
                    font.bold: true
                }
            }
        }
        }
    }
}
