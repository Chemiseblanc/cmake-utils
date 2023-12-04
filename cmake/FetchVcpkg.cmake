cmake_minimum_required(VERSION 3.15)
include_guard(GLOBAL)

include(FetchContent)

function(fetch_vcpkg)
    set(current_toolchain_file "")
    if(CMAKE_TOOLCHAIN_FILE MATCHES "vcpkg.cmake")
        return()
    else()
        set(current_toolchain_file "${CMAKE_TOOLCHAIN_FILE}")
    endif()

    set(options "")
    set(oneValueArgs "TAG" "BRANCH" "DIR")
    set(multiValueArgs "")
    cmake_parse_arguments(FETCH_VCPKG_ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT FETCH_VCPKG_ARGS_TAG)
        if (NOT FETCH_VCPKG_ARGS_BRANCH)
            set(FETCH_VCPKG_ARGS_TAG "origin/master")
        else()
            set(FETCH_VCPKG_ARGS_TAG "${FETCH_VCPKG_ARGS_BRANCH}")
        endif()
    endif()

    if(NOT FETCH_VCPKG_ARGS_DIR)
        if(NOT FETCH_VCPKG_DIR)
            set(FETCH_VCPKG_ARGS_DIR "${CMAKE_SOURCE_DIR}/vcpkg")
        else()
            set(FETCH_VCPKG_ARGS_DIR "${FETCH_VCPKG_DIR}")
        endif()
    endif()

    FetchContent_Declare(vcpkg
        GIT_REPOSITORY https://github.com/microsoft/vcpkg
        GIT_TAG "${FETCH_VCPKG_ARGS_TAG}"
        SOURCE_DIR "${FETCH_VCPKG_ARGS_DIR}"
        CONFIGURE_COMMAND ""
    )
    FetchContent_MakeAvailable(vcpkg)


    if (NOT "${current_toolchain_file}" STREQUAL "")
        set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${current_toolchain_file}" CACHE STRING "")
    endif()
    set(CMAKE_TOOLCHAIN_FILE "${FETCH_VCPKG_ARGS_DIR}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
endfunction()