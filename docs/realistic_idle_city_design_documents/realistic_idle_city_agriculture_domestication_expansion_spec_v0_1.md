---
title: "Realistic Incremental/Idle Colony-to-City Game Design Document"
subtitle: "Agriculture & Domestication Expansion Spec"
version: "v0.1"
date: "2026-04-09"
scope:
  - "Earth-like setting"
  - "Temperate starting biome by default"
  - "Primary focus: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
  - "Secondary bridge: agrarian village prerequisites"
status: "Research-backed draft"
---

# Purpose of this document

This document expands the agriculture and domestication side of the design stack.

Its job is to answer questions that the earlier documents only introduced:

- What are the **realistic steps** from gathering wild plants to running managed plots?
- What makes a settlement count as having true **agriculture** rather than just opportunistic gardening?
- What are the realistic steps from wild animal contact to **managed livestock**?
- Which parts of “domestication” are plausible **inside the playable timescale**, and which are not?
- How do crops, animals, water, manure, labor, storage, risk, and knowledge fit into one believable system?

This document is not meant to replace the item, process, structure, settlement, health, food safety, logistics, or calendar documents.  
It is meant to tie them together specifically for agriculture and animal management.

---

# 1. Position in the stack

This document sits on top of the existing design direction:

- the colony begins with one vulnerable NPC
- the early target slice is lone survivor -> primitive camp -> permanent camp -> small hamlet
- early agriculture begins with tending favored wild plants, clearing patches, seed saving, transplanting, protecting plots, and storing seed
- the hamlet stage creates the first surplus and introduces fields, granary logic, seasonal planning, and the beginning of domestication
- domestication is a sequence, not a single unlock

This spec turns those broad statements into a more explicit model.

---

# 2. Core realism principles for agriculture and domestication

## 2.1 Agriculture is not just “planting seeds”
A believable agricultural system includes:

- land choice
- soil condition
- water availability
- seed quality
- seasonal timing
- weed pressure
- pest pressure
- labor peaks
- post-harvest handling
- reserve protection
- fertility maintenance

## 2.2 Domestication is not the same thing as animal keeping
This distinction matters a lot.

A settlement can:
- tolerate animals nearby
- attract scavengers
- capture juveniles
- tether or pen animals
- feed animals
- breed animals from already-domesticated stock

without truly creating a new domesticated species from local wildlife.

For realism, the game should separate:

1. **Wild exploitation**  
   Hunting, trapping, egg gathering, opportunistic milk theft where culturally relevant.

2. **Wild management / habituation**  
   Tolerating, baiting, corralling, or repeatedly interacting with animals.

3. **Captive keeping**  
   Holding living animals for meat reserve, manure, watch value, or later breeding.

4. **Husbandry of already-domesticated stock**  
   Managing animals that arrived through migration, rescue, inheritance, trade, or social exchange.

5. **Long-horizon domestication**  
   Multi-generation selection and stable breeding changes over very long timescales.

For the actual game, the main playable route in the early and mid stages should be **husbandry of already-domesticated stock**, not “invent sheep from deer.”

## 2.3 Regional realism matters
Agriculture is not universal in its details.

Real crop and livestock systems depend on:
- climate
- day length
- rainfall pattern
- frost pattern
- local soils
- local wild relatives
- cultural history
- access to already-domesticated lineages

So the cleanest design is to use **regional agriculture packages**.

A generic “temperate start” is fine for now, but the long-term design should attach agriculture to scenario packages such as:
- Old World temperate mixed farming
- Mediterranean dry farming
- forest-edge horticulture
- river-valley gardening
- steppe pastoral mix
- wet rice package
- highland tuber package
- New World maize/bean/squash package

For v0.1, the default assumptions below use a **temperate mixed-farming package**.

## 2.4 Agriculture is a reserve system
Early farming is not just about yield.  
It is about making sure that the settlement has:

- food for people
- seed for the next cycle
- fodder or browse for animals
- fibers/materials where relevant
- enough surplus to survive bad weather, illness, and mistakes

## 2.5 Animals are nutrient and labor systems, not only food units
Animals matter because they can convert things humans cannot directly eat into useful outputs:

- meat
- milk
- eggs
- wool/hair
- hides
- manure
- traction later
- alarm/watch value
- social status / exchange value

But they also impose real costs:

