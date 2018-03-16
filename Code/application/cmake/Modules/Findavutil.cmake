find_path(avutil_INCLUDE_DIR avutil.h PATH_SUFFIXES ffmpeg libavutil)
if(avutil_INCLUDE_DIR AND EXISTS "${avutil_INCLUDE_DIR}/avutil.h")
    file(STRINGS "${avutil_INCLUDE_DIR}/avutil.h" avutil_Parsed_Version REGEX "^#define LIBAVUTIL_VERSION +.+$")
    string(REGEX REPLACE "^.*LIBAVUTIL_VERSION +([0-9]+).*$" "\\1" avutil_VERSION_MAJOR "${avutil_Parsed_Version}")
    string(REGEX REPLACE "^.*LIBAVUTIL_VERSION +[0-9]+\\.([0-9]+).*$" "\\1" avutil_VERSION_MINOR "${avutil_Parsed_Version}")
    string(REGEX REPLACE "^.*LIBAVUTIL_VERSION +[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" avutil_VERSION_PATCH "${avutil_Parsed_Version}")

    set(avutil_VERSION_STRING "${avutil_VERSION_MAJOR}.${avutil_VERSION_MINOR}.${avutil_VERSION_PATCH}")
    set(avutil_MAJOR_VERSION "${avutil_VERSION_MAJOR}")
    set(avutil_MINOR_VERSION "${avutil_VERSION_MINOR}")
    set(avutil_PATCH_VERSION "${avutil_VERSION_PATCH}")
endif()

find_library(avutil_LIBRARY_RELEASE NAMES avutil)
find_library(avutil_LIBRARY_DEBUG NAMES avutild)

include(SelectLibraryConfigurations)
select_library_configurations(avutil)

set(avutil_DEFINITIONS -DOFFSET_T_DEFINED)
if(WIN32)
    list(APPEND avutil_DEFINITIONS -DEMULATE_INTTYPES -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_ISOC9X_SOURCE -DMSVC8 -DBUILD_SHARED_AV)
endif()
set(avutil_DEFINITIONS "${avutil_DEFINITIONS}" CACHE STRING "avutil definitions")

set(avutil_INCLUDE_DIRS ${avutil_INCLUDE_DIR})
mark_as_advanced(avutil_INCLUDE_DIR)
mark_as_advanced(avutil_DEFINITIONS)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(avutil REQUIRED_VARS avutil_INCLUDE_DIR avutil_LIBRARY VERSION_VAR avutil_VERSION_STRING)
set(avutil_FOUND ${AVUTIL_FOUND})
