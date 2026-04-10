
---
title: "Realistic Incremental/Idle Colony-to-City Game - Process Bible"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
design_alignment:
  - "Realism-first"
  - "Explicit physical objects from the beginning"
  - "Player gives orders / priorities"
  - "Minimal top-down visuals"
  - "One-NPC-to-hamlet early slice"
author: "OpenAI / ChatGPT"
date: "2026-04-07"
---

# Realistic Incremental/Idle Colony-to-City Game - Process Bible

## Purpose

This document defines the **process layer** for the early game of the project:
- how work is actually done
- what inputs, tools, knowledge, labor, time, and conditions each process requires
- what outputs, byproducts, risks, and follow-up burdens each process creates
- how early camp life becomes repeatable, then dependable, then expandable

This is the companion to:
- the broad design document
- the early-game bible
- the NPC simulation spec
- the NPC data schema
- the task evaluation spec
- the item & material bible

The item bible defines **what exists**.  
This document defines **how one thing becomes another**.

The aim is not to write a tiny recipe list. It is to make the early game feel like a believable chain of physical work:
- water must be fetched, clarified, heated, and stored
- food must be gathered, handled, cooked, preserved, and protected
- a hide must be removed, fleshed, dried/softened/smoked, and then cut and tied into useful things
- clay must be found, moved, cleaned, tempered, shaped, dried, and fired
- seed must be selected, dried, protected, and reserved instead of eaten

That means processes are one of the core realism systems of the whole game.

---

# 1. Design stance for the process layer

## 1.1 What a process is

A **process** is any transformation, movement, preparation, maintenance routine, or repeated work pattern that changes the state of the colony.

A process can:
- transform inputs into outputs
- move goods from one place or state to another
- improve safety, cleanliness, or readiness
- preserve goods against decay
- create structures or work zones
- transfer knowledge through repetition, teaching, or observation

Examples:
- gather deadwood
- settle cloudy water
- boil water
- shape a stone flake
- scrape a hide
- dry meat
- smoke a hide
- dig a latrine
- save seed
- move goods into cache storage
- maintain a hearth
- patrol trap lines
- clear a garden patch

## 1.2 Process realism rules

The process layer should follow these rules:

### A. No invisible magic
Nothing should transform without:
- labor
- time
- place
- required materials
- some degree of know-how
- often tools, fuel, or suitable weather

### B. Setup and cleanup matter
In a realism-first game, work is not only the central transformation.
Many early processes also include:
- travel
- setup
- sorting
- waiting
- turning or checking
- cleanup
- packing away
- storing outputs properly

### C. Distance matters
A process performed beside camp is different from the same process far away.
Distance affects:
- time
- fatigue
- carrying burden
- spoilage risk
- safety
- how often the task is worth repeating

### D. Cleanliness matters
Early camp processes often fail because of dirt, wetness, pests, contaminated hands, mixed zones, or unsafe storage.
That means cleanliness is not just a “health system.” It is part of production quality.

### E. Not all work creates “items”
Some processes mainly create:
- readiness
- reduced risk
- better camp layout
- cleaner work surfaces
- hotter fires
- drier bedding
- stronger habits
- better knowledge reliability

These still matter and should not be ignored just because they do not instantly spawn a new item stack.

### F. Processes create new burdens
Useful work often creates secondary work:
- butchering creates offal disposal
- cooking creates dirty vessels
- carrying water creates empty containers that need refilling
- clay digging creates hauling burdens
- smoking requires dry fuel and regular tending
- seed saving creates the social burden of not consuming a valuable reserve

---

# 2. Scope of this document

This version covers the early slice only:

## Included eras
- **Era 0:** lone survivor
- **Era 1:** primitive camp
- **Era 2:** permanent camp / proto-settlement
- **Era 3 (early edge only):** tiny hamlet with first labor split

## Included process families
- scouting and site selection
- camp layout and hazard reduction
- water
- fire and fuel
- immediate survival shelter
- early camp construction
- primitive toolmaking
- carrying and hauling
- food gathering and first hunting
- butchering and carcass handling
- cooking and basic preservation
- hides, bone, sinew, and fat
- fiber, cordage, and basketry
- clay and first pottery
- plant tending, seed saving, and first horticulture
- sanitation, hygiene, and camp maintenance
- storage, caching, and stock rotation

## Not deeply covered yet
These belong mostly to later documents or later versions:
- metallurgy
- lime, mortar, quarrying at scale
- wheeled vehicles
- animal traction
- milling
- formal textiles beyond the earliest groundwork
- markets and long-range trade
- industrial utilities
- modern chemistry and machinery

---

# 3. Core process record schema

This is the recommended canonical schema for every authored process.

## 3.1 Identity block
- **process_id**
- **display_name**
- **family**
- **era_min**
- **era_max**
- **summary**
- **why_it_exists**

## 3.2 Process type block
- **process_kind**
  - discrete
  - repeatable discrete
  - batch
  - campaign
  - routine maintenance
  - periodic check
  - seasonal
- **player_visibility**
  - direct order
  - auto-generated need
  - scheduled routine
  - opportunity-based
  - emergency override

## 3.3 World requirements block
- **required location tags**
  - fresh water edge
  - tree cover
  - clay patch
  - hearth zone
  - work surface
  - storage zone
  - latrine zone
- **forbidden location tags**
  - sleeping zone
  - clean food storage
  - water source edge
- **weather sensitivity**
  - impossible in rain
  - easier in dry weather
  - riskier in freezing weather
  - requires sunlight / airflow
- **season sensitivity**
  - spring / summer / autumn / winter preference
- **time-of-day preference**
  - daylight preferred
  - nighttime allowed
  - nighttime discouraged

## 3.4 Input block
- **consumed inputs**
- **durability-used tools**
- **required fuel or heat**
- **required water quality**
- **required container state**
- **optional quality-improving inputs**

## 3.5 Labor block
- **minimum workers**
- **ideal workers**
- **skill domains touched**
- **primary body demand**
  - lifting
  - endurance walking
  - fine hand work
  - repetitive motion
  - heat exposure
  - cold exposure
- **attention pattern**
  - continuous
  - intermittent
  - setup then waiting
  - repeated checking
- **interruptibility**
  - easy
  - moderate
  - hard
  - dangerous to interrupt

## 3.6 Knowledge block
- **baseline intuition allowed**
- **discovery requirements**
- **procedural knowledge requirements**
- **tool knowledge requirements**
- **institutional knowledge relevance**
- **can_be_learned_by_doing**
- **can_be_taught**
- **teaching_bonus_sources**

## 3.7 Time block
- **setup time**
- **active labor time**
- **passive waiting time**
- **cleanup time**
- **time variability drivers**
  - skill
  - tool quality
  - weather
  - distance
  - batch size
  - fatigue
  - crowding
  - repeated practice

## 3.8 Output block
- **primary outputs**
- **secondary outputs**
- **byproducts**
- **waste streams**
- **quality grades**
- **state changes**
- **knowledge gain**
- **skill gain**

## 3.9 Failure / risk block
- **common failure modes**
- **injury risks**
- **contamination risks**
- **spoilage risks**
- **waste risks**
- **quality loss causes**
- **predator / pest attraction**
- **weather losses**

## 3.10 Logistics block
- **typical carry burden**
- **bulkiness**
- **travel penalty**
- **staging needs**
- **recommended nearby storage**
- **follow-up tasks generated**

## 3.11 Simulation/UI block
- **map footprint**
- **visible state cues**
- **progress states**
- **task priority tags**
- **alert tags**
- **needs this process answers**

---

# 4. Cross-cutting simulation rules for early processes

## 4.1 Travel is part of the process
Every early process should include travel unless it explicitly occurs at the NPC’s current location.
This matters because:
- a one-person camp loses huge amounts of time to walking
- many tasks only become “good tasks” if done in clusters
- poor camp placement silently makes everything worse

Examples:
- hauling one log from far away may be irrational
- gathering edible greens is much better if combined with water collection
- clay gathering should be bundled with a future pottery batch, not done thoughtlessly every day

## 4.2 Staging matters
Many early processes work better when the NPC first stages goods:
- stack fuel by the hearth before night
- move hides to the hide-work area before scraping
- collect a full basket of reeds before weaving
- stage dirty water near the clarification area, not in the sleeping area
- place seed in a dry, protected sort zone before storage

