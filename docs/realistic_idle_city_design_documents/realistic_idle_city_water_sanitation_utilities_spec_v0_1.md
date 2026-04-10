---
title: "Realistic Incremental/Idle Colony-to-City Game Design Document"
subtitle: "Water / Sanitation / Utilities Spec"
version: "v0.1"
date: "2026-04-09"
scope:
  - "Bridges the early-slice design stack into later settlement and civic utility development"
  - "Grounded in prior project documents plus public-health and water-infrastructure references"
  - "Earth-like temperate setting unless later changed"
author: "OpenAI / ChatGPT"
---

# 1. Purpose of this document

This document defines the **water / sanitation / utilities layer** for the colony-to-city project.

It exists to answer a simple realism question:

> How does a settlement move from one NPC carrying questionable water by hand and using ad hoc waste practices, to a settlement with reliable water access, safe sanitation, drainage, washing, wastewater handling, and eventually true public utilities?

This is not only a building list.

It is a **service-chain document** that covers:
- water sources
- water access and carrying
- water treatment
- water storage
- washing and hand hygiene
- wastewater and greywater
- excreta containment and separation
- drainage and runoff
- wells
- cisterns and water harvesting
- pump and distribution systems later
- wastewater and sewerage later
- staffing, maintenance, breakdowns, and public-health consequences

This document is meant to connect to:
- the early game bible
- item & material bible
- process bible
- building & structure bible
- settlement progression spec
- health / injury / care spec
- environmental hazard spec
- food / water safety spec
- logistics / hauling / storage flow spec
- governance / administration / law spec
- infrastructure / roads / paths spec

---

# 2. Core interpretation

Water and sanitation are not side systems.

They are **foundational survival systems** and later become **civil infrastructure systems**.

In the early game, the main question is:
- can one person get enough reasonably safe water, stay clean enough, and keep waste away from camp and water?

In the hamlet and village game, the main question becomes:
- can the settlement provide enough water, with enough regularity and cleanliness, without wasting too much labor or poisoning itself?

In the town and city game, the main question becomes:
- can the settlement operate a true utility network with source protection, treatment, storage, distribution, wastewater collection, and maintenance?

This layer strongly influences:
- health
- morale
- labor availability
- settlement growth
- food preparation safety
- fire safety
- workshop viability
- agriculture
- trade
- governance legitimacy
- urban density limits

---

# 3. Design doctrine for this layer

## 3.1 Water is a chain, not an item
Water quality and utility depend on the full chain:
- source
- collection
- transport
- treatment
- storage
- handling
- point of use

A clean source can still become unsafe during carrying or storage.
A treated batch can become unsafe again if stored badly.
A settlement can have lots of water and still have poor water service if access is slow, queues are long, containers are dirty, or washing areas are contaminated.

## 3.2 Sanitation is also a chain
Sanitation is not just “build toilet.”
It includes:
- where excreta go
- how they are separated from people
- what insects/animals can reach them
- how runoff moves near them
- how they are emptied or abandoned
- how nearby water is protected
- where wastewater goes
- what happens during floods or heavy rain

## 3.3 Utilities are services, not scenery
A well, cistern, latrine, drain, pipe, or pump is not useful by existing alone.
Each asset only matters if it contributes to a working service:
- enough water
- safe enough water
- reachable water
- manageable wastewater
- low enough disease pressure
- enough reliability to support settlement growth

## 3.4 Labor matters
Before mechanized utilities, water and sanitation consume large amounts of labor:
- fetching
- carrying
- storing
- boiling
- vessel cleaning
- draining wash areas
- digging latrines
- maintaining pits
- repairing linings
- cleaning channels
- emptying waste
- carrying buckets or containers

## 3.5 Site quality matters
A good water/sanitation system starts with a good site:
- water source access
- slope/drainage
- flood risk
- soil suitability
- distance between water and waste
- workable ground for pits, wells, channels, tanks, buildings

## 3.6 Every gain has tradeoffs
Examples:
- surface water is easy to reach but often dirtier
- deep wells may be safer but expensive and slow to make
- rooftop rain harvesting can reduce hauling but depends on season, storage, and roof quality
- pipes reduce hauling but add leaks, maintenance, and contamination risk if badly managed
- pit latrines are simple but can contaminate nearby water if sited badly
- sewers improve density support but require huge construction, water availability, and treatment capacity

---

# 4. Scope and era ladder

This spec spans the entire intended civilization arc, but resolution is highest in the early-to-hamlet range.

