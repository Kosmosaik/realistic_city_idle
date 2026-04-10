---
title: "Realistic Idle City - Animals / Animal Traction / Carts / Wagons Spec"
version: "v0.1"
date: "2026-04-09"
scope:
  - "Bridges tiny hamlet into agrarian village and market-town transport"
  - "Covers working animals, pack use, draft use, carts, wagons, harnessing, fodder burden, welfare, maintenance, and transport economics"
  - "Realism-first, minimal-graphics, top-down colony simulation"
assumptions:
  - "Earth-like setting"
  - "Temperate starting region"
  - "Already-domesticated working stock enter mainly through migrants, trade, rescue, inheritance, or exchange rather than being newly domesticated by the starter colony"
  - "Player leads through policies, zones, priorities, and bounded direct orders"
---

# 1. Purpose of this document

This document defines how **working animals, animal traction, carts, and wagons** should function in the game as a realism-based progression layer between the early hamlet and later village / market-town economy.

It is not a generic “mount unlock” document.

It exists to answer questions such as:
- when animal transport becomes rational
- which animals are plausible for which jobs
- why pack transport appears before wheeled transport in many cases
- what harnessing, fodder, water, training, stabling, roads, and repair burdens come with animal power
- what the colony must build before animal traction is truly reliable
- how carts and wagons change labor, logistics, markets, and settlement scale

This spec is meant to plug into the existing stack:
- settlement progression
- agriculture & domestication
- logistics / hauling / storage flow
- infrastructure / roads / paths
- trade / market / exchange
- village craft / workshop specialization
- water / sanitation / utilities
- defense / security
- governance / administration

---

# 2. Core design stance

## 2.1 Animal power is a major settlement threshold

Animal traction is not just “faster hauling.”

It is one of the first true multipliers that can:
- expand field area
- increase haul radius
- move heavier construction materials
- reduce repeated porterage
- support regular market exchange
- enable specialized workshop supply chains
- increase water, fuelwood, harvest, and manure movement

The original design already places **animal power** at the agrarian village threshold and ties the next step into carts, roads, and markets. This spec keeps that structure. fileciteturn94file0 fileciteturn94file4

## 2.2 Early defense of realism

A realistic system should reject these shortcuts:
- animals do not work for free
- animals do not live off “ambient grass” all year
- a cart is not just extra inventory slots
- roads matter
- harness fit matters
- training matters
- hooves, sores, lameness, dehydration, and fatigue matter
- the wrong animal for the wrong job should perform badly or become unsafe

## 2.3 Pack transport should appear before full cart culture in many runs

This is important.

In rough, wooded, marshy, steep, sandy, or narrow-path environments, **pack animals often become useful before carts**. FAO notes that animal transport can be either packing or carting, and that packing remains important where terrain is too steep, rocky, sandy, or narrow for wheeled transport. citeturn110139view1turn110139view2

That means a believable progression is often:
1. human porterage
2. hand drags / litters / sledges in limited contexts
3. pack animals
4. simple carts on improving paths
5. larger carts / wagons on maintained lanes and roads

## 2.4 This is not yet a “cavalry and carriage city” system

Scope is weighted toward:
- farm traction
- fuel / water hauling
- crop movement
- building material hauling
- village-to-market transport
- service and repair burden

Not yet toward:
- elite carriage culture
- high-speed road networks
- coach stations
- formal freight companies
- rail replacement

---

# 3. Real-world grounding that matters for the design

A few facts should anchor the simulation.

FAO describes draught animal power as important for ploughing, planting, weeding, transport, water lifting, milling, logging, land excavation, and road construction, and notes that cattle, buffaloes, horses, mules, donkeys, and camels are all used in different regions. citeturn110139view0turn110139view1

FAO also notes that animal-drawn transport is especially valuable for short rural haulage over varied terrain, and that pack transport remains important where wheeled vehicles are constrained. citeturn110139view1turn110139view2

