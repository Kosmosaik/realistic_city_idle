# Settlement Progression Spec Bible v0.1

## Purpose

This document defines **what makes a settlement count as a settlement** in the early game of the project.

It is not a repeat of the NPC, item, process, or building documents. Instead, it sits above them and answers questions like:

- when is a lone survival site just a temporary stop?
- when does a repeated campsite become a primitive camp?
- when does a camp become permanent rather than merely larger?
- when does a permanent camp become a hamlet?
- what support burdens rise with each new NPC?
- what physical, social, and planning thresholds must exist before the settlement can honestly move to the next state?

This spec is focused on the same early slice already established in the companion documents:

- **State 0 — Lone Survivor / emergency site**
- **State 1 — Primitive Camp**
- **State 2 — Permanent Camp**
- **State 3 — Tiny Hamlet / proto-settlement**

It is intentionally strict. A state should not be reached because the player placed enough objects. A state should be reached because the settlement has actually solved the relevant real-world problems well enough to persist.

---

# 1. Relationship to the existing design set

This document assumes the following are already established elsewhere:

- the overall project fantasy and early-game progression ladder
- NPC body state, morale, interests, aptitudes, and task choice
- item states, spoilage, containers, fuel, hides, seed, and storage objects
- process definitions for water, fire, preservation, hide work, seed handling, sanitation, and camp maintenance
- building definitions for shelters, hearths, storage, work yards, latrines, racks, pits, and proto-hamlet structures

This document answers a different question:

> Given all those systems, what conditions must be true for the settlement itself to count as having advanced?

---

# 2. Core doctrine for settlement progression

## 2.1 A settlement state is a condition of life, not a cosmetic tier

A settlement stage should be awarded only when the people living there can actually operate at that level.

Examples:

- A place with two huts but no protected food reserve is **not** a permanent camp.
- A camp with a hearth and baskets but no sanitation discipline is **not** secure.
- A cluster of shelters with four NPCs but no role separation, no reserve logic, and no stable layout is **not yet** a hamlet.

## 2.2 Permanence means surviving time, not just building objects

Real sedentism is identified by signs of year-round or long-term habitation such as permanent houses, public buildings, and storage facilities. That means the game should treat permanence as an ability to remain in place across bad weather, shortages, and seasons, not merely as a construction milestone.

## 2.3 Reliable food and water are the hidden foundation of every higher stage

Permanent settlements are only credible where food and water are reliable enough to support repeated habitation. In the game, this means progression should depend on:

- regular access to usable water
- safe enough treatment/storage behavior
- recurring calorie intake
- some reserve and preservation discipline
- increasing ability to protect future food from rot, pests, and panic consumption

## 2.4 Storage and sanitation are stage-gating systems, not side systems

Storage is what protects future labor.
Sanitation is what prevents the settlement from poisoning itself.

A settlement does not become more advanced simply by adding more workers. It becomes more advanced when it can support more people **without collapsing under spoilage, contamination, congestion, and disorder**.

## 2.5 Social organization begins before formal institutions

Even a tiny settlement requires rules, whether spoken or not:

- where clean water is taken
- where waste goes
- where food is processed
- what must be preserved
- which seeds may not be eaten
- who maintains fire
- who sleeps where
- who gets first claim on scarce items

The game should model these as **early institutional behaviors**, not only as late administration.

## 2.6 Settlement progression can move backward

Regression is realistic and important.
A hamlet that loses sanitation, food security, or social coherence can fall back to permanent camp behavior.
A permanent camp that loses shelter, fuel, and storage after disaster may collapse back toward survival mode.

Progress is not only unlocks.
Progress is the continued ability to maintain a higher-order way of living.

---

# 3. Research-backed early settlement truths that should shape progression

## 3.1 Archaeological permanence is tied to long-term habitation markers

Archaeologists identify sedentism partly through permanent houses, public buildings, and storage facilities.

### Design implication

The game should not mark a settlement as permanent just because time has passed.
It should ask whether the site now shows the functional equivalent of:

- repeated sleep infrastructure
- repeated storage infrastructure
- repeated social/work infrastructure
- evidence of staying through more than one weather or food cycle

## 3.2 Not all sedentary life begins with farming, but permanence still needs reliable abundance

Some sedentary hunter-gatherer societies existed where wild food resources were unusually abundant and reliable. But for this project’s temperate one-NPC colony start, durable permanence will usually depend on some combination of storage, preservation, tending, gardening, and early cultivation.

### Design implication

The game should allow semistable camps before full farming, but true early permanence should still depend on:

- preserving food
- protecting seed or future planting material
- creating recurring harvest zones
- building enough reserve to survive gaps in immediate foraging success

## 3.3 Storage sophistication is one of the clearest markers of settlement seriousness

Early agricultural development involved increasingly sophisticated food storage, including pit silos and granaries. Traditional farm and village stores were built specifically to reduce moisture, mold, insects, rodents, and rain damage.

### Design implication

A settlement should not move past primitive camp unless it has begun to solve:

- dry storage
- cool storage where appropriate
- pest exposure
- off-ground storage where useful
- seed reserve separation
- stock rotation and inspection

## 3.4 Water burden scales faster than players expect

Emergency planning guidance commonly uses around **1 gallon per person per day** as a bare planning number for drinking/cooking, and more if hygiene and other uses are included.

### Design implication

The settlement spec should track not just “has water source,” but:

- walking time to water
- carrying burden
- treatment burden
- clean container capacity
- daily water reserve
- vulnerability to a bad-weather or injury day

A camp that only functions when someone spends huge parts of the day hauling water is still fragile.

## 3.5 Early sanitation is mostly about separation and habit

Backcountry sanitation guidance consistently separates human waste and wash water from water sources, camp cores, and trails. In early settlement terms, this means the first sanitation achievement is not a sewer. It is spatial discipline.

### Design implication

Settlement progression must care about:

- waste placed away from water and living/cooking zones
- washing away from clean-water draw points
- bloody/greasy processing away from clean food and sleep areas
- refuse not being allowed to accumulate in the core camp area

## 3.6 Post-harvest losses are settlement killers

Poor storage allows moisture, mold, rodents, and insects to destroy food and seed. Better storage and early processing such as drying can greatly reduce losses.

### Design implication

A settlement should not advance just because it harvested food once.
It should advance when it can **keep** enough of that harvest usable.

---

# 4. Settlement state record schema

Every settlement should have a persistent state record separate from NPC records and structure records.

## 4.1 Identity block

- settlement_id
- settlement_name
- current_stage
- previous_highest_stage
- biome / climate band
- founded_day
- current_population_present
- current_population_absent
- total_affiliated_population

## 4.2 Occupancy block

- year_round_population_count
- transient_population_count
- dependent_count
- guest_count
- active_workers_count
- shelter_capacity_dry
- shelter_capacity_warm
- emergency_shelter_capacity

## 4.3 Support-security block

- daily_potable_water_need
- daily_potable_water_secured
- clean_container_capacity
- days_of_water_buffer
- daily_calorie_need
- expected_daily_calorie_supply
- preserved_food_days
- staple_food_days
- seed_reserve_days_or_units
- fuel_days
- bedding_quality_score
- weatherproof_sleep_capacity

## 4.4 Sanitation and health block

- waste_separation_score
- wash_separation_score
- dirty_work_separation_score
- refuse_accumulation_score
- drainage_score
- contamination_pressure_score
- pest_pressure_score
- crowding_pressure_score
- camp_cleanliness_score

## 4.5 Storage block

- dry_storage_capacity
- cool_storage_capacity
- water_storage_capacity
- secure_seed_storage_capacity
- protected_fuel_storage_capacity
- stock_inspection_discipline_score
- storage_loss_risk_score

## 4.6 Work and organization block

- number_of_defined_work_zones
- number_of_maintained_core_routines
- role_diversity_score
- parallel_labor_capacity
- schedule_stability_score
- reserve_protection_rules_present
- common_meal_or_common_hearth_presence
- shared_maintenance_burden_score

