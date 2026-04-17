# Realistic Idle City — Godot Bootstrap / First Sprint Implementation Plan v0.2

> Filename retained for replacement convenience. This version now reflects the project **after Branch 04** and reframes Sprint 1 as effectively complete enough to close, with one short cleanup branch next.

## 1. Purpose

This document describes what Sprint 1 was meant to establish on the Godot side and what is now actually in place.

Sprint 1 was the “make the project technically buildable” sprint, not the “make the full game” sprint.

That meant the sprint had to prove:

- a clean Godot bootstrap shell
- data-driven startup resolution
- deterministic time/run-loop scaffolding
- authoritative world-state scaffolding
- a real render/inspect path for that world truth
- enough debug surface to safely continue development

---

## 2. Current Sprint 1 status

### Status summary
- **Branch 00 — complete**
- **Branch 01 — complete enough to close**
- **Branch 02 — complete enough to close**
- **Branch 03 — complete enough to close**
- **Branch 04 — complete enough to close**
- **Immediate next branch: Branch 05 — audit and cleanup**

### Practical reading
Sprint 1's main technical objective has been achieved.

The project is no longer just a bootstrap shell:
- it resolves definitions
- it runs deterministically
- it loads authored terrain into authoritative runtime state
- it renders and inspects that world state in a usable way

That means the next step should be a cleanup / closeout branch, not another big feature pile-on.

---

## 3. What Sprint 1 now proves

### 3.1 Bootstrap and definitions
The project already proves:
- boot scene entry works
- autoload shell is in place
- definition loading and validation works
- scenario / map preset / worldgen / season resolution works
- failure cases are surfaced in a readable way

### 3.2 Deterministic runtime backbone
The project already proves:
- `TimeService` owns deterministic ticking
- phase order is explicit
- pause / resume / speed / single-step controls exist
- queued commands and scheduled triggers are processed deterministically
- visibility refresh has a proper phase home
- debug determinism inspection exists

### 3.3 Authoritative world substrate
The project already proves:
- world state exists outside presentation scenes
- authored map data can be loaded into runtime truth
- cells, chunks, patches, and reveal sources exist as real runtime structures
- terrain/buildability/site-related facts can be read from runtime state
- later systems have a trustworthy substrate to build on

### 3.4 Authoritative rendering and reading path
The project already proves:
- terrain can render from authoritative world truth
- overlays can render from authoritative values
- patch boundaries can be visualized
- fog / remembered / visible state can be shown
- the camera can move around the world cleanly
- the user/developer can inspect cells and read why a tile is the way it is

---

## 4. Actual current implementation baseline

## 4.1 Entry chain
Current entry path:
- `scenes/bootstrap/boot_scene.tscn`
- `scenes/world/test_world_scene.tscn`

## 4.2 Active autoload shell
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

## 4.3 Authoritative world runtime currently in use
- `WorldState`
- `WorldCellState`
- `WorldChunkState`
- `WorldPatchState`
- `WorldRevealSourceState`
- `AuthoredMapLoader`
- `WorldVisibilityService`

## 4.4 Presentation stack currently in use
`WorldRootController` now ensures:
- `WorldCameraController`
- `AuthoritativeTerrainRenderer`
- `TerrainOverlayRenderer`
- `TerrainOverlayOutlineRenderer`
- `TerrainInspectorPanel`
- `DevHud`
- `WorldCellInspectorProbe`

## 4.5 Current debug / reading surface
Current active debug reading path includes:
- HUD summary and help
- overlay mode state
- overlay legend text
- visibility counts
- camera snapshot
- hovered / selected cell info
- terrain inspector panel
- world snapshot data from `SimRoot`

---

## 5. Branch-by-branch Sprint 1 reading

## Branch 00 — repo bootstrap
### Status
Complete.

### Delivered
- project shell
- autoload base
- initial boot/dev scenes
- initial debug HUD
- initial placeholder renderer path

### Why it is not the current truth anymore
The placeholder renderer path was a starting scaffold, not the intended long-term world architecture.

---

## Branch 01 — core definitions and IDs
### Status
Complete enough to close.

### Delivered
- typed definition resources
- registry/validation
- bootstrap resolution
- canonical content pack foundation

### Why it mattered
It made later branches data-driven instead of hardcoded.

---

## Branch 02 — simulation clock and run loop
### Status
Complete enough to close.

### Delivered
- deterministic phase loop
- command queue
- scheduled triggers
- debug stepping / pause / speed controls
- deterministic inspection surface

### Why it mattered
It created the runtime backbone that later world systems can plug into safely.

---

## Branch 03 — authoritative world data + authored maps
### Status
Complete enough to close.

### Delivered
- world runtime state objects
- authored map loader
- authored fixture path
- patch summaries
- reveal source loading
- visibility service binding
- `SimRoot` world registration and accessors

### Why it mattered
This is where the project stopped pretending the scene tree itself was the world.

---

## Branch 04 — renderer + overlays + camera + fog
### Status
Complete enough to close.

### Delivered
- authoritative terrain renderer
- overlay renderer
- outline renderer
- camera controller
- world cell probe
- terrain inspector panel
- richer HUD integration
- fog / remembered / visible presentation path

### Why it mattered
This branch proved the Branch 03 world data is actually practical to use and inspect.

---

## 6. Sprint 1 exit criteria review

### Exit criterion: clean bootstrap shell
Met.

### Exit criterion: data-driven startup path
Met.

### Exit criterion: deterministic tick backbone
Met.

### Exit criterion: authoritative world substrate
Met.

### Exit criterion: render and inspect that world truth
Met.

### Exit criterion: adequate debug visibility for continued development
Met.

### Exit criterion: “enough to continue into terrain/system work safely”
Met.

### Remaining closeout item
A short explicit cleanup branch is still recommended before continuing.

---

## 7. Immediate next branch

## Branch 05 — audit-and-cleanup
### Goal
Close Sprint 1 cleanly and prepare the repo for the next feature track.

### Must include
- document sync after Branch 03–04
- cleanup of stale placeholder references
- cleanup of obvious temp/stray scene artifacts
- verify current scene/runtime responsibility docs
- verify README / roadmap / changelog / architecture docs all agree
- optional brief manual verification note for the closeout

### Must not become
- a stealth new feature branch
- a “while we are here” mega-branch
- a rewrite of already-working runtime boundaries

### Exit criteria
- repo is cleaner than before the branch started
- documentation matches the codebase
- no obvious dead placeholder debris remains
- next feature branch can start from a stable handoff point

---

## 8. Preferred next feature direction after cleanup

The preferred next feature direction after Branch 05 is:

## Terrain procgen foundation
Follow `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md`.

That is the safest next move because:
- the authoritative terrain substrate exists
- the overlay/debug tooling exists
- the project now has the exact calibration/debug environment procgen needed

This is a better next step than skipping ahead to broader gameplay/NPC systems on top of a still-maturing world foundation.

---

## 9. Guardrails

- do not move world authority back into presentation scripts
- do not grow HUD panels into hidden state owners
- do not re-open closed branch scopes unless a real bug requires it
- keep the cleanup branch intentionally short and explicit
- continue using authored truth + overlays as the calibration baseline for later procgen work

---

## 10. Final position

Sprint 1 did what it needed to do.

The project now has:
- a functioning bootstrap shell
- validated definitions
- deterministic runtime scaffolding
- authoritative world state
- authoritative world rendering and inspection

That means the right next step is to **close the sprint cleanly**, then move into the next terrain-focused feature track from a tidier baseline.