## 4.1 Era 0 — Lone Survivor
Main questions:
- find water
- avoid dehydration
- avoid obvious contamination
- choose camp with better drainage and safer water access
- create a basic clean/dirty logic even with no true infrastructure

## 4.2 Era 1 — Primitive Camp
Main questions:
- safer carrying and storage
- designated fetch point
- designated washing point
- first waste separation
- basic boiling and covered storage
- first drainage awareness

## 4.3 Era 2 — Permanent Camp
Main questions:
- repeatable water safety
- better containers
- latrine logic
- greywater and refuse separation
- better source protection
- protected water reserve
- first community rules for water and waste

## 4.4 Era 3 — Tiny Hamlet
Main questions:
- multiple households/users
- queue and access management
- reserve storage
- washing and cooking demands
- child/injured/elder access
- routine maintenance and cleaning roles
- more formal sanitation spacing and servicing

## 4.5 Era 4 — Agrarian Village
Main questions:
- dug/lined wells
- more formal rain capture and cisterns
- drainage ditches
- bathing/washhouse logic
- animal-waste separation from household water
- craft/water demand conflicts
- first quasi-public service roles

## 4.6 Era 5 — Market Town
Main questions:
- shared wells and cisterns
- neighborhood storage
- public washing or bath functions
- more durable drains
- street cleanliness
- privies/cesspits/septic-like containment in dense areas
- explicit utility administration
- first fee/labor/ration rules for public assets

## 4.7 Era 6 — Pre-Industrial Power Town
Main questions:
- water-lifting systems
- pumped water for selected uses
- mill races and industrial water use conflicts
- stormwater management
- waste and runoff in denser production zones
- first organized wastewater conveyance in limited districts

## 4.8 Era 7 — Early Industrial City
Main questions:
- municipal source selection
- intake and treatment expansion
- pump stations
- storage tanks
- distribution mains
- sewer mains in dense districts
- public health administration
- industrial wastewater and sludge burdens

## 4.9 Era 8 — Electrified Industrial City
Main questions:
- reliable pumped networks
- large storage and pressure management
- wider sewer coverage
- treatment works
- utility operations staff
- outage response
- monitoring and inspection

## 4.10 Era 9–10 — Modern Utility Society
Main questions:
- multiple treatment steps
- district-level redundancy
- water quality monitoring
- household service connections
- centralized and decentralized wastewater combinations
- energy-water dependency
- repair, finance, regulation, and resilience

---

# 5. Water service model

## 5.1 Water service is measured by more than volume
The settlement’s water service quality should be judged by:
- quantity available
- time to access
- physical effort to access
- source reliability
- contamination risk
- storage safety
- fit-for-purpose quality
- household reserve depth
- breakdown resilience
- fairness of access

## 5.2 Water use classes
Not all water uses demand the same quality.

Recommended classes:

### A. Drinking water
Highest safety demand.

### B. Cooking water
Needs near-drinking quality because it enters food.

### C. Food preparation / utensil rinse water
Often near-drinking quality.

### D. Handwashing water
Should be clean enough to support hygiene.

### E. Personal washing / bathing water
Can be lower quality than drinking water in some systems, but contamination still matters.

### F. Laundry / cloth washing water
Often lower quality acceptable, but cross-contamination can matter.

### G. Cleaning water
Can be lower quality depending on what is being cleaned.

### H. Livestock water
Separate service class.

### I. Irrigation / garden water
Often separate from household drinking logic.

### J. Industrial/process water later
Workshop and factory needs may differ greatly from drinking needs.

## 5.3 Household reserve vs communal reserve
Every settlement should distinguish:
- **household-ready water**: water already in safe household containers
- **communal stored water**: water in tanks, cisterns, or public stores
- **raw source access**: water still needing collection/treatment

This matters because:
- a source can fail suddenly
- night access may be poor
- storm/flood conditions may isolate water points
- treated water can be wasted if not reserved

---

# 6. Water source types

## 6.1 Surface water
Examples:
- stream
- river edge
- pond
- lake margin
- seep
- shallow pool
- seasonal runoff collection

Pros:
- usually easy to find
- easy to access with simple containers
- useful immediately

Cons:
- contamination risk
- turbidity
- seasonal variation
- animal use
- upstream contamination
- flood pulses
- algae/stagnation in some conditions

Early game use:
- most common first source
- often acceptable only after boiling/clarification
- requires fetch-point discipline

## 6.2 Springs and seeps
Pros:
- often cleaner than exposed surface water
- good realism gate for higher-quality settlement sites

