---
title: "Realistic Incremental/Idle Colony-to-City Game - Master Simulation Loop Spec"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
assumptions:
  - "Earth-like setting"
  - "Temperate starting biome"
  - "Top-down minimal visuals"
  - "Player issues orders, priorities, permissions, and policies"
  - "Simulation remains object-based from the start"
date: "2026-04-08"
---

# Purpose

This document defines the **master simulation loop** for the current design stack.

It exists to answer one question:

> In what order should the game update the world so that needs, hazards, hauling, tasks, ownership, health, knowledge, and settlement progression all interact consistently?

The goal is not to introduce new design philosophy.  
The goal is to **integrate the existing specs into one runtime order**.

This document sits on top of:
- the main design draft
- the early game bible
- NPC simulation
- task evaluation
- item/material bible
- process bible
- building/structure bible
- settlement progression
- knowledge/discovery
- social/recruitment
- allocation/ownership/rationing
- health/injury/care
- environmental hazard
- food/water safety
- logistics/hauling/storage flow

It is intentionally focused on the current early slice:
- one starter NPC
- primitive camp
- permanent camp
- tiny hamlet

---

# Core role of the master loop

The master loop is the system that keeps all other systems from contradicting each other.

Without it, the project risks issues like:
- an NPC drinking water before that water is actually hauled
- food being eaten from a pile that was already reserved for seed
- two NPCs taking the same log
- spoilage being checked after food has already been consumed
- knowledge unlocking before the required process actually succeeded
- settlement stage changing before reserves, sanitation, or shelter quality have actually been updated
- task scoring using stale body-state or stale stock information

The loop therefore has three jobs:

1. **Preserve causal order**  
   Causes must happen before effects.

2. **Preserve physical order**  
   Matter, labor, time, and movement must exist somewhere and take time.

3. **Preserve social order**  
   Allocation, morale, care, teaching, and settlement status must react to what actually happened, not what was planned.

---

# Scope boundaries

This spec covers:
- simulation time structure
- update cadence
- phase order inside a simulation pulse
- data that must be finalized before the next phase starts
- how NPC decision-making fits into the world update
- how item flow, process progress, health, learning, and settlement checks fit together
- deterministic and random elements
- event scheduling rules
- debugging expectations

This spec does **not** define:
- exact UI layout
- exact Godot code
- complete content tables
- late-game industrial timing
- rendering

---

# Design principles for the loop

## 1. Nothing updates "for free"
If a value changes, it should be traceable to:
- time passing
- environment acting
- a body process
- a task
- a transfer
- a process consuming or producing something
- a social/administrative rule
- a discrete event

## 2. Planning is not completion
A task being chosen does **not** mean:
- inputs were consumed
- outputs were created
- knowledge was gained
- health was improved
- hauling was completed

Selection, reservation, travel, setup, execution, and completion must stay distinct.

## 3. Matter has a location
Every meaningful object must either be:
- on the ground
- in a container
- in a structure
- carried by an NPC
- reserved for a process/task
- in a transformation state
- discarded as waste
- destroyed/consumed

## 4. NPCs are embodied first, productive second
Body state, temperature, hydration, fatigue, pain, contamination, and illness can override ideal labor allocation.

## 5. The player influences priorities, not physical law
The player can:
- set priorities
- forbid or allow tasks
- reserve items
- change rationing
- assign roles
- create work zones
- define stockpiles
- set emergency rules

The player cannot make:
- hauling instant
- spoilage stop
- unsafe water become safe without treatment
- exhausted NPCs work indefinitely with no consequences

## 6. Every phase should read stable inputs
A phase should avoid mutating the same data it is still trying to evaluate unless that mutation is the phase's explicit purpose.

This is the main reason the simulation must use **staged updates** rather than a single giant uncontrolled "everything happens at once" step. In agent-based modeling, staged activation and event scheduling are standard tools for controlling update order, and random activation order inside a stage helps reduce consistent order bias. citeturn912212search2turn912212search5turn912212search1turn912212search8turn912212search15

---

# Time model

# 1. Time layers

The simulation should use several nested time layers.

## A. Simulation pulse
The smallest common update unit for stateful logic.

Recommended role:
- body-state decay/gain
- exposure accumulation
- movement progress
- process progress
- task progress
- spoilage increments
- hazard checks
- queue updates

