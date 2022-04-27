SET(LIBDIR "${CMAKE_CURRENT_SOURCE_DIR}/../../Libraries")
SET(SRCDIR "${CMAKE_CURRENT_SOURCE_DIR}/../../Libraries/TheoraPlayer/Source")

FILE(GLOB THEORAPLAYER_SRCS
    ${SRCDIR}/TheoraPlayer/*.cpp
)

ADD_LIBRARY(TheoraPlayer STATIC ${THEORAPLAYER_SRCS})

TARGET_INCLUDE_DIRECTORIES(
    TheoraPlayer
    PUBLIC
    ${SRCDIR}
    ${LIBDIR}/Linux/include
    ${LIBDIR}/theora/include
    ${LIBDIR}/ogg/include
    ${LIBDIR}/vorbis/include
)