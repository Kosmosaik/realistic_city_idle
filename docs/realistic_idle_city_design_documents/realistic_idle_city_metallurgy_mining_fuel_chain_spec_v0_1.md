
---
title: "Realistic Idle City - Metallurgy / Mining / Fuel Chain Spec"
version: "v0.1"
scope:
  - "Village craft specialization through early industrial metallurgy"
  - "Supports later machine tools, utilities, transport, and vehicle industries"
  - "Bridges early camp/hamlet systems into ore extraction, furnace work, forging, casting, and coal/coke scale-up"
assumptions:
  - "Earth-like setting"
  - "Temperate baseline biome unless local geology overrides it"
  - "Realism-first provenance model"
  - "NPC labor, logistics, hazards, and maintenance remain explicit"
author: "OpenAI / ChatGPT"
date: "2026-04-09"
---

# Purpose

This document defines the **metallurgy / mining / fuel chain** for the project.

It explains how the game should move from:
- found or traded native metal and scrap
- to ore recognition and small extraction
- to charcoal-supported village smithing and bloomery iron
- to larger furnaces, foundries, and standardized metal stock
- to coal, coke, steam-era metallurgy, and the industrial materials base required for machine tools, engines, utilities, and vehicles

The design goal is not to turn metallurgy into a short recipe ladder.  
The goal is to make metal production feel like a **full settlement system** involving:

- geology
- fuel supply
- quarrying and mining
- furnace construction
- refractory materials
- air blast systems
- fluxes
- water supply
- ore hauling
- slag and ash handling
- forge/refining work
- skilled labor
- dangerous heat
- maintenance
- downstream demand

This spec is a regular design doc, not a content pack.

---

# 1. Design role of metallurgy in this project

Metallurgy is one of the most important "hard bottleneck" families in the whole game.

It matters because it converts:
- stone-age and organic tool limits
- into durable edge tools
- into better agriculture
- into stronger carts and buildings
- into standardized hardware
- into powered machinery
- into the whole modern industrial chain

That matches the project's existing core logic:
- nothing appears from nowhere
- production is path dependent
- surplus creates specialization
- buildings are institutions, not flat bonuses
- late machines are the visible tip of deep upstream chains

Metallurgy therefore should never feel like:
> put ore + fuel into box -> get metal bars.

Instead it should feel like:
> identify deposit -> organize extraction -> prepare fuel -> build hot-work space -> line furnace -> supply air -> process ore -> refine output -> shape it -> repair tools -> scale only when food/logistics/knowledge allow it.

---

# 2. Scope boundaries

This spec covers:

- geological access to useful mineral and fuel deposits
- prospecting and recognition
- quarrying, surface collection, shallow mining, deeper mining
- ore and mineral classes useful to the game
- charcoal production as the first major metallurgical fuel chain
- native copper / early copper / bronze paths
- bog iron and other small iron sources
- bloomery iron and smithing
- forge refining and bar production
- cast iron / blast furnace logic
- foundries and mold/pattern systems
- coal mining and coke production
- the bridge into early industrial metallurgy
- major hazards, waste, labor, and logistics burdens
- stage gates for village, town, pre-industrial town, and early industrial city

This spec does **not** fully cover:
- complete machine-tool and interchangeable-parts systems
- electricity-specific metals processing
- petroleum and modern chemical metallurgy
- full modern steelmaking methods beyond the level needed to support later design docs

Those get their own later documents.

---

# 3. Core realism rules

## 3.1 Metal is not one material family
The game should distinguish at least:

- native metals
- easily worked low-temperature metals
- copper-alloy systems
- bloomery/wrought iron systems
- cast iron systems
- steel-capable systems
- precious/rare metals
- scrap and reclaim streams

"Metal bar" is too vague for this project.

## 3.2 Fuel quality matters
The jump from:
- raw wood
- to charcoal
- to coal
- to coke

is not cosmetic.
It changes:
- attainable temperature
- furnace stability
- contamination
- scale
- throughput
- logistics radius
- pollution
- settlement siting

## 3.3 Hot-work space is an institution
A forge, bloomery, foundry, or blast furnace is never just a workstation.
It requires:
- dry stock handling
- tools
- fuel staging
- refractory maintenance
- air supply
- water nearby for some tasks
- slag/ash disposal
- safe clearances
- skilled supervision
- routine repair