- daily water
- daily feed or access to browse/grazing
- fencing or tethering
- housing or weather protection
- disease risk
- parasite burden
- labor for cleaning
- predation risk
- reserve consumption during winter or drought

---

# 3. Scope and boundaries for this version

## 3.1 Primary scope
This document focuses mostly on:

- wild plant use
- plant tending
- household plots / garden patches
- first regular crop patches
- seed systems
- fertility loops
- post-harvest handling
- first realistic livestock entry
- very small flock/herd management
- hamlet-level surplus agriculture

## 3.2 Secondary bridge to later stages
This document also defines the bridge toward:

- larger fields
- crop rotations
- small grazing systems
- paddocks and fodder storage
- manure systems
- herd/flock breeding control
- animal traction prerequisites

## 3.3 Outside current scope
This document does **not** deeply define:

- full plow agriculture
- irrigation engineering beyond simple channels / carrying / storage
- dairy processing chains in detail
- commercial orchards
- advanced breeding science
- veterinary medicine beyond basic husbandry realism
- market agriculture
- industrial fertilizer systems

Those belong to later documents.

---

# 4. Default temperate agriculture package

For a generic Earth-like temperate starting scenario, the game should assume that the most realistic early agriculture candidate set is **mixed and gradual**, not one giant cereal monoculture.

## 4.1 Plant categories that make sense
Use categories first, specific species second.

### A. Gathered wild edibles
- berries
- nuts
- greens
- roots/tubers
- edible seeds
- fungi where setting allows

### B. Encouraged useful wild stands
- seed-bearing grasses
- berry shrubs
- nut-bearing trees
- wild alliums or greens
- naturally reseeding edible plants

### C. Managed garden crops
Suitable for hand tools and close attention:
- fast greens
- legumes
- roots/tubers
- herbs/medicinals
- fiber plants where region supports them

### D. Managed staple field crops
Suitable only after labor, storage, and timing improve:
- cereals
- pulses
- oil/fiber crops where relevant

### E. Support plants
- fodder crops
- mulch material
- hedge / living barrier plants
- cover crops or green manures later

## 4.2 Realistic early crop logic
The earliest realistic agriculture should move through this sequence:

1. Notice edible plants already thriving near camp
2. Revisit and protect those patches
3. Save seed or useful plant parts
4. Clear small garden patches in favorable soil
5. Transplant or sow close to camp
6. Protect from trampling, birds, rodents, and larger animals
7. Dry and store outputs properly
8. Keep back planting stock
9. Expand only when labor, storage, and water allow

This is much more realistic than “unlock farming -> place field.”

---

# 5. Plant-side progression ladder

# Stage A — Wild gathering with selective pressure

## 5.1 Identity
The NPC is still primarily a gatherer/forager but begins influencing plant communities.

## 5.2 Realistic actions
- revisit productive patches
- gather in ways that leave some reproductive stock
- scatter seeds near camp or along paths
- favor plants by clearing competing brush around them
- protect useful shrubs from accidental cutting
- learn seasonal harvest windows
- dry gathered seeds/fruits for later use

## 5.3 Outputs
- improved reliability of known patches
- first “camp-adjacent” edible growth
- first seed stock
- first simple rule: do not eat all collected viable seed

## 5.4 Gameplay meaning
This is still not full agriculture.  
It is **landscape shaping**.

---

# Stage B — Proto-gardening / tended plots

## 6.1 Identity
The settlement starts building very small managed plots near camp.

## 6.2 Plot characteristics
Good early plots should be:
- close to camp
- close to water
- visible from camp
- in reasonably loose, workable soil
- outside heavy shade unless species wants it
- above flood puddling zones
- protected from trampling

## 6.3 Labor sequence
- clear brush and stones
- loosen topsoil with digging stick / hoe
- incorporate ash, compostable matter, or rotted plant matter where available
- sow or transplant
- cover lightly
- water if rain is insufficient
- weed by hand
- protect from birds and mammals
- harvest selectively
- save seed from the healthiest fraction

## 6.4 Realistic crops at this stage
Best early crops are those that:
- tolerate hand labor
- can be watched closely
- produce useful food in small areas
- do not require draft traction
- fit near-camp care

## 6.5 Main risks
- sowing at the wrong time
- water stress
- seed predation
- weed competition
- trampling
- eating reserve seed
- poor storage after harvest

---

# Stage C — Permanent camp garden system

