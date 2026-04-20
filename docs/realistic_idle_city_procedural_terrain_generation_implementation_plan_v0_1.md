# Realistic Idle City — Procedural Terrain Generation Implementation Plan v0.1
_Last synced:_ 2026-04-17  
_Intended next branch:_ Branch 06 — procedural terrain generation foundation

## 1. Purpose

This document is the **active next-step implementation plan** for moving from the current authored-world runtime baseline to the first procedural starter-area terrain generator.

It is grounded in:
- the current repo architecture after Branch 05 cleanup
- the older terrain/spec/world-generation docs
- the rule that authored and procedural maps must share the same runtime world contract

This is **not** a continent generator plan.
This is the plan for the first believable **starter-area local map generator**.

---

## 2. Current baseline we should preserve

The current repo already has the most important prerequisite pieces:

- definition-driven bootstrap
- scenario / map preset / worldgen profile / season profile resolution
- authoritative `WorldState` with cells, patches, chunks, reveal sources, terrain objects, warnings, and debug snapshots
- authored fixture loading into that runtime model
- authoritative terrain renderer and overlay/debug inspection tools

That means Branch 06 should **add a new world-build path**, not replace the existing one.

---

## 3. Non-negotiable implementation rules

## 3.1 Same runtime contract
Procedural worlds must populate the same runtime data shapes that authored worlds already produce:
- `WorldState`
- `WorldCellState`
- `WorldPatchState`
- `WorldChunkState`
- reveal-source state where applicable
- authored/generated terrain object records and warnings

The renderer, HUD, overlay systems, and terrain inspector should not need separate “procgen-only” codepaths for world truth.

## 3.2 Relief first, then hydrology, then ecology/buildability
Do not generate terrain as disconnected themed paint.

Generation order should remain:
1. world dimensions / seed / profile resolution
2. relief / elevation skeleton
3. flow direction / drainage / watercourse routing
4. wetness / floodplain / buildability consequences
5. vegetation / resource communities
6. patch grouping / candidate-site scoring
7. terrain object seeding / validation
8. reveal/debug bootstrap

## 3.3 Keep authored support intact
Do not fold procgen into `AuthoredMapLoader`.
Keep authored and procedural world building as siblings.

## 3.4 Keep visibility bootstrap separate
Reveal/visibility should remain a deliberate bootstrap layer, not generic terrain paint leakage.

---

## 4. Recommended data-model changes

## 4.1 Keep `TerrainProfileDef` semantic
`TerrainProfileDef` should remain the semantic/ecological identity layer:
- broad landform identity
- expected slope/drainage tendencies
- vegetation baseline
- water-source expectations
- survivability tags

Do **not** dump every numeric generator knob into it.

## 4.2 Add a dedicated procedural generation config definition
Add a new definition/resource type dedicated to generator parameters, for example:

- `TerrainGenerationProfileDef`
or
- `ProceduralTerrainConfigDef`

Recommended responsibility:
- map-scale numeric generation parameters
- valley width targets
- ridge density
- stream density / wetness bias
- noise scales / octave weights
- rock exposure tendency
- vegetation density bias
- patch minimum sizes
- candidate-site minimum contiguous area
- starter survival guarantees and tolerance settings

Recommended folder:
- `data/defs/terrain_generation_profiles/`

Reason:
this keeps semantic terrain identity separate from numeric generation tuning.

## 4.3 Extend `WorldgenProfileDef` only as an orchestrator
`WorldgenProfileDef` should remain the bundle that selects:
- allowed map presets
- terrain profile(s)
- season profile
- starter species
- generation mode / generation config ID

Suggested new fields:
- `generation_mode` with values like `authored` / `procedural`
- `terrain_generation_profile_id` for the numeric procedural config

## 4.4 Extend `MapPresetDef` only where it makes sense
`MapPresetDef` can remain the place for:
- dimensions
- map identity
- optional authored fixture ID
- optional map-shape family / local-play-area intentions

Do not make it hold every terrain algorithm parameter either.

---

## 5. Recommended new runtime modules

The new branch should prefer a staged pipeline of small modules over one generator monolith.

Recommended new modules:

### 5.1 `ProceduralWorldBuilder`
Top-level orchestrator for the procedural path.

Responsibilities:
- resolve seed/profile inputs
- create/configure `WorldState`
- call the staged generation helpers in order
- run final validation
- return finished `WorldState`

### 5.2 `ProceduralReliefGenerator`
Responsibilities:
- create the starter-area elevation/relief skeleton
- carve valley floor / benches / ridges / slopes
- emit per-cell relief/elevation metadata needed by later steps

### 5.3 `ProceduralHydrologyDeriver`
Responsibilities:
- derive downhill direction / drainage tendency
- accumulate water routing
- place stream corridor / wet hollows / flood-prone zones
- classify wetness/drainage consequences for cells

### 5.4 `ProceduralLandcoverDeriver`
Responsibilities:
- derive vegetation communities and surface cover from relief + wetness + profile bias
- assign resource-bearing ecological zones
- avoid isolated decorative loot-node logic

### 5.5 `ProceduralPatchBuilder`
Responsibilities:
- group contiguous cells into semantic patches
- build `WorldPatchState` entries
- classify patch-level buildability / site affordance summaries

### 5.6 `ProceduralSiteCandidateEvaluator`
Responsibilities:
- evaluate contiguous candidate camp areas
- score tradeoffs rather than perfect sites
- ensure at least one viable survival route exists
- produce warnings when guarantees fail

### 5.7 `ProceduralTerrainObjectSeeder`
Responsibilities:
- place terrain objects from ecological/terrain rules
- validate placements through the same placement validator mindset already used for authored objects

### 5.8 `ProceduralWorldValidationService`
Responsibilities:
- final semantic checks
- starter survivability guarantees
- world warning generation
- deterministic debug summary output

---

## 6. Integration seam in the current codebase

The correct integration seam is the world-build step currently reached through:

- `SimRoot.build_world_state_from_active_definitions()`

Recommended change:
- make that method choose authored vs procedural world build using definitions
- keep the rest of the world binding / presentation setup unchanged

Target shape:
- authored mode → `AuthoredMapLoader`
- procedural mode → `ProceduralWorldBuilder`

That keeps the rest of the project stable.

---

## 7. First procedural world target

The first procedural map should generate one believable **temperate woodland valley starter area** where the player gets:
- some dry buildable ground
- water access that is useful but not risk-free
- woodland/fuel access
- some poorer/wetter/more awkward terrain nearby
- meaningful camp-site tradeoffs instead of one obviously perfect pad

The generator must guarantee a **viable start**, not an easy or optimal one.

---

## 8. Recommended generation sequence

## 8.1 Realism note on terrain derivation

The procedural path should follow a **surface-analysis mindset** rather than decorative map painting.

In practical terms:
- slope and buildability should come from relief
- drainage and wetness should come from downhill routing / accumulation tendencies
- stream corridors, flood-prone cells, and wet hollows should emerge from that hydrology pass
- vegetation/resource communities should then react to those terrain consequences

This keeps the map feeling causally grounded instead of thematically scattered.


### Step 1 — resolve bootstrap inputs
Resolve:
- world dimensions from `MapPresetDef`
- seed from scenario/bootstrap/time service
- terrain semantics from `TerrainProfileDef`
- numeric tuning from the new procedural terrain config definition

### Step 2 — create base cells/chunks
Create empty/default world cells and chunk structure first, just like the authored path does.

### Step 3 — generate relief skeleton
Produce the starter-area macro relief:
- valley axis
- stream corridor tendency
- benches / terraces
- ridges / higher ground
- local slope transitions

The goal is not realism through extreme complexity.
The goal is believable causal terrain structure.

### Step 4 — derive hydrology and drainage
From relief, derive:
- local downslope / drainage direction
- accumulation tendency
- surface water corridor
- wet hollows / floodplain tendency
- drainage class and wetness tendency per cell

### Step 5 — derive buildability and surface semantics
From slope + wetness + landform:
- `is_buildable`
- `landform_type`
- `slope_class`
- `drainage_class`
- `wetness_tendency`
- `surface_water_type`