Cons:
- still vulnerable to contamination around the emergence point
- may fluctuate seasonally
- may need protection works to stay clean

Useful upgrades:
- protected spring box
- paved/controlled approach
- fenced area
- overflow drainage

## 6.3 Rain capture
Forms:
- direct vessel capture
- tarp/cloth catchment
- roof catchment
- gutter-fed containers
- cisterns later

Pros:
- potentially cleaner starting water if catchment and storage are clean
- reduces hauling
- can support reserve building

Cons:
- seasonal
- storage-dependent
- contamination from roofs, animals, debris, dirty containers
- stagnant storage risk if badly managed

## 6.4 Groundwater / wells
Forms:
- hand-dug shallow well
- lined dug well
- driven or drilled wells much later
- artesian systems much later if geology allows

Pros:
- can be more reliable than surface water
- can be cleaner if protected
- major labor savings once established near settlement core

Cons:
- large construction burden
- collapse risk
- contamination if shallow or badly sited
- lifting device needed
- maintenance burden
- testing/quality knowledge limited in early eras

## 6.5 Stored community water
Forms:
- jars and covered vessels
- lined pits not ideal for drinking unless purpose-built
- cisterns
- tanks
- reservoirs later
- water towers later

This is not a “source,” but functionally it becomes one for daily use.

---

# 7. Water quality model

## 7.1 Core water quality dimensions
Track water by dimensions rather than single safe/unsafe state:
- microbial risk
- particulate/turbidity load
- chemical/mineral suitability (basic early abstraction only)
- taste/odor acceptability
- freshness/staleness
- handling contamination
- storage contamination
- fit-for-use class

## 7.2 Early-game practical quality states
Use accessible states such as:
- raw questionable water
- visibly cloudy raw water
- raw but relatively clear water
- settled/clarified water
- boiled water
- treated water in unsafe container
- treated water in safe covered container
- stagnant stored water
- contaminated household water
- non-potable wash water
- irrigation/process water

## 7.3 Recontamination rule
Any safe water can become unsafe again if:
- put in dirty container
- exposed to hands/ladles/cups repeatedly
- mixed with raw water
- stored open
- left near waste/pests
- carried through dirty workflow

This rule should remain true at every era.

---

# 8. Water treatment ladder

## 8.1 Era 0–1: crude risk reduction
Available methods:
- choose better source
- let muddy water settle
- strain through cloth for large debris
- boil
- keep in covered clean vessel
- separate drinking water from dirty water

This stage is about reducing risk, not achieving perfect assurance.

## 8.2 Era 2–3: reliable household treatment
Available methods:
- repeated settling and decanting
- better filtration/clarification options
- boiling with predictable fuel planning
- container sanitation
- protected covered storage
- household safe-pour containers
- source protection around spring/well

## 8.3 Era 4–5: communal treatment begins
Available methods:
- routine source inspection
- cleaner withdrawal devices
- more controlled filtration/settling
- designated water stewards
- storage tank cleaning schedules
- formal “drinking only” reserves
- separate wash and livestock areas
- chlorination later if chemistry chain exists

## 8.4 Era 6+: utility treatment
Possible later steps:
- settling basins
- slow sand filtration or analogous filtration stages
- chemical treatment/disinfection
- protected finished-water storage
- distributed pressure network
- water quality checks
- emergency boil advisories

---

# 9. Water storage system

## 9.1 Storage doctrine
Stored water should be judged by:
- cleanliness of vessel
- opening design
- lid/cover
- pour method
- storage location
- separation from dirty tasks
- labeling/ownership/reservation
- age of stored batch

## 9.2 Household drinking-water container requirements
Best-practice characteristics for safer storage:
- narrow opening or controlled outlet
- lid/cover
- easy to clean
- durable enough for repeated use
- not previously used for toxins
- manageable carrying weight
- stable placement in shelter/storage zone

## 9.3 Communal water storage requirements
As scale increases, communal storage should have:
- assigned ownership/stewardship
- protected access
- contamination barriers
- cleaning schedule
- refill logic
- emergency reserve rules
- leak/spoilage/overflow checks
- access rules for households, workshops, and animals

## 9.4 Storage classes
- personal carry vessel
- household drinking vessel
- household general-use vessel
- communal jar cluster
- buried/cooled container storage
- cistern
- elevated tank/tower later
- network tank/reservoir later

---

# 10. Water access and hauling

## 10.1 Access burden matters
A settlement with an excellent source very far away can still function badly.

