// main.qml
import QtQuick 6.5
import QtQuick.Window 6.5
import QtQuick.Layouts 1.15
import QtQuick.Controls // 控件模块
import "./qml/Navi"
import "./qml/DigitalFlipClock"
//import Navis 1.0

// ApplicationWindow: 应用程序主窗口
Window {
	id: root          // 为窗口设置ID，便于在其他地方引用
	visible: true       // 设置窗口可见
	width: 540          // 窗口宽度
	height: 960         // 窗口高度
	title: "小软件哈哈"  // 窗口标题
	color: "#f0f0f0"    // 窗口背景色（微信背景色）
	//flags: Qt.Window | Qt.FramelessWindowHint
	StackView {
		id: mainStack
		anchors.fill: parent
		initialItem: swipeViewContainer  // 初始显示 SwipeView
		//opacity: 0.5
	}

	Component {
		id: swipeViewContainer
		Item {
			id: swipeViewPage
			anchors.fill: parent
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

				HomePage {  // Item是最基础的容器组件

				}


				Page2 {

				}

				Page3 {

				}

				Page4 {


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
	}
	Component{
		id:digitalPage
		Item {
			id: digitalwin
			DigitalFlipClock{

			}
		}
	}
}
