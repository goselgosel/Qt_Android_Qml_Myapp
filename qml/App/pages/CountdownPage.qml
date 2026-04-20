import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "倒计时"
    property int remainingSeconds: 0
    property int initialSeconds: 0

    function toSeconds() {
        return hourBox.value * 3600 + minuteBox.value * 60 + secondBox.value
    }

    function formatTime(sec) {
        var s = Math.max(0, sec)
        var h = Math.floor(s / 3600)
        var m = Math.floor((s % 3600) / 60)
        var r = s % 60
        function pad2(v) { return (v < 10 ? "0" : "") + v }
        return pad2(h) + ":" + pad2(m) + ":" + pad2(r)
    }

    Timer {
        id: countdownTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if (root.remainingSeconds > 0) root.remainingSeconds -= 1
            if (root.remainingSeconds <= 0) {
                running = false
                doneDialog.open()
            }
        }
    }

    Dialog {
        id: doneDialog
        title: "倒计时结束"
        modal: true
        standardButtons: Dialog.Ok
        Label {
            anchors.margins: 10
            text: "时间到。"
        }
    }

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
                anchors.centerIn: parent
                text: root.formatTime(root.remainingSeconds)
                font.pixelSize: 34 * root.scaleFactor
                color: "#1f2a44"
                font.bold: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            SpinBox { id: hourBox; from: 0; to: 23; editable: true; Layout.fillWidth: true }
            SpinBox { id: minuteBox; from: 0; to: 59; editable: true; Layout.fillWidth: true }
            SpinBox { id: secondBox; from: 0; to: 59; editable: true; Layout.fillWidth: true }
        }

        Label {
            text: "小时 / 分钟 / 秒"
            color: "#5b667d"
            font.pixelSize: 12 * root.scaleFactor
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8 * root.scaleFactor

            Button {
                Layout.fillWidth: true
                text: countdownTimer.running ? "暂停" : "开始"
                onClicked: {
                    if (!countdownTimer.running && root.remainingSeconds === 0) {
                        root.initialSeconds = root.toSeconds()
                        root.remainingSeconds = root.initialSeconds
                    }
                    if (root.remainingSeconds > 0) countdownTimer.running = !countdownTimer.running
                }
            }

            Button {
                Layout.fillWidth: true
                text: "重置"
                onClicked: {
                    countdownTimer.running = false
                    root.remainingSeconds = root.toSeconds()
                    root.initialSeconds = root.remainingSeconds
                }
            }
        }

        ProgressBar {
            Layout.fillWidth: true
            from: 0
            to: root.initialSeconds > 0 ? root.initialSeconds : 1
            value: root.remainingSeconds
        }
        }
    }
}
