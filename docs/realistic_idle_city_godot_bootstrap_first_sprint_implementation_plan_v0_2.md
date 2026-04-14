# Realistic Idle City — Godot Bootstrap / First Sprint Implementation Plan v0.2

> Filename retained for replacement convenience. Content now reflects the project **after Branch 02**, while keeping the same Sprint 1 branch shape.

## Purpose

This document is the **full-scope-verified** version of the first sprint plan.

It keeps the original Sprint 1 cut intact:
- Branch 00 — repo bootstrap
- Branch 01 — core definitions and IDs
- Branch 02 — simulation clock and run loop
- Branch 03 — world data model + hand-authored maps
- Branch 04 — map renderer + camera + fog of war

But this version has been checked against the **broader document universe**, not only the newer implementation docs.

It is meant to stay compatible with:
- the base design and early-game bible
- the canonical early content pack
- the world / map / site generation spec
- the time / season / labor calendar spec
- the UI information architecture spec
- the player orders / policy spec
- the logistics / hauling / storage flow spec
- the settlement progression spec
- the NPC schema/simulation docs
- the implementation-pack docs created later

The goal is to make sure Sprint 1 still makes sense when the **whole project** is kept in view.

---

## 1. Verification result

### 1.1 Current status answer

Yes — the original Sprint 1 shape is still the correct shape.

Current branch status:
- **Branch 00 — repo bootstrap: complete**
- **Branch 01 — core definitions and IDs: complete enough to close**
- **Branch 02 — simulation clock and run loop: complete enough to close**
- **Next active branch: Branch 03 — world data model + hand-authored maps**

It was right to begin with:
- project/bootstrap
- definitions and vocabulary
- deterministic time backbone
- authoritative world data
- hand-authored maps
- map rendering / zoom / overlays / fog

and **not** begin with:
- full survival simulation
- crafting depth
- hauling optimization
- weather simulation depth
- procedural continent generation
- polished UI

### 1.2 What Branch 02 now proves

The branch order remains correct, and Branch 02 successfully established the runtime backbone that Sprint 1 needed before authoritative world data.

Implemented Branch 02 proof points:
1. **Calendar compatibility exists in runtime now**
   - tick / day / part-of-day / season / year placeholder all exist in the authoritative clock service.
2. **Scenario + seed determinism is visible now**
   - startup scenario identity, seed, run-loop events, and a rolling determinism signature are debug-visible.
3. **Stable phase order exists now**
   - the run loop executes a fixed ordered phase chain each tick.
4. **Safe external subscription exists now**
   - external systems can register phase listeners without owning the clock.
5. **Deferred work boundaries exist now**
   - scheduled triggers and queued commands already prove next-tick sequencing behavior.
6. **Branch 03 can stay narrow now**
   - world data can be introduced on top of a real deterministic clock rather than inside ad hoc scene code.

So:
- the original plan was **right**
- Branch 02 now meaningfully completes the deterministic time/backbone slice
- the next implementation focus should move cleanly to **authoritative world data and authored maps**

---

## 2. Source-of-truth order for Sprint 1

Use this authority order during implementation:

1. latest user instructions in the active chat
2. handoff summary
3. patch list + consistency/conflict audit
4. Early Game MVP Build Spec
5. Unified Data Dictionary
6. World Generation + Map Rendering Spec
7. System Flow / State Machine Pack
8. Godot Project / Scene Architecture
9. Godot Class / File Responsibility Matrix
10. Balance / Constants, Telemetry, Save/Load, Acceptance docs
11. **Compatibility anchors from the older stack**:
   - Early Game Bible
   - Canonical Early Content Pack
   - World / Map / Site Generation Spec (older design doc version)
   - Time / Season / Labor Calendar Spec
   - Player Orders / Policy Spec
   - Logistics / Hauling / Storage Flow Spec
   - Settlement Progression Spec
   - UI Information Architecture Spec
   - NPC Data Schema + NPC Simulation Spec
12. other older docs where still compatible

### Practical rule

Sprint 1 should primarily follow the newer implementation pack, **but it must not violate the compatibility anchors above**.

---

## 3. What Sprint 1 is for

Sprint 1 is a **foundation sprint**.

Its job is to produce a runnable Godot foundation where the following are already true:
- the project boots cleanly
- definitions load and validate
- a deterministic seed and scenario are visible
- time advances in deterministic phases
- the world is stored as authoritative simulation data
- at least one authored starter map loads
- the map is readable at multiple zoom levels
- fog of war hides unknown land and remembers revealed land
- developers can inspect cells, overlays, and startup state

Sprint 1 should give the project a trustworthy substrate for Branches 05–09.

---

## 4. Non-negotiable Sprint 1 compatibility rules

These came out of the full-scope review.

### 4.1 Time must already be calendar-shaped

Even before deep weather/survival systems exist, the clock must already expose:
- tick
- day index
- part of day / daylight phase
- season token
- year index placeholder

