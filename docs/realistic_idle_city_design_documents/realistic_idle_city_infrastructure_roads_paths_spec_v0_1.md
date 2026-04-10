
---
title: "Realistic Incremental/Idle Colony-to-City Game - Infrastructure / Roads / Paths Spec"
version: "v0.1"
scope:
  - "Early-slice focus: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
  - "Top-down minimal-visual presentation"
  - "Earth-like temperate starting biome"
status: "Design specification"
---

# 1. Purpose of this document

This document defines the **infrastructure movement layer** for the early game:
how paths form, how routes become maintained, how hauling corridors change settlement viability,
and how small camps begin to create real circulation networks.

It is not a vehicle-era roads document.
It is a **foot traffic, hand hauling, camp access, lane, drainage, and crossing** document for the
lone-survivor to tiny-hamlet slice.

This spec exists because the project already treats logistics as real labor and real time rather than
invisible teleportation. Roads and paths are therefore not decorative map features. They are
**productivity multipliers, erosion risks, reserve protectors, hazard reducers, and social organizers**.

# 2. Relationship to the current design stack

This spec should be read as infrastructure support for the already-established layers:

- NPCs have body limits, fatigue, hauling burden, interests, skills, morale, and self-preservation.
- Tasks depend on access, travel time, route condition, safety, and interruption.
- Items and materials have mass, volume, contamination risk, decay risk, and storage rules.
- Processes require work areas, material flow, fuel flow, waste flow, and often dry access.
- Buildings and structures already include caches, hearths, latrines, drying racks, work areas, pits, shelters, gardens, and proto-communal structures.
- Settlement progression already distinguishes lone-survivor camp, primitive camp, permanent camp, and tiny hamlet.
- Hazards, food/water safety, pollution/waste, and health systems already make mud, runoff, smoke, contamination, and distance matter.

This document does **not** replace the logistics spec.
It defines the **physical route layer** that logistics operates over.

# 3. Core design stance

## 3.1 Early infrastructure is mostly about feet, hands, and weather
In the early slice, the dominant movement systems are:

- walking
- carrying in hands
- bundle dragging
- shoulder/back carry
- repeated hauling along the same line
- stepping over or around obstacles
- choosing routes based on dryness, slope, risk, and effort

So infrastructure begins as:
- desire lines
- cleared footpaths
- maintained camp paths
- reinforced muddy sections
- simple stream crossings
- haul routes
- yard edges and work aprons
- settlement lanes

## 3.2 Infrastructure emerges from repeated need
A path should usually **appear because people keep using a line**.

That means the design should strongly support:
- path formation by traffic
- route improvement after repeated use
- route abandonment when conditions worsen
- rerouting when wet ground, erosion, danger, or camp expansion makes an old line bad

## 3.3 Water is the main infrastructure enemy
The single most important realism principle in this layer is:

> Water should not be encouraged to run down the route.

In both trails and low-volume roads, drainage controls long-term function.
If water is concentrated on the tread or lane, the route degrades, puddles, erodes, widens, and pushes users to make bypasses.

## 3.4 Early infrastructure is also social order
Paths and lanes help define:
- what is inside camp vs outside camp
- what is clean vs dirty
- where water carriers walk
- where waste is moved
- where outsiders approach
- where children or recruits can safely move
- where watch and alarm lines run
- where reserves are protected

# 4. Definitions

## 4.1 Path
A mostly pedestrian route established by repeated movement, with little or no engineered surface.

## 4.2 Cleared path
A path where brush, loose obstacles, low branches, and trip hazards have been intentionally removed.

## 4.3 Maintained path
A path with recurring upkeep such as clearing, smoothing, drainage correction, edging, stepping stones, or tread repair.

## 4.4 Haul route
A route repeatedly used for moving wood, water, clay, stone, hides, food, or building materials.

