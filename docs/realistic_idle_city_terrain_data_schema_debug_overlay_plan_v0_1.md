# Realistic Idle City — Terrain Data Schema + Debug Overlay Plan v0.1

## Purpose

This document turns the first-pass terrain generation logic into an **implementation-facing data and observability plan** for the early playable slice.

It defines:
- the **authoritative terrain data model**
- which terrain facts live at **region / chunk / cell / patch / object** levels
- which facts are **generated**, which are **derived**, and which are **mutable at runtime**
- how terrain truth should be exposed through **debug overlays** so the generator can be validated in Godot
- the minimum schema needed before replacing the current placeholder map with a real terrain substrate

This document is not a replacement for the broader world/site generation work.
It is the implementation companion that makes terrain logic debuggable, inspectable, and safe to iterate on.

---

# 1. Relationship to the current document stack

This document should be read together with:
- `realistic_idle_city_design_documents/realistic_idle_city_world_map_site_generation_spec_v0_1.md`
- `realistic_idle_city_world_generation_map_rendering_spec_v0_1.md`
- `realistic_idle_city_terrain_generation_spec_v0_1.md`
- `realistic_idle_city_unified_data_dictionary_v0_1.md`
- `realistic_idle_city_debug_telemetry_spec_v0_1.md`
- `realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`

Authority split:
- the older **world / map / site generation** doc remains the authority for survival pressure, site quality, and terrain-world logic
- the **world generation + map rendering** doc remains the authority for rendering stack, camera modes, fog-of-war, and map presentation
- the **terrain generation spec** remains the authority for the causal terrain pipeline: relief -> hydrology -> drainage -> vegetation -> resources -> site suitability
- this document is the authority for the **runtime terrain schema** and the **terrain debug overlay plan**

Practical rule:
- terrain data must remain useful even if art style changes
- overlays must reveal simulation truth, not merely visual decoration
- the early game still centers on **finding water**, **choosing a site**, **avoiding dampness**, **maintaining sanitation separation**, and **minimizing hauling burden**

---

# 2. Core stance

## 2.1 Terrain truth must be simulation-first

The terrain system must answer practical survival questions before it answers visual questions.

Examples:
- where does water accumulate after rain
- which ground stays damp
- where is footing poor
- which route costs more when hauling loads
- where can a fire and sleeping area remain dry enough
- where can waste be separated downhill / away from water use
- where do reeds, berry edges, straight timber, clayey ground, and rocky outcrops plausibly appear

If the data cannot support those answers, the terrain layer is not finished.

## 2.2 Terrain must be causal, not decorative

The generator should not place unrelated random layers.
Terrain should emerge as:
1. regional profile
2. relief skeleton
3. hydrology
4. drainage / moisture tendency
5. soil / ground condition
6. vegetation communities
7. resource opportunities
8. site suitability
9. rendered interpretation of all of the above

## 2.3 Debug overlays are mandatory, not optional polish

Because this project is realism-first, terrain cannot be tuned by eye alone.
Developers must be able to inspect:
- elevation
- slope
- flow direction
- wetness tendency
- drainage class
- fertility tendency
- traversability
- buildability
- sanitation suitability
- site score
- reveal state

The overlay system is therefore part of the generator implementation, not a later convenience feature.

---

# 3. Realism anchors for the terrain model

The schema should reflect real environmental relationships instead of game shorthand.

Key anchors:
- surface water and groundwater should be treated as linked parts of one water system, not independent decorative features
- wet ground should be understood through the interaction of **hydrology, soils, and vegetation**, not through a single “wet tile” flag
- riparian gradients should reflect **elevation above channel**, **flood frequency**, **substrate**, and **water table depth**, which are among the strongest controls on vegetation and footing near streams
- land suitability should come from combined terrain, drainage, soil condition, water access, and hazard trade-offs, not a single fertility score

This does **not** mean the MVP must simulate full geotechnics or hydrogeology.
It means the data model should preserve the causal relationships that matter to early settlement behavior.

---

# 4. World data levels

The terrain system should use **five data levels**.

## 4.1 Level A — region profile

The region profile is a compact seed-level description of the landscape family being generated.
It is not per-cell data.

Examples:
- temperate valley with mixed woodland and meadow
- modest perennial or seasonal stream density
- spring-wet / summer-drier seasonal tendency
- moderate relief with benches and one small ridge system
- shallow wet margins and occasional clayey low ground

Purpose:
- constrain plausible terrain outcomes
- keep local generation coherent
- prevent biome soup

