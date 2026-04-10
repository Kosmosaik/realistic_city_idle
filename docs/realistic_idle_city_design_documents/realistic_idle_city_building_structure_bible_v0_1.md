---
title: "Realistic Incremental/Idle Colony-to-City Game - Building & Structure Bible"
version: "v0.1 - early-game building and structure layer"
scope:
  - "Era 0: Lone Survivor"
  - "Era 1: Primitive Camp"
  - "Era 2: Permanent Camp"
  - "Era 3: Tiny Hamlet / Proto-settlement"
alignment:
  - "Earth-like setting"
  - "Temperate starting biome"
  - "One starter NPC"
  - "Minimal top-down Godot presentation"
  - "Realism-first dependency logic"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
---

# Building & Structure Bible v0.1

## Purpose

This document defines the **building and structure layer** for the early game of the colony-to-city project.

It is meant to sit beside:

- the overall design document
- the early-game bible
- the NPC simulation spec
- the item & material bible
- the process bible

This document answers questions like:

- What counts as a building in the early game?
- Which early structures are just survival aids, and which become true institutions?
- What does a shelter actually do in simulation terms?
- Why does a raised cache matter?
- Why are latrines, drainage, drying racks, and work yards as important as huts?
- What is the realistic path from “one person surviving outside” to “a tiny organized hamlet”?

This is **not** a decoration catalog.
It is a design bible for structures that change survival, storage, labor, cleanliness, planning, and social organization.

---

# 1. Core stance for the building layer

## 1.1 Buildings are not percentage bonuses

A structure should not exist because it gives `+5% production`.
It should exist because it solves a real bottleneck.

Examples:

- a **lean-to** reduces wind and rain exposure
- a **raised cache** reduces spoilage and pest access
- a **drying rack** allows airflow, sunlight, and separation from ground contamination
- a **latrine zone** reduces contamination pressure around water, sleeping, and food work
- a **smoke shelter** supports a preservation workflow that cannot happen reliably in open weather
- a **seed store** protects future food, not current food
- a **cook shelter** turns a fire into a repeatable food-and-water system
- a **shared work shelter** allows labor to continue during rain and reduces material losses

Every useful structure should justify its own existence through one or more of:

- environment control
- storage protection
- workflow organization
- contamination control
- weather protection
- heat retention or heat use
- training value
- labor efficiency
- social coordination
- security or visibility
- preservation of strategic goods

## 1.2 A structure is any persistent physical arrangement that changes behavior

A “building” does not need full walls and a roof.

For this project, the building layer includes:

- shelters
- hearths
- caches
- racks
- pits
- fences
- yards
- designated work zones
- simple frames
- pits and kilns
- huts
- storehouses
- communal work shelters

So the layer should be named **Building & Structure** rather than just “Buildings.”

## 1.3 Site matters as much as materials

A badly placed structure can be worse than no structure.

Examples:

- a shelter in a drainage path becomes wet and miserable
- a hearth too close to sleeping space reduces sleep and increases fire risk
- a latrine uphill or too near water threatens the whole camp
- a cache in direct sun or damp brush increases spoilage
- a smoke structure in still, wet air may preserve badly
- a seed store near the cooking zone risks heat, pests, and accidental consumption

Location is part of the construction cost.

## 1.4 Early structures create institutions before “civilization”

One of the most important ideas in the project is that institutions begin early.

The camp is already becoming a social system when it has:

- a sleeping place
- a clean water path
- a fire area
- a refuse area
- a toilet area
- preserved food storage
- a work surface
- a protected seed reserve

That is the start of governance and settlement logic, even before there are formal civic buildings.

## 1.5 Maintenance is part of structure value

No structure should be “set and forget.”

A structure can fail, decay, or underperform because of:

- rain
- rot
- sagging lashings
- insect damage
- smoke buildup
- roof thinning
- mud wall cracking
- animal disturbance
- ash buildup
- collapsed pits
- dirty storage
- contamination from nearby waste
- overuse by too many NPCs

## 1.6 Shelter, cleanliness, and storage are equal pillars

In many games, shelter is overvalued while storage and sanitation are treated as secondary.
For this game, all three should matter from the beginning:

- **shelter** keeps bodies functional
- **storage** makes tomorrow possible
- **sanitation** protects the settlement from self-inflicted failure

---

# 2. Scope of this document

## 2.1 Included eras

This document covers:

- **Era 0 — Lone Survivor**
- **Era 1 — Primitive Camp**
- **Era 2 — Permanent Camp**
- **Era 3 — Tiny Hamlet / Proto-settlement**

## 2.2 Included structure families

This version covers:

1. site and zone markers
2. emergency survival structures
3. sleeping and weather shelters
4. hearth and cooking structures
5. storage and cache structures
6. preservation structures
7. sanitation structures
8. work and craft structures
9. water-handling and washing structures
10. garden and field-edge structures
11. proto-hamlet communal structures

## 2.3 Not deeply covered yet

This version does **not** deeply cover:

- masonry buildings
- metalworking shops
- large barns
- mills
- roads and bridges
- formal defensive walls
- advanced wells
- true sewer works
- industrial workshops
- large permanent domestic houses

Those will belong to later documents.

---

# 3. Relationship to the other design documents

This building bible should stay consistent with the already established project logic:

- the game’s first proven slice is **one NPC -> primitive camp -> permanent camp -> small hamlet**
- the early game is about explicit physical survival systems: water, shelter, fire, food, sleep, storage, spoilage, sanitation, first agriculture, and first specialization
- the process layer already assumes that many key actions require **specific places** to occur
- the item layer already distinguishes between raw materials, storage objects, perishable goods, and strategic reserves

This document translates those rules into **host environments**.

---

# 4. Canonical building / structure record schema

Every structure in the eventual database should support most of the following fields.

## 4.1 Identity

- **Name**
- **Family**
- **Stage / era**
- **Short description**
- **Tags**  
  Examples: shelter, heat, storage, seed, sanitation, craft, communal, hazardous, outdoor, roofed, raised, pit, semi-permanent

## 4.2 Physical form

- **Footprint size**  
  small / medium / large or exact tile counts later
- **Height class**  
  ground, waist, standing, overhead
- **Form class**  
  pit, rack, frame, open zone, lean-to, enclosed hut, covered shelter, fenced plot
- **Open/closed status**
- **Roof status**
- **Wall status**
- **Raised-from-ground status**
- **Drainage sensitivity**
- **Fire sensitivity**
- **Weather sensitivity**

## 4.3 Materials

- **Core structural materials**
- **Binding materials**
- **Surface / lining materials**
- **Insulation materials**
- **Repair materials**
- **Consumable maintenance materials**

## 4.4 Construction requirements

- **Required tools**
- **Required skills**
- **Required knowledge**
- **Construction steps**
- **Construction labor estimate**
- **Construction season / weather sensitivity**
- **Can be built by one NPC?**
- **Minimum safe build conditions**