## 4.5 Lane
A wider and more socially recognized route inside or immediately outside a settlement, supporting repeated two-way foot movement, clustered hauling, and access between work zones.

## 4.6 Road
In the early slice, a road is not yet a true engineered wagon road.
It is a more formal lane or outside approach route with deliberate surface shaping, drainage intention, and maintenance status.
Full road engineering belongs more to later village/market-town docs.

## 4.7 Crossing
Any infrastructure element that carries movement across water, wet ground, gullies, unstable soil, or other interruptions.

## 4.8 Apron / work apron
Hardened or repeatedly cleared ground immediately around a structure or work area where frequent traffic and stock handling occur.

## 4.9 Route corridor
The broader usable band around a path or lane, including shoulders, drainage edge, sidestep space, and vegetation margin.

# 5. What infrastructure must solve in the early game

Early infrastructure is justified only when it solves one or more real bottlenecks.

## 5.1 Access
- can the NPC reach water, fuel, food, clay, stone, gardens, and shelters reliably?
- can the route still be used in darkness, rain, mud, or light snow?
- can a sick, tired, or loaded NPC still complete the trip?

## 5.2 Efficiency
- does the route reduce travel time?
- does it reduce slips, detours, and load drops?
- does it reduce path widening and wasted labor?

## 5.3 Clean/dirty separation
- does the water path avoid waste routes?
- do food paths avoid latrine and carcass zones?
- do outsiders arrive on a controlled approach path rather than through the camp core?

## 5.4 Seasonal survivability
- does the camp still have access to water in heavy rain?
- can firewood be hauled when the ground is soft?
- can seed and stores be moved without repeated wetting?
- can shelter be reached quickly in storms or at night?

## 5.5 Expansion logic
- can the camp grow without becoming a tangle of trampling?
- do new structures connect to a recognizable internal circulation system?
- are important routes easy to monitor and defend?

# 6. Realism principles

## 6.1 Best route is often relocation, not heroic repair
Wet, boggy, or flood-prone alignments should often be rerouted rather than “fixed forever.”
Early camps should prefer:
- slight slope
- mineral soil
- naturally draining ground
- shorter dry detours
over endlessly repairing a bad low line.

## 6.2 The route should lie lightly on the land when possible
Early paths should follow natural contours, avoid constant straight-line cuts across bad ground,
and use the land’s natural dry passages where available.

## 6.3 Surface shaping matters more than surface material at first
Before the settlement can afford major surfacing, the biggest gains often come from:
- choosing better alignment
- removing trip hazards
- preserving slight outslope
- avoiding depressions
- draining wet pockets
- keeping traffic off saturated ground

## 6.4 Every route has a maintenance bill
No path is permanent.
It accumulates:
- vegetation regrowth
- rutting
- puddling
- edge sloughing
- mud
- snow cover
- displaced stones
- ash/soot around work areas
- contamination risk where dirty traffic crosses clean routes

## 6.5 Route category should match traffic burden
Do not overbuild every line.
A latrine path, wood-haul path, internal sleeping path, and spring access path do not need identical treatment.

# 7. Infrastructure categories in the early slice

## 7.1 Survival access lines
These appear first and matter most:
- shelter <-> hearth
- shelter <-> water source
- shelter <-> immediate gathering radius
- shelter <-> sanitation area
- shelter <-> emergency lookout / perimeter check

## 7.2 Camp service paths
As camp structure emerges:
- shelter <-> wood cache
- shelter <-> food processing area
- shelter <-> drying rack / smoking frame
- shelter <-> refuse zone
- shelter <-> hide/fiber work area

## 7.3 Clean routes
Routes where contamination control matters:
- potable water route
- cooked-food route
- bedding/clothing route
- seed route
- container route for cleaned vessels

## 7.4 Dirty routes
Routes that should be spatially separated where possible:
- latrine route
- refuse hauling path
- carcass/offal removal path
- ash dump path
- dirty hide processing path

