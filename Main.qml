// main.qml
import QtQuick 6.5
import QtQuick.Window 6.5
import "./ButtonComponents"   // 导入自定义按钮模块
import QtQuick.Layouts 1.15
// main.qml
// 导入必要的模块
import "./Navi"
import QtQuick.Controls // 控件模块


// ApplicationWindow: 应用程序主窗口
Window {
    id: root          // 为窗口设置ID，便于在其他地方引用
    visible: true       // 设置窗口可见
    width: 400          // 窗口宽度
    height: 700         // 窗口高度
    title: "微信式导航"  // 窗口标题
    color: "#f0f0f0"    // 窗口背景色（微信背景色）

    // SwipeView: 可左右滑动的页面容器
    // 功能：实现类似ViewPager的左右滑动切换效果
    SwipeView {
        id: swipeView           // ID，用于在其他地方引用
        anchors.fill: parent    // 填充整个父窗口

        // currentIndex: 当前显示的页面索引
        // 绑定到导航栏的currentIndex，实现双向同步
        //currentIndex: 1 // 改为 0 看第一页，1 看第二页，以此类推
        currentIndex: navBar.currentIndex

        // interactive: 是否允许用户交互滑动
        // true = 允许手指左右滑动切换
        interactive: true

        /**************************************************************
         * 页面1：微信页面
         **************************************************************/
        Item {  // Item是最基础的容器组件
            id: page1  // 页面ID

            // Rectangle: 矩形背景
            Rectangle {
                anchors.fill: parent  // 填充整个页面
                color: "#ffffff"      // 白色背景
            }

            // Text: 显示文本
            Text {
                text: "微信页面"       // 文本内容
                font.pixelSize: 24    // 字体大小
                color: "#07C160"      // 微信绿色
                anchors.centerIn: parent  // 居中显示
            }
            FlatButton {
                text: "FlatButton按钮测试"
                anchors.centerIn: parent
            }
        }

        /**************************************************************
         * 页面2：通讯录页面
         **************************************************************/
        Item {
            id: page2
            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
            }

            Text {
                text: "通讯录页面"
                font.pixelSize: 24
                color: "#07C160"
                anchors.centerIn: parent
            }
            MaterialButton {
                text: "MaterialButton按钮"
                anchors.centerIn: parent
            }
        }

        /**************************************************************
         * 页面3：发现页面
         **************************************************************/
        Item {
            id: page3
            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
            }

            Text {
                text: "发现页面"
                font.pixelSize: 24
                color: "#07C160"
                anchors.centerIn: parent
            }
        }

        /**************************************************************
         * 页面4：我页面
         **************************************************************/
        Item {
            id: page4
            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                // Material 风格按钮
                MaterialButton {
                    text: "Material 按钮"
                    primaryColor: "#e74c3c"
                    hoverColor: "#c0392b"
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: console.log("Material 按钮被点击")
                }

                // 扁平化按钮
                FlatButton {
                    text: "扁平化按钮"
                    baseColor: "#2ecc71"
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: console.log("扁平按钮被点击")
                }

                // 3D 按钮
                ThreeDButton {
                    text: "3D 按钮"
                    topColor: "#9b59b6"
                    sideColor: "#8e44ad"
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: console.log("3D 按钮被点击")
                }

                // 图标按钮
                IconButton {
                    iconSource: "qrc:/icons/heart.svg"
                    color: "#e74c3c"
                    size: 60
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: console.log("图标按钮被点击")
                }
                Text {
                    text: "我页面"
                    font.pixelSize: 24
                    color: "#07C160"
                    //anchors.centerIn: parent
                }
            }

        }
    }

    /**************************************************************
     * 底部导航栏
     **************************************************************/
    // 引用自定义组件 NavigationBar
    NavigationBar {
        id: navBar           // 组件ID
        anchors.bottom: parent.bottom  // 锚定在父窗口底部
        width: parent.width            // 宽度等于父窗口宽度
        height: 60                     // 导航栏高度

        // onItemClicked: 处理导航项点击事件的信号处理器
        // 当用户在导航栏点击某个项目时触发
        onItemClicked: function(index) {
            // 切换SwipeView到对应的页面
            swipeView.currentIndex = index
        }
    }

    /**************************************************************
     * 连接器：同步滑动和点击的状态
     **************************************************************/
    Connections {
        // target: 指定要监听的对象
        target: swipeView

        // 监听SwipeView的currentIndexChanged信号
        // 当用户左右滑动页面时触发
        function onCurrentIndexChanged() {
            // 更新导航栏的选中状态
            navBar.currentIndex = swipeView.currentIndex
        }
    }
}
