---
title: "Realistic Incremental/Idle Colony-to-City Game Design Document"
subtitle: "Pollution / Waste / Byproduct Spec"
version: "v0.1"
scope: "Early slice only: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
author: "OpenAI / ChatGPT"
date: "2026-04-09"
---

# Purpose of this document

This document defines how **pollution, waste, contamination, residues, and byproducts** should work in the early game.

It is not an industrial-era emissions document yet.
It focuses on the kinds of dirty outputs that already matter from day one:

- human excreta
- urine-contaminated soil
- greywater and dishwater
- food scraps and spoiled food
- carcasses, offal, blood, hides, and bones
- smoke and carbon-monoxide risk from combustion
- ash, charcoal fines, soot, and dirty hearth areas
- broken pottery, worn tools, and fiber/hide offcuts
- pest attractants and vermin habitat
- muddy runoff and dirty work surfaces

The goal is to make dirt, filth, smell, residue, smoke, clutter, and contamination part of the colony’s realistic survival challenge rather than background flavor.

---

# 1. Design stance

## 1.1 Waste is not a late-game problem

In the early slice, pollution and waste begin immediately.
A lone survivor already produces:

- feces and urine
- discarded food remains
- dirty water
- smoke
- ash
- spoiled materials
- contaminated tools and surfaces

The question is not whether waste exists.
The question is whether the camp manages it well enough to avoid:

- contaminated water
- foodborne illness
- flies, rodents, and other pests
- bad smells and morale decline
- increased predator/scavenger attraction
- respiratory burden from smoke
- clutter that slows work and increases accidents

## 1.2 Early pollution is mostly local

In the early game, pollution is usually not a regional climate or industrial plume problem.
It is mostly a **local exposure and contamination problem**:

- too much smoke near sleeping areas
- latrine too close to water
- waste pit too close to camp core
- blood and scraps left near shelter
- dishwater dumped where people walk and collect water
- carcasses left to rot near camp
- rodent access to food waste and stores

## 1.3 Byproducts are not automatically waste

A realism-first system should distinguish:

- **valuable byproducts**
- **conditionally reusable residues**
- **hazardous contamination loads**
- **true discard waste**

Examples:

- bone may be useful
- ash may be conditionally useful
- charcoal fines may have limited reuse
- hide scraps may be patch material or trash depending on size and cleanliness
- manure later may be valuable, but only if handled safely
- excreta is never treated as casually reusable in the early slice

## 1.4 Dirt is a spatial problem

Waste should matter partly because of **where it is**.
The same material can be tolerable in one place and dangerous in another.

Examples:

- ash in a cold hearth zone: mostly fine
- ash scattered into water storage: contamination problem
- food scraps near predator paths: security problem
- carcass remains near camp: disease, odor, rodent, and morale problem
- greywater dumped downslope away from camp and water: manageable
- greywater dumped beside the water point: unsafe

---

# 2. Relationship to the existing design stack

This spec inherits several already-established rules from the design stack:

- the early vertical slice is lone survivor -> primitive camp -> permanent camp -> tiny hamlet
- sanitation is part of the settlement layer from the beginning
- the early game already includes waste separation, latrine logic, drying/smoking, carcass handling, and spoilage pressure
- item/process/building records should explicitly track byproducts, waste, sanitation impact, and pollution outputs

That means this document does **not** invent a separate subsystem. It formalizes what the rest of the project has already implied.

---

# 3. What counts as pollution, waste, and byproduct

## 3.1 Master categories

Use these master categories throughout the data model.

### A. Excreta waste

- feces
- urine contamination
- soiled bedding linked to excreta
- latrine contents

### B. Greywater and wash waste

- dishwater
- washing runoff
- muddy cleaning water
- greasy rinse water

### C. Food waste

- peels
- stems and unusable plant parts
- spoiled food
- dropped meals
- fish guts
- shell waste
- bones not being saved

### D. Butchery and carcass waste

- blood-contaminated ground
- offal not being used
- spoiled carcass sections
- rotting carcasses
- hide fleshings
- unwanted organs

