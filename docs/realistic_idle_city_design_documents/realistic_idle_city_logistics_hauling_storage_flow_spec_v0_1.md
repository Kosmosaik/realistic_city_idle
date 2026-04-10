---
title: "Realistic Idle City — Logistics / Hauling / Storage Flow Spec"
version: "v0.1"
scope: "Lone survivor -> Primitive Camp -> Permanent Camp -> Tiny Hamlet"
status: "Design specification"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
---

# Purpose

This document defines the **logistics, hauling, movement, and storage-flow layer** for the early game of the project.

It is meant to sit on top of the existing design stack:
- the original design document
- the early-game bible
- the NPC simulation and task documents
- the item & material bible
- the process bible
- the building & structure bible
- the settlement progression spec
- the knowledge & discovery spec
- the social / recruitment spec
- the allocation / ownership / rationing spec
- the health / injury / care spec
- the environmental hazard spec
- the food & water safety spec

This spec answers questions such as:
- where does every item physically exist?
- how does a thing move from source to use point to storage to waste?
- what makes hauling slow, dangerous, inefficient, or impossible?
- what is the difference between a pile on the ground, a cache, a stored reserve, and a worksite stock?
- how do containers, bundles, baskets, pots, slings, and racks change productivity?
- how should distance from water, fuel, food, sleeping places, and work zones shape camp viability?
- when should NPCs move goods pre-emptively rather than only when the player clicks something?
- how should logistics bottlenecks become visible as the settlement grows?

The goal is not to simulate forklifts, SKU systems, or modern warehouse management in the early slice.
The goal is to create a realistic logistics model in which **movement is work, storage is infrastructure, and bad layout can kill a camp**.

---

# 1. Relationship to the existing design set

This document assumes the following are already established elsewhere:

- NPCs are embodied people with fatigue, thirst, hunger, injury, temperature burden, morale, and task choice.
- Items have mass class, bulk class, fragility, wetness sensitivity, spoilage behavior, contamination risk, ownership tendency, and transport difficulty.
- Processes already define what inputs and outputs exist.
- Buildings and structures already define physical storage places, work yards, shelters, hearths, pits, racks, and proto-hamlet communal facilities.
- Settlement progression already depends on storage, sanitation, reserves, and recurring production rather than object count alone.
- Water and food safety already define safe vs unsafe containers, clean vs dirty chains, and contamination risks.
- Allocation and rationing already define personal, household, worksite, communal, and reserve stocks.

This document answers a different question:

> Given a realism-first early settlement, how are materials physically moved, staged, stored, retrieved, protected, and delivered where they are needed?

---

# 2. High-level design stance

## 2.1 Movement is labor, not background magic

A primitive camp survives or fails based partly on how much labor is wasted in movement.

Examples:
- carrying water uphill several times a day can consume a major share of labor
- gathering wood far from camp quickly becomes a time sink
- food left at the hunt site may spoil before it reaches processing space
- building materials scattered across camp create repeated unnecessary walking
- a great storage vessel is only useful if someone can move water into it and out of it without contaminating it

In practical design terms, **hauling is one of the earliest universal work types**. It is not filler.

## 2.2 Storage is part of production, not an afterthought

A thing is not practically available just because it exists.

A pile of gathered tubers on wet soil is not the same as:
- tubers on a drying mat,
- tubers in cool covered storage,
- tubers issued to the cook area,
- tubers in emergency reserve,
- or tubers already rotting near a latrine path.

The logistic model therefore treats every item as having a **location state**, not just an inventory count.

## 2.3 Distance is a real survival variable

Distance changes:
- time cost
- fatigue cost
- hydration need
- injury risk
- exposure risk
- spoilage risk
- morale burden
- camp throughput

A camp with the same objects but a better layout should perform meaningfully better.

## 2.4 Containers and carry aids are civilization multipliers

A sling, basket, hide bag, shoulder pole, drag, or pot can transform productivity because they change how much can be moved, how safely it can be moved, and how cleanly it can be stored.

## 2.5 Early logistics should stay concrete

For the early slice, the game should treat the following as explicit realities:
- one person can only carry so much
- not all loads are equally awkward
- one hand occupied matters
- clean and dirty containers matter
- wet materials behave differently from dry ones
- some goods are fragile and some can be thrown into a pile
- strategic reserves must remain physically separate from everyday stocks

---

# 3. Real-world anchors for this spec

This document is informed by a few practical real-world observations that map well into game rules:

- Safe water handling is not just treatment; it also depends on **transport and storage in clean, covered containers** that reduce recontamination.[L1][L2][L3]
- Manual material handling risk depends on a combination of **force, repetition, posture, carry distance, coupling/handles, and fatigue**, not on weight alone.[L4][L5]
- General occupational guidance often treats very heavy repeated manual lifting as a high-risk activity, which supports using strong movement penalties and injury risk for repeated heavy hauling.[L5]
- Grain and seed storage success depends heavily on **dryness, cleanliness, pest exclusion, and stable storage conditions**, which means transport and staging errors should affect later spoilage outcomes.[L6][L7]
- Stored goods are vulnerable not just while sitting still, but also while being moved through mud, rain, dirty hands, pest areas, and cross-contaminated containers.[L1][L2][L8]

The spec translates these into gameplay rather than copying workplace regulations literally.

---

# 4. Core logistics concepts

## 4.1 Logistic entities

Every material flow in the early game should be understood through a small set of entity types.

### A. World source
A place where a thing originates:
- stream edge
- berry patch
- tree stand
- stone scatter
- clay patch
- carcass site
- field plot
- brush area

### B. Loose world object
A thing that exists in the world but has not been intentionally staged:
- fallen branch
- loose stone
- dropped tool
- dead bird
- broken pot sherd

### C. Claimed loose stock
A thing the camp has effectively acquired, but not yet stored properly:
- bundle of reeds dropped near camp
- deer quarter left at processing yard
- unstacked firewood near hearth
- wet seeds on drying mat

### D. Container
A movable or fixed thing that can hold other things:
- sling
- bag
- basket
- water skin
- clay pot
- lined pit
- rack
- shelf
- communal store bin later

### E. Stockpoint
A designated storage location with a purpose, rules, and capacity:
- firewood stack
- clean-water pot zone
- seed reserve jar
- drying rack inventory
- hide yard material pile
- meat-processing zone tools
- shelter bedspace stash

### F. Worksite buffer
A small stock meant for immediate nearby use:
- hearth-side kindling
- scraper and awl at hide beam
- clay temper pile near shaping mat
- small clean-water vessel at cook area

### G. Reserve stock
A protected stockpoint not available for ordinary use:
- storm reserve wood
- drought reserve water
- seed reserve
- care reserve clean cloth
- emergency dried food reserve

### H. Waste/salvage point
A place for dirty or partly useful leftovers:
- ash pit
- bone discard zone
- rot/refuse pit
- salvage sherd pile
- scrap fiber pile

## 4.2 Location state model

Every item or batch should always be in one of these broad states:

1. **in world source**
2. **harvested but at source**
3. **claimed and in transit**
4. **temporarily staged**
5. **stored at stockpoint**
6. **reserved / locked**
7. **issued to person or worksite**
8. **being processed**
9. **waste / salvage / quarantine**
10. **lost / spoiled / destroyed**

This matters because most early delays are not “lack of recipe.” They are “wrong place, wrong time, wrong condition.”

## 4.3 Stockpoints are gameplay objects, not invisible bins

A stockpoint should have identity and rules.

Minimum fields:
- name
- location
- stockpoint type
- allowed categories
- cleanliness class
- dry/wet exposure class
- pest exposure class
- access cost
- capacity by volume and weight
- reserve flag
- owner/governance class
- priority for refill / empty / cleanup

Examples:
- **Hearth Kindling Stack**
- **Raw Water Pots**
- **Boiled Water Pots**
- **Hide Yard Dirty Tools Basket**
- **Seed Reserve Jar (Locked)**
- **Dry Fiber Basket**
- **Spoiled Material Refuse Pit**

---

# 5. Human hauling model

## 5.1 Do not reduce hauling to a single weight stat

For realism, hauling difficulty should be affected by more than weight.

Important factors:
- mass
- bulk
- shape awkwardness
- rigidity / floppiness
- fragility
- grip quality / coupling
- whether the load occupies one or both hands
- whether the load shifts while walking
- terrain difficulty
- route length
- slope
- wetness / mud
- temperature / weather
- fatigue
- injury state
- urgency

This mirrors real manual handling better than a flat “can carry 25 kg” rule.

## 5.2 Recommended load model

Use **load classes** instead of hard exact safe limits.

### Load Class A — trivial
Examples:
- knife
- handful of berries
- small bowl
- bone awl
- cord bundle

Effects:
- minimal speed penalty
- can usually be combined with other small items
- can often be carried while doing light movement

### Load Class B — light
Examples:
- one filled small basket
- one moderate bundle of reeds
- one small water vessel
- one hide wrap
- one rabbit-sized carcass

Effects:
- mild speed penalty
- some hand occupation
- noticeable but sustainable repeated hauling

### Load Class C — moderate
Examples:
- armful of sticks
- full medium basket of roots or grain
- medium water pot or skin
- quartered medium carcass section
- several stones for building

Effects:
- clear speed penalty
- fatigue cost accumulates
- repeated trips become a serious labor tax
- awkward terrain can push task into unsafe zone

### Load Class D — heavy
Examples:
- large water vessel
- dense stone bundle
- heavy wood bundle
- wet clay load
- large hide with frame or wet bundle

