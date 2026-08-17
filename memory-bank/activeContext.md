# Active Context

## Current Focus
The immediate priority is establishing the foundational architecture and documenting the project via the `memory-bank`. Following this, the focus will shift to creating the XML manifest cascade structure and building the first virtual frame templates (Window and Button).

## Recent Changes
- Initialized the addon with `WLV_Extends.toc` targeting WoW Retail Interface `110005`.
- Created the root manifest `WLV_Extends.xml`.
- Established project rules for XML manifest cascading (`001-xml-manifest.md`) and Lua global variable usage (`002-global-variable.md`).
- Generated the initial `memory-bank` documentation.

## Active Decisions
- **XML Cascade:** Decided to mandate a strict one-folder-one-manifest structure to keep file loading highly organized.
- **Factory Approach:** Decided against raw Frame instantiation by developers; they must use the provided semantic factory methods (e.g., `CreateWindow`) to ensure templates and internal tracking are applied correctly.

## Blockers
- None currently. The environment is set up and ready for initial implementation.

## Next Steps
1. Create the `src/` directory and its corresponding `src.xml` manifest.
2. Set up `src/frames/` and `src/frames/components/` directories with their respective XML manifests.
3. Design and implement the basic XML templates for `Window` and `Button` inside the components folder.
4. Create the core Lua factory file to expose `CreateWindow()` and `CreateButton()`.
