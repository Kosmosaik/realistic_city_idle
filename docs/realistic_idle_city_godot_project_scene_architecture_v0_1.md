# Realistic Idle City — Godot Project / Scene Architecture v0.1

## Purpose

This document converts the current early-game implementation stack into a **concrete Godot project architecture plan**.

It exists to answer:
- how the Godot project should be **organized**
- what should be an **autoload/service** versus a regular scene node
- how the **simulation layer** and **presentation layer** should be separated
- how the **world map, NPCs, structures, UI, fog of war, saves, and telemetry** should be wired together
- what scene/file layout should support the **survival -> primitive camp -> permanent camp -> tiny hamlet** MVP

This is an **implementation-facing architecture doc**, not a new design bible.

It should remain consistent with:
- Early Game MVP Build Spec v0.1
- Unified Data Dictionary v0.1
- World Generation + Map Rendering Spec v0.1
- System Flow / State Machine Pack v0.1
- Save / Load Schema v0.1
- Godot Save / Load Implementation Plan v0.1
- Debug / Telemetry Spec v0.1

---

## 1. Architecture stance

### 1.1 Simulation-first, scene-friendly

The project should use a **simulation-first architecture** where the authoritative game state is:
- explicit
- serializable
- debuggable
- largely independent from any single visual scene instance

But it should still feel idiomatic in Godot:
- scenes compose visible content
- nodes own runtime behavior and rendering
- resources hold reusable definitions/configuration
- a small number of autoloads coordinate cross-scene services

The goal is **not** to build a pure ECS rewrite inside Godot.
The goal is also **not** to let the entire game state live implicitly inside random scene trees.

### 1.2 Small autoload layer, not autoload sprawl

Use **autoloads only for true cross-scene services**.
Do **not** make every system an autoload.

Godot documents autoloads as globally available nodes/scripts that remain loaded across scene changes, while also noting there are tradeoffs and that regular nodes are often preferable for scene-local behavior. citeturn344111search0turn344111search11

Practical rule:
- **autoloads** = stable services and orchestration roots
- **regular nodes/scenes** = world presentation, UI, entities, map visuals, local controllers
- **resources** = static definitions and tunable content/config data

### 1.3 Authoritative state should be data, not view nodes

Visual nodes should present and animate the simulation state.
They should not be the only place where the truth lives.

Examples:
- an NPC scene should render and locally animate an NPC, but the authoritative NPC record should live in simulation state
- a tree scene should render the tree instance, but resource quantity / harvestable state should be saved in world state
- fog of war visuals should reflect exploration state from the world/exploration model

This is required for:
- reliable save/load
- replay/debug reasoning
- deterministic-enough simulation verification
- headless-ish test support later if desired

---

## 2. Godot concepts to lean on

### 2.1 Scenes are composition units

Godot treats the project as a tree of scenes/nodes, and scenes should be used as reusable composition units rather than one giant monolith. citeturn344111search14turn344111search7

Use scenes for:
- main gameplay shell
- world root
- chunk root
- NPC presentation/controller
- structure presentation/controller
- stockpile/zone presentation
- UI screens and panels
- debug panels
- title/load menu

### 2.2 Resources are data containers

Repeated rule for this project:
- `Resource` definitions are authored/static truth
- managers and state classes are authoritative runtime truth
- presentation controllers are non-authoritative views/caches

Do not let presentation nodes become the only source of truth, and do not mutate static authored definitions into session truth.

Godot resources are intended as data containers, can be nested, and can be saved/loaded separately from nodes. Packed scenes are also resources. citeturn344111search1turn344111search5turn344111search20

Use resources for:
- item definitions
- structure definitions
- process definitions
- skill definitions
- constants/balance sets
- biome/regional profile definitions
- terrain tile definitions
- UI display metadata
- debug config profiles

### 2.3 Scene ownership matters for saved/editor-authored subtrees

Godot notes that node ownership determines what is packed/saved inside a `PackedScene`, and nodes added dynamically must have their owner set if they need to be saved in that scene resource. citeturn344111search10turn344111search3