## 7.1 Identity
The camp now has recurring managed plots rather than one-off attempts.

## 7.2 What changes
The settlement now supports:
- dedicated garden zones
- seed store rules
- simple fencing or hedging
- plot naming
- repeat seasonal sowing
- more than one crop type
- preservation and carry-over planning

## 7.3 Garden design logic
A realistic near-camp garden should include:
- easy-access beds
- paths that avoid trampling crop roots
- drainage awareness
- access to wash water or carried irrigation water where necessary
- small protected nursery spaces for transplants
- compost / waste-to-fertility staging area at safe distance
- visible perimeter to deter animals

## 7.4 Why gardens come before real fields
Near-camp garden plots are realistic early because they:
- reduce travel time
- allow close supervision
- allow experimentation
- fit hand tools
- support dietary diversity
- produce seed stock and confidence

This makes them the correct bridge between foraging and field agriculture.

---

# Stage D — Staple patches and first field logic

## 8.1 Identity
The settlement starts depending on deliberate staple production, not only vegetables and gathered foods.

## 8.2 Requirements
Do not allow this stage until the settlement has:
- enough seed reserve
- stable storage
- enough labor during sowing and harvest windows
- enough food cushion to survive crop mistakes
- tools for repeated soil work
- some system for protecting crops

## 8.3 Realistic field tasks
- larger-scale clearing
- stump/root removal where applicable
- repeated digging / hoeing
- seedbed preparation
- sowing by season window
- bird/animal deterrence
- weeding
- harvest concentration
- drying before storage
- threshing / shelling / cleaning where relevant
- protected storage

## 8.4 Main bottlenecks
- labor spikes
- weather timing
- rodents and birds
- moisture at harvest
- inadequate drying space
- poor granary hygiene
- consuming seed stock in lean periods

---

# Stage E — Hamlet mixed agriculture

## 9.1 Identity
The hamlet begins operating as a true mixed smallholding system.

## 9.2 Features
- multiple plot types
- staple patch or field
- dedicated seed keeper logic
- protected granary or seed room
- labor calendar around sowing/harvest
- fertility management
- first introduced livestock or small captive herd/flock
- stronger reserve accounting

## 9.3 Realistic mixed outputs
The settlement now aims to produce not only calories, but:
- staple reserve
- dietary diversity
- planting stock
- animal feed/browse access
- fiber or hide support
- surplus sufficient for non-food specialists

---

# 6. Soil, fertility, and land-use realism

## 10.1 Soil is not just “fertility value”
For believable agriculture, soil and site should track at least:
- texture/workability
- drainage
- organic matter
- nutrient condition
- stoniness
- erosion risk
- weed pressure
- compaction/crusting
- moisture-holding tendency

## 10.2 Early fertility sources
Before industrial fertilizer, the most realistic fertility inputs are:
- ash in limited amounts
- rotted plant residues
- kitchen scraps
- compostable organic waste
- bedding-rich manure once animals exist
- leaf litter / plant litter
- fallow recovery
- legumes / mixed cropping later
- silt deposition in some flood-safe systems

## 10.3 Important realism rule: fresh manure is not universally safe
Fresh manure is useful as a nutrient source but creates contamination risk, especially around vegetables and water.  
So the game should distinguish:

- raw manure
- aged manure
- composting manure
- finished compost
- contaminated runoff

This matters for both health and agriculture.

## 10.4 Compost and waste loops
Once a permanent camp or hamlet exists, a realistic compost/fertility loop should begin:

- collect plant waste
- collect bedding-rich animal waste if animals exist
- keep away from clean water and food prep zones
- allow time and proper conditions to decompose
- apply to fields/gardens at appropriate times
- improve soil structure and nutrient return over time

## 10.5 Fallow, rotation, and diversity
Even small gardens benefit from not repeating the same crop in the same spot forever.

The design should eventually support:
- simple crop family rotation
- resting a patch
- growing legumes or cover crops later
- mixing crops in space and time
- moving animals carefully across browse/grazing areas

This is more realistic than “fertility slowly goes down unless magic fertilizer.”

---

# 7. Water management for crops and animals

## 11.1 Crop water realism
Crop success depends on:
- rainfall timing
- water-holding soil
- mulching / ground cover
- plot shading/exposure
- drainage
- carried water labor
- storage containers
- distance from camp water source