## 3.4 Ore quality and preparation matter
The same "iron ore" should not always behave the same.
Game-relevant variation should include:
- richness / grade
- gangue burden
- moisture
- phosphorus or sulfur burden if modeled later
- lump size
- whether roasting helps
- whether beneficiation/sorting is needed

## 3.5 Early metal is scarce, inconsistent, and labor-heavy
Before industrial scaling:
- blooms vary
- bars vary
- castings vary
- tools need reworking
- scrap is valuable
- repair and recycling matter a lot

## 3.6 Industrial metallurgy is impossible without prior social scale
Large furnaces and ironworks are not simply "better smithies."
They require:
- strong food surplus
- heavy haulage
- coordinated record-keeping
- roads or water transport
- construction materials
- fuel forests or coalfields
- large labor pools
- maintenance institutions

---

# 4. Geological and material substrate

## 4.1 Resource classes to model

### A. Metallic resources
- native copper
- copper ore
- tin ore
- lead ore
- zinc-bearing ore later
- iron ore
- bog iron
- iron sand in suitable regions if later modeled
- precious metals later
- scrap metal streams

### B. Non-metal but metallurgically critical resources
- charcoal wood
- coal
- coking coal
- limestone / other calcium-bearing flux materials
- clay for furnace lining
- refractory clay / fireclay where available
- sand for molds and cast systems
- stone for furnace and forge construction
- water
- timber for mine supports, charcoal, patterns, wagons, buildings

## 4.2 Ore occurrence types
The game should represent different deposit forms because they change extraction method:

- surface float / loose pieces
- bog or marsh deposits
- exposed vein/outcrop
- shallow pit deposit
- hillside adit opportunity
- deeper shaft deposit
- stream placer/alluvial concentrate for some minerals
- quarryable stone/flux beds

## 4.3 Site-value implications
A settlement with:
- wood
- ore
- clay
- limestone
- water power
- nearby road or river access

should have a radically better metallurgy future than one with only wood and stone.

This is one of the strongest map-generation levers in the whole game.

---

# 5. Prospecting and resource recognition

## 5.1 Prospecting is a real skill family
Prospecting should not be a magical highlight overlay.
It should rely on:

- observation
- local terrain reading
- unusual rock color or weight
- stream sediments
- bog deposits
- exposed outcrops
- prior finds
- trial pits
- local oral/shared knowledge
- trade rumors later

## 5.2 Recognition layers
A deposit may pass through these states:

1. **Unnoticed**
2. **Suspicious**
3. **Known occurrence**
4. **Usable source**
5. **Characterized source**
6. **Managed extraction site**

A hamlet may know "red stone from the ridge sometimes gives poor iron."
A pre-industrial town may know grade, haul distance, fuel cost, and whether roasting improves performance.

## 5.3 Prospecting outputs
Prospecting should discover not only ore, but also:
- clay suitable for lining or molds
- limestone/flux stone
- charcoal woodland
- coal seams
- water sites for mills/bellows
- routes good enough for hauling heavy stock

---

# 6. Mining and extraction ladder

# 6.1 Stage 0 - Gathering and scavenging
Earliest metal access is often:
- found native copper
- weathered ore lumps
- bog iron
- river/stream finds
- traded scrap
- salvaged metal from outsiders later

This stage supports tiny quantities and experimentation, not a village metal economy.

# 6.2 Stage 1 - Surface working
Methods:
- collecting visible lumps
- prying from exposed veins
- shallow scraping
- simple pit digging
- washing/sorting loose material
- cutting turf/peat around bog iron

Main burdens:
- hand tools
- collapse risk in crude pits
- waterlogging
- low output
- heavy hauling cost

# 6.3 Stage 2 - Organized shallow mining
Methods:
- larger open pits
- step cuts
- drainage ditches
- short adits into hillsides
- spoil piles
- ore sorting yards

This stage needs:
- timbering in some places
- dedicated haulers
- ore-breakers
- route maintenance
- better storage and counting

# 6.4 Stage 3 - Deeper mining
Methods:
- shafts
- longer adits
- ladders/hoists/windlasses
- dewatering
- ventilation management
- support timber systems

This is where mining stops being "extra hard gathering" and becomes a major industry.

## 6.5 Extraction sub-processes
A mine chain can include:
- locate site
- clear overburden
- expose seam/vein
- break ore
- sort waste rock
- stage ore
- dewater/drain
- shore/support
- haul to yard
- break/crush
- roast/dry if needed
- transport to furnace district

