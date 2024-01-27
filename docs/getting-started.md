# getting started

## build the example first

open `examples/win32_directx9/win32_directx9.vcxproj` in vs2022, pick a
config, hit f5. you should get a window with the demo menu in it — tabs,
subtabs, children, every element, animated. that's the framework running
end to end.

cmake works too:

```
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

## wiring it into your own host

the example's `main.cpp` is the reference. the short version:

1. **host** — win32 window + d3d9 device. steal `CreateDeviceD3D` /
   `CleanupDeviceD3D` / `ResetDevice` from the example, they're standard.

2. **imgui context + backends**

   ```cpp
   ImGui::CreateContext();
   ImGui_ImplWin32_Init(hwnd);
   ImGui_ImplDX9_Init(device);
   ```

3. **fonts** — kanit + icon fonts ship embedded in
   `divinity/assets/fonts/`, compressed. load them into the
   `content_controller.fonts` struct like the example does.

4. **frame loop** — per frame:

   ```cpp
   ImGui_ImplDX9_NewFrame();
   ImGui_ImplWin32_NewFrame();
   ImGui::NewFrame();

   // your menu calls here (see the readme snippet)

   ImGui::Render();
   ImGui_ImplDX9_RenderDrawData(ImGui::GetDrawData());
   ```

5. **input** — forward your wndproc to
   `ImGui_ImplWin32_WndProcHandler` before your own handling, same as any
   imgui app. the window controller toggles off `menu_key` (default
   `VK_INSERT`) and fades itself.

that's it. no registration, no callbacks, just call the controllers every
frame in the order: window → tabs → children → elements.
