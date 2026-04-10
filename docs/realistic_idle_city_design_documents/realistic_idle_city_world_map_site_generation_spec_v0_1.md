# Realistic Idle City — World / Map / Site Generation Spec v0.1

## Purpose

This document defines the **world substrate** for the project’s early playable slice:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It explains how the map should be generated, what terrain and ecology data each location should carry, how viable camp sites are identified, and how the map should create **realistic survival pressure** rather than decorative scenery.

This is not a full geology simulator or a late-game regional transport spec.
It is the **early-world foundation** that the existing design stack needs so that:
- site choice matters
- hauling distance matters
- bad drainage matters
- water access matters
- sanitation placement matters
- hazard exposure matters
- future expansion matters

The map must behave like a real place that can support or punish human settlement.

---

# 1. Relationship to the current design stack

This spec sits on top of and must remain consistent with the current documents:

- the original design premise that the starter NPC should scout for fresh water, deadwood, stone, wind protection, drainage above flood line, future camp expansion space, and distance from predator or disease-prone zones
- the early-game bible’s emphasis on site selection, water burden, dampness, sanitation, and seasonal pressure
- the environmental hazard spec’s treatment of flood, cold/wet stress, smoke, vectors, and fire
- the building/structure bible’s doctrine that site matters as much as materials
- the settlement progression spec’s rule that permanence depends on water, storage, sanitation, and seasonal readiness
- the logistics spec’s rule that distance is a survival variable, not a cosmetic one
- the canonical early content pack’s temperate-biome assumptions

This document therefore treats the map as:
1. a **resource field**
2. a **hazard field**
3. a **movement field**
4. a **settlement opportunity field**

---

# 2. Core design stance

## 2.1 The world is not a backdrop

The map is not just where objects are placed.
It is the underlying reason why tasks are easy, hard, safe, dangerous, efficient, wasteful, viable, or doomed.

A camp beside clean water on a dry bench above a stream should feel fundamentally different from a camp in a damp hollow or on an exposed ridge.

## 2.2 Site quality must matter immediately

The first day already depends on:
- how far the water source is
- whether the ground stays dry
- whether there is enough nearby fuelwood
- whether the NPC can find stone
- whether night shelter can be placed out of runoff and wind
- whether the camp can later grow without forcing every worksite into long walking loops

## 2.3 The map should generate trade-offs, not puzzle-box perfection

A good early map should not hand the player:
- perfect water
- perfect soil
- perfect shelter
- perfect low hazard
- perfect material access
- perfect animal access
all on one tile cluster.

Instead it should offer **good enough** options with meaningful trade-offs:
- safer high ground but farther from water
- rich riparian resources but more flood/vector pressure
- dense wood nearby but more tick/fire burden
- open meadow for farming but more wind exposure
- rocky ground with stone access but poorer cultivation

## 2.4 The world must stay readable with minimal graphics

Because the project uses tiny top-down abstract visuals, the world model must be:
- simple enough to visualize in a few pixels
- deep enough to support realistic outcomes
- layerable through overlays and inspection

This means the internal map data can be rich while the rendered representation stays minimal.

## 2.5 The map should support regression, not only progression

A settlement can become worse because of:
- flooding
- overharvesting nearby wood
- smoke accumulation
- stagnant water
- contamination near camp
- rodent attraction
- repeated trampling and mud
- burned shelter zone
- poor expansion into risky ground

The world must remember the consequences of habitation.

---

# 3. Research-backed real-world anchors that should shape world generation

## 3.1 Floodplains are not “free flat land”

USGS describes floodplains as landscape features adjacent to rivers that are periodically inundated.
Design implication:
- floodplains can be fertile and convenient
- but they must carry recurring flood risk
- camps on low floodplain ground should be considered short-term, risky, or desperate choices rather than ideal early permanent sites

## 3.2 Springs and seeps are distinct water opportunities

USGS describes a spring as groundwater reaching the surface when the land intersects the water table.
Design implication:
- springs can be especially valuable local water features
- seeps can be intermittent and less reliable
- a spring line on a slope can create excellent early camp opportunities if it is not too muddy or unstable

## 3.3 Soil drainage is a real settlement variable

NRCS material emphasizes that soil interpretation for land use includes drainage class, depth, permeability, slope, erosion potential, and wetness.
Design implication:
- map cells need drainage and soil-wetness information
- good camp ground and good crop ground are not always identical
- buildability and farmability should be related but not the same field

## 3.4 Land suitability depends on use, not only on beauty

FAO’s land-suitability framework treats suitability as the match between land qualities and a defined use.
Design implication:
- a location may be suitable for shelter but poor for gardens
- good grazing ground may be poor for dry storage
- wetland edge may be useful for reeds but poor for permanent housing

