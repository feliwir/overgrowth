macro(target_add_grouped_source target folder)
    file(GLOB GROUPED_SRCS 
        ${SRCDIR}/${folder}/*.cpp
        ${SRCDIR}/${folder}/*.h
        ${SRCDIR}/${folder}/*.hpp
    )
    target_sources(${target} PRIVATE ${GROUPED_SRCS})
    string(REGEX REPLACE "/" "\\\\" folder_backslash ${folder})
    source_group(${folder_backslash} FILES ${GROUPED_SRCS})
endmacro()

MACRO(AddGroupedScript folder)
    IF(EXISTS "${DATADIR}/")
        FILE(GLOB GROUPED_SRCS RELATIVE ${CMAKE_SOURCE_DIR}
            ${DATADIR}/${folder}/*.as
        )
        LIST(APPEND OVERGROWTH_SRCS ${GROUPED_SRCS})
        STRING(REGEX REPLACE "/" "\\\\" folder_backslash ${folder})
        SOURCE_GROUP(${folder_backslash} FILES ${GROUPED_SRCS})
    ENDIF()
ENDMACRO()

MACRO(AddGroupedShaders folder)
    IF(EXISTS "${DATADIR}/")
        FILE(GLOB GROUPED_SRCS RELATIVE ${CMAKE_SOURCE_DIR}
            ${DATADIR}/${folder}/*.glsl
            ${DATADIR}/${folder}/*.vert
            ${DATADIR}/${folder}/*.frag
        )
        LIST(APPEND OVERGROWTH_SRCS ${GROUPED_SRCS})
        STRING(REGEX REPLACE "/" "\\\\" folder_backslash ${folder})
        SOURCE_GROUP(${folder_backslash} FILES ${GROUPED_SRCS})
    ENDIF()
ENDMACRO()