FAO’s pack-animal guidance also gives practical traction design cues: oxen are usually worked in yokes; equines should use collar-type harnessing rather than yokes; cart center of gravity should sit over the axle; and poorly designed axles, bearings, and wheels are common failure points. citeturn110139view2

WOAH’s welfare code for working equids reinforces that working horses, donkeys, and mules are livelihood animals whose welfare depends on feed, water, health, handling, harness, and safe working contexts. citeturn635398view0

Purdue’s equine nutrition material reinforces two useful mechanical truths for the game: horses are primarily forage-digesters, they need dependable clean water, and feed/water shortage reduces intake and raises health risk. citeturn635398view2

---

# 4. Scope boundaries

## 4.1 Included in this spec
- pack animals
- draft animals for field traction
- draft animals for haulage
- carts and wagons
- yokes, collars, traces, drawbars, singletrees / swingletrees, eveners conceptually
- animal training and suitability
- hauling economics
- fodder, water, bedding, manure, stabling, and care burden
- traffic / route / crossing realism at village scale
- animal-linked logistics jobs and roles

## 4.2 Excluded or only lightly touched
- mounted warfare
- breeding genetics in depth
- advanced veterinary medicine
- large-scale pastoral nomad systems
- industrial truck replacement logic
- modern mechanized freight

---

# 5. Progression ladder

## 5.1 Recommended in-game ladder

### Stage A — No animal transport
- Human back / shoulder / arm carrying only
- Very small effective haul radius
- Water and fuel are brutal labor bottlenecks
- Construction and harvest movement are slow

### Stage B — Pack support
- One or more pack animals carry water, fuelwood, gathered produce, and light trade goods
- Best in rough terrain or before decent roads exist
- Major drudgery reduction without needing axle/wheel technology

### Stage C — Light traction and field support
- Small plows, harrows, sledges, or travois-like drags in suitable contexts
- Animal becomes useful in cultivation, timber dragging, and short heavy pulls

### Stage D — Simple cart culture
- Single-animal or pair-draft carts emerge
- Requires wheelmaking, axles, repair capacity, and at least modest road/path improvement
- Enables bulk movement of harvest, clay, timber, stone, charcoal, manure, and traded goods

### Stage E — Wagon and service economy
- Larger wagons, repair shops, harness shops, wheelwrights, stable yards, roadside depots, and market transport routines
- Strong dependence on road maintenance, spare parts, fodder planning, and skilled handlers

This sequence fits the broader design progression where animal power, carts, roads, and markets become the big middle-game expansion. fileciteturn94file0 fileciteturn94file2

---

# 6. Species families and realistic job fit

## 6.1 Main working-animal families to model

### Donkeys
Strengths:
- hardy
- useful for pack work
- practical for water, fuelwood, and moderate cart work
- good in narrow or rough paths
- relatively low feed demand compared with larger animals

Weaknesses:
- lower pulling capacity than larger ox or horse teams
- poorer fit for very heavy plowing or large freight compared with bigger draft species
- welfare often degrades when overloaded or poorly harnessed

Best uses:
- pack water and fuel
- short-haul produce transport
- small cart transport
- hill or rough-ground service

### Horses
Strengths:
- faster travel
- better for time-sensitive movement and lighter-to-moderate road haulage
- strong fit for collar harness and wheeled transport

Weaknesses:
- generally more demanding in feed quality and management
- can be less ideal than oxen in some heavy slow-draft conditions
- require careful feeding routines and water support

Best uses:
- moderate haulage on passable roads
- wagon transport
- some field traction depending on region/system
- messenger and mobility roles later

### Mules
Strengths:
- hardy and sure-footed
- strong transport value in mixed terrain
- good pack and cart animals
- often excellent compromise between donkey toughness and horse size/work output

Weaknesses:
- availability depends on horse-donkey breeding base
- reproduction constraints make them more trade-dependent as an acquired asset

Best uses:
- pack routes
- cart hauling
- hill transport
- mixed farm transport