Track:
- round-trip distance
- elevation change
- path quality
- queue time
- lifting difficulty
- container weight
- number of trips
- weather exposure during fetch

## 10.2 Water-fetch roles
Possible early roles:
- self-fetching adult
- primary water hauler
- secondary reserve hauler
- child/light hauler later with strong care rules
- animal-assisted hauling much later
- cart/wagon hauling later
- piped/pumped delivery later

## 10.3 Water point zoning
Every settlement should distinguish:
- clean fetch point
- wash point
- animal watering point
- laundry point
- dirty runoff exit
- protected drinking-water storage zone

These should not collapse into one muddy shared edge if realism matters.

---

# 11. Early washing, hygiene, and service points

## 11.1 Service-point logic
Water infrastructure is not only “source + storage.”
It also includes where water is used.

Key points:
- handwashing point
- cooking water point
- household water shelf/corner
- laundry point
- bathing point
- tool cleaning point
- medical/cleaning water point later
- workshop water point later

## 11.2 Hand hygiene support
A settlement’s hygiene performance improves when:
- water is near the right tasks
- soap or scrub materials exist
- handwashing is tied to latrine use, wound care, child care, and food prep
- dirty and clean containers are distinct

## 11.3 Greywater
Greywater is not excreta, but it is still infrastructure-relevant.
It needs:
- discharge zones
- soak areas/trenches
- drainage away from walking surfaces and drinking-water zones
- no stagnant puddling near camp core

---

# 12. Sanitation service model

## 12.1 Core sanitation doctrine
Sanitation means keeping human excreta separated from human contact at every step:
- use
- containment
- storage
- emptying or abandonment
- movement
- treatment/disposal or safe isolation

## 12.2 Early sanitation goals
Era 0–2 priorities:
- do not foul sleeping/eating area
- keep excreta away from water source
- keep excreta away from paths and camp core
- reduce flies/odor where possible
- avoid runoff wash-through during rain
- establish habit/rules

## 12.3 Later sanitation goals
Era 3+ priorities:
- enough access points for population
- privacy and usability
- night access safety
- child and ill-person usability
- servicing and fill tracking
- vector control
- groundwater and storm protection
- district-scale planning later

---

# 13. Sanitation ladder by era

## 13.1 Era 0 — ad hoc defecation with risk
Bad state:
- random defecation near camp, paths, or water

Desired first improvement:
- designated away-zone
- basic burial/cover
- distance from water and camp

## 13.2 Era 1 — cathole / designated primitive latrine zone
Features:
- assigned location
- away from fetch point
- away from sleeping and food prep
- sheltered enough for practical use
- not in drainage channel

## 13.3 Era 2 — fixed pit latrine / trench latrine logic
Features:
- repeatable facility
- privacy screen/shelter possible
- cover material management
- path access
- fill monitoring
- fly/odor reduction measures
- handwashing support nearby if feasible

## 13.4 Era 3 — multi-household sanitation
Features:
- more than one facility or one larger managed facility
- family/guest rules
- maintenance role
- night safety
- child-support practices
- stronger washing rules

## 13.5 Era 4–5 — improved privy / cesspit / septic-like containment
Possible branches:
- improved pit latrine
- ventilated pit equivalent if design level supports it
- lined pits where needed
- privy over pit
- simple septic-like tank plus soil absorption later where appropriate
- neighborhood wash/bath and laundry separation

This stage should strongly depend on:
- soil
- water table
- flood risk
- well distance
- density

## 13.6 Era 6+ — sewer and treatment branches
Possible branches:
- simplified sewer
- combined/partial sewer in dense areas
- lift station later
- lagoon/pond treatment in some layouts
- plant-based or mechanical treatment later
- sludge handling chain

---

# 14. Latrine and on-site sanitation rules

## 14.1 Siting rules
A latrine should avoid:
- direct proximity to water point
- flood channels
- drainage swales
- unstable soils/slopes
- camp core
- direct adjacency to food prep/water storage
- groundwater-vulnerable siting where known

## 14.2 Performance dimensions
Rate every sanitation facility by:
- privacy
- ease of access
- cleanliness
- odor burden
- fly/pest attraction
- overflow/fill status
- runoff safety
- handwashing support
- night usability
- accessibility for weak/injured NPCs

## 14.3 Maintenance burdens
On-site sanitation always requires some combination of:
- cover material
- cleaning
- path upkeep
- roof/wall upkeep if sheltered
- fill monitoring
- pit replacement or emptying later
- runoff control
- handwashing point upkeep