## 4.3 Fuel is not a background stat
Fuel should be treated as a material burden:
- tinder
- kindling
- small dry fuel
- longer-burning fuelwood
- dry smoky material for some preservation uses
- special slow-smoke wood for hides/food where appropriate

A strong fire process is impossible if the camp only tracks a generic “fuel” number without quality/state differences.

## 4.4 Clean and dirty zones matter
The early camp should gradually separate into:
- clean drinking water handling
- cooking / vessel area
- butchering / bloody work area
- hide work area
- refuse / carcass waste area
- latrine zone
- sleeping area

The more these zones mix, the more contamination, smell, pests, and morale penalties should appear.

## 4.5 Waiting is part of work
Some processes involve low-active but high-calendar time:
- drying meat
- drying vessels
- drying fiber bundles
- curing onions later
- airing bedding
- smoking a hide
- storing seed to finish drying

These are still processes, not merely timers.
They need:
- space
- protection
- checks
- rework if weather turns bad
- collection at the right time

## 4.6 Storage finishes the process
A process is often not truly complete until outputs are stored correctly.
Examples:
- boiled water left open is not the same as safely stored water
- dried food left in damp air degrades
- seed mixed with food stock is a social and logistical mistake
- a softened hide left wet can stiffen or rot
- finished cordage left on the muddy ground is a quality loss

## 4.7 Camp work creates learning
Many early processes should generate:
- embodied skill (hands-on competence)
- discovery knowledge (this material exists / works)
- procedural knowledge (this sequence produces reliable results)
- task confidence (reduced hesitation and fewer errors)
- quality control habits (sorting, checking, labeling, keeping dry, keeping clean)

## 4.8 Failure should usually waste time before it wastes everything
Most early failures should not instantly destroy the colony.
Instead they should more often cause:
- inferior output
- partial spoilage
- increased disease risk
- extra labor to redo
- tool wear
- lower confidence
- reduced morale

Catastrophic failure should be possible, but not constant.

---

# 5. Canonical process families

The early game process catalog is best organized into the following families:

1. **Scouting and site selection**
2. **Camp layout and structure work**
3. **Water**
4. **Fire and fuel**
5. **Primitive tools and implements**
6. **Hauling, carrying, and staging**
7. **Food acquisition**
8. **Carcass handling and edible processing**
9. **Cooking and first preservation**
10. **Hide, fat, bone, and sinew processing**
11. **Fiber, cordage, and basketry**
12. **Clay and pottery**
13. **Plant tending and seed systems**
14. **Sanitation, hygiene, and health-protective routines**
15. **Storage and stock management**

---

# 6. Process quality axes

To avoid simplistic binary outputs, many processes should produce quality grades.

## 6.1 Common quality axes
- **cleanliness**
- **dryness**
- **structural integrity**
- **sharpness**
- **potability**
- **edibility**
- **softness / flexibility**
- **durability**
- **capacity**
- **safety confidence**
- **seed viability**
- **storage stability**

## 6.2 Common causes of quality loss
- wrong moisture level
- insufficient cleaning
- excessive contamination
- rushing setup
- poor tool edge
- fatigue
- bad weather
- excessive heat
- insufficient heat
- poor storage
- overhandling
- repeated wet/dry cycles
- insect/pest access

---

# 7. Era 0–3 early process catalog

Below is the recommended early-game process library.  
This is written in design-bible form rather than code syntax, but it is structured so it can later become authored process data.

---

## FAMILY A — SCOUTING AND SITE SELECTION

### P-001 Scout for initial camp site

**Summary**  
Walk the nearby area and assess whether it can support immediate survival and short-term camp growth.

**Why it matters**  
A bad site silently worsens almost every future process.

**Likely inputs**  
- none beyond body energy and time

**Preferred conditions**
- daylight
- enough stamina for some walking and return

**Assessment targets**
- fresh water access
- deadwood availability
- stone availability
- wind exposure
- drainage
- slope
- nearby edible plant patches
- signs of animal traffic
- signs of predator denning or swamp-like disease zones
- open enough area for future camp zones

**Outputs**
- candidate camp site
- local map familiarity
- hazard awareness
- discovered resource nodes

**Failure / risk**
- overwalking while dehydrated
- getting caught away from shelter late
- choosing a site too close to flood channels, insect-heavy wet ground, or predator pathways

**Skill / knowledge**
- observation
- risk assessment
- local terrain familiarity

**Notes**
The player should see this as one of the earliest strategic tasks, not optional flavor.

---

### P-002 Mark clean and dirty camp zones

**Summary**  
Establish rough spatial rules for where water handling, sleeping, butchering, hide work, refuse, and waste belong.

**Why it matters**  
This is one of the first true “institution” processes.  
Even one person benefits from not fouling their own camp.

**Inputs**
- chosen camp area
- a little labor and thought
- perhaps stones, sticks, or visual markers

**Outputs**
- designated water-handling area
- hearth area
- sleep area
- hide/butchery area
- refuse zone
- latrine direction or future zone

**Follow-up effects**
- lower contamination risk
- easier task routing
- lower pest attraction to living/sleeping areas
- better camp readability in UI

**Failure / risk**
- too little separation
- placing dirty zones downhill or too close to water

**Knowledge**
- basic intuition
- improves through repeated outbreaks / near-misses / success

---

## FAMILY B — CAMP LAYOUT AND STRUCTURE WORK

### P-003 Gather bedding material

**Summary**  
Collect dry plant matter, leafy litter, boughs, grasses, reeds, or soft brush to create insulation between the body and the ground.

**Why it matters**  
Ground contact steals heat, causes dampness, worsens sleep quality, and increases fatigue penalties.

**Inputs**
- dry grasses, leaves, boughs, reeds, bark strips, or similar local materials

**Tools**
- hands
- possibly cutting flake later

**Outputs**
- loose bedding material
- sleeping mat components
- some shelter stuffing material

**Failure / risk**
- using wet or moldy material
- collecting bug-heavy litter
- collecting too little for real insulation

---

### P-004 Build emergency debris bed

**Summary**  
Arrange bedding material into a raised or at least insulated sleeping surface.

**Outputs**
- crude bed
- warmer sleep
- less wetness transfer from ground
- morale gain relative to bare ground sleeping

**Quality axes**
- thickness
- dryness
- pest exposure
- shelter coverage

**Failure / risk**
- compresses quickly
- gets wet in rain
- attracts insects if dirty food scraps enter the bed area

---

### P-005 Build emergency lean-to / windbreak

**Summary**  
Create the first survival shelter from branches, saplings, bark, brush, reeds, or other available plant material.

**Why it matters**  
This is not a house. It is the first effort to reduce wind, rain exposure, and nighttime heat loss.

**Inputs**
- poles / long branches
- brush or boughs
- bark sheets or grass bundles where available
- lashings if any exist
- stones or stakes to secure materials

**Tools**
- mostly hands early
- later cordage, stone edge, digging stick

**Outputs**
- emergency shelter
- reduced wind exposure
- a focal point for camp layout

**Quality axes**
- water shedding
- wind blocking
- stability
- sleeping capacity
- repairability

**Failure / risk**
- collapse in wind
- poor drainage causing interior wetness
- overinvestment before water and fire are stabilized

---

### P-006 Improve shelter drainage and runoff

**Summary**  
Clear water paths around the shelter, scrape shallow runoff guides, and raise sleeping material.

**Why it matters**  
Water entering camp ruins bedding, extinguishes fire-making materials, and raises illness pressure.

**Inputs**
- shelter site
- digging stick / hands / stones

**Outputs**
- drier shelter area
- reduced bedding wetness
- reduced mud in high-traffic zones

**Risks**
- directing runoff into the hearth or storage zone
- overdigging in fragile soil

---

### P-007 Build simple fire ring / hearth base

**Summary**  
Prepare a safe fire location using bare earth, mineral soil, or stones.

**Why it matters**  
A stable hearth improves safety, repeatability, cooking, warmth, and later preservation.

**Inputs**
- selected hearth location
- cleared ground
- stones where available

**Outputs**
- fire-ready area
- reduced accidental spread
- clearer fuel staging area

