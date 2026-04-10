# Realistic Idle City — Godot Save / Load Implementation Plan v0.1

## Purpose

This document converts **Save / Load Schema v0.1** into a concrete Godot implementation plan for the early-game MVP.

It exists to answer:
- what save/load systems must exist in code
- what order they should be built in
- what data is authoritative at save time
- what should be serialized vs rebuilt on load
- how validation, corruption handling, and debug workflows should work

This plan assumes the current project phase is still the **survival -> primitive camp -> permanent camp -> tiny hamlet** slice.

This plan also follows the current hardening-phase rule that **existing saves are disposable**. Backward compatibility and migration are **not** priority work unless explicitly requested later.

---

## 1. Implementation goals

The save/load implementation must:
- preserve the full authoritative early-game simulation state
- reload deterministically enough for debugging and long-run stability checks
- be easy to inspect during development
- fail safely when data is missing or malformed
- support reproducible QA scenarios tied to telemetry/test packs
- avoid serializing transient runtime caches that can be rebuilt

The implementation does **not** need in this phase to:
- support old-version migration
- support cloud sync
- support binary compression-first storage
- preserve every micro-step of in-progress animation
- preserve editor-only debug overlays unless explicitly configured

---

## 2. Godot storage approach

Use **`user://`** for save slots and related runtime persistence. Godot documents `user://` as the writable per-project data path intended for persistent user data, and `FileAccess`/`DirAccess` are the intended APIs for reading, writing, and managing files/directories there. citeturn864811view0turn864811view1turn864811view2

### 2.1 Save folder structure

Recommended layout:

```text
user://saves/
  slot_001/
    manifest.json
    autosave_latest.json
    autosave_prev.json
    manual_2026-04-09_18-22-10.json
    quicksave.json
  slot_002/
    manifest.json
    ...
user://crash_recovery/
  pending_recovery.json
user://exports/
  telemetry_bundle_*.zip   (later if implemented)
```

### 2.2 File format during hardening

Use **JSON text saves** first.

Reason:
- easy to inspect manually
- easy to diff during balancing/debugging
- aligns with the disposable-save hardening phase
- easier to pair with telemetry and acceptance test scenarios

Godot’s `JSON` support is suitable for structured text serialization, but engine-specific types are not preserved automatically as rich runtime objects, so saves should use explicit primitive fields and schema-controlled arrays/objects instead of relying on engine object dumping. citeturn864811view3

### 2.3 Timestamping

Use `Time` for wall-clock timestamps in metadata and use simulation tick/time values for authoritative in-world timing. Godot’s `Time` class is for real-world clock/date conversion and should not replace the game’s own simulation clock. citeturn864811view4

---

## 3. Core architectural rule

Canonical enum strings come from the Unified Data Dictionary unless the current document is explicitly preserving a more detailed runtime lifecycle that the dictionary mirrors.

The save system should be built around **authoritative simulation roots**, not around scene trees.

Do **not** save by walking visible nodes and dumping scene state.

Instead, save from the simulation/domain layer:
- world state
- fog/memory state
- NPC state
- item state
- structure state
- zone state
- task/process state
- settlement/global managers
- validation/version metadata

Then reconstruct scenes/views from loaded domain data.

This is the single most important implementation decision.

---

## 4. Save/load subsystem breakdown

Create the following core runtime pieces.

## 4.1 `SaveManager`

High-level coordinator.

Responsibilities:
- public API for save/load/list/delete operations
- slot selection
- autosave timing policy
- crash-recovery staging
- write-rotation and backup handling
- dispatch of validation and rebuild steps
- emitting success/failure events for UI and telemetry

Suggested API surface:

```gdscript
class_name SaveManager

func request_manual_save(slot_id: String, label: String = "") -> SaveResult
func request_quicksave(slot_id: String) -> SaveResult
func request_autosave(slot_id: String) -> SaveResult
func load_slot(slot_id: String, file_name: String = "") -> LoadResult
func list_slot_files(slot_id: String) -> Array
func delete_save_file(slot_id: String, file_name: String) -> int
func get_slot_manifest(slot_id: String) -> Dictionary
```

