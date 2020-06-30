@rem Let CMake know about the LLVM install path, for find_package()
set CMAKE_PREFIX_PATH=%LIBRARY_PREFIX%
set ZLIB_ROOT_DIR=%LIBRARY_PREFIX%
set LLVM_CONFIG=%LIBRARY_PREFIX%\bin\llvm_config.exe
set CMAKE_GENERATOR=Visual Studio 15 2017 Win64
set ZLIB_NAME=zlib
set ZLIB_LIBRARY_PATH=%LIBRARY_LIB%
set ZLIB_INCLUDE=%LIBRARY_INC%
SET LIBPATH=%LIBRARY_LIB%
set LLVM_ENABLE_ZLIB=ON
set PREFIX=%LIBRARY_PREFIX%
set "LDFLAGS=%LDFLAGS% /LIBPATH:%LIBRARY_LIB%"

@rem set verbose mode for debugging
set VERBOSE=1

@rem Ensure there are no build leftovers (CMake can complain)
if exist ffi\build rmdir /S /Q ffi\build

llvm-config.exe --libs

@rem %PYTHON% -S setup.py install
@rem Trying to invoke cmake directly
mkdir build
cd build
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ../ffi/
cmake --DCMAKE_VERBOSE_MAKEFILE:BOOL=ON --build ../ffi/ --config Release --verbose
if errorlevel 1 exit 1

%PYTHON% runtests.py
if errorlevel 1 exit 1
