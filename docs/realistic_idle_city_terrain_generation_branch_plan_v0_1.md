# Realistic Idle City — Terrain Generation Branch Plan v0.1

## Purpose

This document breaks the terrain work into **small, implementation-sized branches** that fit the existing roadmap instead of replacing it.

It assumes:
- **Branch 00** is complete
- the project still follows the roadmap logic that says **authoritative world data and hand-authored maps come before fancy procgen**
- the terrain system must stay **simulation-first**, **debuggable**, and **compatible with early survival realism**

This plan therefore does **not** jump straight to “make random maps.”
It first builds the terrain substrate, then the overlays and validators, then the first structured generator.

---

# 1. Planning stance

## 1.1 Why terrain generation is split this way

The project docs already imply the correct order:
1. define IDs and data vocabulary
2. define authoritative world data
3. load hand-authored maps
4. render and inspect them
5. only then generate terrain procedurally

That is the safest order because:
- procgen without trusted terrain data becomes hard to debug
- procgen without overlays becomes guesswork
- procgen without a reference authored map makes it hard to know whether bad results come from logic or tuning

## 1.2 What “terrain generation” includes here

For this plan, terrain generation includes:
- terrain data fields
- patch extraction
- site-suitability derivation
- hydrology/drainage derivation
- vegetation/resource derivation
- validation rules
- debug overlays
- the first structured generator for the early-game temperate valley profile

It does **not** include:
- continent generation
- multiple biome families
- advanced erosion simulation
- final pretty map polish

---

# 2. How this plugs into the existing roadmap

This branch plan is a **sub-plan** inside the larger roadmap.

It maps like this:
- **Branch 01** stays as core definitions and IDs
- **Branch 02** stays as simulation clock and run loop
- **Branch 03** becomes the terrain substrate + authored reference maps foundation
- **Branch 04** becomes renderer + fog + overlays + inspectors
- **new terrain-procgen branches after Branch 04** handle the first structured terrain generator

That means we do **not** overthrow the current roadmap.
We refine it.

---

# 3. Recommended branch sequence

## Branch 03A — terrain-schema-core

### Goal
Create the authoritative terrain cell/chunk/patch schema in code.

### Depends on
- Branch 01
- Branch 02

### Deliverables
- terrain enums / canonical value sets
- terrain cell data object
- terrain chunk data object
- terrain patch data object
- static vs derived vs mutable field split
- serialization-ready structure

### Must include
- elevation
- slope
- landform
- surface water type
- drainage
- wetness tendency
- ground firmness
- vegetation community
- move/haul/build/site-related placeholders
- reveal state hooks

### Must not include
- random terrain generation yet
- renderer-specific logic in the schema
- asset references inside terrain truth

### Exit criteria
- terrain records can be created, stored, and inspected
- schema compiles cleanly
- no inferred-type shortcuts
- save/load compatibility path is obvious

---

## Branch 03B — hand-authored-terrain-map-format

### Goal
Stand up one trustworthy authored terrain map pipeline before procgen.

### Depends on
- Branch 03A

### Deliverables
- hand-authored map file/schema format
- one balanced early survival reference map
- one harsh edge-case map
- loader that populates terrain cells/chunks/patch placeholders

### Why this branch matters
This becomes the calibration target for later procgen.
If the authored map feels right and the procgen map feels wrong, the generator is the problem.

### Exit criteria
- the world loads from authored terrain data
- terrain cells expose useful facts to systems
- two different authored maps can load without code changes

---

## Branch 03C — terrain-derived-fields-v1

### Goal
Derive first-pass practical terrain values from the authored terrain substrate.

### Depends on
- Branch 03B

### Deliverables
- move cost derivation
- haul cost derivation
- buildability derivation
- sleep suitability derivation
- fire suitability derivation
- sanitation suitability derivation
- local site score contribution derivation

### Must not include
- final task/AI behavior
- settlement construction systems

