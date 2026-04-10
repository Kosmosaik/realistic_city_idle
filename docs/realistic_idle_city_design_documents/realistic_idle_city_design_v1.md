
---
title: "Realistic Incremental/Idle Colony-to-City Game Design Document"
version: "v0.1 - first research-backed draft"
assumptions:
  - "Earth-like setting"
  - "Temperate starting biome"
  - "One adult starter NPC"
  - "Realism-first provenance model, but with game-time compression"
author: "OpenAI / ChatGPT"
date: "2026-04-06"
---

# Realistic Incremental/Idle Colony-to-City Game Design Document

## Purpose of this document

This is a **first large design draft** for an incremental / idle game in which the player begins with **one naked NPC in the wilderness** and gradually builds a functioning settlement, then a village, town, industrial city, and finally a modern integrated society.

The design goal is not a fantasy tech tree. It is a **provenance-based civilization builder**:

- nothing appears from nowhere
- every finished item has an upstream chain
- every building requires labor, materials, tools, and knowledge
- every machine requires maintenance, energy, replacement parts, and operators
- every increase in population creates new burdens in food, sanitation, housing, safety, governance, and logistics
- every productivity jump is tied to real bottlenecks humans historically solved

This draft is intentionally broad and deep. It is meant to give you a **foundation document** that can later be split into:
- a game design document
- a progression bible
- an item/building/material dependency database
- a tech/knowledge tree
- NPC simulation rules
- factory and settlement production sheets

---

# 1. Core interpretation of your idea

## 1.1 The fantasy to preserve

The emotional fantasy is:

> Start with almost nothing, survive, learn, specialize, recruit, organize, industrialize, and eventually build a city in which every NPC has a believable place in society.

That means the game is not just about crafting. It is about:
- **bootstrapping civilization**
- **converting individual survival into institutional capacity**
- **converting scattered manual labor into coordinated industry**
- **converting knowledge into social infrastructure**
- **converting surplus into specialization**
- **converting specialization into scale**

## 1.2 The realism challenge

If the game is truly realism-first, then a tractor is not “iron bars + engine + wheel + fuel.”  
A tractor is the end-product of many prior systems:

- mining
- smelting
- steelworking
- casting
- machining
- interchangeable parts
- wire production
- battery production
- rubber production
- glass production
- coatings/paint
- petroleum refining
- lubricant production
- workshop tooling
- assembly labor
- transport logistics
- agricultural demand that justifies the machine in the first place

That same logic must apply to almost everything in the game.

## 1.3 The design truth you should probably embrace

**Realism does not mean simulating all details at the same resolution all the time.**  
A real-feeling game needs:
- realistic **dependencies**
- realistic **constraints**
- realistic **bottlenecks**
- realistic **maintenance burdens**
- realistic **institutional progression**

It does **not** need the player to click every screw by hand forever.

So the right design model is:

### Progressive fidelity
The simulation starts at **high granularity** for survival items and hand labor, then gradually becomes more **industrial and aggregate** as institutions appear.

Example:
- Early game: 1 branch, 1 stone, 1 hide, 1 meal matters.
- Mid game: 1 batch of pottery, 1 charcoal burn, 1 plow, 1 loom matters.
- Late game: 1 steel mill, 1 machine shop, 1 diesel refinery contract, 1 municipal waterworks, 1 tractor assembly line matters.
- Very late game: electricity, fuel, sewage, freight, spare parts, and labor can partly be tracked as **rates**, not only as single handcrafted objects.

This is how you keep realism without making the game unplayable.

---

# 2. Baseline assumptions for version 1

Because the starting state matters enormously, this first draft assumes:

## 2.1 Starting biome
A **temperate biome** with:
- fresh water within reachable distance
- trees / brush / grasses
- wild edibles and small game
- stone suitable for primitive tools
- clay or mud somewhere in the wider area
- animal life sufficient for hides, bone, sinew, fat, and meat later
- seasons that create real survival pressure

Without this, a one-person start becomes either non-viable or highly luck-based.

## 2.2 The starter NPC
One adult NPC, physically capable of:
- walking and carrying
- gathering wood, stone, water, food
- building a primitive shelter
- lighting fire after learning or discovering how
- improvising primitive clothing/bedding
- learning from repetition and observation

They begin with:
- no equipment
- no owned resources
- no formal recipes
- no buildings
- no social support
- only the most basic human problem-solving capacity

## 2.3 Knowledge model
The NPC does **not** begin with an industrial “recipe book.”  
Knowledge should be split into at least four layers:

1. **Embodied skill**  
   What an individual can personally do better through practice.

2. **Practical know-how**  
   What a community knows how to produce reliably.

3. **Codified knowledge**  
   Repeatable procedures, measurements, plans, written instructions.

4. **Scientific/engineering knowledge**  
   Abstract understanding that unlocks large jumps in design capability.

This separation is crucial. A lone survivor might know how to tie a bundle or shape a sharp stone, but that is very different from a society that can produce uniform bolts or refine diesel.

## 2.4 Population growth model
Additional NPCs should not simply “unlock” because of time. They should join or emerge only if the settlement supports them.

Possible routes:
- **migration / attraction** from reputation and safety
- **rescues / wanderers / refugees**
- **family growth** later, once housing, food, care, and health allow it
- **institutional pull** later (traders, specialists, teachers, mechanics, doctors, administrators)

Population growth should be limited by:
- calories
- potable water
- shelter
- heat / clothing
- sanitation
- disease burden
- security
- social stability
- spare labor to support non-food workers

---

# 3. Design pillars

## 3.1 Provenance over abstraction
Every object should have a believable origin:
- food comes from gathering, hunting, husbandry, or agriculture
- cloth comes from plant or animal fiber, spinning, weaving, and sewing
- metal tools come from ore/scrap + fuel + furnace + hammering/machining
- fuel comes from wood, charcoal, coal, petroleum, biomass, or electricity infrastructure
- chemicals come from natural extraction or industrial processing

## 3.2 Surplus creates specialization
Specialists appear only when someone else feeds them.

This is one of the most important realism laws in the whole game:
- no blacksmith without food surplus
- no potter without clay, fuel, and enough food support
- no teacher without enough non-teacher workers
- no machinist without a machine shop
- no tractor factory without a very large economic base

## 3.3 Institutions matter as much as tools
A thriving city needs more than production buildings:
- storage
- roads
- sanitation
- accounting
- law / governance
- distribution
- education
- repair networks
- medical care
- trade
- energy utilities
- water and waste systems

## 3.4 Maintenance is real gameplay
Machines should not be permanent power multipliers with no downside.
They should require:
- lubrication
- spare parts
- operators
- cleaning
- fuel or electricity
- periodic downtime
- repair skill
- safety systems

## 3.5 Knowledge and interest are separate from skill
Each NPC should have:
- **aptitude** (natural capability)
- **interest** (how willingly / quickly they engage and learn)
- **skill** (practice outcome)
- **experience quality** (whether they learn from good supervision, books, schools, or trial-and-error)

Your stated idea — higher interest = faster skill gain — is strong and realistic enough to anchor the NPC simulation.

---

# 4. The simulation backbone

The whole game can be understood as six interacting layers.

