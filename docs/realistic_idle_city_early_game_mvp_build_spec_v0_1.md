# Realistic Idle City — Early Game MVP Build Spec v0.1

## 1. Purpose

This document turns the existing early-game design stack into a **buildable MVP specification**.

It is not a new design bible.
It is a practical implementation target for the first playable slice.

The goal is to define:
- what the MVP must include
- what may be simplified without breaking project identity
- what is explicitly deferred
- what order the systems should be implemented in
- what “done enough to move forward” means for the early game

This spec assumes the project remains:
- realism-first
- provenance-based
- top-down in Godot, with minimal object/NPC presentation and richer simulation-derived map rendering where it improves readability
- policy/priority/order driven rather than puppet-control
- focused on the narrow survival-to-hamlet foundation

---

## 2. Current design stance for this MVP

The current working stance for this build is:

**Realism should drive the constraints, but the game must still feel balanced and fun.**

That means:
- do not erase important real bottlenecks just because they are harsh
- do not simulate every real-world detail at full depth on day one
- do not permanently remove major content families if they matter to the fantasy
- instead, choose a narrow slice, implement it clearly, tune it carefully, and defer depth rather than deleting it

Practical translation for this MVP:
- harsh systems should usually become **visible pressure + recoverable failure**, not silent punishment
- content outside the MVP can be **deferred with hooks**, not treated as forbidden forever
- realism should mainly appear through **dependency chains, body-state pressure, logistics, spoilage, sanitation, shelter, weather, and labor limits**
- balance should mainly appear through **clear feedback, tunable rates, readable priorities, sensible reserve buffers, and a fair recovery path after mistakes**

---

## 3. Source-of-truth order for this spec

When this build spec conflicts with other older documents, use this order:

1. latest user instructions in the active chat
2. handoff summary
3. this MVP build spec
4. early-game design docs
5. base design document
6. later-era bridge docs

If a later-era system pushes the scope sideways, it loses.
If realism and fun appear to conflict, keep the real bottleneck but simplify its representation and tune its severity.

---

## 4. MVP build target

The MVP must cover the full early ladder:

1. **Lone Survivor / emergency site**
2. **Primitive Camp**
3. **Permanent Camp**
4. **Tiny Hamlet / proto-settlement**

The MVP is complete when the player can:
- begin with one vulnerable NPC in a realistic early-world scenario
- secure water, sleep, fire, calories, and basic tools
- establish repeatable survival routines instead of desperate one-off actions
- create protected storage, basic preservation, and basic sanitation separation
- begin planning beyond the current day through fuel reserves, seed protection, and first managed plots
- support a second and then a small handful of NPCs
- transition into a tiny hamlet with visible role emergence and fragile but real settlement continuity

The MVP is **not** required to include deeper later-era systems such as metallurgy, formal trade, vehicles, mills, industrial utilities, or city administration.

---

## 5. Canonical MVP scenario assumptions

To keep implementation grounded and avoid endless branching, the first playable should use **one canonical scenario profile**.

### 5.1 Baseline world profile
- Earth-like world
- temperate starting biome
- mixed open/wooded terrain
- nearby fresh water source, but not perfectly safe by default
- stone suitable for primitive cutting/pounding tools
- some clay or mud available within reachable distance
- edible plants present, but not abundant enough to trivialize survival
- small game or similar opportunistic animal food channel present
- rainfall, cold/wet exposure, and spoilage are meaningful threats
- a full seasonal loop exists in simplified form

### 5.2 Why this is mandatory
This prevents the MVP from exploding into biome-general systems too early.
The first build should prove the logic in one believable ecological profile before broadening to many starts.

### 5.3 Implementation rule
Biome variety may exist later, but the first playable should ship with **one default scenario tuned well** rather than many weakly supported starts.

---

## 6. MVP design pillars

### 6.1 Embodied survival first
NPCs are bodies in weather and time before they are economic units.
Hydration, hunger, fatigue, sleep, temperature/wetness, injury, and sickness must visibly affect decisions.

### 6.2 Logistics are real work
Items have locations.
Hauling takes time.
Distance matters.
Containers and storage quality matter.

### 6.3 Repeated routines matter more than one-time actions
The core progression is not “crafted object unlocked.”
It is “repeatable life-support routine established.”

