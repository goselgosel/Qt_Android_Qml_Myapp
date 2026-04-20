import QtQuick 6.5

// 自适应页面容器：
// 1) 在竖屏下保持手机常规边距。
// 2) 在横屏/平板下限制最大内容宽度并居中，避免控件被拉得过宽。
// 3) 通过 default property 透传子组件，页面内只需要专注业务布局。
Item {
    id: root

    property bool isLandscape: false
    property real scaleFactor: 1.0

    // 这两个值按「设计稿逻辑像素」定义，最终会乘以 scaleFactor。
    property real portraitMaxWidth: 560
    property real landscapeMaxWidth: 980

    default property alias contentData: contentItem.data

    readonly property real horizontalPadding: 16 * scaleFactor
    readonly property real availableWidth: Math.max(0, width - horizontalPadding * 2)
    readonly property real maxContentWidth: (isLandscape ? landscapeMaxWidth : portraitMaxWidth) * scaleFactor
    readonly property real contentWidth: Math.min(availableWidth, maxContentWidth)

    Item {
        id: contentItem
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.contentWidth
    }
}
