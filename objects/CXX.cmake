
SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_EXTENSIONS OFF)


CONFIGURE_FILE("${PROJECT_SOURCE_DIR}/config.h.in" "${PROJECT_SOURCE_DIR}/config.h")
SET(targetName toolkit-objects-c++)

FIND_PACKAGE(toolkit-common-c++ REQUIRED PATHS ${PROJECT_SOURCE_DIR}/../cmake/Modules/)
IF(TOOLKIT_COMMON_FOUND)
	INCLUDE_DIRECTORIES(${TOOLKIT_COMMON_INCLUDE_DIR})
ENDIF()

ADD_EXECUTABLE(develop develop.cpp objects.cpp)

ADD_LIBRARY(${targetName} STATIC objects.cpp)
TARGET_LINK_LIBRARIES(${targetName}) 

INSTALL(TARGETS ${targetName} DESTINATION lib/toolkit)
INSTALL(FILES objects.hpp DESTINATION include/toolkit)