## 7.5 Haul corridors
High-repeat movement lines:
- water haul line
- firewood line
- stone/clay line
- harvest carry line
- construction materials line

## 7.6 Internal camp lanes
Once camp becomes permanent:
- common circulation line between shelters
- access between storehouse, hearth/kitchen, work areas, and water handling
- dry line through the camp core
- night-watch circulation loop

## 7.7 External approach routes
These matter by permanent camp and hamlet:
- main approach from surrounding terrain
- outsider arrival point
- trade/guest approach
- route to managed plots and distant resources

# 8. Maturity ladder

Infrastructure should evolve through recognizable states.

## 8.1 State 0 - No route
Travel happens ad hoc.
Time and risk vary every trip.

## 8.2 State 1 - Desire line
A visible line created by repeated movement.
Gameplay effects:
- slight movement improvement
- slight wayfinding improvement
- increased soil wear
- low mud sensitivity
- no real contamination control

## 8.3 State 2 - Cleared path
Brush, protrusions, and simple obstacles removed.
Gameplay effects:
- fewer slips and delays
- better night movement
- better hauling reliability
- faster repeated trips
- still weak under wet conditions

## 8.4 State 3 - Maintained path
Periodic upkeep and local tread correction.
Gameplay effects:
- stronger speed and reliability
- better contamination routing
- reduced widening
- reduced path loss after regrowth
- more visible social order

## 8.5 State 4 - Reinforced path
Selected sections are improved with stone, log edging, stepping stones, turnpike-like elevation, simple puncheon, or hardened work aprons.
Gameplay effects:
- stronger all-weather performance
- less mud delay
- better load movement
- better reserve protection
- higher build and maintenance cost

## 8.6 State 5 - Settlement lane
A named and socially recognized route serving several structures or zones.
Gameplay effects:
- route priority in task generation
- stronger movement reliability
- stronger monitoring, security, and cleanliness effects
- route becomes part of stage checks for permanent camp / hamlet

## 8.7 State 6 - Early road / service road
A wider, intentionally shaped route with greater maintenance expectations and potential for future animal or cart use.
In the early slice this appears only near the upper hamlet edge and is rare.

# 9. Route hierarchy for the early settlement

The game should distinguish route importance.

## 9.1 Tier A - Critical survival routes
These should be protected first:
- camp core <-> safest water access
- shelter <-> hearth
- shelter <-> dry sleeping access
- shelter <-> emergency sanitation line

If these fail, survival is directly threatened.

## 9.2 Tier B - Daily production routes
- wood haul route
- food processing route
- hide/fiber work route
- cache/storehouse route
- cooking/washing route

## 9.3 Tier C - Expansion routes
- garden and plot access
- clay/stone collection line
- perimeter watch path
- outsider approach route
- secondary water route

## 9.4 Tier D - Improvement / comfort routes
- aesthetic internal connections
- alternate dry-season shortcuts
- redundant loops
- future workshop links

# 10. Route placement doctrine

## 10.1 General alignment rules
Prefer routes that:
- stay out of standing water
- avoid direct fall-line descent where runoff will channel
- use naturally firmer ground
- avoid cutting through the sanitation plume of camp
- avoid unstable banks
- avoid thick brush where ticks, hidden hazards, or predators are more likely
- preserve clear sight where security matters
- leave room for future structures and traffic

## 10.2 Water access paths
Water access paths should:
- use the safest reliable source, not always the shortest line
- avoid latrine/refuse/carcass drainage
- reduce slips on banks
- include waiting and vessel-handling space near the collection point
- avoid repeated trampling that collapses muddy banks into the water

## 10.3 Sanitation routes
Sanitation paths should:
- be direct enough to encourage use
- remain distinct from food and water circulation
- function at night or in rain
- avoid sending contaminated runoff through the camp core

## 10.4 Work area access
Dirty, smoky, or noisy work areas should have routes that do not pass through sleeping and food-storage cores more than necessary.