## 4.1 Human layer
Each NPC has:
- body state (calories, hydration, fatigue, temperature, injury, sickness)
- mood / morale
- traits / interests
- skills
- social ties
- schedule
- workplace / role
- training path

## 4.2 Resource layer
All materials belong to categories:
- raw gathered
- raw extracted
- processed basic
- crafted intermediate
- assembled final
- utility consumables
- waste / byproducts / scrap

## 4.3 Process layer
Every transformation requires a believable combination of:
- labor
- time
- know-how
- tools
- workstation or building
- energy/fuel
- maintenance
- sometimes utilities (water, electricity, ventilation, transport)

## 4.4 Settlement layer
The colony evolves through:
- shelter
- storage
- workshop space
- agriculture
- defense
- roads
- sanitation
- markets
- administration
- education
- industry
- utilities

## 4.5 Knowledge layer
Unlocks come from:
- observation
- repetition
- experimentation
- teaching
- writing / record-keeping
- libraries / schools / technical institutes
- formal R&D later

## 4.6 Logistics layer
No city works without movement:
- hauling
- pack animals
- carts
- wagons
- roads
- rivers/canals
- rail
- trucks
- warehouses
- retail distribution
- municipal service routes

---

# 5. Recommended progression structure

Below is the overall progression model for a realism-first version.

| Era | Identity | Core problem solved | Main bottleneck | Typical new institutions |
|---|---|---|---|---|
| 0 | Lone Survivor | Stay alive tonight | Water, shelter, calories, warmth | None |
| 1 | Primitive Camp | Survive days/weeks reliably | Storage, fire, tools, clothing | Hearth, sleeping shelter, cache |
| 2 | Permanent Camp | Stop living hand-to-mouth | Preservation, sanitation, containers | Pit storage, latrine, drying/smoking, pottery |
| 3 | Hamlet | Create first surplus | Farming, labor division | Fields, granary, workshop huts |
| 4 | Agrarian Village | Support specialists | Animal power, carpentry, metalwork | Smithy, tannery, loom house, mill |
| 5 | Market Town | Scale production and trade | Transport, consistency, records | Roads, carts, warehouses, market, guild-like crafts |
| 6 | Pre-Industrial Town | Replace muscle where possible | Fuel, water power, metallurgy scale | Watermills, lime kilns, foundries, sawmills |
| 7 | Early Industrial City | Mechanize production | Coal, steam, machine tools | Steam engines, factories, rail, urban utilities |
| 8 | Electrified Industrial City | Flexible power and large utilities | Grid, copper, steel, sanitation scale | Power stations, substations, waterworks, sewer plants |
| 9 | Chemical/Mechanical Modern City | Synthetic materials, engines, fertilizers | Oil, chemistry, precision manufacturing | Refineries, chemical plants, machine shops, motor transport |
| 10 | Integrated Modern City | High-throughput economy | Systems integration and maintenance | Logistics networks, schools, hospitals, administration, modern retail |

---

# 6. Era-by-era progression in realistic steps

# Era 0 — Lone Survivor

## 6.0 Core fantasy
One person, no gear, exposed to the environment.

## 6.1 Immediate realistic priorities
In real survival terms, the first solvable issues are usually:
1. water access
2. exposure / shelter
3. fire
4. calories
5. cutting / scraping / pounding tools
6. safe sleeping setup
7. protection from weather and insects
8. minimal sanitation around camp

The game should reflect that **the first day is not “craft a workstation.”**  
It is: “Do I make it through the night without dehydration, exposure, or exhaustion?”

## 6.2 Day-one progression sequence
A strong version-1 sequence would be:

### Step 1: Site selection
The NPC scouts for:
- nearby fresh water
- deadwood / fuelwood
- stone
- some wind protection
- drainage above flood line
- enough open ground for future camp expansion
- distance from predator dens or swamp disease zones

### Step 2: Primitive water access
Initially:
- drink riskily from the cleanest available source if desperate
- later improve through boiling, settling, filtering, storage, and eventually wells and treatment

Game system:
- untreated water can be a **risk-reduction problem**, not a pure binary
- safer source + boiling + cleaner storage reduce disease odds

### Step 3: Emergency shelter
Not a house yet.  
A first shelter is:
- windbreak
- debris lean-to
- brush bedding
- raised sleeping surface if feasible
- dry zone for rest and fire support

### Step 4: Primitive tool improvisation
Likely first tools:
- hammer stone
- sharp flake
- digging stick
- carrying sling / bundle wrap
- branch clubs / simple spears
- cordage from plant fibers or strips later

### Step 5: Fire
Fire is the first productivity explosion because it enables:
- warmth
- safer water
- cooked food
- light
- predator deterrence
- drying
- smoke preservation later
- hardening wooden points
- charcoal path later

### Step 6: Food for the first 1–3 days
Most realistic early calories:
- gathered edible plants
- shellfish / insects / eggs where biome allows
- small trapped or clubbed game
- scavenged carcass with high illness risk
- simple spear or throw tools
- later fish and better traps

### Step 7: Sleep and recovery
Fatigue should be severe at this stage.
A lone survivor doing everything manually should face:
- overwork
- wasted time from carrying
- failed tasks
- injury risk
- morale instability

## 6.3 Era-0 buildings / structures
- emergency lean-to
- fire ring / hearth
- crude storage cache
- drying rack
- sharpened stake line / simple deterrent fence later in the era

## 6.4 Era-0 items
- stone flakes
- pounding stones
- digging sticks
- crude wooden spear
- baskets or bundled carriers
- rough fiber cordage
- simple bedding
- crude wraps / hide wraps if hunting succeeds

## 6.5 Era-0 skills that matter
- foraging
- firemaking
- primitive sheltering
- water gathering
- primitive toolmaking
- basic hunting/trapping
- skinning/butchering
- risk assessment

## 6.6 Failure states
- dehydration
- cold/wet exposure
- food poisoning or unsafe water illness
- exhaustion
- infected wounds
- spoilage from no storage
- predator attack due to bad camp placement

---

# Era 1 — Primitive Camp

## 7.1 Era identity
The NPC has stopped living minute-to-minute and starts building repeatable survival systems.

## 7.2 Primary goal
Create **reliable daily survival** rather than lucky survival.

## 7.3 What changes here
The camp begins to accumulate:
- stable hearth use
- better sleeping conditions
- better food gathering range
- repeatable trap lines
- simple butchering and hide use
- basic clothing
- basic storage
- initial waste separation

## 7.4 Realistic priorities
### A. Better tools
The NPC should improve from improvised objects to purpose-made primitive tools:
- sharper stone blades
- scraping tools
- awls from bone
- digging tools
- hafted stone tools later
- better spears
- snares and deadfalls

### B. Better carrying and storage
A lone human is bottlenecked badly by carrying capacity.
Huge early gains come from:
- baskets
- slings
- hide bags
- poles / drags
- small sleds if terrain allows
- cached food near sources

### C. Food preservation
The moment the NPC can preserve food, survival becomes more stable.
Early realistic methods:
- drying
- smoking
- salting much later unless salt source exists
- cool pit storage
- protected hanging storage

### D. Basic clothing and bedding
Primitive clothing is not fashion; it is survival tech:
- wraps
- hide capes
- simple tied garments
- footwear
- bedding and insulation

