---
title: "Realistic Incremental / Idle Colony-to-City Game - Environmental Hazard Spec"
version: "v0.1"
scope: "Early scope primary: lone survivor -> primitive camp -> permanent camp -> tiny hamlet. Includes extension hooks for later eras."
author: "OpenAI / ChatGPT"
date: "2026-04-08"
status: "Working design document"
---

# 1. Purpose

This document defines the **environmental hazard layer** for the project.

It exists to answer:

- what kinds of environmental danger exist in the world
- how those dangers are detected, evaluated, and remembered
- how hazards change site selection, daily work, health, structures, storage, and settlement growth
- which hazards matter in the **early game** and which are merely future hooks
- how hazard realism is preserved without turning the game into a disaster-only simulator

This spec sits on top of the existing design stack:

- early-game survival and settlement documents
- NPC simulation and task evaluation
- item/material, process, and building/structure bibles
- settlement progression
- knowledge/discovery
- social/recruitment
- allocation/ownership/rationing
- health/injury/care

The environmental hazard layer should make the world feel real by ensuring that terrain, weather, water, wildfire, smoke, animals, contamination, and exposure are not decorative background. They are active constraints that shape behavior, settlement layout, and long-term viability.

---

# 2. Core design stance

## 2.1 What counts as an environmental hazard

An environmental hazard is any **external condition, event, landscape property, or ecological interaction** that can harm people, food, structures, tools, water, stored material, or the long-term viability of the site.

This includes:

- weather and temperature extremes
- wetness and exposure
- flooding and runoff
- lightning and wildfire
- smoke and poor air
- dangerous terrain and falling objects
- animal and insect pressure
- contaminated water and foul ground
- seasonal scarcity caused by environment
- erosion, rot, mold, and dampness affecting stored goods and buildings

## 2.2 What the system is trying to achieve

The goal is not to create random punishment.

The goal is to make the world obey realistic environmental logic:

- low ground floods
- wind strips heat and damages weak structures
- damp bedding ruins rest and raises illness risk
- smoke irritates lungs and enclosed combustion can become deadly
- exposed ridges and isolated trees raise lightning danger
- unsecured food attracts scavengers and larger animals
- poor camp sanitation contaminates living space and nearby water
- seasonal weather changes task timing and labor risk
- settlement expansion without drainage, waste control, and safe storage creates compounding problems

## 2.3 What this system is **not**

This system should **not** be:

- pure RNG punishment
- disconnected from terrain, season, or site choice
- a hidden math layer with no player-readable causes
- a replacement for health/injury/care
- a replacement for food safety/water safety
- a replacement for combat or security

It should instead be the **world-pressure layer** that feeds those systems.

---

# 3. Real-world anchors used for this spec

This project is explicitly realism-seeking, so the hazard layer is grounded in a few strong real-world principles:

- Heat, dehydration, and exertion reduce work safety, judgment, and physical capacity, and outdoor workers are at elevated risk during hot conditions.[R1][R2]
- Cold, wetness, and wind increase cold-stress risk; hypothermia and frostbite can emerge from exposure and poor clothing/shelter.[R3][R4]
- Flooding and flash flooding threaten low-lying camps and can occur rapidly, including in areas where rain is not falling locally but is falling upstream.[R5][R6]
- Lightning risk is higher in open high places and near tall isolated objects; tents do not protect from lightning.[R7][R8]
- Wildfire smoke is a harmful mixture of gases and particles that irritates eyes and lungs and degrades air quality.[R9][R10]
- Carbon monoxide from combustion in enclosed or partly enclosed spaces can poison and kill; camp stoves, charcoal, and similar combustion devices should not be used inside tents or other enclosed shelters.[R11][R12]
- Ticks, mosquitoes, and other biting arthropods concentrate in certain habitats and are best treated as place-linked exposure hazards.[R13][R14]
- Food odors and poor storage attract wildlife; food storage discipline is a genuine camping and settlement-safety issue.[R15]

These anchors do not mean the game must mirror emergency-management wording. They mean the world should obey the same underlying causal logic.

---

# 4. Hazard model overview

Each hazard should be represented through five layers:

## 4.1 Hazard source
What causes the danger.

Examples:
- ambient heat
- freezing wet weather
- floodplain siting
- heavy rainfall upstream
- tall isolated tree during thunderstorm
- smoky valley during nearby fire
- rotting waste near living zone
- brushy tick habitat
- food scraps near sleeping zone

## 4.2 Exposure channel
How the NPC, item, or structure is affected.

Examples:
- body temperature imbalance
- inhalation
- skin contact / bites
- contaminated ingestion
- slipping or falling
- structural collapse
- material wetting
- predator/scavenger attraction
- loss of access route
- contamination of stores or tools

## 4.3 Protective factors
What reduces risk.

Examples:
- better shelter siting
- dry bedding
- layered clothing
- windbreaks
- drainage ditching
- raised storage
- safe water handling
- smoke separation
- food storage discipline
- route choice
- task timing
- trained caution
- observation and memory

## 4.4 Event expression
How the risk becomes visible in play.

