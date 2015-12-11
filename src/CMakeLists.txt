
# ==============================================================================

IF(WIN32)
    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.zip")
        FILE(DOWNLOAD "http://www.vtk.org/files/release/6.3/VTK-6.3.0.zip" "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.zip" SHOW_PROGRESS)
    ENDIF()

    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0")
        EXEC_PROGRAM(${CMAKE_COMMAND} ${CMAKE_CURRENT_SOURCE_DIR} ARGS -E tar xvf VTK-6.3.0.zip)
        FILE(COPY "${CMAKE_CURRENT_SOURCE_DIR}/fix/VTK-6.3.0/GUISupport/Qt/CMakeLists.txt" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0/GUISupport/Qt/")
    ENDIF()
ELSE()
    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.tar.gz")
        FILE(DOWNLOAD "http://www.vtk.org/files/release/6.3/VTK-6.3.0.tar.gz" "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0.tar.gz" SHOW_PROGRESS)
    ENDIF()

    IF(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0")
        EXEC_PROGRAM(${CMAKE_COMMAND} ${CMAKE_CURRENT_SOURCE_DIR} ARGS -E tar xvf VTK-6.3.0.tar.gz)
        FILE(COPY "${CMAKE_CURRENT_SOURCE_DIR}/fix/VTK-6.3.0/GUISupport/Qt/CMakeLists.txt" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0/GUISupport/Qt/")
    ENDIF()
ENDIF()

# ==============================================================================

FILE(MAKE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
IF(WIN32)
    EXEC_PROGRAM(cmake "${CMAKE_CURRENT_SOURCE_DIR}/build" ARGS -G \"MinGW Makefiles\"  -DVTK_QT_VERSION:STRING=5 -DVTK_Group_Qt:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_INSTALL_PREFIX=\"${CMAKE_SOURCE_DIR}/build\" \"${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0\")
ELSE()
    EXEC_PROGRAM(cmake "${CMAKE_CURRENT_SOURCE_DIR}/build" ARGS -DVTK_QT_VERSION:STRING=5 -DVTK_Group_Qt:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_INSTALL_PREFIX=\"${CMAKE_SOURCE_DIR}/build\" \"${CMAKE_CURRENT_SOURCE_DIR}/VTK-6.3.0\")
ENDIF()

INCLUDE(ProcessorCount)
ProcessorCount(N)
MESSAGE(">>> Number of CPUs: ${N}") 
IF(WIN32)
    IF(NOT N EQUAL 0)
        ADD_CUSTOM_TARGET(vtk ALL mingw32-make install -j${N} WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
    ELSE()
        ADD_CUSTOM_TARGET(vtk ALL mingw32-make install WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
    ENDIF()

    # FIXME
    INSTALL(CODE "exec_program(mingw32-make install \"${CMAKE_CURRENT_SOURCE_DIR}/build\" ARGS install)")
ELSE()
    IF(NOT N EQUAL 0)
        ADD_CUSTOM_TARGET(vtk ALL make install -j${N} WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
    ELSE()
        ADD_CUSTOM_TARGET(vtk ALL make install WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
    ENDIF()

    # FIXME
    INSTALL(CODE "exec_program(make install \"${CMAKE_CURRENT_SOURCE_DIR}/build\" ARGS install)")
ENDIF()