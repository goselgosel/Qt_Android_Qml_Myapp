import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

// 日期计算页：计算两个日期之间的天数差。
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "日期计算"

    function parseDate(text) {
        var m = text.match(/^(\d{4})-(\d{2})-(\d{2})$/)
        if (!m) return null
        var y = Number(m[1])
        var mo = Number(m[2]) - 1
        var d = Number(m[3])
        var dt = new Date(y, mo, d)
        if (dt.getFullYear() !== y || dt.getMonth() !== mo || dt.getDate() !== d) {
            return null
        }
        return dt
    }

    function resultText() {
        var a = parseDate(startField.text)
        var b = parseDate(endField.text)
        if (!a || !b) return "请输入合法日期（YYYY-MM-DD）"
        var diffMs = Math.abs(b.getTime() - a.getTime())
        var days = Math.floor(diffMs / 86400000)
        return "相差 " + days + " 天（约 " + (days / 7).toFixed(2) + " 周）"
    }

    function setToday() {
        var now = new Date()
        function pad2(v) { return (v < 10 ? "0" : "") + v }
        var s = now.getFullYear() + "-" + pad2(now.getMonth() + 1) + "-" + pad2(now.getDate())
        startField.text = s
        endField.text = s
    }

    Component.onCompleted: setToday()

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        TextField {
            id: startField
            Layout.fillWidth: true
            placeholderText: "开始日期 YYYY-MM-DD"
        }

        TextField {
            id: endField
            Layout.fillWidth: true
            placeholderText: "结束日期 YYYY-MM-DD"
        }

        RowLayout {
            Layout.fillWidth: true
            Button { text: "今天"; onClicked: root.setToday() }
            Button {
                text: "互换"
                onClicked: {
                    var t = startField.text
                    startField.text = endField.text
                    endField.text = t
                }
            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 92 * root.scaleFactor
            Label {
                anchors.centerIn: parent
                text: root.resultText()
                color: "#1f2a44"
                font.pixelSize: 20 * root.scaleFactor
                font.bold: true
                wrapMode: Text.WordWrap
            }
        }
        }
    }
}
