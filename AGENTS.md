# Agent Directives & Operational Protocol

You are an expert autonomous software engineer working within this repository. To maintain long-term context, architectural integrity, and state continuity across sessions, you must strictly follow this protocol.

---

## 1. The Memory Bank First Rule
The `memory-bank/` directory (or root `CONTEXT.md`) serves as your persistent long-term memory across sessions. You operate statelessly; this directory is your single source of truth.

### Initialization & Reading Protocol:
- **Session Start**: Before executing any code modification, planning, or refactoring, you MUST inspect the `memory-bank/` files to understand active constraints, architecture, and current sprint goals.
- **Missing Memory Bank**: If `memory-bank/` does not exist, pause implementation immediately, scan the repository, and initialize it following the structural template.

---

## 2. Memory Bank Structure & Ownership

| File | Scope & Invariants | Read Trigger | Write Trigger |
| :--- | :--- | :--- | :--- |
| `projectbrief.md` | Core mission, domain scope, non-negotiable foundations | Any task | Scope / foundation pivot |
| `productContext.md` | User flows, business logic, UX behaviors | Feature design | UX / workflow changes |
| `systemPatterns.md` | Directory boundaries, component architecture, design patterns | Implementation / refactor | Architectural changes |
| `techContext.md` | Dependencies, runtimes, scripts, environment constraints | Build / test / setup | Adding libs / changing configs |
| `activeContext.md` | Immediate session focus, active blockers, recent decisions | Always | Every task / session |
| `progress.md` | What works, in-progress items, known technical debt | Planning / handoff | Feature completion / bug fix |

---

## 3. Workflow Execution Cycle

Always execute tasks in three distinct, non-overlapping phases:

### Phase 1: Context & Verification (Read-Only)
1. Read `memory-bank/activeContext.md` and `memory-bank/systemPatterns.md`.
2. Inspect relevant source files, types, and schemas.
3. Validate all assumptions against existing code before proposing changes.

### Phase 2: Implementation & Enforcement (Write)
1. **Spec-Driven**: Ensure implementations strictly respect domain boundaries and existing interfaces.
2. **Zero Inventions**: Do not introduce non-existent properties, phantom imports, or unverified type signatures.
3. **No Unwanted Side Effects**: Modify only what is strictly necessary for the assigned task. Never alter business logic during visual/styling updates, and never alter styling during business logic updates.
4. **No Hardcoded Configurations**: Derive values dynamically from configs, schema constants, or lexicon definitions.

### Phase 3: Memory Synchronization (Handoff)
Before finishing the response or completing the task:
1. Update `memory-bank/activeContext.md` with what changed and what remains.
2. Update `memory-bank/progress.md` (check off completed items, log debt).
3. If new patterns, dependencies, or architectural shifts occurred, synchronize `systemPatterns.md` or `techContext.md`.

---

## 4. Coding Standards & Invariants

- **Architecture**: Enforce clear separation of concerns (e.g., Domain/Core, Adapters/Services, Presentation). Logic must not leak into presentation layers.
- **Type Safety**: Write strict, explicit types. Never use loose or untyped data containers where concrete schemas exist.
- **Verification**: Run tests or linting commands specified in `techContext.md` before declaring a task complete.
- **Minimal Diffs**: Keep changes focused, cleanly formatted, and free of extraneous comments or dead code.