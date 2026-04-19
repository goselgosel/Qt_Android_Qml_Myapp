cmake_minimum_required(VERSION 3.16)

project(myapp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(myapp
    main.cpp

)

# 在 qt_add_qml_module 之前添加
qt_add_resources(myapp "app_images"
    PREFIX "/"
    FILES
        resources/images/kafei.png
        resources/images/facai.png
        resources/images/hmbb.png
        resources/images/kuaile.png
        resources/images/renmb.png
        resources/images/senlin.png
)

qt_add_qml_module(myapp
    URI myapp
    VERSION 1.0
    QML_FILES
        Main.qml
        # 添加子目录作为子模块
    IMPORT_PATH
        ${CMAKE_CURRENT_SOURCE_DIR}/qml/*
    RESOURCES
        RESOURCES .gitignore
        QML_FILES qml/DigitalFlipClock/DigitalFlipClock.qml
        RESOURCES qml/DigitalFlipClock/Components/qmldir
        QML_FILES qml/DigitalFlipClock/Components/TimeDisplay.qml qml/DigitalFlipClock/Components/TimeUnit.qml
RESOURCES qml/ComboBox/qmldir
QML_FILES qml/DigitalFlipClock/Components/TimeSetPage.qml
RESOURCES qml/ButtonComponents/qmldir
QML_FILES qml/ButtonComponents/FlatButton.qml qml/ButtonComponents/IconButton.qml qml/ButtonComponents/MaterialButton.qml qml/ButtonComponents/ThreeDButton.qml
RESOURCES qml/Navi/qmldir
QML_FILES qml/Navi/HomePage.qml qml/Navi/NavigationBar.qml qml/Navi/NavItem.qml qml/Navi/Page2.qml qml/Navi/Page3.qml qml/Navi/Page4.qml

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(myapp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.myapp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(myapp
    PRIVATE Qt6::Quick
)

install(TARGETS myapp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# --- 为 VS Code CMake Tools 添加 Android 支持 ---
if(ANDROID)
    # 查找并加载 Qt 的 Android 支持模块
    find_package(Qt6 COMPONENTS AndroidExtras REQUIRED)
    
    # qt_finalize_project() 是 Qt 6 for Android 打包 APK 的关键步骤
    # 它负责处理依赖、资源打包和生成 AndroidManifest 等
    qt_finalize_project()
endif()