### Oxen / draft cattle
Strengths:
- historically common slow heavy pullers
- strong fit for plowing and heavy draft
- can often be integrated into mixed farming systems with manure output and broader cattle husbandry
- yoke-based traction is common and realistic

Weaknesses:
- slower than equines
- require cattle-management competence
- yoke fit, neck/withers pressure, sores, and training matter
- can be cumbersome in narrow or fast transport contexts

Best uses:
- plowing and tillage
- heavy short-to-medium haulage
- log dragging
- construction hauling
- pair draft for larger carts

### Buffalo / camels / other regional animals
Keep in database as biome/region-specific later expansions, not default temperate-start assumptions.

## 6.2 Species-job matrix

Use a matrix like this in the final data model:
- pack suitability
- plow suitability
- cart suitability
- wagon suitability
- rough-terrain suitability
- wet-ground suitability
- speed
- endurance
- feed demand
- water demand
- cold tolerance
- heat tolerance
- temperament / handling difficulty
- training duration
- infrastructure dependence

---

# 7. Working-animal suitability is not just species

Each individual animal should matter.

## 7.1 Animal stat families

### Physical
- body mass
- strength / pull potential
- endurance
- gait speed
- sure-footedness
- hoof / foot resilience
- heat tolerance
- cold tolerance
- injury resilience

### Health / condition
- body condition score
- hydration status
- hoof condition
- skin / harness sore status
- parasite load
- respiratory burden
- digestive stability
- reproductive status where relevant
- age / maturity

### Behavioral
- calmness
- responsiveness to handler
- noise sensitivity
- crowd sensitivity
- startle tendency
- pair compatibility
- stubbornness / willingness

### Training
- halter training
- leading
- tether tolerance
- pack tolerance
- yoke / collar tolerance
- line / rein response
- backing / turning
- start / stop obedience
- implement familiarity
- road confidence

## 7.2 Readiness gates

A colony should not be able to buy one animal and instantly receive full value.

Useful readiness gates:
- animal is mature enough
- handler is trained enough
- harness or yoke fits correctly
- work type is trained
- route is suitable
- feed / water reserve exists
- night shelter or secure pen exists
- hoof / skin condition acceptable

---

# 8. Acquisition pathways

## 8.1 Realistic acquisition routes

Consistent with the agriculture/domestication direction already established, early working animals should usually enter through:
- trade purchase
- bridewealth / alliance gift / social exchange in some settings
- migrant families arriving with stock
- rescue / stray capture with later social claim issues
- loan / hire from another settlement
- offspring from already-kept domestic stock later

## 8.2 What should usually not happen

The starter colony should **not** be able to turn local wild deer or similar fauna into reliable draft animals in a short arc. That would break the domestication realism already established.

---

# 9. Housing and care burden

## 9.1 Minimum care reality

Working animals create a daily maintenance bill in:
- feed / forage
- water
- supervision
- secure tethering or enclosure
- weather protection
- hoof / foot care
- grooming / cleaning
- harness inspection
- wound monitoring
- manure handling

This is one of the design’s main realism checks: animal power reduces one labor bottleneck by creating several others.

## 9.2 Housing ladder

### Open tether / picket (temporary)
Good for:
- short supervised rest
- low-capital early use

Bad for:
- weather exposure
- entanglement risk
- theft risk
- ground damage
- manure concentration

### Simple pen / paddock
Good for:
- secure overnight holding
- group management
- reduced wandering

Needs:
- fencing
- water access
- feed access
- dung removal routine

### Lean-to / shed
Good for:
- wind and rain shelter
- tack storage nearby
- recovery and inspection

### Stable / barn zone
Needed as work scale rises:
- stall or bay organization
- fodder store
- tack / harness rack
- grooming / treatment area
- manure bay
- water point
- quarantine corner later

## 9.3 Bedding and sanitation

Bedding and ground condition should matter.

Poor conditions increase:
- sores
- hoof rot / foot problems depending on species and climate
- parasite pressure
- resting discomfort
- foul air and moisture burden