### E. Combustion residues and emissions

- smoke
- soot
- carbon monoxide risk
- embers
- ash
- charcoal fines
- tarry soot near smoking structures

### F. Workshop residues and scrap

- broken pottery sherds
- cracked greenware
- dull flakes and shattered stone waste
- rotten cordage
- bark strips and shaved wood waste
- hide scraps
- fiber dust and short unusable fibers

### G. Agricultural and husbandry wastes

Early slice: limited.
Later in the slice / edge of hamlet:
- manure
- urine-soaked bedding
- spoiled fodder
- animal carcasses

### H. Clutter and derelict materials

- broken baskets
- collapsed structures not cleared
- broken tools left in work zones
- random stock piles left in paths
- refuse that creates trip hazard or pest shelter

---

# 4. Pollution media

Track waste not only by material, but by **how it harms**.

## 4.1 Airborne burden

- smoke exposure
- soot exposure
- irritating fumes
- carbon monoxide risk in enclosed or badly ventilated areas

## 4.2 Water contamination burden

- excreta near water
- dirty wash water near water source
- carcass runoff
- spoiled food/liquid seepage into water-fetch areas
- storm transport of waste downslope toward water

## 4.3 Soil and surface contamination burden

- fecal contamination of camp ground
- greasy or bloody processing areas
- dirty sleeping areas
- food preparation on contaminated surfaces
- muddy pathogen-prone work areas

## 4.4 Food contact contamination

- raw/cooked crossover
- contaminated hands
- dirty cutting surfaces
- flies/rodents contacting food
- storing food in dirty containers

## 4.5 Vector and attractant burden

- odors
- exposed scraps
- stored waste
- standing dirty water
- brush/clutter supporting rodents
- carcasses drawing scavengers

## 4.6 Visual / morale burden

Even when not acutely toxic, unmanaged waste can reduce:

- perceived safety
- camp orderliness
- confidence in leadership
- willingness of newcomers to stay
- willingness to sleep/eat near polluted zones

---

# 5. Core realism anchors for the early slice

## 5.1 Excreta separation matters

WHO identifies sanitation as access to facilities and services for safe management of human urine and feces, and improving sanitation reduces disease burden and supports dignity and wellbeing.
For the game this means feces and urine are not cosmetic; they are a major contamination source if allowed to mix with water, food areas, or living areas.

## 5.2 Wastewater and excreta reuse are risk-based, not casual

WHO’s guidance on wastewater, excreta, and greywater treats reuse as something that requires risk management and safe procedures, not something to improvise casually.
For the early slice, this means the colony should **not** treat raw human waste or uncontrolled greywater as simple fertilizer for food plots.

## 5.3 Human waste must stay away from water and camp core

National Park Service / Leave No Trace guidance commonly advises catholes roughly 6–8 inches deep and at least 200 feet from water, camp, and trails where no toilet exists.
In game terms, the exact distance can be abstracted, but the principle must remain:

- keep excreta well away from water points
- keep it well away from food preparation
- keep it well away from sleeping areas and common traffic

## 5.4 Wood smoke is a real health burden

EPA states that wood smoke contains gases and fine particles and can irritate lungs, increase inflammation, and worsen respiratory problems.
That means hearths and smoke structures need siting, ventilation, and exposure rules.

## 5.5 Carbon monoxide is a real enclosed-fire hazard

CDC states carbon monoxide is odorless, colorless, and deadly, and is produced by fuel-burning devices.
For the game, any enclosed or poorly ventilated combustion setup should create CO risk rather than simply “warmth.”

## 5.6 Carcasses and scraps attract rodents and scavengers

CDC guidance around disaster cleanup and rodent control emphasizes removing animal carcasses, controlling garbage, and reducing food sources that attract pests.
That supports making exposed scraps, rotting carcasses, and unprotected offal a real security and disease problem.

## 5.7 Improper manure management pollutes water and spreads disease

FAO notes that manure can be valuable but improper manure management can cause water pollution, environmental degradation, and disease risk.
That matters most once the hamlet begins keeping small stock.