## 4.5 Site requirements

- **Required terrain**
- **Distance preferences**
- **Forbidden adjacency**
- **Preferred adjacency**
- **Slope tolerance**
- **Drainage requirement**
- **Shade / sun preference**
- **Wind exposure preference**
- **Water proximity rule**

## 4.6 Simulation functions

- **Primary function**
- **Secondary functions**
- **Capacity**
- **Workflow hosted**
- **Protection offered**
- **Contamination risk modifiers**
- **Morale effects**
- **Training / learning effects**
- **Social effects**
- **Visibility / camp legibility effects**

## 4.7 Staffing and use

- **Passive or active**
- **Can multiple NPCs use it?**
- **Requires supervision?**
- **Requires recurring maintenance?**
- **Supports scheduled use windows?**
- **Ownership tendency**  
  personal / household / communal / work-specific

## 4.8 Failure and maintenance

- **Main decay vectors**
- **Inspection cadence**
- **Repair triggers**
- **Catastrophic failures**
- **Cleanliness requirements**
- **Rebuild thresholds**

## 4.9 Upgrade path

- **Upgrades from**
- **Upgrades into**
- **Can coexist with upgraded version?**
- **When obsolete, does it remain useful?**

---

# 5. Cross-cutting building rules for the early game

## 5.1 A shelter is measured by function, not by appearance

The game should track shelter performance through practical variables:

- rain shedding
- wind blocking
- ground insulation
- sleeping dryness
- heat retention
- smoke burden
- fire safety
- crowding
- insect exposure
- privacy
- repair burden

A tiny ugly shelter that keeps bedding dry may outperform a prettier but damp one.

## 5.2 Ground contact is one of the first enemies

Ground contact matters for:

- body heat loss
- bedding dampness
- hide spoilage
- seed spoilage
- cordage rot
- food contamination
- mold growth
- insect/pest access

This makes raised or insulated surfaces extremely valuable early on:

- sleeping beds
- drying racks
- shelves
- raised caches
- mats
- planked or brush floors later

## 5.3 Fire structures are central infrastructure

A hearth is never “just a fire.”

It is:

- heat
- cooking
- boiling
- light
- morale
- drying assistance
- ignition continuity
- smoke source
- charcoal trace source
- social focus
- task anchor

As the camp grows, hearth structures become some of the most important institutions in the settlement.

## 5.4 Storage structures protect future labor

The value of a store is not the contents alone.
It is the labor embedded in those contents.

A seed basket is stored planting time.
A dried meat rack is saved hunting success.
A clay pot is saved clay work, drying time, and firing risk.
A fuel stack is saved future nighttime security.

## 5.5 Sanitation structures are strategic, not cosmetic

The toilet area, refuse pit, wash area, and carcass zone matter because contamination travels socially and spatially.

A dirty camp should create knock-on problems:

- poorer sleep
- smell burden
- more flies or pests
- higher contamination odds
- more rework
- lower morale
- less attractive camp for newcomers

## 5.6 Structures shape task choice

NPC task scoring should care about structures because they change what is rational.

Examples:

- if there is a drying rack, preserving food becomes more attractive
- if there is a lined water pot, boiling water is more valuable
- if there is a proper work shelter, crafting in rain becomes possible
- if there is a clean seed store, harvest sorting becomes more strategically important
- if there is no latrine area, cleaning tasks become more urgent

## 5.7 A “work zone” can be a structure even when it is simple

A marked, maintained, repeatedly used area can count as a structure if it changes behavior.

Examples:

- hide scraping spot
- clay prep patch
- wood-cutting area
- clean drying area
- cooking area
- refuse area
- tool-knapping area

The important thing is not ornament.
It is persistent function.

---

# 6. Real-world notes that should shape early structures

## 6.1 Wattle and daub belongs later than the first emergency shelter, but earlier than “advanced building”

Britannica describes **wattle and daub** as one of the oldest known weatherproof wall methods: vertical stakes or woven branches are covered with clay, mud, or similar material. This should be treated as a meaningful upgrade over a brush lean-to, not as a trivial decorative wall skin. [B1]

### Design implication

In this project:

- **wattle-only** panels may appear first as windbreaks and partitions
- **wattle + mud/clay daub** should require more labor, more drying time, and better weather windows
- daubed structures should improve wind blocking and heat retention
- they should also add cracking, maintenance, and rain-damage considerations

## 6.2 Thatch should be slope-sensitive, material-sensitive, and maintenance-heavy

Britannica notes that traditional thatch used dried grasses or reeds tied in overlapping bundles and that shallow or horizontal thatch leaks badly; angle matters. [B2]

### Design implication

Thatched roofing should:

- work best on pitched frames
- fail if laid too flat
- degrade over time
- require replacement patches
- improve rain shedding and solar shading
- increase fire risk near sparks and open flame

## 6.3 Traditional grain and seed stores were often elevated, enclosed, and carefully ventilated

FAO sources on traditional storage describe baskets, pots, bins, underground silos, and elevated storage structures designed to reduce losses from moisture, pests, mold, insects, and rain. Some raised drying/storage structures in humid regions even used low fires beneath them to help keep produce dry and deter pests. [B3][B4][B5][B6]

### Design implication

The game should treat the first proper stores as major breakthroughs:

- raised caches
- covered basket stores
- pot storage
- seed pots
- simple granary-like stores
- ventilated produce racks
- cool shaded pits for some crops

Storage is an engineering problem, not only a container problem.

## 6.4 Moisture control and ventilation are central storage mechanics

FAO guidance repeatedly emphasizes that high crop moisture drives fungal growth, insect problems, respiration, and germination in stored grain. Cleanliness, protection from pests, and ventilation matter. [B5][B6]

### Design implication

Storage structures should track:

- dryness
- airflow
- contamination
- rodent exposure
- insect exposure
- roof leak risk
- soil dampness
- whether seeds are safe or accidentally being half-cooked / sprouted / spoiled

## 6.5 Primitive camp sanitation should strongly separate waste from water, bedding, and cooking

NPS and Leave No Trace guidance consistently recommend catholes roughly **6–8 inches deep** and at least **200 feet from water, camp, and trails**. [B7][B8]

### Design implication

Even if the game later allows permanent latrine structures, the earliest phase should still enforce:

- separate toilet direction/zone
- separation from water collection
- separation from food preparation
- replacement / rotation once a pit is heavily used
- some terrain logic, since wet or flood-prone latrine sites are bad choices

## 6.6 Safe water storage requires clean covered containers

CDC guidance on emergency and safe water storage emphasizes clean containers, tight covers, and avoiding containers that previously held toxic chemicals. [B9][B10]

### Design implication

A “water container” is not automatically safe.
The game should distinguish between:

- carrying water temporarily
- storing water safely
- leaving water exposed
- leaving water in dirty, contaminated, or previously unsuitable containers

## 6.7 Cool storage is not one universal condition

