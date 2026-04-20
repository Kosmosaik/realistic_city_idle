# Realistic Idle City — Godot Project / Scene Architecture v0.1
_Last synced:_ 2026-04-17

## 1. Purpose

This document describes the current implementation-facing scene/script architecture after the Branch 05 cleanup pass.

It focuses on:
- how bootstrapping currently flows
- where runtime authority lives
- how presentation/debug layers consume that runtime truth
- where the next procedural terrain branch should connect

---

## 2. Current architecture snapshot

The active runtime path is now:

`BootScene`  
→ resolves `SimRoot`, `DefinitionRegistry`, `TimeService`, and other autoload services  
→ resolves active scenario/stage/map/worldgen/season definitions  
→ builds `WorldState` from the active definitions  
→ binds world services/state into presentation consumers  
→ world renderers / overlays / HUD / terrain inspector read from runtime truth

This is the correct foundation for the next branch.

---

## 3. Runtime authority

### 3.1 `SimRoot`
`SimRoot` is the current top-level bootstrap/runtime coordinator.

It is responsible for:
- holding active definition IDs
- coordinating bootstrap resolution
- building/owning the active `WorldState`
- exposing hovered/selected debug cell state
- exposing overlay/debug mode state for presentation consumers

It should continue orchestrating high-level flow, but it should **not** absorb full procedural generator internals.

### 3.2 `WorldState`
`WorldState` is the world authority for the current local map.

It holds:
- cell state
- patch state
- chunk state
- reveal sources
- authored terrain object records
- generation warnings/debug snapshots

Renderers and debug UIs should continue reading from this shared world truth.

---

## 4. Scene / script role map

## 4.1 Boot and autoload layer
- `autoload/sim_root.gd` — main runtime coordination and world-state lifecycle
- `autoload/definition_registry.gd` — definition loading/validation
- `autoload/time_service.gd` — time/season/tick orchestration
- `scripts/core/boot_scene.gd` — startup scene entry point
- `scripts/core/boot_defaults.gd` — default boot identifiers/fallback values

## 4.2 Runtime world layer
- `scripts/runtime/world/world_state.gd`
- `scripts/runtime/world/world_cell_state.gd`
- `scripts/runtime/world/world_patch_state.gd`
- `scripts/runtime/world/world_chunk_state.gd`
- `scripts/runtime/world/world_reveal_source_state.gd`

## 4.3 Authored world build path
- `scripts/runtime/world/authored_map_loader.gd`
- `scripts/runtime/world/authored_map_fixture_validator.gd`
- `scripts/runtime/world/authored_map_stamp_applicator.gd`
- `scripts/runtime/world/authored_reveal_source_loader.gd`
- `scripts/runtime/world/authored_terrain_object_loader.gd`

This path should remain intact as the authored-world reference implementation.

## 4.4 Presentation / debug layer
- `scripts/presentation/world/authoritative_terrain_renderer.gd`
- `scripts/presentation/world/terrain_overlay_renderer.gd`
- `scripts/presentation/world/terrain_overlay_outline_renderer.gd`
- `scripts/presentation/world/terrain_debug_visual_config.gd`
- `scripts/presentation/ui/dev_hud.gd`
- `scripts/presentation/ui/dev_hud_text_formatter.gd`
- `scripts/presentation/ui/terrain_inspector_panel.gd`
- `scripts/presentation/sim_root_locator.gd`

---

## 5. What is no longer part of the active architecture

The retired placeholder-world path is no longer part of the active intended architecture.

Interpret any old references to placeholder map rendering as:
- historical scaffold only
- not the current source of truth
- not the correct place to extend new systems from

Also:
- temp `test_world_scene.tscn*.tmp` files are not part of the repo architecture and should stay out

---

## 6. Architectural rule for the next branch

The next branch should add a **second world-build path**, not replace the first one.

Recommended structure:
- authored maps continue through `AuthoredMapLoader`
- procedural maps go through a new procedural world-build orchestrator
- both paths output the same `WorldState` structure
- renderers/HUD/inspector stay agnostic about where the world came from

This is the key architecture rule that keeps the project future-proof.

---

## 7. Presentation/debug expectations

Presentation-side systems should continue to:
- read debug selection/hover state from `SimRoot`
- read world truth from `WorldState`
- read overlay-mode metadata from `TerrainDebugVisualConfig`
- avoid maintaining parallel gameplay truth

The recent overlay-mode fixes only reinforce this rule:
visual controls should stay synchronized because they share the same debug state source.

---

## 8. Immediate next connection point

Branch 06 procedural terrain generation should connect at the world-build step currently owned by `SimRoot.build_world_state_from_active_definitions()`.

That is the correct integration seam.

The new branch should:
- preserve the authored load path
- choose authored vs procedural build mode from definitions
- build the world before presentation consumers initialize against it

---

## 9. Final note

The current architecture is clean enough to move forward.
The right next move is procedural terrain generation through a new world-build path, not a broad scene/script rewrite.