## 5.8 Open burning is not a universal solution

EPA guidance treats open burning as heavily constrained because of pollution and health concerns.
In the game, fire may still be used for specific survival tasks, but “burn the trash pile” should not be treated as a clean or harmless universal disposal method.

---

# 6. Early-slice waste sources by stage

## 6.1 Lone survivor

Main waste outputs:
- feces and urine
- dishwater / washing runoff
- ash from small fire
- smoke exposure
- spoiled gathered food
- carcass remains from small animals or fish
- broken stone flakes
- wet/dirty bedding if neglected

Main risks:
- contamination by laziness or exhaustion
- waste accumulating too close to shelter
- fear of leaving camp at night causing poor latrine habits
- water source fouled by ignorance

## 6.2 Primitive camp

New waste outputs:
- more ash and soot from regular hearth use
- drying/smoking residues
- larger food waste volume
- hides and offcuts
- dirty work surfaces
- dedicated refuse area contents

Main risks:
- smoke near sleep area
- fly/rodent attraction
- blood and scraps near processing area
- path clutter and trip hazards

## 6.3 Permanent camp

New waste outputs:
- larger latrine burden
- pottery breakage and kiln sweepings
- seed husks/chaff and processing residues
- structured greywater zones
- more fuel handling residue
- larger storage spills and spoilage events

Main risks:
- long-term soil contamination in camp core
- bad runoff routes during rain
- dirty containers contaminating safe water or seed
- chronic smell / morale decline

## 6.4 Tiny hamlet

New waste outputs:
- multi-person excreta load
- cooking-house and wash-area waste
- child/elder/injured care waste
- workshop scrap from more specialized work
- early manure and bedding waste if animals are present
- more broken containers / tools / worn goods

Main risks:
- sanitation labor falling behind population growth
- waste role becoming “nobody’s job”
- conflict over who cleans, who carries, and where waste goes
- outsiders judging settlement quality partly by smell/orderliness

---

# 7. Source families and their rules

## 7.1 Excreta system

### What it includes
- feces
- urine loading
- toilet paper analogs / wiping materials later if modeled
- contaminated soil around repeated informal use sites

### Game rule
Excreta should be treated as a **high-risk contamination source**.

### Key mechanics
- informal open defecation raises contamination and morale penalties quickly
- designated cathole or latrine zones localize contamination burden
- overused latrines become smell, fly, and overflow risks
- heavy rain can worsen badly sited latrines
- children/sick/injured NPCs create added sanitation burden

### Early allowed handling
- designated defecation area
- cathole use
- simple latrine pit later
- cover soil application after use

### Early discouraged handling
- direct use on food plots
- placement upslope of water source
- placement inside camp core
- uncovered shared feces areas

## 7.2 Greywater and wash water

### What it includes
- handwashing runoff
- dishwater
- greasy cleaning water
- bathing water
- rinse water from hides or dirty work tools

### Game rule
Greywater is lower risk than feces, but still a contamination and vector-management problem.

### Key mechanics
- clean water becomes dirty after contact with bodies, dishes, food residues, or work residues
- greywater dumped repeatedly in one trampled area creates mud, smell, insects, and bad footing
- greasy or bloody wash water near camp core increases flies and odor
- greywater near water source threatens water safety

### Early allowed handling
- scatter or disperse away from water point and camp core
- strain solids first where possible
- dedicated wash-water dump zone downslope from core living area

### Early discouraged handling
- reuse for drinking
- dumping beside water-fetch point
- uncontrolled reuse on food plants in the early slice

## 7.3 Food scraps and spoiled food

### What it includes
- scraps from prep
- spoiled cooked food
- spoiled raw food
- shells, peels, stems, bones not being saved

### Game rule
Food waste is not only a loss of calories; it is a **pest and disease attractant**.

### Key mechanics
- exposed scraps increase flies, rodents, and scavenger attraction
- rotten food near sleeping/eating areas lowers morale and sanitation score
- spoiled food mixed into usable stock raises contamination events if not sorted
- wet plant waste can be lower risk than meat waste but still adds clutter and attraction

