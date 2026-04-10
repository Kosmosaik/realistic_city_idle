---
title: "Realistic Idle City — Food Safety & Water Safety Spec"
version: "v0.1"
scope: "Lone survivor -> Primitive Camp -> Permanent Camp -> Tiny Hamlet"
status: "Design specification"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
---

# Purpose

This document defines the **food safety** and **water safety** simulation layer for the early game of the project.

It is meant to sit on top of the existing design stack:
- the original design document's emphasis on water, food, spoilage, sanitation, storage, and survival-first progression
- the item/material bible
- the process bible
- the building/structure bible
- the settlement progression spec
- the knowledge/discovery spec
- the social/recruitment spec
- the allocation/ownership/rationing spec
- the health/injury/care spec
- the environmental hazard spec

This spec answers questions such as:
- what makes water safer or less safe?
- how does water become re-contaminated after treatment?
- what makes food risky, spoilable, or durable?
- which camp layouts and habits reduce diarrheal disease and foodborne illness?
- how should raw food, cooked food, dried food, smoked food, grain, and seed behave?
- when should NPCs refuse unsafe handling and when do they proceed under pressure?
- how do cleanliness, fuel, containers, weather, insects, rodents, and labor discipline affect survival?

The goal is not to simulate microbiology in laboratory detail.
The goal is to simulate **realistic contamination pathways, risk reduction practices, storage rules, and handling discipline** closely enough that food and water safety feel like real survival systems.

---

# Design stance

## Core principle

Food and water do not become safe because the player clicked a recipe.
They become safer only when the settlement does the right things in the right order:
- choose better sources
- keep clean and dirty workflows separated
- remove or reduce contamination
- apply sufficient heat where appropriate
- use suitable containers
- prevent recontamination during handling and storage
- consume high-risk items before they deteriorate
- keep reserves dry, protected, and physically separate from waste, vermin, and dirty tools

## Early-game realism priorities

For the early slice, the most important safety truths are:
1. **source quality matters**
2. **storage quality matters**
3. **cleanliness and separation matter**
4. **heat treatment helps, but not everything is solved by heat**
5. **moisture drives spoilage**
6. **time and temperature drive spoilage**
7. **insects, rodents, dirty hands, dirty tools, and dirty containers are major contamination routes**
8. **settlement layout strongly affects water and food safety**
9. **scarcity pressures people into risky choices**
10. **safe systems are institutional, not only individual**

---

# Real-world anchors used for this spec

The rules in this document are grounded in public-health and food-safety guidance rather than invented abstractions.

Key anchors used here include:
- CDC guidance that if water is cloudy it should first be filtered or allowed to settle, then boiled; boiled water should be stored in clean, sanitized containers with tight covers.
- CDC and WHO guidance that treated water can be re-contaminated during transport, storage, and household handling.
- WHO's "Five Keys to Safer Food": keep clean, separate raw and cooked, cook thoroughly, keep food at safe temperatures, and use safe water and raw materials.
- USDA/FSIS guidance on cross-contamination, raw meat handling, and prompt chilling/refrigeration in modern settings.
- CDC handwashing guidance showing meaningful reductions in diarrheal illness from handwashing with soap and water.
- FAO guidance that grain should be dried well before storage, stored clean and dry, and protected from insects, rodents, mold, and re-contamination.
- FAO/NCHFP guidance that drying preserves food by moisture removal, but dried foods can reabsorb moisture and become vulnerable again if stored poorly.

Because this game starts before refrigeration and formal disinfection chemistry, the early design leans heavily on:
- source choice
- settling/filtering
- boiling
- drying
- smoking
- keeping clean
- keeping dry
- keeping covered
- keeping separated
- consuming riskier foods quickly

---

# 1. Safety model overview

The system should track **risk states**, not only binary safe/unsafe tags.

## 1.1 Safety domains

Every edible/drinkable thing should be evaluated in at least these domains:

### A. Water safety
- source contamination risk
- transport contamination risk
- treatment status
- storage contamination risk
- handling contamination risk

### B. Food contamination safety
- raw contamination burden
- preparation contamination burden
- cross-contamination exposure
- parasite/pathogen risk
- dirty-tool/dirty-surface exposure

### C. Spoilage stability
- moisture exposure
- warmth exposure
- time since harvest/prep/cook
- insect/rodent access
- mold growth risk
- container integrity

### D. Toxic or non-microbial hazards
- rotten/tainted food
- moldy grain/seed
- smoke/ash contamination
- chemical contamination much later
- poisonous species / misidentification risk