Examples:
- a body-state penalty
- a temporary task block
- spoilage acceleration
- settlement alert
- structure damage
- route closure
- morale hit
- increased care burden
- wildlife incident
- work speed reduction
- temporary abandonment of exposed zones

## 4.5 Persistence
How long the hazard matters.

Some are:
- momentary (lightning strike window)
- short-term (heat wave day)
- medium-term (muddy ground after rain)
- seasonal (mosquito/tick pressure, freezing nights)
- structural (flood-prone camp siting, waste too close to water)

---

# 5. Hazard categories

The environmental hazard system should classify hazards into stable categories.

## 5.1 Climate and weather hazards
- heat
- cold
- wind
- rain
- snow / freezing precipitation later
- thunderstorm / lightning
- drought
- storm sequences

## 5.2 Water and hydrology hazards
- unsafe water source location
- standing foul water
- runoff through camp
- floodplain occupation
- flash flood exposure
- bank collapse / slippery stream edge
- seasonal source failure
- waterlogging of storage

## 5.3 Fire and air hazards
- uncontrolled campfire spread
- ember spread into fuel storage or structures
- wildfire proximity
- smoke accumulation
- enclosed combustion / carbon monoxide
- ash contamination
- visibility reduction in smoke

## 5.4 Terrain and physical-site hazards
- steep slope
- loose rock
- deadfall / widowmaker branches
- unstable trees
- mud / bogging
- poor drainage
- erosion
- confined bad-air spaces later (mines, kilns, enclosed workshops)

## 5.5 Biological/ecological hazards
- predator presence
- scavenger pressure
- vermin/rodents
- insect swarms
- tick habitat
- mosquito habitat
- stinging insects
- animal-path intersections
- disease reservoir zones
- mold/fungal rot in damp structures and stores

## 5.6 Sanitation-linked environmental hazards
- waste near living space
- wastewater pooling
- carcass disposal too near camp
- latrine too near water
- food scraps left exposed
- contaminated work surfaces / dirty handling areas
- foul mud around work and sleeping zones

## 5.7 Resource-scarcity hazards
- local fuel depletion
- water scarcity
- seasonal forage collapse
- storm-damaged access routes
- winter exposure combined with poor fuel reserve
- drought pressure on garden plots and stored feed later

---

# 6. Hazard entities and data model

## 6.1 Suggested hazard record

Each hazard instance should be able to store:

- `hazard_id`
- `hazard_type`
- `category`
- `source_tile_or_region`
- `origin_mode`  
  - constant  
  - seasonal  
  - event  
  - triggered by player/NPC action  
  - structure-generated  
  - ecology-generated
- `severity`
- `predictability`
- `detectability`
- `onset_speed`
- `duration`
- `spread_behavior`
- `affected_entities`
- `main_exposure_channels`
- `early_signs`
- `known_to_settlement`
- `known_to_individual_npcs`
- `mitigations_available`
- `current_controls_active`
- `failure_modes`
- `linked_health_states`
- `linked_item_damage`
- `linked_structure_damage`
- `linked_task_modifiers`
- `linked_route_modifiers`
- `memory_decay_or_persistence`

## 6.2 Severity scale

Recommended hazard severity classes:

- **Negligible** – no meaningful harm unless stacked with other hazards
- **Low** – mild pressure; small penalties or localized inconvenience
- **Moderate** – real operational consequences; requires response
- **High** – likely injury, major loss, or forced rerouting
- **Extreme** – immediate life-threatening or site-threatening danger

Severity should be modified by:
- preparedness
- knowledge
- structure quality
- clothing/equipment
- time of day
- NPC condition
- number of exposed NPCs
- shelter and route access

## 6.3 Predictability classes
- obvious and constant
- obvious and seasonal
- observable shortly before onset
- partially hidden but inferable
- mostly hidden until experienced

## 6.4 Detectability channels
- direct sensory cues
- environmental signs
- prior settlement memory
- inferred from weather/season
- animal behavior cues
- repeated task failure
- post-event damage evidence
- formal monitoring later

---

# 7. General simulation rules

## 7.1 Hazards stack

Environmental hazards should combine.

Examples:
- cold + wet + wind is worse than any one alone
- poor sleep + heat + heavy hauling sharply raises failure risk
- smoke + exertion + dehydration compounds breathing stress
- muddy slope + load carrying raises injury chance
- spoiled food + unsafe water + poor sanitation spikes illness burden

## 7.2 Hazards are local, not universal

Two tiles or zones near each other can have very different risk:

- ridge vs hollow
- shaded forest edge vs exposed field
- upstream clean draw vs stagnant side pool
- camp core vs refuse edge
- sheltered dry store vs damp pit
- low valley smoke trap vs breezy slope

## 7.3 Hazards must have readable causes

The player should almost always be able to answer:

- what caused this
- why this place is risky
- why this task is unsafe today
- what mitigation was missing
- why the same task was safe yesterday

## 7.4 Experience and knowledge matter

Repeated exposure should improve:
- detection
- avoidance
- task timing
- site choice
- route selection
- protective construction

