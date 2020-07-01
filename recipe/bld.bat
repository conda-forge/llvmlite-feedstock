@rem Let CMake know about the LLVM install path, for find_package()
set CMAKE_PREFIX_PATH=%LIBRARY_PREFIX%

@rem set ZLIB_ROOT_DIR=%LIBRARY_PREFIX%
@rem set LLVM_CONFIG=%LIBRARY_PREFIX%\bin\llvm_config.exe
set CMAKE_GENERATOR=Visual Studio 15 2017 Win64
@rem set ZLIB_NAME=zlib
@rem set ZLIB_LIBRARY_PATH=%LIBRARY_LIB%
@rem set ZLIB_INCLUDE=%LIBRARY_INC%
@rem set LLVM_ENABLE_ZLIB=ON
@rem set PREFIX=%LIBRARY_PREFIX%
set "LDFLAGS=%LDFLAGS% /LIBPATH:%LIBRARY_LIB%"

@rem set verbose mode for debugging
set VERBOSE=1

@rem Ensure there are no build leftovers (CMake can complain)
if exist ffi\build rmdir /S /Q ffi\build

%PYTHON% -S setup.py install
if errorlevel 1 exit 1

%PYTHON% runtests.py
if errorlevel 1 exit 1