## 4.2 `SaveSerializer`

Pure domain -> dictionary transform.

Responsibilities:
- build the root save dictionary
- serialize each subsystem using canonical field names from the Unified Data Dictionary
- exclude transient caches
- ensure JSON-safe values only
- stamp schema/build metadata

## 4.3 `SaveDeserializer`

Dictionary -> domain reconstruction.

Responsibilities:
- parse JSON
- run root/schema checks
- reconstruct authoritative managers/models in dependency order
- queue unresolved cross-references
- finalize link resolution pass
- return structured load report with warnings/errors

## 4.4 `SaveValidator`

Responsibilities:
- schema version check
- required root keys check
- ID uniqueness checks
- cross-reference integrity checks
- enum/value range checks where cheap enough
- settlement/world consistency checks
- report generation for debug UI and logs

## 4.5 `SaveSlotRepository`

Thin file-system utility.

Responsibilities:
- ensure directories exist
- read/write files under `user://saves/`
- rotate backup files
- write manifests
- enumerate slot contents
- isolate `FileAccess` / `DirAccess` usage from higher layers

## 4.6 `PostLoadRebuilder`

Responsibilities:
- rebuild caches and indexes excluded from saves
- rebuild pathfinding grids and chunk lookup tables
- rebuild reservation indices
- rebuild spatial occupancy maps
- rebuild derived overlays if not serialized
- repopulate debug runtime registries
- trigger view refresh / scene sync

---

## 5. Authoritative save roots

The root save payload should contain sections in roughly this order:

```text
meta
simulation_clock
rng_state
world
fog_of_war
settlement
npcs
items
structures
zones
tasks
processes
events
ui_state_minimal
validation
```

### 5.1 `meta`
Must include:
- `schema_version`
- `content_version`
- `balance_version`
- `build_version`
- `created_at_utc`
- `saved_at_utc`
- `save_kind` (`autosave`, `manual`, `quicksave`, `recovery`)
- `slot_id`
- `seed`
- `playtime_seconds`
- `tick_index`

### 5.2 `simulation_clock`
Must include:
- world day/season/time-of-day state
- simulation speed state if relevant
- next scheduled phase boundary if used

### 5.3 `rng_state`
Store only if the runtime architecture uses deterministic seeded random streams and restoring them is practical.

If full RNG restoration is awkward in the first pass, document that limitation and prioritize deterministic generation seeds plus stable authored reload behavior.

### 5.4 `world`
Must include:
- world seed/profile id
- local map dimensions
- cell records or chunk records for authoritative terrain data
- discovered/modified resource nodes
- terrain alterations by player/NPC action
- water source states if mutable
- path wear / cleared ground if modeled

### 5.5 `fog_of_war`
Must include:
- cell reveal state
- last-seen / memory state where used
- explored frontier info if cached

### 5.6 `settlement`
Must include:
- current stage and confidence/progress fields
- reserve rules
- rationing/allocation policies
- active alerts
- named camp/site metadata

### 5.7 `npcs`
Each NPC must include:
- runtime instance id
- identity fields required in MVP
- body-state values
- inventory/equipment references
- location/state/activity
- skill/interest/aptitude fields in canonical form
- health/injury/care fields
- current task/process/order references
- social/home/bed/storage claims where applicable
- exploration knowledge if per-NPC memory exists

### 5.8 `items`
Each item instance must include:
- instance id
- definition id
- quantity / stack state
- quality if modeled
- spoilage/condition/wetness fields where relevant
- ownership/reservation state if any
- location container reference

### 5.9 `structures`
Must include:
- structure instance ids + definition ids
- completion state
- durability/condition if used
- occupancy/storage/process-capacity state
- linked zone references