### E. Camp hygiene
Even one person benefits from:
- a designated defecation area away from water
- refuse/waste zone
- clean/dirty area separation
- protected food storage away from pests

## 7.5 Buildings / structures
- improved shelter hut
- dedicated hearth
- wood storage
- raised sleeping platform
- drying rack
- smoking frame
- meat/hide work area
- waste pit / latrine zone

## 7.6 Knowledge gates
The NPC should unlock practical know-how by repetition:
- which plants are edible
- how long meat keeps in smoke vs open air
- where animals pass repeatedly
- how to make stronger cordage
- how to cure hides more reliably

## 7.7 Transition gate to next era
The key gate is:
> The NPC can produce enough calories and shelter stability to spend time on non-immediate survival work.

That is the first true “surplus” moment.

---

# Era 2 — Permanent Camp / Proto-Settlement

## 8.1 Era identity
The settlement becomes a place, not just a campsite.

## 8.2 The major realism leap
This is where the game should start emphasizing that **containers and preservation are civilization multipliers**.

Pottery is historically enormous. Earthenware was the first kind of pottery and dates back about 9,000 years, while kilns and fired brick were major technological advances over sun-dried materials.[R2][R3]

## 8.3 Main goals
- secure recurring food
- create containers
- improve sanitation
- establish first structured storage
- build out craft zones
- enable first small surplus

## 8.4 Key systems

### A. Pottery / fired containers
Once clay processing exists, the player can support:
- cooking vessels
- water storage
- grain storage
- fermentation
- better transport of liquids and fats
- improved seed storage

Production chain:
1. locate clay
2. dig clay
3. temper it (sand, crushed shell, grog, etc.)
4. shape vessels
5. dry slowly
6. fire in pit/kiln
7. accept breakage losses

### B. Hide processing to leather-like products
Leather making is ancient; early skin preservation involved drying, smoking, fats, brains, and later tanning.[R25]
Game uses:
- clothing
- footwear
- straps
- water-resistant containers
- tool grips
- harness later

### C. Fiber and cordage
The settlement should start recognizing plant and animal fibers as an economy:
- cordage
- nets
- woven mats
- bags
- rough thread
- eventual textile path

### D. Basic horticulture / early agriculture
Early agriculture emerged independently in multiple regions and intensified how humans extracted useful food, fiber, and other resources from land.[R1]
In gameplay, the earliest agricultural step should not instantly be plowed grain farming. It should begin with:
- tending favored wild plants
- clearing patches
- seed saving
- transplanting useful species
- protecting crops from animals
- storing seed for next season

### E. Camp sanitation becomes settlement sanitation
Safe water and sanitation are foundational to public health and prosperity.[R14][R15]
At this stage the player needs:
- separated water-fetch area
- separated washing area
- latrine placement rules
- refuse disposal
- carcass disposal
- drainage awareness

## 8.5 Buildings / structures
- clay pit
- pottery work area
- pit kiln / simple kiln
- improved storehouse
- latrine
- fenced drying yard
- food processing hut
- seed store
- fenced garden plots

## 8.6 Roles that start to appear
With a second or third NPC, labor can finally separate into functions:
- gatherer / water hauler
- hunter / trapper
- camp maintainer
- cook / preserver
- hide worker
- clay worker
- toolmaker

## 8.7 Transition gate
The settlement can survive across seasons with some stored food, some stored fuel, and some stored seed.

---

# Era 3 — Hamlet and First Surplus Economy

## 9.1 Era identity
This is the first true colony era.

The settlement now depends less on pure foraging and more on **planned seasonal production**.

## 9.2 Main bottleneck
Food surplus.

Without a clear surplus, you cannot safely add NPCs who do not directly gather food.

## 9.3 Key systems to unlock

### A. Fields and seasonal planning
The shift from gathered food to regularized cultivation should include:
- land clearing
- digging tools and hoes
- seed selection
- sowing windows
- weed control
- pest protection
- harvest labor spikes
- threshing, drying, storage

### B. Granary / secure storage
Spoilage, rodents, moisture, and theft/pests must become visible constraints.
A granary is one of the first major civilization buildings because it:
- stabilizes population
- enables more workers
- allows seed reservation
- supports trade

### C. Domestication path
Domestication is not one unlock. It is a sequence:
- taming or managing presence
- selective retention
- breeding control
- sheltering and feeding
- disease burden
- manure handling
- security from predators

Game uses:
- meat
- milk later
- wool/hair
- hides
- traction later
- manure
- eggs
- social/pest costs

### D. Textile path begins properly
Weaving is the interlacing of two sets of yarns on a loom, and spinning technology later greatly increased textile throughput.[R4][R26]
A believable textile chain:
1. grow or harvest fibers / wool
2. clean
3. dry
4. separate / comb / card
5. spin
6. weave
7. cut and sew
8. repair and recycle rags

### E. Simple accounting / memory aids
Realistic scaling soon requires:
- counts
- stores
- seasonal expectations
- “do not eat the seed stock”
- labor assignment
- ownership / communal allocation rules

At first this can be non-written. Later it becomes ledgers and administration.

## 9.4 Buildings
- field plots
- granary
- animal pen
- spinning space
- weaving hut / loom shelter
- improved kitchen / baking area
- smokehouse
- storage yard
- fenced work yards

## 9.5 NPC roles
- farmer
- seed keeper
- herder
- spinner
- weaver
- cook/preserver
- storekeeper
- builder

## 9.6 Transition gate
The colony can now support at least a few non-food specialists during part of the year.

---

# Era 4 — Agrarian Village and Basic Craft Specialization

## 10.1 Era identity
This is the moment society begins to differentiate into trades.

## 10.2 Core realism law
Specialists exist only because the farming base, storage base, and building base support them.

## 10.3 Major systems

### A. Animal power
Draft animals were historically used for heavy loads and farm work long before mechanization.[R23]
The game should treat animal traction as a huge productivity leap because it multiplies:
- plowing
- hauling
- logging
- milling support
- transport distance
- construction throughput

But it also adds:
- fodder burden
- harness making
- veterinary burden
- stable cleaning
- manure management

### B. Plow and improved agriculture
Fields now shift from hand cultivation only to:
- ard/plow use
- animal traction
- better tillage
- larger plots
- reduced labor per area
- stronger need for roads and storage

Crop rotation should matter. The medieval three-field system increased productive land use by leaving only one-third fallow instead of half, while legumes improved soil and diet.[R22]

### C. Carpentry and joinery
Now the village can build:
- framed shelters
- carts
- wheels
- doors
- ladders
- barrels later
- sheds and barns
- simple furniture
- better storage fixtures
- improved looms and presses

### D. Charcoal and high-temperature craft
Charcoal is a major transition fuel because it enables higher, cleaner, more controllable heat than raw wood.
It becomes critical for:
- metalworking
- lime burning
- some ceramics
- later larger furnaces

### E. Basic metalworking
A realistic metalworking sequence:
1. locate ore or gather native metal / trade scrap
2. mine or collect
3. roast / prepare ore in some cases
4. smelt or melt depending on metal
5. hammer/cast
6. sharpen / finish
7. repair / recycle