Good conditions require:
- dry standing area
- drainage
- manure removal
- bedding replacement or dry litter management

---

# 10. Feed, water, and seasonal burden

## 10.1 Core realism

Animal power is only as sustainable as the colony’s feed and water base.

This is especially important in winter, drought, late spring scarcity, or long workdays.

## 10.2 General feed logic

### Equines
Use rules consistent with equine nutrition basics:
- forage is the base
- concentrate is support for higher work demand, not the whole diet
- feed should be split rather than dumped in one large ration when grain is used
- clean water is essential and intake rises with work and heat

Purdue notes horses are primarily adapted to forage digestion, should not be overloaded with large concentrate meals, and require dependable access to clean water. citeturn635398view2

### Oxen / draft cattle
Use cattle-style roughage-heavy logic:
- pasture, browse, hay, straw plus better fodder where available
- work output drops sharply when body condition declines
- yoke work on poor nutrition should cause faster fatigue and slower recovery

## 10.3 Seasonal feed burden model

### Spring
- pasture improves
- work demand rises during land prep
- mud and hoof wear may increase

### Summer
- field work and hauling can peak
- heat stress and water demand rise
- dry pasture may decline later in season

### Autumn
- haul harvest
- conserve fodder
- body condition management becomes critical before winter

### Winter
- greatest feed reserve burden
- less grazing
- frozen water issues in cold climates
- road traction and exposure problems may rise

## 10.4 Water as a transport paradox

Working animals reduce human water-hauling burden, but they also **consume water themselves**, so a poor water site can make animal ownership irrational until supply improves.

---

# 11. Training system

## 11.1 Training categories

### Basic handling
- haltering / halter acceptance
- leading
- standing tied
- grooming tolerance
- foot handling

### Work introduction
- tolerate yoke, collar, saddle pack, or traces
- respond to voice / rein / line / goad / handler cues
- pull light load
- stop and back safely
- turn without panic

### Job specialization
- plow work
- cart work
- pack routes
- market traffic
- bridge / crossing confidence
- pair draft coordination

## 11.2 Training time and maturity

Training should take meaningful time.
A newly acquired juvenile or poorly trained adult should require:
- acclimation
- bonding/handling
- light work introduction
- gradual loading
- route familiarization

## 11.3 Pair compatibility

For pair-draft systems, compatibility matters:
- similar pace
- similar size / strength where required
- low mutual aggression
- stable response to commands

Poorly matched teams should waste effort and raise accident risk.

---

# 12. Harnessing, yokes, and fit

## 12.1 This system should be species-specific

One of the easiest realism mistakes is using one generic harness model for all animals.

That should not happen.

FAO explicitly distinguishes bovines and equines here: oxen are generally worked with yokes, while equines should use collar-based harnessing; using yokes on equines can cause injury. citeturn110139view2

## 12.2 Core equipment families

### For bovines / oxen
- neck yoke or regional yoke style
- bows / straps / padding depending design
- central drawbar or pole connection
- head control system if modeled

### For equines
- collar or breast-collar style depending load and vehicle
- hames / straps / traces conceptually
- breeching or braking support for vehicle control on descents
- shafts for single-animal carts or pole and team arrangement for pairs

### For pack animals
- pack saddle or frame
- padding
- balanced panniers / bags / baskets / skins / jars
- lashing and anti-rub management

## 12.3 Fit and welfare penalties

Bad fit should cause:
- chafing
- sores
- reduced pull efficiency
- refusal / stress
- unsafe braking or turning
- long-term lameness / shoulder / neck problems

## 12.4 Harness maintenance

Harnessing is not permanent.
Model wear in:
- leather / fiber straps
- stitching / lashings
- wood yokes
- pins / hooks / chains / rings later
- padding compression

---

# 13. Pack transport system

## 13.1 Why pack transport matters

Pack transport should be a valid middle layer, not just a failed cart.

FAO highlights donkeys carrying produce, firewood, and water, with simple padded frames and locally made containers. citeturn110139view2