Extension guidance for root-cellar-like storage shows that some produce stores best in **cold and moist** conditions, while others prefer **cool and dry** conditions. Ventilation and rodent protection also matter. [B11][B12]

### Design implication

The game should not treat every “storage pit” as equally good for every crop.
Later early-game stores should differentiate between:

- dry stores
- cool damp stores
- shaded stores
- airy hanging stores

## 6.8 Staying dry and insulating from the ground are survival fundamentals

CDC and outdoor survival-oriented guidance both emphasize that cold injury and hypothermia risk are strongly linked to wetness, loss of insulation, and contact with cold ground or water. [B13][B14][B15]

### Design implication

The **bed**, **floor**, **mat**, and **drainage** systems are not minor comforts.
They are essential survival structures.

---

# 7. Camp siting doctrine for the building layer

## 7.1 Baseline site priorities

The first viable camp region should balance:

1. water access
2. fuel access
3. building material access
4. drainage
5. manageable wind
6. reduced exposure to flooding
7. reduced hazard from deadfall or unstable trees
8. enough workable open ground for future camp zoning
9. reasonable distance from heavy animal disturbance paths
10. visibility and pathing convenience

## 7.2 Terrain rules

### Preferred

- slightly elevated but not exposed ground
- near, but not inside, wet ground
- firm soil that supports posts/pits
- a mix of sun and shade
- clear approach paths
- access to wood, brush, stone, and plant fiber

### Avoid where possible

- low drainage channels
- flood edges
- deep boggy ground
- places directly under unstable dead branches
- heavy smoke traps with poor airflow
- places where all paths to water are steep and exhausting
- locations where waste zones cannot be separated properly

## 7.3 Zone logic from the beginning

Even a one-person camp should gradually separate into zones:

- sleeping
- hearth/cooking
- fuel
- clean storage
- utility water
- dirty work / carcass work
- waste / refuse
- toilet area
- drying/preservation
- toolmaking / dirty craft

The earliest “camp planning” is simply putting these in rational places.

---

# 8. Building families

## 8.1 Family A — Site and layout structures

These structures do not always look like buildings, but they matter enormously for camp organization.

Included examples:

- marked sleeping area
- marked hearth zone
- marked clean storage area
- marked dirty work area
- marked refuse zone
- marked toilet direction / latrine zone
- path stubs between major zones

## 8.2 Family B — Survival shelter structures

- debris bed
- lean-to
- windbreak
- rain-shedding brush shelter
- improved sleeping shelter
- small roofed sleep hut
- second sleeping shelter

## 8.3 Family C — Fire and cooking structures

- hearth base
- fire ring
- windbreak around hearth
- cook shelter
- ember-keeping nook
- covered cook/work shelter

## 8.4 Family D — Storage structures

- crude ground cache
- bark-covered cache
- raised cache
- suspended hanging cache
- shaded pit store
- seed pot cluster
- covered storage shelf
- communal dry store
- proto-granary

## 8.5 Family E — Preservation structures

- drying rack
- drying mat zone
- hanging frame
- smoke frame
- smoke shelter / smoke hut
- herb/seed drying rack

## 8.6 Family F — Sanitation and contamination control structures

- cathole zone
- pit latrine
- refuse pit
- ash disposal spot
- wash point
- carcass waste disposal zone
- quarantine spoilage zone

## 8.7 Family G — Work and craft structures

- knapping spot
- wood shaping stump / work spot
- hide scraping frame
- hide drying frame
- fiber prep patch
- basketry work area
- clay prep area
- clay drying shelf
- pit firing area

## 8.8 Family H — Garden and cultivation support structures

- cleared plot
- brush fence
- simple stake fence
- scare line / deterrent line
- seed drying rack
- seed store
- tool stack zone

## 8.9 Family I — Proto-hamlet communal structures

- shared cook shelter
- communal work shelter
- larger store hut
- guest / newcomer shelter
- childcare or care shelter if tone includes it
- workshop hut
- first true storehouse / granary

---

# 9. Quality axes for structures

## 9.1 Common quality axes

Every structure should vary in quality along axes like:

- siting quality
- build quality
- weather resistance
- drainage performance
- cleanliness
- repair condition
- access convenience
- fire safety
- pest resistance
- capacity use ratio
- crowding
- upkeep discipline

## 9.2 Common reasons quality drops

- bad site
- rushed construction
- poor materials
- wet season damage
- smoke saturation
- overloaded storage
- roof wear
- lashing decay
- post rot
- mud cracking
- animal damage
- no cleaning routine
- nearby waste buildup
- failure to rebuild temporary structures into more suitable ones

---

# 10. Structure catalog

The entries below use a design-bible format rather than code syntax.

---

## S-001 Marked Sleeping Area

**Family:** Site / Zone  
**Stage:** Era 0  
**Type:** designated clean zone

### Purpose
Defines a place intended for sleep and dry rest, even before a true shelter exists.

### Materials
- none strictly required
- optionally brush clearing, mat material, markers, stones, or a dry bough layer

### Site requirements
- above runoff line
- away from obvious waste and carcass work
- near enough to fire for access, but not so near that sparks and smoke overwhelm rest

### Simulation functions
- establishes “bed target” for NPC nightly behavior
- improves schedule coherence
- slightly improves morale compared with sleeping anywhere
- enables later upgrading into debris bed or sleeping shelter

### Risks
- if too exposed, gives false security
- if too close to hearth, gains smoke burden
- if too low, becomes damp

### Upgrade path
- debris bed
- lean-to sleeping zone
- improved sleeping shelter

---

## S-002 Marked Hearth Zone

**Family:** Site / Zone  
**Stage:** Era 0  
**Type:** designated utility zone

### Purpose
Creates a recognized place for controlled fire use, cooking, boiling, drying assistance, and social focus.

### Site requirements
- not in bedding
- stable ground
- manageable wind
- no overhanging highly flammable clutter if possible
- enough surrounding space for safe movement

### Simulation functions
- improves repeat fire maintenance
- reduces random fire placement
- anchors cook and fuel tasks
- helps player read the camp

### Risks
- poor placement can damage nearby shelter or stores
- heavy smoke in still air can lower sleep quality

---

## S-003 Dirty Work Zone

**Family:** Site / Zone  
**Stage:** Era 0–1  
**Type:** designated contamination zone

### Purpose
Keeps bloody, muddy, greasy, or debris-heavy tasks away from sleep and food storage.

### Typical uses
- carcass breakdown
- bone cracking
- hide fleshing
- muddy clay work
- ash dumping before final sorting

### Simulation functions
- lowers contamination transfer into clean zones
- improves cleaning logic
- creates better camp organization

### Risks
- if too close to water or storage, contamination remains high
- if too far, hauling cost rises

---

## S-004 Debris Bed

**Family:** Survival Shelter  
**Stage:** Era 0  
**Type:** survival sleep structure

### Purpose
Provides insulation from the ground and a defined resting pad before a true shelter is built.