## 6.6 Mining realism choice
For gameplay, model mining by **site class + process difficulty + hazard profile**, not full geology simulation.

---

# 7. Fuel chain ladder

# 7.1 Raw wood
Raw wood is available earliest but has serious metallurgical limits:
- moisture variability
- lower energy density
- inconsistent heat
- smoky/dirty burn
- bulk hauling burden

It is fine for:
- camp fires
- some pottery
- drying/smoking
- light heating
- crude early reheating

It is poor for sustained high-temperature metallurgy.

# 7.2 Charcoal
Charcoal is the first true metallurgical fuel breakthrough.

It matters because it offers:
- hotter fire
- cleaner combustion
- lower moisture if well made
- lighter haul per useful heat
- better furnace control
- less smoke at point of use than raw wood

Traditional charcoal production depends on heating wood with limited air rather than open burning. citeturn170284search3turn229741search5

## 7.2.1 Charcoal prerequisites
- managed woodcutting
- dry cordwood
- charcoal pit/mound or kiln
- burners who can control air
- cooling time
- protected storage
- lot/batch tracking if quality matters

## 7.2.2 Charcoal failure modes
- too much air -> wood burns away to ash
- too little control -> partly charred wood
- wet feedstock -> poor yield
- rushed opening -> fire reignition and loss
- poor storage -> moisture pickup and crumbling

## 7.2.3 Charcoal as a settlement burden
Charcoal should be one of the most wood-hungry systems in the village layer.
That means:
- woodland depletion pressure
- longer haul distances over time
- seasonal cutting priorities
- conflict with building timber and fuelwood uses

NPS material on historical ironworks notes charcoal was one of the three core inputs to ironmaking and extremely consumption-heavy. citeturn841161search7turn841161search19

# 7.3 Coal
Coal is a later fuel leap, not an early unlock.

Benefits:
- abundant underground fuel where geology allows
- high energy density
- supports steam economy
- reduces direct dependence on woodland for bulk heat

Costs:
- mining danger
- drainage
- ventilation
- haul weight
- smoke/pollution
- sulfur and contamination concerns
- not all coal is suitable for all metallurgical uses

## 7.4 Coke
Coke is heated coal with volatile components driven off.
It becomes crucial for large blast-furnace ironmaking and other heavy metallurgical applications. citeturn841161search2turn291426search5

Gameplay meaning:
- "coal" is not automatically "blast furnace fuel"
- coking coal availability matters
- coke ovens and handling become their own industry
- the transition to coke should feel like a true industrial gate

---

# 8. Non-ferrous early metallurgy

# 8.1 Native copper
A realistic first metal path can begin with native copper where geography allows.

Uses:
- ornaments
- small rivets/pins
- light blades or awls
- experimentation with hammering/annealing

Limits:
- too soft for many heavy tools
- small quantity
- highly location-dependent

## 8.1.1 Game value
Native copper is less important for huge output and more important for:
- first metal curiosity
- first prestige objects
- first heat-and-hammer learning
- first trade appeal

# 8.2 Copper ore path
Copper metallurgy is more complex than "melt green rock."
Sulfide and oxide ores behave differently, and roasting/smelting/refining may all matter. Britannica treats copper processing as ore preparation plus impurity removal and final refining. citeturn170284search8turn170284search0turn170284search4

Game abstraction:
- **green/oxidized copper ore** path = easier early learning, smaller scale
- **sulfide copper ore** path = more demanding roasting/smelting sequence, later better throughput

## 8.2.1 Copper outputs
- copper nugget/lump
- hammered copper stock
- simple copper tool/ornament
- copper vessel or sheet later
- alloy feedstock

# 8.3 Tin and bronze
Bronze is primarily copper plus tin. Tin rarity historically mattered enormously. citeturn170284search1turn170284search13

Gameplay meaning:
- bronze should be powerful but constrained by tin access
- in many starts, bronze is trade-shaped, not purely local
- bronze can create regional specialization and trade routes

## 8.3.1 Bronze advantages
- better casting behavior than pure copper
- stronger tool/weapon potential
- prestige and trade value
- gateway to mold/pattern logic

# 8.4 Lead and soft metals
Lead-family metals can support:
- weights
- seals
- some joining
- low-temperature casting
- later glazing/pipe risks if modeled

