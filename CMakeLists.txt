# -----------------------------------------------------------------------------
# Copyright 2022 Wolfire Games LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
# -----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.11)

project(Overgrowth LANGUAGES CXX C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake")

# Options

option(FATAL_LOG_ASSERTS "Have LOG_ASSERTS* trigger a normal assert() call" OFF)
set(BUILD_ID
    "-1"
    CACHE STRING "Build ID value from automated build system")
# Option to build with breakpad, removes some compiler warnings, so it's best to
# go without for normal development.
option(BREAKPAD
       "Build with breakpad linked into the binary and with exception handling?"
       OFF)
option(
  DO_DIST_ARCHIVE
  "Generate a package containing all build data relevant for final release, excluding game data."
  OFF)
option(
  BUILD_SERVER
  "Building on a buildserver, this means that additional steps are included which generally only occur on a build server"
  OFF)
option(SLIM_TIMING "Build with slim timing system activated" OFF)
option(ENABLE_RAD_TELEMETRY "Enable RAD Game Tools Telemetry Support" OFF)
option(ENABLE_GUI "Enable GUI" ON)
option(GPU_MARKERS "Add GPU markers" OFF)
option(
  GL_TIMING_QUERY
  "Build with ARB_timing_query support used for timing OpenGL GPU execution times"
  OFF)
option(
  GL_INTEL_TIMING
  "Build with ARB_performance_query support used for timing OpenGL performance specifically on intel GPU's"
  OFF)
option(BUILD_OGDA "Build OGDA" ON)
option(BUILD_OVERGROWTH "Build the main game" ON)
option(MONITOR_MEMORY "Monitor memory usage and make avaiable ingame" Off)
option(OPEN_CONSOLE "Open a console on startup on windows" On)
option(FORCE_OPENGL_ERROR_CHECKING "Force OpenGL error checking in Release" Off)
option(
  DEPLOY
  "Set the codebase to compile for Deploy, this means compiling for final release to end-user, in practice, by setting the _DEPLOY define it activates a working directory change on start to force it to be the path of the binary. It also impacts some error messages. This is automatically turned on if BUILD_SERVER is On"
  Off)
option(ENABLE_STEAMWORKS "Build with Steamworks Support" Off)
set(AUX_DATA
    ""
    CACHE
      PATH
      "Auxiliary Data sourced path, used when using a Data folder from an additional path, like an already installed version of the game"
)

message(STATUS "Type: ${CMAKE_BUILD_TYPE}")
if(CMAKE_BUILD_TYPE)
  set(WIN32_DIST_FOLDER "${CMAKE_BUILD_TYPE}")
else()
  set(WIN32_DIST_FOLDER "Release")
endif()
message(STATUS "Path: ${CMAKE_BINARY_DIR}/${WIN32_DIST_FOLDER}")
message(STATUS "")
message(STATUS "Build Server: ${BUILD_SERVER}")
message(STATUS "Build Ogda: ${BUILD_OGDA}")
message(STATUS "")
message(
  STATUS "Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "")
message(STATUS "Monitor Memory: ${MONITOR_MEMORY}")
message(STATUS "Generator: ${CMAKE_GENERATOR}")
message(STATUS "Breakpad: ${BREAKPAD}")
message(STATUS "Slim Timing: ${SLIM_TIMING}")
message(STATUS "GL Timing Query: ${GL_TIMING_QUERY}")
message(STATUS "Intel Timing: ${GL_INTEL_TIMING}")
message(STATUS "Asset Manager Perf: ${ASSET_MANAGER_PERF}")
message(STATUS "Enable Rad Telemetry: ${ENABLE_RAD_TELEMETRY}")
message(STATUS "Force OpenGL Error Checking: ${FORCE_OPENGL_ERROR_CHECKING}")
message(STATUS "Git version: ${GIT_VERSION}")
message(STATUS "Git rev-list: ${GIT_REV_LIST}")
message(STATUS "Build ID: ${BUILD_ID}")

# Git

include(GetGitRevisionDescription)
include(ExternalProject)

git_describe(GIT_VERSION --always --tag)
git_rev_list(GIT_REV_LIST --count HEAD) # Count what revision we're on

# Detect platform
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(LINUX TRUE)
endif()

set(SRCDIR "${CMAKE_SOURCE_DIR}/Source")
set(LIBDIR "${CMAKE_SOURCE_DIR}/Libraries")

add_subdirectory(Libraries/crunch-r319 crnlib)

add_subdirectory(Projects/angelscript_2_32_0_sdk/angelscript/projects/cmake
                 angelscript_2_32_0_sdk)
add_subdirectory(Projects/binn binn)
add_subdirectory(Projects/bullet3-2.89 bullet3-2.89)
add_subdirectory(Projects/recastnavigation)
add_subdirectory(Projects/TheoraPlayer TheoraPlayer)

add_subdirectory(Source)