### Early allowed handling
- immediate separation of usable scraps, animal feed scraps later, and discard waste
- burial or distant discard of high-risk scraps where appropriate
- drying some scraps only when actually intended as preserved food/fodder

### Early discouraged handling
- leaving scraps at the processing area overnight
- storing spoiled food in the main food cache

## 7.4 Carcass, butchery, and hide waste

### What it includes
- blood
- offal
- spoiled tissue
- unusable fat
- gut contents
- rotting carcasses
- fleshings removed from hides

### Game rule
This is one of the most dangerous early waste families because it combines smell, contamination, pests, and predator attraction.

### Key mechanics
- fresh carcasses are time-sensitive
- incomplete processing produces rapid spoilage risk
- blood and scraps contaminate work surfaces and nearby soil
- carcass disposal too close to camp increases scavenger attraction
- old carcass remains increase rodent/insect activity

### Safe-ish early responses
- process quickly
- separate usable from unusable immediately
- place discard remains away from water and camp core
- keep carcass and waste areas distinct from clean food preparation

### Future hooks
Later eras can add dedicated slaughter zones, rendering, hide yards, tannery waste, bone processing, and formal carcass pits.

## 7.5 Smoke, soot, and carbon-monoxide risk

### What it includes
- hearth smoke
- smoking rack smoke
- shelter fire smoke
- soot buildup
- enclosed-fire CO accumulation risk

### Game rule
Combustion creates both useful outputs and hazardous exposures.

### Key mechanics
- outdoor or well-ventilated fire = lower risk
- enclosed/poorly vented shelter fire = high CO and smoke risk
- smokehouse / smoking rack near camp core may contaminate air and bother residents if badly sited
- chronic smoke exposure lowers respiratory comfort and may increase illness burden
- soot buildup makes areas dirtier and worsens perceived cleanliness

### Early design implication
A fire source should track:
- heat benefit
- light benefit
- cooking benefit
- smoke output
- soot residue
- CO risk rating based on enclosure/ventilation

## 7.6 Ash, charcoal fines, and hearth residue

### What it includes
- wood ash
- charcoal dust/fines
- partially burned residue
- ember hazard

### Game rule
Ash is a **conditional byproduct**, not automatically harmless or always useful.

### Potential uses
- limited cleaning/alkali pathway later
- limited soil amendment use in specific cases later
- minor drying/cover material in some contexts

### Risks
- hot ash fire risk
- dirty ash contaminating food/water
- overapplication to soils as casual “free fertilizer” should be discouraged
- ash piles in work paths create mess and dust

### Design stance
Do not let ash become magical zero-cost disposal for all waste.

## 7.7 Workshop scrap and residues

### Stonework
- flakes
- dull chips
- broken hafts

### Pottery
- greenware failures
- firing cracks
- sherds
- kiln sweepings

### Fiber/basketry
- short fibers
- dust
- broken weaving pieces
- rotten cordage

### Hide/leather
- offcuts
- fleshings
- hair/waste from scraping
- greasy rinse waste

### Woodwork
- bark waste
- shavings
- rotten offcuts
- splinters

### Game rule
Workshop residues matter mainly through:
- clutter
- fire load
- trip hazard
- contamination of clean work zones
- reuse potential if sorted

## 7.8 Manure and bedding waste

Mainly relevant late in the early slice.

### What it includes
- dung
- urine-soaked bedding
- mixed litter/manure pack
- spoiled stored manure

### Game rule
Manure is **valuable but risky**.

### Benefits later
- soil fertility support
- compost/manure systems later

### Risks
- water contamination
- odor
- fly breeding
- disease transmission
- muddy animal areas degrading settlement hygiene

### Early stance
Keep animal waste as a managed external burden, not an instant fertility bonus.

---

# 8. Clean / dirty / polluted spatial model

## 8.1 Core zone types

### Clean-sensitive zones
- drinking water handling
- food preparation
- cooked food storage
- bedding and sleep area
- infant/sick care area
- seed storage
- clean tool storage

