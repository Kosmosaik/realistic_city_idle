# Realistic Idle City — Terrain Generation Spec v0.1

## Purpose

This document defines the **first implementation-facing terrain generation model** for the project.

It exists to answer:
- how terrain should be generated so it feels **organic, natural, and believable**
- how terrain logic should support the early playable slice without becoming a giant continent simulator
- how **relief, hydrology, drainage, soils, vegetation, resources, and site suitability** should be causally linked
- what should be derived from the land versus what may be placed later as authored or gameplay content
- what belongs in the **MVP terrain model** versus what should wait

This is **not** a graphics-only document.
It is a **terrain causality document**.
The map should look natural because the terrain system is believable, not because textures are hiding weak logic.

---

## Relationship to the current document stack

This spec should be treated as a **terrain-logic companion** to the existing world generation, map rendering, aerial map graphics, early-game MVP, and architecture docs.

Practical authority split:
- `realistic_idle_city_world_map_site_generation_spec_v0_1.md` remains authoritative for the broader world/site generation intent
- `realistic_idle_city_world_generation_map_rendering_spec_v0_1.md` remains authoritative for 2D elevation treatment, map layers, rendering modes, fog of war, and timing
- `realistic_idle_city_aerial_map_graphics_implementation_spec_v0_1.md` remains authoritative for the graphics/rendering direction
- `realistic_idle_city_terrain_generation_spec_v0_1.md` is authoritative for the **first concrete terrain causality model** used by the early implementation

If there is conflict:
1. latest user instructions
2. handoff/source-of-truth order
3. early-game implementation needs
4. this terrain generation spec
5. older broader world-generation text

---

## Core stance

### 1. Terrain realism must come from cause and consequence

The terrain generator should **not** be built as:
- random noise for height
- random noise for trees
- random noise for resources
- random noise for water

That produces variety, but not believable land.

The generator should instead follow this order:
1. **regional profile**
2. **relief skeleton**
3. **hydrology**
4. **soil / drainage / wetness tendency**
5. **vegetation communities**
6. **resource opportunities derived from those**
7. **site suitability derived from those**
8. **render interpretation**

The map should teach the player how the world works.
If the player sees low wet ground, they should infer dampness, insects, reeds, soft footing, and sanitation risk.
If they see a raised bench, they should infer a better camp site but a longer haul to water.

### 2. First-pass terrain must stay narrow and well tuned

The first implementation should support **one strong early-game terrain family**, not many weak ones.

Default terrain family for MVP:
- temperate valley
- modest stream corridor
- mixed meadow / brush / woodland
- small wet pockets
- some rocky or raised drier ground
- enough ecological contrast to make site choice meaningful

This keeps the terrain system grounded in the actual early-game survival questions:
- where is the water
- where is dry enough to sleep
- where is fuel
- where is food opportunity
- where can waste be separated
- where can the camp grow into something more permanent

### 3. Terrain should be fluid and condition-based, not stage-painted

The generator should not create fixed “camp stages” in the landscape.
It should create land with real constraints.
The player and NPCs discover, evaluate, exploit, and modify that land over time.

---

## Real-world principles to preserve

These principles come directly from real hydrology, wetland science, soil interpretation, and riparian ecology.

### 4. Surface water and groundwater are linked

Streams, wetlands, ponds, groundwater, and soil water interact continuously.
The terrain model should therefore treat water as a linked system rather than isolated blue tiles.

Implementation implication:
- surface water placement should depend on relief and drainage, not random decoration
- wet soils can exist without open water
- seep zones and seasonally wet ground can exist away from the main visible channel

### 5. Wet ground is defined by hydrology, soils, and vegetation together

Real wetlands are commonly identified by the joint presence of wetland hydrology, hydric/wet soils, and hydrophytic vegetation.

Implementation implication:
- the generator should not classify wet ground by color alone
- a wet area should tend to co-produce:
  - poor drainage
  - a shallow water table or prolonged saturation tendency
  - vegetation adapted to those conditions
  - different footing, sanitation, and site suitability behavior

### 6. Riparian vegetation follows moisture gradients and fluvial disturbance

Riparian plant communities organize themselves along moisture, elevation-above-channel, soil texture, water-table depth, and flood disturbance gradients.

Implementation implication:
- vegetation should form **zones and gradients**, not random scatter
- channel margins, natural levees, low wet hollows, slough-like edges, and better-drained banks should look and behave differently

### 7. Soil drainage and slope change land suitability

Soil interpretations for land use depend heavily on drainage, wetness, depth, texture, runoff, slope, and erosion hazard.