### 5.10 `zones`
Must include:
- zone ids
- zone type
- geometric coverage or cell list
- priority/status flags
- allowed item/process settings where relevant

### 5.11 `tasks`
Only save tasks if tasks are treated as authoritative long-lived runtime objects.

Recommended MVP rule:
- save **player-authored directives / standing jobs / direct orders / reservations / process queues**
- do **not** necessarily save every ephemeral candidate-scoring scratch object

### 5.12 `processes`
Must include only processes that materially persist across load:
- construction progress
- ongoing crafting/processing jobs
- fire burn state
- drying/smoking/preservation progress
- care/recovery progress if modeled as persistent process state

### 5.13 `events`
Keep compact.

Save only the event history needed for:
- important recent alerts
- incident aftermath still affecting systems
- tutorial/progression gating if used
- telemetry correlation if explicitly desired

Do not save an unbounded full event log in the main save.

### 5.14 `ui_state_minimal`
Save only minimal convenience state:
- selected map mode
- camera position/zoom if useful
- pinned panels if desirable

This must never block load if missing.

---

## 6. What not to serialize directly

Do **not** serialize these unless a later need proves it necessary:
- pathfinding caches
- task score scratch data
- per-frame animation state
- temporary VFX/SFX state
- generated tooltip text
- UI widget trees
- render chunk caches
- debug panel open/closed state beyond trivial convenience fields
- recomputable settlement summaries
- derived overlays that can be regenerated cheaply enough

General rule:

**Save authoritative facts. Rebuild derived helpers.**

---

## 7. Load order

Load order matters.

Recommended sequence:

1. pause simulation
2. clear active runtime state
3. parse JSON file
4. run root/schema validation
5. create base managers
6. load simulation clock/meta/build context
7. load world terrain/chunks
8. load fog/memory
9. load settlement globals/policies
10. load structures/zones
11. load items
12. load NPCs
13. load persistent tasks/processes/orders
14. resolve cross-references
15. run post-load validator
16. rebuild caches/indexes
17. resync scene/view layer
18. run sanity snapshot
19. unpause simulation
20. emit load-complete report

Important dependency notes:
- structures/zones should exist before item and NPC location binding if those references target them
- world must exist before path/position validation
- settlement policies should exist before reserve/ration checks

---

## 8. Save timing policy

Only save at **stable simulation boundaries**.

Recommended safe windows:
- end of simulation tick
- end of task-resolution phase
- paused game state
- explicit autosave checkpoint after world/process commit

Avoid saving:
- mid-resolution of reservation assignment
- while cross-manager mutations are partially applied
- during load/unload of map chunks if mutation not committed
- halfway through item transfer chains

### 8.1 Autosave policy for MVP

Suggested default:
- autosave every 3–5 in-game hours equivalent or every few real minutes during normal speed
- autosave only when not in critical mutation phase
- keep `latest` and `previous`

### 8.2 Manual save policy
- always allowed while simulation is paused
- optionally queue save-at-safe-boundary if the player saves while unpaused

---

## 9. Crash-safe writing strategy

Use a staged write pattern.

Recommended process:
1. serialize to dictionary
2. encode to JSON string
3. write to temporary file
4. flush/close successfully
5. rename current main save to backup/prev
6. rename temp file to target final name
7. update manifest last

The exact rename/copy flow should stay inside `SaveSlotRepository` so failure handling is centralized.

If any stage fails:
- keep the last known good save
- emit structured error + telemetry event
- never silently replace a good file with a partial write

---

## 10. Validation rules

## 10.1 Hard-fail rules

Load must fail if:
- root JSON is invalid
- required root sections are absent
- schema version is unsupported
- duplicate runtime IDs exist in the same authority domain
- required referenced entity is missing and cannot be safely repaired
- map dimensions or chunk topology are incompatible with saved world data

## 10.2 Soft-repair / warn rules

