# RealisticCityIdle — Branch 05 detailed audit and cleanup plan
_Date:_ 2026-04-17  
_Source of truth audited:_ current Branch 05 closeout working copy

> **Status update:** The items in this audit were used to guide Branch 05. The branch is now considered **complete enough to close**. Keep this file as the historical audit input, but use `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md` for the next branch.

## Branch 05 closeout summary

The core conclusions from the audit still stand:

- the project did **not** need a rewrite
- the right move was a focused hardening / cleanup pass
- authored-world runtime truth was a strong enough base to preserve
- the next correct implementation step after cleanup is procedural terrain generation

### Closeout results reflected in the current repo
- placeholder/dead-path leftovers removed from the active repo
- temp scene artifacts removed
- several oversized responsibilities split into dedicated helper scripts
- implementation-facing docs synced to the real codebase
- the project remains data-driven and expandable without needing a large pre-procgen refactor

## Historical note

The remainder of the original audit remains useful as rationale, but it should now be read as **completed branch guidance**, not active todo work.

---

## 1. Executive verdict

The project is still in a **good architectural state overall**. It does **not** look like it needs a rewrite before continuing. The main foundations are still healthy:

- content is largely definition/resource driven (`data/defs`)
- runtime state is separated from presentation
- authored map data flows through a dedicated loader into authoritative world state
- the renderer reads runtime truth instead of a fake decorative path
- docs are broadly in sync with the current Branch 05 closeout state

So the right move was **not** “big refactor first.”  
The right move was a **Branch 05 hardening / cleanup pass** that removed drift and locked down data boundaries before terrain procgen starts.

## 2. What currently looks good

### 2.1 Architecture direction is still sound
The repo still has a clear high-level split between:
- definitions/content
- runtime state/services
- presentation/debug UI

That remains the correct direction for a future-proof simulation game.

### 2.2 The data-driven foundation is real
Healthy signs remain:
- scenarios, map presets, season profiles, incidents, structures, processes, items, worldgen profiles etc. are externalized
- `DefinitionRegistry` centralizes loading/validation
- `WorldState`, `WorldCellState`, `WorldPatchState`, and reveal-source state form a real runtime model
- authored map data converts into authoritative world cells rather than only driving visuals

### 2.3 The codebase is still salvageable without pain
The larger scripts identified by the audit were good cleanup targets, but they were still manageable.
Branch 05 reduced that pressure enough to move forward.

## 3. What to do next

Do **not** keep extending this audit branch.

The next practical step is:
- commit the Branch 05 closeout/docs sync
- push the branch
- create the next branch for procedural terrain generation foundation
- follow the new procgen implementation plan
