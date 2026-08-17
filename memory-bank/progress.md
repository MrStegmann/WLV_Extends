# Progress

## What Works
- Addon skeleton is initialized (`.toc` and root `.xml` manifest exist).
- Custom rules for agent operations are defined (`.agents/rules/`).

## What is In Progress
- Initial architectural setup and project documentation.

## What is Planned
- **Phase 1: Foundation**
  - Implement the `src/` directory tree and XML manifest cascade.
  - Setup the core Lua global variable wrapper.
- **Phase 2: Templates**
  - Create `Window` XML template (borders, background, close button).
  - Create `Button` XML template ("wow-like" texture layout).
- **Phase 3: Factories & Logic**
  - Implement Lua API `CreateWindow()`.
  - Implement Lua API `CreateButton()`.
  - Implement logic for automatic size calculation and relative anchoring when appending children.
- **Phase 4: Advanced Features**
  - Event listeners and callbacks for components.
  - Additional components (ScrollFrames, CheckButtons, Sliders).

## Known Technical Debt
- None yet. The codebase is currently a blank slate. 
- *Future consideration:* Need to ensure that automatic size calculation doesn't cause recursive UI update loops if child elements dynamically resize frequently.