### 6.4 Settlement stage is computed from conditions
Primitive Camp, Permanent Camp, and Tiny Hamlet must be **earned by functioning conditions**, not manually upgraded by button press.

### 6.5 Player leads through intent, not puppeteering
The player sets priorities, permissions, reserve rules, and direct bounded jobs.
NPCs still self-preserve, delay, refuse, or reroute when appropriate.

### 6.6 Balance comes from tuning and clarity
The MVP must remain harsh enough to feel grounded, but legible enough to feel fair.
Use warnings, reserve thresholds, and visible reasons for failure.

---

## 7. Functional scope of the MVP

This section defines the systems that are required, simplified, or deferred.

### 7.1 Required in full for MVP identity
These systems must exist explicitly because removing them would break the project’s core identity.

#### A. Time and simulation pulse
Must include:
- continuous simulation pulse
- hour/day progression
- weather updates
- daylight/night distinction
- seasonal band or seasonal period state
- scheduled review moments for daily checks and settlement checks

Non-negotiable rule:
- planning, travel, hauling, decay, execution, and recovery must all consume time

#### B. Embodied NPC state
Must include at least:
- hydration
- fullness/hunger
- medium-term energy balance or nutrition pressure
- fatigue
- sleep debt / sleep quality effect
- thermal stress
- wetness
- pain/injury
- sickness
- morale
- loneliness/social comfort
- carry load

These states must influence:
- task eligibility
- task scoring
- work speed/quality
- interruption behavior
- recovery need

#### C. Explicit item location and hauling
Must include:
- all items existing at a real world location
- manual hauling tasks
- carrying load classes or equivalent burden logic
- storage destinations / stockpoints
- drop, retrieve, stage, sort, and put-away logic
- travel cost affected by terrain and route length

#### D. Reservation and access control
Must include:
- task input reservation
- target reservation
- prevention of double-booking
- protected reserve categories
- visible reasons when an NPC cannot use a reserved item

#### E. Task generation, scoring, and execution separation
Must include three distinct layers:
- task generation
- task scoring/selection
- task execution

Must-have scoring factors for first playable:
- feasibility
- thirst/hunger/fatigue override
- cold/wetness safety check
- urgency
- player priority
- skill effect
- interest effect
- distance/travel time

#### F. Settlement stage computation
Must include computed state checks for:
- Lone Survivor
- Primitive Camp
- Permanent Camp
- Tiny Hamlet

These checks must evaluate actual conditions such as:
- water routine
- fire continuity
- sleep protection
- storage quality
- preservation capacity
- sanitation separation
- reserve protection
- support for additional people

#### G. Player control layer
Must include:
- global priorities
- allow/forbid toggles
- role preferences
- reserve rules
- direct jobs
- emergency modes

Must preserve from first build:
- self-preservation interruption
- body-state-based deferral
- reserve lock refusal
- visible reason for delay/refusal
- role-fit influence

#### H. Survival-production backbone
Must include real, playable chains for:
- water acquisition -> transport -> treatment -> storage/use
- fuel gathering -> keeping fuel dry -> fire maintenance
- food acquisition -> processing/cooking -> storage/preservation
- shelter creation -> repair -> bedding/sleep quality
- carrying aid creation -> reduced logistic burden
- sanitation zoning -> waste handling -> health pressure reduction
- seed protection -> managed plot preparation -> planting/tending
- clay gathering -> simple pot shaping/firing -> improved storage/carrying

---

### 7.2 Required, but acceptable in simplified form for MVP
These systems must exist, but can be intentionally narrow or shallow in the first build.

#### A. Weather and environment
Required:
- rain/wetness
- temperature band / cold risk
- simple daylight impact
- simple terrain movement cost

Can remain simplified:
- no advanced wind model
- no deep microclimate simulation
- no detailed soil chemistry

#### B. Food and nutrition
Required:
- different food sources behave differently
- raw vs cooked vs preserved states matter
- spoilage pressure exists
- seed stock is separate from ordinary food

Can remain simplified:
- no micronutrient simulation
- no detailed cuisine system
- no advanced recipe combinatorics