But knowledge should not make the hazard disappear. It should make behavior more competent.

## 7.5 Structures do not remove nature completely

Even a “safe” structure should only reduce hazard in believable ways.

Examples:
- a lean-to blocks some wind and rain but not lightning
- a smoke rack preserves food but can attract scavengers if badly placed
- a storage pit cools produce but can become damp or contaminated
- a wattle-and-daub hut improves warmth but can be vulnerable to fire, rot, roof leak, and smoke if badly vented

---

# 8. Primary early-game hazards

This section defines the hazards that matter most in the agreed early scope.

## 8.1 Heat stress

### What it is
Danger from hot ambient conditions, solar exposure, exertion, and inadequate hydration.

### Why it matters
Hot weather, hard labor, and sweating increase dehydration risk and can progress to heat-related illness.[R1][R2]

### Typical triggers
- hauling during midday heat
- woodcutting or digging in exposed sun
- long tasks with few water breaks
- low water stores
- heavy clothing later
- poorly timed travel

### Early signs
- thirst
- slowing pace
- irritability
- fatigue
- dizziness
- reduced judgment
- reduced willingness to continue

### Gameplay expression
- stamina drains faster
- task interruption
- worse decision quality
- higher error rate
- more care needed after work
- possible collapse or emergency escalation in severe cases

### Main mitigations
- work earlier/later
- rest in shade
- lighter task sequencing during hot hours
- drink from safer stored water
- keep hauling routes short
- build shade structures later

### Knowledge/discovery hooks
- “midday hauling is costly”
- “shade + water + rest restore safer work capacity”
- “exposed ground is worse than shaded forest edge”

## 8.2 Cold stress and chilling wetness

### What it is
Danger from low temperature, wind, rain, damp clothing, wet bedding, and inadequate shelter.

### Why it matters
Cold stress worsens rapidly when clothing, bedding, or shelter are wet; wind also increases heat loss.[R3][R4]

### Typical triggers
- sleeping on damp ground
- rain without dry shelter
- wet footwear
- wind-exposed camp
- insufficient fuel
- working while soaked and exhausted

### Early signs
- shivering
- clumsiness
- slower task speed
- morale drop
- poor sleep
- reluctance to leave shelter
- pain/numbness in extremities later

### Gameplay expression
- strong rest penalty
- higher calorie demand
- slower morning recovery
- increased injury chance from clumsy work
- care burden after exposure event

### Main mitigations
- dry bedding
- raised sleeping surface if possible
- windbreak placement
- fire access
- dry spare wraps/clothing
- quicker drying of wet gear
- prioritize roof integrity

### Knowledge/discovery hooks
- “ground moisture matters as much as roof”
- “wind-exposed camps cost more fuel and sleep quality”
- “keeping one dry reserve blanket/wrap changes survival odds”

## 8.3 Rain and persistent dampness

### What it is
Moisture pressure that degrades body comfort, routes, structures, fuel, food, hides, fibers, and stored goods.

### Why it matters
Even when rain is not severe enough to flood, dampness causes cascading losses: poor sleep, wet fuel, mold, rot, spoilage, slippery work zones, and reduced fire reliability.

### Typical triggers
- prolonged light rain
- repeated storms
- poor roof runoff
- open storage
- direct-ground storage
- badly drained camp cores

### Gameplay expression
- fire-lighting harder
- drying tasks slower
- structure condition loss
- spoilage increase
- storage contamination or mold risk
- morale loss
- route slowdown from mud

### Main mitigations
- roof overhangs / drainage edges
- raised storage
- dry covered fuel reserve
- separate wet and dry work zones
- ditching later
- move critical stores away from splashing runoff

## 8.4 Flooding and flash flood risk

### What it is
Water movement that overtops low areas, channels through camp, isolates routes, ruins stores, and threatens life.

### Why it matters
Flood-prone and low-lying sites are unsafe; flash floods can occur quickly and may arrive from upstream rainfall.[R5][R6]

### Typical triggers
- camp on floodplain or wash
- intense rain
- rain upstream
- channelized runoff through camp
- stream-edge storage pits
- low crossings on routes

### Early signs
- rising water
- new runoff channels
- ground saturation
- debris carried by moving water
- previously dry gullies beginning to flow
- impassable crossings

### Gameplay expression
- forced evacuation from tiles
- storage loss
- soaked fuel and bedding
- route severance
- drowning/trauma risk in extreme events
- major morale and reserve hit

### Main mitigations
- choose camp above flood line
- avoid dry washes/channel bottoms
- keep key stores upslope
- maintain higher-ground fallback spot
- use more than one water route if possible
- do not build critical shelter in depressions

### Knowledge/discovery hooks
- “good water access is not the same as safe water-edge living”
- “a flat easy site can be a bad storm site”
- “upstream rain matters even when local rain looks manageable”

## 8.5 Lightning and thunderstorm exposure

### What it is
Short-duration but high-severity storm danger from lightning, falling branches, sudden wind, intense rain, and fire ignition.

### Why it matters
Open high ground and tall isolated trees increase lightning danger; tents and flimsy shelters do not provide lightning protection.[R7][R8]