Effects:
- strong speed penalty
- higher stumble/drop risk
- high fatigue and overuse burden
- should usually require short routes, drag aid, or partial loads

### Load Class E — extreme / team or aid recommended
Examples:
- large log section
- big carcass
- large stone slab
- large vessel when full
- big construction bundle

Effects:
- single-NPC transport should be slow, unsafe, or impossible without aid
- likely requires drag, litter, shoulder pole, or multiple NPCs

## 5.3 Carry mode classes

### A. Hand carry
- highest flexibility
- lowest setup cost
- poor for bulk
- occupies one or both hands
- bad for long distance if repeated

### B. Folded/tied bundle
- good for brush, sticks, reeds, hides, grass
- cheap early improvement
- unstable if poorly tied
- can trap moisture in damp materials

### C. Shoulder sling
- large early productivity gain
- supports longer carry with less hand occupation
- better for wood and hide bundles than loose arm carry

### D. Basket carry
- foundational early logistics technology
- good for mixed small goods, food, dry fibers, seeds, roots, kindling
- poor for liquids unless lined
- can become unsafe if overfilled or top-heavy

### E. Bag / skin carry
- better for liquids or fine dry goods if condition is good
- contamination-sensitive
- may leak or sour if poorly cleaned

### F. Shoulder pole / yoke-like carry
- later in the early slice or hamlet phase
- strong improvement for balanced paired loads such as two water vessels
- requires route quality and learned technique

### G. Drag / travois / skid
- useful for wood, carcass segments, reeds, brush, or bulky non-fragile goods
- better on snow, grass, or open ground than rough forest or rock
- lower lifting burden, higher terrain dependence

### H. Litter / two-person carry
- allows movement of injured people, heavy loads, and bulky fragile loads
- imposes coordination overhead
- should exist early as an emergency method even before formal tools

## 5.4 Coupling and awkwardness

A load with good handles or stable basket support should be much easier to move than the same weight in a slippery, irregular bundle.

Awkward loads include:
- round stones with no grip
- wet hides
- carcasses
- thorny brush
- sloshing water in open vessels
- long poles through dense brush
- mixed debris piles

Game effects:
- slower speed
- more fatigue per meter
- more drop/spill risk
- more injury chance
- lower willingness under non-emergency conditions

## 5.5 Repetition matters

Even a “possible” load becomes problematic if repeated all day.

The hauling system should distinguish:
- one heroic trip in emergency
- several practical work trips
- repeated high-burden hauling that damages productivity and health

Examples:
- hauling one big water load during drought panic may be rational
- doing twelve heavy uphill water trips daily should create major fatigue and wear

---

# 6. Terrain, route, and travel-cost model

## 6.1 Route cost factors

Every meaningful hauling task should consider:
- horizontal distance
- slope
- footing quality
- obstruction density
- wetness / mud
- stream crossing
- darkness / visibility
- weather exposure
- predator or hazard zones
- crowding / congestion in camp

## 6.2 Terrain classes for early logistics

### A. Clear flat ground
Best walking efficiency.

### B. Open grass / light scrub
Moderate slowing.

### C. Forest understory
Higher obstruction, branch snagging, visibility loss.

### D. Rocky / uneven ground
Higher stumble risk and slower footing.

### E. Mud / marsh edge
Strong speed reduction, contamination risk, vessel instability.

### F. Slope / ridge
Higher fatigue and injury risk, especially with water, stone, and wet loads.

### G. Interior camp clutter
Often underestimated. Poorly laid camp interiors should create real movement drag.

## 6.3 Route memory and preferred paths

NPCs should develop and use remembered routes to:
- water source
- best fuelwood patch
- trap line
- latrine
- refuse pit
- clay source
- field plots
- communal store

Well-used paths should gradually become better logistic corridors because repeated use clears brush and reveals problems.

## 6.4 Path degradation and weather

Heavy repeated movement should be affected by rain, thaw, and trampling.

Examples:
- a water-fetch path can become slippery and eroded
- a route through the refuse side of camp can increase contamination risk
- wet-season pathing may force temporary relocation of stockpoints

---

# 7. Storage model

## 7.1 Storage is defined by protection, not just capacity

A storage place should be judged on:
- dryness
- shade/coolth
- pest exclusion
- contamination exposure
- fire exposure
- breakage exposure
- theft/animal access
- ease of retrieval
- ability to stay organized

A huge open pile may have great capacity but terrible protection.

## 7.2 Early storage classes

### A. Ground drop spot
Fast, zero setup, worst protection.
Use for:
- immediate staging only

### B. Sorted ground pile
Slightly better than a random drop zone.
Use for:
- stone pile
- branch pile
- brush pile
- construction staging

### C. Covered ground stack
Useful for:
- firewood if reasonably ventilated
- poles
- bark sheets
- non-fragile dry materials