### Materials
- dry brush
- grasses
- leaves
- leafy boughs
- reeds
- woven mat if available later

### Site requirements
- dry ground
- preferably under some overhead cover or future lean-to
- protected from runoff

### Simulation functions
- improves sleep quality
- reduces ground-conduction heat loss
- reduces damp clothing and bedding exposure
- increases survival odds in cold/wet weather

### Risks
- flammable if too close to fire
- molds or compacts over time
- becomes pesty and damp if not aired or replaced

### Maintenance
- fluff / replace regularly
- air in sun when possible
- remove if urine, blood, or spoiled food contaminates it

---

## S-005 Emergency Lean-To / Windbreak

**Family:** Survival Shelter  
**Stage:** Era 0  
**Type:** emergency shelter

### Purpose
Provides immediate protection from wind and some rain with very low build time.

### Materials
- poles or saplings
- brush
- bark sheets
- leafy boughs
- reeds or grass bundles
- lashings if available

### Site requirements
- backs onto wind direction if possible
- not in drainage path
- enough room for lying down and storing minimal kit

### Construction logic
1. set main support pole or lean main members against natural support
2. layer poles / brush
3. cover with bark, boughs, or grass
4. thicken on windward side
5. add bedding inside

### Simulation functions
- blocks wind
- improves dryness
- defines sleep location
- can be built quickly by one NPC

### Weaknesses
- poor rain protection in long storms
- low heat retention
- limited capacity
- often smoky if fire is tucked too close
- easily degraded by wind and repeated wetting

### Upgrade path
- improved sleeping shelter
- roofed sleep hut
- cook or work windbreak secondary use later

---

## S-006 Drainage Scrape / Runoff Diversion

**Family:** Site / Water Control  
**Stage:** Era 0–1  
**Type:** micro-earthwork

### Purpose
Moves surface water away from sleep, fire, and storage.

### Materials
- soil shaping only
- optionally gravel, stones, bark, brush edging

### Site requirements
- slight slope
- visible runoff problem or likely runoff path

### Simulation functions
- reduces shelter dampness
- protects bedding
- protects nearby storage
- improves fire reliability in wet weather

### Risks
- badly directed runoff can damage another zone
- open scraped soil can erode
- overdone trenching can feel unrealistic or ugly if overused

### Design note
Use sparingly and plausibly.
The goal is not military trench spam.
The goal is simple drainage awareness.

---

## S-007 Simple Fire Ring / Hearth Base

**Family:** Fire / Cooking  
**Stage:** Era 0–1  
**Type:** utility structure

### Purpose
Creates a safer, more repeatable fire location.

### Materials
- stones
- bare mineral soil
- gravel
- sometimes packed clay edging later

### Site requirements
- stable ground
- enough clear area
- not pressed into bedding or fuel pile

### Simulation functions
- improves fire stability
- improves cooking success slightly
- improves ember retention
- allows ash accumulation and later ash use
- reduces accidental fire spread compared with raw ground fire

### Risks
- sparks
- smoke burden
- poor placement near shelter or stores
- water pooling if placed in a depression

### Upgrade path
- lined hearth
- hearth under cook shelter
- communal hearth

---

## S-008 Crude Drying Rack

**Family:** Preservation  
**Stage:** Era 1  
**Type:** raised utility frame

### Purpose
Raises goods above dirt for drying, airing, and temporary storage.

### Materials
- poles
- saplings
- lashing
- woven mat or slats if available

### Site requirements
- airflow
- not directly next to latrine/refuse
- some sun preferred, depending product
- enough visibility to inspect regularly

### Supported workflows
- meat strips
- herbs
- greens
- seed heads
- wraps / clothing airing
- fiber drying
- small hides in some cases

### Simulation functions
- lowers contamination from ground contact
- improves drying consistency
- increases value of preservation tasks
- acts as a visual signal that the camp is becoming organized

### Risks
- animals can reach it if too low
- rain exposure can ruin lots
- overloading can collapse it
- smoke from nearby hearth may taint or help, depending use

### Upgrade path
- better drying rack
- roofed drying rack
- dedicated herb/seed rack
- smoke shelter integration

---

## S-009 Crude Ground Cache

**Family:** Storage  
**Stage:** Era 0–1  
**Type:** temporary store

### Purpose
Keeps selected goods in one place rather than scattered around the camp.

### Materials
- bark
- brush cover
- stones
- woven mat
- hide cover if available

### Best uses
- non-food tools
- fuel staging
- temporary gathered goods
- low-value materials

### Poor uses
- long-term seed
- potable water
- delicate dry food
- softened hides
- fine fiber stock

### Simulation functions
- reduces search time
- improves player readability
- gives first concept of stockpiling

### Risks
- damp
- pests
- contamination
- forgetting contents
- accidental consumption or spoilage

### Upgrade path
- raised cache
- covered shelf
- storage pot cluster
- communal dry store

---

## S-010 Raised Food Cache

**Family:** Storage  
**Stage:** Era 1–2  
**Type:** elevated store

### Purpose
Protects dry or semi-dry goods from ground damp, some pests, and disorder.

### Materials
- posts or forked poles
- platform poles
- lashings
- basketry
- bark or simple roof cover later

### Research grounding
Traditional storage methods commonly use raised platforms, baskets, and enclosed structures to reduce moisture and pest losses. [B3][B4][B5]

### Best uses
- dried food
- nuts
- cleaned seed heads
- basketed roots for short periods
- wrapped tool kits
- dry cordage and spare lashings

### Simulation functions
- improved storage class for certain goods
- reduces rot and contamination
- visually marks strategic goods
- supports stock inspection tasks

### Risks
- not fully rodent-proof
- roofless cache still vulnerable to rain
- overloaded or poorly lashed cache may fail
- theft/animal access remains possible if not designed well

### Upgrade path
- roofed cache
- enclosed store hut
- granary/storehouse

---

## S-011 Hanging Cache / Suspended Store

**Family:** Storage  
**Stage:** Era 1–2  
**Type:** suspended store

### Purpose
Uses height and hanging suspension to protect selected goods from ground pests and damp.

### Materials
- cordage
- crossbar or branch
- container (basket, hide bag, bark vessel)

### Good for
- small high-value foods
- seed reserve
- a few protected personal belongings

### Weaknesses
- low capacity
- wind movement
- limited access
- requires strong cordage and support

### Design note
Useful as a transitional structure before better raised or enclosed storage exists.

---

## S-012 Shaded Cool Pit Store

**Family:** Storage  
**Stage:** Era 2–3  
**Type:** pit storage

### Purpose
Provides cooler storage for selected roots, tubers, or short-term perishables.

### Materials
- digging labor
- possibly straw/grass insulation
- bark lining
- basket inserts
- removable cover

### Research grounding
Cool storage is not universal: some crops prefer cold and moist conditions, others cool and dry, and good ventilation and rodent protection matter. [B11][B12]