## 1.2 Safety states

A practical early-game model can use these broad states:
- **Unknown**
- **Probably Safe**
- **Conditionally Safe**
- **At Risk**
- **Contaminated**
- **Spoiling**
- **Spoiled**
- **Unsafe by policy**

These are not only labels; they should affect:
- NPC willingness to consume/use
- illness probability
- morale/confidence in leadership
- settlement trust in food handlers/water handlers
- whether the item can enter communal stock

## 1.3 Safety is partly social

Safety is not just a property of an object.
It is also a property of a workflow.

Example:
- Boiled water poured into a dirty open vessel and dipped into by dirty hands should become less safe again.
- Cleanly cooked meat chopped with a dirty skinning tool on a dirty hide-working surface should become less safe again.
- Good grain stored in a damp, rodent-accessible pit should degrade into unsafe stock.

This means the game should evaluate:
- item state
- container state
- surface/tool state
- handler hygiene state
- storage site state
- surrounding hazard state

---

# 2. Water safety system

# 2.1 Water source classes

Water sources should begin with different baseline risk profiles.

## Lowest early risk candidates
- protected spring
- clear fast-moving upstream source with low visible contamination nearby
- recently collected rainwater from a reasonably clean catchment (not magically pure, but often lower fecal risk than surface runoff)

## Medium-risk sources
- clear stream with upstream uncertainty
- pond edge used only in emergencies
- shallow seep or pooled surface water

## Highest-risk early sources
- stagnant pools
- floodwater
- water near latrine/waste/carcass zones
- muddy trampled shoreline used by animals
- water in dirty previously contaminated containers

## Source attributes to track
- clarity / turbidity
- flow/stagnation
- visible organic contamination
- animal traffic intensity
- human waste proximity
- carcass proximity
- flood influence
- algae/scum presence
- known safe/unsafe history
- distance from camp

## Design note

Early water safety should be a **risk-reduction chain**, not a binary source tag.
A medium-quality source with good handling may be safer than a good source handled badly.

---

# 2.2 Water contamination pathways

Water should become less safe through these pathways:

### A. Source contamination
- fecal contamination from people or animals
- runoff after storms or flood events
- carcass decomposition nearby
- stagnant warm conditions

### B. Transport contamination
- dirty buckets / pots / skins / gourds
- dirty hands while filling or pouring
- dipping dirty cups or tools into a shared storage vessel
- mixed-use containers previously used for dirty water or raw food

### C. Storage contamination
- open-topped storage
- wide-mouth vessels repeatedly dipped into
- uncovered containers in dusty/smoky/dirty areas
- storage near children, animals, insects, rodents
- dirty lids or dirty ladles

### D. Settlement contamination
- water fetched downstream of washing/butchering/latrine areas
- shared washing directly at the drinking point
- mud and standing waste around the water-fetch point
- smoke/ash fallout into open vessels

---

# 2.3 Water safety ladder

The early game should support a realistic sequence of safer water handling:

## Tier 0 — desperate direct drinking
- drink straight from source
- very fast
- no fuel cost
- highest illness risk except from clearly safe springs or snowmelt-like edge cases

## Tier 1 — source choice + cleaner collection
- choose better source point
- skim clear water above disturbed sediment
- avoid trampled animal margins
- use a dedicated water vessel
- immediate but still risky

## Tier 2 — settling and rough filtering
- let cloudy water stand so solids settle
- pour off clearer top water
- strain through cloth or similar filter to remove visible particles
- improves later treatment quality
- does **not** by itself make water reliably safe

## Tier 3 — boiling
- clear water is brought to a rolling boil
- high fuel cost
- time cost
- major pathogen reduction
- must still be cooled and stored cleanly afterward

## Tier 4 — boiling + safe storage
- boiled water moved into a clean/sanitized covered container
- ideally poured rather than dipped into
- much safer than boiling alone if container discipline is good

## Tier 5 — protected household water routine
- dedicated safe storage container
- restricted access
- clean ladle or pour-only method
- regular vessel cleaning
- separate dirty-water and safe-water vessels
- this is the first truly robust early-game water routine

---

# 2.4 Water treatment rules

## Settling
Use when water is muddy or visibly cloudy.
Benefits:
- reduces suspended solids
- makes later boiling/storage more effective and acceptable
Limits:
- does not reliably remove germs on its own

## Cloth filtering
Use on cloudy water before boiling.
Benefits:
- removes larger particles and some visible contamination
Limits:
- not sufficient by itself for safe drinking