## 11.2 Hand-watered early agriculture
At early stages, irrigation should mostly mean:
- carrying water in containers
- pouring or channeling by hand
- prioritizing highest-value beds
- accepting that some field-scale planting is unrealistic without good rainfall

This creates a valuable realism pressure:
**gardens can be hand-supported; larger fields mostly depend on season and site.**

## 11.3 Animal water realism
Animals need:
- daily reliable access
- clean enough water
- trough/container hygiene where stored
- winter access if surface water freezes
- reasonable walking distance

Animals cannot simply subsist as invisible “pasture units.”

---

# 8. Crop protection and loss

## 12.1 Threat categories
Crop losses should come from:
- birds
- rodents
- wild herbivores
- insects/other pests in simplified form
- weeds
- trampling
- drought
- waterlogging
- mold at harvest/storage
- human error

## 12.2 Early protection methods
Realistic early protections:
- proximity to camp
- scare lines / noise / movement
- simple fencing
- brush barriers
- raised storage
- drying before storage
- clean granary / seed store
- diversified plots rather than one single vulnerable block

## 12.3 Design recommendation
Do not simulate every insect species.  
Instead, model broad pressures:

- **seed predation**
- **leaf loss**
- **root/tuber damage**
- **grain loss**
- **stored-food pest pressure**
- **stored-seed pest pressure**

That keeps the system realistic enough without becoming unreadable.

---

# 9. Seed system and planting-stock logic

## 13.1 Seed is strategic capital
Seed is not ordinary food.

The game should enforce a hard conceptual split between:
- food stock
- seed stock
- damaged/contaminated seed
- breeding stock for animals

## 13.2 Seed quality variables
Useful seed storage logic should track:
- species suitability to storage
- dryness
- cleanliness
- pest damage
- mold damage
- age
- temperature/humidity exposure
- whether selected from best plants or random plants

## 13.3 Seed keeper role
By hamlet stage, seed should justify a real role or at least a recurring responsibility:

- protect seed from accidental consumption
- monitor dryness
- inspect pests
- separate good seed from broken/infested stock
- choose which lines to expand next season
- maintain diversity buffer if possible

## 13.4 Planting-stock types
Not all crops reproduce only through dry seed.  
The system should support different planting-stock categories:
- dry seed
- tubers/root pieces
- cuttings
- transplanted seedlings
- bulbs/corm-like material if region package uses them

This is important for realism and future crop diversity.

---

# 10. Domestication realism framework

## 14.1 Important realism rule
A lone starter colony should usually **not** create brand-new domesticated species from local wild fauna in one short campaign arc.

Instead, the playable domestication ladder should prioritize:

### Route A — managed wild interaction
- tolerate scavengers
- protect against predators
- bait animals into repeatable paths
- capture juveniles occasionally
- keep live reserve animals temporarily

### Route B — husbandry of existing domestic stock
- migrants arrive with birds or small ruminants
- rescued people bring an animal
- trade introduces breeding pairs
- escaped domestic animals are captured and integrated

### Route C — long-horizon breeding project
- only for much longer timescales or legacy/world-history systems
- not the main early-game route

## 14.2 Animal states
A useful animal-state ladder:

1. **Wild**  
   No control.

2. **Tolerated**  
   Presence accepted because it brings benefit or is hard to prevent.

3. **Attracted**  
   Settlement behavior increases visits.

4. **Habituated**  
   Animals lose some fear due to repeated contact.

5. **Captured / restrained**  
   Temporary direct control.

6. **Managed captive**  
   Fed, sheltered, monitored.

7. **Breeding captive**  
   Reproduction under settlement control.

8. **Established domestic stock line**  
   Stable husbandry of a domestic lineage.

This state model is much more believable than one “domesticated = yes/no” flag.

---

# 11. Realistic early animal candidates

## 15.1 General rule
The best early livestock candidates are species that:
- fit smallholder systems
- provide useful outputs at small scale
- can be housed/fed with modest infrastructure
- do not instantly require large pasture systems
- have realistic routes of introduction

## 15.2 Candidate groups by role

### A. Dogs
Functions:
- alarm
- companionship
- hunting aid
- camp defense / warning
- hauling very limited only much later and not as a core early function

Realistic note:
Dogs are the most plausible early domestic companion, but a lone starter does not automatically begin with one unless scenario says so.

### B. Small scavenging poultry
Functions:
- eggs
- meat
- insect/scavenge conversion
- alarm/noise
- manure