## B. Hour block
Used for:
- schedule tendencies
- sleep pressure interpretation
- light/dark effects
- daily water/fire/meal rhythms
- social availability
- task suitability shifts

## C. Day
Used for:
- day summary
- reserve checks
- recruitment attraction update
- sanitation burden accumulation review
- daily consumption accounting
- morale trend effects
- simple settlement KPI checks

## D. Week / multi-day review
Used for:
- storage stability
- repeated failures
- social cohesion drift
- injury recovery trend
- apprenticeship/learning review
- task priority policy reflection
- work zone effectiveness

## E. Seasonal period
Used for:
- planting windows
- harvest windows
- fuel urgency
- clothing/shelter urgency
- water-source reliability shift
- hazard profile changes
- settlement-stage resilience checks

---

# 2. Recommended pulse philosophy

The simulation should favor:
- **fixed-length simulation pulses**
- stable ordering inside each pulse
- delayed effects scheduled explicitly
- random tie-breaking only where beneficial
- reproducible runs when using the same seed

This is consistent with common simulation practice:
- staged activation lets a model separate decision, motion, interaction, and effect stages citeturn912212search2turn912212search8
- random order within an agent set helps avoid always favoring the same agent by position in a list citeturn912212search1turn912212search4
- reproducibility depends on a defined seed and defined update order citeturn912212search15

---

# Simulation state categories

The loop should treat world state as several categories.

## 1. Persistent state
Long-lived facts:
- terrain
- placed structures
- item stacks/objects
- NPC identity and baseline traits
- long-term skills
- knowledge records
- social ties
- settlement status
- standing policies

## 2. Dynamic continuous state
Values that drift frequently:
- hydration
- fatigue
- temperature burden
- pain
- illness severity
- spoilage progress
- process completion percent
- tool wear
- fire heat/output state
- container fullness

## 3. Intent state
Planned or reserved actions:
- selected task
- reserved inputs
- target destination
- assigned haul destination
- bed claim
- ration entitlement
- emergency override
- care target
- teaching target

## 4. Discrete event state
Timed or triggered events:
- process finished
- shelter collapsed
- fire went out
- stranger arrived
- item contaminated
- wound worsened
- storm onset
- structure completed
- knowledge validated
- settlement stage changed

## 5. Derived state
Values that should usually be recalculated from more basic data:
- task score
- role suitability
- settlement readiness
- stock sufficiency
- exposure risk
- local sanitation score
- attraction score
- social confidence trend

---

# Authoritative order of operations

The master loop should be run in the following phase order.

# Phase 0 - resolve scheduled time triggers

This phase applies events whose trigger time has arrived.

Examples:
- dawn/dusk state changes
- weather front starting or ending
- process timeout finishing
- spoiled batch threshold reached
- recruitment opportunity appearing
- temporary reservation expiring
- fire burnout event
- healing review moment
- policy timer changes

Outputs of this phase:
- event queue reduced
- world flags updated
- expired reservations released
- time-of-day and weather states made current

This phase must happen first so later phases read the current environment.

---

# Phase 1 - refresh environment and local hazard fields

Update world-side conditions before touching NPC choices.

Includes:
- temperature band
- precipitation
- wind
- light level
- wetness propagation
- surface dryness
- smoke concentration
- nearby fire/heat fields
- flood/mud status
- insect/tick/mosquito pressure
- predator/activity pressure
- contamination field changes
- water source condition changes

Outputs:
- per-cell environmental descriptors
- hazard intensities
- source availability flags

These values are inputs to exposure, path cost, and task suitability.

---

# Phase 2 - update structure, fire, and container states

Update passive world objects that are not waiting for NPC choices.

Includes:
- hearth/fire state
- shelter dryness and warmth contribution
- roofing leakage
- storage container openness/cover status
- rack occupancy status
- latrine fill/burden
- drying rack and smoke-frame environmental contribution
- spoilage modifiers from storage context
- water container cleanliness status if contaminated or mishandled
- structure wear from weather or neglect

Outputs:
- structure service values
- passive bonuses/penalties
- storage-condition modifiers
- care-space and sleep-space readiness

---

# Phase 3 - body maintenance and passive physiological change

Each NPC receives passive body-state change from time passage and current conditions.

Includes:
- hydration decay
- calorie depletion
- fatigue accumulation or recovery
- warmth/cold burden shift
- wetness persistence
- pain drift
- illness drift
- smoke burden drift
- contamination exposure
- sleep debt
- morale drift from baseline body discomfort