### Typical triggers
- working on ridge or open field during storm
- sheltering under isolated tall tree
- carrying long poles/tools in exposed area
- remaining near water in thunderstorm
- poor storm timing for travel

### Gameplay expression
- urgent task reprioritization
- temporary closure of exposed zones
- lightning fire ignition chance
- branch-fall/injury risk
- morale shock after near strike

### Main mitigations
- retreat from ridge tops and open ground
- avoid isolated tall trees
- use lower, less exposed ground
- pause exposed labor
- develop storm memory for certain routes/areas

## 8.6 Wind and falling-object risk

### What it is
Hazard from strong wind, wind chill, blown embers, structural strain, and falling dead branches/trees.

### Why it matters
Wind strips warmth, increases fire spread risk, and makes weak roofing, loose thatch, dead limbs, and unstable trees dangerous.[R4][R16]

### Typical triggers
- exposed ridge camp
- dead branches above shelter
- loosely secured roofing
- open fire in gusty conditions
- carrying light materials in high wind

### Gameplay expression
- shelter damage
- fuel consumption rise
- ash/ember spread
- branch-fall injury risk
- task penalties for light construction and fire use

### Main mitigations
- wind-sheltered siting
- branch and deadfall clearance near camp
- better roof fastening
- windbreak structures or vegetation use
- temporary fire restrictions during gusts

## 8.7 Wildfire and ember spread

### What it is
Hazard from uncontrolled vegetation fire, fast-moving flame front, ember attack, radiant heat, smoke, and route loss.

### Why it matters
Wildfire can destroy structures, cut off movement, contaminate air, scatter wildlife, and force abandonment. Smoke harms breathing even when flame is distant.[R9][R10]

### Typical triggers
- drought + wind
- careless open fire
- lightning strike
- dry grass/brush buildup
- cooking/smoking too close to fuel bed

### Gameplay expression
- regional hazard alert
- route closures
- evacuation pressure
- water/fuel task reprioritization
- heavy morale shock
- stored-food and structure loss
- long smoke tail after flames pass

### Main mitigations
- keep fire-separated clear ground around critical structures
- manage brush and litter near camp
- place hearths carefully
- keep water/smothering material ready
- create emergency haul priorities for seed, water, bedding, and tools
- store important goods in more than one location

### Early-scope note
The early game should emphasize **campfire escape and local brush fire** before full landscape wildfire simulation.

## 8.8 Smoke accumulation and poor air

### What it is
Irritating or harmful air from cooking fires, smoking racks, accidental smoldering, or wildfire smoke.

### Why it matters
Wildfire smoke and wood smoke irritate eyes and lungs and reduce work comfort and capacity.[R9][R10][R17]

### Typical triggers
- smoky fire with wet fuel
- poor airflow in shelter
- sleeping too close to smoky hearth
- valley or hollow trapping smoke
- nearby wildfire/prescribed burn equivalent

### Gameplay expression
- eye irritation
- coughing
- lower willingness to work
- reduced sleep quality
- respiratory burden stacking with illness and heavy labor
- indoor-space disuse if smoke gets too bad

### Main mitigations
- fuel drying
- venting and fire placement
- keep sleeping area out of dense smoke plume
- move some tasks outdoors
- avoid smoke-trapping hollows for core sleeping spaces if fire use is constant

## 8.9 Carbon monoxide and enclosed combustion

### What it is
Poisoning risk from combustion fumes in enclosed or semi-enclosed spaces.

### Why it matters
Carbon monoxide is odorless and colorless and can cause sudden illness or death; combustion devices should not be used in enclosed spaces such as tents or badly enclosed shelters.[R11][R12]

### Typical triggers
- charcoal or stove used inside tent
- poorly vented enclosed fire
- sleeping in smoke-filled enclosure
- burning fuel in space designed for heat retention but not ventilation

### Gameplay expression
- headache / dizziness / confusion symptoms
- rapid fatigue
- sudden collapse
- night-time death risk if severe and unnoticed

### Main mitigations
- ventilation
- avoid enclosed charcoal/stove use
- separate heat source from sealed sleeping chamber
- never treat a small shelter as a safe furnace room

### Design note
This should be rare but terrifying. It is a realism anchor, not a constant micromanagement chore.

## 8.10 Dangerous terrain and slips/falls

### What it is
Hazard from steep slopes, unstable banks, loose stone, roots, mud, and load-carrying over bad ground.

### Why it matters
Many early injuries should come not from combat but from ordinary work on bad ground: hauling, chopping, crossing wet banks, climbing, or carrying tools.

### Typical triggers
- muddy stream crossing
- steep loaded descent
- night movement without good light
- wet clay pit edge
- cluttered camp path
- unstable log bridging

### Gameplay expression
- sprains
- cuts
- bruises
- dropped loads
- broken containers
- route avoidance learning

### Main mitigations
- path wear and maintenance
- avoid overloading
- choose safer crossings
- improve camp path cleanliness
- simple steps / ramps later
- move repeated tasks away from unstable ground

## 8.11 Animal-path and predator pressure

