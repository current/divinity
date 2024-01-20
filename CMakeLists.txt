cmake_minimum_required(VERSION 3.16)
project(divinity LANGUAGES CXX)

# windows only — the platform/renderer side is win32 + dx9
if(NOT WIN32)
    message(FATAL_ERROR "divinity builds on windows only (win32 + directx 9)")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# vendored dear imgui + the backends the framework drives
add_library(imgui STATIC
    external/imgui/imgui.cpp
    external/imgui/imgui_demo.cpp
    external/imgui/imgui_draw.cpp
    external/imgui/imgui_tables.cpp
    external/imgui/imgui_widgets.cpp
    external/imgui/backends/imgui_impl_dx9.cpp
    external/imgui/backends/imgui_impl_win32.cpp
)
target_include_directories(imgui PUBLIC
    external/imgui
    external/imgui/backends
)

# the framework itself
add_library(divinity STATIC
    divinity/custom.cpp
    divinity/render/animation_controller.cpp
    divinity/render/render_wrapper.cpp
    divinity/ui/window.cpp
    divinity/ui/tab_controller.cpp
    divinity/ui/child_controller.cpp
    divinity/ui/elements/elem_button.cpp
    divinity/ui/elements/elem_checkbox.cpp
    divinity/ui/elements/elem_colorpicker.cpp
    divinity/ui/elements/elem_dropdown.cpp
    divinity/ui/elements/elem_keybind.cpp
    divinity/ui/elements/elem_label.cpp
    divinity/ui/elements/elem_multiselect.cpp
    divinity/ui/elements/elem_slide_select.cpp
    divinity/ui/elements/elem_slider.cpp
    divinity/ui/elements/elem_textinput.cpp
)
target_include_directories(divinity PUBLIC
    divinity
    divinity/ui
    divinity/ui/elements
    divinity/render
    divinity/util
    divinity/theme
    divinity/assets/fonts
    external
)
target_link_libraries(divinity PUBLIC imgui d3d9)

# demo host: win32 window + dx9 device + the full framework wired up
add_executable(divinity_example WIN32
    examples/win32_directx9/main.cpp
)
target_include_directories(divinity_example PRIVATE examples/win32_directx9)
target_link_libraries(divinity_example PRIVATE divinity)