**Risks**
- too close to shelter
- under branches / roots
- too exposed to wind

---

### P-008 Build crude drying rack

**Summary**  
Create a raised structure for airing, drying, or keeping food and materials off the ground.

**Inputs**
- sticks / poles
- lashings or wedged joinery
- some site clearance

**Outputs**
- drying surface
- elevated staging platform
- reduced pest access compared with ground placement

**Quality axes**
- airflow
- stability
- height
- weather exposure

---

### P-009 Build crude elevated cache

**Summary**  
Create a basic storage point that keeps some goods off the ground and somewhat less accessible to small pests and moisture.

**Outputs**
- basic protected storage
- staged food or tool point
- first meaningful separation between “carried goods” and “camp inventory”

**Risks**
- still vulnerable to determined animals
- weather leakage
- spoilage if damp goods are stored there

---

## FAMILY C — WATER

### P-010 Collect untreated water

**Summary**  
Fetch water from a source into a vessel or improvised container.

**Why it matters**  
Water is one of the first hard bottlenecks.  
But “found water” is not the same as “safe water.”

**Inputs**
- water source
- container or absorbent workaround
- carrying labor

**Outputs**
- raw untreated water
- source familiarity
- route familiarity

**Quality axes**
- source cleanliness
- visible sediment load
- transport contamination risk

**Failure / risk**
- carrying too little
- recontaminating water with dirty vessel/hands
- taking water from stagnant or fouled edge zones when better collection points exist nearby

---

### P-011 Settle cloudy water

**Summary**  
Let sediment-heavy water stand so larger particles fall out before treatment or use.

**Why it matters**  
Settling does not make water safe by itself, but it improves later clarification/treatment and reduces grit.

**Inputs**
- raw cloudy water
- vessel
- time
- place where vessel will not be kicked or fouled

**Outputs**
- clearer top water
- sediment-rich bottom fraction

**Failure / risk**
- disturbing the vessel before decanting
- assuming settled water is automatically safe
- storing it uncovered in a dirty area

---

### P-012 Coarse-filter water

**Summary**  
Strain or filter water through cloth, plant-fiber mat, or other coarse medium to remove visible debris before boiling or other treatment.

**Why it matters**  
Coarse filtering helps with visible dirt and makes subsequent treatment more effective, but it is not enough by itself for pathogen safety.

**Inputs**
- settled or untreated water
- filtering cloth / fine basket lining / plant-fiber pad
- receiving vessel

**Outputs**
- visually cleaner water
- fouled filter material that may need washing/drying

**Risks**
- false confidence
- reusing filthy filter material
- using contaminated receiving vessel

---

### P-013 Boil water

**Summary**  
Bring water to a boil to reduce disease risk.

**Why it matters**  
This is one of the most important early transformation processes in the entire game.

**Inputs**
- water needing treatment
- vessel or heating method
- active fire and fuel
- time

**Outputs**
- boiled safer water
- some fuel ash
- hot vessel

**Important realism notes**
- visibly cloudy water should ideally be settled and/or filtered first
- boiling does not fix toxic chemical contamination
- safe result still depends on later storage

**Quality axes**
- degree of pre-cleaning
- whether a real boil was reached
- whether treated water was recontaminated during cooling/storage

**Risks**
- spills / burns
- fuel use
- contaminated storage container
- unsafe source water if the problem is chemical rather than biological

---

### P-014 Cool and store potable water

**Summary**  
Move treated water into clean covered storage.

**Why it matters**  
This is the step that turns treatment into reliable supply.

**Inputs**
- boiled or otherwise treated water
- clean container with a cover
- clean handling

**Outputs**
- potable stored water
- drinking reserve
- work reserve for cooking and hygiene

**Quality axes**
- container cleanliness
- lid/cover quality
- storage location cleanliness
- handling contamination

**Risks**
- open vessel left near dirty work
- shared dipping with dirty hands
- mixing potable and non-potable stores

---

### P-015 Carry non-potable utility water

**Summary**  
Fetch water intended for washing, clay preparation, cooling, cleaning bloody work areas, or other non-drinking uses.

**Why it matters**  
Non-potable utility water allows the colony to protect cleaner water reserves.

**Outputs**
- utility water reserve
- lower pressure on potable stock

**Notes**
As the camp grows, separating potable and utility water is a major realism and quality improvement.

---

## FAMILY D — FIRE AND FUEL

### P-016 Gather tinder

**Summary**  
Collect and protect the finest, driest, easiest-to-ignite materials.

**Typical materials**
- dry grass
- inner bark shreds
- seed fluff
- dry plant fiber
- scraped bark curls
- other locally available fine dry materials

**Outputs**
- tinder bundle
- fire-start reserve

**Risks**
- tinder getting damp
- using moldy or green material
- storing tinder in exposed conditions

---

### P-017 Gather and sort kindling

**Summary**  
Collect and sort small dry fuels for initial fire build-up.

**Outputs**
- sorted fuel by size
- faster fire-start success
- lower frustration and lower wasted ignition effort

**Quality axes**
- dryness
- size gradation
- resin/smoke profile
- ease of ignition

---

### P-018 Gather fuelwood

**Summary**  
Collect larger burning material for sustained heat.

**Why it matters**  
A camp with fire-start material but no sustained fuel still fails at cooking, boiling, warmth, and preservation.

**Outputs**
- fuelwood stacks
- some long-term security
- greater nighttime survival margin

**Risks**
- excessive hauling fatigue
- overharvesting near camp causing later travel inflation
- bringing wet wood to the hearth and losing labor to drying

---

### P-019 Dry fuel near hearth

**Summary**  
Use low heat and sheltered placement to dry damp or borderline fuel.

**Why it matters**  
Not all collected wood is ready to burn well.
This process turns mediocre fuel into reliable fuel.

**Inputs**
- damp small fuel / medium fuel
- existing hearth warmth
- rack / dry zone near fire

**Outputs**
- drier fuel
- improved fire performance later

**Risks**
- scorching or igniting stacked fuel
- cluttering the hearth area
- smoke and soot contamination

---

### P-020 Ignite fire

**Summary**  
Turn tinder, kindling, and oxygen management into an actual working fire.

**Inputs**
- ignition method
- tinder bundle
- size-graded fuel
- wind management
- reasonably dry conditions

**Outputs**
- active fire
- light, heat, and later process unlocks

**Failure / risk**
- poor airflow
- too-large fuel too early
- damp tinder
- fatigue causing repeated failed attempts
- weather exposure

**Skill / knowledge**
- firemaking
- attention control
- dryness judgment

---

### P-021 Maintain hearth fire

**Summary**  
Keep a fire in a useful state for warmth, cooking, boiling, smoking, or ember preservation.

**Why it matters**  
Fire quality is not binary. Different tasks need different fire behavior.

**Useful fire states**
- ignition flame
- cooking bed of coals
- boil-ready hot fire
- long-sustain warmth fire
- low smoky fire
- ember-preservation state

**Outputs**
- steady useful heat
- safer workflow than repeatedly restarting fires

**Risks**
- fuel waste
- sparks to shelter
- smoke burden on sleeping zone
- burnout at the wrong time of day

---

### P-022 Preserve ember / relight readiness

**Summary**  
Maintain coals or ember-bearing material so the next fire is easier to start.

**Why it matters**  
In realism terms, preserving fire can be easier than fully recreating it repeatedly.

**Outputs**
- ember source
- reduced next-fire effort
- lower ignition-material pressure

**Risks**
- ember loss from neglect
- accidental fire spread
- smoky indoor shelter burden if done badly

---

## FAMILY E — PRIMITIVE TOOLS AND IMPLEMENTS

### P-023 Select workable stone

**Summary**  
Find stone suited for pounding, grinding, or flaking.

**Outputs**
- hammerstone candidates
- core stone
- abrasive stone
- waste rejects

**Quality axes**
- fracture behavior
- hardness
- edge potential
- hand comfort

**Risks**
- wasted hauling of poor stone
- hand injury from poor testing

---

### P-024 Strike stone flake / make crude cutting edge

**Summary**  
Use impact to detach a sharp flake from a suitable stone core.

**Why it matters**  
A cutting edge sharply improves nearly every early process:
- cutting plant fiber
- skinning
- scraping
- trimming shelter materials
- shaping wooden tools
- food preparation