## 10.5 Garden and field access
Garden routes should:
- allow daily inspection
- avoid trampling planted beds
- support water movement if irrigation is used
- separate harvest-in and refuse/manure-out flows where practical

## 10.6 Approach and outsider routes
By permanent camp and hamlet, the settlement should prefer outsiders to arrive on a visible approach path rather than entering through backsides, waste lines, or water access lines.

# 11. Surface and tread types

## 11.1 Bare earth
Default early surface.
Pros:
- cheap
- fast to establish
Cons:
- highly weather-sensitive
- compacts into mud or dust
- easy to rut and widen

## 11.2 Trampled grass / light vegetation
Works for low-traffic dry-season paths.
Low durability under repeated hauling or rain.

## 11.3 Mineral-soil tread
Better than organic-rich or boggy ground.
Should be preferred when aligning or rerouting.

## 11.4 Stone-spotted tread
Local stones placed at wear points, bank landings, or wet pockets.
Useful for:
- spring access
- work aprons
- firewood drop areas
- high-use corners

## 11.5 Log or timber reinforcement
Useful for:
- edging
- muddy short sections
- puncheon-like crossings
- retaining loose fill on short raised sections
Cons:
- rot
- slipperiness when wet
- maintenance burden

## 11.6 Brush / mat / fascine-like temporary stabilization
Low-grade short-term use to reduce sinking or churn in very early camp.
Should be unstable and temporary, not a magical permanent road.

## 11.7 Gravel / crushed stone
Rare and labor-intensive in the early slice but possible in tiny amounts for very high-use aprons or crossings.
More relevant to later village roads.

# 12. Drainage doctrine

## 12.1 Most path failure is drainage failure
Common route failures:
- puddles
- water channeling down the tread
- mud sinks
- edge slough
- bank undercutting
- widened bypasses
- sediment washing into watercourses or camp areas

## 12.2 Fundamental drainage rules
Early routes should prefer:
- slight outslope where sidehill travel is used
- small grade reversals / natural dips where terrain allows
- no long uninterrupted chute for water
- local side release of water rather than concentration on the line
- avoidance of depressions and low bowls
- not trapping water against structures or stores

## 12.3 Wet spots
When a route develops a chronic wet spot, the response order should usually be:
1. reduce or redirect traffic if possible
2. check whether rerouting is better
3. drain or relieve the wet pocket if simple and safe
4. harden/elevate only if the route is critical and alternatives are worse

## 12.4 Hamlet-level road shaping
Once the settlement begins shaping lanes more deliberately, the lane surface should shed water rather than hold it.
Ditches, shoulders, and outlets are only useful if water can safely leave the route without creating new erosion or contamination problems.

# 13. Crossings and wet-ground treatments

The early slice should support several low-complexity crossing types.

## 13.1 Informal ford
Simple crossing at shallow, firm-bottomed water.
Best for:
- very low traffic
- seasonal use
- low consequence
Weakness:
- slippery
- turbidity and bank damage risk
- unreliable in high flow

## 13.2 Stepping stones
Appropriate for pedestrians only, especially for small streams or persistently wet spots.
Good when:
- stones are stable
- flow is modest
- bank approaches are firm
Weakness:
- poor under ice, flood, or heavy load
- not ideal for large vessel or bundle carry

## 13.3 Simple log crossing
A very early, low-reliability crossing over narrow ditches or rivulets.
Good for:
- dry weather foot use
Weakness:
- slippery
- rot
- rolling if badly set
- dangerous under heavy loads or in dark

## 13.4 Puncheon / bog-bridge-like section
Short raised timber section over persistent wet ground.
Good for:
- repeated pedestrian use in one wet point
- protecting the tread from chronic bogging
Weakness:
- wood decay
- higher material cost
- needs approach stabilization