Load may continue with warnings if:
- optional UI state is missing
- deprecated-but-still-known optional fields are absent
- non-critical event history is truncated
- debug-only fields are missing
- an NPC is missing a non-authoritative convenience cache

## 10.3 First-pass repair policy

Because saves are disposable during hardening, prefer:
- **clear validation failure with explanation**
- minimal silent repair
- only small safe repairs such as defaulting optional convenience fields

Do not build a complex migration/repair layer yet.

---

## 11. Cross-reference model

The save system must use strict ID-based references.

Examples:
- item references container/location by ID
- NPC references current task by ID
- structure references covered zone IDs
- process references actor/input/output IDs

### 11.1 Two-pass reconstruction

Use a two-pass load:

**Pass 1**
- instantiate plain runtime records by type and id
- load direct primitive fields

**Pass 2**
- resolve references between records
- validate reference targets
- build reverse lookup/index tables

This avoids order-fragile load code.

---

## 12. Fog-of-war / exploration persistence

This project now includes exploration-based map reveal.

Save must preserve:
- current revealed cells
- unknown cells still hidden
- remembered terrain for explored-but-not-currently-visible areas if memory is modeled separately
- discovered resource/object markers if the design distinguishes “seen once” from “currently visible”

Recommended early rule:
- save reveal state at the **world-cell or chunk-cell level**
- do not treat fog as a pure visual post-effect with no data authority

Fog state is gameplay state because it affects available information and player decision-making.

---

## 13. Map/world mutation persistence

The world generator creates the starting terrain, but the save must preserve all meaningful deltas caused by play.

Persist at minimum:
- removed/harvested plants or nodes
- placed paths/structures/zones
- campfire/ash/refuse traces if modeled materially
- ground cleared for use
- cut tree stumps/log remnants if modeled
- garden plots and planted states
- altered stockpile/latrine/work areas

General rule:
- do not rerun procgen and hope to “re-derive” the current world from seed alone
- save the current authoritative world state or authoritative deltas against the seed-generated base

For the MVP, saving the fully authoritative local world state is simpler than a sophisticated delta-compression model.

---

## 14. Scene/view reconstruction strategy

After authoritative load completes:
- clear current instantiated presentation scenes
- rebuild visible world chunks/objects from loaded data
- restore camera position/zoom if stored
- rebind selection to valid entities if possible
- refresh HUD panels from domain state

The view layer should never be the source of truth.

This makes load behavior more robust and keeps headless or simulation-first testing viable later.

---

## 15. Telemetry integration

Save/load must emit structured telemetry/debug events.

Required events:
- `save_requested`
- `save_started`
- `save_succeeded`
- `save_failed`
- `load_requested`
- `load_started`
- `load_validation_failed`
- `load_succeeded`
- `load_rebuild_warning`
- `recovery_save_created`

Each event should include:
- slot id
- file name
- schema/build/balance version
- save kind
- tick index
- world day/time
- duration ms
- entity counts summary
- warning/error list if any

This directly supports the telemetry spec and acceptance test reproducibility.

---

## 16. Minimal UI requirements

The first usable save/load UI only needs:
- slot list
- last modified time
- settlement stage label
- short save summary (population, day, season, map seed)
- manual save button
- load button
- delete button
- warning prompt for incompatible schema/build

Optional but useful:
- autosave/manual/quicksave badges
- corruption warning icon
- compact screenshot preview later

Do not overbuild the UI before the core pipeline is stable.

---

## 17. Suggested Godot file/class layout

