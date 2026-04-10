# Realistic Idle City — World Generation + Map Rendering Spec v0.1

## Purpose

This document converts the existing world/site design work into an **implementation-facing spec** for the early playable slice:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It defines:
- **when** world generation should be implemented
- how the **world model** should be structured
- how a **2D map with elevation** should work
- how a **synthetic aerial / topographic hybrid map** should be rendered
- how **fog of war / exploration / map knowledge** should behave
- what belongs in the **MVP** versus what should wait

This document is intentionally early-game focused.
It is not a continent generator, not a full cartography simulator, and not a late-game transport geography spec.

---

# 1. Relationship to the current document stack

This spec should be treated as an **implementation companion** to the existing world/map/site generation work, UI map/overlay work, early-game MVP scope, and unified naming/schema work.

Practical rule:
- `realistic_idle_city_world_map_site_generation_spec_v0_1.md` remains authoritative for terrain logic, hydrology, drainage, vegetation/resource derivation, and site-score logic
- `realistic_idle_city_world_generation_map_rendering_spec_v0_1.md` is authoritative for 2D elevation treatment, rendering stack, camera/zoom modes, fog-of-war behavior, and implementation timing
- this document narrows the broader world/site design into an actionable generation + rendering plan without replacing the older terrain-logic document
- if there is conflict, use the **early-game MVP** and latest user instructions as the authority

This spec must remain consistent with:
- realism-first survival-to-hamlet scope
- top-down Godot presentation with minimal object/NPC visuals and simulation-derived map richness where it improves readability
- explicit object/state presentation from the start
- policy/priority/order-based control rather than puppeteering
- map-centered, overlay-rich UI
- balance and fun through tuning, not through flattening the world into decorative terrain

---

# 2. Core stance

## 2.1 The map is simulation first, rendering second

The world should not be generated as:
- pretty terrain first
- random resources second
- gameplay logic third

It should be generated as:
1. **regional profile**
2. **relief / landform**
3. **hydrology**
4. **soil / drainage / wetness tendency**
5. **vegetation communities**
6. **resource opportunities derived from those**
7. **hazard opportunities derived from those**
8. **starter-site candidates**
9. **render interpretation of all of the above**

The render should look convincing because the underlying place makes sense.

## 2.2 The target look is “synthetic aerial”, not literal satellite realism

The desired visual direction is:
- reads like an aerial photo at a glance
- supports topographic interpretation
- remains clear while zooming
- stays cheap enough to build in a minimal-art project

This means:
- forest appears as canopy masses
- meadow/open ground appears as restrained textured surfaces
- wet ground and stream corridors read clearly
- elevation can be toggled or blended in through hillshade/contours
- the player can switch between **aerial**, **topographic**, **hybrid**, and gameplay overlays

Do **not** aim for literal photographic realism in the MVP.
Aim for **believable land-pattern realism**.

## 2.3 Fog of war is required

Unknown land should not be fully known on day one.
NPCs must physically reveal nearby terrain and features while exploring.

However, the fog system should be designed for both realism and fun:
- complete unknown should feel mysterious and consequential
- already explored land should stay legible in memory
- coarse terrain understanding may remain visible even when detailed feature knowledge does not
- current visibility, remembered terrain, and trusted knowledge must be treated separately

## 2.4 World generation matters now, full procgen does not

The **world model and renderer contract** should be defined now.
The **full procedural generator** should come only after the survival loop is stable on hand-authored test maps.

This is the timing stance for the project.

---

# 3. Recommended timing

## 3.1 What should happen now

Define now:
- canonical world data model
- elevation/drainage/hydrology rules
- map layer stack
- fog-of-war behavior
- camera/zoom behavior
- starter-site generation rules
- what the renderer expects from the generator

## 3.2 What should happen before full procedural generation

Build first:
- 2–4 hand-authored local maps using the same data model
- one balanced benchmark map
- one wetter / muddier / sanitation-annoying map
- one drier / rockier / farther-water map
- optionally one harsh edge-case map

