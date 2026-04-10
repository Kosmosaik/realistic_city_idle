# Realistic Idle City — Development Roadmap v0.1

## Purpose

This document converts the early-game implementation pack into a practical development roadmap.

It is designed for:
- small, reviewable branches
- frequent playable checkpoints
- low-risk integration
- clear stop/go points
- protecting the survival-to-hamlet scope from sideways expansion

This roadmap assumes the project remains focused on the early-game MVP:
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It also assumes the current design stance:
- realism-first, but balanced and fun
- explicit objects/systems from the start
- policy/priority/order-based control
- minimal NPC/object visuals, with richer map readability allowed where it helps

---

## 1. Do we need anything else before development?

Very little.

The project is past the point of needing more large design bibles.
Before the first real coding sprint, the only recommended pre-dev work is:

1. apply the existing patch list
2. freeze the authoritative early-game doc set for Sprint 1
3. create a lightweight project index
4. decide the exact branch/review workflow

That means development can begin very soon.

### 1.1 Required pre-flight tasks

#### Preflight A — Apply doc patch list
Apply the already identified consistency patches first.

Focus areas:
- task lifecycle enum alignment
- item location-state alignment
- process state addition to dictionary
- stage ID normalization
- exploration/fog authority cleanup
- downstream enum reference sweep

#### Preflight B — Freeze Sprint 1 source-of-truth set
Mark a short list of documents as authoritative for the first build sprint.
Recommended freeze set:
- Early Game MVP Build Spec
- Unified Data Dictionary
n- Balance / Constants Sheet
- System Flow / State Machine Pack
- World Generation + Map Rendering Spec
- Save / Load Schema
- Godot Project / Scene Architecture
- Godot Class / File Responsibility Matrix
- Acceptance Criteria / Test Checklist
- Debug / Telemetry Spec

#### Preflight C — Create a project index
One short doc or README section listing:
- authoritative docs
- patched docs
- superseded docs
- current implementation milestone
- current branch in progress

#### Preflight D — Decide branch workflow
Recommended:
- one branch = one narrow feature slice
- branch should end in a runnable state whenever possible
- avoid giant “foundation” branches with no visible outcome
- merge only when acceptance notes for that slice are written

---

## 2. Development strategy

The build should proceed in **thin vertical slices**, not giant subsystem dumps.

Good principle:
- every 1–3 branches should improve the game in a visible/testable way
- do not fully build every manager before any gameplay exists
- do not wait for procgen, advanced AI, or polished UI before proving the survival loop

### 2.1 Three implementation phases

#### Phase 1 — Playable solo survival core
Goal:
A single NPC can spawn into a hand-authored test map and survive for several days through water, calories, sleep, fire, shelter, hauling, and basic task execution.

#### Phase 2 — Primitive/permanent camp systems
Goal:
The player can stabilize the site with storage, sanitation, preservation, basic crafting, better shelter, and clearer reserve logic.

#### Phase 3 — Tiny hamlet transition
Goal:
Second and third NPCs arrive, work distribution emerges, site grows into a small multi-person camp/hamlet, and stage logic becomes meaningful.

---

## 3. Branch roadmap

The branch names below are examples. Adjust naming style to your repo conventions.

---

## Branch 00 — repo-bootstrap

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

### Must not include
- gameplay logic beyond boot sanity
- premature content complexity

### Exit criteria
- project launches cleanly
- test scene loads
- no architecture ambiguity for core folders/scripts

---

## Branch 01 — core-definitions-and-ids

### Goal
Implement the basic definition-loading and canonical ID infrastructure.

### Deliverables
- definition resource base classes
- item/process/structure/skill/stage ID validation helpers
- dictionary-driven enums/constants module
- definition registry loading from resources
- duplicate-ID detection

### Exit criteria
- project can load a minimal definition set
- invalid IDs fail loudly
- dictionary vocabulary has a code home

---

## Branch 02 — simulation-clock-and-run-loop