#### C. Health and illness
Required:
- simple injury state
- simple sickness state
- contamination or unsafe-water risk represented somehow
- body-state degradation from neglect

Can remain simplified:
- no organ-level simulation
- no deep pathogen taxonomy
- no detailed wound-treatment mini-system

#### D. Social simulation
Required:
- trust/familiarity basics
- loneliness/social comfort
- shared-meal or proximity morale benefit
- simple mentor/apprentice relationship support
- basic conflict pressure or social friction variable

Can remain simplified:
- no deep family trees
- no advanced romance model
- no rich conversation simulation
- no faction politics

#### E. Knowledge and learning
Required:
- skill gain from repetition and successful work
- knowledge seeds or known procedures affecting what can be attempted safely/effectively
- visible improvement over time

Can remain simplified:
- no giant tech tree UI
- no formal research institution
- no multi-stage theory/practice split beyond a few practical flags

#### F. Recruitment and hamlet emergence
Required:
- second and later NPC arrival by mixed event logic
- support/readiness checks before growth feels plausible
- visible role emergence once multiple NPCs exist

Can remain simplified:
- no large migration model
- no formal demographic simulation
- no detailed kinship migration web

---

### 7.3 Explicitly deferred from MVP, but keep hooks where sensible
These are not required for the first playable.
They are **deferred, not denied**.

#### Deferred later-era production and infrastructure
- metallurgy
- mining chain beyond surface/simple stone/clay gathering
- traction animals
- carts/wagons
- mills and water power
- workshops and machine tools
- electrification
- steam systems
- rail
- industrial logistics

#### Deferred economy/governance depth
- formal market economy
- currency systems
- merchant simulation
- taxes and formal law
- large-scale administration
- written records as a major gameplay layer

#### Deferred social depth
- marriage/fertility/children
- multi-household inheritance logic
- formal leadership institutions
- legal punishment systems
- rich ideology/culture/religion layers

#### Deferred combat/defense depth
- advanced combat model
- raids as a major loop
- weapons progression beyond primitive self-protection hooks
- militia command layers

#### Deferred environment/ecology depth
- broad biome roster
- detailed animal population ecology
- multi-year landscape transformation model
- advanced pest simulation

#### Deferred UI depth
- polished tutorial
- rich onboarding narrative
- full production ledger suite
- advanced history browser

Implementation rule:
- if a deferred system needs later data hooks, add the hooks now only if they are cheap and clean
- do not build placeholder subsystems that the MVP does not actively use

---

## 8. Canonical first-playable content subset

This is the minimum content that should exist in data for the MVP.
It may be expanded later, but the project should not ship below this floor.

### 8.1 Minimum items
- clear untreated water
- boiled water
- hammer stone
- sharp flake
- dry twig bundle
- small dry branch
- brush bundle
- crude pole
- edible mixed plants
- raw small game
- cooked meat
- brush bedding
- crude basket
- crude cordage
- hide bag crude
- dried meat simple
- raw clay
- small fired pot
- saved seed mix
- mixed fuelwood bundle

### 8.2 Minimum processes
- scout local area
- collect water
- boil water
- gather deadwood
- clear sleep ground
- build debris lean-to
- build hearth
- gather edible plants
- hunt small game
- butcher small game
- cook food
- make crude basket
- make cordage
- scrape hide
- dry meat
- prepare garden plot
- plant seed
- shape small pot
- fire small pot
- store seed protected

### 8.3 Minimum structures
- cleared sleep spot
- lean-to
- small hearth
- covered cache
- drying rack
- waste pit / cathole area
- clean water area
- improved hut
- small garden plot
- small pottery workspot

### 8.4 Minimum recurring task families
- fetch water
- gather fuel
- maintain fire
- get food
- cook food
- rest
- build shelter
- repair shelter
- make container
- preserve food
- protect seed
- tend garden
- clean camp
- inspect reserve thresholds

### 8.5 Minimum knowledge seeds
- cover stored water
- keep dirty work away from clean water/food
- dry food must stay dry
- seed is not ordinary food
- better bedding improves recovery
- waste near camp worsens risk
- clay needs careful drying and firing
- carrying aids save labor

---

## 9. Required stage gates for the MVP

The stage system is one of the most important realism-to-gameplay bridges in the project.
Each stage must be computed from actual conditions.