Why:
- faster balance iteration
- easier debugging of hauling, water, shelter, sanitation, and exploration logic
- renderer can be tested before generation complexity explodes

## 3.3 When to implement procedural generation

Implement the first procedural version **after**:
- the map renderer exists
- the camera/zoom/fog stack exists
- the lone-survivor survival loop works on authored maps
- site selection and hauling burden already matter in practice

## 3.4 Recommended order

1. Unified Data Dictionary v0.1  
2. This World Generation + Map Rendering Spec  
3. Hand-authored local test maps  
4. Map renderer + camera + fog-of-war implementation  
5. Core survival-loop implementation on authored maps  
6. MVP starter-area procedural generator  
7. Balance pass  
8. Permanent camp / tiny hamlet expansion  
9. Later biome and region expansion

---

# 4. World scales

The world should be handled at **three scales**.

## 4.1 Regional profile scale

This is not the full playable terrain.
It is a compact generator input that defines the local map’s broad ecological identity.

Examples:
- `profile_temperate_stream_bench`
- `profile_temperate_rolling_meadow_woodland`
- `profile_temperate_rocky_foothill_spring`

The regional profile determines tendencies such as:
- relief character
- stream density
- wetness tendency
- likely soil families
- likely vegetation mix
- likely stone/clay opportunity
- seasonal harshness

## 4.2 Local playable map scale

This is the authoritative early-game simulation map.
It must support:
- walking
- hauling
- camp placement
- water access
- shelter siting
- latrine separation
- storage placement
- gathering
- early gardening
- scouting and fog-of-war reveal

For the MVP, this local map is the important map.
The broader world beyond it can remain abstract.

## 4.3 Object/feature scale

On top of the local terrain grid, the game places discrete things such as:
- trees
- shrubs
- stone clusters
- clay exposures
- berry patches
- spring access points
- stream access points
- structures
- stockpoints
- paths
- waste areas
- gardens
- camp objects

The terrain substrate and the object layer must remain separate.

---

# 5. Canonical early-map scope

## 5.1 Default world profile for first playable

The canonical early world profile should remain a **temperate mixed woodland / meadow / stream-edge landscape** with:
- one reliable-enough freshwater opportunity discoverable early
- at least one dry-enough camp area
- at least one tempting-but-bad site
- nearby wood/fuel opportunities
- some stone access
- clay or clay-rich mud within the broader reachable area
- edible plant and small-game opportunities
- weather/wetness pressure that makes drainage matter

## 5.2 What the first generator must guarantee

The MVP generator must guarantee at least one **viable survival route**, not one perfect site.

That means within early scouting range there must be:
- reachable water
- a dry-enough sleeping/building zone
- enough gatherable material to make the first shelter/fire/container path possible
- some sanitation separation opportunity
- enough route variation that site choice matters

## 5.3 What the first generator should avoid

Avoid in the MVP:
- giant map emptiness with no meaningful decisions
- hyper-dense resource abundance that trivializes survival
- beautiful but non-functional scenery
- terrain that prevents camp viability entirely
- maps where the “best” site is always obvious from frame one

---

# 6. Elevation in a 2D world

## 6.1 Elevation is simulation data, not 3D geometry

For the early game, elevation should not be treated as a true 3D terrain system.
It should be stored as **discrete elevation steps** on a 2D simulation grid.

The point of elevation is to drive:
- water flow tendency
- wetness accumulation
- drainage quality
- flood vulnerability
- movement burden
- buildability
- site quality
- line-of-sight quality in a simplified way

## 6.2 Recommended elevation model

Use a discrete `elevation_step` field rather than arbitrary continuous height as the main gameplay variable.

Suggested coarse band logic:
- `-2` = wet hollow / marsh pocket / channel depression
- `-1` = low ground / damp low flat / flood-prone margin
- `0` = normal ground
- `1` = raised bench / dry rise
- `2` = ridge / rocky rise / strongly elevated ground
- `3` = steep high point / cliff-edge band / exposed crest if needed

The exact numeric range can vary, but the model should stay **coarse and meaningful**.