## 4.2 Level B — chunk record

Chunks exist for streaming, generation caching, and later save/load scaling.
Chunks are not the same thing as terrain meaning.

Purpose:
- generation batching
- rebuild boundaries
- partial overlay refresh
- fog-of-war memory storage grouping
- performance-safe map inspection

## 4.3 Level C — terrain cell record

This is the **authoritative early-game terrain substrate**.
Each traversable map cell should have a terrain record.

Purpose:
- path cost
- wetness burden
- build viability
- site search
- vegetation derivation
- resource derivation
- debug overlays

## 4.4 Level D — patch / zone record

A patch is a derived contiguous or semi-contiguous area with shared meaning.
Examples:
- one meadow patch
- one riparian strip segment
- one rocky rise
- one marshy depression
- one plausible camp bench

Purpose:
- AI reasoning
- site search
- resource grouping
- later worksite planning
- map labels / debug summaries

## 4.5 Level E — object and footprint record

Objects sit on top of terrain truth.
Examples:
- tree objects
- berry shrubs
- reeds
- stones
- clay exposure markers
- structures
- stockpiles
- paths
- waste areas
- garden plots

Terrain remains authoritative.
Objects should be generated and validated against terrain, not the other way around.

---

# 5. Authoritative terrain cell schema

This section defines the minimum terrain cell fields for the first real terrain substrate.

## 5.1 Identity and storage fields

| Field | Type | Purpose |
|---|---|---|
| `cell_index` | `Vector2i` | canonical local cell coordinate |
| `chunk_id` | `String` | owning chunk identifier |
| `world_position` | `Vector2` | center point in world space |
| `is_generated` | `bool` | generation completion marker |
| `is_runtime_dirty` | `bool` | runtime recompute marker |

## 5.2 Relief and shape fields

| Field | Type | Purpose |
|---|---|---|
| `elevation_step` | `int` | discrete elevation band used by gameplay and map rendering |
| `relative_relief_value` | `float` | normalized local relief metric for derivation and debug |
| `slope_class` | `String` | qualitative slope bucket |
| `aspect_class` | `String` | optional broad-facing class for exposure logic |
| `landform_type` | `String` | local landform interpretation |
| `edge_break_class` | `String` | ridge break / bench edge / floodplain edge / none |

### Canonical early values

#### `slope_class`
- `flat`
- `gentle`
- `moderate`
- `steep`
- `very_steep`

#### `aspect_class`
- `neutral`
- `northish`
- `eastish`
- `southish`
- `westish`

#### `landform_type`
- `valley_floor`
- `floodplain`
- `stream_bank`
- `wet_depression`
- `bench`
- `open_flat`
- `lower_slope`
- `upper_slope`
- `ridge`
- `rocky_rise`

#### `edge_break_class`
- `none`
- `bank_edge`
- `bench_edge`
- `ridge_break`
- `micro_depression_edge`

## 5.3 Hydrology and wetness fields

| Field | Type | Purpose |
|---|---|---|
| `surface_water_type` | `String` | open water / channel / none |
| `flow_accumulation_score` | `float` | normalized runoff concentration tendency |
| `flow_direction` | `Vector2i` | coarse downslope neighbor direction |
| `drainage_class` | `String` | practical drainage behavior |
| `wetness_tendency` | `float` | normalized moisture persistence tendency |
| `flood_risk_class` | `String` | early flood likelihood bucket |
| `water_access_class` | `String` | how usable nearby water access is |
| `water_table_proximity_class` | `String` | broad shallow/deep tendency |

### Canonical early values

#### `surface_water_type`
- `none`
- `seep`
- `stream_margin`
- `stream_channel`
- `pond_margin`
- `pond_open_water`

#### `drainage_class`
- `excessive`
- `well_drained`
- `moderate`
- `poor`
- `waterlogged`

#### `flood_risk_class`
- `none`
- `rare`
- `occasional`
- `seasonal`
- `frequent`

#### `water_access_class`
- `none`
- `distant`
- `awkward`
- `usable`
- `strong`

#### `water_table_proximity_class`
- `deep`
- `moderate`
- `shallow`
- `surface_influenced`

## 5.4 Ground and soil-behavior fields

These are **gameplay-ground** fields, not a full soil taxonomy.

