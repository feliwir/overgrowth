macro(target_set_options_flags target)
    if(UNIX)
        target_compile_definitions(${target} PRIVATE PLATFORM_UNIX=1)
    endif()
    if(LINUX)
        target_compile_definitions(${target} PRIVATE PLATFORM_LINUX=1)
    endif()

    if(FATAL_LOG_ASSERTS)
        target_compile_definitions(${target} PRIVATE FATAL_LOG_ASSERTS=1)
        message( STATUS "Compiling with fatal log asserts")
    else()
        message( STATUS "Not compiling with fatal log asserts")
    endif()

    if(BREAKPAD)
        target_compile_definitions(${target} PRIVATE BREAKPAD=1)
    endif()

    if(ENABLE_STEAMWORKS)
        target_compile_definitions(${target} PRIVATE ENABLE_STEAMWORKS=1)
        target_compile_definitions(${target} PRIVATE USE_STEAM_NETWORK_FRAMEWORK)
    else()
        target_compile_definitions(${target} PRIVATE USE_BASIC_NETWORK_FRAMEWORK)
    endif()

    if(ENABLE_RAD_TELEMETRY)

    else()
        target_compile_definitions(${target} PRIVATE NTELEMETRY)
    endif()

    if(MONITOR_MEMORY)
        target_compile_definitions(${target} PRIVATE MONITOR_MEMORY=1)
    endif()

    if(SINGLE_SHOT_ASSERTS)
        target_compile_definitions(${target} PRIVATE SINGLE_SHOT_ASSERTS=1)
    endif()

    if(OPEN_CONSOLE)
        target_compile_definitions(${target} PRIVATE OPEN_WIN32_CONSOLE=1)
    endif()
endmacro()