## 4.7 Knowledge continuity block

- repeated_workflows_count
- taught_routines_count
- process_reliability_score
- settlement_knowledge_tags
- seed_selection_knowledge_present
- preservation_knowledge_present
- layout_rules_present

## 4.8 Risk / regression block

- starvation_risk
- dehydration_risk
- exposure_risk
- contamination_risk
- fire_spread_risk
- social_breakdown_risk
- abandonment_risk
- stage_regression_warning

---

# 5. Core metrics that determine settlement stage

These metrics should drive progression far more than raw building count.

## 5.1 Water security

Measures whether the settlement can provide enough usable water with enough reliability.

Should consider:

- source quality
- travel time
- queuing / contention
- hauling capacity
- treatment success
- recontamination risk
- clean storage volume
- reserve duration

## 5.2 Food security

Measures whether the settlement is still living hand-to-mouth.

Should consider:

- immediate food intake
- expected short-term supply
- preserved food reserve
- harvest predictability
- food diversity / monotony pressure
- food spoilage losses
- emergency fallback foods

## 5.3 Shelter security

Measures whether inhabitants can sleep dry enough, sheltered enough, and warm enough for repeated habitation.

Should consider:

- roof/wind protection
- bedding dryness
- crowding
- weather exposure in common conditions
- recovery quality after workdays
- ability to host one more person without major collapse

## 5.4 Sanitation security

Measures whether the settlement is controlling contamination.

Should consider:

- waste placement
- wash placement
- dirty-work placement
- carcass/offal handling
- refuse handling
- drainage quality
- standing water near living areas
- discipline of not mixing clean and dirty zones

## 5.5 Storage security

Measures whether tomorrow's goods remain tomorrow's goods.

Should consider:

- protected dry storage
- rodent/insect exposure
- moisture exposure
- clean water storage
- seed reserve separation
- fuel kept dry enough to matter
- inspection and rotation behavior

## 5.6 Labor organization

Measures whether the settlement can do more than one critical thing at once.

Should consider:

- number of adults
- schedule overlap
- role separation
- maintenance routines
- whether key tasks are mutually exclusive or parallelized
- whether illness/injury to one worker collapses the whole settlement

## 5.7 Seasonal readiness

Measures whether the settlement is acting for the next weather period rather than the next meal.

Should consider:

- reserve stock before harsh season
- spare fuel before wet/cold periods
- protected seed before planting season
- repair work before weather shift
- shelter upgrades before exposure spikes

## 5.8 Social stability

Measures whether multi-person life is workable.

Should consider:

- fairness in workload
- food allocation stability
- sleeping arrangement stability
- conflict load
- confidence in leadership / player orders
- whether the settlement feels worth staying in

---

# 6. Settlement states and hard transition logic

# State 0 — Lone Survivor / emergency site

## 6.1 Identity

This is not truly a settlement yet.
It is a person trying not to die.

## 6.2 Core problem solved

Stay alive for the next night and next day.

## 6.3 Typical physical signs

- temporary shelter or windbreak
- one active fire or fire attempt area
- scattered gathered materials
- minimal or improvised carrying/storage
- little or no true zoning

## 6.4 Behavioral pattern

- highly reactive
- dominated by thirst, exposure, and immediate calories
- very little protected reserve
- little capacity for long-duration projects

## 6.5 What prevents progression

- no routine water access
- no dependable fire maintenance
- no protected sleep area
- no storage worth defending
- no spare time for improvement work

## 6.6 Exit condition into Primitive Camp

State 0 becomes State 1 only when repeated survival systems exist rather than one-off actions.

---

# State 1 — Primitive Camp

## 7.1 Identity

A primitive camp is the first repeatable survival site.
The inhabitants are still fragile, but daily life is no longer pure emergency improvisation.

## 7.2 Core problem solved

Survive days and weeks with repeatable routines.

## 7.3 What a primitive camp must functionally provide