Practical implication:
- do not rely on runtime-created visual children magically becoming persistent scene data
- runtime world state should be saved through the project’s save schema, not by packing the live gameplay scene as the main persistence strategy

### 2.4 Canvas layers for map/UI separation

`CanvasLayer` exists specifically to separate 2D rendering layers, including fixed-screen UI that should not move with the world camera. citeturn344111search2turn344111search6

Use:
- world-space rendering in the default world canvas
- screen-fixed UI in dedicated `CanvasLayer` nodes
- optional separate overlay layers for debug/map modes if helpful

---

## 3. High-level architecture model

The MVP should be split into **four major layers**.

### 3.1 Definitions layer
Static and semi-static content/configuration.

Examples:
- item defs
- process defs
- structure defs
- balance constants
- map visual palette defs
- region profile defs

Representation:
- primarily `.tres` / `.res` resources
- optionally some JSON data imports for content packs later

### 3.2 Simulation layer
Authoritative runtime game state and rules.

Examples:
- clock
- weather state
- world cell state
- exploration memory
- NPC body states
- tasks and reservations
- settlement stats
- process progress
- item instances

Representation:
- GDScript service/model objects
- plain dictionaries/arrays where practical
- explicit manager-owned state tables
- save/load schema as the authority

### 3.3 Presentation layer
Visible map, entities, UI, audio, overlays, animation.

Examples:
- world tile layers
- object scenes
- NPC visuals
- fog visuals
- topographic overlays
- panel UI
- debug readouts

Representation:
- scenes/nodes
- TileMapLayer nodes
- Node2D/Control hierarchies
- shaders/materials where useful

### 3.4 Tooling/observability layer
Debug, telemetry, test harnesses, scenario loaders.

Examples:
- debug HUD
- event log panel
- performance monitors
- state inspectors
- scenario bootstrapper
- deterministic test seeds

Representation:
- autoload service + optional debug scenes/panels

---

## 4. Recommended autoload set

Keep the autoload set small.

Recommended MVP autoloads:

### 4.1 `AppRoot`
Top-level orchestration root.

Responsibilities:
- boot sequence
- environment mode (title/menu/game)
- global service references
- high-level scene switching
- global pause coordination
- build/version/session metadata access

### 4.2 `GameSession`
Authoritative current-session container.

Responsibilities:
- session state lifecycle
- current world/session IDs
- seed metadata
- references to loaded simulation managers
- new game / load game / unload flow

This is the main boundary between “no game loaded” and “active world loaded.”

### 4.3 `DefinitionDB`
Read-only definition lookup service.

Responsibilities:
- load item/process/structure/etc definitions
- lookup by canonical IDs
- validate references on boot
- expose display metadata to UI where needed

### 4.4 `SaveService`
Persistence service.

Responsibilities:
- slot enumeration
- manifest handling
- save snapshot requests
- load pipeline entry point
- backup/temp rotation
- export/import support later if needed

### 4.5 `TelemetryService`
Debug/telemetry/event aggregation service.

Responsibilities:
- runtime event logging
- live debug counters
- export bundles
- alert triggers
- test scenario annotations

### 4.6 `SettingsService`
Non-save gameplay/application settings.

Responsibilities:
- video/UI/control options
- map display preferences
- debug toggles permitted outside save files
- audio settings later

### 4.7 Optional: `ScenarioService`
Only if debug scenarios become common enough to justify it.

Responsibilities:
- scenario registry
- scenario injection/bootstrap helpers

### 4.8 What should NOT be autoloaded

Do not autoload:
- every simulation subsystem separately unless clearly necessary
- NPC manager as a standalone global if it only matters during an active session
- WorldRoot visual scene
- gameplay HUD scenes
- chunk visual scenes
- random utility scripts that can be static helpers or local objects

Instead, keep session-scoped systems under the active gameplay scene/session model.

---

## 5. Recommended top-level scene tree

### 5.1 Project runtime shell

Recommended structure:

```text
/root
  AppRoot (autoload)
  GameSession (autoload)
  DefinitionDB (autoload)
  SaveService (autoload)
  TelemetryService (autoload)
  SettingsService (autoload)
  Main.tscn
```

