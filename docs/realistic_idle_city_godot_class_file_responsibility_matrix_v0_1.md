# Realistic Idle City — Godot Class / File Responsibility Matrix v0.1

## Purpose

This document converts the project architecture into a concrete responsibility map for the early-game MVP.

It answers:
- which classes/files should exist
- what each one is responsible for
- what each one must **not** own
- which data should live in Resources vs runtime objects vs scene nodes
- which classes are allowed to depend on which others
- how to keep the implementation realistic, debuggable, and expandable without turning the project into autoload spaghetti or scene-coupling chaos

This is for the **early-game MVP only**:
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

This matrix should be read together with:
- Early Game MVP Build Spec v0.1
- Unified Data Dictionary v0.1
- World Generation + Map Rendering Spec v0.1
- Balance / Constants Sheet v0.1
- System Flow / State Machine Pack v0.1
- Acceptance Criteria / Test Checklist v0.1
- Debug / Telemetry Spec v0.1
- Save / Load Schema v0.1
- Godot Save / Load Implementation Plan v0.1
- Godot Project / Scene Architecture v0.1

---

## 1. Architectural stance

The project should use a **small service layer**, **Resource-based static definitions**, and **scene/node-based runtime presentation**.

Core rule:
- **Static design data** lives in Resources or imported data assets.
- **Authoritative runtime simulation state** lives in manager-owned plain data objects / dictionaries / lightweight runtime classes.
- **World presentation** lives in scenes and nodes.
- **UI** reads from simulation state and sends user intent back inward.
- **Save/load** serializes authoritative simulation state, not arbitrary scene trees.

This keeps the project grounded in simulation truth instead of letting view nodes become the real model.

---

## 2. High-level project folder layout

```text
res://
  autoload/
    app_root.gd
    sim_root.gd
    time_service.gd
    event_bus.gd
    save_service.gd
    telemetry_service.gd

  data/
    defs/
      items/
      structures/
      processes/
      species/
      skills/
      biome_profiles/
      worldgen/
      ui/
    balance/
    localization/

  scripts/
    core/
    sim/
    sim/world/
    sim/npc/
    sim/items/
    sim/tasks/
    sim/process/
    sim/settlement/
    sim/health/
    sim/exploration/
    sim/orders/
    sim/save/
    sim/debug/
    presentation/
    presentation/world/
    presentation/entities/
    presentation/ui/
    util/

  scenes/
    bootstrap/
    world/
    entities/
    ui/
    debug/

  assets/
    tiles/
    textures/
    icons/
    shaders/
    fonts/
    audio/

  saves/
    (editor/dev only if needed; runtime uses user://)
```

---

## 3. Ownership model

There are four ownership layers.

### 3.1 Definition ownership
Owns static truth about what something is.
Examples:
- item definitions
- process definitions
- structure definitions
- terrain profile definitions
- skill definitions
- stage definitions

Format:
- Godot `Resource` files or imported JSON transformed into Resources at build/load time.

### 3.2 Simulation ownership
Owns authoritative runtime truth.
Examples:
- NPC need values
- task queues
- item instances
- structure condition
- explored cells
- weather state
- settlement stage progress

Format:
- lightweight runtime classes, dictionaries, arrays, indexed registries, and manager-owned state.

### 3.3 Presentation ownership
Owns what the player sees.
Examples:
- TileMapLayer contents
- tree/rock scene instances
- NPC dots/sprites
- selection highlights
- UI panels
- fog overlay visuals

Format:
- scenes and nodes.

### 3.4 Persistence ownership
Owns save package creation and restoration.
Examples:
- schema conversion
- file write flow
- validation
- migration hooks
- cache rebuild triggers

Format:
- save service + serializer/deserializer + validators.

---

## 4. Autoload/service layer

Only true cross-scene services belong here.