For iron, early smelting used the bloomery process: iron ore mixed with charcoal in a furnace was chemically reduced, producing a spongy bloom rather than fully melted iron.[R5]

### F. Soap / cleaning
Soap made from fats and alkali ash is an important domestic/public health progression, not just a luxury.[R24]
It improves:
- hygiene
- cloth cleaning
- workshop cleaning
- some medical outcomes indirectly
- trade goods

### G. Lime and mortar path
Kilns later support burning lime and making stronger masonry materials.[R3]
This opens:
- improved masonry
- plaster
- sanitation structures
- better waterproofing and foundations in some contexts

## 10.4 Buildings
- animal stable / barn
- plow shed
- charcoal pit / charcoal yard
- smithy
- forge shelter
- carpentry shed
- wheelwright shop
- soap-making area
- lime kiln
- communal storehouse

## 10.5 NPC roles
- farmer
- plowman / animal handler
- blacksmith
- charcoal burner
- carpenter
- wheelwright
- soapmaker
- builder / mason
- store manager

## 10.6 Transition gate
The settlement can support year-round specialists and produce durable tools more reliably.

---

# Era 5 — Market Village to Town

## 11.1 Era identity
The economy shifts from “we make what we need” toward “we make enough of some things to exchange.”

## 11.2 What changes here
Scale and coordination matter more than bare survival.

The settlement now needs:
- transport improvements
- roads
- storage discipline
- regular exchange
- more durable buildings
- role-based labor schedules
- maintenance routines
- dispute/governance systems

## 11.3 Major systems

### A. Wheeled transport and hauling
Once wheelmaking, axles, animal traction, and road maintenance exist, the economy expands massively.
This increases:
- wood hauling
- stone hauling
- crop movement
- building throughput
- trade radius

### B. Market formation
A town economy begins when:
- goods arrive at central places
- inventory must be counted
- exchange rates stabilize
- specialists depend on purchase/trade instead of direct production

### C. Masons and durable construction
Stone and brick matter more at this stage.
Quarried stone, fired brick, lime, timber framing, and roof tiles should emerge as parallel construction branches.

### D. Glass begins to matter
Soda-lime glass historically relied on silica sand, limestone, and soda ash / alkali.[R27]
In-game glass should unlock:
- windows
- bottles
- lantern covers
- labware later
- improved storage and trade packaging later

### E. Water management
Now the settlement can justify:
- dug wells
- lined wells
- drainage ditches
- cisterns
- maybe canals or managed irrigation later

### F. First institutional buildings
- meeting hall
- storehouse / warehouse
- market square
- watchtower / guard post
- shrine / school / archive equivalents
- bath / washhouse depending setting

## 11.4 Buildings
- market
- warehouse
- cart shed
- wagon repair shop
- expanded smithy
- masonry yard
- glasshouse or proto-glass workshop
- road depot
- administration hall

## 11.5 NPC roles
- trader
- porter/hauler
- wagon maker
- warehouse keeper
- bookkeeper / scribe
- mason
- glassworker
- guard
- administrator

## 11.6 Transition gate
The settlement can coordinate multiple supply chains across seasons and across distance.

---

# Era 6 — Pre-Industrial Power Town

## 12.1 Era identity
The town starts replacing muscle with **continuous mechanical power**.

## 12.2 Why this is a huge jump
Waterwheels were among the earliest machines and later powered mills, sawmills, pumps, forge bellows, hammers, and textile operations.[R21][R28]

This is one of the best realism-based game gates you can build because it changes everything without jumping straight to steam.

## 12.3 Main systems

### A. Water power
Water power can drive:
- grain milling
- sawing timber
- forge bellows
- tilt hammers / trip hammers
- pumping
- textile fulling and other repetitive motion

This should reduce labor demand but increase capital demand:
- dam/weir/race construction
- maintenance
- seasonal water variability
- site dependence

### B. Sawmills
A sawmill turns raw logs into regular boards much faster and more uniformly than hand sawing.
That improves:
- building speed
- vehicle production
- furniture
- packaging/crates
- industrial structures later

### C. Improved metallurgy
Now the town pushes beyond tiny bloomery scale.
Historically, charcoal was replaced by coke in blast furnaces as coal-based metallurgy expanded, helping create the materials base needed for sophisticated machinery.[R6][R7]

In game terms, this era should introduce the prerequisites for large iron/steel throughput:
- better ore supply
- fuel supply chain
- furnace construction
- bellows / blast systems
- refractory needs
- slag handling
- ore transport

### D. Standardized components begin
This is a precondition for the industrial future:
- regular bar stock
- nails and fasteners
- hinges
- tool sets
- repeatable wheel sizes
- standard timber lengths
- measured containers

### E. Urban public health pressure rises
Once density goes up, sanitation cannot stay informal.
Clean water, waste removal, and drainage become city-making technologies, not background details.[R12][R13][R14][R15]

## 12.4 Buildings
- waterwheel mill
- sawmill
- pumped water station / mill pump
- improved foundry
- larger forge
- lime and brick yards
- roadworks depot
- slaughter / tannery zone separated from housing
- dedicated waste area

## 12.5 NPC roles
- miller
- millwright
- sawyer
- foundry worker
- furnace tender
- ore hauler
- mason
- road crew
- sanitary laborers
- water maintainers

## 12.6 Transition gate
The town can sustain non-stop powered workshops and maintain more standardized materials.

---

# Era 7 — Early Industrial City

## 13.1 Era identity
This is the age of steam, coal, factories, rail, and machine tools.

## 13.2 Why the industrial leap matters
Steam engines turned heat into mechanical work under pressure, making location-independent power possible where fuel and boilers could be supplied.[R9]

The combination of better metallurgy, steam power, and machine tools is what allows civilization to escape dependence on animal/water power alone.

## 13.3 Core breakthroughs

### A. Coal and coke economy
The city now needs:
- coal mining
- coal hauling
- coke production
- ash handling
- air pollution burden
- labor safety systems

### B. Steam engines
Steam engines unlock:
- mine drainage
- factory line shafts
- pumps
- locomotion
- municipal power before electrification
- large stationary processing plants

### C. Machine tools and interchangeable parts
Mass production became possible when machine tools allowed large numbers of identical parts to be made with precision.[R8]
This is one of the most important late-midgame realism gates in the entire design.

Before this point:
- a smith can make a part
- but repairs are custom and slow

After this point:
- bolts, shafts, gears, bushings, and housings can be standardized
- repair becomes a system
- complex machines become sustainable

### D. Rail / bulk transport
The industrial city should eventually unlock:
- rail beds
- locomotives
- rolling stock
- stations
- freight yards
- scheduled delivery

This massively changes heavy industry viability.

### E. Industrial public health
Historical urbanization without sanitation was catastrophic.
This era should sharply pressure the player to build:
- municipal water intake
- filtration/treatment later
- sewer networks
- waste collection
- burial/medical systems
- zoning separation

### F. Cement, masonry, and aggregates at scale
Hydraulic cements, aggregates, and processed stone/sand/gravel become essential for roads, foundations, bridges, and industrial buildings.[R19][R20]