| Field | Type | Purpose |
|---|---|---|
| `ground_texture_class` | `String` | coarse substrate / footing identity |
| `ground_firmness_class` | `String` | support underfoot / build support tendency |
| `soil_depth_class` | `String` | shallow vs deeper practical rooting/workability |
| `soil_fines_class` | `String` | coarse vs fine tendency, useful for clayey low areas |
| `surface_rockiness_class` | `String` | stone/outcrop tendency |
| `garden_suitability_class` | `String` | broad early horticulture suitability |
| `sanitation_suitability_class` | `String` | whether the ground is acceptable for waste placement |

### Canonical early values

#### `ground_texture_class`
- `mineral_firm`
- `loamy_surface`
- `gravelly`
- `stony`
- `mucky`
- `reedy_margin`

#### `ground_firmness_class`
- `firm`
- `mostly_firm`
- `soft`
- `unstable`

#### `soil_depth_class`
- `shallow`
- `moderate`
- `deep`

#### `soil_fines_class`
- `coarse`
- `mixed`
- `fine`
- `organic_rich`

#### `surface_rockiness_class`
- `none`
- `light`
- `moderate`
- `heavy`
- `outcrop`

#### `garden_suitability_class`
- `poor`
- `limited`
- `usable`
- `good`

#### `sanitation_suitability_class`
- `forbidden`
- `poor`
- `usable`
- `good`

## 5.5 Vegetation and habitat fields

| Field | Type | Purpose |
|---|---|---|
| `vegetation_community` | `String` | dominant community identity |
| `canopy_density_class` | `String` | overhead density |
| `understory_density_class` | `String` | brush / low vegetation density |
| `forage_opportunity_class` | `String` | edible plant / gatherable tendency |
| `fuelwood_opportunity_class` | `String` | deadwood / branchwood / woody biomass tendency |
| `wildlife_cover_class` | `String` | broad habitat cover tendency |

### Canonical early values

#### `vegetation_community`
- `open_meadow`
- `rough_grass_scrub`
- `woodland_edge`
- `mixed_woodland`
- `dense_riparian`
- `wet_margin_reeds`
- `rock_sparse`

#### `canopy_density_class`
- `none`
- `light`
- `moderate`
- `dense`

#### `understory_density_class`
- `none`
- `light`
- `moderate`
- `dense`

#### `forage_opportunity_class`
- `poor`
- `limited`
- `moderate`
- `strong`

#### `fuelwood_opportunity_class`
- `poor`
- `limited`
- `moderate`
- `strong`

#### `wildlife_cover_class`
- `poor`
- `limited`
- `moderate`
- `strong`

## 5.6 Human-use fields

| Field | Type | Purpose |
|---|---|---|
| `move_cost_class` | `String` | broad travel cost |
| `haul_cost_class` | `String` | carrying burden cost |
| `buildability_class` | `String` | whether structures can be placed safely |
| `sleep_suitability_class` | `String` | broad night-rest suitability |
| `fire_suitability_class` | `String` | broad hearth/fire risk practicality |
| `visibility_class` | `String` | line-of-sight / map readability helper |
| `site_candidate_score` | `float` | local site contribution score |
| `site_candidate_flag` | `bool` | whether this cell can contribute to a site patch |

### Canonical early values

#### `move_cost_class`
- `easy`
- `normal`
- `awkward`
- `difficult`
- `severe`

#### `haul_cost_class`
- `easy`
- `normal`
- `costly`
- `very_costly`

#### `buildability_class`
- `forbidden`
- `poor`
- `limited`
- `usable`
- `good`

#### `sleep_suitability_class`
- `forbidden`
- `poor`
- `limited`
- `usable`
- `good`

#### `fire_suitability_class`
- `forbidden`
- `poor`
- `limited`
- `usable`
- `good`

#### `visibility_class`
- `open`
- `mixed`
- `screened`
- `blocked`

## 5.7 Fog-of-war and knowledge fields

| Field | Type | Purpose |
|---|---|---|
| `reveal_state` | `String` | unknown / remembered / visible |
| `first_revealed_tick` | `int` | first reveal time |
| `last_seen_tick` | `int` | last directly visible time |
| `survey_quality_class` | `String` | how well the area has been evaluated |
| `terrain_confidence_class` | `String` | confidence in remembered interpretation |

### Canonical early values

#### `reveal_state`
- `unknown`
- `remembered`
- `visible`

#### `survey_quality_class`
- `none`
- `glanced`
- `walked`
- `inspected`

#### `terrain_confidence_class`
- `none`
- `rough`
- `usable`
- `good`

## 5.8 Runtime mutability rule

Split terrain fields into three groups.