## 3.5 Mosquitoes and ticks are habitat-linked, not random debuffs

CDC notes that mosquitoes rely on water for breeding and that different species are associated with standing or slow water; ticks are strongly associated with brushy, grassy, wooded, and leaf-litter habitats.
Design implication:
- vector burden should derive from habitat and season
- camps near stagnant water, marsh, brush edge, or dense leaf litter should feel biologically different from sunny open ground

## 3.6 Lightning and wildfire safety are site-dependent

NOAA and CDC guidance emphasize avoiding exposed high points, isolated trees, and water during lightning; wildfire guidance emphasizes defensible space and vegetation management around structures.
Design implication:
- exposed ridges, lone tall trees, and heavy fuel accumulation near structures should matter
- camps need not be wildfire simulators in v0.1, but vegetation density and defensible clearing should be represented

## 3.7 Sanitation location is part of site design

WHO and NPS sanitation guidance emphasizes keeping fecal disposal away from water points and watercourses, with practical minimum separation distances.
Design implication:
- a “good camp site” must include **space to separate functions**
- a cramped location beside water may feel convenient but become unsanitary quickly

---

# 4. Scope of this document

## 4.1 Included

This version focuses on:
- local playable map generation
- early temperate biome assumptions
- terrain and hydrology for the first camp-to-hamlet stages
- buildability
- resource distribution
- ecology/habitat distribution
- early hazard overlays
- camp-site evaluation
- world-state changes caused by occupation

## 4.2 Not deeply covered yet

Not yet deeply specified:
- region-to-region trade geography
- procedural continents
- formal roads beyond footpaths and proto-tracks
- large rivers suitable for late transport systems
- multi-settlement geopolitics
- advanced geology/mining distributions
- modern urban zoning
- climate-change or historical world simulation

---

# 5. Canonical biome and starting-world assumptions

## 5.1 Default early-playable biome

Unless later scenarios say otherwise, the canonical early biome remains:

- temperate climate
- four seasons
- mixed woodland / meadow mosaic
- some brush and riparian growth
- one or more freshwater sources within reachable distance
- wild plant foods and small game
- stone suitable for primitive tools
- clay or clay-rich patches somewhere in the local map or near-map radius
- weather severe enough that exposure, wetness, and fuel matter
- enough open ground to eventually form a camp core and small garden area

## 5.2 What the map must guarantee

The map generator should guarantee at least one **viable** early survival route, not necessarily an easy one.
That means the generated map should include within reasonable reach of the starting exploration radius:

- at least one accessible freshwater source
- at least one dry-enough sleeping/building zone
- some woody biomass or deadwood
- some stone or fractured rock source
- some edible or trappable ecology
- enough separation space for camp, waste, and water-use areas
- at least one path toward longer-term storage/garden/camp expansion

## 5.3 What the map does not need to guarantee

It does **not** need to guarantee:
- ideal farmland immediately
- clay immediately next to the starter shelter
- perfect safety from vectors
- perfect fuel density
- perfect fish access
- a flat open “base platform”
- all resource categories within the same micro-area

---

# 6. Map scales and spatial hierarchy

A single flat tile type is not enough.
The world should be defined in layers.

## 6.1 Regional profile layer

This layer determines the general identity of the map:
- upland stream valley
- low rolling woodland with wet depressions
- open meadow cut by stream and brush
- wooded terrace above a river corridor
- rocky foothill edge with springs and gullies

For the early game, the regional profile mostly sets:
- elevation pattern
- water pattern
- vegetation mix
- likely hazards
- likely early resource clusters

## 6.2 Local playable map layer

This is the main playable area for the early slice.
It should contain:
- landforms
- water bodies/courses
- vegetation zones
- resource patches
- animal habitat zones
- current camp footprint
- player-designated zones
- travel routes
- contamination and disturbance traces

## 6.3 Cell / microcell layer

Every playable location should carry a compact but useful data record.
A cell does not need photorealistic detail.
It needs the data that drives believable outcomes.

Recommended cell size:
- small enough that camp layout and hauling distance matter
- large enough that a structure footprint can cover multiple cells without requiring thousands of tiny interactions

The exact numeric size can stay implementation-defined for now.

---

# 7. Canonical world-cell record

Each world cell should have at least the following fields.

## 7.1 Identity and geometry
- cell id
- x/y position
- elevation
- relative relief category
- local slope class
- aspect / exposure direction where relevant
- roughness / obstacle density

## 7.2 Landform identity
Recommended landform tags:
- ridge / crest
- upper slope
- midslope
- lower slope / footslope
- bench / terrace
- floodplain
- stream bank
- ravine / gully edge
- spring line
- wet depression
- pond margin
- meadow flat
- woodland floor
- rocky outcrop
- clay hollow