## 13.4 Buildings
- coal mine
- coke ovens
- steam engine house
- boiler house
- machine shop
- rail workshop
- foundry
- steelworks / large ironworks
- municipal pump station
- sewer main / early treatment facilities
- brickworks / cement works

## 13.5 NPC roles
- miner
- boiler operator
- engine mechanic
- machinist
- pattern maker
- foundry worker
- rail engineer
- surveyor
- waterworks operator
- sanitation engineer / foreman
- clerk / scheduler

## 13.6 Transition gate
The city can produce precise metal components, move bulk freight, and sustain powered industry at scale.

---

# Era 8 — Electrified Industrial City

## 14.1 Era identity
Power becomes much more flexible.

Electric generators convert mechanical energy to electricity for transmission and distribution.[R10]  
Practical AC systems became decisive because DC was inefficient for long-distance transmission.[R11]

## 14.2 Why electrification matters
Electricity changes not only power, but coordination:
- machines no longer all need to sit on one line shaft
- lighting extends productive hours
- pumps, communications, controls, and later refrigeration all improve
- distributed workshops become more practical
- public utilities become deeper systems

## 14.3 Core systems

### A. Power generation
Possible generation paths:
- steam turbine/generator
- hydroelectric later if geography allows
- local industrial generators

### B. Transmission and distribution
The player should need:
- poles/towers
- conductors
- insulators
- transformers / substations later
- maintenance crews
- outage management

### C. Copper and wire production
Electrical industries use large amounts of high-conductivity copper, and copper wire requires refined copper rolled/drawn into rods and wire.[R29]

### D. Lighting and machine electrification
New buildings and systems:
- electric workshops
- street lighting
- pumping stations
- refrigeration/cold storage later
- communication infrastructure

### E. Urban water and sewer scale-up
The city now depends on true utility logic:
- water intake
- treatment
- storage
- pressure/distribution
- sewage collection
- treatment/discharge

Municipal wastewater collection and treatment are vital to public health and clean water.[R13]

## 14.4 Buildings
- power plant
- generator hall
- wire works
- transformer/substation facilities
- electric machine shop
- expanded waterworks
- sewer treatment works
- cold storage
- telegraph/telephone infrastructure later if desired

## 14.5 NPC roles
- electrical engineer
- lineman
- generator operator
- wire drawer / copper worker
- pump operator
- refrigeration operator
- urban maintenance crews
- utility planner

## 14.6 Transition gate
The city sustains continuous utilities and electrically powered industry.

---

# Era 9 — Chemical / Petroleum / Mechanized Agriculture City

## 15.1 Era identity
This is where the city stops being only heavy-mechanical and becomes modern-industrial.

## 15.2 Core jumps

### A. Petroleum refining
Petroleum refineries are complex, expensive industrial facilities that convert crude oil into fuels and chemical feedstocks.[R17]
This matters because modern society increasingly depends on:
- diesel
- gasoline
- lubricants
- asphalt
- petrochemical feedstocks
- plastics and synthetic materials

### B. Diesel fuel and engines
Most diesel is refined from crude oil; diesel tractors depend on a broader fuel supply chain, not just an engine recipe.[R18]

### C. Fertilizer revolution
The Haber-Bosch process combined nitrogen from the air with hydrogen under high pressure and temperature to produce ammonia, enabling industrial nitrogen fertilizer.[R16]
This is one of the largest productivity jumps in agricultural history.
In gameplay it should support:
- higher yields
- larger urban populations
- reduced land pressure per output
- but increased dependence on chemistry and energy

### D. Batteries
Lead-acid batteries became the classic automotive storage battery.[R30]
They matter for:
- starting engines
- lighting and ignition/electrical systems
- backup power for vehicles and workshops

### E. Rubber and synthetic materials
Synthetic rubber became a major industrial material, with large tire applications and petrochemical feedstocks.[R31]
Modern tractors and vehicles depend on:
- tires
- hoses
- seals
- belts
- wire insulation in many cases
- flooring and damping materials

### F. Modern coatings and corrosion control
Paints/coatings become important not just visually but for:
- rust resistance
- weathering
- product lifespan
- sanitation of some equipment and buildings

## 15.3 Agricultural mechanization
This is the point where:
- animal traction begins losing ground to engines
- farms consolidate around machines
- spare parts, workshops, fuel, and roads become critical
- labor shifts from pure fieldwork to equipment operation and maintenance

## 15.4 Buildings
- refinery
- lubricant plant
- battery shop/factory
- chemical fertilizer plant
- tire/rubber works
- engine works
- machine assembly halls
- bulk fuel depot
- industrial testing lab
- agricultural equipment dealer/service center

## 15.5 NPC roles
- chemical engineer
- refinery operator
- diesel mechanic
- battery assembler
- quality inspector
- supply planner
- agricultural equipment assembler
- fleet manager

## 15.6 Transition gate
The city can support internal combustion agriculture, synthetic materials, and modern logistics.

---

# Era 10 — Integrated Modern City

## 16.1 Era identity
The city is now a system-of-systems.

This is not merely “more factories.”  
It is a complex urban organism with:
- utilities
- food chains
- retail/distribution
- repair networks
- education
- healthcare
- administration
- zoning
- mobility
- waste and recycling
- standards and regulations
- training and certification

## 16.2 What a functioning modern city needs
At minimum:

### Food system
- farms
- storage
- processing
- wholesale distribution
- retail
- refrigeration
- packaging
- sanitation inspection

### Water system
- intake
- treatment
- storage
- pressure network
- maintenance

### Waste system
- sewer collection
- treatment
- solid waste collection
- landfill/incineration/recycling options
- hazardous waste paths later

### Shelter/building system
- aggregates
- cement
- steel
- lumber
- glass
- electrical components
- plumbing
- skilled trades
- permits/admin layer if you want realism depth

### Mobility system
- roads
- vehicles
- fuel
- repair shops
- signage/control
- freight planning

### Industrial system
- raw inputs
- component suppliers
- assembly plants
- quality control
- spare parts
- warehouses

### Human capital system
- schools
- apprenticeships
- libraries
- technical institutes
- management / scheduling
- healthcare and injury recovery

## 16.3 City roles that should exist by late game
Not just:
- miners
- smelters
- machinists
- farmers

Also:
- teachers
- nurses/doctors
- sanitation crews
- water operators
- utility dispatchers
- drivers
- clerks
- accountants
- mechanics
- store managers
- inspectors
- engineers
- planners
- construction crews
- warehouse staff
- cleaners
- cooks
- administrators

This is what makes the society feel real.

---

# 7. The realistic starting progression in plain steps

This section restates the game progression as a clear practical chain from “naked NPC” to “city.”

## Phase A — Stay alive
1. Find water source
2. Build temporary shelter
3. Make fire
4. Gather edible calories
5. Make crude tools
6. Improve sleep and dryness
7. Reduce illness risk from filth and water

## Phase B — Stabilize survival
8. Improve hunting / trapping / fishing
9. Preserve food
10. Build better shelter
11. Create storage
12. Make basic clothing and footwear
13. Separate waste from living space
14. Store fuelwood

## Phase C — Establish place
15. Build permanent camp
16. Start clay/container production
17. Start seed saving
18. Start garden plots
19. Fence/protect useful areas
20. Create named work zones
21. Attract or support 1–3 more NPCs