### What it is
Risk from camping or working too close to predator zones, scavenger paths, den sites, or habitual animal travel routes.

### Why it matters
The design stack already assumes site choice should consider distance from predator dens and risky swamp/disease zones. fileciteturn33file0

### Typical triggers
- sleep zone near game trail
- meat processing near bedding
- exposed food scraps
- carcass left near camp
- camp in dense concealment with poor visibility
- foraging at dawn/dusk in predator-heavy zones

### Gameplay expression
- stolen food
- disturbed sleep
- fear spikes
- injury or death in rare severe events
- forced relocation of processing zones

### Main mitigations
- food and waste discipline
- separate butchering from sleeping
- visibility lanes around core camp
- noise/light/fire deterrence where appropriate
- avoid repeated use of known high-risk animal corridors

## 8.12 Rodent, scavenger, and pest pressure

### What it is
Small-animal pressure on food, seed, bedding, hides, and structures.

### Why it matters
Poor storage invites chronic losses. In reality, food storage discipline is a core part of camp and settlement safety.[R15]

### Typical triggers
- open food scraps
- seed in permeable bags on ground
- fish/meat drying without protection
- refuse near stores
- cluttered storage zones

### Gameplay expression
- attrition losses
- contamination
- seed stock damage
- morale irritation
- scavenger/predator attraction

### Main mitigations
- raised, sealed, or protected storage
- strict scrap removal
- drying screens / guarded racks
- separate refuse area
- routine inspection tasks

## 8.13 Tick, mosquito, and biting-insect exposure

### What it is
Place-linked insect and arthropod pressure that causes bites, irritation, fatigue, and disease risk.

### Why it matters
Ticks and mosquitoes concentrate in specific habitats such as grassy, brushy, wet, wooded, or stagnant-water areas.[R13][R14]

### Typical triggers
- high grass or brush
- leaf litter
- damp woodland edge
- stagnant water nearby
- dawn/dusk work near water
- sleeping with exposed skin during insect-heavy season

### Gameplay expression
- bite count
- poor sleep
- irritation and morale penalties
- infection/disease chance over time
- route preference changes

### Main mitigations
- avoid worst habitat during peak periods
- clear vegetation near camp
- choose breezier sleeping location where appropriate
- cover skin better
- drain or avoid stagnant water near camp
- inspect after field work

## 8.14 Unsanitary ground and foul-water adjacency

### What it is
Environmental hazard created by the settlement itself through poor placement of waste, carcasses, washing, or latrines.

### Why it matters
This is where environment and public health intersect. Unsafe placement turns ordinary ground into a hazard zone.

### Typical triggers
- latrine downhill toward water source
- graywater pooling in camp core
- carcass scraps near shelter
- fecal contamination near paths
- children/animals moving contamination through camp later

### Gameplay expression
- persistent illness pressure
- smell/foulness morale penalty
- insect/scavenger increase
- reduced attractiveness to recruits
- contaminated work zones

### Main mitigations
- enforce spatial separation
- rotate or close bad waste zones
- cover waste properly
- move washing away from drinking collection point
- keep butchery and refuse out of sleeping core

## 8.15 Resource depletion as environmental pressure

### What it is
Hazard created by overusing the immediate environment: stripping nearby wood, overharvesting forage, muddying water edges, trampling camp ground into unusable muck.

### Why it matters
The site can become progressively harsher even without a dramatic event.

### Typical triggers
- repeated wood gathering too close to camp
- too many feet around water edge
- overgrazed or overused patch later
- no rotation of cut/fetch routes
- no seasonal reserve planning

### Gameplay expression
- longer haul times
- lower-quality gathered material
- reduced local calories/fuel
- more time spent in risky outer zones
- morale drop from drudgery

### Main mitigations
- rotate harvest areas
- maintain secondary caches
- protect key water-access points
- shift camp footprint when needed
- plan fuel reserve before severe weather

---

# 9. Site selection doctrine

Environmental hazard realism begins with site choice.

## 9.1 Early-site evaluation checklist

A candidate camp site should be scored against:

- distance to fresh water
- elevation relative to flood line
- drainage quality
- wind exposure
- lightning exposure
- deadfall overhead
- nearby fuelwood access
- nearby stone/clay/material access
- visibility and animal-path pressure
- insect pressure
- smoke behavior
- room for latrine/waste separation
- room for future expansion

## 9.2 Core rule: good access is not enough

A site with nearby water and wood can still be poor if it also has:
- flood exposure
- stagnant water nearby
- no drainage
- wind tunnel exposure
- dead limbs overhead
- dense insect habitat
- little room to separate living, fire, and waste

## 9.3 Recommended early camp layout logic

Even a primitive camp should separate:

- sleeping zone
- fire/cooking zone
- water storage zone
- refuse/waste zone
- latrine zone
- food processing/drying zone
- fuel reserve zone

The exact distance should depend on terrain and camp size, but the logic should be visible from the start.

---

# 10. Hazard interaction with major systems

## 10.1 NPC simulation
Hazards feed:
- body temperature
- hydration
- fatigue
- morale
- fear/caution
- willingness to accept tasks
- injury and illness
- learning and memory