| File | Type | Owns | Must not own |
|---|---|---|---|
| `autoload/app_root.gd` | Autoload Node | app boot coordination, mode switching, top-level scene boot, global dev flags | simulation rules, map generation, UI logic details |
| `autoload/sim_root.gd` | Autoload Node | references to active simulation managers, simulation start/stop/reset orchestration | rendering details, widget state |
| `autoload/time_service.gd` | Autoload Node | real-time tick cadence, pause/speed state, stable save-point windows | NPC scheduling logic, weather logic |
| `autoload/event_bus.gd` | Autoload Node | low-friction publish/subscribe for cross-system notifications | authoritative state storage |
| `autoload/save_service.gd` | Autoload Node | slot list, save/load entry points, serializer coordination, backup rotation | owning world/NPC/item state directly |
| `autoload/telemetry_service.gd` | Autoload Node | session telemetry, rolling logs, debug channels, export bundles | game rule decisions |

### Important autoload rule
If a system does not need to survive scene changes or act as a global entry point, it should **not** be an autoload.

---

## 5. Core simulation managers

These are the main authoritative subsystems for the MVP.

| File | Type | Owns | Reads from | Writes to | Must not own |
|---|---|---|---|---|---|
| `scripts/sim/simulation_manager.gd` | Node/service | simulation step order, manager update orchestration, stable boundaries | all managers | orchestrates all managers | UI state, scene instances as truth |
| `scripts/sim/world/world_manager.gd` | Node/service | world seed, cell registry, terrain layers, hydrology flags, world mutations | world defs, map params | world state | NPC logic internals, UI widgets |
| `scripts/sim/world/weather_manager.gd` | Node/service | current weather, wetness pressures, temperature bands, short forecast | world profile, season state | weather state, exposure modifiers | direct NPC control |
| `scripts/sim/exploration/exploration_manager.gd` | Node/service | scouted cells, revealed cells, remembered cells, explore intent/targets, authoritative fog/exploration state | world state, NPC positions | exploration/fog runtime state | pathfinding engine internals |
| `scripts/sim/npc/npc_manager.gd` | Node/service | NPC registry, needs, body states, skills, interests, roles, location refs | definitions, world state, task outcomes | NPC state | UI panels, scene movement interpolation |
| `scripts/sim/tasks/task_manager.gd` | Node/service | task registry, task lifecycle, assignment, reservations at task level | orders, needs, world/item/process requests | active task state | direct movement rendering |
| `scripts/sim/items/item_manager.gd` | Node/service | item instance registry, stacks, location ownership, condition/spoilage | item defs, process outcomes | item runtime state | drawing item icons on map |
| `scripts/sim/process/process_manager.gd` | Node/service | process instances, input/output handling, progress, interruptions | process defs, item state, structure state | process runtime state | item definitions |
| `scripts/sim/settlement/settlement_manager.gd` | Node/service | camp metadata, zones, stockpiles, reserve policies, stage evaluation | NPC/item/structure state | settlement state | low-level hauling path logic |
| `scripts/sim/health/health_manager.gd` | Node/service | injuries, illness states, care needs, recovery timers | NPC state, food/water safety, exposure | health state | rendering sickness indicators |
| `scripts/sim/orders/order_manager.gd` | Node/service | player direct orders, policy toggles, priority rules | UI intent, world/npc/task state | order state, task requests | task execution internals |
| `scripts/sim/path/path_manager.gd` | Node/service | traversability grid, move cost cache, route queries, path wear cache | world terrain, structures, paths | path results, cost caches | NPC decisions about which task to pick |
| `scripts/sim/structure/structure_manager.gd` | Node/service | structure instances, condition, occupancy, linked zones, support values | structure defs, world state, process state | structure runtime state | UI placement mode |
| `scripts/sim/economy/reserve_manager.gd` | Node/service | reserve categories, protected amounts, consumption permissions | settlement/item state, policies | reserve state | owning actual items |

### Manager rule
Managers own **registries and authoritative state**, not view nodes.

---

## 6. Runtime data classes

These should be lightweight, serializable, and mostly logic-friendly.