---

# 15. Wells

## 15.1 Why wells are a major transition
A settlement-local well can:
- reduce hauling time drastically
- improve reliability
- support larger population
- support washing and cooking better
- make denser settlement possible

But it should not be trivial.

## 15.2 Well types in gameplay terms

### A. Hand-dug shallow well
Requirements:
- suitable water table
- dig labor
- shoring/lining materials
- spoil removal
- safe access and lifting setup
- contamination awareness

Risks:
- collapse
- poor yield
- contamination from surface sources
- contamination from nearby waste
- child/fall hazard
- dirty buckets/ropes

### B. Lined dug well
Adds:
- masonry, timber, stone, brick, or other lining
- stronger rim/headwall
- better contamination protection
- greater durability

### C. Covered protected well
Adds:
- cover or well house
- controlled bucket or pump point
- drainage apron
- fenced/protected surroundings
- dedicated use rules

### D. Mechanized or deeper well later
Adds:
- advanced tools/materials
- casing
- pump machinery
- maintenance and replacement parts

## 15.3 Well support assets
- windlass / pulley / lifting beam
- rope and bucket
- hand pump later
- apron or hardstanding
- drainage ditch for spilled water
- nearby clean vessel filling point
- fencing/barrier
- lighting later

## 15.4 Well contamination doctrine
A well becomes higher risk when:
- shallow
- uncovered
- near latrine/septic/manure zone
- in flood-prone ground
- surrounded by pooled dirty water
- using dirty buckets
- lacking drainage around the head

---

# 16. Springs, spring boxes, and protected emergence points

## 16.1 Spring protection value
A clean spring can become a premium early-to-midgame asset because it may require less treatment than open surface water if protected well.

## 16.2 Upgrade path
- discovered spring
- cleared access
- fetch-point discipline
- runoff diversion
- fenced/protected area
- spring box
- controlled outflow or filling point
- overflow drainage

## 16.3 Risks
- upslope contamination
- trampling
- animal access
- leaf/debris fouling
- flood/sediment damage
- false trust leading to no treatment when treatment is still needed

---

# 17. Rain capture and cisterns

## 17.1 Rain capture branches
### A. Opportunistic capture
- vessels placed under runoff
- tarp catchment
- temporary sheet catchment

### B. Roof capture
Needs:
- roof material quality
- guttering/channeling
- first-flow dirt management concept
- clean storage vessel
- reserve management

### C. Formal cistern
Needs:
- catchment area
- inlet management
- covered tank or underground chamber
- sediment/cleaning access
- draw-off method
- contamination prevention

## 17.2 When rain capture makes sense
- seasonal rainfall adequate
- settlement has structures worth harvesting from
- surface water unreliable or far
- labor savings offset build cost
- stored reserve is socially/governance-manageable

## 17.3 Cistern performance dimensions
- catchment size
- storage volume
- cover quality
- evaporation loss
- contamination control
- cleaning interval
- leak resistance
- reserve protection

---

# 18. Drainage, runoff, and stormwater

## 18.1 Why drainage is utility logic
Bad drainage causes:
- muddy access
- container contamination
- latrine overflow or washout
- shelter dampness
- standing mosquito water
- road/path damage
- well contamination
- rot and foundation damage

## 18.2 Early drainage assets
- scraped runoff channels
- shallow swales
- diversion ditches upslope of camp
- stone-lined splash points
- raised thresholds
- hardstanding around key work points
- soak pits/trenches
- surface grading

## 18.3 Settlement drainage zones
Each camp or settlement should define:
- dry core
- runoff paths
- wash water discharge
- livestock waste runoff separation
- garden water use area
- storm overflow danger area

## 18.4 Later drainage evolution
- street drains
- culverts
- lined channels
- stormwater retention
- district drainage planning
- flood-control infrastructure later

---

# 19. Wastewater and greywater systems

## 19.1 Greywater doctrine
Greywater can often be managed more simply than sewage, but it still must not:
- pond in camp core
- undermine structures
- run into drinking-water areas
- create slippery work zones
- create chronic pest habitat

## 19.2 Greywater handling ladder
- scatter discharge away from core
- designated soak patch
- soak trench/pit
- laundry drain area
- washhouse drain
- yard channel
- connection to later wastewater system

## 19.3 Blackwater / sewage ladder
- open defecation (bad baseline)
- cathole / primitive pit
- pit latrine
- improved pit/privy
- on-site containment / septic-like system
- decentralized wastewater treatment
- sewer collection
- municipal wastewater treatment