**Inputs**
- knappable stone core
- hammerstone
- stable striking posture

**Outputs**
- sharp flake
- smaller sharp fragments
- worn core
- stone waste

**Risks**
- hand cuts
- eye injury
- poor-angle strikes wasting stone

---

### P-025 Shape digging stick

**Summary**  
Produce a sharpened, hardened, or simply improved digging stick for roots, shallow pits, edging, and patch clearing.

**Inputs**
- stout straight branch
- cutting edge / abrasion
- optional fire hardening

**Outputs**
- digging stick
- improved access to roots, clay, pits, drainage, latrine work

---

### P-026 Shape simple wooden spear / pointed tool

**Summary**  
Sharpen a pole or branch into a basic stabbing, probing, or hunting implement.

**Outputs**
- crude spear
- probing staff
- defensive tool
- fire-hardened point where applicable

**Failure / risk**
- weak point
- cracking from too much heat
- poor straightness

---

### P-027 Make carrying sling / improvised bundle wrap

**Summary**  
Use bark, cloth salvage, hide strips, or fiber to create a carry aid.

**Why it matters**  
Carrying efficiency is one of the first productivity multipliers.

**Outputs**
- simple carry bundle
- lower hand occupancy
- larger haul size for light goods

---

## FAMILY F — HAULING, CARRYING, AND STAGING

### P-028 Carry loose resources by hand

**Summary**  
Transport resources without a true container.

**Use cases**
- sticks
- stones
- a few roots
- one carcass
- a small armload of brush

**Why it matters**
This is the baseline that later carrying tech improves upon.

**Risks**
- low efficiency
- repeated travel
- dropping or contaminating loads
- fatigue from awkward shape rather than pure mass

---

### P-029 Bundle and carry long goods

**Summary**  
Tie or grip long branches, reeds, or poles for more efficient movement.

**Outputs**
- improved haul efficiency for structural material
- reduced repeated trips

**Risks**
- overlong loads slowing route movement
- tangling in brush or doorway areas
- arm fatigue

---

### P-030 Stage materials at a work zone

**Summary**  
Move required goods close to where the next process will happen.

**Why it matters**  
This is a major realism upgrade even though it sounds mundane.

**Examples**
- stage fuel by the hearth
- stage clay near shaping area
- stage wet hides near scraping area
- stage reeds by weaving zone
- stage seed near sorting/storage area

**Outputs**
- faster follow-up work
- fewer interruptions
- better workflow
- easier player understanding of camp state

---

## FAMILY G — FOOD ACQUISITION

### P-031 Gather wild edible plants

**Summary**  
Harvest leaves, shoots, berries, nuts, roots, seeds, mushrooms where valid knowledge exists, and other locally edible plant foods.

**Why it matters**  
This is often the safest very-early calorie path compared with ambitious hunting.

**Inputs**
- plant knowledge
- carrying capacity
- time
- route

**Outputs**
- mixed gathered plant food
- some inedible or low-value plant matter
- plant-location familiarity

**Risks**
- misidentification
- overharvesting local patch
- collecting wet/spoiling material and leaving it in a hot bundle
- wasting time on low-calorie gather routes

**Knowledge**
This should be heavily knowledge-sensitive.
A modern player may know “berries exist,” but the NPC should become more reliable through repeated correct identification and observation.

---

### P-032 Gather eggs, shellfish, insects, or other opportunistic small foods

**Summary**  
Collect easy opportunistic animal calories where biome and season allow.

**Why it matters**  
These are not glamorous, but they are realistic early supplements.

**Outputs**
- small protein/fat gain
- low tool requirement food
- fragile perishable items

**Risks**
- contamination
- seasonal scarcity
- disturbing nests or hazardous areas

---

### P-033 Patrol for animal sign

**Summary**  
Look for tracks, droppings, trails, feeding marks, bedding, and water access patterns.

**Why it matters**  
This turns random hunting into informed hunting.

**Outputs**
- animal sign knowledge
- trap placement candidates
- safer route decisions
- higher future hunting success expectation

---

### P-034 Set simple trap / snare / deadfall (where applicable)

**Summary**  
Create a passive capture chance for small game.

**Inputs**
- cordage / spring material / sticks / bait depending design
- local animal sign
- setup labor

**Outputs**
- active trap site
- future trap-check task
- occasional captured animal
- occasional sprung-empty trap

**Risks**
- trap damage
- non-target capture depending realism level
- trap site forgotten
- stolen/scavenged catch
- legal/ethical simulation choices later if you want such systems

---

### P-035 Check trap line

**Summary**  
Inspect active trap sites and harvest, reset, or retire them.

**Outputs**
- captured animal or failure outcome
- route familiarity
- reduced spoiled carcass loss compared with unchecked traps

**Risks**
- animal already scavenged
- trapped animal struggling and injuring itself / damaging quality
- wasted travel if trap density is poor

---

### P-036 Hunt / dispatch small game directly

**Summary**  
Use a club, spear, thrown object, or close-range tool to catch small animals.

**Why it matters**  
Direct hunting can produce faster food than waiting on trap lines, but usually at higher effort and higher failure.

**Outputs**
- small carcass
- skill practice
- noise / disturbance

**Risks**
- injury
- low success
- energy loss greater than return if done badly

---

## FAMILY H — CARCASS HANDLING AND EDIBLE PROCESSING

### P-037 Recover and transport carcass

**Summary**  
Move a killed or trapped animal from field to camp or to a field-dressing point.

**Why it matters**  
Food is not secured until it is moved, processed, and protected.

**Outputs**
- carcass at work site
- blood trail or scent burden if realism includes predators/scavengers

**Risks**
- contamination from dragging through dirt
- delayed cooling
- exhaustion if over-carried
- attracting scavengers

---

### P-038 Field dress carcass

**Summary**  
Open the body cavity, remove viscera where appropriate, and prepare the carcass for cooling and further butchering.

**Why it matters**  
This is one of the key real-world quality and safety gates in animal food use.

**Inputs**
- carcass
- cutting tool
- reasonably clean work approach
- water if available for limited rinsing / cleaning

**Outputs**
- dressed carcass
- organs / offal
- blood and waste stream
- hide still attached or removed depending next step

**Important realism notes**
- prompt gut removal can help cooling
- puncturing stomach/intestines/bladder raises contamination risk
- the carcass should be kept clean, dry, and cooled as soon as possible

**Risks**
- gut puncture contamination
- dirt/hair contamination
- heat retention if delayed
- insects if left exposed

---

### P-039 Skin carcass

**Summary**  
Separate hide/fur from carcass while minimizing dirt and meat damage.

**Why it matters**  
This process serves both food quality and hide quality.

**Outputs**
- skinned carcass
- raw hide / skin
- fat and connective tissue remnants

**Quality axes**
- how much meat/fat left on hide
- how much hair/dirt on meat
- hide damage
- speed before rot

---

### P-040 Portion carcass / strip useful meat

**Summary**  
Break animal down into manageable cuts or chunks for immediate cooking, drying, or storage.

**Outputs**
- cooking cuts
- drying strips
- stew meat
- marrow bones
- scrap trim
- offal stream

**Risks**
- leaving edible value behind due to poor skill
- contaminating cuts with dirty ground or tools
- inefficient cutting increasing drying difficulty later

---

### P-041 Cool carcass or meat

**Summary**  
Use shade, airflow, hanging, spacing, and timing to reduce retained heat in animal products.

**Why it matters**  
Warm meat spoils faster.
Cooling should begin quickly after harvest and dressing.

**Outputs**
- cooler meat
- safer preservation window
- better quality

**Risks**
- sun exposure
- stacking warm pieces together
- insects
- freezing too early in certain conditions for quality-sensitive meat

---

### P-042 Extract marrow / recover edible fat scraps

**Summary**  
Break bones and scrape attached fat or tissue for high-value calories.

**Why it matters**  
In early survival, fat and marrow can be disproportionately valuable.

**Inputs**
- marrow bones
- hammerstone / pounder
- collection surface or vessel

**Outputs**
- marrow
- bone fragments
- grease-smear waste
- possible future bone-tool stock if fragments are suitable

---

### P-043 Separate edible organs (optional by knowledge/settings)