## 6.3 Derived fields from elevation

The generator should derive from neighboring elevation values:
- `slope_class`
- `landform_type`
- `drainage_class`
- `flood_risk_class`
- `movement_cost`
- `visibility_cost`
- `buildability_class`

## 6.4 Why discrete elevation is the right fit

It supports realism while keeping the project:
- readable in top-down view
- cheap to simulate
- simple to expose via overlays
- compatible with minimal art
- easier to pathfind on

---

# 7. Canonical terrain model

## 7.1 Recommended minimum landform set

The early-game map should use a small but meaningful landform vocabulary.

Recommended first set:
- `ridge`
- `upper_slope`
- `mid_slope`
- `bench`
- `gentle_flat`
- `valley_floor`
- `wet_hollow`
- `channel_edge`
- `floodplain_margin`
- `rocky_knoll`

Not every profile needs all of them, but the model should support them.

## 7.2 Recommended slope classes

- `flat`
- `gentle`
- `moderate`
- `steep`
- `impassable` later if needed

## 7.3 Recommended drainage classes

- `well_drained`
- `moderately_drained`
- `poorly_drained`
- `waterlogged`

## 7.4 Recommended surface / firmness classes

- `firm`
- `soft`
- `muddy`
- `stony`
- `brushy`
- `wet_margin`

These are useful for both movement and rendering.

---

# 8. World data model

This section defines the recommended authoritative data records.

## 8.1 WorldProfile

Represents the regional input for a local map.

Suggested fields:
- `world_profile_id`
- `display_name`
- `climate_band`
- `seasonality_profile`
- `relief_profile`
- `stream_density_class`
- `stone_abundance_class`
- `clay_opportunity_class`
- `vegetation_mosaic_profile`
- `hazard_biases`
- `starter_site_ruleset_id`

## 8.2 WorldCell

This remains the authoritative simulation cell.

Suggested fields:
- `cell_id`
- `cell_x`
- `cell_y`
- `elevation_step`
- `slope_class`
- `landform_type`
- `drainage_class`
- `flood_risk_class`
- `soil_texture_class`
- `soil_depth_class`
- `surface_firmness_class`
- `moisture_tendency_class`
- `sun_exposure_class`
- `wind_exposure_class`
- `terrain_surface_type`
- `vegetation_community_type`
- `canopy_density_class`
- `understory_density_class`
- `movement_cost`
- `visibility_cost`
- `buildability_class`
- `garden_suitability_class`
- `latrine_suitability_class`
- `storage_suitability_class`
- `shelter_suitability_class`
- `water_access_score`
- `stone_potential_score`
- `deadwood_potential_score`
- `pole_potential_score`
- `fiber_potential_score`
- `food_gather_potential_score`
- `small_game_potential_score`
- `tick_risk_score`
- `mosquito_risk_score`
- `fire_risk_score`
- `smoke_retention_score`
- `contamination_flow_bias`
- `traffic_load`
- `burn_load`
- `path_wear_level`
- `zone_flags`

## 8.3 FeatureInstance

Represents a discrete map feature.

Suggested fields:
- `feature_id`
- `feature_def_id`
- `feature_category`
- `origin_cell_ids`
- `display_anchor_cell_id`
- `resource_family`
- `abundance_class`
- `quality_class`
- `seasonal_state`
- `access_difficulty_class`
- `reliability_class`
- `disturbance_state`
- `current_visibility_state`
- `last_seen_tick`

Examples:
- spring access point
- berry patch
- clay seam
- stony patch
- dense brush corridor
- reed band
- animal trail crossing

## 8.4 WaterFeature

Suggested fields:
- `water_feature_id`
- `water_feature_type`
- `linked_cell_ids`
- `flow_class`
- `reliability_class`
- `access_class`
- `contamination_sensitivity_class`
- `seasonal_variability_class`
- `trust_state`
- `notes_for_discovery`

## 8.5 SiteCandidate

