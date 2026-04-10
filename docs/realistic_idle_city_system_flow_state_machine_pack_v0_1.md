# Realistic Idle City — System Flow / State Machine Pack v0.1

## 1. Purpose

This document turns the existing early-game design stack into implementation-facing runtime flows.

It defines the canonical early-game state machines for:
- the NPC daily loop
- emergency override behavior
- task lifecycle
- direct-order lifecycle
- item/location transitions
- process execution
- health escalation and recovery
- settlement stage checks

This pack is meant to sit between the design documents and actual Godot code.
It does **not** replace the more detailed design specs; it compresses them into a runtime model that can be built.

---

## 2. Scope

This pack covers the first playable slice only:
- Lone Survivor / emergency site
- Primitive Camp
- Permanent Camp
- Tiny Hamlet

It assumes the MVP remains:
- realism-first
- balance-tuned rather than realism-erased
- policy/priority/order driven
- explicit about hauling, reservation, location, spoilage, and body-state pressure
- centered on survival-to-hamlet progression

This pack does **not** finalize:
- late-game factory chains
- advanced diplomacy/politics
- full village law/administration depth
- detailed childbirth/childcare
- deep combat formation logic
- continent-scale logistics

---

## 3. Source-of-truth order

When this document conflicts with older material, use this order:

1. latest user instructions in the active chat
2. handoff summary
3. early-game MVP build spec
4. unified data dictionary
5. balance / constants sheet
6. this state-machine pack
7. older early-game design docs
8. later-era bridge docs

Practical rule:
- this pack defines **runtime behavior shape**
- the unified data dictionary defines **names and enum IDs**
- the balance sheet defines **threshold numbers and timing**

---

## 4. Runtime doctrine

### 4.1 Selection is not completion

The simulation must keep the following separate:
- deciding to do work
- reserving what the work needs
- walking to the work
- setting up the work
- executing the work
- moving outputs
- achieving the intended outcome

### 4.2 Bodies outrank plans

A standing order, role preference, or nice production chain does not outrank:
- imminent dehydration
- collapse-level fatigue
- dangerous cold/wet exposure
- active fire threat
- immediate contamination or injury crisis

### 4.3 Matter must stay somewhere real

Every meaningful item/batch must always be in a real state such as:
- in world source
- harvested at source
- in transit
- staged
- stored
- reserved
- issued
- processing
- waste/salvage/quarantine
- lost/spoiled/destroyed

### 4.4 Progression is computed, not purchased

Settlement stage must be determined by repeated functioning conditions, not by a manual upgrade button.

### 4.5 Realism stays through consequences, not micromanagement

The player influences:
- priorities
- permissions
- reserve rules
- role preferences
- direct jobs
- emergency doctrines

The player does not bypass:
- route length
- bodily limits
- spoilage
- unsafe water
- missing tools
- missing knowledge
- reserve locks

---

## 5. Time cadence used by this pack

The recommended MVP cadence remains:
- **simulation pulse:** 1 minute
- **hour review:** every 60 pulses
- **day review:** once per day boundary
- **multi-day review:** every 3–7 days depending on system
- **seasonal review:** at season boundary or weather-period transition

### 5.1 What belongs in the 1-minute pulse

Run every pulse:
- movement progress
- body-state drift
- task execution progress
- fire burn / fuel consumption
- spoilage increments
- contamination/wetness/exposure increments
- reservation validity checks
- interruption checks
- immediate alert generation

### 5.2 What belongs in hour review

Run hourly:
- light/dark influence updates
- sleep-window preference changes
- scheduled routine prompts
- task desirability shifts from time-of-day
- local route congestion simplification if used

### 5.3 What belongs in day review

Run daily:
- reserve sufficiency checks
- settlement-stage metrics refresh
- morale trend updates
- hygiene/sanitation burden review
- water and food throughput summaries
- labor bottleneck summaries

### 5.4 What belongs in multi-day / seasonal review

Run every few days or seasonally:
- repeated failure pattern checks
- weather-readiness checks
- seed and planting readiness checks
- resilience checks for stage promotion/regression
- newcomer attraction and retention pressure

---

## 6. Authoritative pulse flow

Use this as the canonical order.
The phases below intentionally match the logic already established in the simulation-loop spec, but they are restated here as implementation guidance.