Requirements:
- secure night shelter
- clean water
- feed supplementation
- protection from predators
- flock hygiene

Realistic note:
Chickens are realistic as introduced domestic stock, not as newly domesticated local temperate wildlife.

### C. Small ruminants (goats/sheep)
Functions:
- meat
- milk later
- hair/wool depending species
- hides
- manure
- browse/grazing conversion

Requirements:
- shelter from weather
- dry bedding / dry footing
- fencing or tethering
- parasite burden management
- winter feed / browse planning
- predator protection

Realistic note:
These fit mixed smallholder systems well, but even a tiny flock changes labor and reserve demands dramatically.

### D. Pigs
Functions:
- meat
- waste conversion
- fat
- hide/bristles in some settings

Costs:
- high feed demand if not foraging effectively
- rooting/trampling damage
- stronger fencing requirements
- waste concentration
- disease concerns

Realistic note:
Powerful but messy; not a trivial early unlock.

### E. Rabbits or other microlivestock
Functions:
- meat
- manure
- potentially low-space production

Requirements:
- secure cages/hutches or enclosed housing
- consistent feed/water
- strong sanitation and predator protection
- heat stress management depending climate

Realistic note:
Can be realistic in some regional packages and later introductions, but should not be universal by default.

---

# 12. Which animal package should the game prefer first?

## 16.1 Best default design answer
Do **not** force one universal first animal.

Instead, use a **scenario-appropriate first livestock package**.

## 16.2 Recommended default for a generic temperate start
For design simplicity and realism, the best default first-livestock options are:

### Option 1 — small domestic poultry package
Why it works:
- high recognizability
- egg/meat value
- small footprint
- manageable flock sizes
- ties into scraps, grains, insects, and predator pressure

### Option 2 — very small goat or sheep package
Why it works:
- high realism for mixed smallholder systems
- strong manure value
- meat/milk/fiber/hide potential
- clear fodder and shelter burdens

### Option 3 — no livestock yet, only captured live reserve animals
Why it works:
- most realistic for earliest lonely survival
- avoids premature husbandry complexity
- lets livestock arrive socially later

## 16.3 Recommended ordering
For the game’s realism and pacing, I would recommend:

1. lone survivor and primitive camp: **no true livestock**
2. permanent camp: **captured reserve animals and plot agriculture**
3. tiny hamlet: **first introduced domestic flock or herd**
4. agrarian village: **stable breeding and mixed crop-livestock system**

---

# 13. Animal feed and fodder realism

## 17.1 Feed categories
Animals should consume from realistic categories:
- grazing
- browse
- gathered forage
- kitchen scraps
- grain byproducts
- dedicated fodder crops later
- hay / dried fodder later
- stored roots/tubers or crop residues where relevant

## 17.2 Winter and drought pressure
This is one of the most important realism systems.

A flock/herd that seems cheap in summer can become extremely expensive in winter due to:
- low browse/grazing
- snow cover
- wet ground and foot issues
- need for stored feed
- water access problems
- higher shelter burden

## 17.3 Grazing is not infinite free food
The simulation should treat grazing/browse areas as:
- seasonal
- recoverable
- damageable by overuse
- variable in nutritional value
- linked to weather and terrain

## 17.4 Carrying-capacity rule
Every site should have a rough **sustainable animal capacity** based on:
- area
- vegetation type
- season
- stored fodder
- labor available for cut-and-carry feed
- water access

This is crucial to prevent animals from becoming a free multiplier.

---

# 14. Housing, fencing, and protection

## 18.1 Animal housing is a health system
Housing should affect:
- temperature stress
- wetness
- foot disease risk
- parasite pressure
- egg loss
- predation
- theft/escape
- labor to clean and maintain

## 18.2 Realistic minimal standards
Even the earliest useful housing should provide:
- weather protection
- dry resting surface or bedding
- drainage
- ventilation
- nighttime predator security
- access to clean water
- manageable feeding point

## 18.3 Fencing progression
A believable fence/protection ladder:
- watchful proximity to camp
- brush barriers
- tethering
- simple stake fencing
- reinforced pen
- separated paddock
- rotational paddock logic later

## 18.4 Predation and loss
Animals should be vulnerable to:
- fox-/dog-/wolf-like predators depending biome
- birds of prey for smaller stock
- theft or escape
- weather exposure
- disease outbreaks
- poor sanitation