**Summary**  
Recover organs that are safe and desirable to eat where knowledge, freshness, and contamination state allow.

**Outputs**
- organ meats
- spoilage-sensitive high-value food
- contamination risk if handled badly

---

## FAMILY I — COOKING AND FIRST PRESERVATION

### P-044 Roast or boil immediate meal

**Summary**  
Prepare a same-day meal from gathered or hunted food.

**Why it matters**  
Cooking raises safety, digestibility, morale, and sometimes calorie usability.

**Inputs**
- edible raw food
- fire
- vessel or roasting method
- potable or utility water depending recipe and cleanliness

**Outputs**
- cooked meal
- scraps
- dirty vessel / greasy surface
- ash and soot burden

**Risks**
- undercooking animal foods
- overcooking and wasting moisture/fat
- contaminating finished meal with dirty hands or surfaces

---

### P-045 Prepare thin stew / broth

**Summary**  
Use water, small meat scraps, roots, greens, and bone value to produce a more efficient meal from mixed low-volume inputs.

**Why it matters**  
Stews stretch scarce food and integrate diverse ingredients.

**Outputs**
- cooked liquid meal
- softened ingredients
- vessel burden
- some broth reserve if stored short-term

---

### P-046 Slice meat for drying

**Summary**  
Cut meat into appropriately sized pieces to improve airflow and reduce drying time.

**Why it matters**  
Poorly sized pieces spoil before they dry.

**Outputs**
- drying strips
- trim
- improved preservation readiness

**Quality axes**
- strip thickness consistency
- cleanliness
- lean/fat balance

---

### P-047 Air-dry or sun-dry food

**Summary**  
Expose suitable food to airflow and controlled drying conditions.

**Use cases**
- sliced meat in good weather
- fish in favorable conditions
- herbs
- seeds
- some plant foods

**Why it matters**  
Drying is one of the earliest and most fundamental preservation pathways.

**Inputs**
- prepared food
- rack / line / clean surface
- favorable weather
- pest protection attention

**Outputs**
- partially dried or dried food
- moisture loss
- lighter transport mass

**Risks**
- poor weather
- insect contamination
- mold if drying too slowly
- animal theft
- dirty surface contact

---

### P-048 Smoke food

**Summary**  
Use smoke plus heat control and airflow management to aid preservation and flavor, usually as part of a broader drying/cooking pathway rather than as magic by itself.

**Why it matters**  
Smoking helps, but should not be treated as instant indefinite shelf-stability.

**Inputs**
- food prepared for smoking
- smoking frame / rack
- fire
- appropriate smoke-producing material
- repeated tending

**Outputs**
- smoke-dried or smoke-flavored preserved food
- smoke exposure to work area
- fuel consumption

**Quality axes**
- heat level
- smoke density
- drying completeness
- contamination control

**Risks**
- too much heat cooks instead of preserves
- too little drying leaves spoilage risk
- creosote-heavy / unpleasant smoke
- pest or mold issues if storage is poor afterward

---

### P-049 Dry herbs / greens / seed heads

**Summary**  
Dry small plant foods or useful plants for later use.

**Outputs**
- dry herb stock
- dry seed heads ready for threshing or later cleaning
- reduced bulk moisture

**Risks**
- shattering loss
- mixing clean and dirty plant matter
- mold from poor airflow

---

### P-050 Render fat (early small-batch)

**Summary**  
Slowly heat usable fat scraps to recover liquid fat/grease.

**Why it matters**  
Fat is a calorie source, a cooking medium, and a later craft input.

**Inputs**
- fat scraps
- fire
- vessel or controlled heating surface

**Outputs**
- rendered fat / grease
- cracklings or spent solids
- greasy vessel
- smell that may attract animals

**Risks**
- scorching
- rancidity later if badly stored
- waste if mixed with too much dirt/hair

---

## FAMILY J — HIDE, FAT, BONE, AND SINEW PROCESSING

### P-051 Flesh raw hide

**Summary**  
Remove remaining fat, flesh, and tissue from the inner side of a hide.

**Why it matters**  
This is one of the key steps preventing rot and making later softening work.

**Inputs**
- fresh hide
- scraping tool
- beam/log/stable support if available

**Outputs**
- cleaner hide
- greasy scraps
- more usable next-stage hide

**Risks**
- cutting through hide
- delaying too long and letting rot begin
- leaving tissue that later spoils

---

### P-052 Stretch and dry raw hide

**Summary**  
Open, spread, and dry a hide to prevent rapid decay and create a storable intermediate state.

**Why it matters**  
A raw hide is highly perishable. Drying stabilizes it but does not by itself produce soft wearable leather.

**Outputs**
- dried raw hide
- reduced immediate rot risk
- stiff hide that still needs more work for comfortable use

**Risks**
- mold if drying too slowly
- insect damage
- hard folds / uneven drying
- contamination from ground contact

---

### P-053 Rehydrate / soften hide for further working

**Summary**  
Bring a dried hide back to a workable state for scraping, dressing, or softening.

**Outputs**
- workable hide
- higher labor demand next phase

**Risks**
- over-wetting and promoting rot
- leaving it wet too long
- insufficient reworking leading to stiff final product

---

### P-054 Apply brain/fat softening dressing

**Summary**  
Work oils/emulsified brain or fat dressing into a cleaned hide to improve softness and flexibility.

**Why it matters**  
This is one of the realistic pathways from raw skin toward soft usable buckskin-like material.

**Inputs**
- clean workable hide
- brain/fat dressing or comparable softening agent
- hand work / stretching labor

**Outputs**
- dressed hide ready for stretching and drying
- greasy tools/surfaces

**Risks**
- uneven penetration
- insufficient working
- spoilage if left too long before next step

---

### P-055 Stretch and work hide while drying

**Summary**  
Continuously pull, stretch, and work the dressed hide as it dries so it becomes supple instead of hard.

**Why it matters**  
This is labor-intensive and one of the best examples of realism through process, not through exotic materials.

**Outputs**
- softened hide
- fatigue
- skill gain in hide work

**Risks**
- letting it dry motionless into stiffness
- tearing weak spots
- underworking thick areas

---

### P-056 Smoke softened hide

**Summary**  
Expose a softened hide to cool smoke for durability and water-resistance improvements.

**Why it matters**  
Smoking is an important finishing step in some traditional hide-working systems.

**Inputs**
- softened hide
- smoke source
- low heat / high smoke environment
- support frame or smoke tent arrangement

**Outputs**
- smoked usable hide
- improved resistance to re-hardening after wetting
- finished craft material for clothing, bags, lashings, wrappings

**Risks**
- overheating
- scorching
- patchy smoke exposure
- excess labor if setup is poor

---

### P-057 Clean and save sinew

**Summary**  
Remove strong connective tissue, dry it, and reserve it for future lashing/thread use.

**Outputs**
- raw sinew
- dried sinew
- later split fiber for fine binding

**Risks**
- rot if left wet
- contamination from dirty butchering area
- losing small pieces

---

### P-058 Clean and save bone for tools

**Summary**  
Select and clean useful bone sections for awls, needles, scrapers, pins, fish-gorge points, or other small implements.

**Outputs**
- bone blanks
- future craft stock
- fewer wasted carcass parts

---

## FAMILY K — FIBER, CORDAGE, AND BASKETRY

### P-059 Harvest flexible fiber plants

**Summary**  
Collect bark strips, bast fiber sources, reeds, grasses, rushes, vines, roots, or leaf fibers depending local ecology.

**Why it matters**  
Fiber is one of the earliest infrastructure materials in the game, not a side craft.

**Outputs**
- green fiber plant stock
- reed bundles
- bark strips
- vine lengths
- raw basketry material

**Risks**
- wrong harvest season
- brittle, immature, or over-dry material
- hauling too much unprocessed bulk

---

### P-060 Strip bast or bark fiber

**Summary**  
Peel, split, or separate useful fibrous layers from plant material.

**Outputs**
- bark strips
- bast strips
- coarse fiber bundles
- plant waste

**Quality axes**
- fiber length
- cleanliness
- evenness
- retained flexibility

---

### P-061 Dry / condition fiber material

**Summary**  
Partially dry, soften, or condition harvested fiber so it becomes workable without rotting.