Suggested fields:
- `site_candidate_id`
- `candidate_cell_ids`
- `dryness_score`
- `water_access_score`
- `materials_score`
- `sanitation_score`
- `expansion_score`
- `garden_score`
- `travel_score`
- `hazard_score`
- `overall_site_class`
- `main_strength_tags`
- `main_weakness_tags`

## 8.6 VisibilityCellState

This is required for fog of war.

Suggested fields:
- `cell_id`
- `fog_state`
- `last_seen_tick`
- `first_seen_tick`
- `last_scouted_tick`
- `terrain_memory_quality`
- `dynamic_memory_quality`
- `reported_by_npc_ids`

### Canonical fog states for MVP
- `unseen`
- `explored`
- `visible`

### Meaning
- `unseen` = the player has not explored it enough to know the local terrain/features
- `explored` = the terrain is remembered, but dynamic state is stale
- `visible` = currently within active observation range of at least one observing NPC

## 8.7 FeatureKnowledgeState

Features need more nuance than cells.

Suggested fields:
- `feature_id`
- `knowledge_state`
- `confidence_state`
- `last_verified_tick`
- `seasonal_reliability_notes`

Recommended values:
- `knowledge_state`: `unknown`, `suspected`, `observed`, `familiar`
- `confidence_state`: `tentative`, `reliable`, `trusted`

This lets the player know the difference between:
- “there might be water there”
- “we saw water there once”
- “that spring is dependable”

---

# 9. Fog of war, exploration, and map knowledge

## 9.1 Design goals

The fog system should support all of these at once:
- unexplored land matters
- scouting is real labor
- map reading feels satisfying
- knowledge can improve over time
- remembered terrain remains useful
- dynamic conditions can still surprise the player

## 9.2 Settlement-shared memory for MVP

For the MVP, use **settlement-shared map memory**.

Rule:
- if any controlled NPC observes a cell, that cell updates the settlement’s map memory immediately

Reason:
- much simpler to implement
- better for player readability
- avoids annoying “I saw it but the UI refuses to remember it” problems

Later, the game can add delayed reporting, miscommunication, or per-NPC map knowledge if desired.

## 9.3 What observation reveals

When an NPC explores, reveal should occur in layers.

### A. Immediate terrain reveal
Reveal:
- local terrain surface
- broad vegetation cover
- obvious water edge
- obvious cliff/steep edge
- obvious passability

### B. Feature reveal
Reveal if close enough or visible enough:
- berry patch
- spring access point
- stone outcrop
- clay exposure
- dense brush corridor
- path-like animal route

### C. Trust / reliability does not become perfect instantly
A newly seen feature does **not** automatically become fully trusted.

Examples:
- stream seen once in wet weather is not yet a trusted dry-season water source
- ground that looked dry once may still prove flood-prone later
- a berry patch seen once may not be a reliable staple source

## 9.4 Recommended reveal model

Use a practical, simulation-friendly visibility model.

For MVP:
- each NPC has an observation radius
- observation budget is modified by daylight, weather, slope, vegetation density, and current task state
- reveal uses a grid-based flood or line-budget approach, not expensive per-pixel ray casting
- steep terrain, dense canopy, brush, darkness, and storms raise visibility cost

This is good enough for the early game.

## 9.5 What unexplored land should look like

Recommended default:
- **major unknown** areas are dimmed and detail-hidden
- optionally allow very faint macro relief or contour context so the map is still beautiful and readable
- no exact resources, pathing confidence, or feature labels in unknown space

This creates a good compromise between:
- pure black-box mystery
- and unrealistic total map omniscience

## 9.6 What explored-but-not-currently-visible land should show

Show in explored memory:
- remembered terrain colors/forms
- remembered contour/hillshade
- remembered water line if discovered
- remembered major static features

Hide or stale-mark:
- animal presence
- temporary dropped items unless the player last saw them there
- precise hazard severity if not recently checked
- current passability after weather events if unverified

## 9.7 Frontier logic

The system should always be able to identify a **frontier band**:
- known cells adjacent to unseen cells

