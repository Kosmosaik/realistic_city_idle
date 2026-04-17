# Realistic Idle City — Godot Class / File Responsibility Matrix v0.1

> Filename retained for replacement convenience. This version updates the matrix after **Branch 04**.

## Purpose

This document defines what the current Godot-side classes/files are responsible for so the project keeps clean boundaries.

It is intentionally practical:
- what owns what
- what should stay dumb
- what should not become hidden authority
- what the immediate cleanup branch should preserve

---

## 1. Current core autoload responsibilities

| File | Type | Purpose |
|---|---|---|
| `autoload/app_root.gd` | autoload | lightweight app/session shell |
| `autoload/event_bus.gd` | autoload | cross-system signal hub |
| `autoload/telemetry_service.gd` | autoload | dev logging / telemetry sink |
| `autoload/save_service.gd` | autoload | save/load boundary placeholder |
| `autoload/definition_registry.gd` | autoload | loads and validates static definition resources |
| `autoload/sim_root.gd` | autoload | owns resolved bootstrap/session context, active world load path, current debug world state access |
| `autoload/time_service.gd` | autoload | owns authoritative calendar + deterministic run loop |

---

## 2. Current scene-side / presentation responsibilities

| File | Type | Purpose |
|---|---|---|
| `scenes/bootstrap/boot_scene.tscn` | scene | boot entry path + definition/bootstrap gate |
| `scenes/world/test_world_scene.tscn` | scene | lightweight world shell |
| `scripts/presentation/world/world_root_controller.gd` | Node2D | ensures the active world presentation stack exists and registers the world root with `SimRoot` |
| `scripts/presentation/world/authoritative_terrain_renderer.gd` | Node2D | draws base terrain from authoritative world state |
| `scripts/presentation/world/terrain_overlay_renderer.gd` | Node2D | draws debug/analysis overlay fills from authoritative terrain values |
| `scripts/presentation/world/terrain_overlay_outline_renderer.gd` | Node2D | draws overlay outlines such as patch boundaries / selection emphasis |
| `scripts/presentation/world/world_camera_controller.gd` | Camera2D | owns pan/zoom camera controls for world reading |
| `scripts/presentation/world/world_cell_inspector_probe.gd` | Node2D | converts hover/click input into authoritative cell inspection context |
| `scripts/presentation/ui/dev_hud.gd` | CanvasLayer | debug-facing HUD for bootstrap/runtime/world/overlay/camera state |
| `scripts/presentation/ui/terrain_inspector_panel.gd` | CanvasLayer | focused terrain/cell/patch inspection panel |

---

## 3. Current runtime/world responsibilities

| File | Type | Purpose |
|---|---|---|
| `scripts/runtime/state/sim_phase_ids.gd` | RefCounted helper | canonical ordered phase vocabulary |
| `scripts/runtime/state/scheduled_trigger_record.gd` | RefCounted data object | one queued scheduled-trigger record |
| `scripts/runtime/state/sim_command_record.gd` | RefCounted data object | one queued command record |
| `scripts/runtime/world/world_state.gd` | RefCounted runtime object | authoritative container for loaded world cells/chunks/patches/reveal sources/debug summaries |
| `scripts/runtime/world/world_cell_state.gd` | RefCounted runtime object | authoritative per-cell terrain/buildability/movement/fog data |
| `scripts/runtime/world/world_chunk_state.gd` | RefCounted runtime object | chunk grouping and chunk-level debug structure |
| `scripts/runtime/world/world_patch_state.gd` | RefCounted runtime object | patch-level summary, site-score, hazard/resource, and reveal summary data |
| `scripts/runtime/world/world_reveal_source_state.gd` | RefCounted runtime object | reveal/visibility source definition at runtime |
| `scripts/runtime/world/authored_map_loader.gd` | RefCounted service | loads authored map fixtures into authoritative runtime state |
| `scripts/runtime/world/world_visibility_service.gd` | RefCounted service | refreshes fog/remembered/visible state from reveal sources |
| `scripts/runtime/debug/debug_scheduled_trigger_probe.gd` | Node | dev probe proving external trigger/command behavior |

---

## 4. Current definition/resource responsibilities

| File family | Purpose |
|---|---|
| `scripts/core/defs/base_defs.gd` | common validation/debug base for definitions |
| `scripts/core/defs/*_def.gd` | typed `Resource` definition families |
| `data/defs/**` | static content resources used as project truth |
| `data/world/authored_maps/**` | authored runtime-world fixtures used to prove the authoritative terrain path |

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
| `shared_enums.gd` | RefCounted helper | alert/terrain/storage/shared enum vocabulary |
| `task_def_ids.gd` | RefCounted helper | placeholder task IDs |
| `zone_types.gd` | RefCounted helper | zone type ID vocabulary |

---

## 6. Important current boundary rules

### Rule 1
`DefinitionRegistry` owns static definition truth, not runtime instances.

### Rule 2
`SimRoot` owns active bootstrap/session context and active world access, not presentation scenes.

### Rule 3
`TimeService` owns calendar state **and** the deterministic tick/run-loop backbone.

### Rule 4
`WorldState` and the related runtime/world classes own authoritative terrain/reveal truth.

### Rule 5
Renderers, HUD panels, and inspector panels must stay readers of runtime truth, not hidden stores of canonical data.

### Rule 6
Any leftover placeholder-only files should be treated as disposable cleanup targets, not preserved architecture.

---

## 7. Immediate next branch expectation

## Branch 05 — audit-and-cleanup
Likely responsibilities:
- confirm/remove dead placeholder renderer leftovers
- remove temp scene artifacts
- keep README / roadmap / architecture docs aligned with the real file graph
- preserve the current clean split between runtime truth and presentation readers

This branch should not invent a new architecture.  
It should protect the one that now exists.

---

## 8. Final position

The current shell should continue to follow this structure:
- small autoload layer
- resource-defined static content
- explicit shared helper vocabularies
- deterministic runtime truth outside presentation scenes
- dedicated runtime/world objects for authoritative terrain knowledge
- debug-visible presentation readers on top

That keeps the project aligned with the docs while still being practical to build branch by branch.