```text
Phase 0  resolve scheduled time triggers
Phase 1  refresh environment and local hazard fields
Phase 2  update structures, fire, containers, and passive infrastructure
Phase 3  apply passive body-state drift
Phase 4  inject self-preservation and emergency overrides
Phase 5  refresh claims, reservations, permissions, and locks
Phase 6  generate current task opportunities
Phase 7  evaluate tasks per NPC
Phase 8  commit chosen tasks and reserve inputs/targets
Phase 9  advance movement and positioning
Phase 10 run setup / interaction / active execution
Phase 11 resolve transfers and placement
Phase 12 resolve process completion, output generation, spoilage, contamination
Phase 13 resolve health escalation, injury, illness, and recovery
Phase 14 resolve morale/social reactions
Phase 15 grant skill/knowledge/observation updates
Phase 16 review reserves and stock sufficiency
Phase 17 evaluate settlement status and stage gates
Phase 18 create/schedule future events
Phase 19 write metrics/debug/history output
```

### 6.1 Why this order stays mandatory

This order preserves:
- environment before choice
- body pressure before labor scoring
- reservation before execution
- travel before work completion
- item transfer after actual work
- health results after what really happened
- learning after outcomes
- stage checks after daily realities, not before

---

## 7. NPC macro daily loop

This is the outer state machine for a living NPC.
It is not a rigid schedule. It is a continuously re-evaluated operating loop.

### 7.1 State list

Canonical macro states:
- `sleeping`
- `waking`
- `self_maintenance`
- `evaluating`
- `moving`
- `setting_up`
- `working`
- `micro_recovering`
- `socializing`
- `idle_safe`
- `assisting_care`
- `receiving_care`
- `fleeing`
- `collapsed`
- `dead`

### 7.2 Macro flow

```text
sleeping
  -> waking
  -> self_maintenance
  -> evaluating
  -> moving
  -> setting_up
  -> working
  -> micro_recovering
  -> evaluating

At any point:
  -> fleeing
  -> receiving_care
  -> collapsed
  -> dead
```

### 7.3 State intent and transition rules

#### A. `sleeping`
Entry when:
- fatigue/sleep pressure wins task competition
- player ordered rest and no emergency blocks it
- night behavior and body condition support sleep

Exit when:
- sleep target met enough to wake naturally
- danger/hazard interrupts
- severe thirst, cold, pain, smoke, or crowding interrupts
- another NPC wakes the sleeper for emergency care/event

Notes:
- sleep quality is modified by shelter, bedding dryness, warmth, crowding, noise, safety, and pain
- do not make sleep binary; bad sleep should partially restore and partially fail

#### B. `waking`
Very short transition state.
Used to:
- apply wake-up delay
- recalculate body condition
- spawn first immediate self-maintenance needs

Typical exits:
- to `self_maintenance`
- directly to `fleeing` if a new hazard is active

#### C. `self_maintenance`
Handles personal needs such as:
- drink
- eat
- warm self
- dry off
- quick rest
- use latrine area
- self-bandage

Exit when:
- urgent body tasks are resolved below override threshold
- needed action is impossible, forcing help-seeking or degraded work
- emergency task supersedes

#### D. `evaluating`
Decision state.
The NPC gathers candidate tasks, filters blockers, scores them, and selects one or falls back.

Exit when:
- a task is selected -> `moving` or `setting_up`
- no good task exists -> `idle_safe`
- body emergency appears -> `self_maintenance`, `fleeing`, or `receiving_care`

#### E. `moving`
Represents route-following toward:
- a target worksite
- an item to pick up
- a safe shelter
- a water/fire/care point

Exit when:
- destination reached -> `setting_up` or immediate `working`
- interruption condition hits -> reevaluate
- route invalidates -> reevaluate
- danger appears -> `fleeing`

#### F. `setting_up`
Short preparatory state for multi-step work.
Examples:
- placing materials
- drawing water vessel near fire
- taking tool in hand
- clearing a work spot
- orienting at drying rack

Exit when:
- prerequisites are ready -> `working`
- missing tool/material discovered -> reevaluate
- hazard/body emergency interrupts

#### G. `working`
The active execution state.
Includes:
- gathering
- hauling
- boiling
- tending fire
- building
- processing food
- making cordage or basket
- shaping clay
- cleaning camp
- care actions for self/others

Exit when:
- task completes -> `micro_recovering` or `moving`
- task enters passive wait stage -> `evaluating`
- body emergency or hazard interrupts -> reevaluate/flee/care
- task becomes impossible -> reevaluate