```text
res://scripts/persistence/
  save_manager.gd
  save_slot_repository.gd
  save_serializer.gd
  save_deserializer.gd
  save_validator.gd
  post_load_rebuilder.gd
  save_manifest_types.gd
  save_error_codes.gd

res://scripts/persistence/serializers/
  serialize_world.gd
  serialize_fog.gd
  serialize_settlement.gd
  serialize_npcs.gd
  serialize_items.gd
  serialize_structures.gd
  serialize_zones.gd
  serialize_tasks.gd
  serialize_processes.gd

res://scripts/persistence/deserializers/
  deserialize_world.gd
  deserialize_fog.gd
  deserialize_settlement.gd
  deserialize_npcs.gd
  deserialize_items.gd
  deserialize_structures.gd
  deserialize_zones.gd
  deserialize_tasks.gd
  deserialize_processes.gd
```

Keep save logic out of UI controllers and out of unrelated gameplay nodes.

---

## 18. Recommended implementation order

## Phase 1 — skeletal infrastructure
1. create `SaveSlotRepository`
2. create `SaveManager` shell
3. create slot directories under `user://saves/`
4. implement manifest write/read
5. implement temporary-file + backup rotation pattern
6. implement root `meta` and `simulation_clock` test save

**Exit condition:** can create/list/load a trivial valid test save.

## Phase 2 — world foundation
1. serialize/deserialize world root
2. serialize/deserialize fog-of-war state
3. serialize/deserialize settlement globals
4. rebuild world indexes after load

**Exit condition:** map, reveal state, and settlement globals survive round-trip correctly.

## Phase 3 — entity persistence
1. serialize/deserialize structures/zones
2. serialize/deserialize items
3. serialize/deserialize NPCs
4. resolve cross-references
5. validate occupancy/location integrity

**Exit condition:** settlement contents and NPC positions/inventories survive round-trip.

## Phase 4 — jobs/processes/orders
1. serialize player directives and standing orders
2. serialize persistent processes
3. serialize minimal ongoing task bindings if needed
4. rebuild runtime scheduling queues on load

**Exit condition:** ongoing camp activity resumes correctly after load.

## Phase 5 — validation + hardening
1. implement `SaveValidator`
2. add structured error codes
3. add load reports/warnings panel
4. integrate telemetry events
5. add crash-recovery staging

**Exit condition:** failures are explainable and non-destructive.

## Phase 6 — polish
1. slot summary UI
2. autosave settings/options if desired
3. quicksave/load shortcuts
4. optional export bundle support for QA

---

## 19. Required tests

## 19.1 Round-trip integrity tests
For each authoritative root:
- serialize
- deserialize
- compare required fields
- compare counts and reference integrity

## 19.2 Scenario reload tests
Must test at least:
- day 1 lone-survivor map
- bad-weather camp
- active fire + food preservation
- two-NPC camp with stockpiles and zones
- tiny hamlet with several structures and standing work
- half-explored fog-of-war map

## 19.3 Corruption/failure tests
Must test:
- truncated JSON
- wrong schema version
- missing root section
- duplicate IDs
- missing referenced item/structure/NPC
- impossible map dimensions

## 19.4 Stability tests
- repeated autosave every few minutes for a long run
- save/load cycling 20+ times on the same settlement
- compare key counts and validation summaries after each cycle

## 19.5 Performance tests
Measure:
- save duration
- load duration
- JSON payload size
- rebuild duration
- worst-case entity-count spikes

---

## 20. First-pass non-goals

Not required yet:
- backward compatibility layer
- migration tools
- binary save compression
- cross-platform cloud persistence workflows
- partial region streaming saves for giant maps
- multiplayer-safe authoritative sync
- full replay system from save deltas

These can come later if the project grows beyond the current scope.

---

## 21. Final recommendation

For the current phase, the correct save/load philosophy is:

**domain-authoritative, JSON-first, easy to inspect, strict to validate, cheap to throw away, and structured enough to become long-term architecture later.**

That fits:
- the hardening-phase disposable-save instruction
- the realism-first simulation design
- the need for debugging and telemetry
- the small-but-serious early-game MVP scope

The implementation should start simple, but the structure should already assume the game is a real simulation with world, fog, NPCs, items, structures, tasks, and persistent settlement state.
