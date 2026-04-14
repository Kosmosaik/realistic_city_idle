# Realistic Idle City — Godot Bootstrap / First Sprint Implementation Plan v0.2

## Purpose

This document remains the implementation plan for the early foundation sprint, but it now includes a status update after **Branch 01 — core definitions and IDs**.

This plan still covers the same early branch chain:
- Branch 00 — repo bootstrap
- Branch 01 — core definitions and IDs
- Branch 02 — simulation clock and run loop
- Branch 03 — world data model + hand-authored maps
- Branch 04 — map renderer + camera + fog of war

The difference now is that Branch 00 and Branch 01 are no longer just planned work.
They are implemented enough to be treated as completed milestones.

---

## 1. Current sprint status

### 1.1 Completed branches
- **Branch 00 — repo bootstrap: complete**
- **Branch 01 — core definitions and IDs: complete enough to hand off**

### 1.2 Current active next branch
- **Branch 02 — simulation-clock-and-run-loop**

### 1.3 What Sprint 1 still has left after Branch 01
Sprint 1 is not fully complete yet because Branch 02–04 are still outstanding.

Still missing for the full Sprint 1 chain:
- deterministic simulation ticking
- pause/resume/single-step controls
- authoritative world data model
- authored-map runtime loading into simulation state
- fog-of-war data/model/render integration
- richer debug inspection tied to authoritative world data

---

## 2. What Branch 00 actually delivered

Branch 00 successfully delivered:
- clean Godot boot shell
- project folder structure
- autoload service layer
- boot scene and dev world scene
- placeholder world presentation
- compact debug HUD
- visible scenario ID / seed / calendar snapshot

Current core autoloads:
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `SimRoot`
- `AppRoot`

---

## 3. What Branch 01 actually delivered

Branch 01 successfully delivered:
- `DefinitionRegistry` autoload
- canonical ID rules
- duplicate-ID detection
- cross-reference validation
- visible validation report
- boot failure UI for invalid definitions/bootstrap
- shared code vocabulary helpers:
  - `calendar_ids.gd`
  - `definition_types.gd`
  - `id_rules.gd`
  - `policy_bundle_ids.gd`
  - `shared_enums.gd`
  - `task_def_ids.gd`
  - `zone_types.gd`
- definition Resource families for:
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
- explicit bootstrap resolution through:
  - `ScenarioDef`
  - `WorldgenProfileDef`
  - `SeasonProfileDef`
  - `MapPresetDef`
  - `TimeService`
- current validated seed pack size: **122 definitions**

Important implementation notes captured by Branch 01:
- the project uses `DefinitionRegistry`, not a hypothetical `DefinitionDB`
- the active session/bootstrap holder is `SimRoot`, not a separate `GameSession`
- `SeedService` was not created; seed/bootstrap responsibility currently lives inside `SimRoot`
- a separate `scenario_bootstrapper.gd` was not created; bootstrap resolution currently lives in `BootScene` + `SimRoot`
- `scripts/core/defs/base_defs.gd` is the current base definition file name and exports `class_name BaseDef`

---

## 4. Updated branch status table

| Branch | Status | Notes |
|---|---|---|
| Branch 00 — repo bootstrap | Complete | Stable boot shell and debug world path exist |
| Branch 01 — core definitions and IDs | Complete enough to hand off | Data backbone, validation, and bootstrap resolution exist |
| Branch 02 — simulation-clock-and-run-loop | Next | Should be started now |
| Branch 03 — world-data-model-hand-authored-map | Not started | Wait for Branch 02 |
| Branch 04 — map-renderer-camera-fog | Not started | Wait for Branch 03 groundwork |

---

## 5. Branch 02 — simulation-clock-and-run-loop

### Goal
Stand up the deterministic simulation backbone.

### Must deliver
- authoritative tick clock
- pause / resume
- speed controls
- single-step debug
- stable phase order
- deterministic seed usage hook
- day / part-of-day / season exposure

### First-pass time state
- absolute tick
- day index
- current part-of-day
- current season token
- current year placeholder
- scenario seed
- current season-profile-derived defaults already bootstrapped from Branch 01

### Exit criteria
- same seed + same startup scenario yields stable tick ordering
- pause/resume works
- single-step works
- day/part-of-day/season display updates predictably
- runtime time state remains debug-visible

### Must not include
- full weather
- full daily AI planning
- authored world data model creep
- gameplay systems that depend on the missing world/runtime layers

---

## 6. Branch 03 — world-data-model-hand-authored-map

### Goal
Build the simulation-side world representation before fancy generation.

### Must deliver
- cell/patch world data model
- terrain/elevation/drainage/wetness storage
- zone primitives
- hand-authored test map format
- one balanced starter map
- one harsh edge-case map

### Important note
Branch 03 should consume the definitions/vocabulary already established in Branch 01 rather than inventing parallel IDs.

---

## 7. Branch 04 — map-renderer-camera-fog

### Goal
Make the world readable and explorable against the authoritative world model.

### Must deliver
- layered map rendering
- zoomable camera
- fog-of-war and remembered terrain
- reveal source support
- debug terrain overlays driven by world truth

### Important note
The current placeholder world renderer should be treated as disposable once Branch 03 world truth exists.

---

## 8. Current acceptance result

### Branch 00 acceptance: pass
- project runs cleanly
- boot path is understandable
- dev world loads

### Branch 01 acceptance: pass
- definition pack loads from assets
- malformed IDs fail loudly
- duplicate IDs are detected
- bootstrap chain resolves from definitions
- definition validation is visible in the HUD
- vocabulary needed by later world/policy/incident/panel systems has a code home

### Sprint 1 overall acceptance: not yet complete
Because Branch 02–04 are still pending.

---

## 9. Final stance

The correct next move is now very clear:

**Do not keep expanding content definitions sideways.**
**Do not jump ahead to NPC/gameplay systems.**
**Start Branch 02 and make time deterministic.**

That is the cleanest way to protect the work already done in Branch 01.