## 10.2 Task evaluation
Hazards should affect:
- whether a task is legal
- urgency of mitigation tasks
- route choice
- travel time
- expected success
- interruption chance
- whether player orders are obeyed, delayed, or rejected

Examples:
- “Haul wood from outer forest” becomes lower priority during lightning
- “Move seed stock to dry store” spikes during incoming rain/flood risk
- “Dig drainage notch” becomes urgent when camp core is waterlogged

## 10.3 Item/material system
Hazards affect:
- wetness
- contamination
- spoilage
- breakage
- smoke taint
- rot/mold
- fuel usability
- seed viability
- hide/fiber quality

## 10.4 Building/structure system
Hazards affect:
- roof integrity
- wind resistance
- damp resistance
- fire spread vulnerability
- drainage behavior
- ventilation quality
- safe placement rules
- need for maintenance/inspection

## 10.5 Settlement progression
Settlement stage should depend partly on environmental competence:

A site is not truly a **permanent camp** if:
- every storm ruins stores
- sleeping areas remain chronically damp
- the camp floods easily
- sanitation contaminates water
- food is routinely lost to pests/scavengers

A site is not a viable **tiny hamlet** if:
- reserves are repeatedly destroyed by weather
- roles are constantly interrupted by preventable environmental mismanagement
- recruits experience unsafe water, foul ground, smoke-filled shelter, or chaotic storage

## 10.6 Knowledge/discovery
Hazards should generate:
- local caution rules
- seasonal practices
- site memory
- improved construction techniques
- route lore
- institutional norms later

Examples:
- “Do not sleep under this dead pine in wind season.”
- “This gully carries water after upstream rain.”
- “The lower store pit molds seed.”
- “The sheltered west edge keeps fuel dry.”
- “Ticks are worst in the brush strip after late spring rains.”

---

# 11. Hazard lifecycle

## 11.1 Conditions emerge
A hazard can begin because:
- weather changes
- a route or site is inherently risky
- player/NPC behavior creates the danger
- seasonal ecology shifts
- structures deteriorate

## 11.2 Signs appear
The world presents:
- clouds/thunder
- rising water
- foul smell
- repeated bites
- dead branches
- smoke plume
- damp fuel
- visible scavenger activity
- NPC complaints / caution remarks

## 11.3 NPCs interpret
Interpretation depends on:
- perception
- prior experience
- instruction
- current fatigue
- settlement knowledge
- role fit

## 11.4 Response occurs
Possible responses:
- self-preservation override
- automatic retreat from extreme zones
- new mitigation tasks created
- player alert
- reserve-protection priority
- temporary zoning closure
- relocation task chain

## 11.5 Aftermath persists
Even after the event passes, there may be:
- damp damage
- morale cost
- damaged structure
- contamination
- route changes
- hazard memory
- stronger rules or new discoveries

---

# 12. Player-facing representation

## 12.1 The player should see environmental logic

The player does not need detailed meteorology, but should be able to inspect:

- current hazard list
- local zone risk
- reason for risk
- likely consequence
- current mitigations
- who is exposed
- what task would reduce it

## 12.2 Suggested UI outputs
- icons on zones or tiles
- risk color outline for specific hazard types
- NPC warning barks/log entries
- settlement alerts
- storage warnings
- route warnings
- comparative site overlays

## 12.3 Example hazard messages
- “Low ground near stream is waterlogged; move bedding.”
- “Dead branch over shelter raises windfall risk.”
- “Dry grass and gusts make open flame unsafe.”
- “Thunderstorm approaching; exposed ridge work halted.”
- “Smoke accumulation in hut reducing sleep quality.”
- “Ticks common in brush strip; avoid long work there.”
- “Refuse too near sleeping area; scavenger pressure rising.”

---

# 13. Recommended early-game hazard rules

## 13.1 Hazards that should exist in the first playable
- heat
- cold / wetness
- rain / dampness
- unsafe water adjacency
- flooding risk from poor siting
- wind exposure
- smoke burden
- enclosed-combustion poisoning risk
- rodent/scavenger food pressure
- predator-path risk
- unsafe sanitation adjacency
- slip/fall risk on bad terrain
- insect pressure

## 13.2 Hazards that can exist lightly at first
- lightning
- brush fire
- drought
- severe storm damage
- localized treefall

## 13.3 Hazards better left as later extensions
- avalanche
- industrial toxic gas
- mine collapse/gas as a fully separate system
- volcanic events
- earthquakes unless region-specific
- chemical spills
- modern pollution plumes
- advanced occupational dust exposure systems

---

# 14. Seasonal hazard calendar for the early scope

This is for a temperate-biome baseline.

## 14.1 Late winter / cold season
Main pressures:
- cold stress
- wet clothing and bedding
- low forage
- fuel reserve strain
- poor morale from confinement
- frozen/slippery ground later

## 14.2 Spring
Main pressures:
- mud
- flooding / runoff
- unstable paths
- variable temperature
- insect emergence
- damp-storage losses
- seed vulnerability

