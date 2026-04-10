# Realistic Idle City — Godot Bootstrap / First Sprint Implementation Plan v0.2

## Purpose

This document is the **full-scope-verified** version of the first sprint plan.

It keeps the original Sprint 1 cut intact:
- Branch 00 — repo bootstrap
- Branch 01 — core definitions and IDs
- Branch 02 — simulation clock and run loop
- Branch 03 — world data model + hand-authored maps
- Branch 04 — map renderer + camera + fog of war

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

### 1.1 Short answer

It is still right to begin with:
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

### Required first-pass time state
- absolute tick
- day index
- current day segment / daylight phase
- current season token
- current year placeholder
- scenario seed and active RNG stream handle

### Recommended phase order
1. input / command intake
2. time-step start
3. world/system pre-update
4. simulation update
5. visibility / overlay refresh hook
6. debug snapshot point
7. end-of-tick bookkeeping

### Full-scope compatibility additions
- keep a stable **pre-save / post-save-safe boundary** in mind even if save is stubbed
- expose time in a way later docs can map onto daylight, weather pressure, labor capacity, and seasonal deadlines
- expose deterministic run metadata to telemetry/debug

### Exit criteria
- same seed + same startup scenario yields stable tick ordering
- pause/resume works
- single-step works
- day/part-of-day/season display updates predictably

### Must not include
- full weather
- full daily AI planning
- full survival decay

---

## 10. Branch 03 — world data model + hand-authored maps

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

### Required overlays for Sprint 1
- elevation / landform
- drainage / wetness
- buildability
- water-source / water-access helper overlay if useful
- fog state

### Strongly recommended overlays
- site suitability / campsite score debug overlay
- zone stamp overlay placeholder
- path cost / traversability debug overlay

### Full-scope compatibility additions
- the map must remain the main anchor, with minimal chrome
- overlay/panel UI should stay dense and dev-oriented rather than card-heavy
- reveal behavior should be compatible with later NPC exploration and memory systems

### Exit criteria
- the map is readable across multiple zoom levels
- fog hides unknown land and preserves remembered land
- reveal source uncovers nearby cells correctly
- overlays visibly reflect underlying simulation data

### Must not include
- polished art pass
- final contour polish
- final scouting gameplay

---

## 12. Minimal autoload/service set for Sprint 1

Keep autoloads small.

### Required
- `AppRoot`
- `SimRoot`
- `TimeService`
- `EventBus`
- `DefinitionRegistry`
- `TelemetryService`
- `SaveService` (stub is fine)
- optional `SeedService` if not folded into `SimRoot`

### Must not become autoloads yet
- world renderer
- camera controller
- HUD controller
- map overlay controller
- NPC manager with gameplay logic
- task manager with gameplay logic

---

## 13. Sprint 1 scene and script checklist

### Autoloads
- `autoload/app_root.gd`
- `autoload/sim_root.gd`
- `autoload/time_service.gd`
- `autoload/event_bus.gd`
- `autoload/definition_registry.gd`
- `autoload/telemetry_service.gd`
- `autoload/save_service.gd`
- optional `autoload/seed_service.gd`

### Boot
- `boot/boot_scene.tscn`
- `boot/boot_controller.gd`
- `boot/scenario_bootstrapper.gd`

### World
- `world/scenes/world_root.tscn`
- `world/scenes/test_world_scene.tscn`
- `world/scripts/world_root_controller.gd`
- `world/scripts/world_state.gd`
- `world/scripts/world_cell_state.gd`
- `world/scripts/world_loader.gd`
- `world/scripts/world_renderer.gd`
- `world/scripts/fog_layer_controller.gd`
- `world/scripts/world_overlay_controller.gd`
- `world/scripts/dev_observer_reveal_source.gd`
- optional `world/scripts/site_debug_controller.gd`

### Runtime/shared
- `runtime/state/id_rules.gd`
- `runtime/state/shared_enums.gd`
- `runtime/state/definition_types.gd`
- `runtime/state/sim_seed_state.gd`
- `runtime/state/zone_types.gd` or equivalent enum/resource

### UI/debug
- `ui/scenes/dev_hud.tscn`
- `ui/debug/dev_hud_controller.gd`
- `ui/debug/cell_inspector_panel.gd`
- `ui/debug/overlay_toggle_panel.gd`
- optional `ui/debug/site_score_panel.gd`

### Fixtures
- `tests/fixtures/starter_map_balanced.*`
- `tests/fixtures/starter_map_wet_annoying.*`
- optional `tests/fixtures/starter_map_rocky_spring.*`
- `tests/scenario_configs/dev_start_default.*`

---

## 14. Developer UX requirements

By the end of Sprint 1, the project should already be pleasant enough to debug.

### Required
- startup validation log
- clear fatal errors for missing definitions
- visible seed / scenario / tick / day / season
- pause / resume / single-step
- overlay toggles
- cell hover inspector
- dev reload current scenario
- map reset / reload

### Strongly recommended
- reveal-all fog toggle
- overlay cycle hotkey
- recenter camera hotkey
- site suitability overlay toggle

---

## 15. First-sprint acceptance criteria

Sprint 1 is done only if all of these are true:

### Boot / repo
- project opens and runs cleanly
- startup order is understandable
- seed and scenario are visible

### Definitions
- minimal definition pack loads from assets
- malformed IDs fail loudly
- duplicate IDs are detected
- zone / fog / terrain / placeholder policy vocabulary exists

### Time
- time runs, pauses, and steps
- tick order is deterministic
- day / part-of-day / season are visible and stable

### World
- at least one authored map loads into authoritative state
- the map expresses actual survival-relevant terrain trade-offs
- POI placeholders and site-quality data can be inspected

### Rendering / fog
- map is readable and zoomable
- fog hides unknown land
- revealed land is remembered separately from unknown land
- overlays reflect world truth

### Debuggability
- cell inspector works
- startup validation is visible
- seed / scenario / tick / season info is always visible in dev mode

If any of these are false, Sprint 1 is not done.

---

## 16. Risks to avoid

### Risk A — building gameplay too early
Do not drift into hunger/crafting/hauling simulation during Sprint 1.

### Risk B — underbuilding time
Do not implement only a raw tick counter and promise to fix calendar later.

### Risk C — underbuilding map doctrine
Do not use pretty-but-meaningless test maps.

### Risk D — vocabulary drift
Do not invent loose item/process/zone names that diverge from the canonical early content pack and shared dictionary.

### Risk E — scene truth replacing simulation truth
The renderer is not the world model.

### Risk F — global sprawl
Do not turn every system into an autoload.

---

## 17. What happens after Sprint 1

If Sprint 1 lands cleanly, proceed to:
- Branch 05 — NPC core body-state
- Branch 06 — item runtime / storage foundations
- Branch 07 — task system v1
- Branch 08 — pathfinding / movement / hauling
- Branch 09 — water / fire / sleep / food core

Sprint 1 is successful if it makes those branches easier and safer.

---

## 18. Final stance

After reviewing the full document universe, the correct first sprint is still:

- make the codebase real
- make the data vocabulary real
- make the time backbone real
- make the map real
- make the overlays and fog real
- make the project inspectable

The only important correction is that Sprint 1 should not be grounded **only** in the newer implementation docs.
It should also remain explicitly compatible with the older early-game, content-pack, calendar, site-generation, policy, logistics, settlement, UI, and NPC docs.

That is what this v0.2 plan is for.
