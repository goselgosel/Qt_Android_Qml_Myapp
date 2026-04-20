import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"
import "../services/Storage.js" as Storage

// 待办页面
// 以 JSON 数组形式写入 SQLite，兼容后续字段扩展。
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "待办清单"

    ListModel { id: todoModel }

    function saveAllToLocal() {
        var arr = []
        for (var i = 0; i < todoModel.count; ++i) {
            var row = todoModel.get(i)
            arr.push({ task: row.task, done: row.done })
        }
        Storage.saveTodoList(arr)
    }

    function loadFromLocal() {
        todoModel.clear()
        var arr = Storage.loadTodoList()
        for (var i = 0; i < arr.length; ++i) {
            todoModel.append({ task: arr[i].task, done: !!arr[i].done })
        }
    }

    function addTodo(text) {
        var t = text.trim()
        if (t.length === 0) return
        todoModel.append({ task: t, done: false })
        saveAllToLocal()
    }

    function remainingCount() {
        var n = 0
        for (var i = 0; i < todoModel.count; ++i) {
            if (!todoModel.get(i).done) n++
        }
        return n
    }

    Component.onCompleted: loadFromLocal()

    ResponsivePage {
        anchors.fill: parent
        isLandscape: root.isLandscape
        scaleFactor: root.scaleFactor

        ColumnLayout {
            anchors.fill: parent
            spacing: 10 * root.scaleFactor

        RowLayout {
            Layout.fillWidth: true
            spacing: 8 * root.scaleFactor

            TextField {
                id: inputField
                Layout.fillWidth: true
                placeholderText: "新增任务"
                onAccepted: {
                    root.addTodo(text)
                    text = ""
                }
            }

            Button {
                text: "添加"
                onClicked: {
                    root.addTodo(inputField.text)
                    inputField.text = ""
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Label {
                text: "剩余未完成：" + root.remainingCount()
                color: "#1f2a44"
                font.bold: true
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "清理已完成"
                onClicked: {
                    for (var i = todoModel.count - 1; i >= 0; --i) {
                        if (todoModel.get(i).done) {
                            todoModel.remove(i)
                        }
                    }
                    root.saveAllToLocal()
                }
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 8 * root.scaleFactor
            model: todoModel

            delegate: Frame {
                required property int index
                required property string task
                required property bool done

                width: ListView.view.width
                padding: 8 * root.scaleFactor

                RowLayout {
                    anchors.fill: parent

                    CheckBox {
                        checked: done
                        onToggled: {
                            todoModel.setProperty(index, "done", checked)
                            root.saveAllToLocal()
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        text: task
                        wrapMode: Text.WordWrap
                        color: done ? "#8f96a8" : "#1f2a44"
                        font.strikeout: done
                    }

                    Button {
                        text: "删除"
                        onClicked: {
                            todoModel.remove(index)
                            root.saveAllToLocal()
                        }
                    }
                }
            }

            Label {
                anchors.centerIn: parent
                visible: todoModel.count === 0
                text: "暂无待办事项"
                color: "#97a0b3"
            }
        }
        }
    }
}