### 5.2 `Main.tscn`

`Main.tscn` should be the user-facing shell scene.

Recommended tree:

```text
Main
  SceneHost
  ScreenFXLayer
  UILayer
  ModalLayer
  DebugLayer
```

Responsibilities:
- host either title/menu flow or gameplay flow
- keep persistent UI shell/modals if desired
- provide a stable place for global overlays

### 5.3 Gameplay scene root

Recommended runtime gameplay tree:

```text
GameplayRoot
  SessionController
  WorldRoot
  GameplayUILayer
  GameplayModalLayer
  GameplayDebugLayer
```

Responsibilities:
- session-local orchestration
- own runtime managers that should die when the session unloads
- connect simulation state to presentation scenes

---

## 6. Session-local manager layout

These are **not** autoloads by default.
They belong under `GameplayRoot` and exist only while a world is active.

Recommended manager nodes/scripts:

### 6.1 `SimClockManager`
- in-game time
- tick stepping
- stable save boundaries
- time-of-day/day/season progression

### 6.2 `WeatherManager`
- current weather state
- short-term weather transitions
- environmental exposure modifiers

### 6.3 `WorldStateManager`
- authoritative world cell/patch state
- terrain mutations
- object placement registry
- chunk state tables
- site suitability cached summaries

### 6.4 `ExplorationManager`
- discovered/revealed cells
- remembered terrain
- active visibility around NPCs
- fog-of-war model

### 6.5 `NPCStateManager`
- authoritative NPC records
- needs/body states
- skill/interest/aptitude values
- equipment/carried items
- social/status flags

### 6.6 `TaskManager`
- task registry
- task generation queues
- assignment state
- task lifecycle transitions
- direct-order registration

### 6.7 `ReservationManager`
- item reservations
- work target locks
- tile/interaction slot locks
- structure usage locks

### 6.8 `ItemStateManager`
- loose item instances
- container membership
- stack aggregation/splitting
- spoilage/condition updates

### 6.9 `ProcessManager`
- crafting/cooking/drying/build actions in progress
- process runtime states
- input/output commitments

### 6.10 `SettlementManager`
- settlement stats
- reserve calculations
- stage progression checks
- camp/hamlet support metrics

### 6.11 `StructureManager`
- placed structure instances
- build states
- storage capacities
- usage slots

### 6.12 `ZoneManager`
- stockpiles
- work zones
- sanitation zones
- garden plots
- future grazing/charcoal/etc hooks

### 6.13 `PathCostManager`
- traversability maps
- path wear / preferred route weights
- terrain penalty tables
- route cache rebuild requests

### 6.14 `PresentationSyncCoordinator`
- batches state-change notifications to visual scenes
- reduces direct cross-manager -> scene chatter
- decides when presentation refreshes occur

Not strictly required as its own node on day one, but strongly recommended once the project grows beyond a prototype.

---

## 7. World scene architecture

### 7.1 `WorldRoot`

Recommended tree:

```text
WorldRoot (Node2D)
  CameraRig
    Camera2D
  MapRoot
    GroundLayer
    WaterLayer
    WetnessOverlayLayer
    ElevationEdgeLayer
    PathOverlayLayer
    TopoOverlayLayer
    FogLayer
  ObjectRoot
    ChunkObjectsRoot
  NPCVisualRoot
  StructureVisualRoot
  ZoneVisualRoot
  EffectsRoot
  InteractionRoot
```

### 7.2 Map layers

Use multiple `TileMapLayer` nodes for stacked grid rendering, which matches Godot’s intended modern tile workflow. `TileMap` is deprecated in favor of one-layer-per-node `TileMapLayer` usage. citeturn344111search9turn344111search2

Suggested layer purposes:
- `GroundLayer` = base terrain classes
- `WaterLayer` = stream/shore/wet water presence
- `WetnessOverlayLayer` = dampness emphasis where useful
- `ElevationEdgeLayer` = ledges/ridge edges/cliff transitions
- `PathOverlayLayer` = visible worn paths
- `TopoOverlayLayer` = optional contours/hillshade markers if tile-based
- `FogLayer` = unknown/revealed state visualization if tile-based