This frontier is useful for:
- exploration orders
- automatic scouting suggestions
- AI “expand knowledge” task generation later

## 9.8 Exploration orders

The player should be able to order:
- scout area
- investigate suspected water
- verify route
- map safe camp sites
- search for stone/clay/fiber/food patches

These should generate bounded tasks, not omniscient revelation.

## 9.9 Knowledge aging

A cell or feature can remain explored but become outdated.

Examples:
- storm changed a route into mud
- seasonal weeds/brush thickened
- spring weakened in late dry period
- mosquito burden rose
- flood left silt/wet ground

For MVP this can be light.
A simple `last_verified_tick` plus stale presentation is enough.

---

# 10. World generation pipeline

## 10.1 Generation order

Use this order.

### Step 1 — choose regional profile
Pick one canonical early profile.

### Step 2 — generate elevation / relief skeleton
Create:
- ridges
- benches
- slopes
- valley corridors
- wet hollows
- rocky rises

### Step 3 — derive slope and landform
From the elevation field, assign:
- slope class
- landform type
- exposure tendencies

### Step 4 — generate hydrology
Hydrology must follow relief.
Generate:
- stream channels
- spring or seep opportunities
- wet low cells
- flood-prone margins
- seasonal standing-water opportunities where appropriate

Do **not** randomly sprinkle water as unrelated nodes.

### Step 5 — derive soil and drainage
From relief + hydrology + regional profile, derive:
- drainage class
- moisture tendency
- soil texture tendency
- mud tendency
- cultivation potential

### Step 6 — generate vegetation communities
Assign vegetation communities using:
- moisture
- slope
- drainage
- exposure
- canopy tendency
- water proximity

Examples:
- mixed woodland
- brush edge
- riparian strip
- meadow/open ground
- wet-margin reeds/sedges
- rocky sparse cover

### Step 7 — derive resources and hazards
Resources and hazards must emerge from the above.

Examples:
- deadwood and poles from woodland structure
- reeds/fibers from wet margins
- clay opportunity from certain wet soils and exposed banks
- berries and small game edges from ecotones
- mosquito/tick burden from habitat, not pure randomness

### Step 8 — score site candidates
Evaluate candidate camp zones using:
- water burden
- dryness
- shelter suitability
- sanitation separation
- resource access
- future expansion space
- route burden
- hazard burden

### Step 9 — validate starter conditions
The map must contain:
- at least one viable route to day-one water
- at least one campable dry area
- enough early material access to survive

### Step 10 — seed world state
Seed:
- current season phase
- current weather phase
- water level state
- current edible patch availability
- current vector strength
- current fallen deadwood condition

### Step 11 — seed visibility and suspected hints
Start with:
- a small visible area around the spawn point
- possibly one or two coarse suspected hints such as “likely water downhill” if the profile strongly suggests it

---

# 11. Starter-site logic

## 11.1 The world should contain multiple understandable site options

A good map should produce:
- one or more fairly strong sites
- one or more tempting-bad sites
- some obviously poor sites

The point is to make site choice meaningful.

## 11.2 What a strong early site usually looks like

Usually:
- dry enough to sleep
- close enough to water to haul manually
- not inside the flood path
- enough nearby wood/material access
- enough separation room for waste and water handling
- enough nearby open ground to expand into a primitive camp

## 11.3 What a tempting-bad site often looks like

Examples:
- very near water but damp and mosquito-heavy
- scenic ridge with dryness but too much hauling burden
- rich brush edge with game/berries but terrible sanitation layout
- very sheltered hollow that becomes a smoke or puddling trap

## 11.4 Generator obligation

The generator should intentionally produce trade-offs, not merely random “goodness.”

---

# 12. Map rendering style

## 12.1 Visual target

The target map style is:
- restrained top-down
- aerial-photo-inspired
- topographic-capable
- legible with tiny entities
- realistic in land patterns rather than in literal photographic detail

## 12.2 Default view modes

Recommended modes:
- `aerial`
- `topographic`
- `hybrid`
- `water_sanitation`
- `buildability`
- `hazard`
- `logistics`
- `scouting`
- `debug`