| File | Type | Purpose |
|---|---|---|
| `scripts/sim/world/world_state.gd` | RefCounted/data class | root world runtime package |
| `scripts/sim/world/world_cell_state.gd` | RefCounted/data class | one cell’s authoritative simulation data |
| `scripts/sim/world/world_chunk_state.gd` | RefCounted/data class | chunk-level aggregation/cache package |
| `scripts/sim/npc/npc_state.gd` | RefCounted/data class | one NPC’s runtime state |
| `scripts/sim/items/item_state.gd` | RefCounted/data class | one item instance or stack runtime state |
| `scripts/sim/tasks/task_state.gd` | RefCounted/data class | one task’s runtime lifecycle data |
| `scripts/sim/process/process_state.gd` | RefCounted/data class | one process instance runtime data |
| `scripts/sim/structure/structure_state.gd` | RefCounted/data class | one structure instance runtime data |
| `scripts/sim/settlement/zone_state.gd` | RefCounted/data class | one zone definition at runtime |
| `scripts/sim/orders/order_state.gd` | RefCounted/data class | direct order or policy instance |
| `scripts/sim/health/health_state.gd` | RefCounted/data class | health package for one NPC |
| `scripts/sim/exploration/fog_cell_state.gd` | RefCounted/data class | revealed/remembered/unknown visibility state |

### Runtime data rule
These classes should be safe to serialize and rebuild.
They should not depend on scene node references.

---

## 7. Definition Resources

Static definitions should be Resources, grouped by category.

| File | Type | Owns |
|---|---|---|
| `scripts/core/defs/item_def.gd` | Resource | canonical item definition |
| `scripts/core/defs/structure_def.gd` | Resource | structure type definition |
| `scripts/core/defs/process_def.gd` | Resource | process type definition |
| `scripts/core/defs/skill_def.gd` | Resource | skill metadata |
| `scripts/core/defs/species_def.gd` | Resource | plant/animal/resource species metadata |
| `scripts/core/defs/terrain_profile_def.gd` | Resource | terrain/landform profile definition |
| `scripts/core/defs/worldgen_profile_def.gd` | Resource | region/local generation parameter bundle |
| `scripts/core/defs/season_profile_def.gd` | Resource | seasonal timing and modifiers |
| `scripts/core/defs/stage_def.gd` | Resource | settlement stage requirements and descriptors |
| `scripts/core/defs/incident_def.gd` | Resource | event/incident static rules |
| `scripts/core/defs/ui_panel_def.gd` | Resource | optional config for dense data panels |

### Resource rule
Definitions answer “what can exist” and “what does this type mean.”
They do not answer “what is happening right now.”

---

## 8. World generation and world-state classes

### 8.1 Generation side

| File | Type | Owns | Must not own |
|---|---|---|---|
| `scripts/sim/world/worldgen_pipeline.gd` | service/helper | generation order, seed usage, stage execution | final runtime manager orchestration |
| `scripts/sim/world/worldgen_relief_stage.gd` | helper | elevation bands, landform skeleton | placing final runtime objects directly in scene tree |
| `scripts/sim/world/worldgen_hydrology_stage.gd` | helper | streams, wet depressions, drainage influence | NPC spawn logic |
| `scripts/sim/world/worldgen_soil_stage.gd` | helper | soil/drainage classes | UI/debug panels |
| `scripts/sim/world/worldgen_vegetation_stage.gd` | helper | vegetation communities | task logic |
| `scripts/sim/world/worldgen_resource_stage.gd` | helper | resource patch derivation | item runtime instances outside generation scope |
| `scripts/sim/world/worldgen_hazard_stage.gd` | helper | flood/wetness/exposure overlays | care/injury decision logic |
| `scripts/sim/world/worldgen_start_site_stage.gd` | helper | candidate camp scoring, start placement | long-run settlement simulation |

### 8.2 Runtime side

| File | Type | Owns |
|---|---|---|
| `scripts/sim/world/world_query_service.gd` | helper/service | read-only spatial queries for other systems |
| `scripts/sim/world/world_mutation_service.gd` | helper/service | terrain/object/world mutation application |
| `scripts/sim/world/world_cache_builder.gd` | helper/service | rebuild derived caches after load or major mutation |

### World rule
Generation creates starting truth.
Runtime systems then mutate that truth.
Do not let rendering code generate authoritative terrain state on its own.

---

## 9. NPC and decision classes

