---
title: "Realistic Incremental/Idle Colony-to-City Game - Early Game Design Bible"
version: "v0.2 - early-game expansion"
date: "2026-04-07"
status: "working draft"
based_on:
  - "v0.1 uploaded design document"
author: "OpenAI / ChatGPT"
project_notes:
  - "Realism-first, research-backed"
  - "Top-down minimal visuals in Godot"
  - "NPCs and objects can remain visually abstract while the underlying logic stays realistic"
  - "Player gives orders / priorities; NPCs execute based on needs, skills, traits, and available means"
---

# Early Game Design Bible v0.2

## Purpose of this document

This document narrows the huge colony-to-city concept into a **research-backed early-game design bible**.

The purpose is to answer:

- What should the player actually do with **one starting NPC and nothing else**?
- What are the most realistic first bottlenecks?
- What systems must exist before a second NPC, a permanent camp, and a tiny hamlet make sense?
- Which early items, tasks, buildings, and knowledge states are grounded in real human survival and early settlement logic?
- How should this be framed for a **minimal Godot presentation** without losing realism?

This document is intentionally biased toward the **absolute early game**:
- lone survival
- camp stabilization
- preservation and sanitation
- first containers
- first garden plots and seed saving
- first labor split
- first additional NPCs
- tiny 3–8 person proto-settlement

It does **not** try to detail metallurgy, carts, mills, steam, electricity, or vehicles yet. Those remain later documents.

---

# 1. What changed from v0.1

The previous draft was broad. This one is deliberately narrower and more concrete.

## 1.1 Focus
The design now centers on:

- **Day 1**
- **Days 2–7**
- **First month**
- **First season**
- **First winter**
- **Arrival of the first extra NPCs**
- **Transition from camp to tiny hamlet**

## 1.2 Presentation assumption
The game can keep a single overall presentation style from the beginning:

- top-down
- tiny colored dots / micro-tiles / tiny marks
- no need for full sprite art initially
- dense UI with strong data display
- player sets orders, priorities, and policies
- NPCs are autonomous within those constraints

That means realism should come from:
- dependencies
- timing
- needs
- logistics
- labor capacity
- risk
- maintenance of camp order

not from visually detailed assets.

## 1.3 Early-game realism stance
The starter NPC is **not** a blank mind. They begin with:
- ordinary human intuition
- a personality
- interests
- some aptitudes
- some basic problem-solving capacity

But they do **not** begin with:
- magical recipes
- industrial knowledge
- guaranteed success
- invisible tools
- a perfect memory of every edible or dangerous species

The game should model that difference carefully.

---

# 2. Core doctrine for the project

These principles should guide all later design work.

## 2.1 Nothing appears from nowhere
Food, water, heat, shelter, tools, containers, clothing, and later buildings all come from:
- materials in the world
- labor
- know-how
- time
- risk
- upkeep

## 2.2 Early survival is physical
The first game phase is about the body:
- thirst
- temperature
- wetness
- fatigue
- calories
- sleep
- wounds
- illness risk

The first day should feel like:
> "Can this person stay alive and functional long enough to become organized?"

## 2.3 Surplus creates civilization
A second NPC should not appear merely because the clock advanced.
A second NPC only becomes meaningful when the camp can support one.

Food, water, shelter, and sanitation must support population growth before population growth can solve labor shortages.

## 2.4 The world is realistic even if the graphics are abstract
An object can be one pixel on screen while still obeying realistic logic:
- wet fuel is worse fuel
- badly dried grain stores poorly
- untreated water is risky
- hides rot if left raw
- baskets are not the same as fired pots
- cold, damp sleeping destroys productivity

## 2.5 Institutions begin very early
Even a one-person camp already has proto-institutions:
- sleeping area
- food prep area
- refuse area
- water collection point
- toilet area
- fuel stack
- protected storage

This becomes important because settlements are not just bigger camps; they are more organized camps.

## 2.6 Player role
The player is best understood as:
- organizer
- priority setter
- planner
- policy setter
- production coordinator

not as the literal body doing each action.
That aligns well with an idle/incremental structure.

---

# 3. Baseline assumptions

## 3.1 World assumptions
This early-game design assumes:

- Earth-like world
- temperate starting biome
- nearby fresh water
- mixed open/wooded terrain
- wild edible plants present but not abundant enough to trivialize survival
- stone suitable for simple tools
- some clay or mud in the broader region
- seasonal change
- rainfall and wet/cold conditions as major early threats

## 3.2 Starting NPC assumptions
The starting NPC is:
- one healthy adult
- physically capable of walking, lifting, carrying, cutting, scraping, digging, gathering, and building crude shelters
- mentally capable of observation, memory, trial-and-error, and routine formation
- not guaranteed to know every plant, trap, or craft
- differentiated by traits, interests, and aptitude