Recommended default:
- `hybrid`

## 12.3 Aerial mode

Shows:
- land cover colors/textures
- canopy masses
- wet margins
- rocks/clearings
- paths/structures
- minimal contour emphasis

This should be the most immersive mode.

## 12.4 Topographic mode

Shows:
- contour lines
- stronger hillshade
- stronger landform reading
- simplified land-cover palette
- clearer watercourse emphasis

This should be the most analytical terrain mode.

## 12.5 Hybrid mode

Shows:
- aerial-like terrain base
- restrained hillshade
- faint contour lines
- readable watercourses
- structure/path visibility

This should be the best everyday play mode.

---

# 13. Rendering stack

The render stack should be layered explicitly.

## 13.1 Recommended base stack order

From bottom to top:

1. **base ground layer**  
2. **surface variation layer**  
3. **hydrology / wetness layer**  
4. **land-cover / canopy impression layer**  
5. **object/feature layer**  
6. **structure/path layer**  
7. **hillshade layer**  
8. **contour/topographic overlay**  
9. **gameplay overlay layer**  
10. **fog-of-war / memory mask**  
11. **selection / route / pulse overlays**

Not every mode has to show every layer at full strength.

## 13.2 Base ground layer

Represents broad surface identity:
- meadow/open ground
- compact soil
- disturbed ground
- stony ground
- wet margin
- marshy pocket if present

This is not where every resource is shown.

## 13.3 Surface variation layer

Used to avoid flat-looking terrain.

Can include:
- low-frequency tonal breakup
- dryness variation
- faint stains or worn patches
- subtle field-like texture where the terrain is open

This layer should stay restrained.

## 13.4 Hydrology / wetness layer

Shows:
- stream channels
- spring/seep indications
- darkened wet edges
- pooled damp spots
- shoreline transitions

Water must remain readable at every zoom band.

## 13.5 Land-cover / canopy impression layer

This layer gives the aerial-photo feeling.

Use it to express:
- forest canopy masses
- brush corridors
- meadow/open mosaics
- riparian vegetation belts
- sparse rocky growth

Important rule:
- at far zoom, forests should read as canopy masses, not individual tree icons
- at close zoom, major trees/objects can resolve more clearly

## 13.6 Hillshade layer

Derived from elevation.

Purpose:
- give landform readability without using 3D terrain
- support topo mode and hybrid mode
- help the player read benches, hollows, ridges, and channels

Recommended strength:
- moderate in hybrid mode
- stronger in topographic mode
- weaker in pure aerial mode

## 13.7 Contour layer

Contours should be generated from the elevation field.

They do not need cartographic perfection in the MVP.
They only need to reliably express:
- slope steepness
- ridges/benches/hollows
- water-following low paths

## 13.8 Gameplay overlays

These remain separate from the aesthetic map layers.

Core overlays should include:
- water / sanitation
- buildability / shelter suitability
- hazard burden
- logistics / haul burden
- scouting / visibility
- route verification

---

# 14. Fog-of-war rendering rules

## 14.1 Fog should be a render layer, not a terrain rewrite

Do not mutate the underlying terrain to “become known.”
Instead, keep the world authoritative and let the fog/memory layer control what the player can see.

## 14.2 Recommended visual treatment

### `unseen`
- heavily darkened or desaturated
- hide local resources and fine terrain detail
- hide route confidence and labels
- optionally allow faint macro topography in hybrid/topographic mode

### `explored`
- show remembered terrain
- dim dynamic overlays
- show stale or uncertain markers where appropriate

### `visible`
- full terrain detail allowed for current zoom band
- live object states visible
- full overlay participation

## 14.3 What fog should hide

Hide in unseen or stale contexts where appropriate:
- small resource patches not yet observed
- dynamic animal presence
- exact item positions
- current path wear after events
- current hazard spikes not recently checked

## 14.4 What fog should not hide completely after discovery

Once discovered, remembered terrain can remain visible in memory form:
- landform
- major stream line
- major static clearings
- known structures
- previously discovered major stone/clay/water sites

