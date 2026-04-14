# Realistic Idle City — Handoff Summary After Branch 02 v0.3

> Filename retained for replacement convenience. Content now reflects the project **after Branch 02**, not after Branch 00.

## Purpose

This handoff is for the next assistant continuing the project after **Branch 02 — simulation clock and run loop**.

It explains:
- current project status
- what was actually implemented in Branch 00, Branch 01, and Branch 02
- what the active bootstrap/runtime chain now does
- what technical constraints matter
- what the next assistant should do next
- what should not be changed casually

---

## 1. Current project state

The project now has a real Godot shell, a real data backbone, **and** a real deterministic clock/run-loop backbone.

Current implementation status:
- **Branch 00 — repo-bootstrap is complete**
- **Branch 01 — core definitions and IDs is complete enough to close**
- **Branch 02 — simulation clock and run loop is complete enough to close**
- the project launches cleanly
- the dev world scene loads
- startup definitions validate before entering the world
- active bootstrap context resolves from definitions
- deterministic time advances through an authoritative ordered run loop
- the project is ready to begin **Branch 03 — world data model + hand-authored maps**

The current playable target is still unchanged:
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

No real survival simulation loop is implemented yet.
No authoritative world-cell model is implemented yet.
This is still a foundation-first build.

---

## 2. What was implemented by the end of Branch 02

### 2.1 Autoload/runtime shell
Current autoloads:
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

Important rules already learned:
- autoload scripts should **not** use `class_name`
- explicit local typing is safer in the bootstrap/runtime shell
- `/root/...` singleton lookup is acceptable in the current bootstrap layer

### 2.2 Current scene/runtime flow
Current entry path:
- `scenes/bootstrap/boot_scene.tscn`
- then transitions into `scenes/world/test_world_scene.tscn`

Current bootstrap resolution path:
- `ScenarioDef`
- `WorldgenProfileDef`
- `SeasonProfileDef`
- `MapPresetDef`
- then `TimeService` adopts the season-profile defaults

Current world-scene support:
- `WorldRootController` ensures:
  - placeholder map renderer
  - world camera
  - dev HUD
  - external debug scheduled-trigger probe

### 2.3 Current definition infrastructure
Implemented:
- `autoload/definition_registry.gd`
- canonical ID validation rules
- duplicate-ID detection
- cross-reference validation
- visible validation report in the dev HUD
- readable boot failure panel when definitions/bootstrap are broken

Current shared helper scripts:
- `calendar_ids.gd`
- `definition_types.gd`
- `id_rules.gd`
- `policy_bundle_ids.gd`
- `shared_enums.gd`
- `task_def_ids.gd`
- `zone_types.gd`

### 2.4 Current definition resource families
Implemented definition classes:
- `BaseDef` (`scripts/core/defs/base_defs.gd`)
- `StageDef`
- `SkillDef`
- `ItemDef`
- `ProcessDef`
- `StructureDef`
- `ScenarioDef`
- `MapPresetDef`
- `SpeciesDef`
- `TerrainProfileDef`
- `WorldgenProfileDef`
- `SeasonProfileDef`
- `IncidentDef`
- `UiPanelDef`

### 2.5 Current seed pack size
Current validated definition pack: **122 definitions**

Breakdown:
- 5 stages
- 15 skills
- 33 items
- 33 processes
- 18 structures
- 1 scenario
- 1 map preset
- 4 species
- 2 terrain profiles
- 1 worldgen profile
- 1 season profile
- 4 incidents
- 4 UI panels

### 2.6 Current Branch 02 clock/run-loop backbone
Implemented in `TimeService`:
- deterministic tick progression
- pause / resume
- speed controls
- single-step debug
- calendar snapshot exposure
- stable ordered phase execution
- phase listener registration API
- queued-command queue
- scheduled-trigger queue
- deterministic debug signature/event stream
- phase duration tracking and recent history tracking

Current phase order:
1. command intake
2. time-step start
3. world pre-update
4. simulation update
5. visibility refresh
6. debug snapshot
7. end-of-tick bookkeeping

