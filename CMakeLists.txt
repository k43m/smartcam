cmake_minimum_required(VERSION 3.16)

project(smartcam VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Qml)
find_package(Qt6 COMPONENTS Network)
find_package(Qt6 COMPONENTS Quick)
find_package(Qt6 COMPONENTS Positioning)
find_package(Qt6 COMPONENTS Location)

qt_standard_project_setup()

qt_add_executable(appsmartcam
    smartcam.h
    smartcam.cpp
    main.cpp
    resources.qrc
)

qt_add_qml_module(appsmartcam
    URI smartcam
    VERSION 1.0
    QML_FILES Main.qml
)

set(appsmartcam_files
    "liste_smart_cams.json"
)



set_target_properties(appsmartcam PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsmartcam
    PRIVATE Qt6::Quick
)

install(TARGETS appsmartcam
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