## 13.5 Raised earth / turnpike-like tread
Used where ground is wet but not impossible, and fill plus side relief can produce a usable passage.
Better for repeated haul traffic than deep muck.
Weakness:
- can fail badly if water has nowhere to go
- requires maintenance

## 13.6 Hardened low-water crossing
Appropriate only near the upper end of the early slice and where there is repeated need.
Should minimize channel damage and scour risk.
More of a hamlet feature than a primitive camp feature.

## 13.7 Crossing selection rule
Crossing type should depend on:
- traffic level
- load burden
- failure consequence
- seasonality
- flow strength
- bank stability
- available labor/materials
- contamination sensitivity downstream

# 14. Work aprons and activity pads

A large amount of route wear actually happens not along lines but around nodes.

## 14.1 Key apron locations
- hearth / kitchen area
- storehouse door area
- spring or water-collection bank
- wood chopping / wood drop zone
- drying rack / smoking frame approach
- hide processing zone
- clay processing area
- latrine entrance zone
- main shelter entry

## 14.2 Why aprons matter
They:
- reduce mud at work nodes
- improve throughput
- reduce contamination transfer into shelters
- reduce slips during handling
- create visible social order

## 14.3 Early apron materials
- local stone scatter
- compacted mineral soil
- timber edging with fill
- brush or matting as temporary treatment
- later small gravel or broken fired material

# 15. Interaction with hauling and labor

## 15.1 Route quality modifies effective hauling burden
The route does not literally make an item lighter.
It changes:
- speed
- stumble/drop chance
- fatigue per distance
- contamination chance
- whether repeated trips are sustainable

## 15.2 Haul classes
Suggested haul classes:
- Class 0: hand-carried small items
- Class 1: bundled light goods
- Class 2: water vessels / moderate loads
- Class 3: repeated fuelwood / stone / clay
- Class 4: oversized or awkward materials requiring pauses, drags, or help

Higher classes should be more sensitive to:
- slope
- mud
- sharp turns
- unstable crossings
- narrow route width
- darkness
- congestion

## 15.3 Two-person and assisted movement
A tiny hamlet should be able to create tasks that temporarily use two NPCs or one NPC plus local helpers to move bulky materials along recognized haul routes.

# 16. Interaction with contamination and cleanliness

## 16.1 Infrastructure is part of sanitation
The clean/dirty route network matters because contamination often spreads through:
- foot traffic
- vessel placement on dirty ground
- crossing from waste areas back into food areas
- animals using the same line as water carriers
- muddy runoff entering handling zones

## 16.2 Clean route rules
For critical routes:
- avoid passing through waste zones
- avoid chronic mud
- provide cleaner bank access or vessel staging
- increase maintenance priority after rain or incidents

## 16.3 Dirty route rules
Dirty routes should not dominate the camp core.
If the easiest line to the latrine or offal pit crosses the cooking and storage core, the camp layout is poor.

# 17. Interaction with security and governance

## 17.1 Infrastructure creates lines of control
Clear approach paths improve:
- monitoring
- guest handling
- alarm raising
- reserve protection
- perimeter patrol efficiency

## 17.2 Night movement
A tiny hamlet should value:
- recognizable core lanes
- obstacle-minimized night routes
- shortest safe path to shelter and fire
- shortest safe route to water or latrine in emergencies

## 17.3 Governance hooks
Early governance can regulate:
- which routes are reserve-priority
- who may use which approach
- whether dirty work traffic is allowed through the camp core
- maintenance obligations
- right-of-way during emergency hauling

# 18. Interaction with settlement progression

## 18.1 Lone survivor
Infrastructure is mostly invisible or ad hoc:
- one or two repeated access lines
- no formal lane network
- route choice changes often with conditions

## 18.2 Primitive camp
The camp should begin showing:
- a recognizable water path
- shelter <-> hearth path
- latrine/refuse separation path
- first haul corridor for fuelwood

