cmake_minimum_required(VERSION 3.16)

project(untitled3_qml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appuntitled3_qml
    main.cpp
    ButtonComponents/FlatButton.qml
)

# 在 qt_add_qml_module 之前添加
qt_add_resources(appuntitled3_qml "app_images"
    PREFIX "/"
    FILES
        resources/images/kafei.png
)

qt_add_qml_module(appuntitled3_qml
    URI untitled3_qml
    VERSION 1.0
    QML_FILES
        Main.qml
        # 添加子目录作为子模块
    IMPORT_PATH
        ${CMAKE_CURRENT_SOURCE_DIR}/Navi
    RESOURCES
        ButtonComponents/qmldir
        ButtonComponents/FlatButton.qml ButtonComponents/IconButton.qml ButtonComponents/MaterialButton.qml ButtonComponents/ThreeDButton.qml
        Navi/qmldir
        Navi/NavigationBar.qml Navi/NavItem.qml Navi/HomePage.qml  Navi/Page3.qml Navi/Page4.qml
        RESOURCES .gitignore
        QML_FILES Navi/Page2.qml
        QML_FILES qml/DigitalFlipClock/DigitalFlipClock.qml
        RESOURCES qml/DigitalFlipClock/Components/qmldir
        QML_FILES qml/DigitalFlipClock/Components/TimeDisplay.qml qml/DigitalFlipClock/Components/TimeUnit.qml
        #RESOURCES resources/images/kafei.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appuntitled3_qml PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appuntitled3_qml
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appuntitled3_qml
    PRIVATE Qt6::Quick
)

install(TARGETS appuntitled3_qml
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
