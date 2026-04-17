# Realistic Idle City — Terrain Generation Branch Plan v0.1

## Purpose

This document breaks the terrain work into **small, implementation-sized branches** that fit the existing roadmap instead of replacing it.

It now assumes:
- **Branch 00** is complete
- **Branch 01** is complete enough to close
- **Branch 02** is complete enough to close
- **Branch 03** is complete enough to close
- **Branch 04** is complete enough to close
- the project still follows the logic that says **authoritative world data and inspectable authored maps come before real procgen**
- the terrain system must stay **simulation-first**, **debuggable**, and **compatible with early survival realism**

This plan therefore still does **not** jump straight to “make random maps.”
It first establishes that the project now already has the substrate and overlay/debug proof, then it inserts a cleanup branch, then it starts the structured generator track.

---

# 1. Planning stance

## 1.1 Why terrain generation is split this way

The project has now already proved the correct order:

1. define IDs and data vocabulary
2. define authoritative world data
3. load hand-authored maps
4. render and inspect them
5. only then generate terrain procedurally

That is still the safest order because:
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
- **Branch 03** is now the authoritative terrain/world substrate + authored reference map foundation
- **Branch 04** is now the renderer + fog + overlays + inspectors proof layer
- **Branch 05** should be a short **audit-and-cleanup** closeout branch
- **terrain procgen branches begin after that cleanup branch**

That means we still do **not** overthrow the roadmap.
We refine it based on what the repo now actually proves.

---

# 3. Recommended branch sequence from here

## Branch 05 — audit-and-cleanup

### Goal
Close the authored-world + renderer foundation cleanly before starting procgen work.

### Deliverables
- doc sync after Branch 03–04
- remove stale placeholder references/artifacts
- remove temp scene files / branch debris
- verify the current authoritative terrain stack is documented correctly
- leave a cleaner baseline for the first procgen branch

### Why this branch matters
Procgen work benefits from a clean baseline.  
If the repo is already carrying stale files, outdated docs, and branch-close drift, debugging generation work gets noisier than it needs to be.

### Exit criteria
- docs match code
- stale placeholder/temp artifacts are gone
- the next terrain branch starts from a cleaner base

---

## Branch 05A — structured-terrain-generator-skeleton

### Goal
Create the first procedural generator shell for one terrain family.

### Depends on
- closed Branch 05 cleanup
- completed Branch 03–04 foundation

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

### Exit criteria
- obvious bad starts can be detected
- generated maps stay within the intended early-game realism envelope
- the generator becomes tunable instead of mysterious

---

# 4. Earlier branch breakdown retained for historical context

The earlier conceptual split is still useful as historical reasoning:

## Branch 03A — terrain-schema-core
Created the authoritative terrain cell/chunk/patch schema in code.

## Branch 03B — hand-authored-terrain-map-format
Established a trustworthy authored terrain map pipeline before procgen.

## Branch 03C — terrain-derived-fields-v1
Derived practical terrain values from authored terrain truth.

## Branch 03D — terrain-patch-extraction-and-site-candidates
Turned cell-level truth into patch-level terrain meaning.

## Branch 04A — terrain-overlay-renderer
Rendered debug overlays directly from authoritative terrain data.

## Branch 04B — terrain-inspector-and-debug-ui
Made terrain inspectable at cell and patch level.

## Branch 04C — fog-memory-and-terrain-knowledge
Connected terrain truth to exploration state.

## Branch 04D — terrain-object-placement-validation
Made terrain authoritative for nature/object placement validation.

These slices have now effectively been proven in consolidated Branch 03–04 implementation work.

---

# 5. Final position

The project is now in the right place to begin real procgen work **after** a short cleanup branch.

That is the important conclusion:
- not “keep polishing authored map docs forever”
- not “jump to unrelated gameplay systems”
- but “close the current foundation cleanly, then start the first structured terrain generator”
