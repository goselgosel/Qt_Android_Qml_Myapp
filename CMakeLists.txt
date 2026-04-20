cmake_minimum_required(VERSION 3.16)

project(myapp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(myapp
    main.cpp
)

qt_add_resources(myapp app_images
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
        qml/App/components/ToolCard.qml
        qml/App/components/ResponsivePage.qml
        qml/App/pages/HomePage.qml
        qml/App/pages/DigitalClockPage.qml
        qml/App/pages/NotesPage.qml
        qml/App/pages/TodoPage.qml
        qml/App/pages/CalculatorPage.qml
        qml/App/pages/StopwatchPage.qml
        qml/App/pages/CountdownPage.qml
        qml/App/pages/ConverterPage.qml
        qml/App/pages/CurrencyPage.qml
        qml/App/pages/TipPage.qml
        qml/App/pages/RandomPickerPage.qml
        qml/App/pages/DateCalculatorPage.qml
        qml/App/pages/QuickAccessPage.qml
    RESOURCES
        qml/App/services/Storage.js
)

set_target_properties(myapp PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(myapp PRIVATE Qt6::Quick)

install(TARGETS myapp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(ANDROID)
    qt_finalize_project()
endif()