### 9.1 Lone Survivor / emergency site
Character:
- one-body survival
- no repeatable infrastructure yet
- survival routines are fragile or absent

The early game begins here.

### 9.2 Primitive Camp
Minimum functional meaning:
- repeated water routine
- repeated fire routine
- at least one dependable sleep area
- at least one intentional storage method
- some dry-fuel protection
- some food preservation
- basic clean/dirty separation
- at least one improved tool chain
- time for improvement work beyond immediate desperation

### 9.3 Permanent Camp
Minimum functional meaning:
- site survives multiple bad-weather days without collapse
- protected food storage exists
- dedicated seed protection exists
- container technology matters
- preservation is repeatable
- camp zoning is explicit
- fuel reserve exists
- planning for next weather or next season exists
- one more person could plausibly be supported

### 9.4 Tiny Hamlet
Minimum functional meaning:
- small multi-person occupancy is sustained
- roles begin to specialize
- communal storage or reserve logic is visible
- guest/newcomer support exists in some form
- routine care, cleaning, cooking, hauling, and maintenance are no longer all one person’s burden
- continuity survives beyond one NPC’s daily capacity

Implementation rule:
- stage transitions should use hard requirements plus a small stability/confidence layer
- stage regression must be possible if key systems collapse

---

## 10. MVP system architecture requirements

This section is intentionally implementation-facing.
It should help the Godot build avoid throwaway architecture.

### 10.1 High-level runtime modules
The first playable should be organized into distinct, future-proof modules.

#### A. SimulationClock
Responsibilities:
- pulse progression
- day/hour tracking
- weather and seasonal checkpoints
- scheduled review triggers

#### B. WorldState
Responsibilities:
- map tiles or cells
- terrain class
- stockpoint and zone locations
- environmental hazards
- route cost inputs

#### C. EntityState
Responsibilities:
- NPC state
- item state
- container state
- structure state
- process/job state

#### D. TaskSystem
Responsibilities:
- generate candidates
- score candidates per NPC
- commit chosen task
- monitor interruption conditions

#### E. ReservationSystem
Responsibilities:
- reserve items, inputs, targets, and destinations
- prevent double-booking
- protect stock classes and reserve locks

#### F. ExecutionSystem
Responsibilities:
- movement
- interaction timers
- transfers
- process completion
- state mutation from task outcomes

#### G. SurvivalSystem
Responsibilities:
- body drift
- hydration/hunger/fatigue/sleep/temperature updates
- simple sickness/injury changes
- recovery

#### H. SettlementSystem
Responsibilities:
- reserve sufficiency checks
- stage evaluation
- camp health/cleanliness summary
- growth/readiness checks

#### I. PlayerIntentSystem
Responsibilities:
- global priorities
- policy toggles
- reserve rules
- direct jobs
- emergency modes

#### J. DebugTelemetrySystem
Responsibilities:
- score breakdown logging
- event history
- stage reason reporting
- reserve warnings
- task interruption reasons

### 10.2 Architecture rules
- keep task templates data-driven
- keep items/processes/structures mostly data-defined
- keep tunable numbers in config tables, not hard-coded across scripts
- separate state mutation from presentation/UI
- preserve distinct phases for generation, scoring, reservation, movement, execution, transfer, and review
- avoid giant “god scripts” that own every simulation concern

### 10.3 Early data objects that must exist
At minimum, support clean data models for:
- NPC
- item
- container
- structure
- zone/stockpoint
- task definition
- task instance
- policy bundle
- reserve rule
- settlement state record
- incident/event record

---

## 11. MVP player-facing controls

These controls are enough to support the fantasy without collapsing into puppeteering.

### 11.1 Minimum controls required
#### Global priorities
- water
- shelter
- food
- fuel
- care
- sanitation
- building

#### Allow / forbid toggles
- exploration
- stranger contact
- reserve use
- risky travel
- nonessential fires

#### Role preferences
- generalist
- water/fuel
- food/prep
- builder/maintainer
- learner

#### Reserve rules
- protect seed
- protect clean water reserve
- protect storm fuel
- protect care stock

#### Direct jobs
- fetch
- haul
- build
- boil
- dry
- repair
- seek shelter
- rest now