## 14.3 Summer
Main pressures:
- heat
- dehydration
- thunderstorm/lightning periods
- wildfire/brush-fire risk in dry conditions
- insect load
- food spoilage acceleration
- smoky air during fires

## 14.4 Autumn
Main pressures:
- storm exposure
- wet fuel if reserve not built
- race to secure food/fiber/hide/fuel before cold
- falling branches/wind events
- morale anxiety around preparedness

---

# 15. Structures and environmental mitigation

## 15.1 Structures should reduce specific hazards
Every structure should declare which hazards it mitigates and which it worsens.

Example:
### Debris lean-to
Mitigates:
- wind
- light rain
- sleep exposure somewhat

Does not mitigate:
- lightning
- flood
- major cold without bedding/fire
- enclosed smoke risk if misused

May worsen:
- dampness if sited poorly
- branch-fall risk if built under dead tree
- smoke accumulation if fire managed badly nearby

## 15.2 Critical early mitigation structures
- dry sleeping shelter
- windbreak
- raised bed / bedding platform
- covered fuel store
- covered water store
- raised food cache
- drying rack
- smoking rack with safe placement
- latrine separated from water/living area
- refuse pit/zone
- drainage improvements
- simple fenced/cleared camp edge where useful

## 15.3 Design principle
A structure is not “good” in the abstract.
It is good if:
- it is in the right place
- it is built with suitable materials
- it is maintained
- it is used correctly
- it fits the current season and hazard profile

---

# 16. NPC behavior under hazard

## 16.1 Behavioral modifiers that should matter
- caution
- discipline
- fatigue
- panic threshold
- heat/cold tolerance
- experience in terrain/weather
- role fit
- social responsibility
- obedience to player order vs self-preservation override

## 16.2 Self-preservation override rules
NPCs should refuse or interrupt tasks in **extreme** cases such as:
- active floodwater crossing
- lightning exposure on ridge/open field
- severe smoke in sleeping/cooking enclosure
- visible wildfire encroachment
- acute heat collapse signs
- severe cold exposure without shelter return path
- entering clearly predator-active zone while weak and alone, unless dire need or explicit risk-tolerant policy

## 16.3 Skill effects
Relevant skills/interests may include:
- campcraft
- weather reading
- route planning
- fire handling
- water handling
- animal awareness
- sanitation discipline
- shelter maintenance
- hazard response
- field observation

These should not make NPCs invulnerable. They should make them **less stupid** in dangerous conditions.

---

# 17. Knowledge and memory rules

## 17.1 Local hazard memory
The settlement should retain specific remembered facts:

- this hollow floods after hard rain
- this tree sheds branches in wind
- this stream is muddy after storms
- this store pit stays cool but gets damp
- this meadow is insect-heavy in warm months
- this ridge gets first thunder exposure
- this path is safe in dry weather but slippery after rain

## 17.2 Confidence states
Hazard knowledge should have confidence levels:
- rumored
- observed once
- repeatedly confirmed
- institutional rule

## 17.3 Mislearning must be possible
NPCs can draw wrong conclusions:
- blaming the wrong water source
- overgeneralizing one safe route
- ignoring upstream rain
- assuming smoke inside a hut is “normal”
- thinking scavenger theft is random rather than storage-related

The knowledge system should allow later correction.

---

# 18. Settlement-stage hazard expectations

## 18.1 Lone survivor
Main hazards:
- exposure
- thirst
- bad camp placement
- fatigue under weather stress
- unsafe water
- injury on bad ground
- animal/scavenger threat
- fire failure

## 18.2 Primitive camp
Main hazards:
- dampness
- food loss
- smoke burden
- sanitation negligence
- storage loss
- weather damage to minimal structures

## 18.3 Permanent camp
Main hazards:
- flood/drainage consequences become more expensive
- poor waste layout starts causing chronic disease burden
- pests/scavengers target stores
- more people means more smoke, waste, and water demand
- structure fire becomes more serious

## 18.4 Tiny hamlet
Main hazards:
- camp mislayout scales into settlement dysfunction
- recruit dissatisfaction with unsafe conditions
- reserve loss becomes multi-person crisis
- work specialization is disrupted by recurring environmental incompetence
- environmental control becomes a true institutional burden

---

# 19. Hazard-response tasks

The task layer should be able to generate tasks such as:

- move bedding to dry shelter
- bring extra water before heat peak
- rest in shade
- secure roof covering before storm
- move seed to dry cache
- inspect stream level
- extinguish unsafe edge fire
- clear brush around hearth
- relocate food away from sleeping area
- dig shallow drainage swale
- cut/clear dead branch near shelter
- move butchery away from camp core
- inspect for bites after brush work
- close smoke-heavy hut for sleeping and redirect use
- haul critical goods to higher ground
- establish alternate route after washout

---

# 20. Policy layer hooks

Later, the player should be able to set policies such as:
- avoid midday heavy labor in heat
- no storm exposure on ridges
- no fire use during high wind
- prioritize dry-fuel reserve
- minimum water reserve before long task chains
- animal-proof food storage preference
- mandatory post-field inspection for bites in high-risk season
- keep waste and carcass handling outside living ring
- evacuate low storage first during flood alert