| File | Type | Owns | Must not own |
|---|---|---|---|
| `scripts/sim/npc/npc_needs_model.gd` | helper | hunger, thirst, fatigue, temperature/wetness pressure calculations | full task selection policy |
| `scripts/sim/npc/npc_body_state_model.gd` | helper | body-state severity thresholds and emergency overrides | UI text formatting |
| `scripts/sim/npc/npc_skill_model.gd` | helper | skill gain/use modifiers, aptitude/interest interaction | direct process execution |
| `scripts/sim/npc/npc_decision_model.gd` | helper | macro action selection from current needs/orders/tasks | pathfinding internals |
| `scripts/sim/npc/npc_role_model.gd` | helper | role tags and work preference weighting | player policy state |
| `scripts/sim/npc/npc_spawn_service.gd` | helper | starter NPC/newcomer runtime instancing from definitions | scene-node visual setup |

### NPC rule
NPC code should decide **what they want to do**, not directly manage map visuals or UI.

---

## 10. Task / order / reservation classes

| File | Type | Owns |
|---|---|---|
| `scripts/sim/tasks/task_factory.gd` | helper | creation of canonical task payloads |
| `scripts/sim/tasks/task_scorer.gd` | helper | score calculation per NPC-task pair |
| `scripts/sim/tasks/task_validator.gd` | helper | preconditions and failure checks |
| `scripts/sim/tasks/task_reservation_service.gd` | helper | reservation claims for items, structures, cells |
| `scripts/sim/tasks/task_executor.gd` | helper | progress, interruption, success/failure transition rules |
| `scripts/sim/orders/direct_order_factory.gd` | helper | player direct-order generation |
| `scripts/sim/orders/policy_rule_model.gd` | helper | rationing, reserve, work-priority rule handling |

### Task rule
A task is a **simulation contract**, not a button press and not a movement animation.

---

## 11. Item / process / structure classes

| File | Type | Owns |
|---|---|---|
| `scripts/sim/items/item_stack_service.gd` | helper | stack merge/split rules |
| `scripts/sim/items/item_spoilage_model.gd` | helper | spoilage progression and state shifts |
| `scripts/sim/items/item_location_service.gd` | helper | moving items between world, hands, stockpiles, structures |
| `scripts/sim/process/process_precondition_service.gd` | helper | input/tool/structure/knowledge checks |
| `scripts/sim/process/process_output_service.gd` | helper | deterministic outputs, byproducts, waste |
| `scripts/sim/process/process_interruption_model.gd` | helper | pause/cancel/failure outcomes |
| `scripts/sim/structure/structure_placement_service.gd` | helper | placement checks and footprint rules |
| `scripts/sim/structure/structure_support_model.gd` | helper | shelter/storage/sanitation/workflow support contribution |
| `scripts/sim/structure/structure_condition_model.gd` | helper | wear/repair thresholds |

### Item/process/structure rule
Definitions tell you what a type can do.
Managers track what each instance is doing now.
Helpers implement the transition logic.

---

## 12. Exploration / fog-of-war classes

| File | Type | Owns |
|---|---|---|
| `scripts/sim/exploration/fog_manager.gd` | service/helper | non-authoritative fog query/render helpers owned by `exploration_manager.gd` |
| `scripts/sim/exploration/reveal_model.gd` | helper | reveal radius/rules from movement/exploration tasks |
| `scripts/sim/exploration/memory_decay_model.gd` | helper | optional stale-memory degradation rules |
| `scripts/sim/exploration/scouting_target_service.gd` | helper | unknown-edge candidate selection |

### Fog rule
Fog state is authoritative simulation data because it affects player knowledge and exploration behavior.
The fog overlay visuals are not the authoritative source.

---

## 13. Save/load classes

| File | Type | Owns |
|---|---|---|
| `scripts/sim/save/save_slot_index.gd` | helper | slot metadata and listing |
| `scripts/sim/save/save_serializer.gd` | helper | runtime state -> save payload |
| `scripts/sim/save/save_deserializer.gd` | helper | save payload -> runtime state |
| `scripts/sim/save/save_validator.gd` | helper | schema/version/consistency validation |
| `scripts/sim/save/save_backup_service.gd` | helper | temp write, backup, rollback flow |
| `scripts/sim/save/post_load_rebuild_service.gd` | helper | rebuild caches, subscriptions, transient lookups |