### D. Raised rack
Useful for:
- drying foods
- keeping goods off damp soil
- improving airflow
- reducing rodent access somewhat

### E. Basket / bag storage
Useful for:
- dry gathered foods
- fibers
- seeds
- small tools
- kindling

### F. Pot / jar / skin storage
Useful for:
- water
- fats
- some dried foods
- seed if dry and protected

### G. Pit / cool storage
Useful for:
- roots and tubers under the right conditions
- some protected reserves
- coolth-sensitive food

### H. Dedicated enclosed store
A major threshold toward permanent camp or hamlet.
Use for:
- dry staple storage
- protected tools
- work materials
- communal stocks
- reserve separation

## 7.3 Storage quality axes

Each stockpoint should score across:
- **dryness protection**
- **pest protection**
- **cleanliness protection**
- **temperature protection**
- **airflow**
- **visibility / countability**
- **retrieval convenience**
- **spill / breakage protection**

No stockpoint will score high on everything.

## 7.4 Accessibility versus protection tradeoff

Highly protected storage may take more labor to access.

Examples:
- seed reserve jar sealed and stored safely: excellent protection, low convenience
- hearth-side daily fuel basket: high convenience, lower protection
- communal pit storage: moderate convenience, moderate protection if well maintained

This tradeoff should be visible in gameplay.

## 7.5 Storage cleanliness classes

### Clean-use only
For potable water, eating vessels, medicinal cloth, seed, clean prepared foods.

### Clean-preferred
For cooked foods, dried foods, cleaned fibers, prepared clay, finished garments.

### Neutral-use
For raw roots, bark, fuelwood, stone, construction sticks.

### Dirty-use only
For refuse, hides in raw stage, bloody tools, carcass waste, dung later.

Crossing from dirty to clean use should require cleaning and drying, not instant reuse.

---

# 8. Stock categories and flow rules

## 8.1 Daily-use stock
Things consumed or handled every day:
- drinking water
- fuelwood and kindling
- hearth tools
- cooking pot
- common food
- bedding maintenance items

Rules:
- keep close to use point
- keep enough buffer to survive short disruption
- refill before empty if source travel is costly

## 8.2 Worksite stock
Things used regularly in a process zone:
- hide scraper and dull cutting tools at hide yard
- clay and temper at shaping zone
- drying mats at food-prep zone
- weaving materials at basketry zone

Rules:
- separate from personal stash
- not every retrieval should require walking to central store
- must still be countable and reclaimable

## 8.3 Household / bedspace stock
Once multiple NPCs exist:
- bedding
- wraps/cloaks
- one personal cup/bowl if available
- personal repair bundle
- small clothing reserve

Rules:
- partly personal, partly household-governed
- visible to ownership system

## 8.4 Communal stock
- staple foods
- bulk fuel
- shared tools
- building materials
- common fibers
- communal containers
- pottery blanks / repaired vessels

Rules:
- should be in known locations
- visible to player and NPC logic
- should not silently disappear into personal inventories

## 8.5 Strategic reserve stock
- seed reserve
- drought water reserve
- winter dried food reserve
- storm firewood reserve
- emergency clean cloth reserve
- emergency care broth / easy food reserve later

Rules:
- physically separated
- clearly marked / locked by policy
- hard to auto-consume without explicit trigger or leadership decision

## 8.6 Quarantine / suspect stock
Needed for realism.
Examples:
- questionable water from dirty vessel
- mold-risk grain batch
- raw carcass materials near contamination event
- bloody tools awaiting cleaning
- sick-person vessel set

Rules:
- cannot be mixed into clean stocks automatically
- may require test/use-at-own-risk/clean/discard choices

---

# 9. Core hauling task families

## 9.1 Source collection haul
Move goods from source to camp or cache.
Examples:
- water from stream
- wood from deadfall area
- clay from patch
- stones from outcrop
- reeds from marsh edge

## 9.2 Retrieval haul
Bring stored goods to point of use.
Examples:
- fuel to hearth
- water to cook space
- dried fish to meal prep
- seed to planting area
- scraper to hide yard

## 9.3 Return / put-away haul
Move tools or unused goods back to proper stock.
Examples:
- pot back to clean storage
- basket back to dry shelf
- spare hides back to protected rack

## 9.4 Staging haul
Move goods closer to where they will soon be used.
Examples:
- construction poles near shelter build site
- clay near shaping mat
- fuel stock increased before rain front
- harvest baskets placed near plots before harvest starts

## 9.5 Sorting haul
Move goods into distinct classes.
Examples:
- dry wood separated from green wood
- edible roots from spoiled roots
- seed stock separated from meal stock
- clean vessel set separated from dirty vessel set

