---
trigger: always_on
---

---
name: "Global Variables"
description: "Ensure AI Agent use global variable to extend functions and variables from files among all project. Addons works with a Global variable `_G.` to expose and use functions and variables define in isolate files."
globs: `src/**/*.lua`
---

# Global Variables in WoW Addons Ecosystem
WoW Addons instead use standar lua export, use global variables defined by the ecosystem by using `local addonName, addon = ...` at top of the file.

* **New Lua files:** All new files created must start (MANDATORY) with `local addonName, addon = ...` and initializate a global variable inside addon global variable with the name of the file.
Example:
```lua
-- This file has recently create and named as utils.lua
local addonName, addon = ...

addon.Utils = {}
local Utils = addon.Utils

```

* **Standar usage of global variable:**
  * **Functions:** must be declare inside the global variable by using ":". Example:
Example:
```lua
-- This file is the continue of utils.lua. Above it is defined the global.

function Utils:Print(msg)
    print("|cff33ff99[" .. addonName .. "]|r " .. tostring(msg))
end
```
  * **Variables:** must be declare inside the global variable by using ".". Example:
Example:
```lua
-- This file is the continue of utils.lua. Above it is defined the global.

Utils.PREFIX_COLOR = "|cff33ff99"
```