#### H. `micro_recovering`
Short state after meaningful exertion.
Used to model:
- catching breath
- posture reset
- minor handoff delay
- quick morale/body recalculation

Exit almost always to `evaluating`.

#### I. `socializing`
Very light MVP state.
Represents:
- talking near fire
- checking on another NPC
- small morale-support action
- confidence/trust maintenance

Only selected when:
- no urgent body need dominates
- work pressure is moderate enough
- social strain is meaningful

#### J. `idle_safe`
Fallback state.
Not “do nothing forever.”
Represents low-value waiting or staying near safe area when no action clears thresholds.

Used when:
- all feasible tasks score below threshold
- conditions advise waiting for daylight/weather/help
- the NPC should remain available for likely soon-to-trigger work

#### K. `assisting_care`
Dedicated care-work state for helping another NPC.
Includes:
- bringing water
- warming support
- moving bedding
- washing wound
- escorting to shelter

#### L. `receiving_care`
For impaired NPCs who cannot fully self-manage.
Priority is:
- survival stabilization
- warmth/dryness
- hydration
- rest/safe placement
- wound/illness support

#### M. `fleeing`
Immediate danger state.
Used for:
- fire spread
- severe exposure spike
- hostile animal threat
- smoke/toxic zone
- structure collapse risk

Exit when safe destination is reached and panic pressure falls enough to reevaluate.

#### N. `collapsed`
Entered when body condition drops below functional threshold.
The NPC cannot perform ordinary work.
Can only:
- receive care
- crawl/minimal movement if implemented
- continue deteriorating
- slowly recover if conditions improve

#### O. `dead`
Terminal state.
No ordinary transitions out.
Creates body/carcass, grief, sanitation, and settlement-shock effects.

### 7.4 Emergency override ladder

This override ranking should be checked every pulse after passive body-state drift:

1. immediate life threat
2. severe self-preservation need
3. dependent/nearby care emergency
4. active emergency order / colony emergency mode
5. strong direct order if still feasible and safe
6. role-driven colony work
7. opportunistic or training work
8. social/low urgency work

This ladder is the core realism guardrail.
It prevents the colony from feeling like mind control.

---

## 8. Task lifecycle state machine

This is the canonical runtime lifecycle for a task record.
Use `task_status` from the unified dictionary.
Canonical enum strings come from the Unified Data Dictionary unless this document is providing the more detailed runtime explanation that the dictionary mirrors.

### 8.1 Canonical task states

Recommended states:
- `generated`
- `screened_out`
- `candidate`
- `scored`
- `selected`
- `reserved`
- `in_transit`
- `setup`
- `active`
- `passive_wait`
- `blocked`
- `interrupted`
- `completed`
- `partial_success`
- `failed`
- `cancelled`
- `expired`

### 8.2 Core flow

```text
generated
  -> screened_out | candidate
candidate
  -> scored
scored
  -> selected | screened_out
selected
  -> reserved
reserved
  -> in_transit | setup | blocked
in_transit
  -> setup | active | interrupted | blocked
setup
  -> active | blocked | interrupted
active
  -> completed | partial_success | passive_wait | interrupted | failed
passive_wait
  -> active | completed | failed | expired
blocked
  -> candidate | failed | expired | cancelled
interrupted
  -> candidate | blocked | failed | cancelled
```

### 8.3 State meanings

#### `generated`
Created by:
- body need pressure
- stock deficit
- weather/hazard trigger
- process follow-up
- direct order decomposition
- routine schedule
- event script

#### `screened_out`
Exists for debugging/logging but is not actionable.
Reasons include:
- impossible route
- missing tool
- missing knowledge
- reserve lock
- forbidden by policy
- outside allowed zone
- too injured/exhausted

#### `candidate`
Eligible for scoring this evaluation pass.

#### `scored`
Has a full score breakdown attached.
This should be visible in debug tools.

#### `selected`
Chosen by one NPC for attempted execution, but not yet safe to begin.

#### `reserved`
Required item(s), target(s), workspace(s), or worker slot(s) are locked.
A task must not move to active execution without reservation success unless explicitly marked as reservation-free.

#### `in_transit`
Worker is walking toward the work or pickup point.
No outputs are produced yet.

#### `setup`
Worker is preparing the local situation.
Still no full output yet.

#### `active`
Actual work or active interaction is happening.

#### `passive_wait`
For tasks/processes that have an active stage followed by time-based waiting.
Examples:
- sediment settling
- vessel drying
- food drying/smoking interval
- ember preservation window