## 3.3 Scale assumptions
The early game covers:
- one body
- one camp
- one local foraging radius
- one early seasonal food cycle
- one small emerging social unit

## 3.4 Time assumptions
The simulation should track:
- time of day
- weather
- temperature / seasonal band
- daylight
- task durations
- spoilage windows
- sleep cycles
- seasonal planting/harvest windows

Even if time is compressed for game feel, the **ordering of consequences** should remain believable.

---

# 4. Research-backed early survival truths that should shape gameplay

This section translates real-world survival and early-settlement logic into game design implications.

## 4.1 Water is urgent, but "found water" is not the same as "safe water"
CDC guidance for backcountry and travel settings treats untreated surface water as unsafe and says boiling is the best method to kill Giardia and other germs; filtering plus disinfection is another option.[R1][R2]

### Game implication
The first NPC may drink risky water if desperate, but:
- safer source selection matters
- boiling matters
- storage vessel cleanliness matters
- washing/dirty zones matter

Water should be modeled as:
- **source quality**
- **treatment state**
- **container cleanliness**
- **distance / hauling burden**

not just as "water = water."

## 4.2 Wetness is a major early killer
Army cold-weather guidance emphasizes that cold survival depends on food, water, shelter, insulating clothing, and staying dry, and notes that water conducts heat away from the body much faster than air.[R3][R4]

### Game implication
The early game must treat **wetness** as its own meaningful state:
- sleeping wet is bad
- working in rain without shelter is bad
- wet bedding is bad
- wet clothes/hide wraps are bad
- wet fuel is bad
- wet stored food is bad

This one variable can make the early game much more realistic.

## 4.3 Campsite placement is a systems decision
National Park Service guidance consistently emphasizes camping away from water sources and disposing of waste away from camp and water. It also emphasizes not expanding campsites unnecessarily, and separating washing from the actual water source.[R5][R6]

### Game implication
Camp placement should involve tradeoffs:
- closer to water reduces hauling
- farther from water reduces contamination and flooding risk
- better wind cover may increase dampness or smoke accumulation
- slope affects drainage
- nearby fuel saves time
- nearby game paths may improve hunting but raise animal risk

## 4.4 Storage and drying are civilization multipliers
FAO material on grain storage emphasizes drying, ventilation, moisture control, and protection from rodents, insects, and rain. Traditional structures like cribs, bins, baskets, pots, and raised stores exist because storage is a core survival problem, not a luxury.[R7][R8][R9][R10]

### Game implication
The difference between "food gathered" and "food secured" must matter.

The early game should sharply distinguish:
- fresh food
- drying food
- smoked food
- stored seed
- unsafe damp stores
- pest-damaged food
- spoiled food

## 4.5 Containers are one of the first true breakthroughs
Britannica describes pottery as one of the oldest and most widespread useful arts, with clay becoming water-resistant only after firing.[R11] Basketry, likewise, is an ancient container technology based on flexible plant fibers.[R12]

### Game implication
The early game needs a credible container ladder:

1. hands
2. bundled carry wraps
3. simple baskets / slings
4. hide bags
5. tightly woven baskets
6. clay bowls and jars
7. better fired storage pots
8. lined / covered storage pits
9. racks, bins, and raised stores

Containers should feel like one of the first real "tech trees" of civilization.

## 4.6 Hides are not leather just because an animal was killed
Britannica defines tanning as the treatment of raw hide or skin to convert it into leather, and notes very old tanning traditions using vegetable tannins or oils.[R13]

### Game implication
A fresh hide should pass through clear states:
- fresh hide
- rotting hide
- scraped hide
- dried hide
- smoked hide
- oil-treated hide
- crudely preserved hide
- truly tanned leather later

This is a major early realism upgrade over "wolf pelt = instant clothing material."

## 4.7 Fiber work and cloth are long chains
Britannica notes that weaving requires interlacing warp and weft threads on a loom.[R14] That means cloth is not a primitive first-day material. There is a real chain before woven fabric exists.

### Game implication
In the early game, clothing should begin as:
- wraps
- tied skins
- hide/fur drapes
- braided fibers
- crude cordage
- netted or looped simple goods
- only later spun and woven textiles

## 4.8 Agriculture begins before plows
Britannica notes that agriculture did not have one single origin and developed gradually in different places from management, cultivation, and domestication practices rather than from one instant invention.[R15]

### Game implication
The earliest agricultural gameplay should be:
- noticing useful stands of plants
- revisiting them
- protecting them
- transplanting or clearing around them
- saving seed
- simple digging-stick or hoe cultivation
- only much later true field agriculture

That is much more realistic than instantly unlocking neat rectangular farms.

---

# 5. Early-game simulation backbone

## 5.1 Body-state model
At minimum, each NPC should track:

- hydration
- calories / satiety
- fatigue
- body temperature strain
- wetness
- sleep debt
- injury
- sickness / infection pressure
- morale / stress