### Dirty-work zones
- butchery
- hide scraping
- dishwashing
- ash dump / hearth cleaning
- pottery cleanup
- workshop scrap sorting

### Waste zones
- cathole field / latrine
- refuse pit
- carcass discard area
- greywater discharge zone
- manure pile later

## 8.2 Contamination pressure

Each zone should carry a contamination pressure value shaped by:

- nearby waste
- repeated dirty processing
- rainfall/runoff
- foot traffic from dirty to clean zones
- pest activity
- cleaning effort

## 8.3 Zone bleed

Contamination should not be perfectly local.
It can spread by:

- footsteps
- tools moved between areas
- containers reused dirty
- runoff in rain
- insects/rodents
- smoke plume drift
- proximity of open waste to core spaces

---

# 9. Waste handling ladder

## 9.1 Prevention

The cheapest waste is waste not produced.
Early examples:
- butcher quickly before spoilage expands discard volume
- use more of a carcass if skills allow
- keep food dry and covered to avoid spoilage
- site fires properly to reduce smoke burden
- sort scrap before it becomes mixed dirty trash

## 9.2 Segregation

Always separate at source when possible:

- edible vs inedible
- clean scrap vs contaminated waste
- ash vs food waste
- broken reusable vs discard
- seed vs food grain
- dirty water vs clean water

## 9.3 Safe temporary holding

Sometimes waste cannot be removed immediately.
Add temporary holding states:

- covered scrap basket
- ash bucket/pile
- carcass processing offal container or area
- sealed/covered refuse basket later

## 9.4 Reuse

Allowed only where realistic and safe.

### Safe/low-risk reuse examples
- bone kept for future craft use
- wood offcuts as fuel
- clean fiber offcuts as stuffing or tinder
- some ash retained for future soap/alkali experiments later
- pottery sherd reuse as grog/temper later

### Conditional reuse examples
- manure later under management
- greywater for specific non-food uses later under rules
- cloth rags for cleaning if not contaminated with dangerous material

### Blocked in early slice
- direct human excreta use on food plots
- casual use of dirty greywater on crops
- storing mixed refuse in general inventory as “scrap”

## 9.5 Disposal / isolation

When reuse is unsafe or not worthwhile, remove from sensitive areas.

Main early disposal pathways:
- burial / cover
- distance discard in low-use area
- dedicated refuse pit
- dedicated carcass disposal zone
- burn only in narrow appropriate cases, never as a universal answer

## 9.6 Cleanup / remediation

Dirty zones should sometimes require:
- scraping
- sweeping
- ash removal
- soil cover replacement
- tool washing
- container cleaning
- bedding change
- runoff diversion

---

# 10. Reuse matrix for the early game

## 10.1 Valuable byproducts

- bone
- sinew if obtained
- antler/horn later
- usable hide scraps
- clean wood offcuts
- good charcoal
- pottery sherds for temper later
- selected ash for future lye pathway later

## 10.2 Conditionally useful residues

- wood ash
- charcoal fines
- short plant fibers
- worn cloth/rag pieces later
- urine-soaked bedding only once manure systems exist and only under managed rules

## 10.3 Usually discard / isolate

- feces
- heavily contaminated soil from repeat defecation or butchery
- rotten meat
- highly spoiled cooked food
- putrid offal
- greasy foul wash sludge
- pest-contaminated food

## 10.4 Hard red-line materials in the early slice

These should not quietly become safe through wishful thinking:

- untreated human excreta
- water from contaminated storage
- food contaminated by rodents or obvious spoilage
- smoke-filled enclosed sleeping shelters with active combustion
- carcasses or offal dumped near camp core or water

---

# 11. Pollution interactions with other systems

## 11.1 Health / Injury / Care

Waste and pollution should feed directly into:
- diarrheal illness risk
- vomiting/food illness risk
- wound infection risk
- respiratory irritation burden
- sleep disruption from odor/smoke
- morale decline from dirty living conditions

## 11.2 Food / Water Safety