- repeated water-fetch routine
- repeated hearth/fire routine
- at least one dependable sleep area
- at least one protected storage method
- some way to keep at least part of fuel dry
- some way to preserve at least some food
- some spatial separation between living zone and waste/dirty work
- enough tool support to reduce pure improvisation

## 7.4 Typical structure mix

Usually includes some combination of:

- lean-to / debris hut / simple shelter
- hearth or fire ring
- cache, hanging point, or raised shelf
- drying rack
- simple work area
- cathole or dispersed waste discipline
- fuel stack or covered fuel corner

## 7.5 Typical support profile

- little reserve, but no longer zero reserve
- food still partly opportunistic
- water still labor-heavy
- storage still vulnerable
- shelter still weak in bad weather
- one illness or injury can still threaten the whole camp

## 7.6 Primitive Camp stage requirements

A camp should count as Primitive Camp only if all of the following are true:

1. **Water routine exists**  
   Water is fetched regularly enough that dehydration is not constant default pressure.

2. **A sleep site exists and is actually used**  
   The NPC usually sleeps under some shelter or repeatable protected arrangement.

3. **A maintained fire routine exists**  
   Fire is not merely a lucky event; fuel and relighting behavior now exist.

4. **At least one storage method exists**  
   Goods can be placed somewhere intentionally, not only dropped on ground.

5. **At least one preservation method exists**  
   The camp can keep some food beyond same-day desperation use.

6. **Waste is not handled in the camp core**  
   The camp has begun spatial separation of clean and dirty functions.

7. **At least one improved tool chain exists**  
   The worker is using more than found sticks and found stones.

8. **Improvement time exists**  
   Part of the day can be spent on betterment, not only immediate survival.

## 7.7 Suggested UI summary for Primitive Camp

- water: fragile but functioning
- food: daily plus tiny reserve
- shelter: basic
- sanitation: minimal but intentional
- storage: limited
- labor: single-person bottleneck still severe

## 7.8 Common reasons Primitive Camp fails to become Permanent Camp

- wet fuel and wet bedding after weather shifts
- spoilage because storage never improves
- no seed or future-food planning
- no protected container technology
- no layout discipline
- no reserve against two or three bad days in a row

---

# State 2 — Permanent Camp

## 8.1 Identity

A permanent camp is the first site that can credibly remain occupied through repeated bad-weather periods and act for the next season rather than only the next day.

It is still small and fragile.
It is not yet a true village.
But it now behaves like a place people can return to, build upon, and defend as home base.

## 8.2 Core problem solved

Stop living entirely hand-to-mouth.

## 8.3 What permanent camp means in practical terms

A permanent camp is marked by:

- stable sleep infrastructure
- real reserve protection
- dedicated storage and container use
- repeated preservation workflows
- repeated camp layout rules
- sanitation discipline that survives more than a day or two
- preparation for upcoming weather and planting cycles

## 8.4 Typical structure mix

Usually includes some combination of:

- semi-permanent sleeping hut or upgraded shelter
- maintained hearth and cooking area
- protected dry storage
- cool pit / selected pit storage
- water vessel cluster or dedicated water point
- latrine or rotating sanitation area
- drying rack / smoking frame
- hide/fiber/clay work zones
- seed drying/sorting zone
- fenced garden plots or tended plant patches

## 8.5 Permanent Camp stage requirements

A camp should count as Permanent Camp only if all of the following are true:

1. **The site survives multiple bad-weather days without functional collapse**  
   Sleep, fire, and minimum food/water routines remain viable when conditions are not ideal.

2. **Protected food storage exists**  
   The settlement has a way to hold food intentionally against short-term spoilage and scavengers.

3. **Dedicated seed protection exists**  
   Seed or future planting material is being protected separately from ordinary food use.

4. **Container technology is meaningful**  
   Water, dry goods, or processed foods can be stored/carried in purpose-made containers rather than only by hand or loose bundles.

5. **Preservation is repeatable**  
   Drying, smoking, cooling, or other preservation is part of routine camp work.

6. **Camp zoning is explicit**  
   Sleeping, cooking, water handling, dirty work, waste, and storage no longer fully overlap.