Do **not** build a bare numeric tick counter that later has to be reworked into calendar time.

### 4.2 Map fixtures must already reflect early survival doctrine

The first authored maps must already express the early-game truths from the older design stack:
- water access is urgent but not equal to safety
- dry sleeping/building ground matters
- sanitation separation matters
- terrain trade-offs matter
- there should be at least one site that looks convenient but is strategically worse

### 4.3 Policy / zone vocabulary must exist before policy gameplay exists

Sprint 1 does not need full order execution.
But the data vocabulary for it should already exist:
- zone families
- policy bundle IDs
- order type IDs / placeholders
- stockpoint role types
- water-use / sleep / waste / worksite zone categories

### 4.4 Content IDs should match the canonical early content pack

Sprint 1 can remain implementation-light, but the IDs should not be invented loosely.
The minimum set should resemble the canonical early content pack’s minimum subset.

### 4.5 Fog of war must separate unknown from remembered

At the data level, at minimum distinguish:
- unknown / never seen
- revealed / remembered
- currently visible (optional visual distinction now, required later)

### 4.6 Stage progression must remain condition-driven

Sprint 1 does not need the stage evaluator yet, but it **must** leave room for stage computation from conditions rather than hard-setting stage by fiat.
That means the world and settlement state should already have places for:
- zone quality
- support/security metrics
- structure families present
- reserve categories placeholder
- population continuity placeholder

---

## 5. Required preflight before Branch 00

Before coding begins:

### 5.1 Apply the existing patch list
Required patch areas already identified:
- task lifecycle enum alignment
- item location-state alignment
- process lifecycle enum addition
- stage ID normalization
- fog/exploration ownership cleanup
- downstream enum reference sweep

### 5.2 Freeze the Sprint 1 source-of-truth set
Freeze the same implementation-pack docs as before, but also explicitly note the older compatibility anchors:
- Early Game Bible
- Canonical Early Content Pack
- Time / Season / Labor Calendar Spec
- Player Orders / Policy Spec
- Logistics / Hauling / Storage Flow Spec
- Settlement Progression Spec
- UI Information Architecture Spec
- NPC Data Schema

### 5.3 Create a developer project index
This should point to:
- frozen docs
- current sprint branch order
- branch naming convention
- engine version
- test fixture list
- compatibility anchors

### 5.4 Pin engine version
Use one exact Godot 4.x stable version for all of Sprint 1.

---

## 6. Sprint 1 branch boundaries

Sprint 1 remains:
- Branch 00 — repo bootstrap
- Branch 01 — core definitions and IDs
- Branch 02 — simulation clock and run loop
- Branch 03 — world data model + hand-authored maps
- Branch 04 — map renderer + camera + fog

This is still the right stopping point.

### Why this still works with full scope

Because almost every older doc depends on these shared foundations:
- IDs and definitions
- authoritative time
- map/site truth
- visibility and overlays
- inspectability/debuggability

If those are wrong, later NPC, logistics, survival, storage, stage, and policy systems all become messy.

---

## 7. Branch 00 — repo bootstrap

### Status
**Complete**

### Goal
Create a clean Godot project shell and prove a stable boot path into a dev world scene.

### Must deliver
- Godot project created and launches cleanly
- folder structure created
- minimal autoloads registered
- boot scene
- test world scene
- tiny dev HUD
- startup scenario/seed display
- lightweight project index / README

### Additional full-scope requirements
- show **scenario ID** and **seed** in the dev HUD from day one
- add a clearly visible **engine version** / build version label in dev mode
- make the map view the main visual anchor, not big menus or placeholder chrome

### Exit criteria
- clean boot into dev world scene
- seed/scenario visible
- no missing-scene / missing-script churn
- new contributor can tell where code and content should go

### Must not include
- survival logic
- pathfinding
- production HUD
- procgen depth

---

## 8. Branch 01 — core definitions and IDs

### Status
**Complete enough to close**

### Goal
Create the canonical definition layer and shared project vocabulary in code.

### Must deliver
- base Resource classes for definitions
- canonical ID rules
- definition registry load pipeline
- duplicate-ID detection
- malformed-ID fatal validation
- visible validation report

### Definition families that must exist in Sprint 1

#### Core
- stage definitions
- skill definitions
- item definitions
- process definitions
- structure definitions
- scenario definitions
- map preset / authored map definitions

#### Compatibility-required placeholders
- zone family definitions or enums
- alert severity / alert type definitions or enums
- fog state enum
- landform / slope / drainage / vegetation enums
- water source type enum
- policy bundle placeholder definitions
- order type placeholder IDs
- stockpoint role / storage role enums

### Minimum content IDs to seed now
These should align more closely to the canonical early content pack.

#### Items
- untreated water
- boiled / safe water
- hammer stone
- sharp flake
- dry twig bundle
- small dry branch
- brush bundle
- crude pole
- edible mixed plants
- raw small game placeholder
- cooked food placeholder
- fiber bundle
- hide placeholder
- stone chunk / fractured stone
- crude container placeholder

