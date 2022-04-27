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

set(SRCDIR "${CMAKE_SOURCE_DIR}/Source")
set(LIBDIR "${CMAKE_SOURCE_DIR}/Libraries")
set(PROJDIR "${CMAKE_SOURCE_DIR}/Projects")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(SourceHelpers)
include(SetOptionFlags)

# Dependencies
find_package(OpenAL REQUIRED)

# TODO: Work on supporting "GLVND" instead.
set(OpenGL_GL_PREFERENCE LEGACY)
find_package(OpenGL REQUIRED)

find_package(SDL2 REQUIRED)
find_package(Freetype REQUIRED)

# Logging library
add_library(logging STATIC)
target_include_directories(logging PRIVATE ${SRCDIR})
target_add_grouped_source(logging Logging)

# Overgrowth target
if(BUILD_OVERGROWTH)
  add_executable(Overgrowth ${SRCDIR}/Version/git_version.cpp)
  target_include_directories(
    Overgrowth
    PRIVATE ${SRCDIR}
            ${LIBDIR}
            ${LIBDIR}/glm-0.9.4.2
            ${LIBDIR}/imgui-1.85
            ${LIBDIR}/ovr_sdk_win_1.12.0_public/OculusSDK/LibOVR/Include
            ${LIBDIR}/recastnavigation/Recast/Include
            ${LIBDIR}/recastnavigation/Detour/Include
            ${LIBDIR}/recastnavigation/DetourTileCache/Include
            ${LIBDIR}/recastnavigation/DetourCrowd/Include
            ${LIBDIR}/tclap/include
            ${PROJDIR}/angelscript_2_32_0_sdk/angelscript/include
            ${PROJDIR}/bullet3-2.89/src
            ${OPENAL_INCLUDE_DIR}
            ${SDL2_INCLUDE_DIR}
            ${SDL2NET_INCLUDE_DIR})

  target_link_libraries(
    Overgrowth
    # Ours
    logging
    # 3rdparty
    OpenGL::GL
    Freetype::Freetype
    ${OPENAL_LIBRARY}
    binn
    BulletDynamics
    BulletCollision
    BulletWorldImporter
    BulletFileLoader
    crnlib
    TheoraPlayer)

  if(LINUX)
    find_package(GTK2 REQUIRED)
    target_link_libraries(Overgrowth ${GTK2_TARGETS})
  endif(LINUX)

  target_set_options_flags(Overgrowth)

  set(OVERGROWTH_INTERNAL_SRCS
      ${LIBDIR}/ovr_sdk_win_1.12.0_public/OculusSDK/LibOVR/Src/OVR_StereoProjection.cpp
      ${LIBDIR}/ovr_sdk_win_1.12.0_public/OculusSDK/LibOVR/Src/OVR_CAPI_Util.cpp
      ${LIBDIR}/ovr_sdk_win_1.12.0_public/OculusSDK/LibOVR/Src/OVR_CAPIShim.c
      ${SRCDIR}/Internal/checksum.cpp
      ${SRCDIR}/Internal/crashreport.cpp
      ${SRCDIR}/Internal/collisiondetection.cpp
      ${SRCDIR}/Internal/config.cpp
      ${SRCDIR}/Internal/datemodified.cpp
      ${SRCDIR}/Internal/dialogues.cpp
      ${SRCDIR}/Internal/error.cpp
      ${SRCDIR}/Internal/hardware_specs.cpp
      ${SRCDIR}/Internal/memwrite.cpp
      ${SRCDIR}/Internal/path_utility.cpp
      ${SRCDIR}/Internal/stopwatch.cpp
      ${SRCDIR}/Internal/textfile.cpp
      ${SRCDIR}/Internal/timer.cpp
      ${SRCDIR}/Internal/treestructure.cpp
      ${SRCDIR}/Internal/cachefile.cpp
      ${SRCDIR}/Internal/varstring.cpp
      ${SRCDIR}/Internal/levelxml.cpp
      ${SRCDIR}/Internal/levelxml_script.cpp
      ${SRCDIR}/Internal/zip_util.cpp
      ${SRCDIR}/Internal/returnpathutil.cpp
      ${SRCDIR}/Internal/casecorrectpath.cpp
      ${SRCDIR}/Internal/file_descriptor.cpp
      ${SRCDIR}/Internal/path_set.cpp
      ${SRCDIR}/Internal/comma_separated_list.h
      ${SRCDIR}/Internal/config.h
      ${SRCDIR}/Internal/crashreport.h
      ${SRCDIR}/Internal/datemodified.h
      ${SRCDIR}/Internal/dialogues.h
      ${SRCDIR}/Internal/error.h
      ${SRCDIR}/Internal/file_descriptor.h
      ${SRCDIR}/Internal/hardware_specs.h
      ${SRCDIR}/Internal/integer.h
      ${SRCDIR}/Internal/levelxml.h
      ${SRCDIR}/Internal/levelxml_script.h
      ${SRCDIR}/Internal/memwrite.h
      ${SRCDIR}/Internal/message.h
      ${SRCDIR}/Internal/path_set.h
      ${SRCDIR}/Internal/path_utility.h
      ${SRCDIR}/Internal/returnpathutil.h
      ${SRCDIR}/Internal/scoped_buffer.h
      ${SRCDIR}/Internal/SIMD.h
      ${SRCDIR}/Internal/stopwatch.h
      ${SRCDIR}/Internal/textfile.h
      ${SRCDIR}/Internal/timer.h
      ${SRCDIR}/Internal/treestructure.h
      ${SRCDIR}/Internal/varstring.h
      ${SRCDIR}/Internal/cachefile.h
      ${SRCDIR}/Internal/callstack.h
      ${SRCDIR}/Internal/casecorrectpath.h
      ${SRCDIR}/Internal/checksum.h
      ${SRCDIR}/Internal/collisiondetection.h
      ${SRCDIR}/Internal/win_mem_track.h
      ${SRCDIR}/Internal/win_mem_track.cpp
      ${SRCDIR}/Internal/common.h
      ${SRCDIR}/Internal/common.cpp
      ${SRCDIR}/Internal/profiler.h
      ${SRCDIR}/Internal/profiler.cpp
      ${SRCDIR}/Internal/filesystem.h
      ${SRCDIR}/Internal/filesystem.cpp
      ${SRCDIR}/Internal/modloading.cpp
      ${SRCDIR}/Internal/modloading.h
      ${SRCDIR}/Internal/modid.cpp
      ${SRCDIR}/Internal/modid.h
      ${SRCDIR}/Internal/detect_settings.cpp
      ${SRCDIR}/Internal/detect_settings.h
      ${SRCDIR}/Internal/spawneritem.cpp
      ${SRCDIR}/Internal/spawneritem.h
      ${SRCDIR}/Internal/path.cpp
      ${SRCDIR}/Internal/path.h
      ${SRCDIR}/Internal/assetpreload.cpp
      ${SRCDIR}/Internal/assetpreload.h
      ${SRCDIR}/Internal/locale.cpp
      ${SRCDIR}/Internal/locale.h
      ${SRCDIR}/Compat/compat.h
      ${SRCDIR}/Compat/filepath.h
      ${SRCDIR}/Compat/hardware_info.h
      ${SRCDIR}/Compat/time.h
      ${SRCDIR}/Compat/os_dialogs.h
      ${SRCDIR}/Compat/fileio.cpp
      ${SRCDIR}/Compat/fileio.h
      ${SRCDIR}/Compat/platformsetup.cpp
      ${SRCDIR}/Compat/platformsetup.h
      ${SRCDIR}/Compat/processpool.cpp
      ${SRCDIR}/Compat/processpool.h)

  if(UNIX)
    list(
      APPEND OVERGROWTH_INTERNAL_SRCS ${SRCDIR}/Compat/UNIX/unix_filepath.cpp
      ${SRCDIR}/Compat/UNIX/unix_compat.cpp ${SRCDIR}/Compat/UNIX/unix_compat.h)
  endif()

  if(LINUX)
    list(
      APPEND
      OVERGROWTH_INTERNAL_SRCS
      ${SRCDIR}/Compat/Linux/os_dialogs_linux.cpp
      ${SRCDIR}/Compat/Linux/linux_compat.cpp
      ${SRCDIR}/Compat/Linux/linux_compat.h
      ${SRCDIR}/Compat/Linux/linux_hardware_info.cpp
      ${SRCDIR}/Compat/Linux/linux_time.cpp)
  endif()

  if(APPLE)
    list(
      APPEND
      OVERGROWTH_INTERNAL_SRCS
      ${SRCDIR}/Compat/Mac/os_dialogs_mac.mm
      ${SRCDIR}/Compat/Mac/os_file_dialogs_mac.mm
      ${SRCDIR}/Compat/Mac/os_file_dialogs_mac.h
      ${SRCDIR}/Compat/Mac/mac_compat.mm
      ${SRCDIR}/Compat/Mac/mac_compat.h
      ${SRCDIR}/Compat/Mac/mac_hardware_info.cpp
      ${SRCDIR}/Compat/Mac/mac_time.cpp)
  endif()

  if(WIN32)
    list(
      APPEND
      OVERGROWTH_INTERNAL_SRCS
      ${SRCDIR}/Compat/Win/os_dialogs_win.cpp
      ${SRCDIR}/Compat/Win/win_filepath.cpp
      ${SRCDIR}/Compat/Win/win_compat.cpp
      ${SRCDIR}/Compat/Win/win_compat.h
      ${SRCDIR}/Compat/Win/win_hardware_info.cpp
      ${SRCDIR}/Compat/Win/win_time.cpp)

    if(MSVC_VERSION LESS 1911)
      list(APPEND OVERGROWTH_INTERNAL_SRCS ${SRCDIR}/Internal/snprintf.c)
    endif()

    if(ENABLE_RAD_TELEMETRY)
      list(APPEND OVERGROWTH_INTERNAL_SRCS
           ${PLIBDIR}/Telemetry2SDKWin32_20P3/src/gpu/gpu_opengl.cpp)
    endif()
  endif()

  # Add internal source
  target_sources(Overgrowth PRIVATE ${OVERGROWTH_INTERNAL_SRCS})
  source_group(Internal FILES ${OVERGROWTH_INTERNAL_SRCS})

  # Add source folders
  target_add_grouped_source(Overgrowth AI)
  target_add_grouped_source(Overgrowth Asset)
  target_add_grouped_source(Overgrowth Asset/Asset)
  target_add_grouped_source(Overgrowth Asset/AssetLoader)
  target_add_grouped_source(Overgrowth Editors)
  target_add_grouped_source(Overgrowth Game)
  target_add_grouped_source(Overgrowth Graphics)
  target_add_grouped_source(Overgrowth GUI)
  target_add_grouped_source(Overgrowth GUI/IMUI)
  target_add_grouped_source(Overgrowth GUI/dimgui)
  target_add_grouped_source(Overgrowth Images)
  target_add_grouped_source(Overgrowth Main)
  target_add_grouped_source(Overgrowth Math)
  target_add_grouped_source(Overgrowth Objects)
  target_add_grouped_source(Overgrowth Physics)
  target_add_grouped_source(Overgrowth Scripting)
  target_add_grouped_source(Overgrowth Scripting/angelscript)
  target_add_grouped_source(Overgrowth Scripting/angelscript/add_on/scriptarray)
  target_add_grouped_source(Overgrowth Scripting/angelscript/add_on/scriptdictionary)
  target_add_grouped_source(Overgrowth Scripting/angelscript/add_on/scripthelper)
  target_add_grouped_source(Overgrowth Scripting/angelscript/add_on/scriptstdstring)
  target_add_grouped_source(Overgrowth Scripting/angelscript/add_on/debugger)
  target_add_grouped_source(Overgrowth Sound)
  target_add_grouped_source(Overgrowth Sound/Music)
  target_add_grouped_source(Overgrowth Sound/Loader)
  target_add_grouped_source(Overgrowth Sound/AudioFilters)
  target_add_grouped_source(Overgrowth Threading)
  target_add_grouped_source(Overgrowth UserInput)
  target_add_grouped_source(Overgrowth XML)
  target_add_grouped_source(Overgrowth XML/Parsers)
  target_add_grouped_source(Overgrowth JSON)
  target_add_grouped_source(Overgrowth Memory)
  target_add_grouped_source(Overgrowth Network)
  # In the future, this should only be activated if we're building for the steam
  # target
  target_add_grouped_source(Overgrowth Network/Steam)
  target_add_grouped_source(Overgrowth Network/Basic)
  target_add_grouped_source(Overgrowth Utility)
  target_add_grouped_source(Overgrowth Wrappers)
  target_add_grouped_source(Overgrowth Timing)
  target_add_grouped_source(Overgrowth Steam)
  target_add_grouped_source(Overgrowth Online)
  target_add_grouped_source(Overgrowth Online/Message)
endif()