Some overlays may instead be better as custom draw/shader nodes once the art style is clearer.

### 7.3 Chunking model

The early MVP does **not** need infinite streaming terrain.
But it should still internally group map state into chunks/regions for:
- efficient refresh
- selective fog redraw
- selective object spawn/despawn
- path cost recalculation bounds
- save diff organization later

Recommended chunk usage:
- world state stored by chunk key
- visible/object scenes spawned per nearby chunk band
- offscreen chunks kept as data without heavy presentation nodes

### 7.4 Objects vs terrain

Keep a hard separation between:
- terrain cell state
- placeable/discrete object state

Terrain examples:
- elevation step
- landform
- wetness tendency
- traversability
- buildability

Object examples:
- tree instance
- berry bush
- clay deposit marker
- loose rock
- campfire
- shelter frame
- stockpile marker
- drying rack

This keeps save/load and mutation logic cleaner.

---

## 8. NPC architecture

### 8.1 Two-part NPC model

Each NPC should exist as:
1. an **authoritative NPC state record** in simulation data
2. an **NPC visual/controller scene** that reflects and acts on that record

Do not let the visual node become the only truth.

### 8.2 Recommended NPC scene

```text
NPCActor (Node2D)
  BodySpriteOrMarker
  CarriedItemMarker
  StatusIconRoot
  SelectionIndicator
  InteractionFxRoot
```

Responsibilities:
- movement interpolation
- facing/selection/status icons
- click/hover handling
- local animation timing
- emit interaction requests to gameplay controllers

Non-responsibilities:
- final task scoring truth
- reserve calculations
- authoritative hunger/thirst updates
- primary save ownership

### 8.3 NPC spawning flow

Suggested flow:
- `NPCStateManager` loads/creates NPC state
- `WorldRoot` or a dedicated `NPCVisualSpawner` instantiates `NPCActor`
- visual actor binds to canonical runtime NPC ID
- presentation updates come from batched state sync events or polling windows

### 8.4 Movement/pathing

Use grid/path-cost-driven path requests from simulation-side logic.
Visual actors only follow approved route outputs and animate them.

---

## 9. Structure and zone architecture

### 9.1 Structures

Recommended structure scene pattern:

```text
StructureActor (Node2D)
  BaseVisual
  BuildProgressVisual
  CapacityMarkers
  InteractionMarkers
  DamageStateVisual
```

Authoritative structure state belongs in:
- `StructureManager`
- world object registry
- process/build records where relevant

### 9.2 Zones

Zones are often lighter than structures and may not all need full scenes.

Possible representations:
- tile/overlay visualization only for stockpiles and garden plots
- lightweight scene wrapper only when interaction complexity justifies it

Recommended rule:
- if it mostly marks tiles and rules, keep it data-first + overlay
- if it has rich interaction/capacity/slots, consider a dedicated scene

---

## 10. Fog of war / exploration architecture

### 10.1 Separate three concepts

The architecture should distinguish:
- **unknown** = never seen
- **revealed memory** = seen before but not currently observed
- **currently observed** = within active exploration/vision reveal

### 10.2 Authority

`ExplorationManager` should own:
- revealed cell flags
- memory age if needed later
- currently visible cell set
- per-session reveal metrics

### 10.3 Presentation

Possible presentation split:
- unknown = dark/opaque fog
- remembered = dimmed terrain/object memory
- visible = full clarity

Recommended implementation:
- fog mask rendered independently from terrain truth
- remembered terrain data derived from exploration/world memory state
- avoid directly deleting unseen terrain info from simulation

### 10.4 Update model

Reveals should happen when:
- NPC moves
- scouting order resolves a reveal step
- camera/system requests nearby refresh after chunk load

Refresh should be region-based, not one expensive full-map redraw every frame.

---

## 11. UI architecture

### 11.1 Screen-space UI with `CanvasLayer`

Use screen-space UI for fixed panels and controls so the world camera can move/zoom independently. `CanvasLayer` is designed for this separation. citeturn344111search2turn344111search6