These policies should emerge from learned experience and settlement knowledge.

---

# 21. First-playable minimum subset

For the very first implementation of this system, the minimum useful hazard set is:

- cold / wet exposure
- heat / dehydration pressure
- rain-driven dampness
- poor drainage / flood-prone siting
- smoke burden
- enclosed-combustion poisoning risk
- rodent/scavenger food pressure
- predator-path risk
- unsafe sanitation adjacency
- slip/fall risk on bad terrain

That is enough to make site choice, camp layout, timing, and storage matter.

---

# 22. Open design questions

These are still worth deciding later:

## 22.1 Region specificity
Will hazards remain biome-generic, or will each map/region have unique hazard packages?

## 22.2 Weather forecasting depth
How much can the player know in advance?
- only visual cues
- simple forecast tendencies
- formal weather knowledge later

## 22.3 Animal danger intensity
Should predators be:
- mostly deterrence and food theft
- rare lethal events
- frequent tactical threats

## 22.4 Fire simulation depth
How detailed should fire spread be in the early game?
- local only
- terrain/wind aware regional spread
- full landscape fire model later

## 22.5 Disease linkage
How directly should vector exposure translate into illness in the early slice?
- mostly irritation/sleep impact
- moderate disease pressure
- strong endemic disease simulation

---

# 23. Recommended next companion documents

This hazard layer is strongest when paired with:

1. **Food Safety / Water Safety Spec**  
   to define contamination, safe handling, boiling, settling, storage hygiene, and foodborne/waterborne disease pathways in detail.

2. **Weather / Season System Spec**  
   to define how temperature, rainfall, storm risk, wind, and seasonal patterns are generated and communicated.

3. **Map / Biome / Region Generation Spec**  
   to define how terrain, vegetation, hydrology, and animal ecology produce different hazard profiles.

4. **Fire / Smoke System Spec**  
   if you later want wildfire, indoor smoke, and hearth venting depth beyond the baseline here.

---

# 24. Short conclusion

Environmental hazards should make the world feel like a real place rather than a neutral production board.

A good camp is not merely a place with enough nearby resources.  
It is a place where:

- water can be reached without living in flood danger
- wind, damp, and smoke are managed
- food and seed can survive weather and pests
- waste does not poison the living core
- routes remain usable across seasons
- people learn where not to sleep, work, store, and build

That is the purpose of this system.

It turns terrain, weather, ecology, and settlement layout into meaningful survival and civilization pressure.

---

# References

- [R1] CDC, *Heat and Outdoor Workers*  
  https://www.cdc.gov/heat-health/risk-factors/heat-and-outdoor-workers.html

- [R2] CDC/NIOSH, *Heat-related Illnesses*  
  https://www.cdc.gov/niosh/heat-stress/about/illnesses.html

- [R3] CDC/NIOSH, *Cold and Work: Types, Causes, Preparation*  
  https://www.cdc.gov/niosh/cold-stress/about/index.html

- [R4] CDC, *Preventing Hypothermia*  
  https://www.cdc.gov/winter-weather/prevention/index.html

- [R5] NOAA / National Weather Service, *Flood Safety and Preparedness*  
  https://www.weather.gov/afc/FloodSafety

- [R6] NOAA / National Weather Service, *Floods*  
  https://www.weather.gov/media/bis/Floods.pdf

- [R7] NOAA / National Weather Service, *When a Safe Building or Vehicle is Nearby*  
  https://www.weather.gov/safety/lightning-outdoors

- [R8] NOAA / National Weather Service, *Backcountry Lightning*  
  https://www.weather.gov/media/safety/backcountry_lightning.pdf

- [R9] CDC/NIOSH, *Wildland Fire Smoke*  
  https://www.cdc.gov/niosh/outdoor-workers/about/wildfire-smoke.html

- [R10] CDC, *How Wildfire Smoke Affects Your Body*  
  https://www.cdc.gov/wildfires/risk-factors/index.html

- [R11] CDC, *Carbon Monoxide Poisoning Basics*  
  https://www.cdc.gov/carbon-monoxide/about/index.html

- [R12] CDC, *What to Do to Protect Yourself During a Power Outage*  
  https://www.cdc.gov/natural-disasters/response/what-to-do-protect-yourself-during-a-power-outage.html

- [R13] CDC, *Preventing Tick Bites*  
  https://www.cdc.gov/ticks/prevention/index.html

- [R14] CDC, *How to Prevent Mosquito and Tick Bites*  
  https://www.cdc.gov/vector-borne-diseases/prevention/index.html

- [R15] NPS, *Bear Safety: Storing Food*  
  https://www.nps.gov/articles/bearsafetyfood.htm

- [R16] NOAA / National Weather Service, *High Wind Safety Rules*  
  https://www.weather.gov/mlb/seasonal_wind_rules

- [R17] EPA, *Wood Smoke and Your Health*  
  https://www.epa.gov/burnwise/wood-smoke-and-your-health