A single cell can carry one primary tag and optional secondary qualifiers.

## 7.3 Hydrology
- water presence type: none / damp / seep / spring / stream / pool / marsh edge / standing water
- water permanence: perennial / seasonal / episodic
- runoff tendency
- flood tendency
- saturation tendency
- distance-to-clean-water score
- contamination vulnerability

## 7.4 Soil and ground
- surface texture class
- depth class
- drainage class
- compaction / firmness
- erosion susceptibility
- mud tendency
- root density
- stone content
- clay potential
- cultivation difficulty
- foundation quality
- burial / digging ease

## 7.5 Vegetation
- vegetation formation
- canopy density
- understory density
- grass/reed cover
- leaf litter amount
- deadwood amount
- live wood amount
- fiber plant presence
- edible plant potential by season
- concealment / line-of-sight impact

## 7.6 Ecology / fauna
- small game likelihood
- bird nesting likelihood
- fish/amphibian likelihood if water-linked
- predator transit likelihood
- tick habitat level
- mosquito habitat level
- scavenger attraction level

## 7.7 Human-use suitability
- shelter suitability
- hearth suitability
- storage suitability
- sanitation suitability
- garden suitability
- path suitability
- worksite suitability
- expansion suitability
- visibility/security suitability

## 7.8 Current state
- cleared / uncleared
- trampled level
- ash / burn level
- contamination level
- smoke accumulation tendency
- loose resources present
- structure occupancy
- zone flags
- path traffic score

---

# 8. Topography and landform generation

## 8.1 Core principle

The local map should feel like a real watershed fragment, not a checkerboard of unrelated biome stamps.

Topography should drive:
- where water concentrates
- where soils stay wet
- where erosion is worse
- where wood grows thickly
- where dry camp benches appear
- where floodplain flatness is tempting but risky

## 8.2 Early-playable landform set

A strong early set is:

### A. Ridge / crest
Traits:
- drier
- wind-exposed
- often poorer water access
- lower mosquito burden
- weak for immediate camp unless water is nearby
Use:
- lookout
- emergency avoidance of flooding
- wind exposure risk

### B. Upper / midslope woodland
Traits:
- wood access
- moderate drainage
- variable stone
- can be good for temporary shelter
Use:
- early deadwood gathering
- brush clearing
- moderate tick burden

### C. Bench / terrace above stream
Traits:
- one of the best early camp candidates
- near water but above common flooding
- moderate access to wood and open ground
Use:
- primitive or permanent camp core

### D. Floodplain flat
Traits:
- easy walking
- fertile later
- resource-rich riparian access
- periodic inundation risk
- mosquito burden
Use:
- short-term collection area, later fields in some cases, but poor default permanent housing zone

### E. Wet depression / marsh edge
Traits:
- reeds/fibers
- standing water risk
- mosquito burden
- poor sleeping/building ground
Use:
- specialized gathering zone, not camp core

### F. Rocky outcrop / scree-like patch
Traits:
- stone access
- poor cultivation
- awkward movement
- sometimes excellent drainage
Use:
- toolstone access, windbreak edges, lookout

### G. Spring line / seep band
Traits:
- reliable local water opportunity
- often muddy
- may support lush vegetation
Use:
- high-value water collection zone if stabilized and kept clean

### H. Meadow / open grass patch
Traits:
- sunlight
- easier movement
- lower canopy
- more wind exposure
- later garden potential
Use:
- future cultivation, drying yards, visibility, camp expansion if close enough to resources

## 8.3 Topographic truths the generator should enforce

- water flows downhill
- low areas stay wetter longer
- benches are often better camp ground than valley bottoms
- steeper slopes raise travel and erosion burden
- gullies and channels should not be attractive sleeping zones
- floodplain adjacency should be a temptation with consequences

---

# 9. Hydrology generation

## 9.1 Water features needed in the early slice

The early world can stay simple but must be meaningful.
Recommended water feature families:

- perennial stream
- intermittent stream
- spring
- seep
- pond
- marsh / wetland patch
- seasonal puddling / standing-water depression

## 9.2 Water source hierarchy for early survival

Not all water opportunities are equal.

### A. Spring
Strengths:
- often excellent local access
- may be clearer or more stable than stagnant surface water
Weaknesses:
- can create mud zones
- can be contaminated by nearby human activity

### B. Flowing stream
Strengths:
- obvious collection point
- fish or riparian resources may appear
Weaknesses:
- flood risk nearby
- contamination from upstream or nearby camp use
- steep banks can slow access

### C. Pond / pooled water
Strengths:
- easy access
- can support wildlife
Weaknesses:
- higher stagnation/vector concern
- lower default trust