Suggested UI layers:

```text
GameplayUILayer (CanvasLayer)
  TopBar
  LeftInfoStack
  RightInspectorStack
  BottomCommandBar
  MapModeControls
  NotificationFeed
```

```text
GameplayModalLayer (CanvasLayer)
  PauseMenu
  SaveLoadDialog
  SettingsDialog
  ConfirmationDialog
```

```text
GameplayDebugLayer (CanvasLayer)
  DebugHUD
  EventConsole
  PerfPanel
  OverlayToggles
```

### 11.2 Inspector approach

Use one main right-side inspector shell that swaps content by selection context:
- nothing selected
- tile/cell selected
- NPC selected
- structure selected
- zone selected
- item stack selected

This avoids UI sprawl.

### 11.3 Map mode controls

Map mode/toggle controls should be persistent and easily reachable:
- aerial
- topo
- hybrid
- fog
- water/drainage debug
- fertility/garden suitability
- hauling/path cost
- sanitation suitability

---

## 12. Signal/event wiring strategy

### 12.1 Avoid signal explosion

Do not connect every node to every other node.

Prefer:
- managers emit structured events upward or to a coordinator
- UI/presentation subscribe through a bounded interface
- batch refreshes where possible

### 12.2 Recommended event tiers

#### Tier 1: immediate gameplay-critical events
Examples:
- task assigned
- reservation failed
- NPC entered emergency state
- structure completed

These can update relevant focused UI quickly.

#### Tier 2: batched presentation refreshes
Examples:
- many terrain cells updated
- many item stacks moved
- many fog cells revealed

These should be coalesced by region or tick.

#### Tier 3: telemetry-only events
Examples:
- debug snapshots
- aggregate counters
- event-chain breadcrumbs

Do not force these directly into presentation code.

### 12.3 Good practical rule

Simulation managers should not need direct knowledge of the internal node paths of UI widgets.

---

## 13. Data/resource architecture

### 13.1 Resource families

Recommended custom resource families:
- `ItemDef`
- `ProcessDef`
- `StructureDef`
- `SkillDef`
- `TerrainDef`
- `RegionProfileDef`
- `MapVisualProfileDef`
- `BalanceProfileDef`
- `UIStringDef` or equivalent only if localization/label control grows

### 13.2 Runtime state is not the same as defs

Keep a strict separation between:
- **definition resource** = static design/config data
- **runtime state record** = current live state in the save/simulation model

Example:
- `StructureDef` says a lean-to can provide shelter capacity and material requirements
- runtime structure record says this specific lean-to is half built, wet, and located at cell X/Y

### 13.3 Content loading policy

On project boot:
- load and validate definitions once
- fail loudly on broken cross-references in development
- expose lookups through `DefinitionDB`

---

## 14. Save/load integration in the scene architecture

### 14.1 Save authority

Save authority should live with the **simulation managers and schema serializers**, not the visual scene tree.

### 14.2 Load flow

Recommended flow:
1. boot app/autoload services
2. choose new game / load slot
3. create `GameplayRoot`
4. create/init session-local managers
5. deserialize authoritative state into managers
6. generate/bind presentation scenes from state
7. run rebuild passes for caches/path cost/visibility/UI sync
8. enter active play state

### 14.3 Unload flow

Recommended flow:
1. request save if needed
2. stop simulation stepping
3. detach/clear presentation scenes
4. dispose session-local managers
5. clear `GameSession` active world refs
6. return to menu or reload scenario

---

## 15. Telemetry/debug integration in the architecture

### 15.1 Observability is built in, not bolted on

Every major manager should expose:
- summary counters
- current phase/state
- recent error/failure reason if relevant
- debug dump method or snapshot data function

### 15.2 Required debug hooks

Managers should support:
- selected-entity inspection
- force refresh hooks for debug panels
- event breadcrumbs
- scenario injection points
- validation checks callable from debug tools

### 15.3 Recommended debug scene utilities

Useful debug tools/scenes:
- cell inspector overlay
- NPC state inspector panel
- reservation graph panel
- task queue panel
- fog/exploration inspector
- settlement stage breakdown panel
- path-cost heatmap toggle