### Goal
Stand up the authoritative simulation clock and tick sequencing.

### Deliverables
- simulation clock service
- tick phases
- pause/speed controls
- stable boundary hooks for save/debug
- deterministic update ordering policy

### Exit criteria
- game can advance time in deterministic ticks
- pause/speed works
- other systems can subscribe safely

---

## Branch 03 — world-data-model-hand-authored-map

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

### Goal
Implement the minimal NPC runtime state needed for survival.

### Deliverables
- NPC runtime entity/state
- hunger, thirst, fatigue, wetness, temperature exposure basics
- emergency override flags
- simple inventory/carry capacity state
- basic skill/interest placeholders

### Exit criteria
- one NPC can exist with meaningful needs
- body state changes over time
- emergency conditions can force behavior priority changes

---

## Branch 06 — item-runtime-storage-foundations

### Goal
Implement authoritative item instances and storage behavior.

### Deliverables
- item runtime instances
- item location states
- stack/split/merge rules
- ground items
- simple stockpoint/storage entity support
- reserve/claim basics for items

### Exit criteria
- items can exist in world, inventory, and storage
- items can be moved without duplication/desync

---

## Branch 07 — task-system-v1

### Goal
Stand up the minimal task lifecycle from generation to completion.

### Deliverables
- task model
- candidate generation hooks
- task scoring/select/selectability
- reservation coupling
- interruption/cancel/block handling
- direct-order insertion path

### Exit criteria
- NPC can choose or receive work
- tasks have traceable lifecycle states
- debug view explains why a task was or was not chosen

---

## Branch 08 — pathfinding-movement-hauling

### Goal
Make NPCs physically move through terrain and carry things.

### Deliverables
- grid pathfinding using terrain cost
- movement over time
- hauling effort penalties
- path cache rules if needed
- blocked-path response
- pickup/dropoff interactions

### Exit criteria
- NPC traverses world believably
- hauling distance/terrain matters
- movement ties into task execution

---

## Branch 09 — water-fire-sleep-food-core

### Goal
Create the first true survival loop.

### Deliverables
- get water / drink task chain
- gather calories basics
- rest/sleep behavior
- fire creation/maintenance basics
- water container basics if included in MVP cut
- emergency reprioritization around survival needs

### Exit criteria
- one NPC can survive short-term through actual actions
- failure to secure water/sleep/calories causes visible decline

### Milestone
**First runnable survival prototype**

---

## Branch 10 — shelter-storage-sanitation

### Goal
Make camp quality matter.

### Deliverables
- minimal shelter placement/use
- sheltered sleep improvement
- storage vs ground exposure differences
- sanitation zone designation
- contamination-distance checks
- camp layout signals

### Exit criteria
- camp siting/layout has gameplay consequences
- bad sanitation and bad storage are visibly worse than good practice

---

## Branch 11 — spoilage-preservation-basic-crafting

### Goal
Turn immediate survival into short-term stability.

### Deliverables
- spoilage timers/state transitions
- simple preservation chain(s)
- basic processing stations or workspots
- primitive crafting loop
- container usefulness

### Exit criteria
- food handling/storage quality matters over time
- player can reduce losses through better setup

---

## Branch 12 — weather-health-injury-response

### Goal
Add the first meaningful realism pressure beyond simple meters.

### Deliverables
- weather events or weather states
- wet-cold stress
- minor injury/fatigue penalties
- simple care/rest recovery behavior
- hazard-triggered task reprioritization

### Exit criteria
- weather and injury create believable disruptions
- care/rest decisions matter

---

## Branch 13 — second-npc-arrival-and-social-load

### Goal
Transition from solo survival to a tiny social unit.

### Deliverables
- newcomer arrival event path
- minimal social/recruitment hookup
- role/work distribution
- shared reserves and consumption logic
- sleeping/eating/water competition edge cases

### Exit criteria
- second NPC does not break simulation truth
- multi-person workload feels better but introduces coordination friction

### Milestone
**Primitive camp proven**