### D. Wet depression / marsh edge
Strengths:
- reeds, fibers, some food opportunities
Weaknesses:
- poor drinking default
- poor camp-site quality
- high vector burden

## 9.3 Hydrology rules for map generation

- perennial water should usually occupy lower routes or spring discharge locations
- seeps and spring lines should preferentially appear where slope meets groundwater opportunity
- poorly drained soils should cluster in depressions, marsh edges, and some floodplain pockets
- standing water should increase after heavy rain and decrease later
- contamination should move more easily toward low water-gather points than uphill

## 9.4 Water-use zoning implications

A realistic camp needs distinct water relationships:
- drinking / raw collection point
- washing point
- water-processing point
- waste kept away from all of the above

The map must support spatial separation for this.

---

# 10. Soil, ground, and drainage model

## 10.1 Why this matters

For the early slice, soil and drainage matter at least as much as ore or rich loot.
They determine:
- whether bedding stays dry
- whether storage pits fail
- whether paths become mud traps
- whether gardens can succeed
- whether latrines are sensible
- whether structures rot and sink

## 10.2 Recommended simplified drainage classes

The map does not need full pedology, but it does need meaningful drainage classes.

### Class 1 — Excessively drained
- dries quickly
- little surface wetness
- lower mud burden
- may be poor for some crops without water effort

### Class 2 — Well drained
- strong camp/building candidate
- good walking
- good storage conditions if slope is acceptable

### Class 3 — Moderately drained
- workable
- can become muddy in bad weather
- acceptable for many camp and garden functions

### Class 4 — Somewhat poorly drained
- frequent dampness
- uncomfortable sleeping/building
- higher spoilage and vector pressure

### Class 5 — Poorly drained
- standing water or near-standing dampness
- bad permanent camp ground
- useful for specific wetland resources

### Class 6 — Saturated / marshy
- not a real camp surface
- specialized ecological zone only

## 10.3 Additional ground properties that matter

### Slope class
Suggested simple classes:
- flat
- gentle
- moderate
- steep
- severe

### Surface texture
- sandy
- loamy
- silty
- clayey
- stony / rocky
- organic / peaty

### Diggability
Important for:
- root gathering
- garden prep
- storage pit digging
- latrine digging
- post setting

### Structural support
Important for:
- shelter posts
- hearth safety
- heavier later structures

## 10.4 Early gameplay implications

- best shelter sites favor gentle slope or stable bench + well or moderately drained soil
- best latrine sites need enough separation, diggability, and low flood vulnerability
- best drying/storage sites need airflow, dryness, and low contamination
- best gardens need sunlight, manageable soils, and reachable water
- best paths avoid marshy bottlenecks where possible

---

# 11. Vegetation model

## 11.1 Vegetation is a systems layer, not decoration

Vegetation should simultaneously affect:
- food
- fuel
- fiber
- shelter materials
- visibility
- fire behavior
- vector habitat
- shade/cooling
- pathing burden

## 11.2 Recommended early vegetation formations

### A. Open meadow
- high light
- lower wood immediately
- easier movement
- better later cultivation
- greater wind exposure

### B. Shrub / brush patch
- good for small cover and some browse materials
- harder movement
- stronger tick burden
- useful for traps, simple fencing, fuel

### C. Mixed woodland
- strong general early resource zone
- deadwood, branches, poles, leaf litter, shade
- moderate concealment
- moderate to high tick habitat depending understory

### D. Dense conifer-like stand
- strong poles and litter
- darker ground
- dense fuel
- lower understory in some cases
- can be colder/damper feeling depending local climate

### E. Riparian strip
- lush growth
- fibers, reeds, browse, animal traffic
- flood and wetness risk
- high mosquito pressure where flow slows

### F. Wet meadow / marsh fringe
- reeds, sedges, mud, standing water potential
- poor camp use
- specialized gathering

### G. Rocky sparse patch
- low vegetation
- easy visibility
- poor fuel density
- good stone access

## 11.3 Vegetation metrics per cell or patch

- canopy cover
- understory density
- deadfall amount
- branch/pole availability
- reed/fiber abundance
- edible greens likelihood
- berry/nut likelihood by season
- dry fuel availability
- shade quality
- fire spread tendency

## 11.4 Depletion and regrowth

The map should remember vegetation use:
- deadwood collection lowers nearby fuel stock
- brush clearing lowers tick burden and fire load locally
- overcutting near camp increases hauling time later
- repeated trampling can suppress local plant recovery
- some regrowth occurs seasonally, but not instantly

---

# 12. Resource patch generation

## 12.1 Resources should emerge from landform + ecology

The generator should not place resources as isolated “nodes.”
Instead, resources should come from the terrain/ecology logic.

