import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

// 计算器页面（中文）
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "计算器"
    property string expression: ""

    function appendToken(token) {
        if (expression === "错误") expression = ""
        expression += token
    }

    function clearOne() {
        if (expression.length > 0) expression = expression.substring(0, expression.length - 1)
    }

    function clearAll() {
        expression = ""
    }

    function evaluateExpression() {
        if (expression.length === 0) return
        try {
            var sanitized = expression.replace(/×/g, "*").replace(/÷/g, "/")
            if (!/^[0-9+\-*/().% ]+$/.test(sanitized)) throw new Error("invalid")
            var result = Function("\"use strict\"; return (" + sanitized + ");")()
            if (!isFinite(result)) throw new Error("invalid")
            expression = String(result)
        } catch (e) {
            expression = "错误"
        }
    }

    readonly property var keys: [
        "清空", "(", ")", "退格",
        "7", "8", "9", "÷",
        "4", "5", "6", "×",
        "1", "2", "3", "-",
        "0", ".", "%", "+",
        "=", "=", "=", "="
    ]

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 108 * root.scaleFactor

            Label {
                anchors.fill: parent
                anchors.margins: 14 * root.scaleFactor
                text: root.expression.length > 0 ? root.expression : "0"
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 32 * root.scaleFactor
                color: root.expression === "错误" ? "#cf3f5a" : "#1f2a44"
                elide: Text.ElideLeft
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: root.isLandscape ? 6 : 4
            rowSpacing: 8 * root.scaleFactor
            columnSpacing: 8 * root.scaleFactor

            Repeater {
                model: root.keys

                Button {
                    required property var modelData

                    readonly property string keyText: modelData
                    text: keyText
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 52 * root.scaleFactor

                    onClicked: {
                        if (keyText === "清空") root.clearAll()
                        else if (keyText === "退格") root.clearOne()
                        else if (keyText === "=") root.evaluateExpression()
                        else root.appendToken(keyText)
                    }
                }
            }
        }
        }
    }
}
