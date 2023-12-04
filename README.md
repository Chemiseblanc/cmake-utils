# CMake-utils
An assortment of helpful cmake utilities

## FetchVcpkg.cmake
### Features
- Automatically clone and bootstrap vcpkg when configuring
- Won't run when already building using vcpkg
- If you're using your own toolchain file it will set it via VCPKG_CHAINLOAD_TOOLCHAIN_FILE
- Fixes concerns raised in [vcpkg/pull/27311](https://github.com/microsoft/vcpkg/pull/27311)
### Usage
```cmake
fetch_vcpkg(
    [TAG <git tag>]
    [DIR <directory to clone to>])
```
By default TAG will default to master and DIR will default to ${CMAKE_SOURCE_DIR}/vcpkg.
The directory can also be changed by setting the cache variable FETCH_VCPKG_DIR.

### Example
```cmake
# Assuming FetchVcpkg.cmake is located at ${CMAKE_SOURCE_DIR}/cmake/FetchVcpkg.cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(FetchVcpkg)
fetch_vcpkg(TAG 2023.11.20)

# Top level call to project
project(...)
```