#### `blocked`
Temporarily cannot proceed because something changed.
Examples:
- rain soaked the fuel
- another process still occupies the rack
- clean water pot filled beyond capacity
- missing follow-up input

#### `interrupted`
Stopped by higher-priority condition.
Examples:
- severe thirst
- storm mode
- fire spread
- care emergency
- player cancellation

#### `completed`
Primary success state.
Outputs placed, status finalized, reservations released.

#### `partial_success`
Important realism state.
Examples:
- some food dried, some spoiled
- partial structure progress achieved
- some water delivered, not all
- carcass recovered but butcher quality poor

#### `failed`
Task ended with no valid intended result.
May still consume:
- time
- inputs
- morale
- condition
- cleanliness

#### `cancelled`
Explicitly stopped by player/system.

#### `expired`
No longer relevant.
Examples:
- weather window passed
- spoilage made input useless
- another task satisfied the need first

### 8.4 Mandatory task invariants

1. a task may have a plan without changing matter state
2. a task may not consume reserved inputs twice
3. a task may not complete before route and setup requirements are satisfied
4. interruption must preserve or release reservations explicitly
5. blocked tasks must log why they are blocked
6. partial success must be legal for early survival work
7. body-state overrides may supersede any non-life-critical task

### 8.5 Interruption handling order

When interruption triggers, resolve in this order:

1. freeze or stop progress
2. decide whether current outputs/inputs remain valid
3. keep or release reservations according to task type
4. write interruption reason
5. send NPC back to evaluation or emergency state
6. requeue follow-up cleanup or rescue tasks if needed

### 8.6 Reservation retention rules

Use these default rules:
- short interruption, same worker, same nearby task -> keep reservation briefly
- long interruption or worker incapacitated -> release reservation
- dangerous contamination/risk state -> quarantine affected target instead of ordinary release
- strategic reserve item -> never auto-release into general use without explicit logic

---

## 9. Direct-order lifecycle

Direct orders are not separate from the task system.
They feed it.

### 9.1 Canonical order states

Recommended states:
- `issued`
- `interpreted`
- `blocker_check`
- `accepted`
- `deferred`
- `rejected`
- `decomposed`
- `task_bound`
- `executing`
- `interrupted`
- `completed`
- `failed`
- `expired`
- `reported`

### 9.2 Order flow

```text
issued
  -> interpreted
  -> blocker_check
  -> accepted | deferred | rejected
accepted
  -> decomposed
  -> task_bound
  -> executing
  -> interrupted | completed | failed | expired
  -> reported
```

### 9.3 Blocker checks that stay mandatory

A direct order can still be blocked by:
- impossible route
- missing item/tool
- unsafe exposure
- collapse risk
- protected reserve lock
- contradictory emergency doctrine
- missing knowledge for safe execution
- worker already in higher emergency mode

### 9.4 Override strength guidance

Use four practical strength bands:
- soft order
- normal order
- strong order
- emergency order

Even emergency orders do not override hard physical impossibility.

### 9.5 Reporting rules

Every non-trivial order should report one of:
- completed as intended
- completed with compromise
- delayed and why
- refused and why
- failed and why
- interrupted by life-safety override

This is one of the main fairness tools in a harsh realism game.

---

## 10. Item / location state machine

This is the core state machine that keeps logistics believable.
It should be used for item batches as well as single special items when appropriate.

### 10.1 Canonical location states

Use the location-state model already established for the project:
- `in_world_source`
- `harvested_at_source`
- `claimed_in_transit`
- `temporarily_staged`
- `stored_at_stockpoint`
- `reserved_locked`
- `issued_to_person_or_worksite`
- `being_processed`
- `waste_salvage_quarantine`

### 10.2 Core flow

```text
in_world_source
  -> harvested_at_source
  -> claimed_in_transit
  -> temporarily_staged
  -> stored_at_stockpoint
  -> reserved_locked
  -> issued_to_person_or_worksite
  -> being_processed
  -> temporarily_staged
  -> stored_at_stockpoint | waste_salvage_quarantine
```

### 10.3 State meanings

#### `in_world_source`
Still part of the terrain/world source.
Examples:
- standing berry patch
- branch on ground not yet claimed
- clay in bank
- water at source point

#### `harvested_at_source`
Separated from source but not yet moved meaningfully.
Examples:
- cut branches lying where gathered
- filled vessel still at stream edge
- butchered carcass pieces still at kill site