**Why it matters**  
Some material is best worked fresh; some is easier after drying and re-dampening. The game should allow material-specific behavior later, but the early design should still recognize conditioning as its own stage.

**Outputs**
- workable fiber stock
- lower mold risk
- more stable storage

---

### P-062 Twist crude cordage

**Summary**  
Convert strips or fibers into usable two-ply or similar twisted cord.

**Why it matters**  
Cordage is a major productivity multiplier.
It improves:
- carrying
- shelter binding
- traps
- tool hafting
- drying racks
- clothing ties
- containers
- later weaving

**Inputs**
- plant fibers, bark strips, sinew, or hide strips
- hand skill
- time

**Outputs**
- rough cordage
- twine
- lashings
- short offcuts

**Risks**
- weak twist
- inconsistent thickness
- poor storage causing rot or stiffness

---

### P-063 Braid or reinforce stronger lashing

**Summary**  
Make a stronger, thicker, or more reliable binding for structural tasks.

**Outputs**
- structural lashing
- harness precursors later
- stronger tool bindings

---

### P-064 Weave simple basket or carrying container

**Summary**  
Interweave flexible fibers into a container suitable for carrying, sorting, drying, or storing goods.

**Why it matters**  
Basketry is one of the first major logistics revolutions of the camp.

**Inputs**
- flexible vegetable fibers, reeds, twigs, rushes, grasses, etc.
- hand labor
- some material conditioning
- optional cordage

**Outputs**
- crude basket
- tray
- fiber mat
- sorting container

**Quality axes**
- capacity
- rigidity
- flexibility
- leakiness
- durability
- repairability

**Risks**
- brittle material snapping
- poor weave spacing
- over-dry material
- basket unsuitable for wet transport unless lined

---

### P-065 Make fiber mat / sleeping mat / drying mat

**Summary**  
Produce a flat woven or tied surface for bedding, drying, kneeling, or sorting.

**Outputs**
- cleaner work surface
- better sleeping insulation
- improved drying hygiene
- lower direct ground contact contamination

---

## FAMILY L — CLAY AND POTTERY

### P-066 Locate workable clay

**Summary**  
Find clay-rich earth suitable for shaping and firing.

**Why it matters**  
This is a classic discovery-knowledge process:
“we found a ground material that can become a vessel.”

**Outputs**
- clay source discovery
- route to clay patch
- preliminary clay stock

**Risks**
- mistaking poor material for good pottery clay
- underestimating hauling burden

---

### P-067 Dig and haul clay

**Summary**  
Excavate clay and move it to camp or to a dedicated work area.

**Why it matters**  
Clay is heavy.  
Its logistical burden should be obvious in play.

**Outputs**
- raw wet clay
- haul fatigue
- disturbed clay pit

**Risks**
- overharvesting too much at once
- hauling wet weight without a real plan
- clay contamination with roots/stones if collected poorly

---

### P-068 Dry, clean, and prepare clay

**Summary**  
Dry enough clay to break it down, remove debris, and prepare it for controlled rehydration and tempering.

**Why it matters**  
This is what separates “mud” from “craft material.”

**Inputs**
- raw clay
- sorting surface
- drying area
- labor for crushing / cleaning

**Outputs**
- cleaner clay
- removed stones/roots
- stored dry clay base

**Risks**
- rushing and leaving too much debris
- contamination from dirty surfaces
- drying in a place where rain re-wets the lot

---

### P-069 Temper clay

**Summary**  
Add material such as sand, crushed old pottery, shell, or other suitable temper to reduce shrinkage/cracking and improve working behavior.

**Why it matters**  
This is a major procedural knowledge gate.
A society that merely has clay is not yet a pottery-producing society.

**Outputs**
- tempered clay body
- improved vessel reliability
- more consistent shaping

**Risks**
- wrong temper amount
- coarse inclusions damaging vessel walls
- poor mixing

---

### P-070 Shape simple vessel by hand / coil

**Summary**  
Form a pot, bowl, lid, cup, or simple storage vessel by pinching or coil-building.

**Outputs**
- wet vessel (“green” form)
- vessel variants sized for boiling, carrying, seed storage, or dry storage

**Quality axes**
- wall thickness consistency
- shape stability
- capacity
- rim strength
- handle/lug strength if used

**Risks**
- collapsing walls
- air pockets
- too-thick or too-thin sections
- overhandling

---

### P-071 Dry green vessel slowly

**Summary**  
Let a formed clay vessel dry before firing.

**Why it matters**  
This is one of the most important patience gates in the pottery chain.

**Outputs**
- dry unfired vessel ready for firing
- brittle intermediate state

**Risks**
- drying too fast and cracking
- rough handling when bone dry
- re-wetting from rain or night damp

---

### P-072 Pit-fire / fire simple vessel

**Summary**  
Fire a dried vessel using a pit or simple firing setup.

**Why it matters**  
This creates one of the first transformational technologies of settled life: durable containers.

**Inputs**
- dry green vessel
- fuel
- firing pit or controlled firing arrangement
- attention and timing

**Outputs**
- fired earthenware vessel
- cracked failures
- partially fired failures
- useful shards for later grog/temper

**Quality axes**
- full dryness before firing
- firing completeness
- thermal shock survival
- porosity and strength

**Risks**
- explosion from residual moisture
- cracking from uneven heating/cooling
- large batch loss from a bad firing
- fuel waste

---

### P-073 Test vessel and sort pottery outcomes

**Summary**  
Check fired vessels for cracks, leakage, thermal weakness, and intended use.

**Why it matters**  
Not every pot should be considered equal.
Some vessels may be fine for dry storage but poor for water or direct heating.

**Outputs**
- cooking-grade pot
- dry-storage-grade pot
- cracked shard salvage
- grog source from broken ware

---

## FAMILY M — PLANT TENDING AND SEED SYSTEMS

### P-074 Observe useful plant patch over time

**Summary**  
Watch where useful species grow, when they mature, and how they respond to disturbance.

**Why it matters**  
The earliest horticulture begins with observation, not instant agriculture.

**Outputs**
- seasonal plant knowledge
- patch value rating
- harvest timing insight
- candidate tending zones

---

### P-075 Clear and protect tiny garden patch

**Summary**  
Remove competing plants, stones, and obstructions from a small patch near camp.

**Why it matters**  
This is one of the first real transitions from gathering toward management.

**Inputs**
- patch location
- digging stick / hands / hoe-like tool later
- labor
- often nearby water

**Outputs**
- tended plot
- transplant site
- lower weed competition for chosen plants

**Risks**
- overclearing and drying soil
- too much labor on too-large patch
- animal browsing if left unprotected

---

### P-076 Transplant useful plants or propagate cuttings where applicable

**Summary**  
Move useful plants closer to camp or into protected plots.

**Outputs**
- higher control
- easier harvesting
- better observation
- some transplant loss

---

### P-077 Harvest seed for future planting

**Summary**  
Select mature seed from healthy useful plants instead of consuming or wasting all of it.

**Why it matters**  
This is one of the most important realism gates in the whole early economy.
The colony must begin sacrificing short-term calories for long-term stability.

**Inputs**
- mature seed-bearing plants
- drying space
- sorting labor
- social discipline not to eat the seed stock

**Outputs**
- planting seed
- food grain/seed if separated
- chaff/straw waste
- plant-selection knowledge

**Risks**
- taking immature seed
- mixing food stock and seed stock
- pest damage
- moisture damage
- using weak or diseased plants as seed source

---

### P-078 Dry and clean seed

**Summary**  
Dry seed thoroughly enough for storage, then clean out excess plant debris.

**Why it matters**  
Moisture is one of the main enemies of safe seed storage.

**Outputs**
- cleaner, drier seed
- chaff byproduct
- improved viability retention

**Risks**
- overdrying in harsh heat for sensitive seeds
- underdrying leading to mold
- losing small seeds during cleaning

---

### P-079 Store seed reserve

**Summary**  
Place seed in protected dry storage with identity and intended use preserved.

**Why it matters**  
The colony should distinguish:
- seed to plant
- grain to eat
- damaged seed / animal feed later
- uncertain seed

**Outputs**
- seed reserve
- longer-term agricultural potential
- stronger seasonal planning