---

# 15. Breeding, culling, and herd/flock structure

## 19.1 Breeding is not automatic population growth
For realism, animal reproduction should depend on:
- sex ratio
- breeding-age animals
- seasonality where relevant
- nutrition
- disease stress
- housing/security
- survival of young

## 19.2 Breeding goals
A believable smallholder does not keep every animal forever.  
The herd/flock should be managed for:
- replacement breeders
- meat reserve
- milk output later
- fiber/hide output
- manure production
- labor fit

## 19.3 Culling logic
The game should eventually support decisions like:
- keep breeding female
- keep one breeding male or use outside mating access
- slaughter surplus males
- cull weak/sick animals
- preserve pregnant/lactating animals when possible

## 19.4 Overwintering realism
The size of a herd/flock should often shrink or be intentionally culled before the hardest season unless enough feed and housing exist.

This is both realistic and interesting gameplay.

---

# 16. Health, disease, and biosecurity for animals

## 20.1 Early husbandry disease pressures
You do not need full veterinary simulation, but you do need believable categories:

- parasite burden
- respiratory stress from bad ventilation
- foot problems from wet housing
- injuries
- predator wounds
- nutritional deficiency
- contaminated water/feed
- overcrowding-related stress
- reproductive failure
- flock/herd disease events in simplified form

## 20.2 Biosecurity realism at hamlet scale
Even a tiny settlement can improve animal health by:
- keeping housing dry
- keeping feed and water clean
- limiting mixing with sick or unknown animals
- cleaning waste
- separating slaughter/butchering from live-animal areas
- observing new animals before mixing them fully

## 20.3 Human health overlap
Animals must integrate with the health and food safety docs:
- manure placement matters
- raw milk/meat/eggs need safe handling
- butchering cleanliness matters
- sick animals can threaten food safety and morale

---

# 17. Manure, bedding, and nutrient cycling

## 21.1 Why animals matter to soil fertility
Animals are powerful in farming systems because they help convert:
- browse
- grass
- residues
- scraps

into:
- manure
- bedding-rich compost feedstock
- urine-enriched fertility zones
- heat if composting, indirectly
- improved soil nutrient return

## 21.2 Manure is useful but dangerous if mismanaged
The design should never treat manure as a purely positive token.

Risks:
- smell and morale impact
- flies/pests
- contamination of water
- vegetable contamination if misused
- ammonia/air-quality burden in housing
- pathogen carryover

## 21.3 Manure handling ladder
- raw droppings in place
- periodic cleaning and pile-up
- mixed with bedding
- aging / partial decomposition
- managed composting
- application to soil at safer times and places

## 21.4 Urine and bedding matter too
Do not reduce fertility to dung alone.  
A realistic system should also care about:
- bedding absorption
- wetness in pens
- urine concentration
- straw/leaf/litter mixing
- removal frequency

---

# 18. Labor and role structure

## 22.1 Early agriculture roles
By permanent camp / early hamlet, the following roles make sense:

- plot tender
- seed keeper
- water carrier for high-value beds
- crop watcher / deterrence watcher
- harvester
- dryer / preserver
- storekeeper

## 22.2 Early livestock roles
Once domestic stock exists, these roles become meaningful:
- feeder/waterer
- herder / watcher
- pen cleaner
- egg collector
- breeder / selector
- butcher / processor
- fodder gatherer
- bedding gatherer

## 22.3 Seasonal labor spikes
Agriculture and husbandry create hard peaks:
- bed preparation
- sowing
- weeding bursts
- harvest
- threshing/shelling
- hay or fodder gathering later
- winter feed hauling
- lambing/kidding/chick hatching equivalents where used

This should interact strongly with the time/calendar and task docs.

---

# 19. Agriculture and domestication as knowledge systems

## 23.1 Discovery examples
- this plant reseeds reliably near camp
- this soil patch drains well
- these seeds mold if stored damp
- these birds return to the feeding area
- this browse keeps goats healthier than that patch
- this fence design reduces nighttime loss

## 23.2 Procedural knowledge examples
- how to prepare a bed
- how deep to sow
- how to dry seed
- how to recognize seed maturity
- how to mix bedding and manure
- how to maintain a dry coop/pen
- how to isolate sick stock

## 23.3 Institutional knowledge examples
- reserve rules for seed and breeding animals
- who may slaughter which animals
- when to rotate plots
- how much winter fodder must be stored before herd growth
- quarantine/observation rules for newly acquired animals