These should be useful but never treated as a universal tool metal.

---

# 9. Iron metallurgy ladder

# 9.1 Why iron changes everything
Iron is abundant relative to tin/copper combinations in many regions, but harder to smelt.
Once workable iron becomes reliable, the settlement gains:
- tougher agricultural tools
- better woodworking tools
- stronger hardware
- more repairable durable systems
- a path toward large-scale machinery

# 9.2 Bog iron
Bog iron is a highly useful early iron source where wetlands and groundwater conditions allow it.
Britannica notes bog iron commonly consists of hydrated iron oxides such as limonite and goethite and can even regrow after harvesting in some environments. citeturn745104search15turn745104search11

Gameplay use:
- early accessible iron source
- wetland-dependent
- lower/variable quality
- fits small-scale local bloomery starts well

# 9.3 Ore preparation
Before smelting, iron ore may need:
- selection/sorting
- drying
- breaking/crushing
- roasting
- removal of obvious waste rock
- batching by quality

Roasting is especially important for some ores because heating in air can drive off moisture or convert some ore types into more workable forms; Britannica describes roasting broadly as heating in air without fusion, especially for sulfide ores. citeturn170284search16turn291426search6

# 9.4 Bloomery iron
The bloomery is the early ironmaking cornerstone.
Britannica describes it as a process in which ore is reduced in charcoal heat to a spongy mass of iron and slag rather than fully melted iron. NPS similarly describes the bloomery/direct process as producing wrought-like iron directly from ore. citeturn291426search0turn291426search3

## 9.4.1 Bloomery prerequisites
- iron ore
- charcoal
- furnace shaft/hearth
- tuyere
- bellows or adequate draft
- clay/stone lining
- bloom extraction tools
- heavy hammering capacity

## 9.4.2 Bloomery outputs
Primary output:
- bloom (porous iron + slag)

Secondary outputs:
- slag
- fines
- rejected semi-smelted lumps
- partially carburized pieces in some runs

## 9.4.3 Bloom consolidation
A bloom is not a finished metal stock.
It usually needs:
- reheating
- hammering
- folding/compacting as needed
- slag squeezing
- division into workable pieces

This is where the smith/forger becomes as important as the smelter.

## 9.4.4 Gameplay realism choice
Do not output "iron bar" directly from a bloomery.
Output something like:
- poor bloom
- fair bloom
- good bloom
- steel-rich fragment (rare/conditional)
- slag-rich reject

Then refining/forging determines usable stock.

# 9.5 Forge and smithing path
A forge is where metal is:
- reheated
- drawn out
- upset
- bent
- punched
- welded
- repaired
- heat-treated in simple ways where appropriate

Britannica describes the forge as an open furnace using forced draft, historically often from bellows, with later animal- or water-powered air support. Smithing is fabrication and repair by hot and cold forging on an anvil or with hammers. citeturn745104search0turn745104search4

## 9.5.1 Forge outputs
- tool blanks
- finished edge tools
- nails/spikes
- hooks/hinges
- rings and straps
- simple agricultural fittings
- repair patches
- bar stock from bloom refinement

## 9.5.2 Forge constraints
- fuel
- air blast
- anvil quality
- hammering labor
- quench water/oil if applicable later
- tongs, punches, chisels, hardy tools
- roof/wind/weather protection

---

# 10. Cast iron, blast furnaces, and foundries

# 10.1 Why blast furnaces are a different world
The blast furnace is not just a bigger bloomery.
Britannica describes blast furnaces as producing pig iron from ore by carbon reduction at high temperature in the presence of a flux such as limestone. NPS emphasizes the same iron-ore + carbon fuel + flux pattern. citeturn291426search1turn745104search1turn841161search3

Key differences from bloomery logic:
- hotter
- larger
- continuous-ish operation
- molten iron output
- flux dependence becomes much more prominent
- much larger fuel and ore flow
- much larger capital and labor burden

## 10.1.1 Blast furnace prerequisites
- strong ore supply
- huge fuel supply
- reliable flux
- refractory lining
- bellows/blast
- casting beds or pig casting arrangements
- transport routes
- maintenance crews
- water power or later steam support around the works

## 10.1.2 Outputs
- pig iron
- cast iron
- slag
- furnace gas/heat potential later
- ash and fines
- casting feedstock