## Boiling
Core early treatment step.
Requirements:
- vessel that tolerates heating
- heat source and fuel
- handler time and fire safety
Effects:
- strongly reduces microbial risk
- consumes fuel and labor
- can create flat taste but safer water
Limits:
- does not protect against recontamination after cooling
- cannot redeem every kind of chemically contaminated water later in the game

## Snow/ice melting (if relevant later)
- must still be treated and stored properly if contamination is possible
- cold source does not equal safe source

---

# 2.5 Safe household water storage

The safest early drinking water routine should require:
- **clean container**
- **covered container**
- **dedicated drinking-water container**
- **kept away from toxic storage, smoke fallout, and waste**
- **no dirty dipping**
- **small-volume drawing by pouring or clean ladle**
- **routine cleaning schedule**

## Storage quality classes

### Poor storage
- open pot
- shared multipurpose bucket
- dirty skin bag
- standing near ground filth
- repeated dipping by hand/cup

### Fair storage
- container covered part of the time
- not always dedicated
- some cleaning discipline
- moderate recontamination risk

### Good storage
- dedicated water container
- clean interior
- narrow access or disciplined pouring
- tight cover/lid/plug
- placed in a cleaner cooler area

### Excellent early storage
- dedicated safe-water vessel
- safe placement in camp
- clean transfer protocol
- no dirty dipping
- regular cleaning cycle
- clear distinction between raw-source water and drink-ready water

---

# 2.6 Water-related camp layout rules

The settlement should treat water safety as spatial design.

## Required spatial separations
- drinking-water fetch point away from latrine zone
- drinking-water storage away from hide work/butchery/refuse
- washing area separated from drinking-water draw point
- carcass cleaning and gut disposal away from water and camp core
- animal access controlled near human draw points

## Layout failures that should matter
- latrine uphill or too close to source
- water taken from stagnant wash area
- cleaning bloody carcasses at the drinking edge
- storing safe water in the same zone as raw hides and waste
- muddy high-traffic water point causing chronic contamination

---

# 2.7 Water safety gameplay variables

Recommended variables:
- source_risk
- turbidity
- treatment_level
- storage_integrity
- container_cleanliness
- handling_cleanliness
- distance_to_latrine
- distance_to_carcass_area
- water_turnover_age
- safe_water_policy_level

---

# 3. Food safety system

# 3.1 Food risk classes

Early foods should not all behave the same.

## High-risk perishables
- raw meat
- raw organs
- raw fish/shellfish
- cooked meat left warm
- blood-rich scraps
- wet cut plant foods

## Moderate-risk perishables
- cooked roots/tubers
- cooked grains/pulses later
- wet berries mash/pastes
- moist prepared meals

## Lower-risk shelf-stable foods when handled well
- fully dried plant foods
- well-dried lean meat strips
- smoke-dried foods stored dry
- clean dry whole grains
- dry seeds reserved for planting
- rendered fat in protected container for a limited time depending on heat and contamination

## Special-risk categories
- poisonous/misidentified plants or mushrooms
- moldy grain and nuts
- parasite-prone fish and game
- carrion/scavenged meat
- visibly spoiled cooked food
- half-dried foods that were never fully stabilized

---

# 3.2 Main contamination pathways for food

### A. Dirty hands
- food prep with unwashed hands after latrine use, butchery, animal handling, or waste handling

### B. Dirty tools and surfaces
- one knife or stone flake used for gutting, then slicing ready-to-eat food without cleaning
- butcher block / flat stone contaminated with raw juices
- mats or hides used as food prep surfaces

### C. Raw-to-cooked cross-contamination
- cooked food set where raw carcass was processed
- raw juices dripped onto clean items
- shared storage basket without separation

### D. Unsafe water in food prep
- washing food with dirty water
- making gruel or soup with untreated water
- cleaning vessels in contaminated water

### E. Insects and rodents
- flies on meat and fish
- beetles/moths in dried stores and grain later
- rodents contaminating food with droppings/urine and chewing containers

### F. Time and temperature abuse
- cooked food left warm too long
- raw meat held for long periods in sun or warm shelter
- damp food kept in poorly ventilated stores

### G. Incomplete preservation
- thick meat strips not dried through
- fish smoked but still too moist inside
- damp dried berries or roots packed too early

---

# 3.3 WHO-style safer food logic adapted to the game

The core early-game rules should mirror the same basic real-world logic:

## Keep clean
- wash hands when possible and especially before food work
- clean knives, flakes, scrapers, pots, mats, bowls, and ladles
- keep prep surfaces cleaner than butchery/hide surfaces
- protect food from flies, insects, rodents, and dust