---

# 20. Integration with other systems

## 24.1 Items & materials
Needs direct links to:
- seed classes
- edible yields
- straw / stalk / husk / chaff outputs
- manure states
- bedding materials
- fodder items
- eggs / milk / wool / hair / hides
- damaged or contaminated outputs

## 24.2 Process bible
Needs direct links to:
- bed preparation
- sowing/transplanting
- watering
- weeding
- harvest
- drying/threshing/shelling
- composting
- pen cleaning
- feeding/watering routines
- breeding and slaughter workflows

## 24.3 Building & structure bible
Needs direct links to:
- fenced garden plots
- seed store
- granary
- animal pen
- coop/shed
- fodder rack
- bedding store
- compost/manure area
- milking/slaughter processing areas later

## 24.4 Health and food safety
Needs direct links to:
- safe manure use
- animal disease events
- milk/egg/meat handling
- contamination of water and produce
- nutrition diversity effects

## 24.5 Governance and allocation
Needs direct links to:
- seed reservation
- breeding-stock protection
- slaughter permissions
- rationing during bad harvests
- field/animal labor obligations

## 24.6 Logistics
Needs direct links to:
- water carrying to beds
- moving harvest to drying/storage
- hauling bedding and manure
- moving fodder
- carrying feed to pens
- distance penalties between plots and camp

---

# 21. Recommended gameplay thresholds

## 25.1 When a settlement counts as “doing agriculture”
Minimum believable threshold:
- at least one recurring managed plot over more than one cycle
- stored planting stock
- a recognized sowing/harvest window
- some crop-protection effort
- some reserve logic

## 25.2 When a settlement counts as “farming”
Stronger threshold:
- staple-oriented production
- seed reservation rules
- meaningful harvest labor spike
- storage infrastructure
- plot/field expansion beyond near-camp convenience beds
- agriculture now critical to settlement calories

## 25.3 When a settlement counts as “doing husbandry”
Minimum believable threshold:
- live domestic animals under recurring human care
- controlled feeding/watering
- controlled nighttime security
- health/sanitation burden
- reproduction or intentional holding beyond immediate slaughter

## 25.4 When a settlement counts as “mixed farming”
- crops and animals both present
- nutrient or residue flow between them
- animal products used beyond emergency meat
- crop residues / browse / waste feed into livestock
- manure/bedding feeds soil improvement

---

# 22. Design recommendation: what to include first

## 26.1 Strongest initial plant package
For the next content layer, the best first agriculture module is:

- encouraged wild plants
- near-camp garden plots
- seed saving
- watering/weed/protection loop
- one staple patch class
- one legume/pulse class
- one green/vegetable class
- one root/tuber or region-specific equivalent
- drying and granary/seed-store integration

## 26.2 Strongest initial domestication package
For the first livestock module, the cleanest choice is:

### conservative version
- no livestock in lone survivor
- no true livestock in primitive camp
- permanent camp may hold captured reserve animals briefly
- tiny hamlet receives first small domestic flock or herd through people/social route

### recommended first domestic package
Either:
- **small domestic poultry**
or
- **very small goat/sheep package**
depending on the scenario package you want to use first.

## 26.3 Why this ordering is best
It keeps the game realistic because:
- plants can plausibly be managed before true animal husbandry
- seed and plot management teach reserve logic early
- livestock then arrive into a settlement already capable of storage, scheduling, and rule-making
- manure and fodder loops make sense only once the settlement has enough structure

---

# 23. First-playable minimum for this expansion

If you later want to turn this spec into the next content slice, the minimum believable agriculture/domestication package would be:

## Plant side
- 3-5 wild edible plant categories
- 2-3 encouraged wild stand categories
- 3 near-camp garden crop categories
- 1 staple patch category
- seed selection, drying, storage, and spoilage
- plot fertility state
- weed/pest/animal pressure
- seasonal sow/harvest window logic

## Animal side
- 1 optional dog-type companion route or none
- 1 first livestock package only
- water/feed/housing/sanitation needs
- predator/escape loss
- breeding-stock vs slaughter-stock distinction
- manure and bedding accumulation
- winter burden

## Structures
- fenced plot
- seed store
- granary
- basic pen/coop/shed
- manure/compost area
- fodder/bedding store

