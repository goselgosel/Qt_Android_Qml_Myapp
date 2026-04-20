import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "单位换算"

    readonly property var lengthUnits: [
        { label: "米", factor: 1.0 },
        { label: "千米", factor: 1000.0 },
        { label: "厘米", factor: 0.01 },
        { label: "英寸", factor: 0.0254 },
        { label: "英尺", factor: 0.3048 }
    ]

    readonly property var weightUnits: [
        { label: "千克", factor: 1.0 },
        { label: "克", factor: 0.001 },
        { label: "磅", factor: 0.45359237 },
        { label: "盎司", factor: 0.0283495231 }
    ]

    readonly property var categories: ["长度", "重量", "温度"]

    function toBase(category, value, unitIndex) {
        if (category === 0) return value * lengthUnits[unitIndex].factor
        if (category === 1) return value * weightUnits[unitIndex].factor
        if (unitIndex === 0) return value
        if (unitIndex === 1) return (value - 32) * 5 / 9
        return value + 273.15
    }

    function fromBase(category, value, unitIndex) {
        if (category === 0) return value / lengthUnits[unitIndex].factor
        if (category === 1) return value / weightUnits[unitIndex].factor
        if (unitIndex === 0) return value
        if (unitIndex === 1) return value * 9 / 5 + 32
        return value - 273.15
    }

    function activeUnits(category) {
        if (category === 0) return lengthUnits
        if (category === 1) return weightUnits
        return [
            { label: "摄氏", factor: 1.0 },
            { label: "华氏", factor: 1.0 },
            { label: "开氏", factor: 1.0 }
        ]
    }

    function resultText() {
        var inputValue = Number(inputField.text)
        if (!isFinite(inputValue)) return "请输入有效数字"
        var cat = categoryBox.currentIndex
        var base = toBase(cat, inputValue, fromUnitBox.currentIndex)
        var converted = fromBase(cat, base, toUnitBox.currentIndex)
        return converted.toFixed(6)
    }

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        ComboBox {
            id: categoryBox
            Layout.fillWidth: true
            model: root.categories
            onCurrentIndexChanged: {
                var labels = root.activeUnits(currentIndex).map(function(u) { return u.label })
                fromUnitBox.model = labels
                toUnitBox.model = labels
                fromUnitBox.currentIndex = 0
                toUnitBox.currentIndex = Math.min(1, toUnitBox.count - 1)
            }
            Component.onCompleted: currentIndexChanged()
        }

        TextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: "输入数值"
            text: "1"
            inputMethodHints: Qt.ImhFormattedNumbersOnly
        }

        RowLayout {
            Layout.fillWidth: true
            ComboBox { id: fromUnitBox; Layout.fillWidth: true }
            ComboBox { id: toUnitBox; Layout.fillWidth: true }
        }

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 92 * root.scaleFactor
            Column {
                anchors.centerIn: parent
                spacing: 4
                Label { text: "换算结果"; color: "#5b667d"; anchors.horizontalCenter: parent.horizontalCenter }
                Label {
                    text: root.resultText()
                    font.pixelSize: 28 * root.scaleFactor
                    font.bold: true
                    color: "#1f2a44"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        }
    }
}
