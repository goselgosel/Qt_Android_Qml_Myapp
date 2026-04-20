import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "计时器"
    property int elapsedMs: 0

    function formatTime(ms) {
        var totalSeconds = Math.floor(ms / 1000)
        var hours = Math.floor(totalSeconds / 3600)
        var minutes = Math.floor((totalSeconds % 3600) / 60)
        var seconds = totalSeconds % 60
        var centiseconds = Math.floor((ms % 1000) / 10)
        function pad2(v) { return (v < 10 ? "0" : "") + v }
        return pad2(hours) + ":" + pad2(minutes) + ":" + pad2(seconds) + "." + pad2(centiseconds)
    }

    Timer {
        id: stopwatchTimer
        interval: 10
        running: false
        repeat: true
        onTriggered: root.elapsedMs += 10
    }

    ListModel { id: lapModel }

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        Frame {
            Layout.fillWidth: true
            Layout.preferredHeight: 128 * root.scaleFactor
            Label {
                anchors.centerIn: parent
                text: root.formatTime(root.elapsedMs)
                font.pixelSize: 34 * root.scaleFactor
                font.bold: true
                color: "#1f2a44"
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8 * root.scaleFactor

            Button {
                Layout.fillWidth: true
                text: stopwatchTimer.running ? "暂停" : "开始"
                onClicked: stopwatchTimer.running = !stopwatchTimer.running
            }

            Button {
                Layout.fillWidth: true
                text: "Lap"
                enabled: root.elapsedMs > 0
                onClicked: lapModel.insert(0, { lapText: root.formatTime(root.elapsedMs) })
            }

            Button {
                Layout.fillWidth: true
                text: "重置"
                onClicked: {
                    stopwatchTimer.running = false
                    root.elapsedMs = 0
                    lapModel.clear()
                }
            }
        }

        Label {
            text: "记录"
            color: "#1f2a44"
            font.bold: true
            font.pixelSize: 14 * root.scaleFactor
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: lapModel

            delegate: Frame {
                required property int index
                required property string lapText
                width: ListView.view.width
                padding: 8 * root.scaleFactor

                RowLayout {
                    anchors.fill: parent
                    Label { text: "第 " + (lapModel.count - index) + " 次"; color: "#5b667d" }
                    Item { Layout.fillWidth: true }
                    Label { text: lapText; color: "#1f2a44"; font.bold: true }
                }
            }

            Label {
                anchors.centerIn: parent
                visible: lapModel.count === 0
                text: "暂无记录"
                color: "#97a0b3"
            }
        }
        }
    }
}
