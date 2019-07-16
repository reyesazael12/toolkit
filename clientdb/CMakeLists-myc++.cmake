PROJECT(octetos-toolkit-clientdb-myc++ VERSION 5.2.0 LANGUAGES ${LANG})

FIND_PACKAGE(CUnit REQUIRED PATHS ${PROJECT_SOURCE_DIR}/../cmake/Modules/)
IF(CUNIT_FOUND)
	INCLUDE_DIRECTORIES(${CUNIT_INCLUDE_DIR})
ENDIF()

EXECUTE_PROCESS(COMMAND date +"%Y%m%d%H%M%S" OUTPUT_VARIABLE ${PROJECT_NAME}_VERSION_BUILD)
SET(${PROJECT_NAME}_VERSION_STAGE "beta")

SET(CMAKE_CXX_STANDARD 11)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_EXTENSIONS OFF)
CONFIGURE_FILE("${PROJECT_SOURCE_DIR}/versionInfo-myc++.h.in" "${PROJECT_SOURCE_DIR}/versionInfo-myc++.h")

FIND_PACKAGE(octetos-toolkit-common-c++ REQUIRED PATHS ${PROJECT_SOURCE_DIR}/../cmake/Modules/toolkit/)
IF(OCTETOS_TOOLKIT_COMMON_CPP_FOUND)
   INCLUDE_DIRECTORIES(${OCTETOS_TOOLKIT_COMMON_CPP_INCLUDE_DIR})
ELSE()
        MESSAGE(FATAL_ERROR "No se encontro toolkit-common.")
ENDIF()

MESSAGE("El Servidor seleccionado es MySQL ...")
FIND_PACKAGE(MySQL REQUIRED PATHS ${PROJECT_SOURCE_DIR}/../cmake/Modules/)
IF(MySQL_FOUND)
	   INCLUDE_DIRECTORIES(${MYSQL_INCLUDE_DIR})
ENDIF()
ADD_EXECUTABLE(developing clientdb.cpp clientdb-mysql.cpp developing.cpp)
ADD_EXECUTABLE(testing-myc++-v${${PROJECT_NAME}_VERSION_MAJOR} clientdb.cpp clientdb-mysql.cpp test/myc++-v${${PROJECT_NAME}_VERSION_MAJOR}.cpp)
TARGET_LINK_LIBRARIES(testing-myc++-v${${PROJECT_NAME}_VERSION_MAJOR} ${CUNIT_LIBRARY} ${OCTETOS_TOOLKIT_COMMON_CPP_LIBRARY} ${MYSQL_LIBRARY})
TARGET_LINK_LIBRARIES(developing ${OCTETOS_TOOLKIT_COMMON_CPP_LIBRARY} ${MYSQL_LIBRARY} )
ADD_LIBRARY(${PROJECT_NAME} STATIC clientdb.cpp clientdb-mysql.cpp)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${OCTETOS_TOOLKIT_COMMON_CPP_LIBRARY} ${MYSQL_LIBRARY})
INSTALL(TARGETS ${PROJECT_NAME} DESTINATION lib/octetos/toolkit/clientdb)
INSTALL(FILES clientdb.hpp DESTINATION include/octetos/toolkit/clientdb)
INSTALL(FILES clientdb-mysql.hpp DESTINATION include/octetos/toolkit/clientdb)

SET(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
INCLUDE (InstallRequiredSystemLibraries)
SET (CPACK_PACKAGE_VERSION_MAJOR "${${PROJECT_NAME}_VERSION_MAJOR}")
SET (CPACK_PACKAGE_VERSION_MINOR "${${PROJECT_NAME}_VERSION_MINOR}")
SET (CPACK_PACKAGE_VERSION_PATCH "${${PROJECT_NAME}_VERSION_PATCH}")
INCLUDE (CPack)