This phase should use:
- current environment
- current clothing/equipment
- current shelter/fire proximity
- current illness/injury state
- current carried burden
- current recent exertion

Outputs:
- updated body state
- updated hard blockers
- emergency needs flags

This phase must occur **before task scoring**, because an NPC with severe thirst, severe cold, or collapsing fatigue should evaluate work differently than a fully stable NPC.

---

# Phase 4 - apply automatic self-preservation and emergency overrides

Before normal planning, check whether any NPC must ignore ordinary work.

Typical override categories:
- immediate drinking need
- immediate warmth/shelter need
- collapse-level exhaustion
- severe bleeding
- severe pain/injury
- dangerous illness crisis
- immediate escape from fire/flood/predator zone
- urgent infant/dependent care later if the game expands there

Result:
- some NPCs are forced into emergency task bands
- their ordinary queue is paused or cancelled
- emergency reservations may pre-empt normal reservations

This is where "survival before productivity" is enforced.

---

# Phase 5 - refresh claims, reservations, and access rights

Before new tasks are generated/scored, stabilize who has access to what.

Includes:
- clearing invalid reservations
- confirming ongoing process claims
- re-validating item ownership state
- applying ration locks
- applying seed/protected reserve locks
- applying patient/care item priority
- applying player-forbidden access
- bed/shelter claims
- work-zone permissions
- stockpile acceptance rules

Outputs:
- authoritative availability lists
- authoritative blocked lists
- reserve-protected lists
- claim conflicts resolved

This phase prevents double-booking and accidental use of protected stock.

---

# Phase 6 - generate current task opportunities

Build the candidate task pool from the current world state.

Candidate tasks come from:
- unmet body needs
- player direct orders
- standing policies
- recurring camp maintenance
- available gathering opportunities
- hauling requests
- item safety problems
- structure maintenance
- process continuation opportunities
- care needs
- sanitation duties
- food/water preparation opportunities
- learning/teaching opportunities
- settlement-stage goals
- social/recruitment events

Each generated task should already know:
- required location
- required tools
- required items
- required body capability
- expected duration band
- urgency band
- category
- preconditions
- outputs or intended world effect

Generated tasks should remain candidates until assigned or expired.

---

# Phase 7 - evaluate tasks per NPC

Each available NPC scores relevant tasks.

This phase uses the task evaluation rules already defined elsewhere, but the master loop determines **when** those scores are calculated.

Inputs:
- fresh body state
- current hazards
- access rights
- distance/path cost
- role fit
- interest/aptitude/skill
- player priority
- colony urgency
- learning value
- social/ownership restrictions
- reserve policies
- health restrictions

Hard blockers exclude tasks first:
- cannot reach
- forbidden by player
- no access rights
- no tool
- body too impaired
- task site too dangerous
- reserved inputs unavailable
- no valid destination
- process window closed

Then scores are calculated.

Tie-handling should be explicit.  
When scores are very close, a random tie-break or soft variety rule is useful so the same NPC does not always choose the exact same low-variance action. Randomized order/selection within a controlled stage is a standard way to reduce consistent order bias in agent-based simulations. citeturn912212search1turn912212search8turn912212search15

Outputs:
- ranked task list per NPC
- optionally a chosen primary task and fallback task

---

# Phase 8 - commit task selection and reserve execution inputs

Task choice becomes real here.

For each NPC:
- select one active task or remain idle/resting
- reserve required inputs
- reserve required target/destination slot if relevant
- reserve workstation occupancy if needed
- reserve bed/care space if needed
- record fallback if primary becomes invalid

Important rule:
- **selection reserves inputs**
- **selection does not consume inputs yet**

Consumption should happen only when the process/task reaches its defined commit point.

Examples:
- hauling task reserves source stack and destination slot
- cooking task reserves ingredients and vessel
- fire-feeding task reserves fuel
- shelter repair task reserves materials
- treatment task reserves bandage/water/clean workspace

Outputs:
- active task assignments
- confirmed reservations
- updated occupancy maps

---

# Phase 9 - movement and positioning

NPCs advance physically toward task goals.

Includes:
- path following
- obstacle response
- burden-adjusted movement
- terrain cost
- weather cost
- hazard avoidance
- escort/follow behavior later if needed
- pickup/drop intermediate movement
- return-to-shelter movement
- fleeing movement