## Separate raw and cooked
- separate raw carcass work from ready-to-eat food handling
- separate raw tools from serving tools where possible
- separate dirty water from drink-ready water

## Cook thoroughly
- thorough cooking reduces many biological hazards
- undercooked thick cuts remain riskier
- reheating reduces some risk but does not make all neglected food safe again

## Keep food at safer temperatures
In early game this mostly means:
- eat high-risk foods quickly
- cool/dry them fast if preserving
- keep cooked food out of prolonged warm holding
- use coolest storage possible for short-lived perishables

## Use safe water and raw materials
- do not normalize visibly spoiled or moldy stock
- do not wash or cook with dirty water if avoidable
- prefer fresher and cleaner inputs into communal stores

---

# 3.4 Fresh food handling rules

## Gathered plant foods
Risk factors:
- species misidentification
- decay after bruising/wet collection
- dirty wash water
- trampling/mud contamination

Best practices:
- sort damaged from sound
- keep dirty roots separate from ready-to-eat berries/leaves
- wash with safer water when needed
- consume fragile greens/berries earlier than drier roots/nuts/seeds

## Raw meat and organs
Risk factors:
- gut rupture during butchery
- delayed evisceration/gutting
- dirty skinning surface
- flies and warm conditions
- partial cooking

Best practices:
- process quickly after kill
- separate gutting and clean cutting stages
- discard heavily contaminated sections
- cook soon or preserve immediately
- keep raw meat away from communal ready food

## Fish and shellfish
Risk factors:
- fast spoilage in warmth
- gut contents/contamination
- insect exposure during drying
- sand/soil contamination on drying ground

Best practices:
- clean/gut early when appropriate
- keep shaded/cool prior to cooking or drying
- use raised drying surfaces
- protect from insects and vermin

## Eggs
Risk factors:
- cracking and dirt penetration
- prolonged warmth
- mixed dirty nest material

Best practices:
- collect regularly
- keep cracked eggs separate for immediate use
- do not mix old and new loosely if age tracking exists

---

# 3.5 Cooking safety

Cooking should reduce risk substantially, but cooking is not a total reset button.

## What cooking helps most with
- many microbial hazards in raw foods
- making some foods digestible
- improving calorie extraction from some foods
- turning uncertain raw foods into safer short-term meals

## What cooking does not solve by itself
- recontamination from dirty vessels/ladles/hands after cooking
- long warm holding after cooking
- toxic species misidentification
- heavily spoiled food that already went bad
- dirty water added after cooking

## Meal states
Recommended meal safety states:
- freshly cooked, hot
- cooling, still acceptable
- warm-held too long, rising risk
- contaminated after cooking
- spoiled leftovers

In early game, without refrigeration, many cooked foods should become short-lived.

---

# 3.6 Preservation logic

# Drying

Drying should be the foundational early preservation method.

## Requirements
- thin enough pieces or suitable food type
- airflow
- enough time
- low enough humidity / good enough weather
- protection from rain, insects, animals, dust
- follow-up dry storage

## Benefits
- lowers water activity / available moisture enough to slow spoilage
- reduces mass for storage/transport
- can create portable reserve foods

## Risks
- mold if not dried enough
- re-wetting from damp air/rain/condensation
- insect contamination
- thick pieces drying outside but not inside

## Design rules
- drying should be weather-sensitive
- raised racks and covers should matter
- dried foods must cool before sealed storage if warm from drying
- dried foods stored while warm/damp should sweat and degrade

# Smoking

Smoking should be modeled as:
- heat
- surface drying
- smoke compound exposure
- sometimes partial cooking depending on method

## Benefits
- extends shelf life relative to raw
- adds a preservation effect especially when combined with drying
- can deter some insects and surface spoilage

## Limits
- smoking alone should not be magical immortality
- badly smoked but still wet food remains risky
- thick products can remain unstable internally
- smokehouses/racks/airflow and weather still matter

# Rendering fat

Rendered fat can become a useful calorie and craft material.

## Risks
- dirty rendering vessel
- wet contamination left in fat
- warm storage and rancidity
- mixing with raw scraps

## Uses
- cooking
- lighting/fuel support in some cases
- hide working support

# Fermentation

Very limited in the early slice unless specific foods/containers/knowledge exist.
Do not use generic "ferment = safe" logic.

---

# 3.7 Grain, pulse, nut, and seed safety