### Best uses
- some root crops
- cool-keeping perishables
- temporary harvest holding before sorting

### Poor uses
- most long-term dry seed
- goods vulnerable to damp
- softened hides or dry cordage
- items that mold easily without airflow

### Simulation functions
- extends some crop storage life
- introduces differentiated storage logic
- makes garden production more meaningful

### Risks
- flooding
- condensation
- rodents
- forgetting contents
- unsuitable crop mix causing losses

### Upgrade path
- better root cellar type later
- separate dry store and cool store institutions

---

## S-013 Seed Pot Cluster / Seed Store Nook

**Family:** Storage / Agriculture  
**Stage:** Era 2–3  
**Type:** strategic reserve store

### Purpose
Physically separates planting stock from edible stock.

### Materials
- clay pots with covers, or tightly woven baskets with lids
- shelf, niche, hanging storage, or protected corner
- dry matting
- labels/marks later if desired

### Simulation functions
- protects future planting
- reduces accidental consumption
- raises the strategic value of harvest sorting
- can become a camp-knowledge anchor for seed stewardship

### Risks
- heat from hearth
- moisture
- rodent access
- social misuse when the camp is desperate

### Social note
This is one of the first structures that embodies “thinking past today.”

---

## S-014 Improved Sleeping Shelter

**Family:** Survival Shelter  
**Stage:** Era 1–2  
**Type:** semi-permanent personal shelter

### Purpose
Upgrades from an emergency lean-to into a more reliable all-weather sleeping structure.

### Materials
- saplings / poles
- lashings
- bark sheets or grass thatch
- brush
- matting
- optional hide patches
- optional wattle wall sections
- packed earth or brush floor improvements

### Site requirements
- good drainage
- close enough to hearth for safe access
- not within high-spark zone
- enough room for bedding, a little gear, and dry entry

### Functional improvements over emergency shelter
- better rain shedding
- better wind blocking
- better bedding dryness
- more stable storage of personal gear
- lower rebuilding frequency
- stronger privacy / “home” identity for the NPC

### Risks
- smoke accumulation if too enclosed and fire too near
- roof leaks if maintenance is neglected
- rot in contact points
- crowding if used by too many NPCs

### Upgrade path
- second improved sleeping shelter
- multi-person sleep hut
- small domestic house much later

---

## S-015 Roofed Sleep Hut

**Family:** Housing  
**Stage:** Era 2–3  
**Type:** more formal shelter

### Purpose
Provides a clear enclosed or semi-enclosed place for repeated sleep and light personal storage.

### Research grounding
Thatched roofing and wattle-and-daub-like walls are historically plausible early technologies once enough labor, fiber, poles, and mud work exist. [B1][B2]

### Materials
- poles / posts
- rafters
- thatch or bark roof
- optional wattle walling
- optional clay/mud daub
- mat flooring or raised sleeping platform

### Simulation functions
- improved weather protection
- stronger sleep quality
- better morale
- lower exposure to wind
- modest heat retention

### Risks
- if too sealed without ventilation: smoke burden and dampness
- thatch fire risk
- mud cracking
- higher build and repair labor than simple shelters

### Design note
This should not appear too early.
It belongs after the camp has enough stability to invest labor in more than bare survival.

---

## S-016 Hearth Windbreak / Hearth Guard

**Family:** Fire / Cooking  
**Stage:** Era 1  
**Type:** supporting structure

### Purpose
Improves hearth behavior by reducing wind disruption without fully enclosing the fire.

### Materials
- stones
- green logs
- wattle panel
- earth bank or packed clay support in some cases

### Simulation functions
- improves boil/cook reliability
- reduces spark scatter in some directions
- makes low-smoke / high-heat fire control easier

### Risks
- badly designed windbreak may push smoke into sleep area
- overly tight enclosures may feel too advanced for this stage

---

## S-017 Cook Shelter

**Family:** Fire / Cooking  
**Stage:** Era 2–3  
**Type:** roofed utility shelter

### Purpose
Protects cooking, boiling, and some food prep from rain while keeping the fire slightly separated from sleeping space.

### Materials
- posts
- roof members
- bark or thatch roof
- side screens optional
- hearth base beneath or adjacent
- hooks, hanging poles, or racks later

### Functional value
- increases weatherproof cooking
- supports regular boiled water
- protects fuel staging nearby
- provides social gathering point
- may serve as a camp center for shared meals

### Risks
- smoke accumulation
- thatch ignition
- soot buildup
- contamination if dirty tools and clean food prep are mixed

### Upgrade path
- shared cook shelter
- communal hall with hearth much later

---

## S-018 Ember-Keeping Nook / Protected Coal Spot

**Family:** Fire  
**Stage:** Era 1  
**Type:** small support structure

### Purpose
Protects coals or ember-bearing material so the camp can preserve ignition continuity.

### Materials
- ash bed
- protected shallow pit or container
- hearth-adjacent niche
- cover or partial wind guard

### Simulation functions
- improves chance of relighting without full ignition process
- lowers nightly fire-loss penalty
- reduces repetitive fire-start labor

### Risks
- accidental extinguishing
- unsafe placement causing hidden smoldering
- children / animals / careless movement later

---

## S-019 Smoke Frame

**Family:** Preservation  
**Stage:** Era 2  
**Type:** open smoke support structure

### Purpose
Allows meat or hides to be suspended over or near controlled smoke.

### Materials
- frame poles
- lashings
- hanging rods or hooks
- nearby smoke source

### Best uses
- partial food smoking
- cool smoke exposure for softened hides
- drying assistance in insect-heavy conditions

### Weaknesses
- weather exposed
- harder to control than a smoke shelter
- quality swings widely with wind and rain

### Upgrade path
- smoke shelter / smoke hut

---

## S-020 Smoke Shelter / Smoke Hut

**Family:** Preservation  
**Stage:** Era 2–3  
**Type:** specialized preservation structure

### Purpose
Creates a more controlled environment for cool smoke, slower drying, and repeated preservation work.

### Materials
- poles/posts
- roof
- partial walls or screens
- smoke source area
- hanging poles or rack levels
- optional clay sealing in lower draft areas later

### Simulation functions
- improves preservation consistency
- supports larger batches
- improves hide smoking
- separates smoke-heavy work from the sleeping zone
- can become one of the first “trade-like” camp structures

### Risks
- overheat cooks instead of dries
- too little airflow leads to damp smoke and spoilage
- creosote-heavy / harsh smoke from bad fuel
- fire risk
- soot and buildup require maintenance

### Social value
Once the camp has a smoke structure, it has moved beyond pure improvisation and into repeatable preservation planning.

---

## S-021 Herb / Seed Drying Rack

**Family:** Preservation / Agriculture  
**Stage:** Era 2–3  
**Type:** specialized rack

### Purpose
Provides a cleaner, more controlled drying space for seed heads, herbs, and delicate plant materials.