Movement should not directly finish the task unless the task is movement-only.

Outputs:
- new positions
- travel progress
- arrival events
- in-transit exposure updates queued for later body phase

This phase is separate from process execution so arrival, travel time, and haul effort remain visible.

---

# Phase 10 - interaction and task execution

NPCs at valid destinations advance their tasks.

This is where work actually happens.

Sub-categories:
- gather
- pick up
- drop off
- build
- repair
- tend fire
- prepare food
- prepare water
- butcher
- preserve/dry/smoke
- process hides
- braid/twist cordage
- shape clay
- care for patient
- clean area
- inspect source
- teach/observe
- socialize
- rest/sleep
- guard/watch

Each task should define its own commit points:
- on-start
- on-midpoint
- on-completion
- continuous per pulse

Example:
- hauling may commit pickup at source arrival
- construction may consume material incrementally
- boiling may commit fuel use at start and water-state change at completion
- butchering may convert carcass state gradually and contamination risk continuously
- sleeping may recover fatigue continuously

Outputs:
- process/task progress advanced
- items consumed or transformed when commit point is reached
- structures advanced
- care effects applied
- new waste/byproducts created
- failures/injuries possible

---

# Phase 11 - resolve transfers and storage placement

After execution, all successful transfers must land somewhere explicit.

Includes:
- ground drop placement
- container insertion
- stockpile insertion
- carried inventory update
- water poured into container
- food moved to drying rack
- seed moved to reserve store
- waste moved to refuse zone
- dirty tools placed in dirty zone if modeled
- failed placement fallback behavior

This phase must also enforce:
- destination validity
- stack merging rules
- contamination carryover
- protected reserve respect
- storage suitability
- overflow handling
- spoilage-risk penalties for poor placement

Outputs:
- authoritative item locations
- updated container inventories
- carry states finalized

---

# Phase 12 - process completion, product state changes, and spoilage

Update all non-NPC process states after execution/transfers.

Includes:
- drying progress
- smoking progress
- boiling completion
- cooking completion
- hide drying/softening progress
- clay drying/firing progress
- fire burnout/fuel reduction
- stored food spoilage increments
- seed viability change
- water contamination change
- tool wear from completed work
- construction stage transition
- sanitation burden growth from waste, carcasses, dirty surfaces

This phase should also convert any threshold crossings into events:
- "potable water ready"
- "dried meat unsafe"
- "fire out"
- "structure complete"
- "latrine overloaded"
- "seed reserve damp"
- "hide rotted"
- "food batch spoiled"

---

# Phase 13 - health, injury, contamination, and recovery resolution

This is the main post-action health consequences phase.

Includes:
- injury application from accidents
- contamination from dirty handling
- infection progression
- diarrhea/vomiting burden progression
- pain increase/decrease
- fatigue spike from heavy exertion
- warmth gain from successful shelter/fire use
- hydration gain from drinking
- calorie gain from eating
- sleep recovery from sleep pulses
- care outcome effects
- illness improvement or deterioration

This phase is separate from passive body drift because it resolves **consequences of what just happened**, not just time passing.

Outputs:
- updated health state
- care demand changes
- incapacitation flags
- death/critical crisis checks if the design eventually includes them

---

# Phase 14 - morale, social, and leadership response

Update short- and medium-term social interpretation of the pulse.

Includes:
- fairness perception from rationing/outcomes
- frustration from task interruption
- confidence from successful provision/care
- gratitude after being helped
- resentment from repeated overwork or deprivation
- trust changes after honoring promises or policies
- mentoring/cooperation effects
- social friction from resource conflicts
- belonging drift for outsiders/guests
- leadership legitimacy effects

This phase should avoid being overly volatile.  
Most social changes should be:
- small per pulse
- reinforced by patterns
- more visible in day/week summaries

Outputs:
- morale drift
- relationship drift
- cohesion trend
- retention/attraction trend

---

# Phase 15 - skill gain, knowledge gain, and observation logging

Learning is processed after actual work and outcomes are known.

Includes:
- skill XP or practice accumulation
- quality-of-practice modifier
- interest-aligned motivation bonus
- mentorship/training modifier
- error-based learning opportunity
- discovery observation records
- procedural confidence increase after repeated success
- knowledge misconceptions after repeated low-quality practice
- explicit teaching events
- settlement-level knowledge updates if evidence threshold is reached