## 13.2 Good pack cargoes
- water containers
- seed stock in protected bags
- food baskets
- fuelwood bundles
- fiber bundles
- hides / leather / cloth
- medicine / urgent light goods
- market samples / high-value low-bulk goods

## 13.3 Bad pack cargoes
- unstable liquids in poor containers
- oversized logs
- sharp loads without protection
- asymmetrical weight
- fragile pottery without padding
- high center-of-mass loads on rough routes

## 13.4 Pack design rules
- left/right balance matters
- top load must be secured
- rubbing and pressure points matter
- route roughness matters
- steep descents and narrow vegetation corridors matter

---

# 14. Carts and wagons

## 14.1 Distinction

### Cart
- usually lighter
- often two wheels
- easier to maneuver
- lower build requirement
- often earlier unlock

### Wagon
- heavier
- usually four wheels
- more stable over certain loads but more infrastructure-dependent
- stronger road and repair demands
- more suitable for bulk or longer-distance haulage on maintained routes

## 14.2 Design logic

Realistic cart / wagon value depends on:
- deadweight
- axle quality
- wheel quality
- bearing friction
- center of gravity
- load stability
- road condition
- species used
- harness geometry

FAO’s guidance explicitly notes that bearings, axles, and wheels are critical and common breakdown points, and that cart center of gravity should sit over the axle so neck weight on the animal remains low. citeturn110139view2

## 14.3 Simple capacity bands for game design

Do not treat published load examples as universal laws, because terrain, speed, animal size, road condition, and vehicle design matter.

But for design purposes, broad bands make sense:
- single pack donkey: meaningful increase over human porterage, but limited bulk
- single donkey cart: significant household / market improvement
- single ox cart: heavy village hauling becomes viable
- pair ox cart: major construction / crop / manure / market movement
- horse or mule cart/wagon: stronger speed-distance value where road conditions justify it

FAO TECA provides example capacities for single-donkey, single-ox, and pair-ox carts and notes the importance of low neck load, good axle design, and moderate road structure. Use these as balance anchors, not as fixed world laws. citeturn110139view2

## 14.4 Vehicle subcomponents to model

### Structure
- frame
- bed/platform
- side rails / racks
- seat or standing position

### Running gear
- axle
- bearings / bushings
- wheels
- tires / metal band / rawhide / solid wood depending era and region

### Draft connection
- drawbar / shafts / pole
- singletree / doubletree / evener equivalents if modeled
- hitch hardware

### Safety / control
- brakes later if modeled
- wheel chocks
- tie-down points
- animal-control geometry for downhill work

## 14.5 Deadweight matters

A badly designed vehicle should be a real trap.
Too-heavy carts:
- waste animal power
- sink in soft ground
- break more often
- encourage overloading
- increase road damage

---

# 15. Roads, paths, and crossings

## 15.1 Strong dependency on infrastructure

The value of carts/wagons should be tightly linked to the infrastructure spec.

### Good for carts/wagons
- passable width
- low stump density
- moderate grades
- drainage handled
- stable stream crossings
- firm surfaces during wet periods

### Better for pack animals than carts
- rocky paths
- narrow forest trails
- boggy zones
- steep slopes
- frequent fallen timber or obstacles
- field margins and soft ground after rain

## 15.2 Seasonal route variation

A route can shift between:
- pack only
- light cart only
- full wagon-capable
- temporarily closed

based on:
- mud
- snow/ice
- flood damage
- rut depth
- bridge/crossing damage
- vegetation encroachment

## 15.3 Traffic and congestion

At market-town scale, animal traffic should create:
- lane wear
- manure concentration
- delay at gates / crossings
- conflict between pedestrians, animals, and vehicles
- need for staging yards and hitching areas

---

# 16. Work categories

## 16.1 Field traction
- ard / plow pulling
- harrow pulling
- field drag
- seedbed preparation support
- haul seed and tools to field

## 16.2 Domestic / settlement hauling
- water
- fuelwood
- food stocks
- clay
- dung/manure
- bedding material
- reeds / thatch
- stone / timber