# 10.2 Fluxes
Flux materials such as limestone help combine with impurities and form slag in blast-furnace systems. NPS notes calcium-bearing fluxes, commonly limestone, were standard furnace inputs. citeturn841161search3turn841161search19

Gameplay meaning:
- flux source should be an actual strategic input
- distance to limestone matters
- poor/no flux should reduce yield and foul furnace behavior in appropriate systems

# 10.3 Foundry logic
Foundries convert pig/cast iron and later other metals into shaped cast parts.

Foundry prerequisites:
- furnace/cupola or suitable melting system
- molds
- sand/clay/binder systems
- patterns
- gating/runner logic in simplified form
- shakeout/finishing
- scrap return handling

## 10.3.1 Foundry outputs
- stove plates
- pots/kettles
- machine frames later
- wheels and hubs later
- counterweights
- housings
- pipes later
- gears/gear blanks later

## 10.3.2 Foundry realism choice
Foundries are powerful because they reduce forging labor for complex shapes, but they increase:
- mold prep labor
- fuel burden
- brittleness risk for some products
- finishing work
- defect rate

# 10.4 Refining cast iron toward wrought iron / bar
Historic ironworks often refined cast iron into more malleable wrought iron in finery/chafery-style systems. NPS describes finery hearth conversion of cast iron by reheating and exposing it to an air blast until carbon content was reduced. citeturn745104search5

Gameplay meaning:
- blast furnace + finery/forge = a two-stage route
- some settlements may skip direct bloomeries and work imported pig iron
- refining capacity should matter for hardware and smithing quality

---

# 11. Refractory and furnace materials

# 11.1 Why refractories matter
High-heat industries fail quickly without suitable linings.

Needed materials can include:
- ordinary clay
- tempered clay
- fireclay / refractory clay
- stone
- firebrick later
- sand bodies for molds
- repair mortars

Britannica notes fireclay-based refractories are widely used for furnace linings because of heat resistance and shock resistance. citeturn745104search2turn745104search10

## 11.2 Refractory gameplay roles
Refractory quality should affect:
- furnace lifespan
- maximum temperature
- crack risk
- maintenance frequency
- contamination risk
- campaign length before rebuild

## 11.3 Furnace maintenance
Regular tasks:
- patch cracks
- replace tuyere
- clean slag/tapholes as relevant
- dry out new lining
- protect from rain
- inspect structural stone/timber
- remove ash and clinker
- rotate consumable tools

---

# 12. Air blast and power support

# 12.1 Bellows
Bellows are a major heat-control technology.
Britannica describes them as devices for creating air jets, widely used to speed combustion in forges and ironworking. citeturn745104search12

Game stages:
- hand bellows
- foot/treadle bellows
- animal-assisted blast in some contexts
- water-powered bellows
- steam-powered blast later

## 12.2 Why blast power matters
More controlled blast changes:
- heat
- fuel burn rate
- reduction success
- carbon pickup
- consistency
- scale

## 12.3 Water-powered metallurgy
The existing design already places water power as a major town-scale metallurgy multiplier through forge bellows and hammers. Water-driven bellows and hammers historically increased bloom size and forging scale. citeturn745104search8turn291426search3

So metallurgy should strongly connect to:
- mill races
- wheelworks
- tilt/trip hammers
- bellows houses
- sawmills and ore-crushing support later

---

# 13. Fuel-to-metal stage ladder

# 13.1 Stage A - Experimental / scavenged metal
Inputs:
- found native copper
- traded metal scraps
- tiny crucible/hammer work

Outputs:
- ornaments
- awls
- needles/pins
- prestige items
- first metal knowledge

# 13.2 Stage B - Charcoal craft metalworking
Inputs:
- charcoal
- small ore lots
- forge or small smelting hearths
- hammer/anvil sets

Outputs:
- copper items
- bronze items if tin exists
- first iron blooms
- simple wrought iron tools and hardware

Settlement identity:
- advanced village craft economy

# 13.3 Stage C - Bloomery village iron
Inputs:
- regular iron ore
- charcoal chains
- bloomery furnace
- forge refining

Outputs:
- axes
- hoes
- knives
- nails/spikes
- hinges
- basic plow fittings
- better woodworking/agricultural tools

Settlement identity:
- agrarian village / early market town

# 13.4 Stage D - Charcoal blast and foundry town
Inputs:
- high volume charcoal
- ore
- limestone/flux
- larger furnace works
- foundry and finery support
- strong hauling

