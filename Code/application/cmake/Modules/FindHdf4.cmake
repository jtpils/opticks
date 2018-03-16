find_path(Hdf4_INCLUDE_DIR hdf.h PATH_SUFFIXES hdf)
if(Hdf4_INCLUDE_DIR AND EXISTS "${Hdf4_INCLUDE_DIR}/h4config.h")
    file(STRINGS "${Hdf4_INCLUDE_DIR}/h4config.h" Hdf4_Parsed_Version REGEX "^#define H4_VERSION \"[^\"]*\"$")

    string(REGEX REPLACE "^.*H4_VERSION \"([0-9]+).*$" "\\1" Hdf4_VERSION_MAJOR "${Hdf4_Parsed_Version}")
    string(REGEX REPLACE "^.*H4_VERSION \"[0-9]+\\.([0-9]+).*$" "\\1" Hdf4_VERSION_MINOR  "${Hdf4_Parsed_Version}")
    string(REGEX REPLACE "^.*H4_VERSION \"[0-9]+\\.[0-9]+[\\.|r]([0-9]+).*$" "\\1" Hdf4_VERSION_PATCH "${Hdf4_Parsed_Version}")

    set(Hdf4_VERSION_STRING "${Hdf4_VERSION_MAJOR}.${Hdf4_VERSION_MINOR}.${Hdf4_VERSION_PATCH}")
    set(Hdf4_COMPACT_VERSION_STRING "${Hdf4_VERSION_MAJOR}${Hdf4_VERSION_MINOR}${Hdf4_VERSION_PATCH}") 
    set(Hdf4_MAJOR_VERSION "${Hdf4_VERSION_MAJOR}")
    set(Hdf4_MINOR_VERSION "${Hdf4_VERSION_MINOR}")
    set(Hdf4_PATCH_VERSION "${Hdf4_VERSION_PATCH}")
endif()

find_library(Hdf4_LIBRARY_RELEASE NAMES hd${Hdf4_COMPACT_VERSION_STRING}m df dfalt)
find_library(Hdf4_LIBRARY_DEBUG NAMES hd${Hdf4_COMPACT_VERSION_STRING}md)

include(SelectLibraryConfigurations)
select_library_configurations(Hdf4)

list(FIND Hdf4_FIND_COMPONENTS SD SD_FOUND_INDEX)
if(NOT SD_FOUND_INDEX EQUAL -1)
    if (EXISTS "${Hdf4_INCLUDE_DIR}/mfhdf.h")
        set(Hdf4_FOUND_SD_HEADER 1)
    endif()
    find_library(Hdf4_SD_LIBRARY_RELEASE NAMES hm${Hdf4_COMPACT_VERSION_STRING}m mfhdf mfhdfalt)
    find_library(Hdf4_SD_LIBRARY_DEBUG NAMES hm${Hdf4_COMPACT_VERSION_STRING}md)
    select_library_configurations(Hdf4_SD)
endif()

include(FindPackageHandleStandardArgs)
if(Hdf4_FIND_REQUIRED_SD)
    set(Hdf4_LIBRARIES ${Hdf4_LIBRARIES} ${Hdf4_SD_LIBRARIES})
    find_package_handle_standard_args(Hdf4 REQUIRED_VARS Hdf4_INCLUDE_DIR Hdf4_FOUND_SD_HEADER Hdf4_LIBRARY Hdf4_SD_LIBRARY Hdf4_VERSION_STRING VERSION_VAR Hdf4_VERSION_STRING)
else()
    find_package_handle_standard_args(Hdf4 REQUIRED_VARS Hdf4_INCLUDE_DIR Hdf4_LIBRARY Hdf4_VERSION_STRING VERSION_VAR Hdf4_VERSION_STRING)
endif()
set(Hdf4_INCLUDE_DIRS ${Hdf4_INCLUDE_DIR})
mark_as_advanced(Hdf4_INCLUDE_DIR)
set(Hdf4_FOUND ${HDF4_FOUND})
