// main.qml
import QtQuick 6.5
import QtQuick.Window 6.5
import QtQuick.Layouts 1.15
import QtQuick.Controls // 鎺т欢妯″潡
import "./qml/Navi"
import "./qml/DigitalFlipClock"
//import Navis 1.0

// ApplicationWindow: 搴旂敤绋嬪簭涓荤獥鍙?
Window {
	id: root          // 涓虹獥鍙ｈ缃甀D锛屼究浜庡湪鍏朵粬鍦版柟寮曠敤
	visible: true       // 璁剧疆绐楀彛鍙
	width: 540          // 绐楀彛瀹藉害
	height: 960         // 绐楀彛楂樺害
    title: "My App"    // 绐楀彛鏍囬
	color: "#f0f0f0"    // 绐楀彛鑳屾櫙鑹诧紙寰俊鑳屾櫙鑹诧級
	//flags: Qt.Window | Qt.FramelessWindowHint
	StackView {
		id: mainStack
		anchors.fill: parent
		initialItem: swipeViewContainer  // 鍒濆鏄剧ず SwipeView
		//opacity: 0.5
	}

	Component {
		id: swipeViewContainer
		Item {
			id: swipeViewPage
			anchors.fill: parent
			// SwipeView: 鍙乏鍙虫粦鍔ㄧ殑椤甸潰瀹瑰櫒
			// 鍔熻兘锛氬疄鐜扮被浼糣iewPager鐨勫乏鍙虫粦鍔ㄥ垏鎹㈡晥鏋?
			SwipeView {
				id: swipeView           // ID锛岀敤浜庡湪鍏朵粬鍦版柟寮曠敤
				anchors.fill: parent    // 濉厖鏁翠釜鐖剁獥鍙?

				// currentIndex: 褰撳墠鏄剧ず鐨勯〉闈㈢储寮?
				// 缁戝畾鍒板鑸爮鐨刢urrentIndex锛屽疄鐜板弻鍚戝悓姝?
				//currentIndex: 1 // 鏀逛负 0 鐪嬬涓€椤碉紝1 鐪嬬浜岄〉锛屼互姝ょ被鎺?
				currentIndex: navBar.currentIndex

				// interactive: 鏄惁鍏佽鐢ㄦ埛浜や簰婊戝姩
				// true = 鍏佽鎵嬫寚宸﹀彸婊戝姩鍒囨崲
				interactive: true

				HomePage {  // Item鏄渶鍩虹鐨勫鍣ㄧ粍浠?

				}


				Page2 {

				}

				Page3 {

				}

				Page4 {


				}
			}

			/**************************************************************
				 * 搴曢儴瀵艰埅鏍?
				 **************************************************************/
			// 寮曠敤鑷畾涔夌粍浠?NavigationBar
			NavigationBar {
				id: navBar           // 缁勪欢ID
				anchors.bottom: parent.bottom  // 閿氬畾鍦ㄧ埗绐楀彛搴曢儴
				width: parent.width            // 瀹藉害绛変簬鐖剁獥鍙ｅ搴?
				height: 60                     // 瀵艰埅鏍忛珮搴?

				// onItemClicked: 澶勭悊瀵艰埅椤圭偣鍑讳簨浠剁殑淇″彿澶勭悊鍣?
				// 褰撶敤鎴峰湪瀵艰埅鏍忕偣鍑绘煇涓」鐩椂瑙﹀彂
				onItemClicked: function(index) {
					// 鍒囨崲SwipeView鍒板搴旂殑椤甸潰
					swipeView.currentIndex = index
				}
			}

			/**************************************************************
				 * 杩炴帴鍣細鍚屾婊戝姩鍜岀偣鍑荤殑鐘舵€?
				 **************************************************************/
			Connections {
				// target: 鎸囧畾瑕佺洃鍚殑瀵硅薄
				target: swipeView

				// 鐩戝惉SwipeView鐨刢urrentIndexChanged淇″彿
				// 褰撶敤鎴峰乏鍙虫粦鍔ㄩ〉闈㈡椂瑙﹀彂
				function onCurrentIndexChanged() {
					// 鏇存柊瀵艰埅鏍忕殑閫変腑鐘舵€?
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