Outputs:
- pig iron
- castings
- more regular bar iron
- more standardized hardware

Settlement identity:
- pre-industrial town

# 13.5 Stage E - Coal / coke industrial metallurgy
Inputs:
- coal mining
- coking
- blast furnace scale
- heavy haulage
- steam support
- larger refractory systems

Outputs:
- mass pig iron
- steel-capable pathways
- foundry scale-up
- rail/machine-building feedstock
- components for boilers, engines, machines

Settlement identity:
- early industrial city

---

# 14. Knowledge and training ladder

# 14.1 Knowledge families
Metallurgy should require multiple distinct knowledge lines:

## A. Geological recognition
- which rocks may contain ore
- how to identify bog iron zones
- where limestone occurs
- which wood species make usable charcoal

## B. Fuel craft
- cutting/drying wood
- stacking and covering charcoal mounds
- reading smoke and vent behavior
- cooling without losing the batch

## C. Furnace craft
- lining and drying furnace bodies
- tuyere placement
- charge sequencing
- air control
- slag management

## D. Metalworking craft
- reading heat by color
- bloom consolidation
- drawing out bar
- joining, punching, upsetting, bending
- simple hardening/tempering where appropriate

## E. Industrial metallurgy knowledge later
- flux ratios
- furnace campaigns
- pig vs wrought uses
- mold/pattern work
- coke quality
- blast systems
- quality inspection and material sorting

# 14.2 Training model
Use the education/apprenticeship spec:
- helper -> striker/fuel handler -> furnace assistant -> smith/smelter -> foreman/master
- observation alone should not unlock reliable metallurgy
- supervised repetition matters more than reading in early stages
- workshop/training value of real ironworks should be high

---

# 15. Labor and role specialization

# 15.1 Early metallurgy roles
- charcoal burner
- ore gatherer / shallow miner
- ore breaker / sorter
- furnace tender
- bellows operator
- bloom consolidator / striker
- smith
- water/fuel hauler
- slag/ash cleaner
- storekeeper

# 15.2 Later town roles
- miner
- pit boss / shift lead
- charcoal yard foreman
- flux quarry worker
- foundry molder
- pattern maker
- finery/refining crew
- hammer crew
- transport crew
- works clerk
- maintenance mason
- waterwheel/bellows maintainer

# 15.3 Early industrial roles
- coal miner
- coke worker
- blast furnace crew
- foundry crew
- roller/hammer crew
- engine mechanic
- surveyor
- ore buyer/trader
- quality inspector
- safety foreman

---

# 16. Hazards and health burdens

Metallurgy should be one of the most dangerous work families in the game.

## 16.1 Heat and burn hazards
- radiant heat
- molten splash
- sparks
- hot metal misread as safe
- furnace collapse
- kiln/charcoal re-ignition

## 16.2 Smoke and gas hazards
- charcoal smoke during making
- forge smoke in poor ventilation
- coal smoke
- carbon monoxide in enclosed or badly vented spaces
- sulfur fumes in some ore/fuel chains

## 16.3 Mechanical hazards
- hammer strikes
- crushed fingers
- falling stock
- mine collapses
- shaft/adit falls
- hoist failures
- wheel/bearing failures on ore haul

## 16.4 Fatigue hazards
- bellows work
- repetitive hammering
- heavy hauling
- night furnace tending
- long campaign pressure

## 16.5 Contamination burdens
- ash and soot in camp if zoning is poor
- slag piles near water
- runoff from mining spoil
- charcoal-yard fire spread
- workshop clutter and cuts

This spec should integrate tightly with:
- Health / Injury / Care
- Environmental Hazard
- Pollution / Waste / Byproduct
- Defense / Security
- Player Orders / Policy

---

# 17. Waste, scrap, and byproducts

## 17.1 Important byproducts to model
- slag
- ash
- fines
- broken ore waste
- failed castings
- runner/sprue returns
- scale from forging
- spoiled charcoal
- sulfurous or dirty residues where relevant
- refractory rubble

## 17.2 Scrap economy
Metal scrap should become more valuable as society scales.
Important scrap classes:
- forging offcuts
- broken tools
- damaged hinges/nails/hardware
- casting returns
- pig/bar leftovers
- machine scrap later