## 16.3 Workshop and construction hauling
- charcoal
- ore later
- lime feedstock
- bricks / tiles later
- heavy beams
- workshop stock transfer

## 16.4 Trade and market hauling
- produce to market
- salt / tools / cloth / pottery inward
- bulk exchange between village and town
- service hauling for hire

## 16.5 Specialized later uses
- logging
- water lifting
- mill support in some systems
- roadwork / earth moving

FAO explicitly notes that animal power can support not only farm work and transport but also water-lifting, milling, logging, land excavation, and road construction. citeturn110139view0

---

# 17. Labor and economic consequences

## 17.1 What animal traction actually changes

### Human labor saved
- fewer porter trips
- fewer water/fuel trips by people
- less field labor per area when plows are viable
- less manual drag effort in construction

### New labor created
- herding / tending
- fodder cutting and storage
- harness making and repair
- wheelwright and axle repair
- grooming / watering / cleaning
- manure removal
- training
- veterinary attention / first aid

## 17.2 Surplus logic

Animal power should feel transformative only when the colony can already support it materially.

That means the true prerequisites are not just “have animal.”
They are:
- feed reserve
- water reserve
- handler skill
- route maintenance
- housing/security
- repair support
- governance over shared use and scheduling

## 17.3 Hire economy and service roles

By late village / market-town scale, working animals can create new roles:
- hauler-for-hire
- cart service operator
- teamster
- drover
- stable keeper
- harness maker
- wheelwright
- veterinary helper / animal healer
- market carrier

---

# 18. Shared ownership, allocation, and law

## 18.1 Ownership models

The allocation spec should support multiple forms:
- private family animal
- household-shared animal pair
- communal draft team
- hired transport team
- elite / administrative transport stock later

## 18.2 Governance questions the colony must answer
- who can schedule a working animal
- which loads are priority during scarcity
- who pays feed costs if the animal is communal
- who is liable for damage or injury
- whether sick/tired animals can be forced to work
- whether breeding stock and working stock are separated
- what counts as abuse or negligent overload

## 18.3 Reserve rules

Animals should be integrated with reserve policy:
- emergency water hauling priority
- harvest priority during narrow windows
- seed and food reserve transport priority
- fire or flood evacuation priority

---

# 19. Welfare and failure states

## 19.1 Major welfare indicators to surface

Borrowing from WOAH’s practical welfare framing for working equids, useful outcome indicators include:
- body condition
- hydration state
- wounds / sores
- gait / lameness
- abnormal behavior / reluctance
- reduced feed or water intake
- dullness / lethargy
- fear and avoidance around work gear or routes citeturn635398view0

## 19.2 Common working-animal failure states
- dehydration
- overwork fatigue
- heat stress
- cold stress / exposure
- harness sores
- hoof / foot injury
- lameness
- digestive upset from poor feeding changes
- panic and runaway incident
- vehicle overturn
- traffic / crossing accident
- collapse under overload
- theft or escape

## 19.3 Overload logic

The game should avoid fake precision, but overload must exist.

Overload should depend on:
- species and size
- body condition
- training
- route grade
- surface softness
- weather / heat
- vehicle deadweight
- speed demanded
- duration of pull
- harness fit

A “same load everywhere” rule would be unrealistic.

---

# 20. Buildings and infrastructure unlocked by animal traction

## 20.1 Core structure set
- tether posts / hitching rail
- animal pen / paddock
- simple stable or lean-to
- barn / draft-animal shed
- fodder store / hay loft
- tack and harness rack
- cart shed
- wheel repair bay
- wagon repair shop later
- manure bay / compost area where appropriate
- watering trough / dedicated water point
- loading platform / ramp later
- market hitching yard

## 20.2 Workshop support chain

Animal transport creates demand for:
- rope / strap making
- leatherwork
- woodworking
- wheelwrighting
- smithing for metal fittings later
- saddlery / harness repair
- road maintenance crews

---

# 21. NPC roles and skills

