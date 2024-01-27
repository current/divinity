# element reference

everything hangs off `_child.child_elem` (a `child_elements_t`, declared in
`divinity/ui/window.hpp`, implemented one file per element in
`divinity/ui/elements/`). call them inside a child's content lambda — the
child controller handles layout, spacing and scrolling.

| method | signature | notes |
| --- | --- | --- |
| `label` | `(const std::string& label)` | static text |
| `button` | `(const std::string& label, std::function<void()> on_click)` | fires on click |
| `checkbox` | `(const std::string& label, bool* variable)` | animated check |
| `slider` | `(const std::string& label, float* v, float min, float max, std::string format = "%.2f")` | float |
| `slider` | `(const std::string& label, int* v, int min, int max, std::string format = "%")` | int overload |
| `slide_select` | `(const std::string& label, int* v, std::vector<std::string> options)` | sliding selector |
| `dropdown` | `(const std::string& label, int* v, std::vector<std::string> items)` | animated popup |
| `multiselect` | `(const std::string& label, std::vector<bool>* v, std::vector<std::string> items)` | toggles per item |
| `keybind` | `(const std::string& label, int* v)` | captures a vk code |
| `color_picker` | `(const std::string& label, float* rgba[4], bool show_alpha_bar)` | inline picker |
| `text_input` | `(const std::string& label, std::string* v)` | text field |

notes:

- colors are `float[4]` rgba 0..1. `color_pallete::accent` is the default
  highlight; swap the palette to re-theme everything at once.
- animation state (hover, open, fade) lives per element in the controllers —
  you don't manage any of it.
- want a new element? copy `elem_label.cpp`, it's the smallest, and follow
  the shape: read `context`, animate, draw via `render_wrapper`, eat input.