#### `claimed_in_transit`
Assigned to worker/haul job and moving.

#### `temporarily_staged`
Realistic and important.
Examples:
- wet wood near hearth
- raw meat at processing zone
- clay near shaping mat
- bedding bundle left near shelter

#### `stored_at_stockpoint`
Intentionally placed in a governed storage location.
Examples:
- firewood stack
- clean-water vessel zone
- seed reserve jar
- dry goods basket

#### `reserved_locked`
Protected for a task, process, or reserve rule.
Not available to general pull.

#### `issued_to_person_or_worksite`
Assigned for immediate routine use.
Examples:
- knife carried by worker
- basket at gatherer
- kindling stack at hearth buffer
- scraper left at hide beam

#### `being_processed`
Under transformation.
Examples:
- water being boiled
- meat on drying rack
- hide being stretched
- clay vessel in drying stage

#### `waste_salvage_quarantine`
Important sink state.
Examples:
- spoiled food
- contaminated bandage
- scrap bone pile
- salvageable sherds
- dirty carcass waste


### 10.4 Overlay conditions separate from location state

Do **not** overload location state with condition overlays.
Track separately:
- cleanliness / contamination
- wetness / dryness
- temperature exposure
- spoilage progress
- fuel usability
- pest exposure
- quarantine flag

### 10.5 Storage transition rules

1. storing is a real transfer, not an instant metadata flip
2. reserve protection is a separate step from ordinary storing
3. staged goods can degrade faster than stored goods
4. processing may output multiple location states at once
5. waste/salvage must still have a location until destroyed/removed

### 10.6 Example item transition chains

#### Water chain
```text
water at source
  -> collected untreated
  -> hauled
  -> staged raw water vessel
  -> being processed (settling / boiling)
  -> staged potable vessel
  -> stored potable water stockpoint
  -> issued for drink/cooking/care
```

#### Fuel chain
```text
branch/wood source
  -> harvested at source
  -> hauled
  -> staged near camp
  -> dried/protected storage
  -> issued to hearth buffer
  -> consumed by fire
  -> ash/waste
```

#### Food chain
```text
wild plant / carcass source
  -> harvested/recovered
  -> staged dirty processing area
  -> being processed
  -> staged ready food / preservation work
  -> stored protected food
  -> issued for meal or reserve
  -> eaten / spoiled / waste
```

---

## 11. Process execution state machine

Tasks are what NPCs do.
Processes are the larger transformations those tasks support.

### 11.1 Recommended process states

Recommended states:
- `planned`
- `waiting_inputs`
- `setup`
- `active_work`
- `passive_progress`
- `paused`
- `completed`
- `failed`
- `salvageable_failure`
- `cancelled`

Canonical enum strings come from the Unified Data Dictionary.
This section is the more detailed runtime explanation that the dictionary mirrors.

### 11.2 Core flow

```text
planned
  -> waiting_inputs
waiting_inputs
  -> setup | cancelled
setup
  -> active_work | paused | failed | cancelled
active_work
  -> passive_progress | completed | failed | salvageable_failure | paused | cancelled
passive_progress
  -> active_work | completed | failed | salvageable_failure | paused | cancelled
paused
  -> setup | active_work | cancelled | failed
```

### 11.3 State meanings

#### `planned`
The process is desired by need, stock target, schedule, or order.

#### `waiting_inputs`
Not enough inputs or conditions exist yet.
Examples:
- no dry fuel for boiling
- no clean cloth for wound care
- no free drying rack slot

#### `setup`
Everything needed is in place.
The next worker can begin without extra staging.

#### `active_work`
A worker is performing the active labor portion.
Examples:
- chopping/gathering
- boiling
- shaping clay
- tending smoke fire
- building shelter segment

#### `passive_progress`
The process continues in time with reduced or no active labor.
Examples:
- sediment settling
- vessel drying
- rack drying interval
- ember holding window

#### `paused`
Temporarily stopped without full failure.
Examples:
- rain interrupts but food can still be saved
- worker pulled to emergency but process remains recoverable

#### `completed`
Outputs produced and follow-up tasks may spawn.

#### `failed`
Primary intended result lost.
Examples:
- pot cracks beyond use
- water recontaminated and not safe
- food rots fully

