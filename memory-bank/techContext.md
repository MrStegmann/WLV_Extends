# Technical Context

## Languages and Frameworks
- **Lua 5.1:** The primary scripting language used by World of Warcraft. Note that WoW's Lua environment lacks standard OS libraries (like `os` or `io`) and introduces many custom Blizzard APIs.
- **XML:** Used for UI definitions. Must adhere to the Blizzard UI schema (`http://www.blizzard.com/wow/ui/`).
- **WoW Frame API:** The underlying framework. Key concepts include Frames, Regions (Textures, FontStrings), Anchors (Points), Strata, and Levels.

## Key Libraries & Dependencies
- **None currently:** `WLV_Extends` is designed to be a standalone library/framework for other addons to depend on. It relies purely on the standard WoW Client API.

## Development Setup
- **Directory Location:** Must reside within `.../_retail_/Interface/AddOns/WLV_Extends`.
- **Entry Points:** 
  - `WLV_Extends.toc`: The Table of Contents file read by the WoW client to discover the addon, its saved variables, and its primary entry file.
  - `WLV_Extends.xml`: The root manifest file loaded by the `.toc`, responsible for cascading loads of all source files.

## Build and Run Scripts
- There are no automated build scripts (like Node or Python).
- **Execution:** The addon is loaded when the World of Warcraft client boots or when the `/reload` UI command is issued in-game.

## Hardware & API Constraints
- **Sandboxed Environment:** File I/O is restricted to the SavedVariables API (which only writes on logout/reload). No network access outside of Blizzard's secure communication channels.
- **Performance:** Lua execution happens on the main UI thread. Heavy calculations or infinite loops will freeze the game client. UI updates should be event-driven.
- **Global Namespace:** Variables not explicitly declared `local` leak into the global environment `_G`, potentially breaking the entire game UI. Strict adherence to the `addon` table pattern is required.
