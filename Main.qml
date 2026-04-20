import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 1.15
import QtQuick.Window 6.5
import "./qml/App/pages" as Pages

// 应用主壳：
// 1) 统一导航（StackView）
// 2) 统一返回键逻辑（安卓返回键 / 侧边返回 / ESC）
// 3) 为各页面提供 scaleFactor 做横竖屏自适应
ApplicationWindow {
    id: root

    visible: true
    width: 420
    height: 860
    title: "多功能日常工具箱"
    color: "#f5f7fb"

    // 自适应缩放：以常见手机设计稿宽 390 为基准，限制缩放范围避免过大/过小。
    readonly property real scaleFactor: Math.max(0.82, Math.min(width / 390, height / 844))
    readonly property bool isLandscape: width > height

    // 当前页面标题与头部显示控制（数字时钟页面会隐藏头部）。
    readonly property string currentPageTitle: {
        if (!stackView.currentItem || stackView.currentItem.pageTitle === undefined) {
            return "多功能日常工具箱"
        }
        return stackView.currentItem.pageTitle
    }
    readonly property bool currentPageHideHeader: !!(stackView.currentItem && stackView.currentItem.hideAppHeader === true)

    // 统一返回行为：优先回栈，栈底时退出。
    function handleBackAction() {
        if (stackView.depth > 1) {
            stackView.pop()
        } else {
            Qt.quit()
        }
    }

    // 首页工具入口分发：只维护 ID -> Component 映射。
    function openTool(toolId) {
        var component = null
        switch (toolId) {
        case "digitalClock": component = digitalClockPageComponent; break
        case "notes": component = notesPageComponent; break
        case "calculator": component = calculatorPageComponent; break
        case "stopwatch": component = stopwatchPageComponent; break
        case "countdown": component = countdownPageComponent; break
        case "todo": component = todoPageComponent; break
        case "converter": component = converterPageComponent; break
        case "tip": component = tipPageComponent; break
        case "picker": component = pickerPageComponent; break
        case "dateCalc": component = dateCalcPageComponent; break
        case "currency": component = currencyPageComponent; break
        case "quickAccess": component = quickAccessPageComponent; break
        }

        if (component !== null) {
            stackView.push(component)
        }
    }

    header: ToolBar {
        visible: !root.currentPageHideHeader
        height: 56 * root.scaleFactor
        contentHeight: height

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12 * root.scaleFactor
            anchors.rightMargin: 12 * root.scaleFactor
            spacing: 10 * root.scaleFactor

            ToolButton {
                visible: stackView.depth > 1
                enabled: visible
                text: "返回"
                onClicked: root.handleBackAction()
            }

            Label {
                Layout.fillWidth: true
                text: root.currentPageTitle
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 19 * root.scaleFactor
                font.bold: true
                color: "#1f2a44"
                elide: Text.ElideRight
            }

            Item { implicitWidth: (stackView.depth > 1 ? 56 : 1) * root.scaleFactor }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        clip: true
        initialItem: homePageComponent
    }

    Component {
        id: homePageComponent
        Pages.HomePage {
            scaleFactor: root.scaleFactor
            isLandscape: root.isLandscape
            onOpenTool: function(toolId) { root.openTool(toolId) }
        }
    }

    Component { id: digitalClockPageComponent; Pages.DigitalClockPage { scaleFactor: root.scaleFactor; appWindow: root } }
    Component { id: notesPageComponent; Pages.NotesPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: calculatorPageComponent; Pages.CalculatorPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: stopwatchPageComponent; Pages.StopwatchPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: countdownPageComponent; Pages.CountdownPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: todoPageComponent; Pages.TodoPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: converterPageComponent; Pages.ConverterPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: tipPageComponent; Pages.TipPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: pickerPageComponent; Pages.RandomPickerPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: dateCalcPageComponent; Pages.DateCalculatorPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: currencyPageComponent; Pages.CurrencyPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }
    Component { id: quickAccessPageComponent; Pages.QuickAccessPage { scaleFactor: root.scaleFactor; isLandscape: root.isLandscape } }

    // 安卓返回键/系统返回键映射。
    Shortcut {
        sequence: "Back"
        onActivated: root.handleBackAction()
    }

    // 桌面调试时使用 ESC 模拟返回键。
    Shortcut {
        sequence: "Esc"
        onActivated: root.handleBackAction()
    }

    // 某些安卓设备不会把返回动作映射成 Shortcut，而是直接分发按键事件。
    // 这里兜底捕获 Qt.Key_Back，避免导航白屏或直接退进程。
    Keys.onReleased: function(event) {
        if (event.key === Qt.Key_Back) {
            event.accepted = true
            root.handleBackAction()
        }
    }

    // 窗口关闭（含安卓手势返回触发的关闭路径）统一回栈，避免白屏/直接销毁。
    onClosing: function(close) {
        if (stackView.depth > 1) {
            close.accepted = false
            root.handleBackAction()
        }
    }
}
