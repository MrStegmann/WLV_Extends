# Product Context

## Why this project exists
WLV_Extends was created to bridge the gap between World of Warcraft's raw UI API and modern, component-based UI development. Building interactive windows and menus in WoW often requires deep knowledge of frame strata, points, regions, and backdrops. This framework abstracts these complexities into a library of prefabricated templates, enabling rapid iteration and development of other addons.

## User Personas
- **WoW Addon Developers:** Developers who want to build complex interfaces quickly without wrestling with raw XML or the verbose `CreateFrame` API. They prioritize clean code, rapid prototyping, and a native WoW look and feel.
- **UI/UX Designers (WoW Modding):** Individuals focused on the layout and flow of addons, who benefit from a semantic API (`CreateWindow`, `CreateButton`) that closely matches their design mental model.

## UX Goals
- **Semantic API:** The developer experience should be highly intuitive. Calling `CreateWindow()` should immediately provide a fully functional window with a close button, borders, and a background, ready to accept children.
- **Native Aesthetic:** The generated UI elements should feel native to the World of Warcraft client ("wow-like"), blending seamlessly with the default UI.
- **Automatic Layout:** Developers shouldn't have to manually calculate pixels for every child element. The framework should handle automatic size calculation and relative anchoring when children are appended to a parent.

## Operational Workflows
1. **Dependency:** An addon developer lists `WLV_Extends` as a dependency in their `.toc` file.
2. **Instantiation:** In their Lua code, they use the global API exposed by `WLV_Extends` to create their UI (e.g., `local myWindow = WLV_Extends:CreateWindow()`).
3. **Configuration:** They use chainable or simple setter methods on the created objects to adjust properties (size, text, callbacks) and append child elements.