## 9.6 Preservation support haul
Movement required to prevent loss.
Examples:
- bring meat from carcass site to drying/smoking space quickly
- move wet firewood under cover before rain
- move dried foods from rack into protected storage at dusk
- move cleaned seed from threshing area to dry reserve pot

## 9.7 Waste / sanitation haul
Examples:
- ash to ash pit
- refuse to waste pit
- dirty water away from clean-use areas
- carcass waste away from camp core
- fouled bedding to wash/dry area

## 9.8 Emergency haul
Highest priority situations.
Examples:
- water to severely dehydrated NPC
- dry wraps to exposed NPC
- fuel to prevent night cold crisis
- litter transport for injured NPC
- salvage of food before storm/flood/animal incursion

---

# 10. Key early-game flow chains

## 10.1 Water flow chain

Water is the most important early logistic chain because it is heavy, needed daily, contamination-sensitive, and often source-distance limited.

### Ideal early chain
source -> collection point -> raw-water vessel -> clarification/treatment -> clean covered vessel -> drinking / cooking issue point -> cup/bowl use -> dirty vessel queue -> cleaning -> clean storage

### Important rules
- raw and treated water should never silently merge
- transport container quality matters
- open dirty containers increase recontamination risk
- water near refuse, latrine, or carcass area should be suspect
- cooking water and drinking water may share stock, but dirty wash water should not
- distance to source should be one of the strongest camp-location pressures

### Useful stockpoints
- raw water pot zone
- boiled water pot zone
- cook-water small vessel
- wash water vessel
- emergency reserve vessel

## 10.2 Fuelwood flow chain

wood source -> gathered branch/log -> bundle/sling/drag -> camp staging pile -> sorting into green/dry/kindling -> covered dry stack -> hearth-side daily basket -> fire use -> ash/char remains -> ash pit / reuse

Important rules:
- dry and green wood should not be treated as the same stock
- daily-use kindling belongs near hearth
- bulk reserve should be more protected than daily-use stock
- storm preparation should generate pre-emptive fuel movement tasks

## 10.3 Food flow chain

### Gathered plant foods
wild patch -> basket/bag -> sorting mat -> wash/clean if needed -> immediate eat OR drying/cool storage -> meal issue

### Carcass foods
carcass site -> bleeding/field handling -> transport to processing zone -> skinning/butchering -> fresh-use OR drying/smoking/cooling -> protected storage -> cook issue

Important rules:
- raw bloody flow should stay spatially separated from clean eating/storage space
- distance from hunt site raises spoilage and contamination pressure
- dried food should move indoors/covered at night or bad weather when appropriate

## 10.4 Hide flow chain

carcass site -> hide removal -> raw hide transport -> fleshing/scraping zone -> drying frame / softening / smoking -> finished hide storage -> garment/container/cordage use

Important rules:
- raw hide should be treated as urgent and perishable
- hide tools and hide waste should belong to dirty-use stockpoints
- finished hides need dry protected storage

## 10.5 Fiber flow chain

wild fiber source -> gather bundle -> dry/sort -> strip/process -> cordage or weaving material stock -> use at basketry / repair / binding tasks

Important rules:
- wet fibers may mold if stored packed
- processed dry fibers deserve better storage than raw gathered bundles

## 10.6 Clay flow chain

clay source -> dig wet clay -> haul to clay yard -> clean/sieve/temper -> shaped greenware -> drying area -> firing -> usable vessel storage -> issue to clean or neutral stockpoint depending use

Important rules:
- wet clay is heavy and awkward
- greenware is fragile in transit
- newly fired but porous vessels may not be suitable for every liquid without condition checks

## 10.7 Seed and staple flow chain

harvest -> thresh/clean -> dry -> sort into eating stock and seed stock -> seed reserve storage -> planting issue later

Important rules:
- seed stock must be visibly separate
- seed should not auto-fill meal requests unless player overrides or starvation conditions trigger emergency use
- dry, pest-safe storage matters more than raw volume

---

# 11. Camp layout and logistic doctrine

## 11.1 Core site doctrine

A good early camp layout should reduce repeat walking between the most-used nodes:
- sleeping shelter
- hearth / cook area
- potable water stock
- daily fuel stock
- common food prep area

But it should also maintain necessary separation from:
- latrine / cathole zone
- refuse / rot pit
- carcass processing zone
- dirty hide work area
- smoky or fire-risk fuel bulk piles

## 11.2 Early logistic rings

A useful mental model is three rings.

### Ring 1 — immediate life-support zone
Very near sleeping and hearth:
- daily drinking water
- daily fuel/kindling
- basic cookware
- bedding repair items
- emergency wraps

### Ring 2 — routine work zone
Short walk from center:
- food sorting / cleaning area
- drying racks
- smoking frame
- wood stack
- stone pile
- basketry / fiber zone
- clay work area if site allows