The uncertainty should move from **existence** to **trust / current state**.

---

# 15. Camera and zoom behavior

## 15.1 The camera is a core map-reading tool

The map is the main play surface.
A zoomable camera is not optional.

## 15.2 Required zoom bands

At minimum, support three practical zoom bands.

### Far zoom
Use for:
- landform reading
- route planning
- camp versus resource distance reading
- overlay interpretation

At this zoom, prefer:
- canopy masses
- bold water/readability
- generalized structures
- hidden tiny labels

### Mid zoom
Use for:
- worksite planning
- camp layout decisions
- route tracing
- broad selection

At this zoom, reveal:
- route lines
- structure footprints
- clearer object clusters
- selected labels

### Close zoom
Use for:
- NPC activity observation
- item/structure interaction
- precise placement
- local terrain assessment

At this zoom, reveal:
- compact labels
- state glyphs
- local details
- small feature distinctions

## 15.3 Zoom readability rules

- never let far zoom become meaningless texture soup
- never require close zoom for basic terrain understanding
- never cover the map with giant panels by default
- selection and overlay legibility must scale with zoom

---

# 16. Godot implementation architecture

## 16.1 Node strategy

Use a layered 2D map scene rather than one monolithic map object.

Recommended high-level scene structure:

- `WorldRoot`
  - `Camera2D`
  - `MapView`
    - `TileMapLayer_Ground`
    - `TileMapLayer_SurfaceVariation`
    - `TileMapLayer_Water`
    - `TileMapLayer_Paths`
    - `Node2D_Features`
    - `Node2D_Structures`
    - `Sprite2D_Hillshade`
    - `Sprite2D_Contours` or `TileMapLayer_Contours`
    - `Node2D_GameplayOverlays`
    - `Sprite2D_FogOfWar`
    - `Node2D_SelectionAndRoutes`

The exact node names may vary, but the separation of responsibilities should remain.

## 16.2 Terrain representation

Recommended approach:
- authoritative world data in custom data structures / resources
- static or mostly static terrain rendered through layered tilemaps and generated textures
- discrete objects rendered as scene instances or lightweight map objects

## 16.3 Hillshade and contour generation

Recommended approach:
- derive hillshade from the elevation grid
- derive contours from elevation bands or marching-like contour extraction
- cache the result by chunk or by map section
- regenerate only when needed

In the early game, terrain itself rarely changes massively, so these layers should be mostly static.

## 16.4 Fog-of-war implementation

Recommended MVP approach:
- keep a visibility grid matching the simulation grid
- maintain a fog texture or chunked mask derived from visibility states
- update only around moving observers and newly revealed cells
- render the fog as a separate blended layer above terrain and most world objects

## 16.5 Pathfinding and movement

The same underlying grid should feed:
- movement cost
- route planning
- haul burden estimates
- exploration reach
- visibility-cost logic

Do not create one fake pretty map and one unrelated gameplay grid.

## 16.6 Chunking

Recommended early performance rule:
- divide the local map into fixed logical chunks
- keep chunk render caches for terrain/hillshade/fog if needed
- mark chunks dirty only when their visible or structural state changes

This will matter more once vegetation is depleted, paths emerge, and camp footprint spreads.

---

# 17. Rendering detail strategy by zoom

## 17.1 Far zoom strategy

Show:
- macro land cover
- canopy masses
- bold water channels
- broad hillshade
- contour readability
- camp and structure clusters

Hide or aggregate:
- tiny items
- detailed labels
- minor object clutter

## 17.2 Mid zoom strategy

Show:
- route lines
- selected entities
- feature clusters
- structure footprints
- local overlay signals

Aggregate where needed:
- item piles
- dense vegetation clutter

## 17.3 Close zoom strategy

Show:
- local object identity
- NPC state glyphs
- terrain detail cues
- work area boundaries
- exact placement feedback

The map should still look like the same world, just with more resolved detail.

---

# 18. Human footprint and world change