## Phase D — Create surplus
22. Plant regular crops
23. Build granary
24. Process hides/fibers more reliably
25. Add spinning/weaving
26. Keep small livestock
27. Expand housing
28. Assign first permanent roles

## Phase E — Support specialists
29. Build smithy/carpentry/tannery/loom areas
30. Produce charcoal
31. Smelt/process first metals
32. Build animal traction systems
33. Construct carts/wheels/plows
34. Increase field scale
35. Improve roads and hauling

## Phase F — Become a village economy
36. Build market and warehouse
37. Add bookkeeping/storage accounting
38. Expand masonry and lime use
39. Improve wells/drainage
40. Trade for missing materials
41. Add governance/admin roles

## Phase G — Harness continuous power
42. Build water mills
43. Build sawmill
44. Mechanize repetitive work
45. Scale metalworking
46. Standardize materials and component sizes
47. Improve public sanitation

## Phase H — Industrialize
48. Mine coal at scale
49. Produce coke
50. Build steam power
51. Build machine tools
52. Produce interchangeable parts
53. Expand rail/heavy freight
54. Build utility-style water and waste systems

## Phase I — Electrify
55. Build generators
56. Build electrical distribution
57. Produce/install copper wiring
58. Electrify workshops
59. Increase pumping, lighting, refrigeration, communications

## Phase J — Modernize
60. Refine petroleum
61. Produce diesel/lubricants
62. Produce industrial fertilizer
63. Build engine and machine assembly industries
64. Introduce tractors and modern farm equipment
65. Create modern maintenance/service economy
66. Support a multi-layered urban society

---

# 8. NPC design for this game

## 18.1 Recommended NPC stat model

### Biological / physical
- strength
- endurance
- dexterity
- resilience
- disease resistance
- heat/cold tolerance

### Cognitive / behavioral
- curiosity
- discipline
- caution
- sociability
- patience
- problem-solving

### Interests
Examples:
- plants
- animals
- making things
- numbers/accounting
- tools/machines
- cooking
- caring/healing
- trade
- building
- teaching
- exploration

### Aptitudes
Examples:
- farming aptitude
- mechanical aptitude
- craft precision
- spatial reasoning
- memory
- leadership
- medical aptitude

### Skills
Examples:
- foraging
- hunting
- carpentry
- masonry
- pottery
- smithing
- spinning
- weaving
- herding
- cooking
- administration
- teaching
- machine operation
- maintenance
- chemistry
- electrical work

## 18.2 Interest as training speed
Your idea is excellent:
- **interest modifies willingness and speed**
- **aptitude modifies efficiency ceiling and error rate**
- **practice time produces actual skill growth**

A high-interest low-aptitude NPC can become competent slowly and happily.
A high-aptitude low-interest NPC can learn but may resist, burn out, or underperform.

## 18.3 Roles vs jobs
An NPC should have:
- **primary role** (farmer, carpenter, machinist)
- **secondary competencies** (hauling, repair, cleaning, basic defense)
- **emergency fallback tasks**

This matters for realism because real societies survive through redundancy.

## 18.4 Learning paths
Skill gains should come from:
- practice
- supervision/apprenticeship
- written manuals later
- institutional training later
- experimentation and failures
- exposure to better tools and processes

## 18.5 Social realism
NPCs should care about:
- safety
- family/relationships
- competence fit
- workload fairness
- housing quality
- status/pride
- food quality
- access to clothing, warmth, hygiene, rest
- confidence in leadership

This is what makes a city feel populated by people rather than robots.

---

# 9. Knowledge progression model

A normal “tech tree” is too gamey for your concept.  
A better model is a **knowledge ecology**.

## 19.1 Categories of knowledge

### Discovery knowledge
“We found clay that survives firing.”

### Procedural knowledge
“This is how you consistently shape and fire a storage pot.”

### Tool knowledge
“This mold/jig/tool makes the work repeatable.”

### Measurement knowledge
“This part must be this size and tolerance.”

### Institutional knowledge
“We train new workers like this, inspect output like this, maintain the machine like this.”

### Scientific knowledge
“This reaction, pressure, or circuit behaves in this predictable way.”

## 19.2 Unlock sources
- repeated success
- observed natural patterns
- reverse engineering
- teachers
- books
- experiments
- schools and laboratories
- traders bringing techniques

## 19.3 Realistic late-game truth
A modern city depends on **codified and institutional knowledge**, not just talented individuals.
That means schools, manuals, standards, and records must matter.

---

# 10. Buildings as institutions, not just recipes

A realism-first game should avoid making buildings mere shells with flat percentage bonuses.

A building should provide one or more of:
- environment
- capacity
- workflow structure
- safety
- storage
- power access
- sanitation access
- supervision
- quality control
- training value
- maintenance requirements

## 20.1 Example
A “Machine Shop” is not just a place to craft gears.
It implies:
- machine tools
- power supply
- cutters and tooling
- measuring tools
- lubricants
- skilled labor
- raw stock
- scrap handling
- maintenance schedule
- sometimes drawings/standards

The same principle should apply all the way down to:
- tannery
- bakery
- hospital
- market
- waterworks
- power plant

---

# 11. The tractor case study

This is the kind of realism chain you explicitly asked for.

## 21.1 First principle
A tractor should be **very late game**.

Why? Because a tractor depends on:
- advanced metallurgy
- standardized and interchangeable parts
- precision machining
- internal combustion engine production
- fuel refining
- electrical system manufacturing
- tires / rubber industry
- glass and lighting components
- lubricants and coolants
- assembly tooling
- repair ecosystem
- roads / service logistics
- farms large enough to justify the machine

A modern farm tractor is built around major systems such as engine, fuel, cooling, electrical, hydraulics, transmission, hitching, and traction systems.[R32]

## 21.2 Tractor major systems (game-facing)
Use these as the main assembly branches.

### 1. Power unit
- engine block / structure
- pistons / rods / crankshaft
- cylinder head / valves
- air intake
- fuel injection system
- exhaust system
- lubrication system
- cooling system

### 2. Drivetrain
- clutch or equivalent transfer
- gearbox / transmission
- differential
- final drives
- axles

### 3. Hydraulic system
- pump
- valves
- cylinders
- hoses / lines
- hydraulic fluid reservoir

### 4. PTO and hitching
- PTO shaft and controls
- drawbar / hitch frame
- three-point hitch or equivalent
- linkage components

### 5. Chassis / frame
- structural members
- mounting points
- protective housings
- fenders
- operator platform or cab frame

### 6. Traction
- wheels/rims
- hubs
- tires or tracks
- steering linkage

### 7. Electrical system
- battery
- starter
- alternator / generator
- wiring harness
- switches
- gauges
- lights
- sensors / basic control units later

### 8. Operator environment
- seat
- control levers/pedals
- steering wheel
- safety frame / ROPS or cab
- visibility items / glass later
- weather sealing and HVAC much later

### 9. Consumables
- diesel fuel
- engine oil
- hydraulic / transmission fluid
- grease
- coolant
- filters

## 21.3 Tractor upstream dependency tree

