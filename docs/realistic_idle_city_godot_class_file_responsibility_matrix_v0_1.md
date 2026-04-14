# Realistic Idle City — Godot Class / File Responsibility Matrix v0.1

## Purpose

This matrix maps the current early-game MVP architecture to concrete file responsibilities.

This updated version keeps the original architectural intent but adds a status snapshot after **Branch 01** so the document matches the current shell more closely.

---

## 1. Current implementation snapshot after Branch 01

Actually implemented shell files now include:

### Autoloads
- `autoload/app_root.gd`
- `autoload/definition_registry.gd`
- `autoload/event_bus.gd`
- `autoload/save_service.gd`
- `autoload/sim_root.gd`
- `autoload/telemetry_service.gd`
- `autoload/time_service.gd`

### Definition resources/classes
- `scripts/core/defs/base_defs.gd`
- `item_def.gd`
- `process_def.gd`
- `structure_def.gd`
- `skill_def.gd`
- `stage_def.gd`
- `scenario_def.gd`
- `map_preset_def.gd`
- `species_def.gd`
- `terrain_profile_def.gd`
- `worldgen_profile_def.gd`
- `season_profile_def.gd`
- `incident_def.gd`
- `ui_panel_def.gd`

### Shared runtime/state helpers
- `scripts/runtime/state/calendar_ids.gd`
- `definition_types.gd`
- `id_rules.gd`
- `policy_bundle_ids.gd`
- `shared_enums.gd`
- `task_def_ids.gd`
- `zone_types.gd`

### Current presentation scripts
- `scripts/core/boot_scene.gd`
- `scripts/presentation/world/world_root_controller.gd`
- `scripts/presentation/world/map_placeholder.gd`
- `scripts/presentation/ui/dev_hud.gd`

### Current scenes
- `scenes/bootstrap/boot_scene.tscn`
- `scenes/world/test_world_scene.tscn`

---

## 2. Current responsibility stance

### Static definitions
Live in `scripts/core/defs/` + `data/defs/`.
These are Resources and are loaded/validated by `DefinitionRegistry`.

### Bootstrap/session context
Lives in `SimRoot`.
`SimRoot` owns the resolved active IDs for scenario/stage/map/worldgen/season/seed.

### Calendar/clock bootstrap
Lives in `TimeService`.
For now this is bootstrap calendar state, not the full deterministic simulation clock yet.

### Presentation
Lives in scenes and `scripts/presentation/...`.
These are views and debug surfaces, not authoritative simulation truth.

### Validation/observability
Lives in `DefinitionRegistry`, `TelemetryService`, and the debug HUD.

---

## 3. Concrete current file responsibilities

| File | Type | Owns | Must not own |
|---|---|---|---|
| `autoload/app_root.gd` | Node/autoload | app-level scene switching and build/session metadata access | gameplay truth |
| `autoload/sim_root.gd` | Node/autoload | active bootstrap/session context, resolved IDs, world-root registration | rendering details, deep gameplay systems |
| `autoload/time_service.gd` | Node/autoload | calendar snapshot and season-profile bootstrap defaults | future world model, UI logic |
| `autoload/definition_registry.gd` | Node/autoload | definition loading, ID validation, duplicate/reference checks | runtime simulation state |
| `autoload/event_bus.gd` | Node/autoload | shared signals/events | business logic ownership |
| `autoload/telemetry_service.gd` | Node/autoload | debug/runtime logging | gameplay state |
| `autoload/save_service.gd` | Node/autoload | save/load entry-point shell | direct view logic |
| `scripts/core/boot_scene.gd` | Node | bootstrap orchestration and boot-failure handling | simulation truth |
| `scripts/presentation/world/world_root_controller.gd` | Node | current world scene glue and registration | authoritative world model |
| `scripts/presentation/world/map_placeholder.gd` | Node2D/visual | temporary debug/placeholder terrain presentation | real terrain truth |
| `scripts/presentation/ui/dev_hud.gd` | CanvasLayer | debug visibility for build/bootstrap/validation state | gameplay decision logic |

---

## 4. Definition class responsibilities

| File | Type | Owns |
|---|---|---|
| `scripts/core/defs/base_defs.gd` | Resource base | shared definition metadata (`display_name`, `description`, `sort_index`, `tags`) |
| `stage_def.gd` | Resource | stage metadata |
| `skill_def.gd` | Resource | skill metadata |
| `item_def.gd` | Resource | item metadata |
| `process_def.gd` | Resource | process metadata and reference lists |
| `structure_def.gd` | Resource | structure metadata |
| `scenario_def.gd` | Resource | scenario bootstrap references |
| `map_preset_def.gd` | Resource | authored map preset metadata |
| `species_def.gd` | Resource | plant/animal/resource species metadata |
| `terrain_profile_def.gd` | Resource | terrain profile metadata |
| `worldgen_profile_def.gd` | Resource | world/profile bundle metadata |
| `season_profile_def.gd` | Resource | calendar/season bundle metadata |
| `incident_def.gd` | Resource | incident metadata |
| `ui_panel_def.gd` | Resource | panel metadata |

---

## 5. Shared helper responsibilities

| File | Type | Purpose |
|---|---|---|
| `calendar_ids.gd` | RefCounted helper | season and part-of-day vocabulary |
| `definition_types.gd` | RefCounted helper | definition family type keys + directory mapping |
| `id_rules.gd` | RefCounted helper | canonical ID validation rules |
| `policy_bundle_ids.gd` | RefCounted helper | placeholder policy bundle IDs |
| `shared_enums.gd` | RefCounted helper | alert/terrain/storage/shared enum vocab |
| `task_def_ids.gd` | RefCounted helper | placeholder task IDs |
| `zone_types.gd` | RefCounted helper | zone type ID vocabulary |

---

## 6. Important current/future boundary rules

### Rule 1
`DefinitionRegistry` owns static definition truth, not runtime instances.

### Rule 2
`SimRoot` owns the active bootstrap/session context, not presentation scenes.

### Rule 3
`TimeService` owns calendar state, but the full deterministic tick loop belongs to **Branch 02**.

### Rule 4
The current placeholder map renderer is disposable once authoritative world data arrives in Branch 03–04.

### Rule 5
Do not let the debug HUD or world scene become hidden data stores.

---

## 7. Near-term additions expected after Branch 01

### Branch 02
Likely new responsibilities:
- simulation tick sequencing
- pause/resume/speed controls
- single-step debug
- stable phase ordering hooks

### Branch 03
Likely new responsibilities:
- `world_state.gd`
- `world_cell_state.gd`
- authored map loading into authoritative runtime state

### Branch 04
Likely new responsibilities:
- world renderer bound to authoritative terrain data
- fog/remembered terrain controllers
- richer debug overlays

---

## 8. Final position

The current shell should continue to follow this structure:
- small autoload layer
- Resource-defined static content
- explicit shared helper vocabularies
- runtime truth outside presentation scenes
- debug-visible bootstrap state

That keeps the project aligned with the docs while still being practical to build branch by branch.