Implementation implication:
- camp suitability should be derived from multiple land properties
- gardens, latrines, sleeping spots, paths, and structures should not all prefer the same terrain

### 8. Floodplains contain small but important relief differences

Natural levees, backswamps, sloughs, low floodplain hollows, and slightly raised benches can all exist within a landscape that still looks generally flat at first glance.

Implementation implication:
- the terrain system should support **micro-relief with big gameplay consequences**
- a difference of one elevation band can change:
  - wetness
  - flood risk
  - vegetation
  - soil condition
  - camp desirability

---

## MVP terrain family

### 9. Canonical early profile

The first terrain generator should produce a believable **temperate woodland-valley survival landscape**.

Minimum expected features:
- one primary freshwater stream corridor
- at least one reachable dry bench or raised terrace-like area
- at least one visibly wetter low area
- mixed open ground and tree cover
- scattered rocky or firmer patches
- enough resource-bearing habitats to support first survival decisions

### 10. What this terrain family must support

The terrain must make these early questions meaningful:
- accessible but not perfect water
- short-term sleep vs long-term camp quality
- haul distance tradeoffs
- fuel access vs visibility/open space
- sanitation distance and drainage logic
- early food gathering and first managed plots
- future expansion room for camp organization

---

## Terrain scales

### 11. Regional scale

For MVP, the regional scale is a compact profile, not a full simulated continent.

Regional profile fields should include:
- `region_profile_id`
- `climate_family_id`
- `seasonality_profile_id`
- `rainfall_profile_id`
- `relief_family_id`
- `channel_density_band`
- `soil_parent_material_profile_id`
- `vegetation_family_id`

This layer exists to shape the local map generator, not to be fully traversable yet.

### 12. Local playable scale

The local playable map is the authoritative early-game terrain surface.

Each simulated terrain cell or terrain patch should be able to hold:
- `elevation_step`
- `slope_class`
- `landform_type_id`
- `surface_water_class_id`
- `drainage_class_id`
- `soil_depth_class_id`
- `ground_firmness_class_id`
- `wetness_tendency_class_id`
- `vegetation_community_id`
- `buildability_class_id`
- `garden_suitability_class_id`
- `sanitation_suitability_class_id`
- `path_cost_class_id`
- `visibility_class_id`
- `hazard_flags`

---

## Terrain logic model

### 13. Relief first: the land needs a skeleton

The generator should begin with a **landform skeleton**, not detailed decoration.

Recommended MVP landform set:
- `landform.ridge_low`
- `landform.upper_slope`
- `landform.mid_slope`
- `landform.foot_slope`
- `landform.dry_bench`
- `landform.valley_floor_dry`
- `landform.valley_floor_wet`
- `landform.stream_corridor`
- `landform.wet_depression`
- `landform.rocky_rise`

These should be generated as **connected shapes** and transitions, not tile-by-tile randomness.

### 14. Use discrete elevation and slope classes

The 2D map should use discrete simulation bands, not free-floating continuous height for MVP.

Recommended MVP elevation bands:
- `elevation.lowest_wet`
- `elevation.low`
- `elevation.base`
- `elevation.raised`
- `elevation.high`

Recommended MVP slope classes:
- `slope.flat`
- `slope.gentle`
- `slope.moderate`
- `slope.steep`

This is enough to produce believable hydrology and site tradeoffs without turning the project into a full geomorphology simulator.

### 15. Hydrology must be derived from relief

After the relief skeleton exists, derive water behavior from it.

MVP hydrology classes:
- `surface_water.none`
- `surface_water.stream_main`
- `surface_water.stream_minor`
- `surface_water.pond_margin`
- `surface_water.seep`
- `surface_water.seasonally_wet_ground`

Hydrology rules:
- channels should occupy the lowest connected route through the valley structure
- seep or persistent damp zones may appear where subsurface water would likely emerge near slope breaks or valley margins
- ponds should prefer enclosed or poorly drained low points, not arbitrary circles
- wet ground may appear beyond open water due to poor drainage and shallow groundwater influence

### 16. Drainage should be its own layer, not a synonym for elevation

Two places at the same elevation can still differ in drainage due to soil, micro-relief, and connection to the channel.

Recommended MVP drainage classes:
- `drainage.excessive`
- `drainage.good`
- `drainage.moderate`
- `drainage.poor`
- `drainage.very_poor`

Drainage should be influenced by:
- landform position
- slope
- soil depth / texture tendency
- distance to wet corridor
- enclosed local depressions

### 17. Soils should be simplified but meaningful

The MVP does not need full pedology, but it does need believable ground behavior.

