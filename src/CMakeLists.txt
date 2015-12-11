
IF(WIN32)
    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.zip")
        FILE(DOWNLOAD "http://www.vtk.org/files/release/6.3/VTK-6.3.0.zip" "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.zip" SHOW_PROGRESS)
    ENDIF()

    IF()
        EXEC_PROGRAM(${CMAKE_COMMAND} ${CMAKE_CURRENT_SOURCE_DIR} ARGS -E tar xvf VTK-6.3.0.zip)
        FILE(COPY "${CMAKE_CURRENT_SOURCE_DIR}/fix/VTK-6.3.0/GUISupport/Qt/CMakeLists.txt" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0/GUISupport/Qt/")
    ENDIF()
ELSE()
    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.tar.gz")
        FILE(DOWNLOAD "http://www.vtk.org/files/release/6.3/VTK-6.3.0.tar.gz" "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.tar.gz" SHOW_PROGRESS)
    ENDIF()

    IF()
        EXEC_PROGRAM(${CMAKE_COMMAND} ${CMAKE_CURRENT_SOURCE_DIR} ARGS -E tar xvf VTK-6.3.0.tar.gz)
        FILE(COPY "${CMAKE_CURRENT_SOURCE_DIR}/fix/VTK-6.3.0/GUISupport/Qt/CMakeLists.txt" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0/GUISupport/Qt/")
    ENDIF()
ENDIF()