This phase should distinguish:
- **individual practice gain**
- **individual discovery/insight**
- **settlement knowledge adoption**
- **codified or shared procedure stabilization**

Outputs:
- updated skills
- updated knowledge confidence
- new discovery candidates
- new teachable procedures
- new institutional practices if evidence/support is sufficient

---

# Phase 16 - allocation, reserve, and stock sufficiency review

Once new stock has landed and consumption has occurred, update the settlement's material posture.

Includes:
- communal stock totals
- protected seed totals
- potable water reserve
- ready food reserve
- fuel reserve
- care supply reserve
- shelter capacity
- bedding/clothing sufficiency
- ration stress level
- scarcity alerts
- over-allocation correction
- reserve breach detection

Outputs:
- scarcity state
- rationing triggers
- emergency reserve warnings
- next-pulse policy hooks

---

# Phase 17 - settlement status and stage checks

Evaluate whether the current site qualifies for:
- primitive camp
- permanent camp
- tiny hamlet
- regression to a weaker state if collapse conditions occur

Use the settlement progression rules already defined:
- shelter reliability
- storage reliability
- food stability
- fuel stability
- potable water routine
- sanitation routine
- labor division
- reserve logic
- year-round viability
- social viability

Important rule:
stage checks should use **smoothed or thresholded evidence**, not a one-pulse spike.

Example:
- a single good day does not make a permanent camp
- one lost food cache should not instantly erase a hamlet if reserves remain
- repeated sanitation failure may delay or reverse stage status

Outputs:
- settlement stage
- stage progress
- warnings about unmet conditions
- unlock flags only where stage logic explicitly permits them

---

# Phase 18 - event generation and scheduling for future pulses

Convert resolved state into future events.

Examples:
- stranger may appear because attraction crossed threshold
- a storm warning event enters queue
- a drying batch will finish in N pulses
- a wound infection review is scheduled
- a structure completion milestone is scheduled
- a teaching session repeat is scheduled
- a water source may become muddy after rain
- morning fire-maintenance reminder/event
- daily ration review event
- seasonal planting window opening

Event scheduling is especially useful for delayed processes rather than checking every possibility every pulse. Event scheduling is a standard pattern in simulation systems where time advancement and delayed triggers must be managed explicitly. citeturn912212search5turn912212search12

---

# Phase 19 - metrics, history, and debug logging

Final phase records what happened.

Recommended metrics:
- NPC body states
- task picks
- task failures
- distance traveled
- hauled mass/volume
- process completions
- spoilage losses
- health incidents
- care burden
- reserve levels
- morale changes
- knowledge gains
- structure state changes
- stage progress

This phase should not mutate live simulation state except for bounded history buffers.

---

# Why this phase order works

The order is designed to answer the most common causal questions.

## Why hazards come before task scoring
Because task suitability must reflect:
- current weather
- current smoke
- current flood/mud
- current path risk
- current water-source condition

## Why body-state drift comes before task scoring
Because a thirsty, freezing, exhausted NPC should not score work the same way as a comfortable one.

## Why reservations come before selection commit
Because the world must know what is still actually available.

## Why movement comes before execution
Because work at a location should require arriving there first.

## Why transfers are separate from execution
Because "picked up", "carried", "placed", and "stored safely" are different states.

## Why health resolution comes after task execution
Because the consequences of carrying, butchering, sleeping, drinking, eating, smoke exposure, and treatment should reflect what just happened.

## Why learning comes after outcomes
Because the game should distinguish:
- successful repetition
- failed repetition
- lucky success
- supervised success
- contaminated/unsafe bad practice
- observed but not understood events

## Why settlement checks come late in the pulse
Because settlement readiness depends on the current, not planned, state of:
- stock
- sanitation
- shelter
- labor patterns
- social stability

---

# NPC activation policy inside a phase

The game should define how multiple NPCs are processed inside phases that touch agents.

Recommended rule:
- use **stable staged phases**
- within an equivalent stage, process NPCs in **rotating or randomized order**
- keep tie-breaking reproducible under a seed

This avoids one permanent list position always eating first, reserving first, or reaching a task first. Random activation order within a stage is a widely used way to reduce systemic bias in agent-based simulation, while a fixed seed keeps runs reproducible for testing. citeturn912212search1turn912212search15turn912212search8

A good practical pattern is:
- stage order fixed
- actor order shuffled per pulse or rotated by pulse index
- deterministic under saved seed