### 2.7 Current debug UI
Implemented:
- compact debug HUD
- scrollable panel so the full runtime debug state remains visible
- visible bootstrap fields:
  - scenario ID
  - stage ID
  - map preset ID
  - worldgen profile ID
  - season profile ID
  - seed
- visible calendar/run-loop fields:
  - tick/day/year/season/part-of-day/ticks-per-part
  - pause/running state
  - speed index / multiplier
  - active/visible/last-completed phase state
  - recent phase history
  - per-phase durations
  - scheduled-trigger counts and preview
  - queued-command counts and preview
  - determinism signature/event counters
  - definition validation counts
- toggle with **F3**

### 2.8 Current Branch 02 proof probe
Implemented:
- `scripts/runtime/debug/debug_scheduled_trigger_probe.gd`

What it proves:
- external systems can subscribe to Branch 02 runtime behavior without owning `TimeService`
- external systems can schedule future triggers
- resolved triggers can enqueue commands
- commands queued after command-intake resolve on the **next tick**, not the same tick

### 2.9 Current presentation status
Still intentionally placeholder/debug:
- synthetic aerial-style world renderer
- river/pond/terrain color patches
- seeded tree placement
- site hint marker
- zoomed-out camera

This is still **not** the authoritative world model.

---

## 3. What Branch 02 proved

Branch 02 proved that the project can now:
- advance time in deterministic ticks
- keep a stable ordered phase contract each tick
- expose pause/resume/speed/step controls without burying logic in scene scripts
- let later systems subscribe through phase listeners rather than owning the run loop
- queue future work deterministically through scheduled triggers and queued commands
- expose deterministic debug metadata to the HUD/telemetry layer
- keep the clock/calendar state authoritative in `TimeService`

That is exactly what Branch 02 was supposed to do.

---

## 4. What is still intentionally not implemented

Do **not** mistake the current shell for deeper gameplay progress.

Still not implemented:
- authoritative world cell data model
- authored-map loader into simulation state
- fog-of-war data/model/rendering
- NPC body-state runtime
- item runtime instances / inventories / storage behavior
- task runtime execution
- pathfinding / movement / hauling
- actual incident runtime queue/triggering
- production HUD/UI panels
- real survival pressure simulation

Those belong to later branches.

---

## 5. Recommended next branch

### Branch 03 — world data model + hand-authored maps

This should be the next assistant’s main focus.

Correct next tasks:
1. create the first authoritative world cell/patch state containers
2. load one authored starter map into runtime truth
3. keep the current placeholder renderer clearly separate from authoritative map data
4. expose world cells through a debug inspector
5. add starter-map data that reflects real campsite trade-offs from the docs

The goal is:
- no deep NPC survival behavior yet
- no fancy procgen yet
- no renderer overreach yet
- just make world terrain/state authoritative, inspectable, and ready for later systems

---

## 6. Important technical rules to preserve

- do not add `class_name` to autoload scripts
- prefer explicit local typing in the bootstrap/runtime shell
- keep content in `data/defs/`, not hardcoded in presentation scripts
- keep scene nodes as presentation, not simulation truth
- do not replace definition-driven bootstrap with ad hoc code paths
- do not turn placeholder map rendering into the real world model
- do not bypass `TimeService` for deterministic tick progression
- do not jump to Branch 04+ presentation/gameplay depth before Branch 03 world truth lands

---

## 7. Practical instruction for the next assistant

The correct mindset is:

**Branch 00 is done.**
**Branch 01 is done enough to close.**
**Branch 02 is done enough to close.**
**Do not redesign the project.**
**Start Branch 03 and keep it narrow.**

The next assistant should work in small, implementation-focused steps and keep everything:
- data-driven
- modular
- future-proof
- aligned with the docs and realism-first design intent

---

## 8. Manual reproducibility note

A useful Branch 02 smoke test is:
- boot the default scenario/seed
- keep the same seed
- use the same pause/step inputs
- compare determinism signature + event counts after the same number of steps

If the startup state and input sequence match, the Branch 02 debug signature should match too.

---

## 9. Final note

The project is in a good state for handoff.

The shell is real.
The definition backbone is real.
The bootstrap chain is definition-driven.
The simulation clock/run loop is now real.

The next assistant should focus on **Branch 03** and keep the project disciplined.