### Ring 3 — dirty or strategic edge zone
Farther and separated:
- latrine
- refuse pit
- carcass waste
- raw hide zone
- large fuel reserve
- seed reserve if security and dryness justify
- field plots / gardens

## 11.3 Layout mistakes that should hurt

- storing clean water near waste area
- keeping all fuel far downhill from hearth
- processing carcasses beside sleeping area
- mixing daily food stock and seed reserve in same open basket
- scattering tools with no return zone
- keeping all communal stock in a damp low spot
- forcing every task to route through one crowded muddy choke point

---

# 12. Era-by-era logistics progression

## 12.1 State 0 — Lone survivor / emergency site

### Logistic character
One body, no infrastructure, almost no storage discipline.

### Typical realities
- most things are hand-carried
- source trips dominate the day
- one or two temporary caches may exist
- items are often dropped wherever exhaustion allows
- heavy loads strongly disrupt survival schedule

### Key logistic gains in this state
- first bundle or sling
- first crude cache
- first separation between dry sleeping goods and dirty work goods
- first remembered water route
- first habit of gathering extra fuel before dusk

### Logistic failure modes
- repeated over-carry causing exhaustion
- losing tools in clutter or darkness
- leaving food too long at source site
- not carrying enough water for work away from camp
- contaminating one’s only good vessel

## 12.2 State 1 — Primitive camp

### Logistic character
The camp now has repeat locations and some daily stockpoints.

### New logistic features
- dedicated wood pile
- one or more food baskets
- one raw-water and one safer-water separation if knowledge exists
- drying rack as temporary stockpoint
- better bundle methods
- cached materials near frequent work areas

### Main bottleneck
Repeated water, fuel, and food hauling still consumes huge labor.

### Important rules
- the camp should begin auto-generating refill tasks for daily-use stocks
- there should be strong benefit to keeping small buffers at use points
- clutter penalties should become visible

## 12.3 State 2 — Permanent camp

### Logistic character
Storage becomes a defining institution.

### New logistic features
- multiple purposeful stockpoints
- covered and raised storage options
- cool storage / pit storage under some conditions
- pottery and improved containers
- worksite-specific stock
- strategic reserve separation
- clearer clean/dirty material channels

### Main bottlenecks
- preserving enough before weather turns
- keeping stock dry and countable
- maintaining separation between reserve and daily use
- hauling between expanding work zones without wasting labor

### Key new doctrines
- use-point stock vs reserve stock
- dry vs wet storage classification
- communal vs personal vs worksite containers
- seasonal restocking tasks

## 12.4 State 3 — Tiny hamlet

### Logistic character
The settlement is now a small multi-node organism rather than one person’s camp.

### New logistic features
- household and communal storage coexist
- central store or store-yard emerges
- porter/hauler becomes meaningful role
- field-to-camp transport becomes seasonal major work
- path maintenance matters
- reserve accounting matters
- worksite buffers prevent central-store congestion

### New bottlenecks
- movement coordination
- congestion at water and hearth points
- stock visibility
- theft/misuse/confusion across households and work teams
- distance to fields/gardens
- carrying materials for construction and food preservation at the same time

### Logistic threshold to hamlet status
A true hamlet should be able to:
- keep daily drinking water available without constant crisis hauling
- maintain bulk fuel and staple stocks in known places
- separate clean, dirty, reserve, and waste stocks
- support construction and seasonal harvest movement without collapsing basic survival

---

# 13. Roles and labor specialization in logistics

## 13.1 Everyone does some hauling

In the early game, hauling is not a niche profession. Everyone does some of it because almost all work includes movement.

## 13.2 But some NPCs become better logistic workers

Relevant influences:
- strength / endurance
- interest in order, maintenance, or support work
- familiarity with routes
- lower drop/spill rate
- better planning discipline
- higher reliability under repetitive tasks

## 13.3 Early logistic role variants

### A. Water carrier
- route familiarity
- vessel discipline
- clean/dirty separation awareness
- urgency handling

### B. Fuel hauler / wood keeper
- dry/green sorting
- reserve awareness
- storm preparation

### C. Storekeeper / cache manager
- remembers where things are
- sorts by class and purpose
- reduces clutter
- protects reserves
- improves retrieval speed

### D. Harvest porter
- moves field output quickly
- stages baskets and containers before peak work
- reduces spoilage and labor idling

### E. Care porter
- moves water, wraps, broth, tools, bedding for sick/injured NPCs

These may start as role flags or favored tasks, not full professions.

---

# 14. Logistic AI and task-generation rules

## 14.1 Hauling should not require constant player babysitting

The player gives priorities and restrictions, but the system should generate many obvious movement tasks automatically.

## 14.2 Common auto-generated hauling tasks

### Refill tasks
Trigger when daily-use stock falls below threshold.
Examples:
- hearth kindling below minimum
- potable water vessel below target
- cook area missing clean vessel

