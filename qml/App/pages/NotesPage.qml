import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"
import "../services/Storage.js" as Storage

// 记事本页面
// 持久化方式：Storage.js -> QtQuick.LocalStorage（SQLite）
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "记事本"

    // 本地缓存文本，输入变化时节流保存，降低 SQLite 写入频率。
    property string noteText: ""

    Timer {
        id: saveDebounceTimer
        interval: 350
        repeat: false
        onTriggered: Storage.saveNotes(root.noteText)
    }

    Component.onCompleted: {
        root.noteText = Storage.loadNotes()
        memoArea.text = root.noteText
    }

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 12 * root.scaleFactor

        Label {
            text: "内容自动保存到本地 SQLite"
            font.pixelSize: 14 * root.scaleFactor
            color: "#5b667d"
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 10 * root.scaleFactor

            TextArea {
                id: memoArea
                anchors.fill: parent
                wrapMode: TextArea.Wrap
                placeholderText: "输入你的备忘内容..."
                font.pixelSize: 14 * root.scaleFactor

                onTextChanged: {
                    root.noteText = text
                    saveDebounceTimer.restart()
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "全选"
                onClicked: memoArea.selectAll()
            }

            Button {
                text: "清空"
                onClicked: {
                    memoArea.clear()
                    root.noteText = ""
                    Storage.saveNotes("")
                }
            }

            Item { Layout.fillWidth: true }

            Label {
                text: "字数：" + memoArea.length
                color: "#5b667d"
                font.pixelSize: 12 * root.scaleFactor
            }
        }
        }
    }
}