### Materials
- lighter rack frame
- woven trays or mats
- roof cover optional
- labels/marks later

### Simulation functions
- improves seed quality
- reduces accidental trampling and mixing
- separates strategic seed drying from general food drying

### Risks
- birds, pests, and wind loss
- rain damage if uncovered
- overheating if placed too close to hearth

---

## S-022 Cathole Zone

**Family:** Sanitation  
**Stage:** Era 0–1  
**Type:** rotating sanitation area

### Purpose
Defines a direction and distance for primitive toilet use before a more dedicated latrine exists.

### Research grounding
Guidance commonly places catholes 6–8 inches deep and at least 200 feet from water, camps, and trails. [B7][B8]

### Simulation functions
- lowers contamination of camp core
- gives NPCs a known toilet target
- improves social order and camp legibility

### Risks
- overuse of one patch
- poor soil choice
- rain runoff
- too near camp due to laziness or exhaustion

### Upgrade path
- pit latrine zone

---

## S-023 Pit Latrine

**Family:** Sanitation  
**Stage:** Era 2–3  
**Type:** early sanitary structure

### Purpose
Provides a more stable and maintainable toilet solution for a repeated camp site.

### Materials
- digging labor
- optional privacy screen
- optional foot support logs/boards
- ash or soil cover practice
- path markers

### Site requirements
- definitely away from water and camp center
- not in flood/drainage channel
- accessible enough for use in bad weather
- soil that can hold shape reasonably

### Simulation functions
- improved sanitation over ad hoc catholes
- reduced random filth
- increased camp attractiveness for newcomers
- clearer maintenance task generation

### Risks
- collapse in weak soil
- smell if not covered / maintained
- fly burden
- overflow or abandonment if not rotated or replaced

### Maintenance
- soil/ash cover
- path upkeep
- replacement when full or unstable

---

## S-024 Refuse Pit / Waste Pit

**Family:** Sanitation  
**Stage:** Era 1–3  
**Type:** dirty zone structure

### Purpose
Keeps non-reusable waste and selected dirty residues out of clean camp space.

### Good for
- food scraps not worth reprocessing
- broken low-value debris
- selected ash / sweepings
- dirty fiber trash
- some clay slurry waste

### Not good for
- all organics indiscriminately
- anything that attracts predators in large amounts if open
- strategic byproducts like bones, fat scraps, or usable ash

### Simulation functions
- reduces clutter
- reduces contamination of clean zones
- improves morale slightly in organized camps

### Risks
- scavenger attraction
- smell
- contamination if too near storage or water
- forgotten useful materials being wasted

---

## S-025 Wash Point / Vessel-Washing Spot

**Family:** Hygiene / Water  
**Stage:** Era 1–3  
**Type:** designated utility zone

### Purpose
Separates washing from drinking-water collection and from sleeping/food storage areas.

### Materials
- none strictly required at first
- later stones, drain gravel, drying hooks, vessel stands

### Site requirements
- not at the exact drinking point
- enough drainage
- far enough from latrine zone
- easy water-carry path

### Simulation functions
- reduces contamination in main camp
- supports vessel cleaning routines
- lowers disease pressure modestly
- improves repeated boiling/storage workflows

### Risks
- if used directly at water source, can contaminate collection point
- stagnant muddy wash areas become gross fast

---

## S-026 Carcass Processing Zone

**Family:** Dirty Work / Hygiene  
**Stage:** Era 1–3  
**Type:** designated high-risk work zone

### Purpose
Creates a repeatable place for bloody and greasy processing away from clean storage and sleep.

### Typical contents
- work surface or stump
- hanging branch/frame if available
- bone-breaking spot
- discard path to refuse/disposal area
- water bucket or wash routine nearby but separate

### Simulation functions
- lowers contamination transfer
- speeds butchery once established
- anchors hide and bone workflows

### Risks
- smell
- scavenger attraction
- flies
- psychological burden if too close to living center

---

## S-027 Knapping Spot / Stoneworking Patch

**Family:** Work / Craft  
**Stage:** Era 0–2  
**Type:** dirty craft zone

### Purpose
Creates a place for stone selection, flaking, and shaping where sharp debris is expected.

### Materials
- suitable flat-ish ground or anvil stone
- debris edge marker
- collection basket for useful flakes later

### Simulation functions
- improves toolmaking organization
- reduces stepping on sharp flakes elsewhere
- supports repeat practice and learning

### Risks
- foot injury if mixed into common traffic path
- accidental contamination of sleeping zone with sharp debris

---

## S-028 Woodworking Spot / Shaping Stump

**Family:** Work / Craft  
**Stage:** Era 1–3  
**Type:** craft support structure

### Purpose
Gives a stable place to shape sticks, shafts, pegs, poles, and simple handles.

### Materials
- stump, log, or stable support
- nearby tool cache
- shaving/debris zone

### Simulation functions
- improves efficiency for spear shafts, pegs, frames, stakes, and shelter repair
- creates a visible craft identity in camp

### Risks
- debris buildup
- tool loss
- splinter/trip hazards if badly placed

---

## S-029 Hide Scraping Frame / Hide Work Spot

**Family:** Work / Craft  
**Stage:** Era 2–3  
**Type:** specialized craft structure

### Purpose
Supports fleshing, scraping, stretching, and working hides more consistently.

### Materials
- frame poles or beam
- pegs/lashings
- scraper tools
- dirty runoff area
- optional partial shade

### Simulation functions
- improves hide work efficiency
- increases quality ceiling on softened or smoked hide
- strengthens distinction between raw hide, rawhide, and usable soft hide outputs

### Risks
- smell and mess
- flies
- strain on weak lashings
- hide spoilage if frame placement is too wet or hot

---

## S-030 Fiber Prep Patch

**Family:** Work / Craft  
**Stage:** Era 1–3  
**Type:** craft zone

### Purpose
Hosts plant fiber drying, stripping, sorting, and conditioning.

### Materials
- dry ground or mats
- hanging line or poles
- small tool kit
- clean-ish storage nearby

### Simulation functions
- supports cordage and basketry economy
- improves drying and sorting
- keeps fibers out of muddy general traffic

### Risks
- contamination
- rain re-wetting
- tangling and loss
- fire risk if next to hearth

---

## S-031 Basketry / Weaving Work Shelter

**Family:** Work / Craft  
**Stage:** Era 3  
**Type:** sheltered craft space

### Purpose
Provides a dry place for repetitive handwork like basket making, cordage reinforcement, mat weaving, and light repair.

### Materials
- roof
- seated work area
- dry material storage
- tool nook

### Simulation functions
- enables work during light rain
- reduces material loss
- improves quality consistency
- supports specialization once multiple NPCs exist

### Social value
This is one of the first true **skill-place** structures: a place associated with patient craft labor.

---

## S-032 Clay Prep Area

**Family:** Work / Craft  
**Stage:** Era 2–3  
**Type:** dirty wet craft zone