#### `salvageable_failure`
Very important for realism and fun.
Examples:
- cracked pot becomes sherd salvage
- smoke run poor but still yields lower-quality preserved food
- hide dries poorly but still usable for rough work


### 11.4 Interruption classes

Use three interruption classes:
- **safe_interrupt**: easy to stop and resume
- **costly_interrupt**: resumes with penalty or quality loss
- **dangerous_interrupt**: likely failure, contamination, or fire risk if abandoned

Suggested examples:
- gather fuel -> safe_interrupt
- scouting -> safe_interrupt
- hauling staged material -> safe_interrupt
- hide working at key moisture stage -> costly_interrupt
- vessel shaping -> costly_interrupt
- controlled smoking -> dangerous_interrupt
- active boiling -> dangerous_interrupt
- butchering in dirty/risky conditions -> dangerous_interrupt

### 11.5 Follow-up task spawning rules

A process may spawn follow-up tasks when:
- outputs need hauling
- cleanup is required
- contamination risk rose
- passive stage finished
- reserve stock target is still unmet
- failure produced salvage/waste

---

## 12. Health escalation and recovery state machines

Health should not be a single HP bar.
Use interacting state machines with a shared escalation grammar.

## 12.1 Shared escalation grammar

Most early health domains should follow this shape:

```text
stable
  -> strained
  -> impaired
  -> severe
  -> critical
  -> collapsed / incapacitated
  -> death   (only for the harshest unresolved states)
```

Recovery usually flows back more slowly:

```text
critical/severe
  -> impaired
  -> strained
  -> stable
```

### 12.1.1 Global rules

1. worsening can be fast; recovery should usually be slower
2. care quality changes slope, not only direction
3. poor shelter, wetness, contamination, and fatigue amplify other domains
4. multiple moderate problems together should be dangerous
5. severe states should create automatic tasks and alerts

## 12.2 Hydration state machine

States:
- `hydrated`
- `needs_drink`
- `thirsty`
- `dehydrated`
- `severely_dehydrated`
- `collapse_risk`

Escalation drivers:
- time without drinking
- heat
- heavy labor
- long hauling
- fever
- vomiting / diarrhea

Recovery drivers:
- drinking safe water
- rest
- shade/cooling if hot
- reduced exertion
- illness treatment if fluid loss persists

Key automatic transitions:
- `thirsty` -> spawn urgent water/drink task
- `dehydrated` -> heavy work penalties and strong override
- `severely_dehydrated` -> cancel nonessential work, prioritize immediate safe drinking/care
- `collapse_risk` -> may enter `collapsed`

## 12.3 Fatigue / sleep state machine

States:
- `rested`
- `tired`
- `fatigued`
- `very_fatigued`
- `exhausted`
- `collapse_risk`

Escalation drivers:
- wake time
- heavy exertion
- cold/wet exposure
- pain
- poor-quality sleep
- repeated interruptions

Recovery drivers:
- sleep
- high-quality sleep environment
- short rest for minor states
- warmth/dryness
- food/water support

Key behavior:
- `fatigued` reduces score for long/risky/precision tasks
- `very_fatigued` pushes sleep/rest strongly
- `exhausted` increases accident and morale penalties sharply
- `collapse_risk` may force rest or collapse even against orders

## 12.4 Thermal and wetness burden state machine

Track two related axes:
- wetness state
- thermal stress state

### Wetness states
- `dry`
- `damp`
- `wet`
- `soaked`

### Thermal stress states
- `thermally_stable`
- `cold_strained`
- `cold_impaired`
- `severe_cold`
- `critical_cold`

Drivers:
- rain
- immersion
- sleeping exposed
- poor shelter
- inadequate fire continuity
- lack of bedding/clothing later

Recovery:
- move to shelter
- fire/warm zone
- dry body and bedding
- reduce exposure time

Important rule:
wetness should amplify fatigue, morale loss, sleep failure, and illness risk even before becoming critical cold.

## 12.5 Injury / pain / impairment state machine

### Injury severity states
- `none`
- `minor`
- `moderate`
- `serious`
- `severe`
- `incapacitating`

### Pain/impairment states
- `none`
- `noticeable`
- `work_limited`
- `severe`
- `incapacitating`

Drivers:
- accidents during work
- falls/slips
- tool misuse
- fire/burn incident
- animal attack

Recovery drivers:
- rest
- warmth
- hydration/food support
- wound cleaning and wrapping
- reduced strain
- assisted care for severe cases