#### Emergency modes
- storm
- cold
- injury/care
- contamination/water safety
- fire

### 11.2 Feedback that must be visible
The player must be able to see:
- why an NPC is not obeying immediately
- what body-state pressure is blocking work
- when stock is protected by reserve rules
- why a stage has not advanced
- what alert is currently most dangerous
- which task an NPC chose and why at a coarse level

---

## 12. Must-have UI and debug surfaces

The MVP is simulation-heavy. Without debug and explanation, it will feel unfair.

### 12.1 Required player surfaces
- selected NPC panel
- selected item/container/structure panel
- camp summary panel
- reserve alerts panel
- current stage + next-stage blockers panel
- priorities/policies panel
- minimal task/job panel

### 12.2 Required debug surfaces
- pulse phase panel
- NPC reasoning panel
- item flow panel
- process panel
- reserve panel
- settlement stage panel
- event queue or incident list panel

### 12.3 MVP UI philosophy
The UI does not need to be pretty yet.
It must be:
- dense
- legible
- fast to read
- explicit about causality

---

## 13. Balance stance for the MVP

Because the user wants realism **and** fun, the build should obey these balance rules.

### 13.1 Preserve real bottlenecks
Do not remove:
- hauling burden
- travel time
- wetness/cold danger
- food spoilage
- dirty vs clean separation
- reserve depletion anxiety
- the cost of supporting more people

### 13.2 Soften through legibility, not fantasy shortcuts
Prefer these solutions:
- warnings before collapse
- visible reserve thresholds
- tutorial text later, but immediate alerts now
- clear task reasons
- forgiving restart/recovery windows early in tuning
- player-visible policy tools to mitigate risk

Avoid these shortcuts:
- teleporting items
- instant perfect obedience
- fire that never needs fuel continuity
- food that only disappears through a generic hunger drain
- stage upgrades granted by button press rather than living conditions

### 13.3 Use tuning bands, not one-off hand edits
The MVP should expose configurable values for later balancing, including:
- hydration drain
- hunger drain
- fatigue accumulation
- wetness gain/loss
- fire fuel consumption
- spoilage timers
- sickness risk rates
- hauling burden thresholds
- reserve warning thresholds
- stage confidence thresholds
- event frequency

### 13.4 Failure should teach, not only punish
A good early failure should tell the player something like:
- “fuel stayed wet”
- “water was not protected”
- “food spoiled before storage improved”
- “seed was eaten”
- “camp zones overlapped and sickness risk rose”
- “one worker could not maintain all routines”

That keeps realism while still supporting good game feel.

---

## 14. Concrete implementation order

This is the recommended build order.
The order is chosen to minimize rework and preserve the project’s identity.

### Phase 0 — Foundation skeleton
Build first:
- SimulationClock
- WorldState basics
- NPC/item/structure/task data models
- simple path/travel-cost support
- ReservationSystem skeleton
- DebugTelemetry skeleton

Deliverable:
- one NPC and a few loose world objects can exist in time and space

### Phase 1 — Lone survivor core loop
Build next:
- body drift for hydration, hunger, fatigue, wetness, temperature, sleep
- task generation/scoring/execution foundation
- basic movement and hauling
- water fetch/drink
- gather plants/basic calories
- gather branches/stones
- emergency sleep/rest
- simple shelter creation
- simple fire/hearth creation and maintenance

Deliverable:
- one NPC can survive or die based on readable survival decisions

### Phase 2 — Primitive camp formation
Build next:
- intentional stockpoints / storage
- keep-fuel-dry logic
- basic cooking
- spoilage basics
- basic preservation via drying
- sanitation zone separation
- bedding quality effect
- reserve warnings
- Primitive Camp stage check

Deliverable:
- the site can become a functioning Primitive Camp through repeatable routines

### Phase 3 — Permanent camp systems
Build next:
- improved shelter/hut
- covered cache and better protected storage
- container meaning: basket, hide bag, pot
- seed protection rules
- basic garden plot preparation and planting/tending
- clay gathering, pot shaping, simple firing
- bad-weather resilience checks
- Permanent Camp stage check

Deliverable:
- the site can survive several bad days and begin next-cycle planning

