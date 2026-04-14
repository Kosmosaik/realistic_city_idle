# Realistic Idle City — Development Roadmap v0.1

## Purpose

This roadmap defines the intended implementation branch order for the early-game MVP.

It now includes a status update after **Branch 02 — simulation clock and run loop**.

---

## Current status snapshot

- **Branch 00 — repo-bootstrap: complete**
- **Branch 01 — core-definitions-and-ids: complete enough to close**
- **Branch 02 — simulation-clock-and-run-loop: complete enough to close**
- **Next active branch: Branch 03 — world-data-model-and-hand-authored-map**

Current implementation notes:
- project boots cleanly into the dev world
- bootstrap context resolves through scenario -> worldgen -> season -> map preset
- current validated seed pack size: **122 definitions**
- `TimeService` now owns deterministic tick progression, phase ordering, pause/step/speed controls, scheduled triggers, and queued commands
- debug HUD exposes Branch 02 calendar/run-loop/determinism state
- authoritative world cells and authored-map runtime loading are **not** implemented yet

---

## Branch 00 — repo-bootstrap

### Status
**Complete**

### Goal
Create the clean project skeleton with folders, naming conventions, autoloads, scenes, and placeholder test map support.

### Deliverables
- Godot project created/cleaned
- folder structure matching architecture docs
- autoload registration for core services only
- boot scene
- test world scene
- debug/dev settings asset
- seed/config file location conventions

### Exit criteria
- project launches cleanly
- test scene loads
- no architecture ambiguity for core folders/scripts

---

## Branch 01 — core-definitions-and-ids

### Status
**Complete enough to close**

### Goal
Implement the basic definition-loading and canonical ID infrastructure.

### Deliverables
- definition resource base classes
- item/process/structure/skill/stage ID validation helpers
- dictionary-driven enums/constants module
- definition registry loading from resources
- duplicate-ID detection
- cross-reference validation
- visible validation report
- definition-driven bootstrap resolution for scenario/worldgen/season/map context

### Actual result summary
Implemented families/resources now include:
- stages
- skills
- items
- processes
- structures
- scenarios
- map presets
- species
- terrain profiles
- worldgen profiles
- season profiles
- incidents
- UI panels

Current validated seed pack size: **122 definitions**.

### Exit criteria
- project can load a non-trivial canonical definition set
- invalid IDs fail loudly
- dictionary vocabulary has a code home
- active bootstrap chain resolves from definitions

---

## Branch 02 — simulation-clock-and-run-loop

### Status
**Complete enough to close**

### Goal
Stand up the authoritative simulation clock and tick sequencing.

### Deliverables
- simulation clock service
- tick phases
- pause/speed controls
- stable boundary hooks for save/debug
- deterministic update ordering policy

### Actual result summary
Implemented Branch 02 backbone now includes:
- deterministic tick progression in `TimeService`
- stable ordered phases for:
  - command intake
  - time-step start
  - world pre-update
  - simulation update
  - visibility refresh
  - debug snapshot
  - end-of-tick bookkeeping
- pause / resume
- speed controls
- single-step debug
- phase listener registration API
- queued-command queue + processing
- scheduled-trigger queue + resolution
- deterministic debug signature/event tracking
- HUD exposure of phase state, queue previews, and determinism diagnostics
- external probe proving trigger-to-next-tick-command behavior outside `TimeService`

### Exit criteria
- game can advance time in deterministic ticks
- pause/speed works
- other systems can subscribe safely

---

## Branch 03 — world-data-model-hand-authored-map

### Status
**Next**

### Goal
Build the simulation-side world representation before fancy generation.

### Deliverables
- cell/patch world data model
- terrain/elevation/drainage/wetness storage
- zone primitives
- hand-authored test map format
- one balanced starter map
- one harsh edge-case map

### Exit criteria
- world loads from authored data
- cells expose terrain facts to systems
- no procgen required yet

---

## Branch 04 — map-renderer-camera-fog

### Status
Not started

### Goal
Make the world readable and explorable.

### Deliverables
- layered map rendering
- zoomable camera
- aerial/topo/hybrid mode scaffolding
- fog-of-war and remembered terrain
- scout/reveal radius support
- debug terrain overlays

### Exit criteria
- player can read and navigate the map
- unknown land stays hidden until revealed
- rendering respects simulation data

---

## Branch 05 — npc-core-body-state

### Status
Not started

### Goal
Implement the minimal NPC runtime state needed for survival.

### Deliverables
- NPC runtime entity/state
- hunger, thirst, fatigue, wetness, temperature exposure basics
- emergency override flags
- simple inventory/carry capacity state
- basic skill/interest placeholders

### Exit criteria
- one NPC can exist in authoritative runtime state
- core survival variables update through the simulation clock

---

## Roadmap note

The current project discipline is still correct:
- Branch 00 and Branch 01 laid the shell and vocabulary
- Branch 02 laid the deterministic time backbone and inspectable run loop
- the next safe move is authoritative world data + authored maps
- do not skip ahead into NPC/runtime gameplay depth before Branch 03 lands