Important rule:
injury severity and pain are related but not identical.
A moderate wound can produce high impairment if badly placed or contaminated.

## 12.6 Contamination / wound infection risk flow

States:
- `clean`
- `dirty`
- `contaminated`
- `infection_risk_high`
- `infected`

Drivers:
- dirty handling
- poor wash water
- carcass work near living area
- untreated wound contact
- filthy bedding/clothing

Recovery:
- cleaning
- better care conditions
- protected dressing
- rest and nutrition support

This flow should be slower than immediate injuries, but more likely to snowball if camp discipline is poor.

## 12.7 Illness severity flow

States:
- `well`
- `unwell`
- `sick`
- `seriously_sick`
- `critical`

Early causes:
- unsafe water
- spoiled food
- prolonged wet/cold stress
- respiratory irritation from smoke
- wound infection spillover

Gameplay use:
- illness reduces labor availability
- increases care load
- destabilizes water/food throughput
- can delay or reverse settlement progression

## 12.8 Recovery reserve state

This is the domain that says whether healing is even plausible.

States:
- `supported`
- `strained`
- `poor`
- `failing`

Recovery reserve is shaped by:
- warmth
- hydration
- calories / nourishment
- sleep quality
- cleanliness
- care attention
- stress load

This is why a better camp heals injuries faster without any magical medicine.

## 12.9 Care response state machine

When severe health pressure is detected, use this care flow:

```text
alerted
  -> self_care | assisted_care | watch_care
  -> stabilized | not_stabilized
  -> ongoing_recovery | deterioration
```

### Care modes
- `self_care`: mild impairment, can still act
- `assisted_care`: another NPC actively supports
- `watch_care`: low-active supervision, periodic checks

### Care priorities
1. move to safety / shelter
2. warmth and dryness
3. safe water
4. stop contamination / basic wound handling
5. rest support
6. food and morale support

---

## 13. Settlement stage evaluation flow

Settlement stage is computed from functioning conditions and resilience, not from asset count alone.

### 13.1 Core stage states

- `stage.lone_survivor`
- `stage.primitive_camp`
- `stage.permanent_camp`
- `stage.tiny_hamlet`
Where `start` is mentioned as a real stage tag, use `stage.start`.

### 13.2 Stage metrics that must be refreshed

At minimum compute these metric groups:
- water security
- food security
- shelter security
- sanitation security
- storage security
- labor organization
- seasonal readiness
- social stability

### 13.3 Promotion logic model

Use a staged promotion state instead of instant upgrade.

Recommended promotion states:
- `stable_current_stage`
- `promotion_candidate`
- `promotion_pending_confirmation`
- `promoted`
- `regression_risk`
- `regressed`

### 13.4 Promotion flow

```text
stable_current_stage
  -> promotion_candidate
  -> promotion_pending_confirmation
  -> promoted
  -> stable_current_stage(next stage)
```

### 13.5 Regression flow

```text
stable_current_stage
  -> regression_risk
  -> regressed
  -> stable_current_stage(lower stage)
```

### 13.6 Hysteresis rule

Do not promote or regress on one lucky or unlucky pulse.

Recommended doctrine:
- promotion requires sustained success over repeated daily reviews
- regression can be faster than promotion when core life-support collapses
- small temporary failures may create `regression_risk` without immediate downgrade

This keeps stages meaningful and avoids visual/status flicker.

## 13.7 Stage requirements to check

### A. Lone Survivor -> Primitive Camp

Require all of the following to remain true long enough for confirmation:
- a repeated water-fetch/use routine exists
- an actual sleep site exists and is used
- fire continuity exists beyond luck
- at least one intentional storage method exists
- at least one preservation method exists
- waste/dirty handling is spatially separated from camp core
- at least one improved tool chain exists
- some time remains for improvement work

### B. Primitive Camp -> Permanent Camp

Require all of the following:
- site survives multiple bad-weather days without full functional collapse
- protected food storage exists
- seed/future planting material is protected separately
- container technology materially improves handling/storage
- preservation is repeatable routine work
- camp zoning is explicit
- fuel reserve exists
- planning for next weather/season exists
- one more person could plausibly be supported

### C. Permanent Camp -> Tiny Hamlet

Require all of the following:
- more than one adult NPC present in sustained fashion
- food production or preservation is partly planned
- labor splits into at least two ongoing roles
- storage is meaningful enough that losses matter strategically
- some plant management or gardening exists
- layout functions as infrastructure
- social rules exist in practice
- a bad day for one worker does not instantly break every loop