### Static generated fields
Generated once and normally saved directly.
Examples:
- `elevation_step`
- `landform_type`
- `drainage_class`
- `surface_water_type`
- `ground_texture_class`
- `vegetation_community`

### Derived rebuildable fields
Can be recalculated from authoritative terrain inputs and current world state.
Examples:
- `site_candidate_score`
- `move_cost_class`
- `haul_cost_class`
- `buildability_class`
- `sleep_suitability_class`

### Mutable runtime fields
Change due to reveal, weather, disturbance, human footprint, or maintenance.
Examples:
- `reveal_state`
- `last_seen_tick`
- path wear contribution
- temporary standing water after weather events
- brush clearing / canopy thinning flags

---

# 6. Chunk schema

Each chunk should own:
- `chunk_id`
- `chunk_index: Vector2i`
- `bounds_rect`
- `seed_offset`
- `generation_state`
- `cells`
- `patch_ids`
- `runtime_dirty_flags`
- `reveal_summary`
- `last_rebuild_tick`

Recommended early values for `generation_state`:
- `uninitialized`
- `skeleton_generated`
- `terrain_generated`
- `objects_generated`
- `runtime_mutated`

Chunk purpose:
- keep rebuild work bounded
- support overlay refresh by chunk
- support later save/load chunk deltas
- support future streaming without redesign

---

# 7. Patch / zone schema

A patch is a higher-level terrain meaning object derived from contiguous or near-contiguous cells.

## 7.1 Patch record

| Field | Type | Purpose |
|---|---|---|
| `patch_id` | `String` | runtime patch identifier |
| `patch_type` | `String` | patch semantic identity |
| `cell_indices` | `Array[Vector2i]` | member cells |
| `centroid` | `Vector2` | center point |
| `area_cell_count` | `int` | size |
| `dominant_landform_type` | `String` | summary |
| `dominant_vegetation_community` | `String` | summary |
| `dominant_drainage_class` | `String` | summary |
| `site_score` | `float` | patch-level site utility |
| `resource_summary` | `Dictionary` | gatherable tendencies |
| `hazard_summary` | `Dictionary` | flood / damp / vector / exposure tendency |
| `reveal_state` | `String` | patch knowledge summary |

## 7.2 Canonical early `patch_type` values

- `candidate_camp_bench`
- `stream_corridor`
- `wet_margin`
- `open_meadow_patch`
- `woodland_patch`
- `woodland_edge_patch`
- `rocky_rise_patch`
- `poor_drainage_patch`
- `garden_candidate_patch`

## 7.3 Why patches matter early

Even in the early MVP, patches help with:
- site search reasoning
- “search for dry camp site” tasks
- “search for nearby fuelwood” tasks
- map inspector summaries
- reducing AI cost versus testing every cell for every decision

---

# 8. Object placement validation rules

Terrain is authoritative, so object placement must validate against terrain.

## 8.1 Minimum early placement rules

### Trees
- forbidden in `stream_channel` and `pond_open_water`
- normally forbidden in `waterlogged` cells unless the specific tree definition allows wet roots later
- density should respond to `vegetation_community`, `canopy_density_class`, and edge logic

### Reeds / wet-margin plants
- favored near `wet_margin_reeds`, `poor`, or `waterlogged` drainage cells
- favored near shallow water-table and open margin cells

### Berry shrubs / edge plants
- favored in `woodland_edge` or `rough_grass_scrub`
- avoid dense closed canopy centers in the MVP

### Stone / outcrop markers
- favored on `rocky_rise`, `ridge`, or `surface_rockiness_class = heavy/outcrop`

### Clay opportunity markers
- favored in fine, poorly drained low ground; not everywhere wet

### Site hints (temporary debug only)
- should be generated from site suitability logic, not authored as an independent world truth
- may remain visible in prototype builds as a debug interpretation layer

---

# 9. Debug overlay system

The terrain overlay system should be available from the start of real terrain generation.

## 9.1 Overlay design goals

Overlays must:
- reveal simulation truth clearly
- be readable over the map without needing final art
- help explain *why* a place behaves a certain way
- support both momentary spot checks and structured balancing work

## 9.2 Overlay categories

### Category A — structural terrain overlays
These show the static terrain substrate.

- `overlay_elevation`
- `overlay_slope`
- `overlay_landform`
- `overlay_surface_water`
- `overlay_drainage`
- `overlay_ground_firmness`
- `overlay_vegetation_community`

### Category B — practical use overlays
These show human-use consequences.

