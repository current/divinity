@REM Build for Visual Studio compiler. Run your copy of vcvars32.bat or vcvarsall.bat to setup command-line compiler.
@set OUT_DIR=Debug
@set OUT_EXE=divinity_example
@set INCLUDES=/I..\..\external\imgui /I..\..\external\imgui\backends /I..\..\external /I..\..\divinity /I..\..\divinity\ui /I..\..\divinity\ui\elements /I..\..\divinity\render /I..\..\divinity\util /I..\..\divinity\theme /I..\..\divinity\assets\fonts
@set SOURCES=main.cpp ..\..\divinity\custom.cpp ..\..\divinity\render\*.cpp ..\..\divinity\ui\window.cpp ..\..\divinity\ui\tab_controller.cpp ..\..\divinity\ui\child_controller.cpp ..\..\divinity\ui\elements\elem_*.cpp ..\..\external\imgui\imgui*.cpp ..\..\external\imgui\backends\imgui_impl_dx9.cpp ..\..\external\imgui\backends\imgui_impl_win32.cpp
@set LIBS=d3d9.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD /EHsc %INCLUDES% /D UNICODE /D _UNICODE %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%