### Save rule
Save/load code should know the schema and reconstruction order.
It should not contain the actual gameplay rules for hunger, hauling, construction, or site choice.

---

## 14. Telemetry / debug classes

| File | Type | Owns |
|---|---|---|
| `scripts/sim/debug/debug_snapshot_service.gd` | helper | on-demand authoritative state snapshot assembly |
| `scripts/sim/debug/event_trace_service.gd` | helper | structured chronological event traces |
| `scripts/sim/debug/failure_chain_service.gd` | helper | root-cause chain reconstruction |
| `scripts/sim/debug/dev_command_service.gd` | helper | dev cheats, scenario injection, forced conditions |
| `scripts/sim/debug/monitor_registry.gd` | helper | live monitor registration and metric lookup |

### Debug rule
Debug code may observe everything, but it should not silently become a hidden authority that changes normal simulation behavior outside explicit dev commands.

---

## 15. Presentation layer: world scenes and view controllers

### 15.1 Root world scene

| File | Type | Owns |
|---|---|---|
| `scenes/world/world_root.tscn` | scene | main world presentation composition |
| `scripts/presentation/world/world_root_controller.gd` | Node | binds sim state to world presentation subcontrollers |

### 15.2 Terrain/map rendering

| File | Type | Owns | Must not own |
|---|---|---|---|
| `scenes/world/map_renderer.tscn` | scene | world map visual hierarchy | simulation truth |
| `scripts/presentation/world/map_renderer_controller.gd` | Node | terrain redraw requests, visual mode switch, chunk view updates | authoritative cell values |
| `scripts/presentation/world/tile_layer_controller.gd` | Node | one TileMapLayer’s tile updates | world generation logic |
| `scripts/presentation/world/hillshade_overlay_controller.gd` | Node | hillshade visual generation/display | real elevation truth |
| `scripts/presentation/world/contour_overlay_controller.gd` | Node | contour line rendering | terrain simulation |
| `scripts/presentation/world/fog_overlay_controller.gd` | Node | unknown/revealed/remembered fog visuals | exploration/fog authority |
| `scripts/presentation/world/path_overlay_controller.gd` | Node | path wear/path overlay visuals | route calculation truth |

### 15.3 Chunk visualization

| File | Type | Owns |
|---|---|---|
| `scripts/presentation/world/chunk_view_registry.gd` | helper | which chunks are currently visualized |
| `scripts/presentation/world/chunk_redraw_scheduler.gd` | helper | batched redraw timing |

### Presentation world rule
Presentation controllers only mirror or summarize simulation data.
If a visual controller is deleted and rebuilt, the simulation should still remain correct.

---

## 16. Presentation layer: entity views

| File | Type | Owns |
|---|---|---|
| `scenes/entities/npc_view.tscn` | scene | one NPC visual |
| `scripts/presentation/entities/npc_view_controller.gd` | Node | map position interpolation, simple state icon overlays |
| `scenes/entities/world_object_view.tscn` | scene | tree/bush/rock/object impression view |
| `scripts/presentation/entities/world_object_view_controller.gd` | Node | appearance from object state |
| `scenes/entities/structure_view.tscn` | scene | placed structure visual |
| `scripts/presentation/entities/structure_view_controller.gd` | Node | structure visual status and construction phase display |
| `scripts/presentation/entities/item_pile_view.gd` | Node | optional visible dropped-item pile impression |

### Entity view rule
No entity view decides gameplay outcomes.
At most it can request or display state.

---

## 17. Presentation layer: camera / selection / player interaction

| File | Type | Owns |
|---|---|---|
| `scripts/presentation/world/camera_controller.gd` | Node | zoom, pan, clamp, optional follow |
| `scripts/presentation/world/selection_controller.gd` | Node | hover/select target resolution |
| `scripts/presentation/world/placement_controller.gd` | Node | structure/zone placement preview |
| `scripts/presentation/world/direct_order_input_controller.gd` | Node | translating clicks into player order requests |
| `scripts/presentation/world/map_mode_controller.gd` | Node | aerial/topo/hybrid/debug visual mode switching |

