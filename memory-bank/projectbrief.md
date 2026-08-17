# Project Brief: WLV_Extends

## Core Mission
WLV_Extends (Wolverine Extends Framework) is a Third-Party World of Warcraft Addon framework designed to manage UI Frames easily. It achieves this by providing prefabricated templates and semantic keywords to configure windows, child elements, and layouts.

## Value Proposition
Developing UIs in World of Warcraft is traditionally verbose and heavily reliant on manual boilerplate for frames, anchors, backdrops, and event handling. WLV_Extends simplifies this process by offering intuitive, reusable components with automatic size calculation, anchoring, and layout management. Developers can create complex native-looking interfaces using semantic factory functions instead of raw XML/Lua frame instantiation.

## Problem Solved
- **Boilerplate Reduction:** Eliminates repetitive code required to set up standard UI elements like windows, buttons, and panels.
- **Layout Management:** Solves the difficulty of managing child frames, automatic sizing, and relative anchoring.
- **Consistency:** Ensures addons built with the framework maintain a consistent, "wow-like" aesthetic.

## Non-Negotiable Requirements
1. **XML Manifest Cascade:** The project must strictly follow the XML cascade rule (`001-xml-manifest.md`). Every folder must have an identically named XML file acting as a manifest to load its contents. Frame templates use PascalCase.
2. **Global Variables:** Must follow the standard Lua addon global variable pattern (`002-global-variable.md`). All new Lua files must start with `local addonName, addon = ...` and expose functions/variables on this global table.
3. **Semantic Keywords:** Must expose a clean API of semantic keywords (e.g., `CreateWindow()`, `CreateButton()`) for developers to instantiate templates easily.
4. **Environment:** Must be compatible with WoW Retail (Interface: `110005`).
