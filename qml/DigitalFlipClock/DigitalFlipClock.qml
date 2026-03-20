import QtQuick
import QtQuick.Controls
import "./Components"

Window {
    id: digitalWindow

    visible: true
    width: 800
    height: 480
    //title: "Digital Flip Clock"
    //icon.source:"../android/res/drawable/icon.png"
    //color: "#FFFFFF"

    // 强制横屏
    minimumWidth: 800
    minimumHeight: 480
    maximumWidth: 800
    maximumHeight: 480

    // === 关键：设置窗口属性 ===
    flags: Qt.Window | Qt.FramelessWindowHint
    visibility: "FullScreen"    //全屏操作添加不要求applicationwindow，window也可以
    //记录全屏操作，Androidmanifest.xml添加android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
    //测试了android……xml文件配置内的上面的代码删除后依旧全屏

    // === 全局背景图片配置 ===
    // 可切换的背景图片数组
    property var backgroundImages: [
        "qrc:/resources/images/kafei.png",  // 纯黑
        "qrc:/resources/images/hmbb.png",  // 深蓝星空
        "qrc:/resources/images/kuaile.png",  // 渐变
        "qrc:/resources/images/renmb.png",  // 纹理
        "qrc:/resources/images/senlin.png"   // 图案
    ]

    // 当前背景索引
    property int currentBackgroundIndex: 0

    // 当前背景图片路径
    property string currentBackgroundImage: backgroundImages[currentBackgroundIndex]

    // === 方案1A：使用资源中的图片 ===
    // 将图片放在项目的 resources/images/ 目录下
    // 在 CMakeLists.txt 中添加资源文件
    // 然后通过 qrc:/ 路径访问
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: currentBackgroundImage  // 资源路径

        // 图片填充模式
        fillMode: Image.PreserveAspectCrop  // 保持比例并裁剪
        // fillMode: Image.Stretch  // 拉伸填充
        // fillMode: Image.PreserveAspectFit  // 保持比例适应

        // 可选：添加模糊效果
        // layer.enabled: true
        // layer.effect: FastBlur { radius: 8 }
    }

    SwipeView {
        id:digitalSwip
        anchors.fill: parent    // 填充整个父窗口

        // currentIndex: 当前显示的页面索引
        // 绑定到导航栏的currentIndex，实现双向同步
        //currentIndex: 1 // 改为 0 看第一页，1 看第二页，以此类推
        currentIndex: 0

        // interactive: 是否允许用户交互滑动
        // true = 允许手指左右滑动切换
        interactive: true
        Item {
            id: digital_Swip_page_one
            //anchors.fill: parent

            // === 时间显示组件 ===
            // 修改这里的尺寸设置
            TimeDisplay {
                id: timeDisplay
                anchors.centerIn: parent

                // === 在这里调整整体尺寸 ===
                // 时间单位组件尺寸
                unitWidth: 170     // 时间单位宽度（包含两个数字）
                unitHeight: 270    // 时间单位高度

                // 冒号尺寸
                colonWidth: 30     // 冒号占用宽度

                // 组件间距
                spacing: 10        // 时、分、秒之间的间距

                // 注释：以上参数可以根据需要调整
                // 增加 unitWidth/unitHeight 可以增大底框和数字
                // 减小 colonWidth 可以减少冒号占用位置
                // 减小 spacing 可以减少时分秒之间的间距
            }

            // 应用信息
            Text {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: 20
                }
                text: "Digital Flip Clock"
                color: "#999999"
                font.pixelSize: 16
                font.family: "Arial"
            }
        }

        Item {
            id: digital_Swip_page_two
            // 关键：显式绑定到 SwipeView
            width: swipeView.width
            height: swipeView.height
            TimeSetPage {

            }
        }

    }

}