Examples:
- stone cobbles near stream gravels, rocky patches, or erosion exposures
- clay in low-energy depositional areas, cutbanks, or certain hollows
- reeds and sedges in wet margins
- long straight poles in younger or denser growth zones
- deadwood in woodland and edge zones, affected by season and weather
- edible greens near meadow edge, open woodland, and riparian areas
- mushrooms or rot materials in damp shaded litter zones
- animal tracks where cover and water intersect

## 12.2 Core early resource families to support

### Lithic / mineral
- hammer stones
- flakeable stone
- coarse rock
- gravel/cobbles
- clay-rich soil

### Wood / plant structure
- tinder
- kindling twigs
- branches
- poles
- brush
- bark
- leaf litter
- thatch-capable grasses/reeds later

### Fiber
- bark strips
- long grasses
- reed fibers
- root fibers
- nettle/flax-like future path materials if present

### Food
- edible greens
- berries
- nuts
- roots/tubers
- mushrooms with risk
- eggs
- insects
- shellfish/fish where biome permits

### Water-linked
- clay
- reeds
- fish
- smooth stones
- cool-storage microclimates nearby

### Animal-linked
- small game paths
- nesting zones
- burrows
- watering routes
- scavenger-prone areas

## 12.3 Patch quality variables

A patch should have more than quantity.
Recommended variables:
- abundance
- accessibility
- renewability
- seasonality
- contamination risk
- extraction difficulty
- travel exposure
- competition with other uses

---

# 13. Fauna and habitat generation

## 13.1 Why fauna should be habitat-based

Animals should appear where the map makes sense, not as random periodic spawns.
This improves realism and lets the player learn the land.

## 13.2 Early fauna habitat zones

### A. Small game edge habitat
Generated where:
- meadow meets brush
- woodland edge meets open ground
- water is nearby but not too exposed

### B. Riparian wildlife corridor
Generated along:
- streams
- ponds
- spring-fed lush strips

### C. Dense cover refuge
Generated in:
- brush
- thickets
- dense woodland floor
Role:
- prey concealment
- tick burden
- harder hunting visibility

### D. Open-forage corridor
Generated in:
- meadow
- sparse woodland
- field edge later

## 13.3 Predator and scavenger logic for early slice

Predator logic can stay light in v0.1, but the map should still define:
- den likelihood
- transit likelihood
- attraction to carcass waste or careless storage
- reduced approach near fire, active camp cores, and clean defended layouts

## 13.4 Vector habitat logic

### Mosquito burden rises with:
- standing or slow water
- warm wet conditions
- unmanaged container water near camp later
- marsh edge or stagnant depressions

### Tick burden rises with:
- brush
- tall grass
- leaf litter
- woodland edge
- poor clearing around camp

This should create meaningful reasons to clear brush, choose sunny sites, and manage water.

---

# 14. Hazard overlays derived from world generation

## 14.1 Flood overlay
Generated from:
- watercourse proximity
- relative elevation
- floodplain identity
- local drainage
- storm events

## 14.2 Damp/cold overlay
Generated from:
- poor drainage
- shade
- valley-bottom pooling
- persistent wetness
- low winter sun exposure

## 14.3 Fire-risk overlay
Generated from:
- dry fuel accumulation
- brush density
- deadwood density
- wind exposure
- structure spacing and clearing around the camp

## 14.4 Lightning exposure overlay
Generated from:
- ridge/crest exposure
- isolated tall tree adjacency
- open high ground
- distance to safer lower shelter zones

## 14.5 Vector overlay
Generated from:
- standing water
- marsh presence
- brush/tall grass
- dense edge habitat
- unmanaged water storage at camp

## 14.6 Sanitation vulnerability overlay
Generated from:
- shallow or close water point geometry
- cramped buildable area
- flood-prone waste sites
- poor separation between camp, water, carcass handling, and latrine zones

## 14.7 Smoke retention overlay
Generated from:
- enclosed hollows
- low wind pockets
- dense shelter clustering
- repeated hearth use without ventilation logic

---

# 15. Camp-site evaluation model

## 15.1 Why site scoring should exist

The game does not need to show the raw formula to the player, but the world generator should internally evaluate candidate camp sites so that:
- starts are viable
- bad sites are bad for understandable reasons
- the map contains both good and tempting-bad locations

## 15.2 Core site-score dimensions

### A. Water access score
Factors:
- distance to source
- climb/descent burden
- source reliability
- source cleanliness confidence
- ability to separate drinking, washing, and waste

### B. Dryness / drainage score
Factors:
- drainage class
- flood risk
- saturation tendency
- runoff crossing risk
- mud persistence

### C. Shelter support score
Factors:
- wind protection
- nearby poles/brush/debris
- stable ground
- shade/sun balance
- ability to place hearth nearby safely