---

## 16. Suggested file/folder layout

Recommended starting layout:

```text
res://
  autoload/
    app_root.gd
    game_session.gd
    definition_db.gd
    save_service.gd
    telemetry_service.gd
    settings_service.gd

  core/
    boot/
    util/
    constants/
    validation/

  defs/
    items/
    processes/
    structures/
    skills/
    terrain/
    region_profiles/
    balance/
    map_visuals/

  sim/
    clock/
    weather/
    world/
    exploration/
    npcs/
    tasks/
    reservations/
    items/
    processes/
    settlement/
    structures/
    zones/
    pathing/

  scenes/
    app/
      Main.tscn
    gameplay/
      GameplayRoot.tscn
      SessionController.gd
    world/
      WorldRoot.tscn
      chunks/
      fog/
      overlays/
    actors/
      NPCActor.tscn
      StructureActor.tscn
    ui/
      hud/
      inspectors/
      modals/
      debug/
    menu/
      TitleScreen.tscn
      LoadMenu.tscn

  content/
    scenarios/
    generated_test_maps/

  save/
    serializers/
    loaders/
    validators/

  telemetry/
    exporters/
    monitors/
    debug_panels/

  tests/
    scenarios/
    smoke/
    validation/
```

This is only a starting point, but it keeps content, simulation, scenes, and persistence clearly separated.

---

## 17. Build order for the architecture

### Phase 1 — skeleton
Build:
- project folder structure
- autoload skeletons
- `Main.tscn`
- `GameplayRoot.tscn`
- `WorldRoot.tscn`
- UI shell layers

### Phase 2 — authoritative simulation cores
Build:
- session-local manager shells
- state registries
- definition loading/validation
- save-compatible runtime IDs

### Phase 3 — world presentation bridge
Build:
- map layers
- chunk/object visual spawners
- fog/exploration visual layer
- camera and map mode controls

### Phase 4 — entity/interaction presentation
Build:
- NPC actor scene
- structure actor scene
- selection/inspection flow
- task/order interaction hooks

### Phase 5 — persistence + debug hardening
Build:
- save/load wiring
- telemetry panels
- scenario loader hooks
- validation and rebuild passes

### Phase 6 — performance cleanup
Build:
- chunk refresh bounds
- event batching
- pool/reuse hot scenes if needed
- overlay update throttling

---

## 18. Architecture rules that should not be casually broken

### 18.1 No hidden truth inside visuals
A visible node may cache display state, but it must not become the sole owner of important simulation truth.

### 18.2 No uncontrolled autoload growth
Every new autoload must justify why it cannot be session-local or a normal helper/resource.

### 18.3 Definitions are not runtime state
Definition resources stay static; mutable play state lives elsewhere.

### 18.4 UI should inspect managers, not own the simulation
UI sends requests/orders and displays state; it should not become the hidden rules engine.

### 18.5 Save/load schema is authoritative for persistence
Do not quietly rely on scene packing as the primary save strategy for the gameplay world.

### 18.6 Map readability beats visual cleverness
Aerial/topographic style should support survival decisions, not obscure them.

---

## 19. Practical MVP recommendation

For the current project stage, the strongest architecture choice is:

- **small autoload service layer**
- **session-local simulation managers under `GameplayRoot`**
- **data-first authoritative state**
- **multi-layer 2D world presentation under `WorldRoot`**
- **screen-space UI via `CanvasLayer`**
- **definitions stored as resources**
- **save/load driven by explicit schema, not scene serialization**

This is strong enough for:
- lone survivor survival
- primitive camp formation
- permanent camp stabilization
- tiny hamlet growth

without overcommitting to a too-clever architecture too early.

---

## 20. Suggested immediate follow-up

The best next document after this one is:

**Godot Class / File Responsibility Matrix v0.1**

That doc should answer:
- exact scripts/classes to create first
- one-line responsibility for each file
- ownership boundaries
- key method names / API surfaces
- what talks to what

That would be the cleanest bridge from architecture into actual implementation.