#### Processes
- scout local area
- collect water
- boil water
- gather deadwood
- clear sleep ground
- build debris lean-to
- build hearth
- gather edible plants
- butcher small game placeholder
- cook food

#### Structures / sites / zones
- cleared sleep spot
- lean-to
- small hearth
- covered cache
- drying rack
- waste pit / cathole area
- clean water area
- stockpoint placeholder
- small garden plot placeholder
- pottery workspot placeholder

#### Tasks / intents (definition-only if needed)
- fetch water
- gather fuel
- maintain fire
- get food
- cook food
- rest
- build shelter
- repair shelter
- preserve food
- protect seed
- scout nearby area

### Exit criteria
- a small canonical definition pack loads from assets
- startup validation catches ID drift loudly
- vocabulary needed by world/policy/zone/fog systems already exists

### Must not include
- deep runtime item logic
- full crafting logic
- full policy execution logic

---

## 9. Branch 02 — simulation clock and run loop

### Status
**Complete enough to close**

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

### Actual result summary
Implemented Branch 02 backbone now includes:
- authoritative deterministic tick progression in `TimeService`
- pause / resume control
- speed controls
- single-step debug
- stable phase order
- calendar state exposure for tick/day/part-of-day/season/year placeholder
- deterministic seed refresh and debug-visible determinism signature
- phase listener registration/unregistration for external systems
- queued-command queue and processing
- scheduled-trigger queue and resolution
- latched debug visibility for active/recent phases
- per-phase duration tracking
- debug queue previews for triggers and commands
- external scheduled-trigger probe proving next-tick command behavior

### Required first-pass time state
- absolute tick
- day index
- current day segment / daylight phase
- current season token
- current year placeholder
- scenario seed and active RNG stream handle

### Implemented phase order
1. input / command intake
2. time-step start
3. world/system pre-update
4. simulation update
5. visibility / overlay refresh hook
6. debug snapshot point
7. end-of-tick bookkeeping

### Full-scope compatibility additions
- a stable phase boundary exists for future save/debug work even though save integration is still stubbed
- time is exposed in a way later docs can map onto daylight, weather pressure, labor capacity, and seasonal deadlines
- deterministic run metadata is exposed to telemetry/debug

### Exit criteria
- same seed + same startup scenario yields stable tick ordering
- pause/resume works
- single-step works
- day/part-of-day/season display updates predictably

### Must not include
- full weather
- full daily AI planning
- full survival decay
- authoritative world cells
- authored-map loading

---

## 10. Branch 03 — world data model + hand-authored maps

### Status
**Next active branch**

### Goal
Implement the first authoritative world model and load authored starter maps.

### Must deliver
- authoritative local map state
- cell / patch data containers
- authored map asset format
- one balanced starter map
- one second map that expresses a worse / trickier site profile if possible
- cell inspector

### Minimum authoritative world fields
Per cell/patch, at minimum:
- coordinates
- elevation step
- slope class
- landform type
- drainage class
- wetness tendency
- vegetation / surface cover class
- movement cost
- buildability
- fog state
- remembered/revealed state
- optional current-visibility flag placeholder
- point-of-interest / feature markers placeholder
- zone stamp placeholder

### Starter-map doctrine requirements
The authored maps should already satisfy the world/site-generation doctrine.
A starter exploration zone should include:
- one discoverable usable water route
- one dry-enough sleeping/building zone
- nearby deadwood / woody biomass
- a lithic / stone source
- some food potential
- enough room for camp / waste / water-use separation
- at least one visually tempting but strategically worse site

### Strongly recommended authored fixtures
- `starter_map_balanced`
- `starter_map_wet_annoying`
- optional `starter_map_rocky_spring`

### Full-scope compatibility additions
- attach lightweight **site-quality tags or site-score debug values** to candidate areas
- support at least placeholder POIs for water, stone, biomass, and camp-suitable ground
- leave room for later stockpoints, worksite buffers, zone families, and settlement metrics

### Exit criteria
- authored map loads into runtime state
- map data is authoritative rather than decorative
- cell inspector exposes meaningful survival-relevant fields
- the first map already supports real campsite trade-offs

### Must not include
- continent procgen
- late-game biome variety
- full ecology simulation

---

## 11. Branch 04 — map renderer + camera + fog

### Status
Not started

### Goal
Render the world clearly and prove the first interaction model for reading terrain.

### Must deliver
- layered renderer
- zoomable and pannable camera
- aerial-style base rendering
- topo / hybrid support or debug-equivalent
- fog of war overlay
- reveal source scaffolding
- overlay toggles
- map legend/debug readout

### Required fog states
At minimum the data model should support:
- unknown / never seen
- remembered / revealed but not currently visible
- currently visible

The visible presentation may simplify this at first, but the underlying state distinction should already exist.