### Step 6 — derive vegetation/resource communities
Use terrain consequences to derive:
- woodland vs scrub vs meadow vs wet vegetation pockets
- starter resource tendencies
- ecological transitions instead of isolated decorative markers

### Step 7 — build semantic patches
Group contiguous cells into patches such as:
- valley floor
- stream corridor
- wet hollow
- lower bench
- upper bench
- ridge shoulder
- dense woodland patch
- open meadow pocket

These patches should support later site scoring, debug interpretation, and gameplay reasoning.

### Step 8 — evaluate site candidates
Evaluate multiple candidate camp zones using:
- contiguous dry ground
- slope suitability
- flood/wetness risk
- proximity to water
- proximity to fuel/forage
- penalty for overly exposed or awkward terrain

Store enough summary data/debug info to inspect why the generator judged the map viable.

### Step 9 — seed terrain objects
Seed stones, reeds, berry scrub, clay-bank indicators, etc. from terrain/ecology rules, then validate placements.

### Step 10 — finalize world warnings/debug summary
Populate:
- generation warnings
- debug snapshots
- optional starter-site candidate summary data

---

## 9. Concrete branch plan

## Branch 06A — pipeline and schema foundation
Deliverables:
- add the procedural terrain config definition/resource type
- extend `WorldgenProfileDef` with explicit generation mode + config reference
- update `SimRoot.build_world_state_from_active_definitions()` to route authored vs procedural
- add `ProceduralWorldBuilder` skeleton
- keep authored path untouched and still working

Success criteria:
- the project can choose between authored and procedural world build through definitions
- a procedural path can return a valid but simple `WorldState`

## Branch 06B — relief and hydrology
Deliverables:
- `ProceduralReliefGenerator`
- `ProceduralHydrologyDeriver`
- starter-area valley profile generation
- stream/wetness/drainage derivation
- first meaningful buildability semantics

Success criteria:
- generated maps show believable slope/water/buildability differences
- overlays/inspector reflect those differences without special-case UI work

## Branch 06C — landcover, patches, and site viability
Deliverables:
- `ProceduralLandcoverDeriver`
- `ProceduralPatchBuilder`
- `ProceduralSiteCandidateEvaluator`
- first candidate-site viability guarantees

Success criteria:
- the map contains meaningful terrain tradeoffs
- at least one viable start exists by generator validation
- debug tools can explain why

## Branch 06D — terrain objects, validation, and debugging
Deliverables:
- `ProceduralTerrainObjectSeeder`
- `ProceduralWorldValidationService`
- world warning/debug summary improvements
- additional overlay support only if the existing overlays prove insufficient

Success criteria:
- terrain object placements follow terrain logic
- bad worlds fail with actionable warnings instead of silently shipping nonsense

## Branch 06E — second profile and tuning pass
Deliverables:
- at least one more terrain-generation config/profile
- tuning of balance, wetness bias, woodland density, stream placement, and candidate scoring

Success criteria:
- the generator is no longer a one-off hardcoded valley script
- the system is clearly extensible through definitions/configs

---

## 10. Guardrails against future technical debt

Do not:
- put all generator stages into one giant script
- bypass runtime state with renderer-only convenience values
- hide procgen knobs inside unrelated definitions
- store site viability only as a decorative marker
- treat “random scatter” as terrain generation
- reintroduce placeholder-only rendering logic as a shortcut

Do:
- keep generation modular
- keep outputs deterministic from seed + definition inputs
- surface warnings/debug summaries for failed or weak maps
- use the authored path as the contract reference implementation

---

## 11. Minimal first implementation target

The smallest acceptable first win for Branch 06 is:

- one procedural worldgen profile
- one procedural terrain config
- one seeded temperate starter-valley generator
- generated `WorldState` feeding the current renderer/inspector successfully
- at least one viable camp candidate guaranteed by validation
- authored map path still fully working

That is enough to start pressure-testing realism against non-authored worlds.

---

## 12. Final note

The project is now at the right point to begin procedural terrain work.

Do not spend the next branch reopening general cleanup.
Use the cleaned Branch 05 baseline and build the procedural path beside the authored path in a staged, data-driven way.
