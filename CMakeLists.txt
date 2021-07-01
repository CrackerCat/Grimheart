cmake_minimum_required(VERSION 3.0)
project(Grimheart)
enable_testing()

# cryptopp
# Ninja's support is broken. See https://github.com/noloader/cryptopp-cmake/issues/57
include(ExternalProject)
ExternalProject_Add(
  cryptopp-cmake
  URL https://github.com/noloader/cryptopp-cmake/archive/refs/tags/CRYPTOPP_8_5_0.zip
  URL_MD5 e947f57137338fe1f350c8de6ef7f730
  DOWNLOAD_NAME cryptopp-cmake-CRYPTOPP_8_5_0.zip
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
INSTALL_COMMAND "" STEP_TARGETS cryptopp-cmake)
ExternalProject_Get_Property(cryptopp-cmake SOURCE_DIR)
ExternalProject_Add(
  cryptopp
  URL https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_8_5_0.zip
  URL_MD5 62fee41a6ef8395f61ddfb90c69d926a
  DOWNLOAD_NAME cryptopp-CRYPTOPP_8_5_0.zip INSTALL_COMMAND "" TEST_BEFORE_INSTALL ON
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${SOURCE_DIR}/CMakeLists.txt
${SOURCE_DIR}/cryptopp-config.cmake <SOURCE_DIR> DEPENDS cryptopp-cmake )

# curl
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/curl/)
# curl's test-full is not exposed properly as CMake test
add_custom_target(curl-test)
## curl does some weird shit like checking if there is any redundant symbols, not what we want / need #
# TODO: Hjack CMake to disable test:
# 1119 - Verify that symbols-in-versions and headers are in sync - stdout
# 1139 - Verify that all libcurl options have man pages - stderr
# 1167 - Verify curl prefix of public symbols in header files
add_dependencies(curl-test test-full)


# flac
SET(WITH_OGG OFF CACHE BOOL "Force Disable FLAC libOGG")
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/flac/)

# fmt
SET(FMT_TEST ON CACHE BOOL "Force Enable FMT Tests")
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/fmt/)

# nghttp2
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/nghttp2/)

# OpenSSL doesn't have a CMake-based build system

# libxml2
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/xml2/)

# yaml-cpp
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/3rd_party/yaml-cpp/)
# yaml-cpp's test is not built when building as sub-project