- `overlay_move_cost`
- `overlay_haul_cost`
- `overlay_buildability`
- `overlay_sleep_suitability`
- `overlay_fire_suitability`
- `overlay_garden_suitability`
- `overlay_sanitation_suitability`
- `overlay_site_score`

### Category C — risk overlays
These show settlement penalties and threats.

- `overlay_flood_risk`
- `overlay_wetness_tendency`
- `overlay_vector_pressure`
- `overlay_smoke_pooling_risk`
- `overlay_exposure`

### Category D — knowledge overlays
These show what is known and how well it is known.

- `overlay_reveal_state`
- `overlay_survey_quality`
- `overlay_terrain_confidence`
- `overlay_last_seen_age`

### Category E — generation validation overlays
These exist for tuning and debugging, not gameplay.

- `overlay_flow_accumulation`
- `overlay_flow_direction`
- `overlay_water_table_proximity`
- `overlay_patch_boundaries`
- `overlay_object_placement_conflicts`
- `overlay_site_patch_candidates`

## 9.3 Overlay presentation rules

- only one **major heatmap-style overlay** should be active at a time
- line overlays like contour lines, patch boundaries, and candidate outlines may stack with a major overlay
- fog-of-war should be composited on top of the terrain view, not replace terrain truth internally
- player-facing future overlays and developer overlays should share the same data, but developer overlays may expose more raw gradients and labels

## 9.4 Canonical early overlay color intent

These colors are intentionally descriptive, not final palette law.

### Elevation
- lower: darker cooler muted values
- higher: lighter warmer muted values

### Drainage / wetness
- drier: muted tan / olive
- wetter: cooler blue-green deepening toward saturation

### Build / sleep suitability
- poor: muted red-brown
- limited: amber
- usable/good: muted green

### Site score
- low: dull red-brown
- mid: amber/ochre
- high: pale warm green or straw-gold

### Reveal state
- unknown: near-black mask
- remembered: dark desaturated tint
- visible: no additional mask

## 9.5 Overlay toggle behavior

Recommended early controls:
- one key cycles overlay family
- one key cycles the current family’s mode
- one key toggles contour / patch / debug labels
- one key resets to hybrid aerial view

Do not hardcode final player-facing hotkeys yet.
For the early implementation, keyboard debug controls are acceptable.

---

# 10. Map inspector requirements

The terrain system should support a **cell inspector** and a **patch inspector**.

## 10.1 Cell inspector

Clicking or hovering in debug mode should show:
- cell coordinate
- elevation step
- slope class
- landform type
- surface water type
- drainage class
- wetness tendency
- ground firmness class
- vegetation community
- move cost class
- buildability class
- site candidate score
- reveal state

## 10.2 Patch inspector

Clicking a patch should show:
- patch type
- area cell count
- dominant terrain summary
- resource opportunity summary
- hazard summary
- site score
- reveal summary

This inspector is important because realism tuning often depends on **why** a patch exists, not just where it is.

---

# 11. Telemetry hooks for terrain generation

The terrain generator should emit telemetry events compatible with the debug / telemetry spec.

## 11.1 Required generation events

- `terrain_region_profile_selected`
- `terrain_relief_generated`
- `terrain_hydrology_generated`
- `terrain_drainage_generated`
- `terrain_vegetation_generated`
- `terrain_patch_graph_built`
- `terrain_site_scores_computed`
- `terrain_objects_validated`
- `terrain_generation_completed`

## 11.2 Required validation / warning events

- `terrain_invalid_object_placement`
- `terrain_site_candidate_contradiction`
- `terrain_unreachable_water_access`
- `terrain_excessive_low_ground_cluster`
- `terrain_overlay_rebuild_requested`

## 11.3 Useful payload fields

- `seed`
- `scenario_id`
- `chunk_id`
- `cell_count`
- `surface_water_cell_count`
- `candidate_site_patch_count`
- `avg_site_score`
- `warning_count`

---

# 12. Godot implementation notes

## 12.1 Data should not live only inside visual nodes

Authoritative terrain data should live in simulation-owned world data structures.
Map nodes should render from that data.

Recommended split:
- simulation layer owns region / chunk / cell / patch records
- rendering layer reads from that data and builds visible map layers
- debug UI reads the same data and exposes overlays/inspectors

## 12.2 Recommended early renderer relationship

- base terrain visual layer
- water / wet-edge visual layer
- vegetation impression layer
- optional hillshade / contours
- fog-of-war / remembered overlay
- debug overlay layer
- cell / patch inspector UI on top