### Tier A — raw extractive industries
You need:
- iron ore
- coal or other metallurgical fuel route
- limestone
- copper ore
- silica sand
- lead
- crude oil or major biofuel substitute path
- sulfur / sulfur chemistry for some processes
- timber for patterns/crates/buildings
- water in large industrial volumes

### Tier B — basic heavy materials
From those, you need:
- cast iron / pig iron / steel path
- rolled steel plate, bar, rod, sheet
- copper conductor stock
- glass batch materials
- rubber inputs (natural or synthetic)
- acids/alkalis/industrial chemicals
- coatings and pigments
- fastener metal stock

### Tier C — component industries
You then need factories or workshops for:
- castings
- forgings
- machining
- gear cutting
- shaft making
- bolt/nut/screw production
- bearings/bushings
- springs
- hoses/seals
- wire and cable
- battery assembly
- lamp/lens production
- glass forming
- paint/coating
- radiator/cooling components
- filters
- seat/upholstery/trim

### Tier D — sub-assemblies
Then:
- engine assembly
- gearbox assembly
- hydraulic assembly
- axle and wheel hub assembly
- electrical harness assembly
- operator control assembly
- chassis/frame weldment
- tire + wheel mounting
- fuel and cooling sub-systems

### Tier E — final assembly
Finally:
- frame/chassis setup
- powertrain install
- hydraulics install
- electrical install
- wheels/tires
- controls/cab/seat
- fluids fill
- testing
- paint/finish
- inspection
- shipping

## 21.4 Tractor building chain in gameplay terms

### Prerequisite civilization state
To make a tractor in your game, the society should already have:
- abundant food surplus
- large farms or clear demand for mechanization
- fuel distribution
- roads passable for heavy transport
- machine shops
- foundry/casting capability
- steel production or dependable import chain
- battery production or trade
- tire/rubber source
- electrical wiring capability
- trained mechanics
- spare-part storage
- service garages

### Required buildings
At minimum, either locally or through trade:
- mine(s)
- smelter / steelworks
- foundry
- machine shop
- fastener shop
- wire works
- battery shop
- glassworks
- rubber/tire works
- paint/coating shop
- engine works
- gearbox assembly shop
- hydraulic shop
- final vehicle assembly plant
- test yard
- fuel depot
- repair garage

### Required NPC specializations
- miners
- metallurgists
- foundry workers
- machinists
- fitters/assemblers
- welders or equivalent metal joiners
- electricians
- battery technicians
- glassworkers
- rubber workers
- painters/coaters
- engine mechanics
- quality inspectors
- logistics workers
- parts clerks
- maintenance mechanics

## 21.5 Tractor as a realistic game unlock
A good design is:
- **not** “research tractor”
- instead, tractor becomes possible only after multiple enabling industries exist

Suggested unlock criteria:
- steel throughput above X
- fuel production/distribution above Y
- interchangeable parts capability unlocked
- machine tooling tier unlocked
- battery + wire + lighting available
- farm acreage or labor shortage makes mechanization rational
- maintenance workforce available
- spare parts stock system available

This makes the tractor feel earned and believable.

## 21.6 Tractor operating realism
The tractor should not simply boost farm output forever.
It should also require:

### Daily/regular
- fuel
- operator
- lubrication
- inspections

### Periodic
- oil changes
- filter changes
- tire wear replacement
- belt/hose replacement
- battery replacement
- hydraulic leak repair
- starter/alternator issues
- bearing wear
- cooling problems
- seasonal storage / weathering issues

### Strategic
- trained mechanics
- spare parts warehouse
- road access
- workshop downtime
- supply chain interruption sensitivity

That is the real gameplay gold: modern productivity comes with modern dependency.

## 21.7 Farm-side realism
A tractor is only valuable if the rest of the farm can use it.
That means the farm also needs:
- implements
- fuel access
- storage tank / depot
- operator skill
- spare tires or repair access
- replacement filters and fluids
- enough field size to justify the machine
- maintained lanes/roads
- crops and schedules that benefit from mechanization

## 21.8 Best way to convert this into game systems
Model the tractor as:
- one **final assembly recipe**
- fed by many **sub-assemblies**
- each fed by upstream industries
- with an ongoing **maintenance bill**
- and a **utilization curve**

So instead of “1 tractor = +500 food”
you get:
- Tractor availability
- Implement compatibility
- Fuel availability
- Operator availability
- Maintenance condition
- Spare parts stock
- Field conditions

This is much more realistic and much more interesting.

---

# 12. What the game should simulate explicitly vs abstract

## 22.1 Simulate explicitly in early game
Because early game is about tactile survival:
- sticks, stones, hides, raw food
- shelter pieces
- small containers
- tool wear
- carrying burden
- individual meals
- sleep quality
- weather exposure

## 22.2 Semi-abstract in midgame
Once settlements form:
- batches of pottery
- textile lots
- charcoal burns
- harvest bundles
- livestock herds
- building material stockpiles
- workshop queues

## 22.3 More abstract in late game
Once industrial society exists:
- utility flows
- freight tonnage
- standard part categories
- maintenance budgets / part stocks
- district demand
- wholesale inventories
- educational throughput

This scaling of simulation resolution will keep the game playable.

---

# 13. What makes this concept different from normal city builders

Your concept becomes special if you commit to these principles:

## 23.1 No “magic craft menu”
A recipe only appears when the society has enough evidence, teaching, or infrastructure to do it.

## 23.2 Labor is embodied
People are not generic workers.
They have:
- interests
- aptitudes
- training histories
- health states
- morale
- social roles

## 23.3 Production is path dependent
A late-game item is not just expensive.  
It depends on everything before it.

## 23.4 Utilities are real
Water, waste, fuel, power, and transport are actual systems.

## 23.5 Society is more than industry
A city fails without:
- cleanliness
- governance
- records
- repair
- distribution
- education
- healthcare
- morale

---

# 14. Suggested “first playable” scope

Because the whole concept is huge, the smartest version-1 playable slice is not “everything until tractors.”

It is:

## 24.1 Recommended vertical slice
**From lone NPC -> primitive camp -> permanent camp -> small hamlet with 3–8 NPCs**

That slice alone can already prove:
- needs simulation
- interests and skill growth
- roles
- survival crafting
- food preservation
- shelter upgrading
- first agriculture
- early pottery
- first specialization

## 24.2 Why this is the right first playable
Because it validates the hardest and most unique parts:
- believable bootstrapping
- realistic survival pressure
- labor bottlenecks
- NPC role differentiation
- knowledge progression
- social expansion from 1 to several people

If this slice works, everything later can stack on top of it.

## 24.3 Recommended milestone order for development
1. One NPC survival loop
2. Primitive resource gathering and hauling
3. Shelter, fire, water, food, sleep systems
4. Task scheduling and fatigue
5. Skill + interest progression
6. Basic crafting and preservation
7. Storage and spoilage
8. Second NPC / role assignment
9. Seasonal agriculture
10. First permanent camp buildings
11. Pottery / hides / weaving beginnings
12. Small-settlement management layer

Only after that should you start building:
- metallurgy
- animal traction
- markets
- milling
- utilities
- industrial systems
- vehicles

---

# 15. Recommended database structure for your future content

To support this game, every thing in the world should probably be stored in a dependency-friendly format.