### Phase 4 — Multi-NPC and hamlet formation
Build next:
- second and third NPC arrival/event support
- role preferences and role-fit scoring bonus
- simple trust/familiarity and loneliness relief
- communal work splitting
- direct jobs plus reserve rules at multi-NPC scale
- communal/strategic stock distinction
- Tiny Hamlet stage check

Deliverable:
- multiple NPCs can sustain a fragile proto-settlement with visible specialization

### Phase 5 — MVP hardening and tuning
Build next:
- critical alerts and blocker explanations
- stage regression handling
- interruption polish
- task score breakdown visibility
- balance/config cleanup
- content tuning for rough fairness

Deliverable:
- the MVP feels harsh but understandable rather than arbitrary

---

## 15. Minimum acceptance bar for “MVP complete”

The MVP should count as complete only if all of the following are true.

### 15.1 Simulation integrity
- items do not teleport
- tasks do not consume unavailable inputs
- two NPCs do not successfully use the same reserved item at once
- body-state overrides can interrupt player intent when necessary
- travel and hauling meaningfully affect outcomes

### 15.2 Survival playability
- a competent player can stabilize one NPC into Primitive Camp reliably
- a poor start or poor decisions can still fail
- failure usually has a visible cause
- water, fire, sleep, calories, and shelter all matter in practice

### 15.3 Settlement progression
- Primitive Camp can be reached through real conditions
- Permanent Camp can be reached through real conditions
- Tiny Hamlet can be reached through real conditions
- stages can regress when key support systems collapse

### 15.4 Multi-NPC viability
- additional NPCs are not just more hands; they also add consumption burden
- role emergence changes camp performance in understandable ways
- loneliness/social comfort changes behavior at least lightly

### 15.5 UI legibility
- the player can see the camp’s current bottleneck
- the player can see reserve pressure
- the player can understand the main reason a task was delayed or refused
- the player can see why the next stage is blocked

---

## 16. Explicit anti-patterns to avoid during MVP development

Do not do these, even temporarily, unless there is no other way to unblock a prototype.

### 16.1 Simulation anti-patterns
- invisible teleport hauling
- use-before-arrival
- instant task completion without location/time logic
- one giant worker script handling every system
- hard-coded stage upgrades
- item spawning that bypasses provenance without clear world reason

### 16.2 Control anti-patterns
- total puppet control
- infinite player override with no NPC self-preservation
- hidden reserve rules
- silent refusals with no explanation

### 16.3 Balance anti-patterns
- punishing illness or collapse with no warning surface
- making storage/sanitation decorative
- solving fun problems by deleting bottlenecks instead of tuning them
- adding lots of content before the narrow loop feels good

---

## 17. What this spec intentionally does not finalize

This build spec does **not** finalize:
- the exact numerical constants
- the complete shared data dictionary
- the full state machine diagrams
- the complete acceptance/test matrix
- final UI wireframes
- save/load schema

Those belong in the next companion documents.

---

## 18. Immediate next documents after this one

After this build spec, the best follow-up documents are:

1. **Unified Data Dictionary v0.1**
   - canonical IDs
   - enums
   - field names
   - item/process/structure/task naming

2. **Balance / Constants Sheet v0.1**
   - hydration, hunger, fatigue
   - spoilage
   - hauling thresholds
   - reserve warnings
   - stage confidence

3. **System Flow / State Machine Pack v0.1**
   - NPC daily loop
   - task lifecycle
   - item state transitions
   - settlement stage evaluation flow

4. **Acceptance Criteria / Test Checklist v0.1**
   - debug scenarios
   - pass/fail cases
   - regression traps

---

## 19. Final summary

The MVP is not “a little prototype with some gathering.”
It is a narrow but complete **survival-to-hamlet foundation**.

The build should prove that this game’s identity works in play:
- one vulnerable body in a real environment
- explicit objects and labor
- water, fire, shelter, food, sleep, storage, and sanitation as interlocking systems
- repeated routines becoming settlement continuity
- continuity becoming support for more people
- early specialization emerging from real constraints

The discipline for this phase is simple:

**Do not expand sideways.**
**Build the narrow loop cleanly.**
**Keep realism in the constraints and fun in the readability, tuning, and recovery.**