---

# Reservation and ownership invariants

The master loop should enforce the following invariants at all times.

## Invariant 1
An item cannot be:
- consumed
- reserved
- carried
- stored in two places
at the same time.

## Invariant 2
A protected reserve cannot be consumed by normal tasks unless:
- policy explicitly allows it
- emergency override explicitly authorizes it

## Invariant 3
A process requiring occupancy cannot be used by two incompatible tasks at once.

## Invariant 4
Transfer completion must always end with a valid destination or explicit fallback.

## Invariant 5
Task failure must release or adjust reservations cleanly.

## Invariant 6
Ownership and access must be checked before use, not after.

## Invariant 7
Knowledge gains from a process cannot occur if the process never actually reached a meaningful execution state.

---

# Failure and interruption rules

The loop must define what happens when a task becomes invalid midstream.

## Causes of interruption
- source depleted
- tool broke
- task site became dangerous
- weather turned severe
- higher emergency need appeared
- another NPC completed the needed work first
- player forbade the task
- required destination became full
- target item spoiled or became contaminated
- NPC body state crossed hard blocker threshold

## Interruption handling order
1. pause or cancel active execution
2. preserve partial progress if the task/process supports it
3. release invalid reservations
4. retain valid carried items
5. mark fallback state
6. re-enter candidate selection next pulse or immediate emergency handling

Partial progress should be process-specific:
- a half-built wall may persist
- a dropped haul remains where dropped
- a half-boiled batch may cool and fail
- interrupted sleep may give some recovery
- interrupted care may reduce benefit

---

# Event model

The simulation should use both:
- **continuous pulse updates**
- **scheduled future events**

## Continuous pulse is better for:
- body drift
- movement
- spoilage drift
- fire burning
- rain exposure
- drying/cooling
- morale drift
- carried burden

## Scheduled events are better for:
- dawn/dusk transitions
- weather onset/end
- process completion times
- recruitment arrivals
- review checks
- delayed consequences
- periodic policy reviews
- structure completion messages
- settlement stage review moments

This reduces unnecessary repeated checking and keeps delayed causality explicit. Mesa’s documentation explicitly treats event scheduling and time management as a separate concern alongside agent activation. citeturn912212search5turn912212search12

---

# Daily and seasonal review loops

Not every rule should fire every pulse.

# 1. Per-pulse
- body drift
- hazard field update
- task selection/execution
- movement
- process progress
- spoilage progress
- immediate health changes

# 2. Per-hour or light-block
- schedule preference
- rest likelihood
- darkness penalties
- watch duties
- fire-light dependency
- insect pressure
- meal rhythm pressure

# 3. Per-day
- reserve sufficiency audit
- ration policy review
- stage evidence accumulation
- social fairness memory update
- care burden review
- sanitation burden audit
- water routine audit
- recruitment attraction update

# 4. Per-week / multi-day
- cohesion trend
- trust trend
- knowledge stabilization check
- repeated failure pattern audit
- equipment maintenance pattern review
- storehouse effectiveness review

# 5. Per-season
- crop window state
- source reliability shift
- clothing and shelter urgency shift
- winterization urgency
- fuel reserve threshold shift
- settlement resilience re-evaluation

---

# First-playable loop profile

For the earliest implementation slice, the loop can be reduced without changing its logic.

## Keep fully active
- environment refresh
- body drift
- emergency override
- reservations
- task generation
- task scoring/selection
- movement
- execution
- transfers
- spoilage
- hydration/food/sleep outcomes
- simple injury/illness
- skill gain
- simple knowledge discovery
- reserve review
- primitive camp / permanent camp / tiny hamlet checks

## Keep simplified
- social relationship drift
- fairness memory
- outsider integration
- complex contamination chains
- nuanced morale subcomponents
- multi-step mentorship
- multi-layer shelter wear
- complex event queues

## Do not remove
- explicit item locations
- explicit hauling
- explicit reservation
- explicit body-state precedence
- explicit separation of selection vs completion

Those are foundational to the project's identity.

---

# Recommended debug views for this loop

To make this design usable, the game should eventually expose debug layers for:

## 1. Pulse phase panel
Shows current phase and recent mutations.

## 2. NPC reasoning panel
For selected NPC:
- body blockers
- candidate tasks
- scores
- chosen task
- fallback task
- reservation state