Once the settlement begins proto-agriculture and small stores, this becomes one of the most important systems.

## Core rules
- dry thoroughly before storage
- clean before storage
- remove damaged, moldy, wet, insect-heavy stock when possible
- keep storage structure dry and ventilated appropriately
- prevent rodent access
- prevent mixing new harvest with old contaminated residues

## Major hazards
- mold growth due to moisture
- insect infestation
- rodents
- dirty storage containers and old residues
- seed being eaten as food during scarcity
- seed viability loss from dampness/heat/time

## Separate categories that should exist
### Eating grain/seed stock
For calorie use.

### Planting seed stock
For future production and viability.
Should be more protected, more strictly rationed, and often stored separately.

### Compromised stock
May be:
- emergency food only
- animal feed later
- discard / burn / isolate depending severity

## Design consequence
A hamlet can starve next season not because it lacked harvest, but because it failed at **drying, cleaning, protecting, and reserving** stock.

---

# 3.8 Food storage classes

## Immediate-consume storage
- hand-carried bundles
- open baskets
- temporary leaf wraps
Use for:
- same-day foods
- foraging returns
- foods awaiting prep

## Short-hold clean storage
- covered pot/bowl
- hanging basket
- shaded rack
Use for:
- next meal ingredients
- cooked food awaiting immediate use

## Cool / shaded short-life storage
- pit or cool earth shelf where suitable
- shaded ventilated hut corner
Use for:
- roots/tubers
- some produce
- water cooling
- never as a magical refrigerator

## Dry reserve storage
- dry basket lined appropriately
- ceramic vessel with lid
- raised granary / seed store later
Use for:
- dried foods
- seeds
- grain
- protected reserve goods

## High-risk storage failures
- food directly on ground
- storage in damp shelter wall/floor contact
- uncapped pots in dirty zones
- cooked and raw mixed together
- seed stored in same container as damp food scraps

---

# 3.9 Clean/dirty zone doctrine

The settlement should visibly benefit from a hygiene layout.

## Cleanest zone
- drink-ready water
- serving vessels
- ready-to-eat food
- seed reserve
- infant/sick care food later

## Clean-work zone
- cooking
- final food prep
- vessel drying
- boiled water cooling

## Dirty-work zone
- butchery
- gutting
- hide scraping/fleshing
- refuse sorting
- dirty-water vessels

## Waste zone
- latrine
- offal burial/disposal
- rotting waste pit

## Hard rule
Clean-zone items moved into dirty zones should accumulate contamination risk.
Dirty-zone tools should not safely serve clean-zone functions without a cleaning process.

---

# 4. Behavior rules for NPCs

# 4.1 Food and water risk tolerance

NPCs should not all tolerate risk equally.
Their choices should depend on:
- desperation (hunger/thirst)
- knowledge/confidence
- conscientiousness/discipline
- illness memory
- leadership policy
- settlement norms
- role identity (cook, caregiver, water keeper, storekeeper)

## Example tendencies
- desperate lone survivor may drink untreated water from a medium-risk source
- trained camp cook should resist serving cooked food from a visibly dirty vessel if alternatives exist
- careful storekeeper should refuse to mix damp grain into dry reserve stock
- sick NPCs should require safer water/food first where policy allows

---

# 4.2 Hygiene actions as tasks

The game should treat hygiene work as real labor, not passive bonuses.

Important recurring tasks:
- wash or scrub vessel
- refill safe-water vessel
- relight boil fire and boil water
- inspect water storage cover
- clean serving tools
- clean food prep surface
- move waste away from food areas
- inspect drying racks
- turn drying food / protect from rain
- inspect grain/seed for dampness, insects, mold
- exclude rodents / repair lids / patch baskets / improve hanging storage

This creates realistic tradeoffs:
less glamorous labor prevents illness and spoilage.

---

# 4.3 Refusal, warning, and override rules

NPCs should have the ability to:
- warn: "water container is dirty"
- warn: "this meat is turning"
- warn: "seed stock is damp"
- refuse communal use of badly compromised stock
- accept risk under emergency override if the player insists or scarcity becomes acute

These warnings should grow out of knowledge and experience, not omniscient game magic.

---

# 5. Buildings and structures interacting with safety

# 5.1 Key early structures that affect water safety
- water-fetch point
- washing point
- boiling hearth / cook hearth
- dedicated safe-water storage vessel area
- covered shelf / raised stand for safe water
- drainage path away from camp core