---

# 20. Utility service branches

## 20.1 Household service
Water and sanitation managed mainly at household/work-area scale:
- own vessels
- own boiling
- own latrine access
- own washing point
- own reserve responsibility

## 20.2 Shared neighborhood service
Several households share:
- water point
- latrine block
- wash point
- cistern
- drainage channels
- cleaning schedule

## 20.3 Public utility service
Settlement-level organized service:
- designated operators
- inspections
- posted rules
- rationing during shortage
- maintenance planning
- inventories/spares later
- finances/labor obligations
- emergency procedures

---

# 21. Public-utility maturity ladder

## 21.1 Stage U0 — no utility system
- all service individual/ad hoc

## 21.2 Stage U1 — recognized shared service points
- one or more communal water and waste assets
- informal governance

## 21.3 Stage U2 — stewarded service
- assigned water steward / sanitation steward
- maintenance schedule
- reserve tracking
- cleaning rules
- queue/priority rules

## 21.4 Stage U3 — managed utility service
- multiple assets operating as a system
- service-area planning
- labor or fee obligations
- repair planning
- source diversification
- contingency rules

## 21.5 Stage U4 — civic utility institution
- administration office or formal recordkeeping
- trained operators
- replacement planning
- district coverage
- service metrics
- breakdown dispatch

---

# 22. Later-era utility components

## 22.1 Waterworks components
By later eras the water system may include:
- source protection zone
- intake
- raw-water conveyance
- treatment works
- clear-water storage
- pumps
- mains
- local distribution branches
- valves
- hydrants/fire supply later
- metering/monitoring later
- repair yards and spares

## 22.2 Wastewater components
- toilets/house connections
- service lines
- trunks/mains
- lift stations later
- decentralized package treatment in some districts
- lagoons/settling ponds
- plant treatment trains later
- sludge handling
- effluent discharge/reuse controls

## 22.3 Support utility components
- workshops
- operator housing/office
- records and maps
- spare parts storage
- chemical storage later
- testing room/lab later
- emergency fuel/power later
- outage communication later

---

# 23. Roles and labor

## 23.1 Early roles
- self-fetcher
- household water carrier
- fire tender for boiling
- vessel cleaner
- latrine digger/maintainer
- camp cleaner
- runoff clearer

## 23.2 Hamlet/village roles
- water steward
- source inspector
- well tender
- spring keeper
- cistern keeper
- sanitation steward
- washhouse cleaner
- drain/ditch cleaner
- reserve monitor
- public-rule enforcer

## 23.3 Town/city roles
- waterworks operator
- pump operator
- treatment operator
- sewer crew
- drain crew
- inspector
- utility planner
- sanitation foreman
- meter/records clerk later
- engineer later

---

# 24. Governance, ownership, and allocation hooks

## 24.1 Water ownership classes
- personal carried water
- household stored water
- communal drinking reserve
- communal general-use reserve
- workshop/process water stock
- livestock water stock
- emergency public reserve

## 24.2 Water priority order
Suggested crisis priority order:
1. drinking
2. essential cooking
3. wound care / critical hygiene
4. infant/ill-person needs
5. essential household hygiene
6. livestock survival minimum
7. tool cleaning / laundry / comfort uses
8. irrigation
9. luxury or low-priority industrial uses

## 24.3 Sanitation governance questions
Settlement must decide:
- who maintains facilities
- who cleans them
- who can use which facility
- what happens when a pit is near full
- whether outsiders may use them
- what rules apply in flood or freeze conditions
- who responds to contamination incidents

---

# 25. Hazards and failure modes

## 25.1 Water failures
- source dries up
- source floods/muddies
- container breaks
- stored water contaminated
- fetch point blocked
- well collapses
- well yield declines
- rope/bucket failure
- cistern leaks
- pipe leak later
- pump failure later
- treatment outage later

## 25.2 Sanitation failures
- pit too full
- runoff enters latrine area
- latrine too close to water source
- open defecation due to neglect or fear/night hazards
- handwashing point dry
- wastewater pooling
- cesspit overflow later
- sewer backup later
- treatment failure later

## 25.3 Governance failures
- drinking reserve used for washing
- public asset not cleaned
- labor not assigned
- rules not obeyed due to low legitimacy
- queues become conflict point
- upper-status households hoard safe water
- outsiders contaminate or overdraw assets
- workshop or livestock uses crowd out domestic need