### Notes
- Hydration should fall faster during labor and heat.
- Calories should affect stamina, cold resilience, and healing.
- Wetness should amplify cold stress and reduce sleep quality.
- Sleep debt should reduce judgment, speed, and learning quality.

## 5.2 Trait / personality model
Each NPC should have:

- caution
- curiosity
- persistence
- sociability
- cleanliness
- routine preference
- stress tolerance
- pain tolerance

These do not replace skills. They shape behavior.

## 5.3 Interest model
Interests should drive willingness and learning speed, especially once more than one role exists.

Useful early interests:
- plants
- animals
- shelter/building
- tools
- fire/cooking
- order/cleanliness
- water/fishing
- crafting
- exploration
- caregiving
- storage/organization

## 5.4 Aptitude model
Aptitudes shape ceiling and error rate.

Useful early aptitudes:
- foraging sense
- handcraft precision
- physical endurance
- tracking/observation
- spatial sense
- memory
- coordination
- heat management
- animal handling
- risk judgment

## 5.5 Skill model
Skills rise through doing, observing, and being taught.

Early skills:
- scouting
- water collection
- firemaking
- shelter building
- foraging
- trapping
- butchery
- hide scraping
- cordage making
- basket making
- digging
- basic cooking
- drying/smoking
- storage handling
- sanitation discipline
- seed selection
- simple gardening

## 5.6 Knowledge model
Knowledge should exist at multiple levels.

### Individual intuition
What the NPC can attempt without formal unlocking.

### Learned practical methods
What repeated success turns into a repeatable task.

### Camp knowledge
What any NPC in the settlement can now perform reliably because it has been established, taught, or routinized.

### Example
The first NPC may experimentally dry meat.
Only after repeated success does the camp gain a stable "dry meat" process with expected time, yield, and risk.

---

# 6. Realistic early-game chronology

# 6.1 The first hours

The first hours should not be wide-open sandbox chaos. They should be organized around brutally realistic priorities.

## Goal
Stay alive long enough to create a stable overnight situation.

## Priority order

### A. Identify a viable campsite region
The starter NPC should scan for:
- freshwater access
- dry ground above flood line
- nearby deadwood
- nearby stone
- some wind protection
- visibility / safety
- not directly on an animal trail
- not too close to stagnant water
- enough nearby space to expand camp functions later

### B. Drink or secure water
If thirst is already significant, the NPC may need immediate intake.
But the game should make a distinction between:
- desperate drinking
- careful source choice
- treated water
- stored treated water

### C. Build an emergency shelter
The first shelter is not a hut. It is an emergency dryness and wind-management solution:
- lean-to
- debris shelter
- windbreak
- brush bedding
- ground insulation
- maybe a raised branch layer if enough time/material exists

### D. Acquire primitive cutting / pounding capability
The first functional tool set should be minimal:
- hammerstone
- sharp flake
- stout stick
- carrying bundle
- digging stick

### E. Begin fire effort if conditions and skill allow
Fire should be transformative but not guaranteed on day one.

It enables:
- heat
- water treatment
- cooking
- morale recovery
- light
- drying
- predator deterrence
- point-hardening
- smoke

### F. Acquire same-day calories
The best realistic early calories are not glamorous.
They are usually small, local, and low-investment:
- gathered plant foods
- eggs where available
- shellfish/invertebrates where biome allows
- insects
- scavenged plant carbohydrates
- opportunistic trapping or clubbing of very small game
- maybe fish if shoreline conditions are excellent

### G. Protect sleep
The day-one success test is:
- not freezing
- not sleeping on saturated ground
- not lying next to rotting waste
- not losing all gathered food to animals
- not waking exhausted and sick

---

# 6.2 Days 2–7: primitive camp stabilization

This is where the game becomes uniquely yours.
The NPC stops solving single emergencies and begins creating repeatable systems.

## Main objectives
- repeatable water access
- repeatable fire use
- better sleep
- better carrying
- more reliable calories
- first storage
- first hygiene habits
- first material specialization

## 6.2.1 Water system, week 1
The NPC should progress from:
- source found
to:
- source selected
to:
- water fetched regularly
to:
- some water treated
to:
- some water stored

### Week-1 water tasks
- identify least risky water point
- collect with hands / leaf folds / improvised scoop if needed
- improvise first water-carry method
- boil where vessel/fire conditions allow
- separate dirty and cleaner vessels when possible
- avoid fouling the source area

## 6.2.2 Shelter system, week 1
The emergency shelter becomes a camp shelter.

### Improvements
- thicker weather side
- better roof overlap
- better drainage
- separate bedding from bare ground
- nearby but not dangerously close fire spot
- fuel kept under cover
- dry sleeping area protected from sparks, smoke, and runoff