### Retrieval tasks
Trigger when a process needs an input not yet present at use point.
Examples:
- hide yard lacks scraper
- clay shaping zone lacks temper
- cook task missing water pot

### Put-away tasks
Trigger when valuable tools or materials are left exposed after use.
Examples:
- knife left in rain
- basket left in dirty zone
- finished hide left at smoking frame

### Protection tasks
Trigger when weather or pests threaten stock.
Examples:
- rain incoming and wood pile uncovered
- dried food still on rack at dusk with bad weather risk
- rodents active near open grain basket

### Cleanup / declutter tasks
Trigger when movement efficiency drops or contamination rises.
Examples:
- camp core clutter above limit
- bone waste too near sleeping zone
- random loose materials blocking common path

### Reserve protection tasks
Trigger when reserve integrity is threatened.
Examples:
- daily-use stock trying to pull from seed reserve
- drought reserve water stored in wrong vessel

## 14.3 Task pull logic

A good first-pass hauling-task priority stack:
1. life-threatening or health-critical movement
2. food/water/fuel preservation and contamination prevention
3. active process support
4. reserve protection
5. route/camp declutter
6. long-horizon seasonal staging
7. low-urgency tidiness

---

# 15. Item flow permissions and restrictions

## 15.1 Not every item should be free to move anywhere

Movement restrictions improve realism and reduce chaos.

### Examples
- seed reserve cannot be auto-moved to cook area as ordinary food
- dirty hide tools should not be placed in clean eating vessel basket
- potable water vessel should not be filled from dirty wash source without treatment
- sick-person cup should stay separate if illness protocol exists
- fired but fragile greenware should not be stacked like stone

## 15.2 Container compatibility

Each container should support compatibility tags.

Examples:
- potable-water safe
- raw-water only
- dry-food safe
- seed reserve safe
- dirty-use only
- hot-material tolerant
- pest resistant low/medium/high
- weatherproof low/medium/high

## 15.3 Retrieval rules

Retrieval time should depend on:
- stockpoint clarity
- pile organization
- access path
- visibility / labeling knowledge
- whether the item is buried under other goods
- whether the retriever has authority/access rights

A messy store is not just ugly. It is slower.

---

# 16. Inventory representation philosophy

## 16.1 Avoid fake pocket dimensions

NPCs should not carry large invisible inventories.

Preferred representation:
- equipped or worn items
- hand-held items
- one or more attached carry containers
- possibly one drag/litter assignment
- small personal stash if justified

## 16.2 Loose stock is real

A lot of early camp wealth should exist as visible stock:
- wood piles
- stone piles
- baskets
- hanging food
- pots
- drying hides
- seed jars
- bedding bundles

## 16.3 Batch abstraction is allowed when physically honest

Some items may be represented as batches rather than single atoms, as long as the batch is still physically located and bounded.

Examples:
- “basket of tubers”
- “bundle of reeds”
- “stack of 18 dry branches”
- “pot of boiled water”

That keeps the logistics layer manageable while staying concrete.

---

# 17. Storage-flow data schema

## 17.1 Item instance / batch location fields

Recommended fields:
- **item_id / batch_id**
- **item_type**
- **quantity**
- **mass_class**
- **bulk_class**
- **fragility_class**
- **cleanliness_state**
- **freshness_state**
- **ownership_class**
- **reserve_flag**
- **current_holder_type** (world, npc, stockpoint, process, waste)
- **current_holder_id**
- **world_position**
- **last_moved_time**
- **last_clean_state_change_time**
- **exposure_flags** (rain, sun, pests, smoke, mud, blood, etc.)

## 17.2 Stockpoint record

Recommended fields:
- **stockpoint_id**
- **name**
- **stockpoint_type**
- **position**
- **linked_structure_id**
- **capacity_mass**
- **capacity_bulk**
- **allowed_item_tags**
- **forbidden_item_tags**
- **cleanliness_class**
- **weather_protection_class**
- **pest_protection_class**
- **temperature_class**
- **reserve_policy**
- **owner_policy**
- **restock_target**
- **restock_minimum**
- **depletion_priority**
- **ui_group**

## 17.3 Hauling task record

Recommended fields:
- **task_id**
- **task_family**
- **source_holder_id**
- **destination_holder_id**
- **item_or_batch_id**
- **preferred_container_type**
- **required_cleanliness**
- **required_authority**
- **urgency_score**
- **preservation_risk_score**
- **health_risk_score**
- **distance_cost**
- **path_risk**
- **expected_trips**
- **minimum_workers**
- **deadline_window**
- **interruptibility**

## 17.4 Route record (optional early, valuable later)

- **route_id**
- **from_node**
- **to_node**
- **distance**
- **terrain_mix**
- **average_cost**
- **hazard_flags**
- **weather_sensitivity**
- **path_quality**