Recommended MVP soil-related fields:
- `soil_texture_family_id`
- `soil_depth_class_id`
- `soil_stoniness_class_id`
- `drainage_class_id`
- `organic_wetness_flag`

Suggested simplified texture families:
- `soil_texture.coarse`
- `soil_texture.mixed_loam`
- `soil_texture.fine`
- `soil_texture.organic_wet`
- `soil_texture.stony_shallow`

These should affect:
- garden suitability
- path wear / mud tendency
- latrine suitability
- clay opportunity
- footing / hauling cost
- tree and reed likelihood

---

## Vegetation generation

### 18. Vegetation should form communities, not random single-asset scatter

The terrain generator should derive vegetation as **communities** from moisture, drainage, landform, and disturbance tendency.

Recommended MVP vegetation communities:
- `veg.open_meadow`
- `veg.patchy_meadow`
- `veg.brushy_edge`
- `veg.mixed_woodland_open`
- `veg.mixed_woodland_dense`
- `veg.riparian_strip`
- `veg.wet_margin_reeds`
- `veg.stony_sparse`

### 19. Use gradients and edges

Natural landscapes are often defined by transitions:
- open ground becoming brush
- brush becoming woodland edge
- drier bank grading into wetter margin
- firmer bench fading into softer valley floor

Implementation rule:
- generate broad habitat zones first
- then create edge breakup and density variation
- never scatter trees evenly across all non-water ground

### 20. Tree distribution rules

Trees in MVP should prefer:
- riparian strips with enough non-open-water ground
- better-drained woodland patches
- edge habitats and mixed stands
- some drier rises if the vegetation family allows it

Trees should avoid or heavily reduce in:
- open channel water
- pond interiors
- marsh core zones
- very soft saturated ground
- site-hint or future debug reservation zones when active

### 21. Wet-margin vegetation rules

Wet edges should not just be “water with trees nearby.”
They should support their own community logic.

Wet-margin communities may co-produce:
- reeds/fiber plants
- more insects later
- soft footing
- poor sleeping ground
- increased sanitation sensitivity
- possible clay/mud opportunity nearby

---

## Resource derivation

### 22. Resources should be consequences, not decorative nodes

The terrain generator should not place resources as disconnected loot markers.

Instead, derive opportunities such as:
- `resource_opportunity.timber_small`
- `resource_opportunity.deadwood`
- `resource_opportunity.brush_fiber`
- `resource_opportunity.reeds`
- `resource_opportunity.stone_loose`
- `resource_opportunity.clay_near_wet_fine_soil`
- `resource_opportunity.berry_edge_patch`
- `resource_opportunity.small_game_cover`

Examples:
- deadwood tends to increase in wooded areas but may cluster near older denser stands or storm-prone edges
- reeds belong near wet margins, not dry benches
- clay opportunity belongs near fine wet soils or exposed muddy edges, not rocky rises
- berries prefer edges and openings, not every dense canopy interior
- loose stone is more plausible on stony rises, eroded patches, and sparse rocky ground

### 23. Resource abundance should not erase survival pressure

The first terrain profile must support survival, but should not trivialize it.

Design rule:
- every major survival need should have a plausible acquisition path
- not every need should be locally abundant at the best camp site
- meaningful haul and site tradeoffs must remain intact

---

## Site suitability

### 24. Good sites should be derived, not spawned as magic objects

The terrain generator should not create a permanent “camp site object” as part of world truth.
A good site should emerge from terrain conditions.

The current visible site hint may remain as a **debug/prototype aid**, but the actual game logic should derive candidate sites from contiguous terrain.

### 25. Site scoring categories

Candidate sites should be evaluated on at least:
- water access distance
- flood / wetness risk
- sleep-ground dryness
- buildable contiguous area
- sanitation separation potential
- fuel/material access
- expansion room
- path burden
- visibility/exposure tradeoffs

### 26. Site scoring should be area-based

A site is not a point.
It is a contiguous area large enough to support:
- sleeping zone
- fire/work zone
- storage zone
- movement room
- later sanitation separation and expansion

Implementation rule:
- score patches or contiguous clusters, not single cells
- allow multiple viable sites with different tradeoffs
- allow the “best” site to be situational rather than universal

---

## Recommended generation pipeline

### 27. Generation sequence

For the first terrain implementation, use this sequence:

1. select regional profile and seed
2. create broad relief skeleton
3. assign elevation bands and slope classes
4. carve the primary drainage route / stream corridor
5. derive low wet areas, seep zones, and poorly drained pockets
6. derive soil/drainage/wetness classes
7. assign vegetation communities from those conditions
8. derive resource opportunities from vegetation + soils + landform
9. score candidate site areas
10. pass the result to the map renderer