## 17.3 Waste realism rule
Not all waste is useless:
- some slag may be reusable in limited ways
- some failed castings can be remelted
- some broken ore or low-grade batches can be blended
- some charcoal fines can be used in secondary ways

But:
- waste still costs labor, space, and cleanliness

---

# 18. Logistics burden

# 18.1 Metallurgy is haul-heavy
The metal chain depends on moving:
- ore
- waste rock
- charcoal or coal
- limestone/flux
- clay/refractory
- water
- bars/pigs/castings
- broken tools for repair
- finished hardware to farms/workshops

## 18.2 Critical logistics choke points
- ore source to smelter
- woodlot to charcoal yard
- charcoal yard to furnace
- flux source to furnace
- furnace to forge/foundry
- forge to settlement users
- coalfield to coke works
- coke works to blast furnace
- ironworks to machine-building districts later

## 18.3 Site logic
A good metallurgy town should ideally sit near some combination of:
- ore
- woodland or coal
- flux stone
- water power
- transport route

Hopewell Furnace historically depended on the co-location of ore, limestone, trees for charcoal, and water power. citeturn841161search3turn841161search7

---

# 19. Buildings and structure families

# 19.1 Village-scale
- ore sorting yard
- charcoal pit/mound field
- charcoal shed
- small forge
- bloomery furnace
- anvil area
- covered smithy
- slag dump
- water trough/quench area
- fuelwood store

# 19.2 Town-scale
- ore shed
- larger charcoal yard
- blast furnace stack
- bellows house
- finery/refining forge
- foundry
- mold sand yard
- pattern shop
- bar store
- coal yard
- lime/flux shed
- haul depot

# 19.3 Early industrial scale
- coal mine works
- coke ovens
- blast furnace complex
- blowing engine house
- foundry hall
- rolling/hammer works
- boiler/steam support
- weigh house / yard office
- rail or heavy wagon sidings
- slag heap district

---

# 20. Item and material families to link into the database

## 20.1 Ores and minerals
- low-grade iron ore
- high-grade iron ore
- bog iron
- copper ore
- tin ore
- lead ore
- limestone flux stone
- refractory clay
- molding sand
- coal
- coking coal

## 20.2 Fuel and support
- cordwood
- seasoned cordwood
- charcoal
- charcoal fines
- coke
- bellows leather
- tuyere clay nozzle
- furnace patch clay
- firebrick later

## 20.3 Intermediate metal states
- native copper lump
- crude copper bloom/lump
- bronze ingot
- iron bloom (poor/fair/good)
- refined wrought iron stock
- pig iron
- cast iron blank
- bar iron
- steel-capable stock later
- scrap metal mixed
- sorted iron scrap
- foundry return scrap

## 20.4 Finished goods
- knife blank
- axe head
- hoe head
- nails
- hinge
- ring
- chain link later
- plow fitting
- wheel tire later
- casting plate/pot
- hardware set

---

# 21. Process families for the database

## 21.1 Extraction
- prospect deposit
- gather bog iron
- collect surface ore
- dig shallow ore pit
- quarry flux stone
- cut and haul cordwood
- mine coal
- mine deeper ore

## 21.2 Preparation
- break ore
- sort ore by grade
- roast ore
- dry ore
- stack charcoal mound
- fire charcoal mound
- cool charcoal mound
- sort/store charcoal
- crush flux stone

## 21.3 Smelting/refining
- run small copper smelt
- run bloomery smelt
- consolidate bloom
- forge-refine bloom to bar
- fire blast furnace campaign
- tap pig/cast output
- refine pig iron toward wrought stock
- remelt scrap
- cast object
- dress/finish casting

## 21.4 Forging
- draw bar
- upset stock
- punch hole
- bend hook/strap
- forge-weld
- harden/temper simple tool where relevant
- repair tool
- sharpen edge

---

# 22. Stage gates and progression

# 22.1 Unlocking first meaningful village metallurgy
Required:
- reliable charcoal production
- at least one usable ore source or trade route
- weather-protected forge space
- enough food surplus to support partial specialists
- hauling capacity for fuel and ore
- practical know-how for air blast and heat control

# 22.2 Unlocking reliable iron village economy
Required:
- repeatable bloomery success
- bar stock/refining competence
- replacement tools and forge consumables
- enough ore and charcoal flow to maintain agricultural tools
- smith as a stable role, not just emergency task

