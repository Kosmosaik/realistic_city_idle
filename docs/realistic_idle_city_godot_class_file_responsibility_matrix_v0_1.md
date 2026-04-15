# Realistic Idle City — Godot Class / File Responsibility Matrix v0.1

> Filename retained for replacement convenience. This version updates the matrix after **Branch 02**.

## Purpose

This document defines what the current Godot-side classes/files are responsible for so the project keeps clean boundaries.

It is intentionally practical:
- what owns what
- what should stay dumb
- what should not become hidden authority
- what near-term files are expected next

---

## 1. Current core autoload responsibilities

| File | Type | Purpose |
|---|---|---|
| `autoload/app_root.gd` | autoload | lightweight app/session shell |
| `autoload/event_bus.gd` | autoload | cross-system signal hub |
| `autoload/telemetry_service.gd` | autoload | dev logging / telemetry sink |
| `autoload/save_service.gd` | autoload | save/load boundary placeholder |
| `autoload/definition_registry.gd` | autoload | loads and validates static definition resources |
| `autoload/sim_root.gd` | autoload | owns resolved bootstrap/session context |
| `autoload/time_service.gd` | autoload | owns authoritative Branch 02 calendar + deterministic run loop |

---

## 2. Current scene-side responsibilities

| File | Type | Purpose |
|---|---|---|
| `scenes/bootstrap/boot_scene.tscn` | scene | boot entry path + definition/bootstrap gate |
| `scenes/world/test_world_scene.tscn` | scene | current dev world wrapper |
| `scripts/presentation/world/world_root_controller.gd` | Node2D | ensures placeholder world presentation + dev-only helpers exist |
| `scripts/presentation/world/map_placeholder.gd` | Node2D | temporary decorative/debug world rendering |
| `scripts/presentation/ui/dev_hud.gd` | CanvasLayer | debug-facing bootstrap + Branch 02 runtime panel |

---

## 3. Current runtime/state responsibilities

| File | Type | Purpose |
|---|---|---|
| `scripts/runtime/state/sim_phase_ids.gd` | RefCounted helper | canonical ordered Branch 02 phase vocabulary |
| `scripts/runtime/state/scheduled_trigger_record.gd` | RefCounted data object | one queued scheduled-trigger record |
| `scripts/runtime/state/sim_command_record.gd` | RefCounted data object | one queued command record |
| `scripts/runtime/debug/debug_scheduled_trigger_probe.gd` | Node | dev probe proving external trigger/command behavior |

---

## 4. Current definition/resource responsibilities

| File family | Purpose |
|---|---|
| `scripts/core/defs/base_defs.gd` | common validation/debug base for definitions |
| `scripts/core/defs/*_def.gd` | typed Resource definition families |
| `data/defs/**` | static content resources used as project truth |

Current implemented definition families:
- stage
- skill
- item
- process
- structure
- scenario
- map preset
- species
- terrain profile
- worldgen profile
- season profile
- incident
- UI panel

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
`TimeService` owns calendar state **and** the deterministic Branch 02 tick/run-loop backbone.

### Rule 4
The current placeholder map renderer is disposable once authoritative world data arrives in Branch 03–04.

### Rule 5
Do not let the debug HUD or world scene become hidden data stores.

---

## 7. Near-term additions expected after Branch 02

### Branch 03
Likely new responsibilities:
- `world_state.gd`
- `world_cell_state.gd`
- authored map loading into authoritative runtime state
- world inspector/debug accessors

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
- deterministic runtime truth outside presentation scenes
- debug-visible bootstrap and run-loop state

That keeps the project aligned with the docs while still being practical to build branch by branch.