## Roles
- grower/seed keeper
- harvester/preserver
- herder/feeder
- storekeeper

---

# 24. Data schema recommendation

Each crop type should track at least:
- crop family
- climate/season suitability
- sowing window
- growth duration class
- edible yield categories
- seed yield category
- water sensitivity
- soil sensitivity
- frost sensitivity
- shade tolerance
- weed sensitivity
- pest pressure profile
- storage behavior
- processing requirements
- byproducts/residues
- feed value for animals
- fertility impact / rotation notes

Each animal type should track at least:
- species/group
- domestication source route
- climate suitability
- housing requirements
- feed categories
- water need class
- reproduction pattern
- growth/maturity pattern
- product outputs
- manure output
- disease/parasite sensitivity
- predator vulnerability
- temperament/escape tendency
- labor burden
- over-winter burden
- breeding value vs slaughter value

Each managed plot / herd should track at least:
- owner or governance status
- reserve priority
- current condition
- productivity outlook
- labor needs now / soon
- risk status
- season stage
- logistics burden
- dependencies (water, fencing, bedding, feed, storage)

---

# 25. Recommended next follow-up after this document

After this spec, the cleanest next expansions would be one of:

1. **Trade / Market / Exchange Spec**  
   if you want to continue broad settlement/economy growth

2. **Village Craft & Workshop Specialization Spec**  
   if you want to follow food surplus into real trades

3. **Agriculture Content Pack v0.1**  
   if you want a concrete list of crop packages, livestock packages, items, structures, and processes next

4. **Region Package Spec**  
   if you want to decide whether your first playable agriculture uses an Old World temperate, Mediterranean, forest-edge, or another specific agriculture set

---

# References used for realism grounding

- Britannica — How agriculture and domestication began  
  https://www.britannica.com/topic/agriculture/How-agriculture-and-domestication-began

- Britannica — Earliest beginnings of agriculture  
  https://www.britannica.com/topic/agriculture/Earliest-beginnings

- Britannica — Early development of agriculture  
  https://www.britannica.com/topic/agriculture/Early-development

- Britannica — Domestication  
  https://www.britannica.com/science/domestication

- Britannica — Chicken  
  https://www.britannica.com/animal/chicken

- FAO — Appropriate Seed and Grain Storage Systems for Small-scale Farmers  
  https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content

- FAO — Seeds in Emergencies: Technical Handbook  
  https://www.fao.org/4/i1816e/i1816e00.pdf

- USDA — Cover Crops and Crop Rotation  
  https://www.usda.gov/about-usda/general-information/initiatives-and-highlighted-programs/peoples-garden/soil-health/cover-crops-and-crop-rotation

- NRCS — Rotations for Soil Fertility: Small Scale Solutions for your Farm  
  https://www.nrcs.usda.gov/sites/default/files/2023-01/Rotations%20for%20Soil%20Fertility-%20Small%20Scale%20Solutions%20for%20your%20Farm.pdf

- FAO — The benefits of composting, reusing and recycling nutrients for agricultural productivity  
  https://www.fao.org/land-water/overview/onehealth/composting/en/

- Penn State Extension — Wise Use of Manure in Home Vegetable Gardens  
  https://extension.psu.edu/wise-use-of-manure-in-home-vegetable-gardens/

- MSD / Merck Veterinary Manual — Management of Backyard Poultry  
  https://www.msdvetmanual.com/exotic-and-laboratory-animals/backyard-poultry/management-of-backyard-poultry

- MSD / Merck Veterinary Manual — General Management of Goats  
  https://www.msdvetmanual.com/management-and-nutrition/preventative-health-care-and-husbandry-of-goats/general-management-of-goats

- MSD / Merck Veterinary Manual — Nutrition of Goats  
  https://www.merckvetmanual.com/management-and-nutrition/preventative-health-care-and-husbandry-of-goats/nutrition-of-goats

- MSD / Merck Veterinary Manual — General Management of Sheep  
  https://www.msdvetmanual.com/management-and-nutrition/preventative-health-care-and-husbandry-of-sheep/general-management-of-sheep

- FAO — Sheep and goats for diverse products and profits  
  https://www.fao.org/4/i0524e/i0524e00.htm

- FAO — Developing home gardens  
  https://www.fao.org/4/y5112e/y5112e05.htm

- FAO — Home garden technology leaflets  
  https://www.fao.org/4/v5290e/v5290e04.htm