### D. Materials access score
Factors:
- nearby deadwood
- poles/brush
- stone access
- clay potential within later reach
- fiber plants within later reach

### E. Sanitation separation score
Factors:
- whether a latrine area can be placed away from water and sleeping zone
- whether refuse and carcass work can be separated
- whether the camp is too cramped to stay clean

### F. Expansion score
Factors:
- nearby dry buildable cells
- later garden potential
- path network potential
- storage/work-yard placement potential

### G. Hazard burden score
Factors:
- flood exposure
- vector pressure
- wildfire fuel concentration
- lightning exposure
- predator transit
- smoke-trap tendency

### H. Travel centrality score
Factors:
- route burden to major resource patches
- route burden to water
- route burden to future gardens and work zones
- path viability in wet weather

## 15.3 Recommended site classes

- **Excellent**: uncommon; supports strong early growth
- **Good**: strong practical site with manageable weaknesses
- **Viable**: survival-capable, but clear burdens exist
- **Hard**: only for players who accept real pressure
- **Trap**: should exist in the world but should usually not be the forced start
- **Uninhabitable for early camp**: flood channel, marsh core, severe slope, etc.

## 15.4 What a strong starter site usually looks like

A strong but not overpowered early starter site is often:
- on a bench or terrace above a stream
- close enough to water to haul it manually
- not on the floodplain itself
- near mixed woodland edge
- with some open patch for light, drying, and later gardens
- with at least one nearby stone source
- with room to keep waste away from water and sleeping areas

---

# 16. Starting-site generation rules

## 16.1 Do not random-spawn the starter NPC blindly

The game should not drop the starter NPC into any random cell.
The system should choose a start area that is:
- viable
- readable
- capable of teaching the early systems
- still imperfect enough that site choice and relocation remain meaningful

## 16.2 Starter-area rules

The starting exploration zone should include:
- one immediately usable temporary shelter zone
- one trusted-enough water route discoverable quickly
- one or more nearby deadwood areas
- at least one lithic source
- some food potential within day-one/day-two reach
- at least one location that looks convenient but is strategically worse
- some uncertainty that requires observation

## 16.3 Optional start presets

### Balanced start
A good bench near stream with mixed woods and meadow access.

### Wetland-edge start
Abundant water and fibers, but heavy damp/vector/sanitation burden.

### Rocky spring start
Reliable water and stone, but less easy cultivation and less dense fuel.

### Open meadow fringe start
Better light and future gardens, but farther timber and more wind exposure.

### Harsh ridge-side start
Safer from flood, but more hauling and exposure; optional challenge mode.

---

# 17. Human footprint and map change over time

## 17.1 Camps alter the land

The world should not remain pristine after occupation.
A camp should gradually produce:

- trampled paths
- worn sleeping ground
- brush clearing
- wood depletion near the core
- ash deposition near hearths
- refuse accumulation if unmanaged
- odor/scavenger attraction near dirty carcass or waste areas
- compacted/muddy traffic corridors
- safer cleared perimeters if managed well

## 17.2 Ground wear model

Cells should carry a traffic history:
- low
- moderate
- heavy
- chronic

Effects may include:
- easier walking on dry established paths
- muddier, more compacted ground in poor-drainage cells
- reduced vegetation cover
- increased runoff in badly worn paths
- greater readability of routes for the player

## 17.3 Wood depletion halo

Repeated collection near camp should reduce:
- easy deadwood availability
- brush abundance
- local fuel convenience

This forces the map to create a growing outward haul burden over time.

## 17.4 Sanitation footprint

Poor camp management should create local penalties:
- contaminated wash zones
- smell/scavenger burden
- fly burden
- morale penalties
- sickness exposure
- social complaints later

## 17.5 Garden / cultivation footprint

Once the camp approaches hamlet stage:
- vegetation is cleared
- soil is turned
- fertility and moisture interact with cultivation effort
- paths form between camp core and food plots
- fencing or protection may alter movement and habitat

---

# 18. Visibility, discovery, and map knowledge

## 18.1 The player should not know the whole land perfectly on day one

The world exists before the player understands it.
Map knowledge should grow through:
- direct observation
- repeated route use
- task outcomes
- seasonal changes
- NPC reports
- hazard incidents

## 18.2 Recommended knowledge states for map features

Every important world feature can have a knowledge state:
- unknown
- suspected
- seen once
- familiar
- trusted / measured

Examples:
- “There is water downhill somewhere” -> suspected
- “This stream bend is reliable in dry weather” -> trusted
- “That hollow floods in heavy rain” -> learned truth
- “Ticks are bad in that brush corridor” -> familiar hazard knowledge

## 18.3 Hidden but inferable truths

The map should contain hidden variables that can still be inferred:
- seasonal puddling in a low area
- better spring reliability than surface pond reliability
- one bench being slightly better drained than another
- one path turning into a mud trap after storms
- one thicket being a reliable small-game edge