### Exit criteria
- changing terrain input changes practical outputs predictably
- wet low ground is visibly penalized
- dry benches and firm ground read better for camp use

---

## Branch 03D — terrain-patch-extraction-and-site-candidates

### Goal
Turn cell-level truth into patch-level terrain meaning.

### Depends on
- Branch 03C

### Deliverables
- patch extraction logic
- patch summaries
- candidate camp-site patches
- garden-candidate patches
- wet / hazard patch summaries
- patch-level site score

### Why this branch matters
This is where “good site” stops being a magic marker and becomes a derived property of the land.

### Exit criteria
- contiguous terrain produces coherent patches
- multiple viable site candidates can exist
- no single-point “site object” is required for logic

---

## Branch 04A — terrain-overlay-renderer

### Goal
Render debug overlays directly from authoritative terrain data.

### Depends on
- Branch 03A to 03D

### Deliverables
- overlay rendering layer
- elevation overlay
- drainage overlay
- wetness overlay
- vegetation overlay
- buildability overlay
- site score overlay
- patch boundary overlay

### Must include
- overlay switching without full world regen
- clear legend behavior or inspector-based reading

### Exit criteria
- overlays reflect terrain truth, not duplicated state
- changing terrain values updates overlays correctly
- terrain can be tuned without relying on final art

---

## Branch 04B — terrain-inspector-and-debug-ui

### Goal
Make terrain inspectable at cell and patch level.

### Depends on
- Branch 04A

### Deliverables
- cell inspector panel
- patch inspector panel
- hover/click terrain query
- compact debug panel integration
- terrain field readout

### Must include
- coordinate readout
- terrain classes
- practical suitability values
- reveal state
- patch summaries where available

### Exit criteria
- one click explains why a location is good or bad
- inspector matches authoritative data exactly
- no hidden duplicated terrain logic in UI

---

## Branch 04C — fog-memory-and-terrain-knowledge

### Goal
Connect terrain truth to exploration state.

### Depends on
- Branch 04A
- Branch 04B

### Deliverables
- reveal state integration with terrain cells
- unknown / remembered / visible display rules
- remembered terrain tinting
- survey quality hooks
- terrain confidence hooks

### Exit criteria
- unknown land hides detailed truth
- remembered land stays partially informative
- visible land shows full terrain interpretation

---

## Branch 04D — terrain-object-placement-validation

### Goal
Make terrain authoritative for nature/object placement.

### Depends on
- Branch 03A
- Branch 03C
- Branch 04A

### Deliverables
- placement validation rules for trees
- wet-margin placement rules
- rocky resource placement rules
- conflict debug overlay
- generation warning logging

### Why this branch matters
It closes the exact hole already seen in the prototype: trees in water and terrain-ignorant placement.

### Exit criteria
- open water rejects ordinary tree placement
- wet margins and rocky patches influence placement sensibly
- invalid placements surface as warnings/overlays

---

## Branch 05A — structured-terrain-generator-skeleton

### Goal
Create the first procedural generator shell for one terrain family.

### Depends on
- Branch 03A to 03D
- Branch 04A to 04D

### Deliverables
- seed input
- region profile selection
- relief skeleton generator
- stream corridor generator
- dry bench placement
- wet depression placement
- chunk-safe generation order

### Scope rule
Only one terrain family:
- temperate valley
- modest stream corridor
- mixed meadow / brush / woodland
- some wetter low ground
- some firmer raised ground

### Exit criteria
- generator produces structural terrain before decoration
- repeated seeds reproduce the same map
- generated maps look coherent even before vegetation/object pass

---

## Branch 05B — hydrology-drainage-derivation

### Goal
Turn the relief skeleton into believable wetness structure.

### Depends on
- Branch 05A

### Deliverables
- flow direction derivation
- flow accumulation approximation
- drainage class derivation
- wetness tendency derivation
- flood risk class derivation
- water-access evaluation support