## 21.1 Roles
- herder
- animal handler
- plowman / teamster
- carter / wagoner
- pack-route porter / driver
- stable keeper
- farrier-like hoof-care role later
- harness maker / saddler
- wheelwright
- animal healer / veterinary helper

## 21.2 Skills to track
- animal handling
- animal health observation
- harnessing / yoking
- driving / team control
- route judgment
- load balancing
- hoof / foot care
- fodder planning
- stable hygiene
- cart maintenance
- wheel repair
- breeding selection later

## 21.3 Interest and aptitude examples
- interest: animals, travel, trade, outdoor work, repair
- aptitude: calm handling, spatial reasoning, patience, strength, observation, coordination

---

# 22. Data-model guidance

## 22.1 Animal record fields
- species
- sex / reproductive status if relevant
- age class
- mature_work_ready flag
- body size class
- body condition
- hydration trend
- hoof / foot condition
- skin sore status
- parasite burden
- disease flags
- temperament profile
- training profile
- owner / steward / communal assignment
- preferred jobs
- forbidden jobs
- current workload meter
- last rest time
- current harness fit grade
- social compatibility / pair partner if paired

## 22.2 Vehicle record fields
- vehicle type (pack frame / cart / wagon)
- draft requirement
- empty weight
- safe cargo volume
- safe cargo mass band
- axle type
- wheel type
- bearing quality
- brake / chock support
- condition
- route suitability band
- maintenance interval
- repair skill required

## 22.3 Harness record fields
- harness family
- compatible species
- fit size band
- padding grade
- wear state
- break risk
- sore risk modifier
- control quality

## 22.4 Route suitability fields
- width
- grade
- roughness
- mud susceptibility
- crossing risk
- obstruction level
- seasonal closure risk
- cart suitability tier
- wagon suitability tier
- pack suitability tier

---

# 23. First-playable and first-village recommendations

## 23.1 First meaningful animal layer

For the first expansion beyond the hamlet slice, the cleanest realistic introduction is:
- donkey or mule pack transport
- or a single light cart animal if the settlement already has better paths and woodworking

This keeps the step understandable without jumping immediately into pair-ox plowing, wheelwright shops, and market freight.

## 23.2 First village traction package

A good first full package is:
- one pair of oxen or equivalent heavy draft animals
- one yoke and field traction set
- one basic farm cart
- one paddock + shelter
- one fodder reserve system
- one trained handler
- one maintenance / repair path

## 23.3 First market-town traction package
n- multiple teams or mixed species
- cart shed and repair bay
- wheelwright support
- road maintenance policy
- market hitching / staging area
- transport scheduling rules

---

# 24. Anti-abstraction rules that keep it believable

To preserve realism, do not reduce this system to:
- “+X carry weight globally”
- “horse = fast, ox = strong” and nothing else
- “cart ignores road condition”
- “animals self-feed automatically”
- “injured animals work until HP reaches zero”

The simulation should always remember:
- animals are living workers
- transport value depends on terrain and infrastructure
- training and fit matter
- animal power expands labor capacity, but only when supported by feed, water, shelter, and craft maintenance

---

# 25. Recommended next companion docs

The cleanest follow-on docs after this are:
1. **Metallurgy / Mining / Fuel Chain Spec**
2. **Mills / Water Power / Mechanized Workshops Spec**
3. **Utilities / Wells / Water Supply Infrastructure Expansion Pack**
4. **Transport Content Pack**
5. **Village Economy / Service Occupations Expansion**

---

# 26. Short conclusion

Animal traction should feel like one of the first times the colony truly breaks past human muscle alone.

But it should never feel free.

A believable system will show that:
- pack animals reduce drudgery before roads are ready
- carts and wagons reward road, wheel, and repair investment
- plow animals expand field scale only if feed and handler skill support them
- trade grows when transport becomes regular and trustworthy
- animals are not tools with hit points; they are living workers with needs, limits, and value

That is what will make the jump from hamlet to village and market-town feel earned.