## 18.1 The map should visibly change under occupation

Even in early game, the world should not remain pristine and static.

Track at least:
- path wear
- trampled camp core ground
- wood depletion near camp
- cleared brush around camp
- waste accumulation zones
- burned/scorched spots if fire incidents occur
- garden/disturbed soil areas

## 18.2 Why this matters

This supports realism and gameplay because the player can read:
- overused routes
- expanding haul burden
- sanitation mistakes
- fuelwood depletion near camp
- emerging camp structure

This is also a big part of making the aerial-style view feel alive.

---

# 19. MVP scope versus deferred scope

## 19.1 Required in MVP

Must exist in the first implementation-capable version:
- one canonical regional profile
- local playable map generator contract
- discrete elevation step model
- derived slope/drainage/landform logic
- hydrology derived from relief
- resource placement derived from terrain/ecology
- site-candidate scoring
- zoomable top-down map
- aerial / topographic / hybrid map modes
- fog of war with NPC-based reveal
- explored-memory state
- water / hazard / logistics / scouting overlays
- visible human footprint changes at least in simple form

## 19.2 Simplified in MVP

May remain simplified at first:
- exact line-of-sight realism
- detailed seasonal vegetation transitions
- complex wildlife movement
- fine-grained erosion or sediment transport
- many biome families
- advanced cartographic symbols
- per-NPC private map memory
- delayed reports before map memory updates

## 19.3 Deferred

Intentionally defer:
- continent-scale generation
- many regional profiles
- full geology/mineral layers
- late-game road/rail geography
- advanced weathered river-basin simulation
- photoreal terrain synthesis
- sophisticated satellite-style shadow systems

Deferred does **not** mean excluded forever.
It only means not required before the survival-to-hamlet loop works.

---

# 20. Proposed implementation phases

## Phase 0 — Data contract

Define:
- cell fields
- feature fields
- site-candidate fields
- visibility fields
- map modes
- layer stack

## Phase 1 — Hand-authored test maps

Create:
- balanced benchmark map
- wet problem map
- dry/rocky problem map
- optional harsh edge map

## Phase 2 — Renderer MVP

Implement:
- map camera
- base terrain rendering
- hillshade
- contour overlay
- fog-of-war layer
- map mode switching

## Phase 3 — Simulation hookup

Hook up:
- pathfinding costs
- hauling burden
- exploration reveal
- site overlays
- water access routes
- hazard overlays

## Phase 4 — Procedural starter-area generator

Implement the first procedural generator using the same contract already proven by the authored maps.

## Phase 5 — Visual hardening

Improve:
- canopy variation
- surface breakup
- water edge quality
- remembered-terrain presentation
- world footprint change readability

---

# 21. Acceptance criteria for this spec

This spec is being implemented correctly when all of the following are true:

## 21.1 World logic
- water consistently appears in terrain-logical places
- dry benches and wet hollows behave differently in play
- resource opportunities feel derived, not sprinkled
- bad camp sites are bad for understandable reasons

## 21.2 Map rendering
- the map reads like a believable place at a glance
- hybrid mode is playable without constant overlay flipping
- topographic mode makes relief easier to understand
- zooming remains readable at far, mid, and close levels

## 21.3 Fog of war
- unexplored land feels unknown
- explored land remains useful in memory form
- NPC movement visibly reveals nearby terrain
- discovered features can still remain uncertain or untrusted

## 21.4 Gameplay value
- site selection changes outcomes
- hauling burden can be read from the map
- sanitation planning is spatially meaningful
- exploration is useful labor, not empty busywork

---

# 22. Final implementation recommendation

For this project, the correct approach is:

- define the world model now
- implement the map renderer and fog system early
- use authored maps before full procedural generation
- then add the MVP starter-area generator

The map should be treated as a **living survival surface**:
- not decorative scenery
- not pure abstraction
- not fake satellite art pasted over game logic

It should look convincing because its layers are consequences of real terrain, water, vegetation, use, and discovery.

That is the right foundation for a realism-first survival-to-hamlet game.