**Risks**
- rodent access
- moisture ingress
- mislabeling / mixing varieties or quality states
- hunger pressure causing emergency consumption

---

### P-080 Tend favored plant patch

**Summary**  
Water lightly where appropriate, weed, protect, loosen soil, and monitor for damage.

**Outputs**
- improved yield chance
- ongoing labor burden
- local plant familiarity
- first repeating horticultural routine

---

## FAMILY N — SANITATION, HYGIENE, AND HEALTH-PROTECTIVE ROUTINES

### P-081 Dig latrine / cathole

**Summary**  
Create a dedicated human-waste disposal point away from drinking water and core camp spaces.

**Why it matters**  
This is one of the most important “boring but civilization-making” tasks in the game.

**Inputs**
- suitable soil
- digging tool
- chosen location
- habit / camp rule

**Outputs**
- latrine function
- lower direct contamination around living/work zones

**Important realism notes**
- waste pits should be kept well away from water sources
- shallow but sufficient burial depth matters
- rocky or sandy ground may complicate the process

**Risks**
- too close to camp
- too close to water
- too shallow
- neglected overfill

---

### P-082 Dispose of carcass waste safely

**Summary**  
Move offal, spoiled food, bloody scraps, and non-usable remains away from the clean camp core.

**Why it matters**  
Animal waste attracts pests, scavengers, smell, and contamination.

**Outputs**
- cleaner work area
- reduced pest pressure
- lower smell burden

**Risks**
- dumping near water
- leaving remains in the hide area or near sleeping area
- creating predator/scavenger attractor too close to camp

---

### P-083 Wash hands / high-contact surfaces with soap-and-water path when available

**Summary**  
Clean hands and key surfaces after dirty work, especially after animal handling, waste handling, and before food handling.

**Why it matters**  
This is one of the most effective low-tech health-protective routines once soap exists, and even before soap, dedicated washing with cleaner water still matters.

**Inputs**
- water
- later soap or ash-assisted washing depending design depth
- clean-ish drying method / air dry

**Outputs**
- reduced contamination carryover
- lower food contamination risk

**Important realism notes**
- soap and water are stronger than sanitizer for visibly dirty hands
- shared dirty wash water should not be treated as equivalent to proper washing
- dirty clothing used as a drying surface is a contamination issue

**Risks**
- symbolic washing with dirty communal basin
- touching dirty surfaces immediately after washing
- scarce potable water pressure if all washing uses drinking-grade water

---

### P-084 Wash vessel / cooking tool

**Summary**  
Clean pots, bowls, stones, knives, and surfaces after use.

**Why it matters**  
Cleanliness affects taste, smell, contamination, and pest attraction.

**Outputs**
- cleaner tools
- lower next-meal contamination risk
- cleaner camp

**Risks**
- washing greasy/bloody items in drinking source edge
- leaving washed vessel where animals can foul it
- low cleaning quality due to haste

---

### P-085 Air bedding and dry clothing / wraps

**Summary**  
Expose bedding and worn goods to sun, airflow, or hearth-adjacent drying.

**Why it matters**  
Wet sleep systems quietly destroy morale, warmth, and health.

**Outputs**
- drier sleep gear
- lower mildew/mustiness
- better sleep quality

**Risks**
- weather shift re-wetting goods
- smoke overexposure if dried too close to hearth
- leaving items out overnight

---

### P-086 Sweep / pick camp debris from clean zone

**Summary**  
Remove scraps, bones, spilled food, wet litter, and clutter from sleeping, cooking, and water-handling areas.

**Outputs**
- cleaner camp
- lower pest attraction
- lower accidental contamination
- morale benefit

---

### P-087 Quarantine spoiled food / suspect water

**Summary**  
Separate doubtful goods from trustworthy stores.

**Why it matters**  
A realism-first game should allow uncertain goods, not only obviously good or obviously ruined goods.

**Outputs**
- suspect stockpile
- lower accidental consumption
- decision point: salvage, discard, animal feed later, or emergency use

---

## FAMILY O — STORAGE AND STOCK MANAGEMENT

### P-088 Sort goods by use and risk

**Summary**  
Separate:
- edible now
- preserve now
- use later
- seed reserve
- craft stock
- dirty scraps
- waste
- repair stock

**Why it matters**  
Sorting is one of the first anti-chaos acts in camp life.

**Outputs**
- clearer stock state
- lower accidental waste
- better task generation

---

### P-089 Store dry goods in elevated cache

**Summary**  
Move seeds, dried foods, cordage, tools, and other dry-sensitive items into more protected storage.

**Outputs**
- lower ground damp exposure
- lower casual pest loss
- stronger reserve logic

**Risks**
- storing damp goods and causing enclosed spoilage
- mixing strongly scented goods with vulnerable goods
- overfilling unstable cache

---

### P-090 Store roots / cool perishables in shaded pit or cool storage

**Summary**  
Use shaded, cool earth-contact storage for certain roots or cool-sensitive foods where appropriate.

**Why it matters**  
This is an important bridge between pure immediate consumption and real seasonal storage.

**Outputs**
- longer keeping time for suitable foods
- reduced sun/warmth loss
- first temperature-sensitive storage practice

**Risks**
- moisture imbalance
- rot from poor ventilation or damaged produce
- pest access
- storing unsuitable goods together

---

### P-091 Rotate food stock

**Summary**  
Use older, riskier, or more perishable food before newer more stable food where sensible.

**Why it matters**  
This is a key institutional behavior, even in a tiny camp.

**Outputs**
- reduced spoilage waste
- less hidden reserve loss
- stronger inventory reliability

**Risks**
- forgetting hidden stores
- eating seed reserve by mistake
- hoarding “good stock” until it goes bad

---

### P-092 Inspect stores for pests, mold, damp, and damage

**Summary**  
Periodically check caches, baskets, pots, racks, and pits for emerging storage problems.

**Outputs**
- early warning
- salvage opportunities
- lower catastrophic reserve loss

**Risks**
- infrequent checking
- inspecting but not acting
- contaminating clean stores during inspection with dirty hands/tools

---

### P-093 Reprocess salvageable goods

**Summary**  
Take goods that are not ideal but not yet lost and convert them into lower-grade use.

**Examples**
- slightly damp fiber re-dried
- half-dry meat returned to smoke/drying
- cracked pot turned into shard stock / temper
- suspect but still usable fat used quickly instead of long storage

**Why it matters**  
Real camps do not live on perfect outputs only.

---

# 8. Process chains by survival stage

This section restates the process catalog as practical progression chains.

## 8.1 Day 1 survival chain
1. Scout for site
2. Mark rough camp area
3. Collect untreated water
4. Gather bedding material
5. Build emergency debris bed
6. Build lean-to / windbreak
7. Gather tinder, kindling, fuelwood
8. Ignite fire
9. Gather immediate calories
10. Cook immediate meal if possible
11. Maintain fire through first night
12. Sleep / recover

## 8.2 First week stabilization chain
1. Improve hearth
2. Boil and store safer water
3. Gather and stage fuel
4. Build crude drying rack
5. Make basic cutting edge and digging stick
6. Gather plant foods more efficiently
7. Hunt or trap small game
8. Field dress and portion carcasses
9. Dry or smoke surplus food
10. Flesh and dry first hides
11. Establish latrine and refuse zone
12. Begin daily cleanliness routines

## 8.3 Permanent camp chain
1. Build better storage and cache points
2. Improve carrying tools and baskets
3. Harvest fiber plants and make cordage
4. Create more reliable racks, ties, bindings
5. Locate clay source
6. Dig, clean, temper, and shape first vessels
7. Fire first pottery
8. Separate potable / utility water
9. Establish seed-saving and patch-tending routines
10. Inspect and rotate stores

## 8.4 Tiny hamlet chain
1. Split labor
2. Stage materials by work zone
3. Increase drying / smoking throughput
4. Maintain multiple shelters and central hearths
5. Expand seed and food storage discipline
6. Add more regular trap checks / plant patch tending
7. Improve hide and fiber specialization
8. Support one or two emerging specialists without collapsing food supply

---

# 9. Recommended skill-to-process mapping

Because you said there is nothing like “too many skills,” the process layer should support narrow and broad skills at once.