## 3. Item flow panel
For selected item/container:
- location
- owner/access state
- reserved by
- contamination/spoilage state
- destination if in haul

## 4. Process panel
Shows:
- active processes
- percent complete
- next commit point
- inputs reserved
- outputs expected

## 5. Reserve panel
Shows:
- potable water
- ready food
- seed reserve
- fuel reserve
- care supply reserve
- shelter capacity

## 6. Settlement stage panel
Shows:
- current stage
- evidence toward next stage
- failing conditions
- recent regressions

## 7. Event queue panel
Shows:
- scheduled events
- trigger times
- source system
- cancellation reason if removed

---

# Anti-patterns to avoid

## 1. Invisible teleportation
Items should not jump from source to consumer with no haul path unless the design later introduces explicit linked utility/network systems.

## 2. Use-before-arrival
Drinking, eating, building, and crafting should not consume resources that are still only planned, not present.

## 3. Double-booking
Two NPCs should not both "own" the same input or workstation.

## 4. Learning detached from practice
Knowledge should not unlock simply because time passed.

## 5. Instant social forgiveness
Repeated unfairness, hunger, danger, and neglect should leave memory.

## 6. Instant settlement upgrade
One temporary burst of resources should not transform the site into a durable settlement.

## 7. Unseeded randomness
Simulation randomness without controlled seeds makes debugging much harder. Reproducibility in stochastic simulations depends on controlled random seeds and defined execution order. citeturn912212search15

---

# Suggested data produced each pulse

Each pulse should be able to output a compact structured summary:

```yaml
pulse_index:
time_of_day:
weather_state:
settlement_stage:
npc_updates:
  - npc_id:
    body_before:
    body_after:
    emergency_override:
    chosen_task:
    task_result:
    moved_distance:
    consumed_items:
    produced_items:
    health_events:
    skill_gains:
    morale_change:
item_transfers:
  - item_id:
    from:
    to:
    reserved_by:
process_updates:
  - process_id:
    progress_before:
    progress_after:
    commit_events:
reserve_snapshot:
  potable_water:
  ready_food:
  seed_reserve:
  fuel_reserve:
  care_supplies:
hazard_snapshot:
  smoke_hotspots:
  wetness_hotspots:
  contamination_hotspots:
  predator_pressure_zones:
queued_events:
  - event_type:
    trigger_time:
```

This is primarily for debugging, testing, and later replay tools.

---

# Relationship to the rest of the design stack

The master loop does not replace the other documents.  
It tells them **when** they act.

## NPC simulation spec
Defines:
- what an NPC is

Master loop defines:
- when NPC state is updated
- when NPC reasoning is recalculated
- when NPC learning/social effects are applied

## Task evaluation spec
Defines:
- how tasks are scored

Master loop defines:
- when candidate tasks are generated
- when blockers are checked
- when the chosen task becomes a reservation
- when execution actually happens

## Item/material + process + structure docs
Define:
- what exists
- how it transforms
- where it can be done

Master loop defines:
- when transforms progress
- when items move
- when spoilage and contamination are checked

## Health + hazard + food/water safety
Define:
- what can harm or heal NPCs

Master loop defines:
- when exposure is sampled
- when passive body drift happens
- when post-action health consequences are resolved

## Allocation + social + recruitment
Define:
- how people share, judge, and join

Master loop defines:
- when rights/claims are checked
- when fairness consequences are updated
- when attraction or integration events are scheduled

## Settlement progression
Defines:
- what counts as a camp, permanent camp, or hamlet

Master loop defines:
- when those checks happen
- what evidence is considered current

---

# Final summary

The correct master loop for this project is not:
"everyone acts whenever."

It is:

1. update time and environment
2. update passive world states
3. update body states
4. enforce emergency survival overrides
5. stabilize reservations and access
6. generate candidate work
7. score work per NPC
8. commit task choice and reservations
9. move NPCs physically
10. execute work
11. resolve transfers
12. advance processes and spoilage
13. resolve health consequences
14. resolve morale/social consequences
15. award skill and knowledge effects
16. review reserves and allocation stress
17. review settlement stage
18. schedule future events
19. record debug/history output

That order keeps the game grounded in:
- embodied labor
- explicit logistics
- believable causality
- settlement realism
- social consequences
- knowledge earned through actual practice

It also fits the original project goal: start with one vulnerable person, bootstrap survival systems, then turn repeated successful work into a believable settlement and, later, a civilization.