7. **Fuel reserve exists**  
   Fire continuity does not depend entirely on same-day collection.

8. **Planning for the next cycle exists**  
   The camp is acting for next weather or next season, not only immediate consumption.

9. **One more person could plausibly be supported for some time**  
   Even if not yet occupied, the settlement has crossed from strictly one-body survival into limited multi-person viability.

## 8.6 What changes socially at Permanent Camp

This is where unspoken rules begin to matter more.
The camp now needs working norms for:

- what food may be eaten immediately
- what must be preserved
- what is emergency reserve
- what is seed reserve
- where water containers belong
- where muddy, bloody, and greasy work happens
- who repairs shelter and fuel storage before storms

## 8.7 Why Permanent Camp is the first real settlement threshold

This stage is the first point at which the settlement has a memory outside the body of one worker.
That memory exists in:

- structure placement
- stored goods
- preserved reserves
- repeated routes
- work zones
- protected seed
- routines that remain valid tomorrow

## 8.8 Common reasons Permanent Camp fails to become Hamlet

- no labor parallelism yet
- food reserve too narrow or too uncertain
- social friction when second/third NPC arrives
- sanitation and waste pressure rising faster than layout quality
- not enough shelter or bedding for added people
- too much dependence on one skilled individual

---

# State 3 — Tiny Hamlet / proto-settlement

## 9.1 Identity

A tiny hamlet is the first truly social settlement state.
It is no longer just an improved survival camp.
It is a place where multiple people live with continuing roles, shared burdens, and shared infrastructure.

For this project, the tiny hamlet is the early-game target state and usually sits around the existing design range of **3–8 NPCs**, with at least some of them present year-round.

## 9.2 Core problem solved

Create first true surplus and first real labor division.

## 9.3 What a hamlet must functionally provide

- multi-person sheltering
- shared food handling and reserve logic
- clear layout and zone discipline
- enough water and fuel throughput for several people
- some plant management or food production planning
- meaningful storage where pests/spoilage matter
- at least two ongoing roles, usually more
- social stability good enough that newcomers might stay

## 9.4 Typical structure mix

Usually includes some combination of:

- multiple sleep shelters or households
- common hearth / meal space
- dedicated storage hut or clustered storage structures
- dedicated seed or staple store
- garden plots / field edge / tended food patches
- work huts or repeated craft yards
- latrine or managed rotating sanitation area
- dedicated butchering / dirty work zone
- water handling point
- simple communal meeting area or fire circle

## 9.5 Hamlet stage requirements

A settlement should count as Tiny Hamlet only if all of the following are true:

1. **More than one adult NPC is present in sustained fashion**  
   The settlement is not merely a visit site.

2. **Food production or preservation is partly planned**  
   The group is acting on seasonal and reserve logic, not only opportunistic intake.

3. **Labor can split into at least two ongoing roles**  
   Example: water/fuel + food processing, tending + gathering, trapping + storage, gardening + fire/cooking.

4. **Storage is meaningful enough that losses matter**  
   The settlement now has enough goods and enough reserve logic that moisture, pests, and spoilage are strategic concerns.

5. **Some plant management or gardening exists**  
   Full plow agriculture is not required, but recurring food-space management should exist.

6. **The layout functions as infrastructure**  
   The settlement is no longer a random pile of objects. Placement now supports life and work.

7. **Social rules exist in practice**  
   Who uses which shelter, how common stores are handled, what is emergency reserve, and what work must be maintained are now stable enough to be recognized by the simulation.

8. **A bad day for one worker does not instantly break every survival loop**  
   Parallel labor and redundancy now exist at least modestly.

## 9.6 What changes when Hamlet begins

The hamlet begins the first true settlement-level phenomena:

- role identity
- fairness concerns
- social status differences
- routine maintenance as community burden
- common spaces
- communal reserve disputes
- first durable attraction for outsiders
- first need for simple record-like memory, even if only verbal or spatial

## 9.7 Early hamlet roles that should be visible

Likely recurring roles include:

- primary forager / gatherer
- water and fuel maintainer
- cook / preserver
- trapper / hunter / fisher
- shelter and repair worker
- fiber / hide / container worker
- garden tender / seed keeper
- hauler / organizer

These do not need to be rigid professions yet, but they should be visible ongoing roles.

## 9.8 Hamlet instability factors

The first hamlet is still highly vulnerable to:

- one failed food cycle
- contaminated water routines
- fire accidents
- overcrowded sleep and storage
- reserve theft or panic eating
- role mismatch and morale collapse
- unresolved waste accumulation
- bad weather damage to core structures

---

# 7. Transitional gates in detail

## 10.1 Gate: Lone Survivor -> Primitive Camp

This gate is crossed when immediate survival becomes routine survival.

### Required functional changes

- water is fetched often enough to avoid constant thirst crisis
- a repeated shelter or sleep arrangement exists
- a repeated hearth/fire routine exists
- at least one storage point exists
- at least one preservation behavior exists
- at least one zone separation rule exists

### Player-facing meaning

The player can start spending time on improvement and not only emergency reaction.

## 10.2 Gate: Primitive Camp -> Permanent Camp

This gate is crossed when the site becomes defendable across time.

### Required functional changes

- reserve logic exists
- bad-weather resilience exists
- container use matters
- preservation is repeated intentionally
- the site has explicit clean/dirty zoning
- seed or future-food protection exists
- fuel continuity exists
- the site can plausibly host another person

### Player-facing meaning

The player can start planning by weather, season, and future labor rather than only day-to-day survival.

## 10.3 Gate: Permanent Camp -> Tiny Hamlet

This gate is crossed when survival becomes social organization.

### Required functional changes

- more than one adult lives here in continuing fashion
- role separation exists
- common infrastructure exists
- food and seed protection scale beyond one person
- sanitation and storage now function at group scale
- layout has become communal infrastructure
- retention of extra people is plausible

### Player-facing meaning

The game becomes about coordinating people and institutions, not only protecting one body.

---

# 8. Settlement support thresholds by category

These should be used as the actual tuning backbone behind stage changes.

## 11.1 Water threshold

A settlement should ask:

- can we meet today’s drinking/cooking needs?
- can we survive one disrupted collection day?
- are containers clean and covered?
- are washing and waste separated from collection?
- does adding one person break the routine?

### Suggested tuning interpretation

- **Primitive Camp:** works today, fragile tomorrow
- **Permanent Camp:** can survive disruption and bad weather better
- **Hamlet:** can serve multiple people without one hauler becoming the whole system

## 11.2 Food threshold

A settlement should ask:

- are we eating today or feeding tomorrow too?
- do we have reserves?
- can food losses erase progress?
- are future seeds or planting material protected?
- does more population create surplus or only faster depletion?

## 11.3 Shelter threshold

A settlement should ask:

- can everyone sleep dry enough to recover?
- can the shelter system absorb one more person?
- can weather hit without immediate bed collapse?
- are sleep areas separated enough from dirt, blood, and waste?

## 11.4 Sanitation threshold

A settlement should ask:

- is waste kept away from water, sleep, and food handling?
- are washing and butchering separated from clean zones?
- does runoff threaten the core site?
- does the number of people now exceed the old waste habit?

## 11.5 Storage threshold

A settlement should ask:

- are dry goods staying dry?
- are pests and mold reducing reserves?
- can we store seed separately and clearly?
- can we keep fuel dry enough for bad weather?
- can we inspect and rotate goods intentionally?

## 11.6 Role threshold

A settlement should ask:

- do we have at least two continuing roles?
- is there any redundancy if one worker is unavailable?
- is one person still forced to do all critical tasks serially?
- are maintenance tasks being neglected because no one owns them?

---

# 9. Spatial doctrine for early settlements

Settlement progression should care strongly about layout.

## 12.1 Minimum zone families by Permanent Camp

By Permanent Camp, the layout should usually express at least these zones:

- **sleep zone**
- **hearth / cooking zone**
- **clean water storage / handling zone**
- **dirty work zone**
- **waste zone**
- **dry storage zone**
- **fuel zone**
- **garden / tended resource zone**