## 18.3 Permanent camp
Transition markers should include:
- at least one maintained internal dry route
- a deliberate approach path
- cleaner separation of water and waste traffic
- repeated apron treatment at key nodes
- at least one wet-spot or crossing solution if site requires it

## 18.4 Tiny hamlet
Transition markers should include:
- named or socially recognized lanes
- link between several structures and work zones
- route hierarchy
- maintained route to plots and storage
- visible control of approach and circulation
- maintenance burden assigned to roles or shared labor

# 19. Environmental and hazard interactions

## 19.1 Rain
After rain:
- some routes soften
- contamination spread increases
- hauling efficiency drops
- maintenance demand rises
- water access may become either easier or more dangerous

## 19.2 Cold and frost
- wet surfaces may freeze
- logs and stones become slick
- route choice may favor open sun-exposed lines
- repeated freeze-thaw damages lightly improved tread

## 19.3 Heat and dust
- loose surfaces become dusty
- visibility of desire lines increases
- water carrying urgency rises
- heavily exposed routes increase heat burden

## 19.4 Wind and falling debris
- forest-edge routes may become blocked
- watch and emergency shelter lines become more important
- storm cleanup can temporarily redefine route hierarchy

## 19.5 Fire
Infrastructure can support fire response:
- access to water
- clear run lines
- fuelbreak-like open strips near camp
- safe evacuation line
But paths are not magical fireproof zones.

# 20. Maintenance doctrine

## 20.1 Basic maintenance actions
- cut back encroaching vegetation
- remove trip hazards
- fill or bridge small soft spots
- reset stepping stones
- scrape or clear drainage outlets
- re-establish outslope or raised crown on lanes
- clean aprons
- move fouled soil away from clean nodes where appropriate
- repair crossings
- reroute failing segments

## 20.2 Maintenance frequency
Depends on:
- traffic class
- wetness
- slope
- season
- soil type
- contamination sensitivity
- role importance

## 20.3 Deferred maintenance consequences
- higher travel time
- more slips, spills, contamination, and fatigue
- route widening
- trail braiding
- worse bank damage
- reserve handling failure
- greater settlement disorder

# 21. Skill and knowledge links

## 21.1 Useful skills
- pathfinding / terrain judgment
- basic earthwork
- drainage awareness
- woodwork for simple crossings
- stone placement
- hauling practice
- sanitation awareness
- surveying / layout later

## 21.2 Knowledge states
Examples:
- "Wet ground keeps eating this route."
- "The water path is fouled after rain."
- "This crossing fails in spate/high flow."
- "The storehouse needs a dry apron."
- "The outsider path should not pass the water point."

Infrastructure should improve as a community learns these patterns.

# 22. Player-facing control implications

The player should be able to influence this layer through:
- route priority
- designation of clean / dirty / outsider / emergency paths
- preferred water path
- maintenance orders
- reroute orders
- restrict-use orders
- future lane planning
- crossing improvement orders
- storage-apron upkeep priorities

But the player should not need to hand-draw every footstep.
NPC traffic should still produce emergent route formation under the policy layer.

# 23. Suggested data model

## 23.1 Route record
- route_id
- name
- route_type
- maturity_state
- endpoints
- connected_zones
- length
- width_band
- slope_class
- surface_type
- drainage_profile
- wetness_sensitivity
- contamination_class
- traffic_class
- day_use_bias / night_use_bias
- load_limit_class
- seasonal_reliability
- maintenance_state
- hazard_tags
- visibility/security_rating
- priority_rating
- ownership/governance restrictions
- current blockages
- current degradation
- current notes

## 23.2 Crossing record
- crossing_id
- crossing_type
- route_id
- water_or_wet_feature_id
- load_limit_class
- slip_risk
- flood_failure_risk
- maintenance_need
- contamination_risk
- seasonality
- current status

## 23.3 Apron record
- apron_id
- attached_structure_or_zone
- surface_type
- cleanliness_class
- load_class
- area_size
- maintenance_need
- mud_risk
- contamination_risk
- throughput_bonus