---

# 18. Example early stockpoint set

A practical first version could include:

## Lone survivor
- temporary ground cache
- sleeping goods drop spot
- crude water vessel location
- loose fuel pile

## Primitive camp
- hearth daily fuel stack
- general dry basket
- raw water vessel zone
- safer water vessel zone
- drying rack inventory
- dirty-work tools basket
- refuse point

## Permanent camp
- covered wood reserve
- staple food basket / pot
- seed reserve jar
- clean vessel shelf
- clay stock area
- fiber basket
- finished hide rack
- cool storage pit
- worksite tool stocks

## Tiny hamlet
- communal store
- household bedspace stocks
- cook yard stocks
- hide yard stocks
- clay yard stocks
- field harvest staging area
- emergency reserve store
- wash/cleaning supply point

---

# 19. Metrics the player should be able to see

To make logistics legible in a minimal UI, show indicators like:

- average water haul distance
- average daily fuel haul distance
- time spent hauling vs productive processing
- clutter score by zone
- stock visibility score
- protected days of water
- protected days of fuel
- protected days of staple food
- reserve integrity warnings
- spoiled due to bad storage / bad transport
- tasks delayed because item is in wrong place
- tasks delayed because no compatible container exists

These are high-value management metrics even with tiny visuals.

---

# 20. Failure modes the logistics system should create

A realism-first logistics layer should generate believable problems such as:

- the camp is technically near water but the path is so bad that hydration labor is crippling
- enough wood exists in radius, but no one staged dry fuel before rain
- food spoils because it reaches camp too late or sits at the wrong stockpoint
- clean water gets re-contaminated during transport/storage
- seed reserve gets consumed because ordinary food stock was not physically separated
- construction stalls because poles, lashings, and digging tools are scattered
- one overworked NPC spends the whole day carrying instead of processing or building
- camp clutter increases retrieval time and injury risk
- work zones are arranged so badly that every useful action requires unnecessary round trips

These are exactly the kinds of realistic bottlenecks that should make the game feel alive.

---

# 21. First-playable minimum slice for this system

For the earliest implementation-facing design, the minimum worthwhile logistics model is:

## 21.1 Explicitly simulate
- item batches with physical location
- basic hand carry plus one or two carry aids
- source -> camp haul
- stockpoints
- raw vs safe water separation
- daily fuel stock vs reserve fuel stock
- food spoilage from delay/exposure
- simple clutter penalty
- reserve protection for seed and emergency stocks

## 21.2 Defer for later if needed
- highly detailed path engineering
- animal traction
- vehicle loading logic
- marketplace distribution
- complex theft/security
- advanced warehouse sorting
- long-distance trade caravans

Even with this minimum slice, the camp will already feel far more realistic than a generic inventory-based survival game.

---

# 22. Final design summary

The logistics layer should make the player feel a core truth of early settlement life:

> survival is not only about having resources — it is about getting the right thing, in the right condition, to the right place, at the right time, without exhausting the people who move it.

If the project gets this right, then even a simple top-down field of tiny dots and tiny stockpiles will feel believable.
Because the player will see that:
- distance matters
- carrying matters
- baskets matter
- storage discipline matters
- camp layout matters
- reserves matter
- and a stable settlement is, in large part, a solved movement problem.

---

# References / grounding sources

These sources were used to ground the realism assumptions in this spec.

- [L1] CDC — *How to Make Water Safe in an Emergency*  
  https://www.cdc.gov/water-emergency/about/index.html

- [L2] CDC — *Safe Water Storage*  
  https://www.cdc.gov/global-water-sanitation-hygiene/about/about-safe-water-storage.html

- [L3] World Health Organization — *Household Water Treatment and Safe Storage*  
  https://iris.who.int/bitstream/handle/10665/206916/9789290616153_eng.pdf

- [L4] CDC / NIOSH — *Ergonomic Guidelines for Manual Material Handling*  
  https://www.cdc.gov/niosh/media/pdfs/Ergonomic-Guidelines-for-Manual-Material-Handling_2007-131.pdf

- [L5] CDC / NIOSH — *Manual Materials Handling / Risk Factors*  
  https://archive.cdc.gov/www_cdc_gov/niosh/mining/topics/manualmaterialshandling.html
  and  
  https://www.cdc.gov/niosh/ergonomics/ergo-programs/risk-factors.html

- [L6] FAO — *Appropriate Seed and Grain Storage Systems for Small-scale Farmers*  
  https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content

- [L7] FAO — *Grain crop drying, handling and storage*  
  https://www.fao.org/4/i2433e/i2433e10.pdf

- [L8] World Health Organization — *Combating waterborne disease at the household level*  
  https://iris.who.int/server/api/core/bitstreams/94609a0c-ea77-4e1b-bda6-74b42069dac4/content