# 22.3 Unlocking pre-industrial ironworks
Required:
- strong transport
- woodland or coal abundance
- flux source
- refractory competence
- dedicated ironworks district
- administration and stock counting
- enough demand to justify castings and larger campaigns

# 22.4 Unlocking early industrial metallurgy
Required:
- coal mining
- coking route
- large blast systems
- heavy haul infrastructure
- foundry scale
- water/steam power support
- sanitation/pollution zoning
- downstream machine demand

---

# 23. Integration with other systems

## 23.1 Agriculture
Metal tools increase:
- land clearing
- tillage
- harvest efficiency
- carpentry support for barns/carts/fences
- animal traction equipment

But agriculture must still feed the metalworkers.

## 23.2 Trade
Trade can provide:
- missing tin
- better ore
- flux
- coal
- finished bars or pig iron
- specialist tools
- molds/patterns
- technical knowledge

## 23.3 Governance
Metallurgy often justifies rules on:
- woodland cutting
- mine access
- stock accounting
- dangerous-zone restrictions
- reserve tool allocation
- repair priority
- pollution zoning

## 23.4 Education
Metallurgy is one of the strongest apprenticeship families in the whole game:
- tacit skill
- supervised repetition
- visual heat reading
- error-rich learning
- high safety stakes

## 23.5 Logistics and infrastructure
Roads, paths, bridges, carts, and animal traction sharply determine whether metallurgy remains village-scale or becomes town-scale.

---

# 24. First-playable and near-term design advice

Even though this doc spans later eras, the first playable should not try to implement all of this.

## 24.1 First metal slice
A practical first slice could be:
- found native copper or scrap
- charcoal production
- small forge
- crude iron ore recognition
- one bloomery
- poor/fair/good bloom outputs
- simple bar refinement
- 5-10 iron hardware/tool products
- tool repair loop

## 24.2 First village metallurgy slice
Then add:
- ore yard
- charcoal lot tracking
- slag/waste handling
- blacksmith role
- tool priority policy
- seasonal charcoal and ore stock pressure
- simple trade for missing flux/tin

## 24.3 What not to rush
Do not jump immediately to:
- modern steel
- precision alloys
- deep mine simulation
- full chemistry
- huge casting catalogs
- machine tools

Get the village metal economy feeling right first.

---

# 25. Strong realism choices made in this spec

1. **Charcoal is a full supply chain, not a side input.**
2. **Bog iron and surface ore can matter early.**
3. **Bloomery output is not finished bar stock.**
4. **Flux availability becomes strategically important in larger iron systems.**
5. **Coal and coke are different materials with different implications.**
6. **Foundries and blast furnaces are institution-scale upgrades, not bigger forges.**
7. **Scrap, slag, ash, refractory wear, and haul burden remain part of the experience.**
8. **The transition from smith-made custom parts to standardized metal stock belongs later, after major metallurgy scaling.**

---

# 26. Suggested references used for grounding

- Britannica, **Bloomery process**  
- Britannica, **Blast furnace**  
- Britannica, **Iron processing**  
- Britannica, **Charcoal**  
- Britannica, **Coke**  
- Britannica, **Coal mining**  
- Britannica, **Coal**  
- Britannica, **Copper processing**  
- Britannica, **Bronze**  
- Britannica, **Forge**  
- Britannica, **Smithing**  
- Britannica, **Refractory**  
- Britannica, **Bog iron ore**  
- Britannica, **Bellows**  
- National Park Service, **Iron Making: Introduction**  
- National Park Service, **Hopewell Furnace: Iron Making**  
- National Park Service, **Hopewell Furnace: Charcoal Making**  
- National Park Service, **Iron Making: Refining into Wrought Iron**  
- FAO, **Making charcoal in earth mounds**  
- USGS, **Iron ore statistics and information**  
- USGS, **Bog iron / iron oxyhydroxide materials references**

---

# 27. Short conclusion

The metal chain should feel like one of the settlement's great acts of organization.

At first it is:
- finding unusual stone
- making hotter fuel
- coaxing tiny amounts of useful metal out of difficult material
- then repairing every precious edge and fitting

Later it becomes:
- a village's first true specialist industry
- then a town's heavy-material base
- then an industrial city's furnace-and-foundry backbone

That is the right arc for this project.

Metal should never feel cheap.

It should feel like the settlement learned how to make Earth itself yield structure, edge, heat, and eventually machinery.