Cross-links:
- dirty hands and surfaces
- dirty containers
- rodent and insect contamination
- greywater misuse
- latrine siting failures
- carcass handling contamination

## 11.3 Environmental Hazard

Cross-links:
- rain spreads dirty runoff
- flood spreads waste and carcasses
- heat accelerates spoilage and odor
- wind shifts smoke exposure
- drought increases dirty-water reuse temptation

## 11.4 Logistics / Hauling / Storage Flow

Cross-links:
- distance to waste zone changes compliance
- overloaded NPCs may dump waste in bad places
- mixed hauling of clean and dirty goods raises contamination risk
- poor stockpile layout increases clutter and pest access

## 11.5 Governance / Administration / Law

Cross-links:
- latrine rules
- carcass disposal rules
- waste duty rotation
- fire/smoke rules
- no-dump zones near water
- enforcement and grievance when others leave filth behind

## 11.6 Social / Recruitment

Cross-links:
- outsiders judge camp quality partly by smell/orderliness/safety
- NPCs resent unfair cleaning burdens
- dirty camps reduce trust in leadership
- refusal to clean can become a social conflict trigger

---

# 12. Detection, visibility, and player information

## 12.1 Player should see pollution as gradients, not only popups

Useful map overlays:
- smell/filth burden
- smoke burden
- contamination risk
- pest attraction
- waste hauling routes
- clean-sensitive zones

## 12.2 Warning families

### Immediate warnings
- fire in enclosed space / CO danger
- carcass near water point
- latrine too near water
- severe smoke burden at shelter

### Growing warnings
- refuse accumulation
- pest attraction increasing
- foul camp morale
- overfull latrine
- repeated dirty greywater dumping in core zone

### Chronic warnings
- sanitation labor insufficient for population
- high background respiratory burden
- persistent clutter and accident risk

---

# 13. Event and incident hooks

This spec should feed the event layer with incidents like:

- fouled water point
- latrine overflow / overuse
- smoke-filled shelter incident
- rodent contamination event
- carcass scavenger attraction event
- spoiled store due to mixed dirty stock
- fly-ridden processing yard event
- ash ember fire event
- resentment over cleaning duty
- outsider disgust / settlement reputation hit

---

# 14. Data model proposal

## 14.1 WasteMaterial record

Fields:
- id
- name
- waste_family
- source_processes
- contamination_risk_type
- odor_rating
- pest_attraction_rating
- pathogen_risk_rating
- smoke_or_air_rating if applicable
- reusable_state (none / conditional / strong)
- disposal_options
- unsafe_disposal_flags
- decay_behavior
- runoff_behavior
- morale_penalty_if_near_core
- cleanup_difficulty
- notes

## 14.2 PollutingProcess extension

For every process, allow:
- byproducts_generated
- waste_generated
- air_emissions
- dirty_tool_generation
- dirty_surface_generation
- wastewater_generated
- carcass_or_offal_output
- ash_output
- contamination_if_failed

## 14.3 Zone sanitation state

Per zone:
- clean_sensitivity
- contamination_load
- smell_load
- smoke_load
- pest_attraction_load
- clutter_load
- runoff_risk
- last_cleaned_at
- assigned_steward_role

## 14.4 Building pollution profile

Per building/structure:
- expected_waste_families
- safe_distance_preferences
- ventilation_need
- ash/soot accumulation_rate
- wastewater_output_rate
- smell_profile
- fire_risk_profile
- cleanup_labor_need

---

# 15. First-playable minimum slice

If you want the minimum viable version of this system, start with these only:

## 15.1 Waste families to simulate first
- feces/urine contamination
- greywater
- food scraps/spoilage
- carcass remains
- smoke/CO risk
- ash/soot
- clutter

## 15.2 Zone tags to simulate first
- water zone
- shelter zone
- hearth zone
- food prep zone
- dirty work zone
- latrine zone
- refuse zone

## 15.3 Consequences to simulate first
- unsafe water illness risk
- food contamination risk
- pest attraction
- smoke discomfort / respiratory burden
- morale penalty from dirty camp
- predator/scavenger attraction from carcass waste
- cleanup labor load

