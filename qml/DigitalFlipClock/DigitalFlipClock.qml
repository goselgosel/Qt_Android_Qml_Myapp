import QtQuick
import QtQuick.Controls
import "./Components"

Window {
    id: rootWindow

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

    // === 方案1A：使用资源中的图片 ===
    // 将图片放在项目的 resources/images/ 目录下
    // 在 CMakeLists.txt 中添加资源文件
    // 然后通过 qrc:/ 路径访问
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/resources/images/kafei.png"  // 资源路径

        // 图片填充模式
        fillMode: Image.PreserveAspectCrop  // 保持比例并裁剪
        // fillMode: Image.Stretch  // 拉伸填充
        // fillMode: Image.PreserveAspectFit  // 保持比例适应

        // 可选：添加模糊效果
        // layer.enabled: true
        // layer.effect: FastBlur { radius: 8 }
    }

    Item {
        id: mainContainer
        anchors.fill: parent

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


}