---

# 26. Interactions with other systems

## 26.1 Health
Poor water/sanitation increases:
- diarrheal disease burden
- dehydration from unsafe-source avoidance or shortage
- wound contamination risk
- child/elder vulnerability
- care labor burden

## 26.2 Food and cooking
Water quality affects:
- soup/stew/cooking safety
- utensil cleaning
- food wash safety
- fermentation quality later
- preservation failure

## 26.3 Logistics
Water carrying is a major logistics burden until:
- local source
- better containers
- animal traction
- carts
- pipes/pumps

## 26.4 Settlement progression
The settlement should not qualify as more mature just because it has more houses.
It should need real water and sanitation improvements that support population safely.

## 26.5 Trade and workshops
As village/town craft increases, water demand rises for:
- clay work
- washing
- hides/leather
- soapmaking
- lime work
- cooling/steam/power later
- sanitation cleaning

This creates allocation conflict unless a larger utility layer exists.

---

# 27. Utility performance metrics

## 27.1 Early metrics
- liters available per person per day (or abstract equivalent if not numerically exposed)
- average fetch time
- household reserve depth
- days since drinking-water shortage
- distance from waste to water point
- fraction of drinking water stored safely
- queue burden at water points
- sanitation access score
- wastewater pooling severity

## 27.2 Midgame metrics
- protected source count
- communal reserve capacity
- working well count
- maintenance backlog
- service reliability
- contamination incidents per season
- wash access and hygiene support
- drainage performance during storms

## 27.3 Later utility metrics
- coverage rate
- pressure/reliability
- storage turnover
- treatment throughput
- non-delivered or lost water later
- sewer coverage
- untreated wastewater fraction
- outage response time
- per-district service equity

---

# 28. Data schema recommendations

## 28.1 Water asset schema
- asset_id
- asset_type
- source_type
- location
- service_area
- capacity
- quality_constraints
- contamination_protection_level
- lifting_or_conveyance_method
- throughput_per_time
- reserve_flag
- maintenance_state
- staffing_requirements
- access_rules
- hazard_flags
- connected_assets
- failure_modes

## 28.2 Sanitation asset schema
- asset_id
- sanitation_type
- containment_type
- location
- users_supported
- privacy_level
- accessibility_level
- runoff_risk
- fill_state
- servicing_method
- handwashing_support
- vector_risk
- maintenance_state
- connected_disposal_chain
- closure_or_replacement_rule

## 28.3 Utility service schema
- service_id
- service_name
- service_class
- assets_included
- households_served
- minimum_staff
- quality_target
- reliability_target
- reserve_policy
- emergency_policy
- governance_owner
- fee_or_labor_basis
- incident_thresholds

---

# 29. First-playable minimum for the early slice

This project’s current playable-design center is still:
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

For that slice, the minimum water/sanitation/utility simulation should include:

## 29.1 Water
- at least two source-quality states
- carrying burden
- cloudy vs clearer water distinction
- boiling
- covered vs uncovered storage
- recontamination risk
- household reserve
- communal reserve later in hamlet

## 29.2 Sanitation
- no sanitation / bad sanitation
- designated waste zone
- primitive latrine
- latrine distance and flood/runoff penalties
- handwashing support bonus
- wastewater pooling if washing is unmanaged

## 29.3 Utility maturity
- no system
- shared service point
- stewarded service point

## 29.4 Roles
- water fetcher
- vessel cleaner
- latrine maintainer
- water steward later

## 29.5 Events
- water shortage
- contaminated stored water
- source muddied by storm
- latrine overflow / unusable latrine
- wash area turns muddy and pest-prone
- outsider or animal fouls source area

---

# 30. Stage gates for settlement growth

## 30.1 Primitive Camp gate
Should require:
- identifiable water source access
- some covered storage
- some clean/dirty separation
- basic waste zone away from camp core

## 30.2 Permanent Camp gate
Should require:
- repeatable safe drinking-water workflow
- protected reserve capacity
- routine sanitation location/facility
- basic runoff/drainage management
- washing point logic separate from fetch point

## 30.3 Tiny Hamlet gate
Should require:
- more than one reliable household access path
- communal water reserve and/or protected source near settlement
- managed latrine use and servicing
- visible maintenance/stewardship role
- household/workshop/livestock water separation at least partly functioning

## 30.4 Village/Town gates later
Should increasingly require:
- protected wells or similar robust supply
- drainage network
- multiple sanitation assets
- wash/bath and laundry logic
- formal water governance
- repairs and scheduled maintenance
- true utility planning