# 5.2 Key early structures that affect food safety
- butchery area
- drying rack
- smoking frame / smoking hut
- raised food cache
- cool pit / root pit where appropriate
- covered dry storage
- seed store / reserve vessel
- refuse zone
- latrine zone

# 5.3 Structure qualities that matter
- cover
- airflow
- raised from ground
- rodent resistance
- insect resistance
- drainability
- cleanability
- separation from dirty work
- fuel access for boiling/cooking

---

# 6. Interactions with other systems

# 6.1 Health / Injury / Care
Unsafe food/water can produce:
- diarrhea burden
- vomiting burden
- dehydration acceleration
- weakness / fatigue
- caregiving load
- reserve consumption spike
- social fear or distrust in handlers

# 6.2 Environmental hazards
Weather should directly affect safety:
- rain increases re-wetting risk on drying foods
- floods contaminate water and food stores
- heat accelerates spoilage
- smoke can foul storage if poorly designed
- insect seasons raise contamination pressure

# 6.3 Allocation / rationing
Rationing policy should interact with safety:
- emergency consumption of borderline food
- strict protection of seed reserve
- priority safe water for sick or high-risk NPCs
- decision to discard or salvage compromised stores

# 6.4 Knowledge / discovery
New knowledge should improve safety systems:
- which source points stay cleaner
- how long to boil
- which racks dry better
- how to recognize mold, insect damage, foul smell, off texture
- how to keep raw and ready foods apart
- how to maintain a clean communal serving workflow

# 6.5 Social / recruitment
Poor food/water systems should lower settlement attractiveness.
Guests and newcomers should notice:
- whether water is handled safely
- whether food service is orderly
- whether waste is controlled
- whether the group protects shared reserves

---

# 7. Safety quality axes

Every relevant item/process/storage/building should be evaluable on these axes:

## Cleanliness
How free it is from dirt, residues, raw contamination, fecal contamination, insects, droppings, old moldy residue.

## Dryness
How protected it is from moisture, condensation, rain, ground damp, and humidity.

## Separation
How well raw/dirty/high-risk things are kept away from ready/clean/protected things.

## Coverage
How protected it is from rain, ash, flies, dust, animals, and accidental contact.

## Turnover
How long items sit before use and how often the store is rotated or checked.

## Discipline
Whether the settlement follows routines consistently or only in emergencies.

---

# 8. Hazard catalog for the food/water layer

# 8.1 Water hazards
- muddy source water
- upstream waste contamination
- floodwater contamination
- animal-trampled draw point
- dirty transport vessel
- recontaminated boiled water
- algae/scum suspicion
- shared dipping contamination

# 8.2 Food hazards
- spoiled raw meat
- inadequately dried meat/fish
- cross-contaminated cooked food
- dirty serving vessel
- moldy grain/seed
- insect-infested dry stores
- rodent contamination
- warm-held cooked leftovers
- poisonous species or misidentified gatherables

# 8.3 Process hazards
- butchering too near clean area
- hide work near food prep
- drying rack exposed to rain/sand/flies
- smoking without sufficient drying follow-through
- dirty pot reused for safe water without cleaning
- old contaminated residues mixed into fresh harvest

---

# 9. Safety event examples

## Event: Water recontamination
Conditions:
- water previously boiled
- transferred to dirty open vessel
- handler dips cup by hand repeatedly
Outcome:
- safe water confidence falls
- illness risk returns partially
- observant/knowledgeable NPC may warn or refuse communal designation

## Event: Failed drying batch
Conditions:
- weather turned humid/rainy
- food packed before fully dry
- rack was fly-exposed
Outcome:
- batch becomes unstable or mold-prone
- some portion salvageable, some downgraded, some unsafe

## Event: Seed reserve compromise
Conditions:
- damp seed vessel
- rodent access or mold signs
Outcome:
- viability drops
- planting output later reduced
- emergency debate whether to eat compromised stock

## Event: Clean/dirty workflow improvement
Conditions:
- dedicated butchery area built
- dedicated safe-water vessels established
- clean serving bowls kept separate
Outcome:
- lower ongoing illness risk
- higher trust in communal food system

---

# 10. Settlement-stage expectations

# 10.1 Lone survivor
Expected reality:
- frequent risk-taking
- minimal separation
- crude transport/storage
- water often only partially controlled
- cooked food usually consumed quickly
- high contamination vulnerability

Key gameplay tension:
The NPC may knowingly accept unsafe inputs to survive the day.

# 10.2 Primitive camp
Expected upgrades:
- designated water vessel(s)
- routine boiling when fuel allows
- dedicated hearth/cook area
- drying rack
- basic waste separation
- safer food serving habits begin