## 23.4 Route-use telemetry
- trips_per_day
- heavy_trips_per_day
- night_trips
- contamination incidents
- slip incidents
- delays
- widening index
- reroute pressure
- reserve relevance

# 24. First-playable minimum set

For the very first implemented version of this layer, the game does not need full road engineering.

It only needs:

## 24.1 Route types
- no route
- desire line
- cleared path
- maintained path
- internal lane

## 24.2 Surface/wetness classes
- dry/fair
- soft/muddy
- rocky/uneven
- wet crossing point

## 24.3 Cleanliness tags
- clean-critical
- general
- dirty

## 24.4 Crossing types
- none
- ford
- stepping stones
- simple log
- reinforced wet section

## 24.5 Gameplay effects
- travel time modifier
- fatigue modifier
- slip/drop modifier
- contamination modifier
- maintenance need
- route formation pressure
- route degradation after weather

# 25. Strong recommendations for the early game

1. Let repeated traffic create desire lines automatically.
2. Make water access routes and work aprons matter very early.
3. Separate clean and dirty traffic sooner than most colony games do.
4. Treat drainage and rerouting as more important than simply “adding road.”
5. Make wet-ground path failure visibly create detours and settlement disorder.
6. Tie hamlet maturity partly to route hierarchy and maintained internal lanes.
7. Do not over-engineer early roads; save true cart-road logic for later.
8. Make crossings seasonal and failure-prone instead of permanently solved forever.

# 26. Open design questions for future infrastructure docs

These are intentionally deferred beyond the early-slice focus:
- pack-animal trail requirements
- cart and wagon turning/radius rules
- formal bridges and culverts as standard infrastructure
- road depots and dedicated road crews
- drainage ditches at larger settlement scale
- paving, metalling, or gravel surfacing at broad scale
- rights-of-way between plots and private holdings
- street hierarchy in true villages and towns
- canals, wharves, rail, and utility corridors

# 27. References and research anchors

The following sources strongly informed the realism logic of this spec:

- USDA Forest Service, *Trail Construction and Maintenance Notebook*  
  Key ideas used here: water should sheet across routes rather than run down them; outsloped tread and grade reversals are effective drainage structures; water-driven erosion causes widening and user-created bypasses.

- USDA Forest Service, *Trails in Wet Areas* / *Wetland Trail Design and Construction*  
  Key ideas used here: reroute wet problem sections when possible; prefer better-drained slopes and mineral soil; use raised tread / turnpike / puncheon-like solutions only where justified.

- EPA, *Recommended Practices Manual: A Guideline for Maintenance and Service of Unpaved Roads*  
  Key ideas used here: drainage is central to route survival; unpaved lanes need surface shaping and outlets; standing water weakens the route and accelerates failure.

- FAO, *Guidelines for Roading and Watercourse Crossings* and forest-road engineering material  
  Key ideas used here: crossing type should match flow/site/traffic; low-water crossings should minimize earth moving and stream-bed damage; culverts, fords, and bridges are selected by conditions and use.

- Existing project design stack:
  - logistics / hauling / storage flow
  - world / map / site generation
  - environmental hazard
  - food / water safety
  - pollution / waste / byproduct
  - settlement progression
  - defense / security
  - trade / market / exchange
  - building / structure bible
  - process bible
  - item / material bible

# 28. Short conclusion

In the early game, infrastructure is not yet “roads” in the civic sense.
It is the gradual conversion of repeated human movement into **reliable, cleaner, safer, and more efficient circulation**.

A believable camp becomes a believable permanent camp partly when:
- its routes stop collapsing into mud and confusion,
- water and waste traffic stop crossing casually,
- key work nodes gain hardened access,
- outsiders arrive through visible approaches,
- and the settlement’s internal movement begins to show order.

That is the role of this layer in the simulation.