### Input rule
Input controllers emit intent.
They do not directly mutate simulation state without passing through order/placement services.

---

## 18. Presentation layer: UI

### 18.1 Main HUD

| File | Type | Owns |
|---|---|---|
| `scenes/ui/main_hud.tscn` | scene | core HUD layout |
| `scripts/presentation/ui/main_hud_controller.gd` | Control | high-level HUD state binding |
| `scripts/presentation/ui/top_bar_controller.gd` | Control | time, weather, speed, alerts |
| `scripts/presentation/ui/selection_panel_controller.gd` | Control | context panel for selected cell/NPC/item/structure |
| `scripts/presentation/ui/orders_panel_controller.gd` | Control | order buttons and policy toggles |
| `scripts/presentation/ui/reserve_panel_controller.gd` | Control | reserves and consumption permissions |
| `scripts/presentation/ui/settlement_status_panel_controller.gd` | Control | stage, counts, key support values |

### 18.2 Specialized panels

| File | Type | Owns |
|---|---|---|
| `scripts/presentation/ui/npc_detail_panel_controller.gd` | Control | needs, body state, skills, task, inventory |
| `scripts/presentation/ui/task_inspector_panel_controller.gd` | Control | task cause/status/failure details |
| `scripts/presentation/ui/world_cell_panel_controller.gd` | Control | terrain/drainage/fertility/buildability/fog info |
| `scripts/presentation/ui/log_panel_controller.gd` | Control | filtered event/telemetry feed |
| `scripts/presentation/ui/map_legend_controller.gd` | Control | map mode legends and overlays |

### UI rule
UI may cache view models, but authoritative truth remains in simulation managers.

---

## 19. View-model / adapter layer

To avoid bloating UI scripts with direct manager reads, use thin adapters.

| File | Type | Owns |
|---|---|---|
| `scripts/presentation/ui/viewmodels/npc_view_model_builder.gd` | helper | NPC -> UI-friendly view model |
| `scripts/presentation/ui/viewmodels/cell_view_model_builder.gd` | helper | world cell -> UI-friendly package |
| `scripts/presentation/ui/viewmodels/task_view_model_builder.gd` | helper | task -> UI-friendly package |
| `scripts/presentation/ui/viewmodels/settlement_view_model_builder.gd` | helper | settlement summary model |

### View-model rule
Adapters may transform, sort, and label data.
They do not invent hidden gameplay state.

---

## 20. Dependency rules

### 20.1 Allowed direction
Preferred dependency direction:

```text
Definitions/Constants
    -> Simulation helpers/models
    -> Managers / authoritative runtime state
    -> Presentation adapters/controllers
    -> UI widgets / visual scenes
```

### 20.2 Disallowed direction
These are anti-patterns:
- UI scripts directly changing NPC/item state without going through a service/manager
- map renderer being the authority for terrain values
- entity scenes storing the only copy of structure condition or item state
- save/load reading from the current scene tree as the main truth
- one manager reaching deeply into another manager’s internal arrays instead of using a query/service boundary
- every helper becoming a global singleton

---

## 21. Communication patterns

Use the simplest pattern that preserves clarity.

### 21.1 Direct manager calls
Use when the dependency is stable and explicit.
Example:
- simulation manager calling NPC manager update

### 21.2 Query services
Use when many systems need read-only spatial/state queries.
Example:
- world query service
- settlement summary query service

### 21.3 Event bus
Use for low-coupling notifications, not core authority.
Example:
- “task completed”
- “structure placed”
- “alert raised”
- “selected entity changed”

### 21.4 View-model builders
Use when UI needs dense derived summaries.

---

## 22. File naming rules

Use clear, boring names.

### Managers
- `*_manager.gd`

### Data/state
- `*_state.gd`
- `*_snapshot.gd`

### Definitions
- `*_def.gd`
- matching `.tres` or `.res` data assets

### Services/helpers
- `*_service.gd`
- `*_model.gd`
- `*_builder.gd`
- `*_validator.gd`
- `*_factory.gd`
- `*_controller.gd`