## 25.1 For each item
- name
- category
- subcategory
- raw/proc/intermediate/final
- mass/volume
- perishability
- decay conditions
- stack behavior
- transport difficulty
- inputs
- outputs
- tool requirements
- workstation/building requirements
- knowledge requirements
- utility requirements
- labor skill requirements
- byproducts
- waste generated
- maintenance use
- repair use
- downstream uses

## 25.2 For each building
- footprint
- structural materials
- construction steps
- required trades
- required tools
- required utilities
- maintenance burden
- staffing roles
- production capacity
- sanitation impact
- pollution/waste outputs
- training bonus
- storage integration
- adjacency or logistics effects

## 25.3 For each process
- batch or continuous
- setup time
- labor intensity
- skill sensitivity
- failure chances
- quality outputs
- energy/fuel inputs
- maintenance/tool wear
- pollution/waste
- seasonal constraints

This database-first approach will save you later.

---

# 16. Open design decisions for the next draft

These are the main questions still worth deciding before the document becomes v0.2 or v1.0.

## 26.1 Recruitment model
How do new NPCs arrive?
- migration
- births
- rescues
- contracts
- conquest
- mixed model

## 26.2 Knowledge realism level
How strict should the start be?
- “blank slate human”
- “ordinary modern human with common intuition”
- “historically grounded primitive know-how”
- “player omniscience but NPC institution gating”

## 26.3 Combat/security importance
How much focus on:
- predators
- raids
- bandits
- war
- policing

## 26.4 Disease model complexity
Do you want:
- very light disease pressure
- sanitation-linked outbreaks
- full epidemiological layer

## 26.5 Trade reliance
How autarkic must the city be?
- fully self-built ideal
- heavy reliance on trade
- mixed local + import economy

## 26.6 Modern endpoint
How modern do you want the final city to become?
- early 20th century
- late 20th century
- contemporary
- near-future

This matters because contemporary society quickly reaches electronics, semiconductors, telecom, pharmaceuticals, and global supply chains, which are much harder to model realistically.

---

# 17. Recommended next step after this document

For the next iteration, the strongest move is **not** to expand the whole world equally.

It is to create one of these:

### Option A — Early game design bible
Detailed day 1 -> year 1 systems:
- needs
- resource list
- tasks
- skills
- buildings
- seasonal survival

### Option B — Dependency database seed
A structured list of:
- 200–500 early items
- 100–200 early buildings
- 100–200 processes
- with prerequisites and uses

### Option C — Progression chart
A giant dependency map from:
- shelter
- fire
- water
- food
to:
- mills
- metallurgy
- roads
- utilities
- vehicles

### Option D — NPC simulation spec
Traits, interests, skills, schedules, morale, health, teaching, specialization, labor efficiency.

For pure productiveness, I would recommend **Option A first**, then **Option B**.

---

# 18. Short conclusion

The most realistic and compelling version of your game is not “craft everything manually forever.”  
It is:

- start with one vulnerable person
- bootstrap survival systems
- turn survival into seasonal stability
- turn stability into food surplus
- turn surplus into specialization
- turn specialization into institutions
- turn institutions into energy, logistics, and industry
- turn industry into a city
- and make every modern convenience visibly dependent on layers of upstream work

That structure is historically grounded, mechanically deep, and very different from ordinary idle games.

The tractor example proves the core philosophy:
a late-game machine should feel like the visible tip of an entire civilization.

---

# References

These references were used as grounding for the realism and progression logic in this first draft.

- [R1] Britannica, *How agriculture and domestication began*  
  https://www.britannica.com/topic/agriculture/How-agriculture-and-domestication-began

- [R2] Britannica, *Pottery*  
  https://www.britannica.com/art/pottery

- [R3] Britannica, *Kiln*  
  https://www.britannica.com/technology/kiln-oven

- [R4] Britannica, *Weaving*  
  https://www.britannica.com/technology/weaving

- [R5] Britannica, *Bloomery process*  
  https://www.britannica.com/technology/bloomery-process

- [R6] Britannica, *Blast furnace*  
  https://www.britannica.com/technology/blast-furnace

- [R7] Britannica, *History of technology: Development of industries*  
  https://www.britannica.com/technology/history-of-technology/Development-of-industries

- [R8] Britannica, *Interchangeable parts*  
  https://www.britannica.com/technology/interchangeable-parts

- [R9] Britannica, *Steam engine*  
  https://www.britannica.com/technology/steam-engine

- [R10] Britannica, *Electric generator*  
  https://www.britannica.com/technology/electric-generator

- [R11] Britannica, *Electric power*  
  https://www.britannica.com/technology/electric-power

- [R12] Britannica, *Water supply system*  
  https://www.britannica.com/technology/water-supply-system

- [R13] U.S. EPA, *Municipal Wastewater*  
  https://www.epa.gov/npdes/municipal-wastewater

- [R14] WHO, *Drinking-water*  
  https://www.who.int/news-room/fact-sheets/detail/drinking-water

- [R15] WHO, *Sanitation*  
  https://www.who.int/news-room/fact-sheets/detail/sanitation

- [R16] Britannica, *Haber-Bosch process*  
  https://www.britannica.com/technology/Haber-Bosch-process

- [R17] U.S. Energy Information Administration, *Refining crude oil: the refining process*  
  https://www.eia.gov/energyexplained/oil-and-petroleum-products/refining-crude-oil-the-refining-process.php

- [R18] U.S. Energy Information Administration, *Diesel fuel explained*  
  https://www.eia.gov/energyexplained/diesel-fuel/

- [R19] Britannica, *History of cement*  
  https://www.britannica.com/technology/cement-building-material/History-of-cement

- [R20] U.S. Geological Survey, *Construction aggregates*  
  https://www.usgs.gov/publications/construction-aggregates

- [R21] Britannica, *Waterwheel*  
  https://www.britannica.com/technology/waterwheel-engineering

- [R22] Britannica, *Three-field system*  
  https://www.britannica.com/topic/three-field-system

- [R23] Britannica, *Draft animal*  
  https://www.britannica.com/animal/draft-animal

- [R24] Britannica, *Soap and detergent*  
  https://www.britannica.com/science/soap

- [R25] Britannica, *Leather*  
  https://www.britannica.com/topic/leather

- [R26] Britannica, *Textile: Conversion to yarn*  
  https://www.britannica.com/topic/textile/Conversion-to-yarn

- [R27] Britannica, *Soda-lime glass*  
  https://www.britannica.com/technology/soda-lime-glass

- [R28] Britannica, *History of energy conversion technology*  
  https://www.britannica.com/technology/energy-conversion/History-of-energy-conversion-technology

- [R29] Britannica, *Copper processing: the metal and its alloys*  
  https://www.britannica.com/technology/copper-processing/The-metal-and-its-alloys

- [R30] Britannica, *Lead-acid storage battery*  
  https://www.britannica.com/technology/lead-acid-storage-battery

- [R31] Britannica, *Synthetic rubber*  
  https://www.britannica.com/science/synthetic-rubber

- [R32] Purdue Agricultural Safety and Health Program, *Tractor Component Basics*  
  https://www.asec.purdue.edu/tractor/Notes/Notes2%20-%20Tractor%20Component%20Basics.pdf
