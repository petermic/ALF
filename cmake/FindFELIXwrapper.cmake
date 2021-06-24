# - Try to find the FELIXwrapper package include dirs and libraries
# Author: Barthelemy von Haller
#
# This script will set the following variables:
#  FELIXwrapper_FOUND - System has FELIXwrapper
#  FELIXwrapper_INCLUDE_DIRS - The FELIXwrapper include directories
#  FELIXwrapper_LIBRARIES - The libraries needed to use FELIXwrapper
#  FELIXwrapper_DEFINITIONS - Compiler switches required for using FELIXwrapper
#
# This script can use the following variables:
#  FELIXwrapper_ROOT - Installation root to tell this module where to look. (it tries LD_LIBRARY_PATH otherwise)

# Init
include(FindPackageHandleStandardArgs)

# find includes
find_path(FELIXwrapper_INCLUDE_DIR CardInterface.h
        HINTS ${FELIXwrapper_ROOT}/include ENV LD_LIBRARY_PATH PATH_SUFFIXES "../include/FELIXwrapper" "../../include/FELIXwrapper" )
# Remove the final "FELIXwrapper"
get_filename_component(FELIXwrapper_INCLUDE_DIR ${FELIXwrapper_INCLUDE_DIR} DIRECTORY)
set(FELIXwrapper_INCLUDE_DIRS ${FELIXwrapper_INCLUDE_DIR})

# find library
find_library(FELIXwrapper_LIBRARY NAMES FELIXwrapper HINTS ${FELIXwrapper_ROOT}/lib ENV LD_LIBRARY_PATH)
set(FELIXwrapper_LIBRARIES ${FELIXwrapper_LIBRARY})

# handle the QUIETLY and REQUIRED arguments and set FELIXwrapper_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(FELIXwrapper  "FELIXwrapper could not be found. Install package FELIXwrapper or set FELIXwrapper_ROOT to its root installation directory."
        FELIXwrapper_LIBRARY FELIXwrapper_INCLUDE_DIR)

if(${FELIXwrapper_FOUND})
    message(STATUS "FELIXwrapper found : ${FELIXwrapper_LIBRARIES}")
    mark_as_advanced(FELIXwrapper_INCLUDE_DIR FELIXwrapper_LIBRARY)

    # add target
    if(NOT TARGET AliceO2::FELIXwrapper)
        add_library(AliceO2::FELIXwrapper INTERFACE IMPORTED)
        set_target_properties(AliceO2::FELIXwrapper PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${FELIXwrapper_INCLUDE_DIR}"
                INTERFACE_LINK_LIBRARIES "${FELIXwrapper_LIBRARY}"
                )
    endif()
endif()