---

# 31. Strong design recommendations

## 31.1 Do not reduce water to one bar
Water should not be only “NPC thirst.”
It should be:
- personal hydration
- household stock
- settlement reserve
- service burden
- contamination risk
- infrastructure stress

## 31.2 Do not reduce sanitation to a mood debuff
It should shape:
- disease risk
- settlement attractiveness
- odor/pest burden
- maintenance labor
- storm vulnerability
- water contamination risk
- governance friction

## 31.3 Make wells and protected sources meaningful
They should feel like genuine civilization gains.

## 31.4 Make recontamination real
This is one of the simplest and most valuable realism rules.

## 31.5 Make utilities visibly labor-intensive before they become mechanized
This preserves the “earned infrastructure” feeling.

---

# 32. Open questions for later versions

## 32.1 Numerical exposure
How explicit should the game be about liters, contamination scores, and treatment rates versus more abstract values?

## 32.2 Water chemistry
How much mineral/salinity/chemical contamination realism do you want beyond microbial safety?

## 32.3 Winter/freezing complexity
How much do frozen storage, frozen latrines, and seasonal well/pump issues matter in your chosen biome?

## 32.4 Bathing culture / comfort level
How detailed should bathing, laundry, and social cleanliness expectations become over time?

## 32.5 Modern endpoint
Do you want full municipal treatment plants, storm sewers, district pumps, and household plumbing, or stop earlier?

---

# 33. Short conclusion

This layer should make one truth visible from the beginning:

> Civilization is partly the story of bringing water closer, keeping it cleaner, handling waste more safely, and eventually turning those tasks into organized public services.

In the early game, this means:
- fetch
- boil
- cover
- separate
- drain
- dig
- clean
- protect

In the middle game, this means:
- wells
- cisterns
- washing places
- drainage
- stewardship
- reserve rules

In the later game, this becomes:
- waterworks
- pumping
- treatment
- distribution
- sewerage
- wastewater treatment
- inspection
- utility management

A settlement that cannot manage water and sanitation should not feel truly stable, no matter how many items or buildings it owns.

---

# References

These references were used to ground the realism and utility-chain logic in this document.

- World Health Organization, *Sanitation*  
  https://www.who.int/news-room/fact-sheets/detail/sanitation

- World Health Organization, *Guidelines on sanitation and health*  
  https://www.who.int/publications/i/item/9789241514705

- World Health Organization, *Sanitation Safety Planning*  
  https://www.who.int/teams/environment-climate-change-and-health/water-sanitation-and-health/sanitation-safety/sanitation-safety-planning

- CDC, *How to Make Water Safe in an Emergency*  
  https://www.cdc.gov/water-emergency/about/index.html

- CDC, *Safe Water Storage*  
  https://www.cdc.gov/global-water-sanitation-hygiene/about/about-safe-water-storage.html

- CDC, *Guidelines for Treating Well Water*  
  https://www.cdc.gov/drinking-water/safety/guidelines-for-treating-well-water.html

- CDC, *How to Disinfect Wells After an Emergency*  
  https://www.cdc.gov/water-emergency/about/how-to-disinfect-wells-after-an-emergency.html

- CDC, *How to Create and Store an Emergency Water Supply*  
  https://www.cdc.gov/water-emergency/about/how-to-create-and-store-an-emergency-water-supply.html

- U.S. Geological Survey, *Ground Water and the Rural Homeowner*  
  https://pubs.usgs.gov/gip/gw_ruralhomeowner/

- U.S. Geological Survey, *Aquifers and Groundwater*  
  https://www.usgs.gov/water-science-school/science/aquifers-and-groundwater

- U.S. Environmental Protection Agency, *Drinking Water Distribution System Tools and Resources*  
  https://www.epa.gov/dwreginfo/drinking-water-distribution-system-tools-and-resources

- U.S. Environmental Protection Agency, *Small and Rural Wastewater Systems*  
  https://www.epa.gov/small-and-rural-wastewater-systems

- U.S. Environmental Protection Agency, *About Small Wastewater Systems*  
  https://www.epa.gov/small-and-rural-wastewater-systems/about-small-wastewater-systems

- U.S. Environmental Protection Agency, *Septic Systems and Drinking Water*  
  https://www.epa.gov/septic/septic-systems-and-drinking-water

- Food and Agriculture Organization, *Water harvesting and use*  
  https://www.fao.org/4/t0321e/t0321e-12.htm