### Purpose
Holds clay cleaning, temper mixing, kneading, and batch staging before shaping.

### Materials
- flat work surface or compact earth
- water access path
- temper stock
- drying protection nearby
- dirty runoff tolerance

### Simulation functions
- improves clay workflow efficiency
- supports batch work
- separates muddy clay handling from clean domestic space

### Risks
- re-wetting by rain
- contamination with organic debris
- clay loss into traffic areas

---

## S-033 Pottery Drying Shelf / Drying Board Area

**Family:** Work / Craft  
**Stage:** Era 2–3  
**Type:** dry craft support structure

### Purpose
Gives green vessels a protected place to dry slowly before firing.

### Materials
- shelf, plank substitute, woven tray, or smoothed dry platform
- shade / cover
- airflow
- low disturbance area

### Simulation functions
- reduces vessel cracking from poor staging
- supports batch pottery
- increases realism of waiting time before firing

### Risks
- over-fast drying in harsh sun/wind
- accidental bumping
- rain re-wetting
- children/animals/travel path damage later

---

## S-034 Pit Firing Area

**Family:** Work / Craft / Thermal  
**Stage:** Era 2–3  
**Type:** specialized firing structure

### Purpose
Provides a deliberate place for firing simple vessels rather than throwing them into any campfire.

### Materials
- selected pit or ground bed
- fuel stock
- sherds/stones/earth for packing
- drying space nearby
- exclusion area during firing

### Simulation functions
- supports first real pottery
- increases breakage risk visibility
- makes fuel and weather planning matter

### Risks
- weather disruption
- vessel cracking
- incomplete firing
- accidental trampling if not isolated
- fuel waste

---

## S-035 Cleared Garden Plot

**Family:** Agriculture  
**Stage:** Era 2–3  
**Type:** cultivation structure

### Purpose
Represents a repeatedly maintained patch rather than random foraging.

### Materials
- clearing labor
- digging sticks / hoes later
- seed stock
- water path
- weeded boundaries

### Simulation functions
- anchors gardening tasks
- increases predictability of food production
- supports the transition from gathering to planning

### Risks
- animal browsing
- trampling
- over-drying
- seed waste
- labor drain if the camp is still barely stable

---

## S-036 Brush Fence / Simple Stake Fence

**Family:** Agriculture / Protection  
**Stage:** Era 2–3  
**Type:** low defensive boundary

### Purpose
Reduces casual intrusion by small animals and visually defines cultivated or protected areas.

### Materials
- brush
- stakes
- saplings
- lashings optional

### Simulation functions
- modest crop protection
- path shaping
- visual order
- can also separate clean/dirty areas slightly

### Risks
- constant repair burden
- low effectiveness against determined animals
- fuel competition for the same wood stock

---

## S-037 Seed Drying Rack

**Family:** Agriculture / Preservation  
**Stage:** Era 2–3  
**Type:** specialized agricultural structure

### Purpose
Supports drying seed heads or cleaned seeds before storage.

### Materials
- light rack
- woven trays/mats
- roof or cover optional

### Simulation functions
- improves seed viability
- lowers mold risk
- increases importance of harvest timing and weather

### Risks
- bird loss
- wind loss
- accidental over-drying or heat damage for delicate seed

---

## S-038 Shared Cook Shelter

**Family:** Proto-Hamlet Communal  
**Stage:** Era 3  
**Type:** communal institution

### Purpose
Becomes the camp’s shared cooking, boiling, meal, and social center once population rises.

### Materials
- stronger post-and-roof system
- central or side hearth
- fuel stacking area
- hanging poles / hooks / shelves
- seating/log edges optional

### Research grounding
Simple communal structures with central fires are well attested in many traditional settlements; British Museum educational material on Iron Age Britain, for example, describes thatched roundhouses with central fires. This is used here as **broad structural precedent**, not as a claim that your exact biome must copy that architecture. [B16]

### Simulation functions
- shared meals
- weatherproof boiling
- improved labor coordination
- social bonding
- morale stabilization
- easier onboarding of newcomers

### Risks
- smoke overload if ventilation is bad
- crowding
- disease spread if filthy
- spark/fire risk with thatch and clutter

### Social importance
This is one of the first buildings that feels like society, not just survival.

---

## S-039 Communal Work Shelter

**Family:** Proto-Hamlet Communal  
**Stage:** Era 3  
**Type:** covered work institution

### Purpose
Allows repeated handwork to continue despite mild rain or strong sun and starts consolidating craft activity.

### Good uses
- cordage
- basketry
- sorting harvest
- light repair
- some clay shaping
- sewing / hide cutting
- tool handle work

### Simulation functions
- improves craft continuity
- reduces material losses to weather
- helps specialization emerge
- improves training conditions

### Risks
- mixed clean and dirty work causing contamination
- clutter
- tool confusion if no storage discipline exists

---

## S-040 Store Hut / Dry Goods Hut

**Family:** Proto-Hamlet Storage  
**Stage:** Era 3  
**Type:** enclosed communal store

### Purpose
Centralizes dry goods, tools, seed, fibers, containers, and selected preserved foods.

### Materials
- posts and frame
- roof
- walling or close screens
- shelves or hanging points
- raised floor or internal platforms preferred
- pest barriers where possible

### Simulation functions
- major upgrade to inventory order
- reduced random spoilage for suitable goods
- improved work planning
- supports a storekeeper role later
- becomes a core visual marker of permanence

### Risks
- if damp or dirty, can fail dramatically
- rodent pressure
- theft or misallocation in social stress
- crowding and search inefficiency if badly organized

### Design note
This should feel like a major milestone.
It means the camp is storing labor in a deliberate institution.

---

## S-041 Proto-Granary

**Family:** Proto-Hamlet Storage / Agriculture  
**Stage:** Era 3  
**Type:** strategic food institution

### Purpose
Protects seed and dry staple harvests in a dedicated structure rather than generic storage.

### Materials
- dry enclosed or elevated structure
- basket/pot/bin inserts
- raised flooring strongly preferred
- roof
- strong maintenance discipline

### Research grounding
Traditional granaries and storage bins are designed around moisture, pest, and mold control, not merely capacity. [B3][B4][B5][B6]

### Simulation functions
- increases settlement carrying capacity
- allows larger non-food labor share
- reduces panic after harvest
- creates a new point of social trust and conflict
- supports planned future expansion

### Risks
- harvest failure becomes painfully visible
- pest outbreak can threaten the whole camp
- poor sealing and bad ventilation both matter
- may require guarding/social rules once population rises

---

## S-042 Newcomer / Guest Shelter

**Family:** Proto-Hamlet Social  
**Stage:** Era 3  
**Type:** social support structure

### Purpose
Provides a place for a new arrival, injured NPC, or low-status guest without immediately displacing existing sleepers.

### Materials
- simple roofed shelter
- bedding material
- modest storage nook

