# System Patterns

## System Architecture
The architecture of `WLV_Extends` is heavily reliant on the WoW Addon environment, separated into structural definitions (XML) and behavioral logic (Lua).
- **XML Manifest Cascade:** The project strictly uses XML files as manifests to load the project tree. The root `WLV_Extends.xml` loads child folders' XML files, which in turn load their contents.
- **Component Templates:** UI components (Windows, Buttons) are defined as virtual templates in XML files (e.g., `src/frames/components/WindowTemplate.xml`).
- **Global Table:** Lua functionality is exposed through a centralized global variable `_G.WLV_Extends` (initialized via `local addonName, addon = ...`).

## Component Relationships
- **Templates (XML):** Define the visual structure, default anchors, strata, and regions of UI elements. They are marked as `virtual="true"`.
- **Factories (Lua):** Provide semantic methods like `addon:CreateWindow()` which utilize the WoW API `CreateFrame("Frame", nil, parent, "TemplateName")` to instantiate the virtual XML templates.
- **Parent-Child Hierarchy:** Frames created via the API maintain parent-child relationships. The framework provides methods to automatically calculate the parent's size based on the aggregate bounds of its appended children, and handles relative anchoring dynamically.

## Design Patterns
- **Factory Pattern:** Abstracting the verbose `CreateFrame` API behind semantic functions (`CreateWindow`, `CreateButton`).
- **Namespace Pattern:** All variables and functions are scoped within the addon's global table to prevent global namespace pollution.
- **Mixins (Expected):** Using Lua mixins or prototype tables to attach methods (e.g., `:SetText()`, `:AppendChild()`) to the instantiated frames for chainable configurations.

## Tech Stack Choices
- **World of Warcraft Addon API (Retail 110005):** The target platform.
- **XML (WoW UI Schema):** Used for structural templates and manifest loading.
- **Lua 5.1 (WoW Flavor):** Used for logic, API implementation, and state management.