## 15.4 Early rules worth hard-coding first
- no excreta near water or shelter
- no ongoing fire in enclosed shelter without major risk
- carcass waste must be moved out of camp core fast
- dirty water never returns to “clean water” automatically
- spoiled food cannot sit in general food storage without consequences
- waste zones need distance but still impose hauling burden

---

# 16. Expansion path after the early slice

Once the settlement grows beyond the tiny hamlet, this system should expand into:

- formal refuse collection
- compost systems
- managed manure systems
- tannery wastewater and hide-yard residues
- soap and alkali handling
- kiln and lime dust
- smithing slag and scale
- sewerage / cesspits / drainage works
- workshop zoning laws
- smoke nuisance between districts
- industrial ash, slurry, and hazardous waste later

---

# 17. Short conclusion

A realistic colony does not become dirty only when it invents factories.
It becomes dirty the moment a human drinks, eats, cooks, defecates, washes, bleeds, butchers, burns wood, and starts storing things.

That is why pollution / waste / byproduct design belongs inside the early game.
In this project, the early settlement should succeed partly by learning to:

- keep filth away from food and water
- move dirty work out of clean spaces
- assign cleanup labor before waste becomes crisis
- reuse only what is realistically reusable
- accept that some outputs must be isolated, buried, covered, or hauled away
- treat smoke, odor, clutter, runoff, and pests as real signals of settlement quality

A clean hamlet is not just prettier.
It is healthier, calmer, safer, more attractive to newcomers, and more capable of becoming a real village later.

---

# References

- WHO, *Sanitation*  
  https://www.who.int/news-room/fact-sheets/detail/sanitation

- WHO, *Guidelines for the safe use of wastewater, excreta and greywater in agriculture and aquaculture*  
  https://www.who.int/publications/i/item/9241546859

- WHO, *Guidelines for Safe Use of Wastewater*  
  https://www.who.int/teams/environment-climate-change-and-health/water-sanitation-and-health/sanitation-safety/guidelines-for-safe-use-of-wastewater-greywater-and-excreta

- CDC, *Carbon Monoxide Poisoning Basics*  
  https://www.cdc.gov/carbon-monoxide/about/index.html

- EPA, *Wood Smoke and Your Health*  
  https://www.epa.gov/burnwise/wood-smoke-and-your-health

- EPA, *Smoke from Residential Wood Burning*  
  https://www.epa.gov/indoor-air-quality-iaq/smoke-residential-wood-burning

- National Park Service, *Leave No Trace Seven Principles*  
  https://www.nps.gov/articles/leave-no-trace-seven-principles.htm

- CDC, *Rodent Control After Hurricanes and Floods*  
  https://stacks.cdc.gov/view/cdc/5612

- CDC, *Controlling Wild Rodent Infestations*  
  https://www.cdc.gov/healthy-pets/rodent-control/index.html

- CDC, *Safety Guidelines: Disposing of Dead Animals After a Disaster*  
  https://www.cdc.gov/natural-disasters/safety/safety-guidelines-disposing-dead-animals-after-a-disaster.html

- USDA APHIS, *Wildlife Carcass Disposal*  
  https://www.aphis.usda.gov/sites/default/files/Carcass-Disposal-WDM-Technical-Series.pdf

- USDA APHIS, *On-Site Burial Module 1*  
  https://www.aphis.usda.gov/sites/default/files/11-on-site-burial.pdf

- FAO, *Enhancing manure management for sustainable smallholder farming*  
  https://www.fao.org/one-health/news-detail/enhancing-manure-management/en

- FAO, *Water quality in agriculture: Risks and risk mitigation*  
  https://openknowledge.fao.org/server/api/core/bitstreams/eb0ed8bb-545a-4d6b-84b2-d8c8bbd96b91/content

- EPA, *Management Options for Materials and Wastes from Disasters*  
  https://www.epa.gov/disaster-debris/management-options-materials-and-wastes-disasters
