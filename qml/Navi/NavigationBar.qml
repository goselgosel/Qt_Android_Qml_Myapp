
import QtQuick 6.5
import QtQuick.Controls 6.5
// NavigationBar.qml
// 导入必要的模块

import QtQuick.Layouts

// Rectangle: 矩形组件，作为导航栏的容器
Rectangle {
    id: navBar          // 组件ID
    color: "#ffffff"    // 导航栏背景色（白色）

    /**************************************************************
     * 自定义属性
     **************************************************************/
    // property: 定义组件的可配置属性

    // currentIndex: 当前选中的导航项索引
    // 默认值为0（第一个导航项）
    property int currentIndex: 0

    // signal: 定义组件可以发出的信号
    // itemClicked: 当导航项被点击时发出的信号
    // 参数：被点击的导航项索引
    signal itemClicked(int index)

    /**************************************************************
     * 导航栏顶部边框
     **************************************************************/
    Rectangle {
        width: parent.width    // 宽度等于导航栏宽度
        height: 1              // 高度1像素（细线）
        color: "#e0e0e0"       // 浅灰色边框
        anchors.top: parent.top // 锚定在导航栏顶部
    }

    /**************************************************************
     * 导航项容器布局
     **************************************************************/
    // RowLayout: 水平布局容器
    // 功能：将子项水平排列，并自动分配空间
    RowLayout {
        anchors.fill: parent  // 填充整个导航栏
        spacing: 0           // 子项之间的间距为0

        /**************************************************************
         * 导航项1：微信
         **************************************************************/
        NavItem {  // 引用自定义组件 NavItem
            // Layout.fillWidth: 在水平布局中填满可用宽度
            Layout.fillWidth: true

            // Layout.fillHeight: 在垂直方向填满可用高度
            Layout.fillHeight: true

            iconText: "💬"      // 图标表情符号
            label: "微信"       // 标签文本
            isActive: navBar.currentIndex === 0  // 是否激活（选中）

            // onClicked: 处理导航项点击事件
            onClicked: {
                // 更新导航栏的当前索引
                navBar.currentIndex = 0

                // 发出itemClicked信号，传递索引0
                navBar.itemClicked(0)
            }
        }

        /**************************************************************
         * 导航项2：通讯录
         **************************************************************/
        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "👥"      // 人群图标
            label: "通讯录"
            isActive: navBar.currentIndex === 1

            onClicked: {
                navBar.currentIndex = 1
                navBar.itemClicked(1)
            }
        }

        /**************************************************************
         * 导航项3：发现
         **************************************************************/
        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "🔍"      // 搜索图标
            label: "发现"
            isActive: navBar.currentIndex === 2

            onClicked: {
                navBar.currentIndex = 2
                navBar.itemClicked(2)
            }
        }

        /**************************************************************
         * 导航项4：我
         **************************************************************/
        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "👤"      // 人物图标
            label: "我"
            isActive: navBar.currentIndex === 3

            onClicked: {
                navBar.currentIndex = 3
                navBar.itemClicked(3)
            }
        }
    }
}