### Simulation functions
- makes recruitment events more believable
- reduces social friction when population grows
- supports care tasks

### Design note
Not every playthrough needs this immediately, but it is a powerful realism structure once migration/rescue events matter.

---

## S-043 Care Shelter / Recovery Shelter

**Family:** Proto-Hamlet Social / Health  
**Stage:** Era 3  
**Type:** special-use shelter

### Purpose
Provides a quieter, cleaner space for an injured or sick NPC, or for infants/childcare if the tone later includes family growth.

### Materials
- dry, warm shelter
- better bedding
- clean water access
- reduced smoke exposure

### Simulation functions
- improves recovery conditions
- lowers disease spread if isolation logic exists
- strengthens social realism

### Design note
This structure can remain optional until health depth increases, but it fits the realism direction well.

---

# 11. Recommended structure unlock order for the early design

## 11.1 Day 1

1. marked sleeping area
2. marked hearth zone
3. debris bed
4. emergency lean-to / windbreak
5. crude ground cache

## 11.2 First week

6. drainage scrape
7. simple fire ring / hearth base
8. dirty work zone
9. crude drying rack
10. raised food cache
11. cathole zone

## 11.3 Permanent camp threshold

12. improved sleeping shelter
13. wash point
14. carcass processing zone
15. hide work spot
16. fiber prep patch
17. clay prep area
18. seed store nook
19. pit latrine
20. smoke frame
21. cook shelter

## 11.4 Tiny hamlet threshold

22. roofed sleep hut or second improved shelter
23. herb/seed drying rack
24. basketry/work shelter
25. smoke shelter
26. store hut
27. cleared garden plot
28. brush fence
29. shared cook shelter
30. communal work shelter
31. proto-granary
32. guest / care shelter as needed

---

# 12. Strong design rules for Godot presentation

## 12.1 Minimal visuals still need strong readability

Because the game uses tiny top-down visuals, structures should rely on:

- color
- footprint shape
- edge pattern
- tiny icon overlays
- activity indicators
- smoke/heat/wetness/pest hints
- zone outlines
- compact state text in UI

A structure should be readable not because it is pretty, but because the player understands:

- what it is
- what it is for
- what is wrong with it
- what it is connected to

## 12.2 Suggested minimal visual language

Examples:

- **sleep shelter:** small wedge or roof-tint footprint
- **hearth:** dark ring with ember/orange center
- **drying rack:** narrow raised line / slat symbol
- **cache:** small box/raised square
- **latrine:** isolated brown-marked zone
- **work zone:** outlined patch with tiny category icon
- **store hut:** compact rectangle with storage overlay
- **proto-granary:** elevated box with seed/grain overlay

## 12.3 The UI should expose building condition, not hide it

For each selected structure, the player should quickly see:

- dryness
- cleanliness
- fullness
- safety
- repair need
- contamination risk
- suitability for current stored goods
- current users
- recent losses or problems

---

# 13. What the building layer should add to the feel of the game

If the building layer is working, the player should feel this progression:

## 13.1 Very early
“I am barely surviving outdoors.”

## 13.2 Primitive camp
“I now have a real place with sleep, fire, storage, and routines.”

## 13.3 Permanent camp
“I am protecting tomorrow, not only today.”

## 13.4 Tiny hamlet
“We are no longer just individuals near the same fire. We have shared infrastructure.”

That emotional ladder matters as much as the mechanical one.

---

# 14. Open design questions for the next draft

These do not block this version, but they matter for later refinement.

## 14.1 Household ownership vs communal ownership
When shelters and stores multiply, who “owns” them?

## 14.2 Fire policy
How many hearths are ideal as population rises:
- one shared hearth
- household hearths
- mixed model

## 14.3 Security
When do caches need locks, guards, or stronger social rules?

## 14.4 Weather severity
How harsh are rain, snow, and wind on weak structures?

## 14.5 Pest ecology
How detailed should rodents, insects, and scavengers become?

## 14.6 Privacy and social class
How much do shelter size, dryness, and crowding affect status and relationships?

---

# 15. Recommended next companion document

Now that the project has:

- item & material layer
- process layer
- building & structure layer
- NPC/task layer

the strongest next companion document is:

## Settlement Progression Spec v0.1

That document should define:

- what makes a camp become a permanent camp
- what makes a permanent camp become a hamlet
- population-support thresholds
- sanitation thresholds
- storage thresholds
- structure mix requirements
- social/organizational changes
- early role specialization
- the first true settlement metrics

That is the natural next step.

---

# References

These sources were used as grounding where real-world building, storage, sanitation, shelter, and preservation logic mattered for this document.

- [B1] Britannica, **Wattle and daub**  
  https://www.britannica.com/technology/wattle-and-daub

- [B2] Britannica, **Thatching**  
  https://www.britannica.com/technology/thatching

- [B3] FAO, **Traditional farm/village storage methods**  
  https://www.fao.org/4/t1838e/t1838e12.htm

- [B4] FAO, **Grain storage**  
  https://www.fao.org/4/s1250e/S1250E0w.htm

- [B5] FAO, **Grain crop drying, handling and storage**  
  https://www.fao.org/4/i2433e/i2433e10.pdf

- [B6] FAO, **Manual of the prevention of post-harvest grain losses**  
  https://www.fao.org/4/x5065e/x5065E07.htm

- [B7] National Park Service, **Leave No Trace Seven Principles**  
  https://www.nps.gov/articles/leave-no-trace-seven-principles.htm

- [B8] Leave No Trace Center for Outdoor Ethics, **Dispose of Waste Properly**  
  https://lnt.org/why/7-principles/dispose-of-waste-properly/

- [B9] CDC, **Safe Water Storage**  
  https://www.cdc.gov/global-water-sanitation-hygiene/about/about-safe-water-storage.html

- [B10] CDC, **How to Make Water Safe in an Emergency**  
  https://www.cdc.gov/water-emergency/about/index.html

- [B11] University of Minnesota Extension, **Harvesting and storing home garden vegetables**  
  https://extension.umn.edu/planting-and-growing-guides/harvesting-and-storing-home-garden-vegetables

- [B12] University of Minnesota Extension, **Growing carrots and parsnips in home gardens**  
  https://extension.umn.edu/vegetables/growing-carrots-and-parsnips

- [B13] CDC, **Stay Safe During and After a Winter Storm**  
  https://www.cdc.gov/winter-weather/safety/stay-safe-during-after-a-winter-storm-safety.html

- [B14] CDC, **Hypothermia-Related Deaths — Utah, 2000, and United States, 1979–1998**  
  https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5104a2.htm

- [B15] CDC, **Survivor! Volume 1 - Surviving Outdoor Adventures**  
  https://stacks.cdc.gov/view/cdc/216053

- [B16] British Museum, **Prehistoric Britain (educational resource)**  
  https://www.britishmuseum.org/sites/default/files/2019-09/visit-resource_prehistoric-britain-KS2.pdf
