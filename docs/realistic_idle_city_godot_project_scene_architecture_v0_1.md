# Realistic Idle City — Godot Project / Scene Architecture v0.1

> Filename retained for replacement convenience. This version updates the architecture note after **Branch 04**.

## 1. Purpose

This document defines the current Godot-side scene/runtime structure for the early playable foundation.

It explains:
- what scenes currently exist
- what autoloads own
- what runtime files are authoritative
- what presentation files merely read and visualize that truth

---

## 2. Current scene stack

Current entry path:
- `scenes/bootstrap/boot_scene.tscn`
- `scenes/world/test_world_scene.tscn`

Current world-scene support is created/ensured by `WorldRootController`:
- `WorldCameraController`
- `AuthoritativeTerrainRenderer`
- `TerrainOverlayRenderer`
- `TerrainOverlayOutlineRenderer`
- `TerrainInspectorPanel`
- `DevHud`
- `WorldCellInspectorProbe`

Important current reality:
- `test_world_scene.tscn` is intentionally very light
- most active scene-side wiring is created by the controller script
- the world scene is a presentation shell, not the authority

---

## 3. Autoload shell

Current autoloads:
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

Current responsibility split:
- `DefinitionRegistry` = static definition loading / validation
- `SimRoot` = resolved bootstrap context + active `WorldState` ownership / access
- `TimeService` = authoritative calendar + deterministic tick/run loop
- world runtime files = authoritative loaded world substrate
- world scene = presentation/dev shell that reads from that substrate

---

## 4. Presentation-vs-authority rule

Current rule:
- the world scene is **not** the authoritative simulation state
- renderers are **not** authoritative terrain truth
- UI panels are **not** authoritative data stores
- runtime world files own cell/chunk/patch/reveal truth
- autoload/runtime services own active session truth

Current authoritative terrain/world path is:
- definitions resolve bootstrap context
- `SimRoot` loads and stores `WorldState`
- `WorldVisibilityService` refreshes reveal/fog state
- presentation scripts query the active world state and render it

---

## 5. Current world scene doctrine

The current world scene is allowed to:
- host the active camera
- render world truth
- render overlay/debug views
- host the HUD and terrain inspector
- host cell hover/select probing
- surface data from runtime/autoload services

The current world scene should **not**:
- become the source of truth for simulation state
- own canonical terrain facts
- own hidden progression state
- implement separate time loops
- duplicate terrain logic that already exists in runtime state

---

## 6. Bootstrap chain rule

The active bootstrap chain should stay definition-driven.

Current intended rule:
- scenario chooses stage + map preset + worldgen profile
- worldgen profile chooses season profile / terrain profile context
- season profile bootstraps initial calendar defaults
- `SimRoot` stores resolved active context
- `TimeService` exposes resolved calendar/run-loop state
- authored map loading builds the authoritative `WorldState`
- the world scene reads that resolved runtime state

Do not replace this with loose hardcoded startup state in scene scripts.

---

## 7. Current runtime flow rule

The deterministic runtime clock belongs to `TimeService`.

Current phase order:
1. command intake
2. time-step start
3. world pre-update
4. simulation update
5. visibility refresh
6. debug snapshot
7. end-of-tick bookkeeping

External systems should subscribe through stable APIs/signals/listeners rather than creating parallel loops in scene code.

Important current architectural note:
- `visibility refresh` now has a proper runtime home
- fog/remembered/visible display is downstream of that runtime phase, not a standalone scene hack

---

## 8. Current world substrate

The active world runtime currently centers on:
- `WorldState`
- `WorldCellState`
- `WorldChunkState`
- `WorldPatchState`
- `WorldRevealSourceState`
- `AuthoredMapLoader`
- `WorldVisibilityService`

That means the architecture has already crossed the important line from:
- “debug picture of a world”
to:
- “real world data that a debug picture reads”

---

## 9. Immediate next architecture concern

The next branch should be a cleanup branch, not a structural reinvention.

The architecture work that matters next is:
- remove stale placeholder-only debris
- keep documentation aligned with current runtime truth
- clean up temp scene artifacts
- preserve the existing clean split between:
  - definitions
  - runtime truth
  - presentation readers

---

## 10. Final position

The project should continue as:
- resource-defined static content
- small autoload/service shell
- deterministic runtime truth outside presentation scenes
- authoritative world runtime objects
- presentation layers that read, render, and inspect that truth
- explicit debug-friendly boundaries

That keeps the project aligned with the realism-first design while remaining practical to build incrementally.
