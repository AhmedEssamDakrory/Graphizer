cmake_minimum_required(VERSION 3.16)

project(graphizer LANGUAGES CXX C VERSION 0.1)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")

# link with qt6
find_package(Qt6 COMPONENTS Core Quick Network REQUIRED)

if (Qt6_DIR)
	message(STATUS "Qt6 path: ${Qt6_DIR}")
endif ()

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(SOURCE_FILES
	src/main.cpp)

# list resources files
set(RESOURCES_FILES
		resources/qml/qml.qrc
)

# add library target
add_executable(graphizer
	${SOURCE_FILES}
	${RESOURCES_FILES}
)

target_link_libraries(graphizer
	PUBLIC
		Qt6::Core
		Qt6::Quick
		Qt6::Network
)

# make it reflect the same structure as the one on disk
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${HEADER_FILES})
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCE_FILES})

target_compile_features(graphizer PUBLIC cxx_std_17)
set_target_properties(graphizer PROPERTIES
	CXX_EXTENSIONS OFF
)

# list include directories
target_include_directories(graphizer
	PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}/include
		${CMAKE_CURRENT_BINARY_DIR}/include
)
