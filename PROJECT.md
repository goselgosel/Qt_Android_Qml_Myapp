# 多功能日常工具箱（Qt 6.8.3 / Android 优先）

## 1. 项目目标
这是一个面向手机端的 Qt/QML 工具型 App，核心目标：
- 横竖屏自适应（尤其是手机横屏可用性）。
- 常用小工具集中管理（记事本、计算器、计时器、倒计时等）。
- 安卓返回键行为稳定，不出现白屏卡死。
- 本地离线持久化，保证重启后数据还在。

## 2. 当前已集成功能
- 数字时钟（进入页面后全屏无边框，横屏显示）
- 记事本（自动保存）
- 待办清单（增删改查 + 完成状态）
- 计算器
- 计时器（含 Lap）
- 倒计时
- 单位换算（长度/重量/温度）
- 汇率换算（手动汇率 + 本地保存）
- 小费平摊
- 随机选择
- 日期计算
- 快捷功能占位页（手电筒/扫码扩展入口）

## 3. 本地持久化说明（你问的数据库）
是的，使用的是 **SQLite**。
- QML 侧使用 `QtQuick.LocalStorage`。
- `QtQuick.LocalStorage` 底层就是 SQLite。
- 项目在 `qml/App/services/Storage.js` 做了统一封装，页面只调用 `load/save`。
- 当前采用 KV 表（`kv_store`），用于轻量数据保存（文本、JSON、数字字符串）。

## 4. 目录结构（已优化）
```text
qml/
  App/
    components/
      ToolCard.qml
      ResponsivePage.qml
    pages/
      HomePage.qml
      DigitalClockPage.qml
      NotesPage.qml
      TodoPage.qml
      CalculatorPage.qml
      StopwatchPage.qml
      CountdownPage.qml
      ConverterPage.qml
      CurrencyPage.qml
      TipPage.qml
      RandomPickerPage.qml
      DateCalculatorPage.qml
      QuickAccessPage.qml
    services/
      Storage.js
Main.qml
main.cpp
CMakeLists.txt
CMakePresets.json
.vscode/smoke-test.ps1
```

## 5. 导航与返回键策略
- 使用 `ApplicationWindow + StackView` 统一导航。
- 返回逻辑：
  - 栈深度 > 1：`pop()` 返回上一级。
  - 栈底：退出应用。
- 同时处理三种返回来源：
  - `Shortcut("Back")`
  - `Keys.onReleased` 捕获 `Qt.Key_Back`
  - `onClosing` 兜底（安卓手势返回触发关闭路径时拦截）

## 6. 数字时钟页面策略
`DigitalClockPage.qml` 在进入时：
- 隐藏主头部
- 设置窗口 `FramelessWindowHint`
- 设置 `FullScreen`
- 设置 `contentOrientation = Qt.LandscapeOrientation`

退出时会恢复进入前窗口状态，避免影响其它页面。

## 7. 横竖屏适配策略
- 全局：`Main.qml` 提供 `scaleFactor` 和 `isLandscape`。
- 页面：统一接收这两个属性。
- 新增 `ResponsivePage.qml`：
  - 竖屏保持手机边距；
  - 横屏时限制最大内容宽度并居中，避免布局过分拉伸。

## 8. 构建与验证（VSCode）
### 8.1 配置
```powershell
cmake --preset desktop-mingw-debug
```

### 8.2 编译
```powershell
cmake --build --preset desktop-mingw-debug --parallel
```

### 8.3 冒烟验证（无界面）
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .vscode/smoke-test.ps1
```

期望输出：`smoke-ok`

## 9. 与 QtCreator 并行使用建议
- 不改 QtCreator 默认生成逻辑，只在工程内补充 QML 结构和 CMake 文件清单。
- 使用 `CMakePresets.json` 统一 VSCode 构建入口，避免改动 QtCreator Kit。
- QtCreator 继续用你原来的 Android Kit；VSCode 主要用于改代码与桌面快速验证。

## 10. 下次新建同类工程可复用步骤
1. QtCreator 新建 Qt Quick 工程（先保证原生可运行）。
2. 复制这套目录骨架：`qml/App/components|pages|services`。
3. 在 `CMakeLists.txt` 的 `qt_add_qml_module` 中注册新增 QML 文件。
4. `Main.qml` 使用 `ApplicationWindow + StackView`，统一返回逻辑。
5. 数据持久化统一走 `Storage.js`，不要在页面散写 SQL。
6. 在 VSCode 执行配置/编译/smoke 三步，确认通过后再做新功能。