A dedicated `TileMapLayer` stack remains appropriate for grid-aligned layers, with other world visuals added separately where needed.

## 12.3 Overlay rendering rule

Do not bake overlay logic into the terrain tiles themselves.
Overlays should be dynamically generated from terrain data so that:
- multiple modes can reuse the same substrate
- color ramps can be tuned quickly
- remembered/visible state can be combined cleanly
- debug and player-facing map modes remain consistent

## 12.4 Noise usage rule

`FastNoiseLite` or similar helpers may be used for variation, but noise must remain a **supporting tool**.
It must not replace the causal generation sequence.

Use noise mainly for:
- edge breakup
- sub-patch variation
- local irregularity
- canopy texture distribution
- slight shoreline irregularity

Do not use raw uncorrelated noise as the final authority for:
- rivers
- drainage classes
- site quality
- vegetation communities

---

# 13. Early implementation order

## Phase 1 — terrain substrate only

Implement:
- region profile record
- chunk record
- terrain cell record
- minimal patch record
- debug inspector shell
- elevation / drainage / water / reveal overlays

Goal:
- replace the placeholder map with real inspectable terrain truth

## Phase 2 — derived human-use layers

Implement:
- move cost
- haul cost
- buildability
- sleep suitability
- sanitation suitability
- site score
- patch candidate extraction

Goal:
- make the terrain directly useful to early survival systems

## Phase 3 — ecology and object validation

Implement:
- vegetation community derivation
- resource opportunity fields
- terrain-aware object placement
- object placement conflict overlay

Goal:
- make the map look and behave plausibly without resorting to decorative randomness

## Phase 4 — fog / memory integration

Implement:
- reveal state persistence
- remembered terrain tinting
- survey quality and confidence
- inspector behavior for unknown vs remembered cells

Goal:
- make exploration and map knowledge meaningful

---

# 14. Minimum acceptance checks

The first terrain data implementation should not count as acceptable until the following are true.

## 14.1 Structural checks

- every generated cell has valid terrain fields
- no open-water cells are marked buildable or good sleeping ground
- drainage and wetness correlate sensibly with surface water and relief
- patch derivation produces coherent candidate areas rather than noise speckles

## 14.2 Practical checks

- site score highlights dry benches and penalizes flood-prone low ground
- move / haul overlays visibly punish marshy, cluttered, or sloped cells
- sanitation suitability clearly rejects wet ground and water-adjacent cells
- tree placement and similar objects respect terrain exclusions

## 14.3 Debugging checks

- overlays can be switched live without regenerating the map
- cell inspection always reports the authoritative cell record
- unknown / remembered / visible states display correctly
- telemetry reports terrain generation events and validation warnings

---

# 15. What not to do yet

Do not add these before the basic schema and overlays are working:
- full continent generation
- geological strata simulation
- highly detailed erosion simulation
- complex hydrodynamic flooding
- biome explosion
- player-facing cartography tools
- final pretty map shaders

The first objective is **trustworthy terrain truth**.
The second objective is **readable map rendering**.
The third objective is richer art and polish.

---

# 16. Short practical summary

The first real terrain implementation should be built around:
- one authoritative terrain cell record
- one chunking layer for performance and save boundaries
- one patch layer for higher-level terrain meaning
- one overlay system for inspecting terrain truth
- one inspector for understanding why a location behaves the way it does

If those pieces are done well, the project can move from a placeholder map to a believable survival landscape without needing final art quality first.

---

# 17. Reference anchors

Project-side anchors:
- `realistic_idle_city_design_documents/realistic_idle_city_world_map_site_generation_spec_v0_1.md`
- `realistic_idle_city_world_generation_map_rendering_spec_v0_1.md`
- `realistic_idle_city_terrain_generation_spec_v0_1.md`
- `realistic_idle_city_unified_data_dictionary_v0_1.md`
- `realistic_idle_city_debug_telemetry_spec_v0_1.md`

External realism anchors used to justify the data model:
- U.S. Geological Survey material on groundwater and surface water functioning as one linked resource
- U.S. EPA wetland guidance emphasizing the interaction of hydrology, soils, and vegetation
- U.S. Forest Service riparian guidance emphasizing elevation above channel, flood frequency, substrate, and water-table relationships
- FAO / land-suitability logic that practical land use depends on combined terrain, drainage, soil condition, water access, and hazards
- Godot official documentation for `TileMapLayer`, `Camera2D`, `CanvasItem`, and `FastNoiseLite`