Key gameplay tension:
Fuel, labor, and discipline compete with gathering and shelter work.

# 10.3 Permanent camp
Expected upgrades:
- clearer zone separation
- safer covered storage
- more reliable drying/smoking
- clay vessels and better reserve logic
- seed reserve and cleaner handling
- water routines become repeatable rather than ad hoc

Key gameplay tension:
Need for stable institutional routines, not only heroic effort.

# 10.4 Tiny hamlet
Expected upgrades:
- role-specific handlers (cook, water keeper, storekeeper)
- communal serving norms
- stronger reserve protection
- safer handoff between handlers
- regular stock inspection
- conflict over discarding risky food versus emergency use

Key gameplay tension:
The settlement can now lose safety through complacency, bad policy, or unequal compliance.

---

# 11. Player-facing rules

The UI should teach safety through concrete signals rather than hidden formulas.

## Water indicators
- source clarity
- source contamination warning
- boiled/unboiled state
- vessel cleanliness
- covered/uncovered
- dedicated drinking-water marker
- last refreshed / stale indicator

## Food indicators
- raw / cooked / dried / smoked / rendered / grain / seed
- clean / dirty / contaminated
- dry / damp / rewetted
- insect risk / rodent risk / mold risk
- ready-to-eat vs requires cooking
- communal-safe vs emergency-only

## Storage indicators
- dry
- covered
- ventilated
- rodent exposed
- insect exposed
- dirty residue present
- mixed old/new stock warning

## Message tone
Avoid magical certainty where realism suggests uncertainty.
Use language like:
- "likely safe"
- "higher contamination risk"
- "poorly protected"
- "rewetted"
- "unsafe for communal serving"
- "seed viability likely reduced"

---

# 12. Rules for communal stock acceptance

The hamlet should not automatically merge everything into one perfect stockpile.

## Communal-safe standards
Item may enter protected communal stock when:
- container acceptable
- not visibly spoiled/dirty
- processed with known routine
- not stored in a dirty zone
- reserve integrity still acceptable

## Emergency-use-only standards
Item may be set aside for emergency use when:
- borderline but not visibly catastrophic
- handler confidence low
- seed/food reserve pressure high
- leadership allows risk under scarcity

## Reject/discard/isolate standards
Item should be isolated or discarded when:
- obvious mold or rot
- strong foul spoilage signs
- severe insect/rodent contamination
- water container clearly fecally contaminated
- food touched by gross contamination event

---

# 13. Knowledge categories specific to food and water safety

## Discovery knowledge
- some water points stay cleaner after rain than others
- thin strips dry better than thick chunks
- covered vessels stay safer
- damp grain molds

## Procedural knowledge
- how to settle and boil water reliably
- how to clean storage vessels
- how to gut without contaminating meat badly
- how to keep a drying rack functional
- how to reserve seed separately

## Recognition knowledge
- signs of spoilage
- signs of dampness and mold risk
- signs of insect infestation
- signs a vessel is dirty or unsafe

## Institutional knowledge
- only clean ladle used for safe-water vessel
- never butcher in the cook zone
- do not mix fresh harvest into old unclean container
- protect seed stock before general rationing

---

# 14. Data model suggestions

# 14.1 Water item fields
- source_type
- source_risk_class
- turbidity_level
- treatment_history
- treated_timestamp
- storage_container_id
- storage_quality
- handling_exposure
- safe_for_communal_drinking
- confidence_level

# 14.2 Food item fields
- food_type
- raw_material_origin
- time_since_harvest_or_kill
- prep_state
- heat_treated
- dried_state
- smoked_state
- moisture_state
- contamination_state
- cross_contamination_flag
- insect_damage
- rodent_damage
- mold_flag
- storage_context
- safe_for_communal_use
- emergency_use_only

# 14.3 Container fields
- dedicated_use
- cleanliness_state
- cover_state
- opening_type
- cracked_or_sound
- dry_or_damp
- residue_present
- dirty_history_tags

# 14.4 Storage node fields
- zone_type
- dry_score
- airflow_score
- pest_exposure
- rodent_exposure
- distance_to_waste
- distance_to_water
- distance_to_butchery
- inspection_interval

---

# 15. First-playable minimum slice

If this system needs a first implementation subset later, the minimum useful slice is:

## Water
- source quality: good / medium / poor
- cloudy flag
- untreated / settled / boiled
- clean container flag
- covered flag
- recontaminated flag