### Exit criteria
- water follows terrain logically
- low/wet areas emerge from structure, not decoration
- stream-adjacent and poorly drained ground behave differently

---

## Branch 05C — vegetation-and-resource-derivation

### Goal
Grow believable terrain communities and opportunities from the water/ground model.

### Depends on
- Branch 05B

### Deliverables
- vegetation community assignment
- canopy/understory density derivation
- resource opportunity fields
- terrain-aware object placement hooks
- edge habitat logic

### Must include
- riparian strip behavior
- wet-margin logic
- woodland edge logic
- open ground logic

### Exit criteria
- vegetation forms communities, not even scatter
- resources read as consequences of terrain/ecology
- edge transitions feel plausible

---

## Branch 05D — generated-site-candidate-evaluation

### Goal
Derive camp candidates from generated terrain.

### Depends on
- Branch 05A to 05C

### Deliverables
- generated site patch extraction
- candidate ranking
- water-distance tradeoff handling
- sanitation separation handling
- expansion-room scoring
- candidate debug overlay

### Exit criteria
- multiple site candidates can be compared
- the best site is situational rather than always obvious
- no special “camp marker” world object is needed for truth

---

## Branch 05E — procgen-validation-and-balance-pass

### Goal
Make generated maps consistently playable and believable.

### Depends on
- Branch 05A to 05D

### Deliverables
- generation validation rules
- bad-seed rejection rules
- telemetry counters
- map-summary debug report
- harsh/balanced seed test set

### Validation examples
- reachable water exists
- at least one dry viable site patch exists
- not all useful resources cluster on one perfect cell block
- no ordinary trees spawn in open water
- terrain communities are spatially coherent

### Exit criteria
- repeated seed tests mostly pass without manual cleanup
- obvious “gamey” maps are rejected or flagged
- tuning becomes data-driven instead of visual guesswork

---

# 4. Suggested implementation order in practice

If you want the smallest safe progression, implement in this exact order:

1. Branch 03A
2. Branch 03B
3. Branch 04A
4. Branch 04B
5. Branch 03C
6. Branch 03D
7. Branch 04C
8. Branch 04D
9. Branch 05A
10. Branch 05B
11. Branch 05C
12. Branch 05D
13. Branch 05E

Why this order works:
- it gives you inspectable terrain truth early
- it keeps procgen from becoming a black box
- it solves known prototype issues before procedural complexity increases

---

# 5. Minimum branch boundaries

Each branch should ideally:
- touch one coherent subsystem area
- have one clear before/after behavior change
- include acceptance checks
- leave the game runnable
- avoid mixing schema, UI, and procgen in the same commit unless the branch explicitly exists to connect them

Avoid these bad branch mixes:
- terrain schema + NPC needs + item runtime in one branch
- fog-of-war + task system + generator tuning in one branch
- pretty map rendering changes mixed with terrain truth refactors

---

# 6. Risks and anti-patterns

## 6.1 Biggest risk

Jumping straight to Branch 05A-style procgen before Branch 03/04 terrain truth and overlays are stable.

That would likely cause:
- hidden bad assumptions
- hard-to-read bugs
- repeated visual retuning without understanding the data problem

## 6.2 Other anti-patterns

- building the generator around art needs instead of terrain truth
- adding multiple terrain families before one feels believable
- placing resources as decorative scatter instead of terrain consequence
- keeping site quality as a spawned marker instead of a derived patch property
- hiding terrain bugs because the renderer looks nice

---

# 7. Practical recommendation

The next best terrain-related branch after the current state is:

## **Branch 03A — terrain-schema-core**

That should be followed immediately by:
- **Branch 03B — hand-authored-terrain-map-format**
- **Branch 04A — terrain-overlay-renderer**
- **Branch 04B — terrain-inspector-and-debug-ui**

Only after those are working should the first procedural terrain branch begin.

That keeps the project aligned with its docs, future-proof, data-driven, and realistic.