This supports discovery without fantasy mystery systems.

---

# 19. Overlays and player-facing map information

## 19.1 Core overlays recommended for the UI

The UI spec should be able to show the map in multiple information modes.

### A. Terrain / buildability
Shows:
- slope
- roughness
- buildable cells
- unstable / poor-ground cells

### B. Water / wetness
Shows:
- water bodies
- springs/seeps
- flood-prone cells
- wet ground
- water hauling burden

### C. Resource field
Shows:
- deadwood
- poles
- stone
- clay potential
- fiber/reed zones
- food gather zones

### D. Hazard field
Shows:
- vector hotspots
- smoke-trap zones
- fire-risk vegetation
- flood risk
- exposure/ridge risk

### E. Sanitation planning
Shows:
- water source protection zones
- current waste zones
- unsuitable latrine placements
- contamination danger routes

### F. Travel burden
Shows:
- path cost
- likely traffic routes
- haul distance to stockpoints or camp core

### G. Visibility / scouting
Shows:
- known
- uncertain
- not recently checked
- newly changed

## 19.2 Minimal-graphics expression

With minimal visuals, cells can be shown through:
- tiny color/value shifts
- sparse overlays
- edge lines for water or elevation bands
- icon tags only when selected or zoomed
- inspection panels for exact values

The map should remain readable even when entities are only a few pixels large.

---

# 20. World generation pipeline

## 20.1 Recommended generation order

### Step 1 — Choose regional profile
Example:
- wooded stream bench
- rolling meadow-woodland valley
- rocky foothill spring corridor

### Step 2 — Generate relief skeleton
Create:
- ridges
- slopes
- valley lines
- benches
- floodplain candidates
- depressions

### Step 3 — Generate hydrology
Place:
- streams
- spring or seep opportunities
- wet low cells
- ponds or marsh edges where appropriate

### Step 4 — Derive soils and drainage
From:
- relief position
- hydrology
- substrate assumptions
assign:
- texture families
- drainage classes
- wetness persistence
- clay or stone tendencies

### Step 5 — Generate vegetation communities
Based on:
- moisture
- slope
- canopy logic
- riparian proximity
- exposure

### Step 6 — Place resource patches
Based on terrain/ecology rules:
- stone
- deadwood
- poles
- fibers
- food gather patches
- clay pockets
- reed zones

### Step 7 — Generate habitats and hazard overlays
Create:
- small game edges
- vector pressure
- flood risk
- fire load
- exposure zones

### Step 8 — Evaluate candidate camp sites
Score many candidate zones.
Ensure at least one viable start area exists.

### Step 9 — Apply starter knowledge and visibility
The player and NPC should start with partial knowledge only.

### Step 10 — Seed current season state
Apply:
- current weather phase
- current water levels
- current deadwood abundance
- current edible plant availability
- current vector season strength

---

# 21. Suggested data records

## 21.1 WorldCell
- id
- position
- elevation
- slope_class
- aspect
- landform_primary
- hydrology_type
- hydrology_reliability
- flood_risk
- drainage_class
- soil_texture
- soil_depth_class
- mud_tendency
- erosion_risk
- vegetation_type
- canopy_density
- understory_density
- deadwood_level
- pole_level
- fiber_level
- edible_patch_score_by_season
- stone_score
- clay_score
- small_game_score
- predator_transit_score
- tick_score
- mosquito_score
- shelter_score
- latrine_score
- storage_score
- garden_score
- movement_cost
- visibility_cost
- contamination_level
- traffic_level
- burn_level
- zone_flags

## 21.2 WaterFeature
- id
- type
- cells
- permanence
- flow_class
- access_difficulty
- baseline_trust
- contamination_sensitivity
- flood_influence_radius
- resource_associations
- notes_for_player_discovery

## 21.3 ResourcePatch
- id
- resource_family
- quality
- abundance
- regeneration_profile
- contamination_risk
- extraction_difficulty
- seasonal_behavior
- linked_landforms
- linked_cells

## 21.4 HabitatZone
- id
- habitat_type
- species_families
- concealment
- disturbance_sensitivity
- seasonality
- risk_to_humans
- attraction_to_food_waste

## 21.5 SiteCandidate
- id
- candidate_cells
- water_access_score
- dryness_score
- materials_score
- sanitation_score
- expansion_score
- hazard_score
- travel_score
- overall_site_class
- main_strengths
- main_weaknesses

---

# 22. Canonical early-map profile

To keep the project grounded, the default early-world template should probably resemble this:

## 22.1 Macro feel
A modest temperate stream valley or bench landscape with:
- one small perennial stream
- one or two tributary wet channels or intermittent gullies
- a mixed woodland belt
- an open meadow or lightly wooded patch
- one rocky or stony exposure
- at least one wet but non-ideal reed/fiber patch
- at least one decent terrace/bench suitable for camp
- at least one tempting but worse low flat near water

## 22.2 What this profile teaches naturally
It teaches:
- why water proximity matters
- why floodplains are dangerous despite convenience
- why dry elevated storage is valuable
- why hauling routes shape labor
- why brush/wetness affect pests and comfort
- why the camp should be placed with future sanitation and growth in mind

## 22.3 Why this is a good default
Because it produces meaningful early decisions without forcing obscure survival expertise from the player.

---

# 23. Simulation interactions with other systems

## 23.1 Logistics
The map determines:
- route cost
- haul time
- carrying burden
- where stockpoints make sense
- whether camp sprawl becomes expensive

## 23.2 Health and hazards
The map determines:
- damp sleeping risk
- cold stress amplification
- vector exposure
- flood harm
- smoke retention
- contamination routes

## 23.3 Buildings and structures
The map determines:
- where a shelter can stand well
- where a hearth is safe
- where storage remains dry
- where latrines are acceptable
- where gardens are feasible
- how much clearing is required

## 23.4 Social and settlement progression
The map determines:
- whether newcomers see the camp as viable
- whether hygiene can be maintained
- whether labor is wasted on hauling
- whether the settlement can separate functions cleanly
- whether the camp can become permanent

## 23.5 Knowledge and discovery
The map creates learnable truths:
- “that route is faster in dry weather”
- “that bench stays drier than the lower flat”
- “the spring line is reliable”
- “the marsh edge is unbearable in mosquito season”
- “we need to clear brush near sleeping areas”

---

# 24. Common world-generation failures to avoid

## 24.1 Perfectly balanced resource circles
This feels gamey and hides the logic of the land.

## 24.2 Random hazard noise
Hazards should come from understandable terrain/ecology causes.

## 24.3 Flat maps with cosmetic water
If water does not affect flooding, wetness, route choice, sanitation, and camp siting, it is not doing enough.

## 24.4 Camp sites with no room for separation
A site without enough room for water use, sleep, waste, and work separation should not score as strong.

## 24.5 “Good farmland” everywhere
Suitable cultivation ground should be present, but not universal.

## 24.6 Infinite nearby deadwood
Local depletion must matter or hauling never becomes a real system.

## 24.7 Marshes that are only negative
Wet zones should also have useful materials such as reeds, cool ground, wildlife, or clay opportunity.

## 24.8 Ridges that are only useless
Higher ground may offer dryness, visibility, and flood safety at the cost of wind and hauling.

---

# 25. Suggested first-playable subset

For the first implementation-facing use of this document, the minimum world model can be:

- elevation bands
- slope class
- landform primary tag
- water feature type
- drainage class
- vegetation type
- deadwood score
- stone score
- clay score
- edible forage score
- small game score
- tick score
- mosquito score
- shelter score
- latrine score
- garden score
- movement cost
- contamination level
- traffic level

That is enough to make early camp placement and hauling meaningfully realistic without requiring a giant map engine immediately.

---

# 26. Short conclusion

The world/map layer should make the player feel this truth:

> Civilization begins not on a blank grid, but on a piece of land with strengths, weaknesses, seasons, water paths, wet ground, dry ground, useful edges, dangerous edges, and long-term consequences.

A good early map for this project should:
- offer at least one viable survival route
- reward good site judgment
- punish bad drainage and careless sanitation
- create real hauling burdens
- teach the player the land through repeated use
- support growth from lone sleeper to camp to tiny hamlet

If this layer is done well, the early game will already feel far more real than most colony or idle games, even with extremely minimal graphics.

---

# References

- U.S. Geological Survey, “Floodplains and climate change”
- U.S. Geological Survey, “Floods: Things to Know”
- U.S. Geological Survey, “Springs and the Water Cycle”
- U.S. Geological Survey, “Aquifers and Groundwater”
- USDA NRCS, “Soils & Soil Survey”
- USDA NRCS, “Web Soil Survey”
- USDA NRCS, “Land capability classification” references
- FAO, “Land suitability classifications”
- FAO, “Assessing suitability”
- CDC, “Where Mosquitoes Live”
- CDC, “Mosquito Control at Home”
- CDC, “Preventing Lyme Disease” / “Preventing Tick Bites”
- CDC, “Lightning Safety”
- NOAA/NWS JetStream, “Lightning Safety”
- WHO, “Water sanitation and health in humanitarian emergencies”
- National Park Service / Denali, backcountry camping sanitation guidance
- Ready for Wildfire / FEMA / USFA guidance on defensible space and wildfire risk reduction
