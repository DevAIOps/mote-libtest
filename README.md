A really simple test framework, only the macro header file needed. Copy this file to your source code or c standard include path, such as `/usr/include`.

And also some useful tools.

# Code Coverage

Copy `contrib/cmake/CodeCoverage.cmake` to CMake modules path, such as `/usr/share/cmake-X.YY/Modules`, or set `CMAKE_MODULE_PATH` variable.

```
IF(${WITH_CONVERAGE})
	SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/contrib/cmake)
	INCLUDE(CodeCoverage)

	SET(COVERAGE_EXCLUDES "'/usr/lib/*'" "'${CMAKE_SOURCE_DIR}/deamon/tests/*'" "'*mock*'")
	SETUP_TARGET_FOR_COVERAGE(coverage ctest covdir)
ENDIF()
```

Then execute `make coverage` to generate the coverage result. And check the result through simple python http server.

```
----- python2
$ python -m SimpleHTTPServer 8080
----- python3
$ python3 -m http.server -d covdir 8080
```

# Valgrind

Copy `contrib/wrapper.sh` to `/opt` and also set CMake test as following.

```
ADD_TEST(NAME test-foobar COMMAND ${WRAP_CMD} ./test arg)
```

Then complie with `cmake -DWRAP_CMD=/opt/wrapper.sh`.

