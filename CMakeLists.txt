cmake_minimum_required(VERSION 3.14)
project(print VERSION 0.1.0 LANGUAGES CXX)

# Version settings
set(PRINT_VERSION_MAJOR 0)
set(PRINT_VERSION_MINOR 1)
set(PRINT_VERSION_PATCH 0)
set(PRINT_VERSION "${PRINT_VERSION_MAJOR}.${PRINT_VERSION_MINOR}.${PRINT_VERSION_PATCH}")
set(PRINT_VERSION_STRING "v${PRINT_VERSION}")

# Main library
add_library(print STATIC print.cpp)
target_include_directories(print PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Tests
option(BUILD_TESTS "Build tests" ON)

if(BUILD_TESTS)
    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG release-1.12.1
    )
    FetchContent_MakeAvailable(googletest)

    enable_testing()
    
    add_executable(check tests/test1.cpp)
    target_link_libraries(check PRIVATE print GTest::gtest_main)
    target_include_directories(check PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
    
    include(GoogleTest)
    gtest_discover_tests(check)
endif()


# Installation
install(TARGETS print
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    PUBLIC_HEADER DESTINATION include
)

# CPack
include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "KhotAbuch")
set(CPACK_PACKAGE_CONTACT "quentinthanks@yandex.ru")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Static print library")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