## 6.2.3 Fire and fuel system, week 1
The player should feel the difference between:
- having flame
- keeping flame
- keeping dry tinder
- maintaining a hearth
- having enough fuel for night + cooking + boiling

### Fuel categories
- tinder
- kindling
- small dry sticks
- long-burn fuelwood
- damp wood
- green wood
- rotten wood
- resinous wood

### System depth
The early game should reward:
- fuel sorting
- keeping tinder dry
- storing under shelter
- splitting or shaving damp wood if tool quality allows
- maintaining embers

## 6.2.4 Food system, week 1
The NPC must widen food strategy beyond luck.

### Best realistic early food channels
- recurring foraging patches
- opportunistic gathering routes
- shoreline gathering/fishing
- basic trap routes
- bird nest raiding where appropriate
- tuber/root digging where ecology supports it
- small-game capture
- carcass scavenging only as risky desperation behavior

### Strong design choice
Food should be categorized by:
- calories
- water content
- spoilage speed
- preparation need
- contamination risk
- carrying bulk
- seasonal availability

## 6.2.5 Tool system, week 1
The first useful specialized tools should emerge.

### Candidate tools
- scraper
- better cutting flake/knife
- digging stick
- sharpened spear
- club
- bone awl if butchery succeeds
- cordage
- stake
- frame sticks / pegs
- carrying sling

Stone flakes and scraper-like tools are historically among the most basic useful forms of stone technology; scrapers and awl-like tools are strongly associated with hide and material processing in archaeological toolkits.[R16][R17][R18]

### Design implication
The game should treat "stone tool" as too vague.
Different primitive tool functions matter:
- cut
- scrape
- pierce
- pound
- dig
- pry

## 6.2.6 Carrying system, week 1
One of the most important and underused realism levers is **carrying capacity**.

A single human without containers is terrible at moving civilization.

### Early carrying upgrades
- armload
- bundle wrap
- sling
- branch drag
- basket
- hide bag
- shoulder pole with slung loads later

This system creates believable early bottlenecks without needing combat or fantasy danger.

## 6.2.7 Sanitation system, week 1
Even one person should start forming camp hygiene rules immediately.

### Minimum sanitation zones
- toilet area downhill and away from water
- cooking area
- sleeping area
- refuse area
- butchery area if possible
- wash area away from direct source

NPS guidance commonly recommends catholes 6–8 inches deep and around 200 feet from water, camp, and trails, and moving dishwashing away from streams/lakes.[R5][R6]

### Game implication
Do not turn this into a manual hygiene simulator.
Instead, use **camp sanitation score** influenced by layout and behavior:
- waste too close to camp -> smell, flies, morale hit, illness risk
- butchery scraps left out -> scavengers, pests
- washing in source point -> dirty water risk
- food waste near sleep zone -> animal attraction

---

# 6.3 Weeks 2–4: permanent camp threshold

The camp is now more than a sleeping place.

## Main objectives
- stabilize calories over multiple days
- protect stores
- create first real containers
- preserve food
- process animal byproducts
- create first defined work areas
- support survival through bad weather days

## 6.3.1 Preservation begins
Preservation is the first real surplus technology.

### Early preservation methods
- air drying
- smoke drying
- roasting/drying near hearth
- cool pit storage for some foods
- protected hanging storage
- ash burial for some short-term cases
- fermentation later, but not necessarily first

USDA/FSIS material notes that drying is the world's oldest and most common method of food preservation.[R19]

### Game implication
Preservation should create:
- labor now for safety later
- fuel costs
- spoilage risk if weather is humid
- pest risk
- storage-space needs
- quality differences

## 6.3.2 Hide, bone, sinew, fat economy
An animal should become multiple material streams, not just "meat + hide."

### Outputs from successful animal processing
- meat
- organs
- fat
- bones
- sinew / tendon
- hide / skin
- horn/antler where relevant
- guts usable for cord or disposal burden depending tech

### Early uses
- meat: food, drying
- fat: calories, waterproofing help, primitive grease, maybe lamp later
- bone: awls, needles, hooks, points
- sinew: binding, thread
- hide: wraps, bedding, bags, lashings, shelter layers

This is a major place where realism can make the game feel special.

## 6.3.3 Basketry and fiber work
Basketry is an excellent early-game system because it is realistic, useful, and visually minimal.

Britannica describes basketry as interwoven objects made from flexible vegetable fibres such as twigs, grasses, bamboo, and rushes.[R12]

### Practical early-game uses
- gathering basket
- drying tray
- seed basket
- fish basket/trap later
- refuse carrier
- root/tuber storage
- firewood carrying aid
- wall/fence paneling
- reinforced containers if mud-lined later

### Fiber chain
- gather flexible stems/reeds/bark strips
- sort by length/flexibility
- soak or fresh-use depending material
- weave/braid/twist
- maintain and replace due to wear