## 12.2 Minimum zone families by Tiny Hamlet

By Hamlet, add:

- **shared meal / social center**
- **dedicated staple / seed storage**
- **more than one sleeping cluster or household area**
- **more structured work areas**
- **circulation paths that do not constantly cross contamination zones**

## 12.3 Practical sanitation spacing rule for the early game

Before advanced sanitation exists, the game should use a simplified spacing doctrine based on real outdoor sanitation guidance:

- human waste should be well away from water, camp core, and major paths
- washing should occur away from direct water draw points
- dirty animal processing should not happen in the clean food/sleep core

This is an early-game rule of **separation**, not of engineered treatment.

---

# 10. Recruitment, retention, and settlement attractiveness

## 13.1 Recruitment should remain mixed, not automatic

The project direction already favors a mixed/random model:

- wanderers
- refugees
- rescues
- acquaintances
- attraction to visible camp stability

This spec keeps that.

## 13.2 What makes a settlement attractive enough for new people to join

A new NPC is more likely to join or remain if the settlement visibly offers:

- water routine
- visible hearth and cooked-food possibility
- dry sleep possibility
- enough order to suggest survival competence
- some surplus or preserved food
- not obviously filthy or collapsing conditions
- meaningful work they can contribute to

## 13.3 What makes retention fail

Newcomers may leave, resist, or destabilize the settlement if:

- food is too scarce
- labor is unfairly assigned
- there is nowhere acceptable to sleep
- sanitation is poor
- leadership seems incompetent
- reserve rules are not trusted
- there is constant conflict over tools, food, or roles

## 13.4 Social threshold for Hamlet legitimacy

A hamlet is not socially real until at least some of the following exist in practice:

- accepted shared-use rules
- repeated common work
- repeated common meals or fire use
- visible role reliability
- at least modest confidence that staying is better than wandering

---

# 11. Failure, regression, and shock events

Settlement progression should be reversible.

## 14.1 Common regression shocks

- several days of rain soaking fuel and bedding
- food cache raided by pests/animals
- contaminated water routine causing illness cluster
- shelter damage from wind or rot
- fire destroying storage or sleeping area
- loss of seed reserve
- conflict splitting the group
- injury to sole high-skill worker

## 14.2 Regression logic

- **Hamlet -> Permanent Camp** when multi-person role system breaks but the site remains viable
- **Permanent Camp -> Primitive Camp** when reserves and zoning collapse and the site returns to reactive survival
- **Primitive Camp -> Lone Survivor site** when the camp no longer has maintained routines and the worker is back in pure emergency behavior

Regression should not delete everything. It should change what the settlement can honestly sustain.

---

# 12. Recommended UI / debug representation

Because the project uses minimal visuals and dense UI, settlement progression should be inspectable through compact panels and overlays.

## 15.1 Settlement panel

Show:

- current stage
- stage confidence
- strongest blocker to next stage
- strongest regression risk
- population present / supportable
- days of water buffer
- days of food buffer
- fuel buffer
- sanitation status
- storage status
- seasonal readiness

## 15.2 Overlay suggestions

- clean vs dirty zones
- water pathing
- waste contamination risk
- shelter dryness / exposure
- storage moisture / pest risk
- social core / household clusters
- work-zone coverage

## 15.3 Best next-stage explanation text

The UI should not merely say “Need 20 points.”
It should say things like:

- “Camp still collapses during prolonged rain: dry fuel reserve too weak.”
- “Permanent Camp blocked: seed reserve not protected from food use.”
- “Hamlet blocked: no durable shared storage for group staples.”
- “Hamlet unstable: sanitation load now exceeds current layout.”

---

# 13. Recommended implementation logic

This document is still design-facing, but it is specific enough to guide implementation.

## 16.1 Stage should be computed from conditions, not manually set

The settlement stage should be a derived result from:

- support metrics
- required structure families
- reserve conditions
- zoning quality
- role diversity
- population continuity
- seasonal proofing

