# Realistic City Idle

Current implementation status: **Branch 04 — authoritative world rendering / overlays / fog complete enough to close**

Immediate next working branch: **Branch 05 — audit and cleanup**

Preferred next feature direction after cleanup: **terrain procgen foundation**, starting from the terrain branch plan rather than jumping straight into unrelated gameplay systems.

## Source of truth order
1. Latest user instructions in the active chat
2. Current handoff / session summary
3. Early-game MVP build spec
4. Unified data dictionary
5. Development roadmap
6. Godot implementation / architecture docs
7. Broader design docs when they do not conflict with the current playable scope

## Current implementation snapshot
- Branch 00 boot shell is complete
- Branch 01 definition/data backbone is complete enough to close
- Branch 02 deterministic simulation clock/run-loop backbone is complete enough to close
- Branch 03 authoritative world data + authored-map loading is complete enough to close
- Branch 04 authoritative terrain rendering + overlays + fog/visibility + camera + inspection is complete enough to close
- project boots cleanly into the dev world through `boot_scene.tscn`
- bootstrap resolves from `ScenarioDef -> MapPresetDef / WorldgenProfileDef / SeasonProfileDef -> SimRoot / TimeService`
- current seed pack loads **122** validated definition resources
- `TimeService` owns:
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
- `SimRoot` now owns active world bootstrap context **and** the currently loaded `WorldState`
- authoritative world runtime now includes:
  - `WorldState`
  - `WorldCellState`
  - `WorldChunkState`
  - `WorldPatchState`
  - `WorldRevealSourceState`
  - `AuthoredMapLoader`
  - `WorldVisibilityService`
- the current repo contains **one** authored reference map fixture (`starter_map_balanced.json`) used to prove the runtime and renderer path
- world presentation is now built around:
  - `WorldRootController`
  - `AuthoritativeTerrainRenderer`
  - `TerrainOverlayRenderer`
  - `TerrainOverlayOutlineRenderer`
  - `WorldCameraController`
  - `WorldCellInspectorProbe`
  - `TerrainInspectorPanel`
  - `DevHud`
- current debug overlays include:
  - off
  - elevation
  - drainage
  - wetness
  - vegetation
  - buildability
  - site_score
  - patch_boundaries
  - fog_memory
- dev controls currently exposed include:
  - `F3` HUD toggle
  - `F4` terrain inspector toggle
  - `F5` site-hint toggle
  - `F6` force full visibility toggle
  - `O / Shift+O` overlay cycling
  - camera pan via middle mouse drag / WASD / arrows
  - cell inspect/select via hover + click
- the old placeholder map path should now be treated as retired / disposable
- the immediate next branch should be a cleanup pass before more feature work

## Current playable scope stance
The early game still centers on the lone-survivor-to-small-settlement arc, but progression should be treated as **fluid and condition-driven**, not as rigid hard gates that the player always experiences in a fixed order.

## Current important folders
- `autoload/` cross-scene services only
- `data/defs/` static definition resources and seed content
- `data/world/authored_maps/` authored world fixtures used to prove the authoritative terrain path
- `docs/` design + implementation source-of-truth docs
- `scenes/bootstrap/` boot scene
- `scenes/world/` current dev world scene wrapper
- `scripts/core/defs/` definition resource classes
- `scripts/runtime/` authoritative runtime state, IDs, helpers, loaders, and services
- `scripts/presentation/` world/UI presentation scripts that read runtime truth
- `scripts/sim/` future higher-level simulation systems

## Current autoloads
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

## Current rules
- keep file and folder names in snake_case
- keep node names in PascalCase
- do not hardcode gameplay content into presentation scripts
- keep simulation truth out of arbitrary scene trees
- prefer data-driven definitions and reusable systems
- prefer explicit local typing in bootstrap/runtime shell scripts
- do not add `class_name` to autoload scripts
- do not jump ahead to deep gameplay systems before the active branch says so
- do not treat presentation renderers or HUD panels as hidden authority
- keep cleanup / branch-close work separate from new feature branches when the repo starts to accumulate stale assets, dead files, or doc drift