## 6.3.4 First clay use
Clay should begin before pottery perfection.

### Clay uses before good pots
- sealing gaps
- lining hearth features
- lining baskets or pits
- daubing simple windbreak walls
- crude sun-dried forms
- trial vessels that may crack

Then later:
- shaped vessel
- slow drying
- pit firing
- fired cooking/storage vessel

Britannica notes that clay hardens permanently against water only after firing, and kilns/pit firing represent a major technological step.[R11][R20]

### Game implication
There should be many failed pots early.
This is good gameplay if the player understands why:
- bad clay mix
- poor temper
- too-fast drying
- uneven firing
- thermal shock

## 6.3.5 First semi-permanent structures
A permanent camp should start gaining specialized structures, even if all are tiny.

### Suggested early structures
- sleeping shelter
- hearth
- covered fuel stack
- drying rack
- smoke frame / smoke hut
- refuse pit/heap
- toilet area / latrine zone
- hide scraping frame
- raised food cache
- clay work patch
- small fenced garden patch
- seed store / protected basket or jar

---

# 6.4 First season: from survival to planning

The real transition into settlement begins when the NPC starts acting for the **next season**, not only the next day.

## Main objectives
- maintain seed stock
- establish repeatable plant patches
- preserve enough food for bad days
- hold enough fuel for cold/rain periods
- reduce losses to spoilage and pests
- survive weather setbacks without total collapse

## 6.4.1 Early plant management
The earliest food production should not instantly be "farming."
It should be:
- returning to good patches
- clearing around useful plants
- protecting them
- replanting useful seeds
- moving plants closer to camp
- watering only where practical
- weeding by hand
- marking seasonal expectations

## 6.4.2 Seed saving
Seed handling matters immediately once useful plants are recognized.

FAO guidance emphasizes the importance of seed quality, moisture, temperature, relative humidity, and protection from insects and rodents in storage.[R21][R22][R23]

### Game implications
Seed should have:
- species
- viability
- dryness
- purity / contamination
- pest damage
- age
- storage container
- storage environment

### Earliest seed mistakes
- eating all good seed
- storing damp seed
- mixing food grain and seed stock
- letting rodents into stores
- storing near wet walls / roof leaks
- planting damaged or immature seed

## 6.4.3 Garden plot logic
The first managed plots should be tiny and labor-intensive.

### Plot tasks
- clearing
- digging/loosening
- picking roots/stones
- sowing
- covering
- guarding
- weeding
- harvesting
- post-harvest drying

This gives a believable early settlement loop:
- more food potential
- but more labor concentration
- more need for storage
- more need for protection
- more need for time discipline

## 6.4.4 Food stores vs seed stores
A crucial realism rule:
**seed storage is not food storage.**

They overlap physically but not functionally.
The game should punish using next season's seed stock during panic hunger unless the player chooses desperation over long-term survival.

---

# 6.5 First winter or first harsh season

If the world has winter or a strong cold/wet season, this is the first serious test of camp legitimacy.

## Main winter risks
- insufficient fuel
- damp shelter
- inadequate bedding
- inadequate clothing/wraps
- food shortage
- weak food preservation
- frozen / inaccessible water
- illness and low morale
- inability to spend time outside productively

## 6.5.1 What winter should test
Not just:
- "Do you have enough food?"

Also:
- Do you have enough **dry** fuel?
- Can the NPC sleep warm and dry?
- Is the camp layout still workable in rain/mud/snow?
- Can you keep water drinkable?
- Are tools still usable?
- Can you protect stores from moisture, mould, and animals?

## 6.5.2 Winter-prep checklist for the design
Before harsh weather the player should ideally have:
- stronger shelter wall or roof
- thicker bedding
- some hide or fiber wraps
- dedicated fuel stock
- dried/smoked food
- protected seed
- latrine habit established
- cleaner water routine
- some indoor-ish work tasks for bad weather days

## 6.5.3 Winter work
Winter or wet-season labor should shift toward:
- repairing shelter
- tool maintenance
- hide work
- cordage
- basketry
- planning
- simple craft
- firewood processing
- seed sorting
- social bonding once more NPCs exist

This creates seasonal texture without needing huge new systems.

---

# 7. The transition from one NPC to more NPCs

This is one of the biggest conceptual decisions in the whole project.

## 7.1 Recruitment philosophy
Early additional NPCs should come through a mixed model:
- wanderers
- refugees
- rescues
- nearby isolated survivors
- attraction to visible camp stability
- occasional randomness shaped by the settlement's condition

This feels more realistic than unlocking population by points.

## 7.2 Conditions for first additional NPC arrival
A second NPC should only plausibly join when the camp has enough evidence of survival value:

- stable water routine
- sleeping place that can be expanded
- some surplus food or preserved food
- visible hearth
- some safety and order
- not obviously filthy or starving
- enough tasks that another person would truly help

