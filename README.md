# Realistic City Idle

Current implementation status: **Branch 02 — simulation clock and run loop complete enough to close**

Next planned branch: **Branch 03 — world data model + hand-authored maps**

## Source of truth order
1. Latest user instructions in the active chat
2. Current handoff summary
3. Early-game MVP build spec
4. Unified data dictionary
5. Development roadmap
6. Godot implementation/architecture docs
7. Broader design docs when they do not conflict with the early-game MVP

## Current implementation snapshot
- Branch 00 boot shell is complete
- Branch 01 definition/data backbone is complete enough to close
- Branch 02 deterministic simulation clock/run-loop backbone is complete enough to close
- project boots cleanly into the dev world
- bootstrap resolves from `ScenarioDef -> WorldgenProfileDef -> SeasonProfileDef -> TimeService`
- `DefinitionRegistry` validates IDs and cross-references on startup
- current seed pack loads **122 definitions**
- `TimeService` now owns:
  - deterministic tick progression
  - pause / resume
  - speed controls
  - single-step debug
  - stable phase order
  - calendar state exposure
  - scheduled-trigger queue
  - queued-command queue
  - deterministic debug signature
- current phase order is:
  1. command intake
  2. time-step start
  3. world pre-update
  4. simulation update
  5. visibility refresh
  6. debug snapshot
  7. end-of-tick bookkeeping
- debug HUD now shows scenario/bootstrap state, calendar state, run-loop state, phase visibility, trigger/command queues, and determinism debug data
- debug HUD is scrollable so the full Branch 02 surface remains visible at runtime
- placeholder world rendering/debug terrain view still exists and is intentionally temporary
- an external debug scheduled-trigger probe exists to prove the Branch 02 trigger/command boundary works from outside `TimeService`

## Current playable target
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

## Current important folders
- `autoload/` cross-scene services only
- `data/defs/` static definition resources and seed content
- `docs/` design + implementation source-of-truth docs
- `scenes/bootstrap/` boot scene
- `scenes/world/` current dev world scene
- `scripts/core/defs/` definition resource classes
- `scripts/runtime/` shared runtime state, IDs, helpers, and Branch 02 debug/runtime support
- `scripts/presentation/` temporary world/UI presentation scripts
- `scripts/sim/` future authoritative simulation runtime

## Current autoloads
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

## Rules
- keep file and folder names in snake_case
- keep node names in PascalCase
- do not hardcode gameplay content into presentation scripts
- keep simulation truth out of arbitrary scene trees
- prefer data-driven definitions and reusable systems
- prefer explicit local typing in bootstrap/runtime shell scripts
- do not add `class_name` to autoload scripts
- do not jump to deep gameplay before the branch roadmap says so
- do not treat the placeholder world renderer as authoritative world state
