# Realistic Idle City — Godot Class / File Responsibility Matrix v0.1
_Last synced:_ 2026-04-17

## 1. Purpose

This file describes the intended responsibility boundaries of the current implementation-facing scripts.

It is not an exhaustive list of every definition resource or scene file.
It focuses on the scripts most likely to matter when extending the runtime, bootstrap, renderer, and debug stack.

---

## 2. High-level responsibility layers

### Definitions / content schema
- `scripts/core/defs/*`
- `data/defs/*`

### Bootstrap / orchestration
- `autoload/sim_root.gd`
- `autoload/definition_registry.gd`
- `autoload/time_service.gd`
- `scripts/core/boot_scene.gd`
- `scripts/core/boot_defaults.gd`

### Runtime world / simulation state
- `scripts/runtime/world/*`
- `scripts/runtime/time/*`

### Presentation / inspection / overlays
- `scripts/presentation/world/*`
- `scripts/presentation/ui/*`
- `scripts/presentation/sim_root_locator.gd`

---

## 3. Primary file responsibility matrix

| File | Responsibility | Notes |
|---|---|---|
| `autoload/sim_root.gd` | central runtime bootstrap state, active definition IDs, world-state lifecycle, debug selection/overlay state | should orchestrate, not absorb generator internals |
| `autoload/definition_registry.gd` | load and validate definition resources | remains the definition authority |
| `autoload/time_service.gd` | game time orchestration, season/day/tick state, time-driven event execution | large, but improved by helper extraction |
| `scripts/core/boot_scene.gd` | boot flow entry scene; resolves services and starts runtime bootstrap | should stay thin and explicit |
| `scripts/core/boot_defaults.gd` | central default bootstrap IDs and boot fallback values | prevents default IDs scattering |
| `scripts/core/defs/map_preset_def.gd` | map preset definition contract | currently authored-map oriented; likely extension point for procgen path selection |
| `scripts/core/defs/worldgen_profile_def.gd` | worldgen bundle contract linking map presets, terrain profiles, season profile, starter species | should remain a bundle/orchestration definition, not raw noise settings |
| `scripts/core/defs/terrain_profile_def.gd` | semantic terrain/ecology profile baseline | good place for terrain identity; do not overload with every procgen knob |
| `scripts/runtime/world/world_state.gd` | authoritative world container for cells, patches, reveal sources, objects, warnings, debug snapshots | renderer/debug tools should consume this |
| `scripts/runtime/world/world_cell_state.gd` | per-cell terrain/runtime truth | authoritative local terrain semantics |
| `scripts/runtime/world/world_patch_state.gd` | contiguous/semantic patch metadata | should remain useful for site evaluation and debug interpretation |
| `scripts/runtime/world/world_chunk_state.gd` | chunk grouping of cells | supports chunk-aware world operations and rendering |
| `scripts/runtime/world/world_reveal_source_state.gd` | fog/reveal bootstrap sources | visibility should remain separate from generic terrain paint |
| `scripts/runtime/world/authored_map_loader.gd` | top-level authored fixture load orchestration | should orchestrate helper modules, not regain monolith status |
| `scripts/runtime/world/authored_map_fixture_validator.gd` | fixture root validation and schema rules | good place for semantic validation growth |
| `scripts/runtime/world/authored_map_stamp_applicator.gd` | stamp/default-cell application and patch creation | keep terrain paint logic isolated here |
| `scripts/runtime/world/authored_reveal_source_loader.gd` | reveal-source loading/bootstrap | keeps reveal semantics out of generic stamp logic |
| `scripts/runtime/world/authored_terrain_object_loader.gd` | authored terrain-object loading and placement validation | keeps terrain-object rules isolated |
| `scripts/runtime/world/terrain_object_placement_validator.gd` | terrain object placement rule validation | should stay data/rule focused |
| `scripts/runtime/time/time_command_queue.gd` | scheduled time command queue support | extracted from `time_service.gd` |
| `scripts/runtime/time/time_trigger_queue.gd` | time trigger queue support | extracted from `time_service.gd` |
| `scripts/runtime/time/time_random_stream_manager.gd` | deterministic/random stream helper state for time service | extracted from `time_service.gd` |
| `scripts/presentation/world/authoritative_terrain_renderer.gd` | terrain tile rendering from authoritative world cells | presentation consumer only |
| `scripts/presentation/world/terrain_overlay_renderer.gd` | terrain overlay visualization modes from runtime/debug state | should not own gameplay truth |
| `scripts/presentation/world/terrain_overlay_outline_renderer.gd` | overlay outlines and emphasis rendering | visual supplement only |
| `scripts/presentation/world/terrain_debug_visual_config.gd` | overlay mode registry, labels, legend text, shared visual metadata | keeps overlay modes/data centralized |
| `scripts/presentation/ui/dev_hud.gd` | HUD controller and runtime polling | should avoid swallowing all formatting logic |
| `scripts/presentation/ui/dev_hud_text_formatter.gd` | text/legend formatting for HUD output | extracted to keep HUD controller smaller |
| `scripts/presentation/ui/terrain_inspector_panel.gd` | selected/hovered cell terrain inspection UI | should reflect SimRoot/runtime truth directly |
| `scripts/presentation/sim_root_locator.gd` | shared utility for finding/validating SimRoot from presentation-side scripts | avoids duplicated fragile node-path lookup logic |

---

## 4. Current branch interpretation

### Branch 05 result
The codebase still has some large files, but the worst immediate cleanup pressure was reduced enough to move forward.

### Immediate next branch
The next branch should be:
**Branch 06 — procedural terrain generation foundation**

That branch should introduce new modules rather than re-bloating the scripts listed above.

---

## 5. Responsibility rules for the next branch

### 5.1 Keep authored and procedural world building separate at the loader level
Do not cram procedural generation directly into `AuthoredMapLoader`.

Recommended direction:
- keep `AuthoredMapLoader` for fixture-based authored worlds
- add a separate procedural world-build orchestrator for generated maps
- make both output the same `WorldState` contract

### 5.2 Keep reveal/bootstrap logic separate from terrain generation
Do not let generic terrain paint schemas quietly become visibility schemas again.

### 5.3 Keep profile semantics separate from generator knobs
Avoid turning `TerrainProfileDef` into a dumping ground for every noise/weight/range value.

Recommended direction:
- keep `TerrainProfileDef` semantic
- introduce a dedicated procedural generation config/profile resource for numeric generation parameters

### 5.4 Prefer helper modules over one bigger manager
When new generator stages are added, split them by concern:
- relief/elevation derivation
- hydrology/wetness derivation
- landcover/resource derivation
- site candidate evaluation
- terrain object seeding/validation

---

## 6. Final note

This matrix is meant to prevent responsibility drift.
If a future change makes one of these scripts own multiple unrelated concerns, that is a signal to split the logic before it hardens into a new monolith.
