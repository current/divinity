# divinity

A menu framework for C++ built on top of [Dear ImGui](https://github.com/ocornut/imgui). Runs on Win32 and DirectX 9.

The framework was written as contract work. The client broke the terms of the agreement, so the deal is off and the code is public. It was built for one specific product, so a few choices in it are opinionated, but the core is a general purpose menu framework. Take it apart, learn from it, build your own thing on it.

imgui already covers widgets. What it does not cover is everything around them when the goal is a real menu: the render layer, the window, moving between pages, the state each part of the UI needs. divinity sits one level above imgui and provides those parts.

## Features

Compared to writing the menu directly against imgui, divinity gives you:

- A render wrapper that draws rects, outlines, gradients, circles, arcs, text and clipped regions into any imgui draw list
- A window controller that handles the toggle key, fade in and out on open and close, dragging by the header, edge resize and min size
- A tab controller with subtabs, per subtab alpha crossfade, content passed in as lambdas
- A child controller that groups panes with placement (top left, top right and so on) and sizing modes, with scrolling
- An element API: checkbox, slider (int and float), dropdown, multiselect, keybind, color picker, slide select, text input, button, label. All custom drawn, all animated
- An animation controller that provides the easing behind all of the above
- Theming through one `color_pallete` struct that gets threaded through everything, swap it to re-theme

## Layout

```
divinity/                 the framework
├── divinity.hpp          umbrella header, include this and go
├── custom.hpp/.cpp       older widget prototypes (kept around, still handy)
├── ui/                   window, tab + child controllers, element api
│   └── elements/         one file per element
├── render/               render wrapper + animation helpers
├── theme/                color_pallete
├── util/                 shared contexts, misc
└── assets/fonts/         kanit + icon fonts, embedded as compressed ttf

examples/win32_directx9/  full working host: win32 window, dx9 device,
                          fonts loaded, framework wired up, demo page
external/                 vendored deps: dear imgui 1.89.5-wip, tinyformat
docs/                     getting started + element reference
```

## Usage

The whole menu is three nested lambdas. From the example:

```cpp
_window.begin_new_frame("divinity", pos, size, [&] {
    _tab_controler.begin([&] {
        _tab_controler.add_tab("settings", &tab, {
            subtab_t{ 0, "general", [&] {
                _child.begin([&] {
                    _child.add_child("interface", e_child_top_left, e_child_size_full, [&] {
                        _child.child_elem.checkbox("enabled", &enabled);
                        _child.child_elem.slider("opacity", &opacity, 0.f, 100.f);
                        _child.child_elem.keybind("toggle hotkey", &key);
                        _child.child_elem.color_picker("accent", accent, true);
                    });
                });
            }, &stab },
        });
    });
});
```

There is no scene graph and no widget state to manage. You call the controllers every frame, in the same order, and the menu draws. That is the entire contract.

For the full host setup refer to [docs/getting-started.md](docs/getting-started.md), for the element API refer to [docs/elements.md](docs/elements.md).

## Building

Open `examples/win32_directx9/win32_directx9.vcxproj` (or the sln) in Visual Studio 2022 and build. Or:

```
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

There is also `examples/win32_directx9/build_win32.bat` if you build with cl.exe from a developer prompt. Everything links against `d3d9` from the Windows SDK, no DirectX SDK needed.

## Vendored ImGui

Dear ImGui 1.89.5-WIP lives in `external/imgui/`. It is a pinned snapshot because the framework uses imgui internal headers, and those change between versions. The win32 and dx9 backends are kept (dx11 too, for later), the rest was trimmed. Upstream documentation ships in `external/imgui/docs/`, the [FAQ](external/imgui/docs/FAQ.md) is worth reading.

## License

MIT, see [LICENSE](LICENSE). Dear ImGui is copyright Omar Cornut and is vendored unmodified in `external/imgui/` under the same license.