## 13.8 Stage-check timing

Use this schedule:
- quick derived metrics refresh: daily
- promotion/regression review: daily at fixed review window
- resilience review: after major shocks and at multi-day checkpoints
- season-readiness review: at seasonal boundary and before key weather shift

## 13.9 Major shock triggers that force immediate review

Run immediate stage-risk review when:
- core fire lost during dangerous weather
- protected water becomes unusable
- seed reserve is consumed or destroyed
- key shelter fails in storm/cold spell
- a death or incapacitation removes critical labor redundancy
- contamination event hits food/water core

---

## 14. MVP simplifications that are safe

These simplifications preserve identity while keeping implementation manageable.

### 14.1 Keep one active task per NPC

For the MVP, one primary active task per NPC is enough.
Follow-up reservations and passive process state can still exist.

### 14.2 Keep macro states broad

Do not explode NPC behavior into dozens of tiny animation states.
The simulation state matters more than animation granularity.

### 14.3 Use one shared interruption handler

Different task families may define different consequences, but the top-level interruption pipeline should stay shared.

### 14.4 Use one common health escalation grammar

Different health domains can reuse the same severity progression shape while differing in drivers and consequences.

### 14.5 Keep social state light but real

For the MVP, simple trust/familiarity/morale effects are enough.
Do not build deep drama trees before the survival loop is robust.

---

## 15. Debug and telemetry surfaces this pack requires

To make this buildable, the following debug views should exist early.

### 15.1 NPC state panel

For selected NPC, show:
- current macro state
- current task
- destination
- body-state severities
- interruption reason if any
- next likely self-preservation trigger

### 15.2 Task inspector

For selected task, show:
- current lifecycle state
- score breakdown
- blockers
- reservations
- dependency tasks
- last interruption reason

### 15.3 Item flow inspector

For selected item/batch, show:
- location state
- owner / reserve class
- contamination / spoilage / wetness overlays
- current stockpoint or carrier
- last transfer event

### 15.4 Process inspector

Show:
- process state
- active worker
- inputs present/missing
- passive timer if any
- failure risk / interruption class
- expected outputs

### 15.5 Health event log

Show:
- escalations
- care actions started/completed
- cross-domain amplifiers
- collapse / recovery transitions

### 15.6 Settlement stage panel

Show:
- current stage
- promotion/regression state
- metric scores by category
- failed requirements
- shock triggers affecting stage confidence

---

## 16. Implementation sequence for this pack

Recommended order:

### Phase 1 — shared runtime scaffolding
- pulse scheduler
- enum wiring
- common state machine helper pattern
- debug event logging

### Phase 2 — NPC + task core
- NPC macro loop
- candidate generation
- scoring/selection
- task lifecycle states
- movement + interruption

### Phase 3 — item/location reality
- item location states
- stockpoints
- reservation logic
- transfer and placement flow

### Phase 4 — process backbone
- process states
- passive progress timers
- follow-up task spawning

### Phase 5 — health escalation
- hydration/fatigue/wetness/cold first
- injury/illness next
- care modes and care tasks

### Phase 6 — settlement stage evaluation
- metrics refresh
- stage gates
- promotion/regression hysteresis
- stage debug panel

---

## 17. Acceptance bar for this pack

This pack is implemented well enough when all of the following are true:

1. an NPC can move from sleep/self-care into work and back without fake teleports
2. task choice can be visibly overridden by thirst, fatigue, cold/wetness, and danger
3. a direct order can be accepted, deferred, refused, interrupted, and reported with a clear reason
4. an item can move through source -> transit -> storage -> reserve -> use/process -> waste without losing location truth
5. at least one passive process flow exists cleanly, such as settle water, dry food, or dry green pottery
6. at least one health crisis can escalate and produce real care work
7. settlement stage does not change by button press; it changes by sustained conditions
8. debug surfaces are good enough that a broken transition can be identified quickly

---

## 18. Short conclusion

The early game becomes believable when the simulation clearly answers:
- what is this NPC doing right now?
- why are they doing it instead of something else?
- what is blocking them?
- where are the needed things?
- what changed in the world because the work really happened?
- did the body get safer or worse?
- is this still a desperate site, a routine camp, a permanent camp, or a tiny hamlet?

That is the purpose of this pack.
It should be treated as the implementation-facing authority for runtime behavior in the survival-to-hamlet MVP.