### Scenes
- snake_case scene names matching controller names when practical

---

## 23. MVP-first implementation order

Recommended build order:

### Phase 1 — foundation
- `simulation_manager.gd`
- `world_manager.gd`
- `npc_manager.gd`
- `item_manager.gd`
- `task_manager.gd`
- `order_manager.gd`
- `time_service.gd`
- core defs
- core state classes

### Phase 2 — survival loop
- `path_manager.gd`
- `weather_manager.gd`
- `health_manager.gd`
- `task_scorer.gd`
- `npc_needs_model.gd`
- `npc_decision_model.gd`
- `item_spoilage_model.gd`
- simple HUD + selection panel

### Phase 3 — camp formation
- `structure_manager.gd`
- `process_manager.gd`
- `reserve_manager.gd`
- structure/process helpers
- stockpile/zones support
- map renderer + fog overlay + simple world objects

### Phase 4 — exploration and stage progression
- `exploration_manager.gd`
- `fog_manager.gd`
- world query/mutation helpers
- settlement stage checks
- newcomer spawn support

### Phase 5 — persistence and hardening
- save/load classes
- telemetry/debug services
- debug panels
- scenario injection tools
- validation and failure tracing

---

## 24. Anti-bloat rules

To keep the codebase healthy:

### 24.1 Do not create a manager for every tiny concept
Use helpers/models first unless the concept has real authoritative state.

### 24.2 Do not let scenes become hidden databases
Scene nodes are disposable views.

### 24.3 Do not put all logic in one “god manager”
Simulation manager orchestrates; subsystem managers own their domain.

### 24.4 Do not let UI scripts own business logic
UI is for displaying state and sending intent.

### 24.5 Do not over-abstract too early
For MVP, prefer explicit files over generic framework magic.

---

## 25. Ownership sanity checklist

Before adding any new class/file, ask:

1. Is this **static definition**, **runtime truth**, **presentation**, or **persistence**?
2. Is it a **manager**, **helper**, **state class**, **resource**, or **controller**?
3. What is the single sentence of responsibility?
4. What must it explicitly **not** own?
5. Could this be a helper instead of a manager?
6. Could this be a view-model instead of UI logic?
7. Can it survive save/load boundaries cleanly?
8. If its scene vanished, would simulation still be correct?

If those answers are blurry, the class/file should not be added yet.

---

## 26. Recommended first file set

If implementation starts immediately, the first concrete file set should be:

```text
autoload/
  app_root.gd
  sim_root.gd
  time_service.gd
  event_bus.gd

scripts/core/defs/
  item_def.gd
  structure_def.gd
  process_def.gd
  skill_def.gd
  worldgen_profile_def.gd

scripts/sim/
  simulation_manager.gd

scripts/sim/world/
  world_manager.gd
  world_state.gd
  world_cell_state.gd
  world_query_service.gd

scripts/sim/npc/
  npc_manager.gd
  npc_state.gd
  npc_needs_model.gd
  npc_decision_model.gd

scripts/sim/items/
  item_manager.gd
  item_state.gd
  item_location_service.gd

scripts/sim/tasks/
  task_manager.gd
  task_state.gd
  task_factory.gd
  task_scorer.gd
  task_validator.gd

scripts/sim/orders/
  order_manager.gd

scripts/presentation/world/
  world_root_controller.gd
  map_renderer_controller.gd
  camera_controller.gd
  selection_controller.gd

scripts/presentation/ui/
  main_hud_controller.gd
  selection_panel_controller.gd
```

That is enough to start building the actual MVP loop without prematurely committing to every future subsystem.

---

## 27. Final position

The project should be implemented as:
- **Resource-defined types**
- **manager-owned authoritative simulation state**
- **query/service helpers for cross-system logic**
- **scene/node presentation that mirrors but does not own truth**
- **schema-driven save/load**
- **debuggable, explicit file boundaries**

If this matrix is followed, the project should stay:
- realistic
- modular
- debuggable
- save/load friendly
- compatible with fog-of-war and layered map rendering
- expandable beyond the early game without rewriting the foundation