### 28. Preferred shape logic

Use **large connected shapes first**, then local breakup.

Good pattern:
- broad valley floor polygon
- one or two raised bench areas
- one stream corridor with slight bends
- one or two wet pockets or slough-like low zones
- one rocky rise or stony patch
- woodland concentrated in plausible habitat bands
- edge/noise breakup after the structural pass

Bad pattern:
- independent noise maps competing with each other
- perfectly uniform tree scatter
- water placed after vegetation as an overlay
- random circles of “resource terrain” without landscape logic

### 29. Noise usage rule

Noise is allowed, but only as a helper.

Use noise for:
- edge breakup
- local density variation
- texture/detail variation
- irregular boundaries

Do not use noise alone to decide:
- where the stream goes
- where the valley is
- where wetlands are
- where the best sites are

---

## MVP validation rules

### 30. A generated map is acceptable only if it passes these checks

Every generated MVP map should pass terrain validation such as:
- at least one reachable freshwater access path exists
- at least one contiguous reasonably dry camp candidate area exists
- at least one wetter low-risk-to-identify area exists
- at least one fuel-bearing vegetation zone exists within early hauling distance
- at least one primitive stone opportunity exists within realistic scouting distance
- the map contains meaningful tradeoffs rather than one strictly dominant perfect site
- major terrain communities are spatially coherent
- open water does not contain ordinary tree placement
- vegetation density transitions read naturally at the map scale

### 31. A map should fail generation if it is “technically possible but obviously gamey”

Examples of unacceptable output:
- stream with no plausible lowland structure around it
- dense trees uniformly stopping at a perfect circle around water
- pond in the middle of a steep dry rise with no wet margin logic
- site candidates only because a marker was placed there
- resources sprinkled evenly regardless of terrain

---

## MVP simplifications that are allowed

### 32. Acceptable simplifications

These are acceptable for v0.1 terrain generation:
- one terrain family only
- one main stream only
- simplified groundwater/seep logic
- discrete elevation bands
- simplified soil families instead of full soil taxonomy
- simplified vegetation communities
- opportunity-based resource derivation instead of full ecology simulation
- no full erosion or sediment transport simulation
- no biome-spanning world map yet

### 33. Simplifications that are not acceptable

These would damage the realism goal too much:
- decorative water not driven by terrain
- tree placement ignoring wetness/open water logic
- identical suitability everywhere except random points of interest
- treating resources as disconnected game nodes with no habitat meaning
- flattening all low ground into the same behavior
- making terrain visually rich but mechanically meaningless

---

## Recommended implementation order

### 34. Build order

1. define terrain enums and shared field names in the dictionary if needed
2. implement one hand-authored reference map using the terrain model
3. build terrain debug overlays for elevation, drainage, wetness, vegetation, and site score
4. implement the first structured terrain generator for the canonical temperate valley profile
5. add validation rules
6. tune for believable site tradeoffs
7. only then deepen the aerial rendering style

### 35. Branch recommendation

This terrain generator is likely a **post-Branch-00 / early world branch** concern.
It should be implemented before broad gameplay expansion, but after the basic project shell and early definition/data scaffolding are stable.

---

## Anti-patterns to avoid

### 36. Do not do these

- do not build the first version as stacked independent noise maps
- do not use photographic-looking art to hide weak terrain logic
- do not place site quality as a magic spawned object
- do not let all good survival resources cluster on the same ideal square
- do not over-generalize to many biome families too early
- do not simulate continents when the project needs believable local terrain first

---

## Short practical summary

The first terrain generator should create **one believable temperate stream-valley landscape** where:
- relief explains water
- water explains wetness
- wetness and soils explain vegetation
- vegetation and terrain explain resources
- all of those together explain where a human would want to camp

That is what will make the map feel real, organic, and natural even before the final aerial graphics style is fully polished.

---

## Research anchors

This spec is grounded in broad, durable real-world principles from hydrology, soil interpretation, wetland science, riparian ecology, and land suitability work, including:

- USGS work on linked groundwater / surface-water systems and hydrologic interactions
- EPA wetland guidance emphasizing the combined role of hydrology, soils, and vegetation
- USDA / NRCS soil interpretation material emphasizing drainage, wetness, slope, erosion, and suitability
- USFS riparian ecology work emphasizing moisture gradients, elevation above channel, groundwater influence, and fluvial disturbance
- FAO land-evaluation guidance emphasizing that land suitability depends on terrain, soils, water, vegetation, and intended use together rather than any single factor in isolation

These research anchors should guide future refinements even when the actual implementation remains simplified.
