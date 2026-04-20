import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import "../components"

// 快捷功能页面
// 注意：手电筒和扫码涉及设备硬件与权限，当前先提供 UI 入口与说明。
Item {
    id: root

    property real scaleFactor: 1.0
    property bool isLandscape: false
    property string pageTitle: "快捷功能"

    Dialog {
        id: infoDialog
        modal: true
        title: "功能说明"
        standardButtons: Dialog.Ok

        property string messageText: ""

        Label {
            anchors.margins: 12
            text: infoDialog.messageText
            wrapMode: Text.WordWrap
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
            Layout.preferredHeight: 90 * root.scaleFactor
            Label {
                anchors.centerIn: parent
                text: "这里放常用硬件入口（占位版）"
                color: "#1f2a44"
                font.bold: true
            }
        }

        Button {
            Layout.fillWidth: true
            text: "手电筒（占位）"
            onClicked: {
                infoDialog.messageText = "手电筒需要调用 Android Camera/Flash API 和权限，后续可通过 C++ + JNI 接入。"
                infoDialog.open()
            }
        }

        Button {
            Layout.fillWidth: true
            text: "二维码扫描（占位）"
            onClicked: {
                infoDialog.messageText = "二维码扫描需要相机预览与解码库（如 ZXing），后续可扩展。"
                infoDialog.open()
            }
        }

        Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: "当前先提供稳定的页面入口，保证主流程可用。你后续需要时，我可以继续把手电筒和扫码做成真实功能。"
            color: "#5b667d"
            font.pixelSize: 12 * root.scaleFactor
        }
        }
    }
}