## 7.3 Early recruitment events
Possible early events:
- injured traveler found nearby
- hungry drifter approaches camp
- seasonal migrant family member / acquaintance
- child/teen/adult rescue depending tone of the game
- abandoned camp found, leading to survivor encounter

## 7.4 The second NPC changes everything
Once two adults exist, labor can separate for the first time.

### Example splits
- one gathers water/fuel while one works on food/prep
- one scouts while one maintains fire and shelter
- one traps while one processes materials
- one tends garden while one preserves food

That means the **real value of the second NPC** is not just +100% labor.
It is:
- parallelism
- specialization
- better camp continuity
- lower failure from mutually exclusive tasks

## 7.5 The first social problems
The second NPC should also create new needs:
- more calories
- more water
- more sleep space
- relationship stress
- role mismatch
- hygiene pressure
- fairness issues
- leadership tension
- grief or morale effects if one is sick or injured

---

# 8. Early camp layout as a core system

Layout should matter even in a tiny-dot visual style.

## 8.1 Minimum early camp zones
A serious camp should eventually separate:

- sleep zone
- hearth/cooking zone
- fuel zone
- butchery/hide zone
- refuse zone
- toilet zone
- water handling zone
- drying/preservation zone
- storage zone
- work zone
- garden zone

## 8.2 Why this matters
This allows realism through spatial logic:
- smoke near bedding lowers sleep quality
- toilet too near water increases illness risk
- refuse near sleep attracts pests
- butchery near clean food zone increases contamination
- storage in damp low ground increases rot
- fuel too far from hearth wastes labor
- garden too far from camp is hard to guard

## 8.3 Godot implication
Each zone can be represented by:
- a tiny colored patch
- a heatmap / overlay
- tooltips
- task assignment borders
- icons in the UI rather than detailed art

This is a strong fit for your minimalist approach.

---

# 9. Early-game building and structure list

This is not a full database. It is a reality-based design seed.

## 9.1 Emergency structures
- brush windbreak
- debris lean-to
- crude fire spot
- branch bedding
- covered fuel pile
- crude cache

## 9.2 Primitive camp structures
- improved sleeping shelter
- hearth
- drying rack
- raised food cache
- hide scraping frame
- stake line / deterrent barrier
- basketry/fiber work spot
- wood rack

## 9.3 Permanent camp structures
- smoke frame / smoke shelter
- refuse pit / refuse heap
- toilet area / latrine
- clay working patch
- pit storage
- seed basket / seed pot
- covered work lean-to
- water-fetch path / access clearing
- first fenced patch
- first small garden bed

## 9.4 Proto-settlement structures
- second sleeping shelter
- shared cook/fire shelter
- larger store
- larger drying area
- separate work hut
- animal scavenger barrier/fence
- path clearing between zones
- first communal store
- first dedicated seed store
- first child/injured shelter if population/tone requires

---

# 10. Early-game item and material ladder

This is a design seed rather than a finished database.

## 10.1 Raw gathered materials
- branches
- sticks
- poles
- bark
- leaves
- grasses
- reeds/rushes
- vines/fibers
- stones
- sharp stone fragments
- clay/mud
- sand
- water
- edible plants
- roots/tubers
- nuts/seeds
- berries/fruits
- insects/eggs/shellfish
- deadwood
- green wood

## 10.2 Animal-derived early materials
- raw meat
- raw fat
- fresh hide
- scraped hide
- dried hide
- smoked hide
- bone
- sinew
- gut
- feathers
- horn/antler (where available)

## 10.3 Primitive processed materials
- cordage
- basket
- sling
- bundle wrap
- scraper
- cutting flake
- digging stick
- spear
- club
- awl
- needle
- hide wrap
- crude bag
- bedding bundle
- dry fuel bundle
- tinder bundle
- dried food
- smoked food
- ash
- charcoal trace / hearth charcoal later
- shaped clay lump
- sun-dried clay form
- fired pot shard
- fired crude bowl/jar

## 10.4 Early storage objects
- open basket
- covered basket
- hanging bundle
- hide bag
- ground pit
- lined pit
- clay bowl
- clay jar
- raised rack
- seed container
- fuel rack

## 10.5 Early statuses for items
Items should have meaningful states such as:
- wet
- dry
- clean
- dirty
- spoiled
- infested
- smoked
- cured
- cracked
- charred
- contaminated
- seed-worthy
- damaged
- rotten

This gives realism without requiring high graphical detail.

---

# 11. Early-game process list

## 11.1 Survival processes
- scout area
- fetch water
- drink untreated water
- boil water
- gather dry fuel
- gather green fuel
- keep fire alive
- sleep
- dry clothing/bedding
- eat raw
- eat cooked