## 16.2 Use hard requirements plus soft confidence

A strong model is:

- **hard gates** for absolutely required conditions
- **confidence score** for how stable the current stage actually is

Example:

A camp may technically qualify as Permanent Camp, but only at **52% confidence** because contamination risk, fuel dampness, and thin reserves make it unstable.

## 16.3 Suggested stage evaluation order

1. Check whether hard gates for current stage are still met
2. Check whether hard gates for next stage are met
3. Compute confidence for current and next stage
4. Apply hysteresis so stage does not flicker every day
5. Raise warnings when regression risk is high

---

# 14. Working definitions for this project

## 17.1 Lone Survivor site

A temporary survival site centered on one body and immediate needs.

## 17.2 Primitive Camp

A repeated survival site with working routines for water, fire, sleep, storage, and basic preservation.

## 17.3 Permanent Camp

A repeated habitation site with protected reserves, meaningful containers/storage, sanitation discipline, and planning that extends into future weather or future seasons.

## 17.4 Tiny Hamlet / proto-settlement

A multi-person, partly year-round settlement with shared infrastructure, ongoing role separation, meaningful reserve logic, and layout that now functions as social infrastructure.

---

# 15. Recommended next companion document

Now that the project has:

- NPC simulation and task choice
- item/material definitions
- process definitions
- building/structure definitions
- settlement progression definitions

the strongest next companion document is:

## Knowledge & Discovery Spec v0.1

That document should define:

- discovery knowledge
- procedural knowledge
- settlement knowledge
- teaching/apprenticeship transmission
- observation/experimentation unlocks
- recipe visibility rules
- role of intuition vs learned competence
- when a settlement knows something vs when only one NPC knows it

That is the next major missing layer needed to make progression feel earned and realistic.

---

# References

- Britannica, *How agriculture and domestication began*  
  https://www.britannica.com/topic/agriculture/How-agriculture-and-domestication-began

- Britannica, *Origins of agriculture: Early development*  
  https://www.britannica.com/topic/agriculture/Early-development

- Britannica, *Sedentism*  
  https://www.britannica.com/topic/sedentary-society

- Britannica, *How do archaeologists identify sedentism?*  
  https://www.britannica.com/question/How-do-archaeologists-identify-sedentism

- Britannica, *Village*  
  https://www.britannica.com/topic/village

- Britannica, *Hunter-gatherer*  
  https://www.britannica.com/topic/hunter-gatherer

- FAO, *Traditional farm/village storage methods*  
  https://www.fao.org/4/t1838e/t1838e12.htm

- FAO, *Farm and village level storage*  
  https://www.fao.org/4/x5065e/x5065E06.htm

- FAO, *Post-harvest losses*  
  https://www.fao.org/4/w1544e/W1544E05.htm

- FAO, *Crop handling, conditioning and storage: Grain storage*  
  https://www.fao.org/4/s1250e/S1250E0w.htm

- FAO, *Appropriate Seed and Grain Storage Systems for Small-scale Farmers*  
  https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content

- FAO, *Practical Guide for drying and storing vegetable seeds in organic small-scale and on-farm seed production*  
  https://www.fao.org/family-farming/detail/en/c/1708951/

- CDC, *How to Create and Store an Emergency Water Supply*  
  https://www.cdc.gov/water-emergency/about/how-to-create-and-store-an-emergency-water-supply.html

- CDC, *About Water Treatment Options When Hiking, Camping, or Traveling*  
  https://www.cdc.gov/drinking-water/prevention/water-treatment-hiking-camping-traveling.html

- CDC / NEHA, *Environmental Health Shelter Assessment*  
  https://www.cdc.gov/environmental-health-response-and-recovery/media/pdfs/Shelter_Assessment_instruct_508.pdf

- Leave No Trace, *Dispose of Waste Properly*  
  https://lnt.org/why/7-principles/dispose-of-waste-properly/

- U.S. Fish & Wildlife Service, *Leave No Trace Principles*  
  https://www.fws.gov/project/leave-no-trace-principles