## 9.1 Broad early skills
- survival judgment
- campcraft
- water handling
- firemaking
- food gathering
- hunting
- butchery
- cooking
- preservation
- hide work
- fiber work
- basketry
- clay work
- pottery
- gardening / tending
- sanitation
- hauling / load handling

## 9.2 Narrow process-linked skills
- source scouting
- sediment judgment
- boil management
- fuel sorting
- ember keeping
- flake striking
- scraping technique
- strip cutting consistency
- smoke control
- drying judgment
- seed selection
- seed cleaning
- hide stretching
- lashing quality
- vessel wall control
- firing management
- cache organization
- spoilage detection

## 9.3 Why both scales are useful
Broad skills help readable progression.  
Narrow skills help realism and more believable specialization later.

Example:
- an NPC may have good **fiber work**
- but still be poor at **tight structural lashing**
- and excellent at **basket weaving**
- while another NPC is mediocre at weaving but great at **hide softening**

That kind of profile is exactly the sort of believable labor personality your game benefits from.

---

# 10. How these processes should interact with NPC decision-making

This section links the process bible to the NPC and task documents.

## 10.1 Process generation
Processes should create tasks when:
- a need threshold is crossed
- an opportunity appears
- a stock target is missing
- weather creates urgency
- a follow-up from another process is due
- the player places a direct order
- a routine schedule triggers

Examples:
- low potable water -> fetch / boil water tasks
- good weather + surplus meat -> drying tasks rise in importance
- raw hide present -> flesh-hide task appears before rot deadline
- wet bedding -> air bedding task appears
- clay stock + free labor + container shortage -> prepare-clay and shape-vessel tasks appear

## 10.2 Process urgency drivers
Tasks should score differently depending on:
- body needs
- season
- weather
- spoilage timers
- stock deficits
- distance
- required setup already staged or not
- player priority
- skill fit
- knowledge availability
- sanitation pressure

## 10.3 Process interruption logic
Some processes interrupt easily:
- gathering fuel
- scouting
- staging materials

Some interrupt badly:
- vessel shaping at the wrong moment
- hide working during drying phase
- controlled smoking
- active boiling
- butchering halfway through in dirty conditions

This should feed directly into the task evaluation rules.

---

# 11. Recommended first-process authored set for data entry

This is the lean but still realism-rich first authored set I would enter into a database first:

## Absolute must-have
1. Scout for initial camp site
2. Gather bedding material
3. Build emergency debris bed
4. Build emergency lean-to
5. Gather tinder
6. Gather kindling
7. Gather fuelwood
8. Ignite fire
9. Maintain hearth fire
10. Collect untreated water
11. Settle cloudy water
12. Boil water
13. Store potable water
14. Gather wild edible plants
15. Hunt / dispatch small game
16. Recover carcass
17. Field dress carcass
18. Skin carcass
19. Roast / boil meal
20. Slice meat for drying
21. Air-dry food
22. Flesh hide
23. Stretch and dry hide
24. Harvest fiber plants
25. Twist crude cordage
26. Weave simple basket
27. Dig latrine
28. Dispose carcass waste
29. Store dry goods in cache
30. Inspect stores

## Strong next wave
31. Ember preservation
32. Shape digging stick
33. Shape crude spear
34. Render fat
35. Clean and save sinew
36. Clean and save bone
37. Locate clay
38. Dig and haul clay
39. Clean / prepare clay
40. Temper clay
41. Shape vessel
42. Dry green vessel
43. Fire vessel
44. Harvest seed
45. Dry and clean seed
46. Store seed reserve
47. Tend plant patch
48. Reprocess salvageable goods

This gives you a serious early-game process library without prematurely jumping into village-industry systems.

---

# 12. Open design decisions specifically for the process layer

These are the main process-side questions still worth deciding later.

## 12.1 How harsh should contamination be?
Possible spectrum:
- light realism: mostly small penalties
- moderate realism: recurring quality and illness risk
- high realism: sloppy camp layout can become a major failure driver

## 12.2 How detailed should fire states be?
Possible spectrum:
- one generic “fire on/off”
- warmth / cooking / smoke / ember states
- full fuel-size + heat-profile simulation

## 12.3 How granular should preservation be?
Possible spectrum:
- simple dry / smoked / cooked / spoiled
- partial dryness + contamination + storage state
- advanced moisture, temperature, and pest interactions

## 12.4 How explicit should knowledge be?
Possible spectrum:
- hidden probabilities
- visible discovered-process entries
- explicit multi-layer knowledge records per process and sub-step

## 12.5 How much should weather matter?
Possible spectrum:
- mild scheduling modifier
- major constraint for drying, shelter, and fuel
- dominant system requiring strong planning

---

# 13. Short conclusion

The process layer is where your design becomes believable.

Items alone are not enough.  
NPCs alone are not enough.  
Buildings alone are not enough.

What makes the colony feel real is the chain in between:
- work takes place somewhere
- it uses actual inputs
- it creates real outputs and waste
- it can go well or poorly
- it teaches the worker something
- it changes what the colony can do next

In the early game especially, the most important processes are not flashy:
- fetching and treating water
- drying fuel
- maintaining a hearth
- cooling and cleaning meat
- scraping a hide before it rots
- making cordage
- drying food before weather turns
- protecting seed
- separating waste from living space
- checking whether stores are still good

That is exactly where the realism of this project should live.

---

# 14. Research anchors and references used in this version

These were used to keep the early-process logic tied to real-world constraints and practices.

- CDC, *How to Make Water Safe in an Emergency*  
  https://www.cdc.gov/water-emergency/about/index.html

- CDC, *Preventing Drinking Water-Related Illnesses*  
  https://www.cdc.gov/drinking-water/prevention/index.html

- U.S. National Park Service, *Backcountry Camping, Cooking, Water, Sanitation - Denali National Park*  
  https://www.nps.gov/dena/planyourvisit/camp-sanitation.htm

- U.S. National Park Service, *Camping Guidelines & Regulations*  
  https://www.nps.gov/moja/planyourvisit/camping-regs.htm

- FAO, *Appropriate Seed and Grain Storage Systems for Small-scale Farm Operators*  
  https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content

- FAO, *Seeds in Emergencies: a technical handbook*  
  https://www.fao.org/4/i1816e/i1816e00.pdf

- Oregon State University Extension, *A step-by-step guide to saving seeds*  
  https://extension.oregonstate.edu/catalog/em-9663-step-step-guide-saving-seeds

- University of Alaska Fairbanks Cooperative Extension, *Vegetable Storage in Root Cellars*  
  https://www.uaf.edu/ces/publications/database/food/vegetable-storage.php

- Wisconsin Extension, *Safe Handling Practices for Wild Game Meat*  
  https://winnebago.extension.wisc.edu/2022/11/04/safe-handling-practices-for-wild-game-meat/

- Pennsylvania State University Extension, *Proper Field Dressing and Handling of Wild Game and Fish*  
  https://extension.psu.edu/proper-field-dressing-and-handling-of-wild-game-and-fish/

- USDA FSIS, *Jerky and Food Safety*  
  https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/meat-fish/jerky

- USDA NIFA / University of Wyoming, *Making Jerky*  
  https://www.nifa.usda.gov/sites/default/files/resource/Making%20Jerky.pdf

- Northern Arizona University, *Tanning Deer Hides and Small Fur Skins*  
  https://jan.ucc.nau.edu/tct/tanning.pdf

- Britannica, *Basketry*  
  https://www.britannica.com/art/basketry

- Britannica, *Natural fiber*  
  https://www.britannica.com/topic/natural-fiber

- University of New Mexico / Maxwell Museum educational material, *Pottery activity*  
  https://maxwellmuseum.unm.edu/sites/default/files/public/Pottery%20activity.pdf

---

# 15. Recommended next document

The strongest next companion after this is:

**Building & Structure Bible v0.1**

Why:
- the process layer now says what work happens
- the item layer says what matter exists
- the next missing piece is the physical and institutional spaces that host the processes:
  - lean-to
  - hearth
  - drying rack
  - smoke frame
  - cache
  - work surface
  - hide-working area
  - clay work area
  - latrine
  - shelter hut
  - seed store
  - garden patch
  - fenced work yard

Once that is defined, the early camp will feel much more complete.