## 11.2 Primitive material processes
- knap/break stone
- sharpen stick
- twist cordage
- weave basket
- scrape hide
- smoke hide
- dry hide
- cut sinew
- shape bone awl/needle/hook
- shape clay
- dry clay
- fire clay
- repair shelter
- dig shallow pit
- line pit with grass/clay

## 11.3 Food processes
- gather plant food
- dig roots/tubers
- roast food
- boil food
- dry strips
- smoke strips
- sort seed from food
- dry harvested seed
- store edible food
- store seed separately
- butcher animal
- render/use fat at crude level

## 11.4 Camp-order processes
- move refuse
- clean food area
- maintain latrine area
- wash away from source
- scatter dishwater
- inspect stores for rot/pests
- move stores to dry shelter
- re-sort wet fuel from dry fuel

## 11.5 Garden processes
- clear patch
- loosen soil
- sow seed
- transplant
- weed
- water where practical
- protect from animals
- harvest
- dry seed
- reserve best seed

---

# 12. The first playable loop

This is the clearest "game feel" version of the early design.

## 12.1 Core loop
1. **Observe**
2. **Prioritize**
3. **Gather**
4. **Stabilize**
5. **Protect**
6. **Preserve**
7. **Prepare for next day / next weather / next season**
8. **Attract or support more people**
9. **Assign roles**
10. **Create surplus**

## 12.2 Micro-loop, day scale
- wake
- check body state
- check weather
- secure water
- secure fuel
- gather/eat calories
- maintain fire/shelter
- perform one improvement task
- protect camp before sleep

## 12.3 Meso-loop, week scale
- expand food reliability
- improve camp layout
- make better tools
- build one new structure
- preserve one batch of food
- create one new container/storage method
- reduce one major risk

## 12.4 Seasonal loop
- prepare for worse weather
- secure seed
- reinforce shelter
- increase stores
- reduce camp filth
- complete at least one labor-saving material breakthrough

---

# 13. How this should feel in Godot

## 13.1 Camera and visuals
Recommended:
- top-down
- fixed or mildly zoomable
- terrain as simple color fields
- NPCs as dots
- resources as dots or tiny marks
- structures as tiny footprints / outlines / clusters
- overlays for zones, needs, danger, wetness, sanitation, and storage quality

## 13.2 UI philosophy
The UI should be:
- compact
- data-dense
- edge-anchored
- readable at a glance
- collapsible by category
- built around lists, filters, and priorities

## 13.3 Most useful panels
- NPC list
- current priorities
- camp alerts
- stores
- water / food / fuel summary
- weather / daylight / season
- active jobs
- camp layout overlay toggles
- knowledge / learned methods
- incoming person/opportunity events later

## 13.4 Important overlays
- walk cost
- wet ground / flood risk
- sanitation risk
- storage protection
- warmth/fire coverage
- wildlife pressure
- source nodes
- work zones

## 13.5 Why minimal graphics are a good fit
Your game's identity is in:
- causality
- bottlenecks
- state changes
- labor assignment
- survival planning
- settlement order

Minimal graphics keep the focus where it belongs.

---

# 14. What must be true before the game can honestly say "primitive camp achieved"

A primitive camp should count as achieved only when all of these are true:

- water is being fetched regularly
- the NPC usually sleeps under some shelter
- there is at least one functioning hearth/fire routine
- food is not always same-day desperation food
- at least one storage method exists
- at least one preservation method exists
- waste has been spatially separated from camp core
- some dry fuel can survive rain
- at least one tool category beyond "found stick/stone" exists
- the NPC can spend part of the day on improvement rather than pure emergency survival

This is a better threshold than "built hut level 1."

---

# 15. What must be true before the game can honestly say "permanent camp achieved"

A permanent camp should count as achieved only when:

- the camp survives multiple bad-weather days without collapse
- there is protected food storage
- there is dedicated seed protection
- there is some working container technology beyond bare hand-carry
- there is a repeated preservation workflow
- there is a stable sleep area
- there is a stable fuel reserve
- the camp has defined zones
- the camp can plausibly support at least one more person for some time

---

# 16. What must be true before the game can honestly say "hamlet begun"

A hamlet has begun when:

- more than one adult NPC is present
- food production/preservation is partly planned
- the settlement is no longer purely nomadic in behavior
- labor can be split into at least two ongoing roles
- storage is meaningful enough that spoilage/pests matter
- some plant management or gardening exists
- camp layout now functions as social infrastructure rather than private survival space

---

# 17. Strong next documents after this one

After this v0.2, the best next documents are:

## A. NPC Simulation Spec v0.1
Define:
- exact traits
- exact interests
- exact aptitudes
- exact needs decay rates
- morale logic
- learning logic
- injury/sickness handling
- task decision logic

## B. Early Game Data Sheets v0.1
Define:
- items
- processes
- structures
- statuses
- skills
- events
- storage types