---

## Branch 14 — progression-stage-checks

### Goal
Make stage transitions explicit and testable.

### Deliverables
- stage evaluation service
- promotion/regression checks
- UI indication of settlement stage
- debug report on unmet conditions

### Exit criteria
- game can explain why it is still lone_survivor / primitive_camp / permanent_camp
- stage changes are deterministic and inspectable

---

## Branch 15 — gardens-seed-saving-first-managed-production

### Goal
Introduce the first low-depth managed production system.

### Deliverables
- seed retention logic
- simple plot designation
- planting/tending/harvest basics
- season sensitivity at MVP level
- crop failure simplifications where needed

### Exit criteria
- first managed plots exist
- agriculture begins as support, not instant abundance

---

## Branch 16 — permanent-camp-structures-and-worksites

### Goal
Cross from improvised camp to persistent small settlement.

### Deliverables
- better shelters
- persistent work areas
- improved storage/craft areas
- path wear or simple path designation
- expanded camp zoning

### Exit criteria
- settlement feels persistent rather than purely temporary

---

## Branch 17 — telemetry-and-debug-panels

### Goal
Make the game explain itself.

### Deliverables
- live debug panels
- task/state event logging
- NPC reason traces
- map/debug overlays
- failure-chain reconstruction tools

### Exit criteria
- major simulation failures can be diagnosed quickly
- acceptance scenarios become practical to run

---

## Branch 18 — save-load-v1

### Goal
Make long-run testing possible.

### Deliverables
- slot system
- save serialization
- load reconstruction
- validation checks
- safe-write flow
- simple version stamp support

### Exit criteria
- stable save/load round trip on active runs
- load does not duplicate actors/items/tasks

---

## Branch 19 — tiny-hamlet-stabilization

### Goal
Prove the target MVP endpoint.

### Deliverables
- 3–8 NPC support at MVP fidelity
- reserve pressure under multiple consumers
- basic specialization emergence
- camp-to-hamlet stability checks
- balancing pass for throughput and failure rates

### Exit criteria
- tiny hamlet is reachable and sustain-able in test scenarios

### Milestone
**Tiny hamlet MVP achieved**

---

## Branch 20 — acceptance-sweep-and-hardening

### Goal
Bring the project to “real first implementation milestone” quality.

### Deliverables
- full acceptance checklist sweep
- balance iteration pass
- bug triage wave
- doc corrections from real implementation findings
- known-issues list
- next-phase backlog draft

### Exit criteria
- must-pass scenarios complete
- blockers understood or fixed
- project is ready for the next roadmap phase

---

## 4. Recommended merge rhythm

Use a repeating rhythm:

1. narrow branch
2. merge
3. quick stabilization pass
4. short test note
5. next narrow branch

Avoid stacking 6–8 unmerged branches.
That usually hides integration problems too long.

A good rule:
- if a branch cannot be summarized in one sentence, it may be too large

---

## 5. What should not be done too early

Do not start with:
- full procedural world generation
- continent/world-scale map generation
- deep social simulation breadth
- complex trade economy
- advanced combat/raids
- beautiful final UI polish
- dozens of craft chains
- late-era transport/industry systems

Those are all valid later, but they will slow the MVP.

---

## 6. Suggested milestone grouping

If you want broader milestone buckets instead of single branches:

### Milestone A — Foundation
Branches 00–04

### Milestone B — Solo survival proof
Branches 05–09

### Milestone C — Camp quality and stability
Branches 10–12

### Milestone D — Multi-person transition
Branches 13–16

### Milestone E — Production hardening
Branches 17–18

### Milestone F — MVP proof
Branches 19–20

---

## 7. Strong recommendation

Yes, you should have a roadmap before development.
And yes, it should be in **small branches**.

The project is now at the point where the right move is:
- patch/freeze
- bootstrap the repo
- build the solo survival loop on hand-authored maps
- then grow toward primitive camp and tiny hamlet

That is the safest path to a real playable build.