## Food
- raw / cooked / dried / smoked / grain / seed
- fresh / aging / spoiled
- clean / contaminated
- dry / damp
- insect/rodent exposed flag
- ready-to-eat / requires cooking

## Zones
- clean food zone
- dirty butchery zone
- waste zone
- water zone

## NPC behaviors
- prefer boiled water if available
- warn on dirty container
- warn on seed reserve use
- warn on spoiled food
- prioritize drying food before rain if knowledgeable

Even this small slice would already make safety feel real.

---

# 16. Main design conclusions

1. Water safety is mostly about **source choice + treatment + safe storage + disciplined handling**.
2. Food safety is mostly about **cleanliness + raw/cooked separation + time/moisture control + pest exclusion**.
3. Drying and smoking are crucial early preservation tools, but both fail if moisture, pests, dirty handling, or bad storage are ignored.
4. Clean containers and clean routines are as important as the food or water item itself.
5. Seed and grain storage must be treated as strategic safety systems, not just inventory stacks.
6. The camp/hamlet should become safer only when it builds and maintains real routines and clean spatial organization.
7. Food and water safety are not side systems; they are central to survival, illness burden, trust, settlement growth, and reserve security.

---

# References

## Existing project documents
- realistic_idle_city_design_v1.md
- realistic_idle_city_early_game_bible_v0_2.md
- realistic_idle_city_npc_simulation_spec_v0_1.md
- realistic_idle_city_npc_data_schema_v0_1.md
- realistic_idle_city_task_evaluation_spec_v0_1.md
- realistic_idle_city_item_material_bible_v0_1.md
- realistic_idle_city_process_bible_v0_1.md
- realistic_idle_city_building_structure_bible_v0_1.md
- realistic_idle_city_settlement_progression_spec_bible_v0_1.md
- realistic_idle_city_knowledge_discovery_spec_v0_1.md
- realistic_idle_city_social_recruitment_spec_v0_1.md
- realistic_idle_city_allocation_ownership_rationing_spec_v0_1.md
- realistic_idle_city_health_injury_care_spec_v0_1.md
- realistic_idle_city_environmental_hazard_spec_v0_1.md

## Public grounding sources
- CDC, "How to Make Water Safe in an Emergency"
  https://www.cdc.gov/water-emergency/about/index.html
- CDC, "How to Create and Store an Emergency Water Supply"
  https://www.cdc.gov/water-emergency/about/how-to-create-and-store-an-emergency-water-supply.html
- CDC, "Safe Water Storage"
  https://www.cdc.gov/global-water-sanitation-hygiene/about/about-safe-water-storage.html
- WHO, *Household Water Treatment and Safe Storage*
  https://iris.who.int/bitstream/handle/10665/206916/9789290616153_eng.pdf
- WHO, "Five keys to safer food manual"
  https://www.who.int/publications/i/item/9789241594639
- WHO, "Promoting safe food-handling behaviours"
  https://www.who.int/activities/promoting-safe-food-handling
- USDA FSIS, "Kitchen Companion: Your Safe Food Handbook"
  https://www.fsis.usda.gov/sites/default/files/media_file/2020-12/Kitchen-Companion.pdf
- USDA FSIS, "Smoking Meat and Poultry"
  https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/food-safety-basics/smoking-meat-and-poultry
- USDA FSIS, "Food Safety While Hiking, Camping & Boating"
  https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/food-safety-basics/food-safety-while-hiking-camping
- CDC, "About Handwashing"
  https://www.cdc.gov/clean-hands/about/index.html
- CDC, "Handwashing Facts"
  https://www.cdc.gov/clean-hands/data-research/facts-stats/index.html
- FAO, "Food storage and processing for household food security"
  https://www.fao.org/4/w0078e/w0078e07.htm
- FAO, "Processing & Storage | Food Loss and Waste in Fish Value Chains"
  https://www.fao.org/flw-in-fish-value-chains/value-chain/processing-storage/en/
- FAO, "Artisanal Fish Smoking"
  https://www.fao.org/flw-in-fish-value-chains/value-chain/processing-storage/artisanal-fish-smoking/en/
- FAO, "Good fish handling"
  https://openknowledge.fao.org/server/api/core/bitstreams/5705f4ff-7b1a-42b4-ab4b-2a5ddc059cc0/content
- National Center for Home Food Preservation, "Drying"
  https://nchfp.uga.edu/how/dry
- National Center for Home Food Preservation, "Packaging and Storing Dried Foods"
  https://nchfp.uga.edu/how/dry/drying-general/packaging-and-storing-dried-foods/