## C. Godot Prototype Spec v0.1
Define:
- scene structure
- data-first architecture
- save format
- tick/update model
- job system
- need system
- overlay system
- UI panels
- debug visualization

---

# 18. Open questions still worth deciding

These are the most useful unresolved design questions after this draft.

## 18.1 How punishing should illness be?
Options range from:
- light risk modifier
to
- serious long-recovery survival threat

## 18.2 How much species identification do you want?
Do plants/animals exist as:
- simple categories
- broad realistic classes
- or highly specific real species by biome?

## 18.3 How much violence/predator threat do you want?
Is danger mostly:
- weather and scarcity
- plus occasional animals
- or a major constant threat?

## 18.4 How simulation-heavy should gardening be?
Do you want:
- simple sow/weed/harvest
or
- richer soil, seed quality, pests, moisture, and seasonal timing?

## 18.5 How visible should knowledge be to the player?
Should the UI expose:
- everything the camp could theoretically do
or only
- what has actually been observed, learned, or stabilized?

---

# 19. Conclusion

The early game should not begin as a crafting menu.
It should begin as a **human survival and camp-order problem**.

The realistic early arc is:

- find a viable place
- get water
- get dry
- get warm
- get enough calories
- protect sleep
- create order
- preserve food
- protect stores
- save seed
- improve materials
- support another person
- divide labor
- become a place instead of a temporary stop

If this part works, the rest of the civilization game has a real foundation.
If this part is weak or too gamey, later factories and cities will feel hollow.

This is the layer that determines whether the entire project feels believable.

---

# References

These references were used to deepen the early-game design logic in this draft.

- [R1] CDC, *Giardia Infection Prevention and Control*  
  https://www.cdc.gov/giardia/prevention/index.html

- [R2] CDC, *Water Treatment Options When Hiking, Camping, or Traveling*  
  https://www.cdc.gov/drinking-water/prevention/water-treatment-hiking-camping-traveling.html

- [R3] U.S. Army / Fort Benning Infantry Magazine, *Care and Maintenance of Our Most Dangerous Weapon*  
  https://www.benning.army.mil/infantry/magazine/issues/2021/Summer/pdf/15_Henry_txt.pdf

- [R4] U.S. Army Northern Warfare Training Center, *Cold Weather*  
  https://api.army.mil/e2/c/downloads/440625.pdf

- [R5] National Park Service, *Leave No Trace - Grand Teton National Park*  
  https://www.nps.gov/grte/planyourvisit/leave-no-trace.htm

- [R6] National Park Service, *Leave No Trace Seven Principles*  
  https://www.nps.gov/articles/leave-no-trace-seven-principles.htm

- [R7] FAO, *Grain crop drying, handling and storage*  
  https://www.fao.org/4/i2433e/i2433e10.pdf

- [R8] FAO, *Food storage and processing for household food security*  
  https://www.fao.org/4/w0078e/w0078e07.htm

- [R9] FAO, *Traditional farm/village storage methods*  
  https://www.fao.org/4/t1838e/t1838e12.htm

- [R10] FAO, *Crop handling, conditioning and storage: Grain storage*  
  https://www.fao.org/4/s1250e/S1250E0w.htm

- [R11] Britannica, *Pottery*  
  https://www.britannica.com/art/pottery

- [R12] Britannica, *Basketry*  
  https://www.britannica.com/art/basketry

- [R13] Britannica, *Tanning*  
  https://www.britannica.com/technology/tanning

- [R14] Britannica, *Weaving*  
  https://www.britannica.com/technology/weaving

- [R15] Britannica, *How agriculture and domestication began*  
  https://www.britannica.com/topic/agriculture/How-agriculture-and-domestication-began

- [R16] Britannica, *Flake tool*  
  https://www.britannica.com/technology/flake-tool

- [R17] Smithsonian Human Origins Program, *Stone Tools*  
  https://humanorigins.si.edu/evidence/behavior/stone-tools

- [R18] Smithsonian Human Origins Program, *Middle Stone Age Tools*  
  https://humanorigins.si.edu/evidence/behavior/stone-tools/middle-stone-age-tools

- [R19] USDA FSIS, *Jerky and Food Safety*  
  https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/meat-fish/jerky

- [R20] Britannica, *Kiln*  
  https://www.britannica.com/technology/kiln-oven

- [R21] FAO, *Seed and Seed Quality: Technical Information for FAO Emergency Field Staff*  
  https://www.fao.org/fileadmin/templates/tc/tce/pdf/Appendix_14_Seed_and_Seed_Quality_for_Emg.pdf

- [R22] FAO, *Seeds in Emergencies: a technical handbook*  
  https://www.fao.org/4/i1816e/i1816e00.pdf

- [R23] FAO, *Growing vegetables for home and market*  
  https://www.fao.org/4/i0526e/i0526e.pdf
