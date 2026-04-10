# Realistic Idle City — Debug / Telemetry Spec v0.1

## 1. Purpose

This document defines the **debugging, observability, and telemetry requirements** for the early-game MVP.

It exists to make the survival-to-hamlet slice:
- explainable
- debuggable
- balance-tunable
- reproducible
- safe to iterate on without flying blind

This is **not** a generic logging spec.
It is a project-specific causality spec for a realism-first simulation game where failure often emerges from interacting pressures rather than from one obvious bug.

This document turns earlier requirements into a buildable observability layer for:
- body-state pressure
- task choice and interruption
- reservation and reserve protection
- item movement and contamination
- process execution and stalls
- settlement stage promotion/regression
- weather/environment stress
- world exploration and fog-of-war reveal
- long-run simulation stability

---

## 2. Scope

Canonical enum strings come from the Unified Data Dictionary unless this document is referring to a more detailed runtime lifecycle defined and mirrored elsewhere.

This spec covers only the first playable ladder:
- Lone Survivor
- Primitive Camp
- Permanent Camp
- Tiny Hamlet

It supports the early-game MVP where the player must be able to understand:
- why an NPC chose or refused work
- why a survival failure happened
- where time was lost
- where stock went
- why a stage is blocked
- why a process stalled
- why exploration did or did not reveal useful land
- why the settlement became fragile or stable

This spec does **not** attempt to finalize:
- cloud analytics
- monetization telemetry
- multiplayer/network observability
- large-scale post-launch data warehousing
- continent-scale simulation analytics
- cinematic replay capture

---

## 3. Source-of-truth order

When this document conflicts with older material, use this order:

1. latest user instructions in the active chat
2. handoff summary
3. early-game MVP build spec
4. unified data dictionary
5. balance / constants sheet
6. system flow / state machine pack
7. acceptance criteria / test checklist
8. world generation + map rendering spec
9. this debug / telemetry spec
10. older early-game design docs

Practical rule:
- the MVP build spec defines **what the build must include**
- the balance sheet defines **numeric harshness and thresholds**
- the state-machine pack defines **runtime flow shape**
- the acceptance checklist defines **what must be demonstrably true**
- the world-generation spec defines **world/exploration observability needs**
- this document defines **how the build exposes causality to developers and testers**

---

## 4. Core observability doctrine

### 4.1 Explain causes, not just symptoms

A good debug surface does not merely show that an NPC is hungry or that a task failed.
It should explain the **chain**.

Examples:
- not just `dehydrated`, but `dehydrated because nearest safe water source was too far + hauling load too high + rain shelter build outranked refill job`
- not just `fire out`, but `fire went out because reserve-protected firewood remained locked in household reserve + active fuel hauling task lost reservation + rain increased relight demand`
- not just `camp not promoting`, but `stage blocked by sanitation distance + insufficient dry sleep capacity + reserve stability below threshold`

### 4.2 Decision points must write reasons

The most important moments for observability are:
- candidate generation
- task scoring
- reservation refusal
- interruption
- process stall
- state escalation
- stage evaluation
- fog-of-war reveal / non-reveal

If reasons are not recorded there, later logs become guesswork.

### 4.3 Debug and telemetry are related but distinct

Use these terms consistently:

- **debug surface** = live panel, overlay, inspector, or timeline visible to the developer/tester
- **telemetry event** = structured event emitted when something meaningful happens
- **snapshot** = a sampled state record at a fixed cadence or trigger point
- **aggregate metric** = rolling count, average, ratio, or threshold status
- **trace** = ordered set of related events for one entity or one outcome chain
- **alert** = high-salience warning derived from thresholds or failure risk

### 4.4 Dense is fine; vague is not

The debug UI does not need polish.
It does need:
- precise labels
- stable IDs
- visible reason strings
- filterable lists
- enough context to explain consequences

### 4.5 Release-safe minimal telemetry is different from full debug mode

The project should support at least three observability tiers:
- **editor_debug** = maximum introspection, heavy inspectors, rich logs
- **qa_debug** = high signal, reduced overhead, session export enabled
- **release_minimal** = lightweight counters, alerts, and optional manual dump

### 4.6 Reproducibility matters as much as visibility

A useful telemetry system must let a tester say:
- what seed was used
- what scenario preset was loaded
- what balance version was active
- what build version was run
- what direct orders/policies were changed
- when the failure began

Without that, even good event logs lose value.

---

## 5. Questions the telemetry layer must be able to answer

The early-game MVP is not sign-off ready unless the debug / telemetry layer can answer these questions quickly.

### 5.1 Survival causality
- Why did the starter NPC collapse or die?
- Which pressure crossed the dangerous threshold first?
- Was the failure preventable with the available tools and time?
- Did the NPC try to self-preserve before failing?

### 5.2 Task causality
- Why was a task chosen over alternatives?
- Why did a direct order not execute immediately?
- Why did a task remain queued, stall, or get canceled?
- Which blocker was dominant: missing item, distance, reserve rule, body state, weather, pathing, or ownership?

### 5.3 Logistics causality
- Where is the missing item now?
- Was it dropped, carried, stockpiled, reserved, spoiled, contaminated, or consumed?
- How much time was lost to hauling versus production versus recovery?

### 5.4 Process causality
- Why did a craft / dry / cook / boil / cure / build process fail or pause?
- Which inputs were missing?
- Was worker labor missing, or was the process waiting on passive time, fuel, or shelter conditions?

### 5.5 Stage causality
- Why did the settlement not promote?
- Why did it regress?
- Which category is currently weakest: water, food, fuel, sleep, sanitation, storage, labor continuity, or growth support?

### 5.6 World / exploration causality
- Why is a region still unknown?
- Which cells are visible now versus only remembered?
- What did the explorer actually reveal?
- Why did the pathfinder avoid a seemingly obvious route?
- Why is a site good or bad for camp placement?

### 5.7 Stability causality
- Is the sim stable over 7 days? 30 days?
- Are item counts conserved?
- Are orphan reservations accumulating?
- Are stalled tasks or idle loops growing over time?
- Is performance degrading with the same scenario?

---

## 6. Telemetry design goals for this project

The telemetry layer should primarily help with five kinds of work.

### 6.1 Correctness debugging
Examples:
- task never begins despite valid conditions
- reserve rule blocks emergency use incorrectly
- firewood vanishes or duplicates
- stage promotion triggers too early
- revealed cells do not persist in map memory

### 6.2 Balance tuning
Examples:
- dehydration pressure is too punishing relative to travel time
- sleep recovery is too weak
- fire maintenance consumes too much labor
- newcomer arrival causes impossible reserve collapse
- exploration reveals too little land to be worth the labor

### 6.3 Realism validation
Examples:
- wet low ground should correlate with worse sleep quality and sanitation burden
- hauling uphill should be measurably worse than hauling across flat dry ground
- bad water should create believable downstream illness risk
- stock growth should be slow and path-dependent rather than magically smooth

### 6.4 Long-run regression detection
Examples:
- memory leak
- node count ballooning
- unresolved tasks accumulating
- orphan carriers or dropped stacks increasing
- fog state desync after long simulation runs

### 6.5 Tester communication
Examples:
- “NPC ignored order” becomes “NPC deferred order because emergency thirst overrode direct order at severity critical”
- “Map feels weird” becomes “starter-site scoring placed spawn near low-water distance but high flood risk; dry bench was 11 cells farther”

---

## 7. Build tiers

## 7.1 `editor_debug`

Purpose:
- active development
- deep causality inspection
- breakpoint-friendly play
- event flood acceptable within reason

Required features:
- all inspectors enabled
- verbose event stream filters
- per-entity traces
- overlay toggles
- manual dump/export
- simulation pause + step support
- ring buffers plus optional file logging
- custom Godot performance monitors registered

## 7.2 `qa_debug`

Purpose:
- reproducible test runs
- acceptance tests
- performance-sensitive but still explainable

Required features:
- all critical inspectors
- selected verbose channels toggleable
- session summary export
- seeded run metadata
- aggregate charts and alerts
- reduced event verbosity compared with `editor_debug`

## 7.3 `release_minimal`

Purpose:
- protect performance and clarity in player-facing builds
- retain enough observability for support and balancing

Required features:
- limited alerts and explanation surfaces
- compact camp summary
- selected-NPC explanation panel
- optional manual diagnostics dump
- no always-on verbose event spam
- no heavy per-frame traces by default

---

## 8. Canonical architecture

The early-game MVP should implement observability through a single project-level service.

### 8.1 Required singleton

Create an autoload-like runtime authority:
- `DebugTelemetrySystem`

Responsibilities:
- receive structured events from gameplay systems
- maintain rolling buffers
- maintain selected aggregates and histograms
- provide filtered data to panels and overlays
- export debug sessions
- register project-specific performance monitors
- track session fingerprint and reproducibility metadata

### 8.2 Telemetry inputs

The following systems should emit into `DebugTelemetrySystem`:
- simulation clock / pulse scheduler
- world state / exploration system
- NPC system
- task evaluation + task runtime
- reservation system
- item / transfer system
- process system
- health / care system
- settlement stage system
- weather / environment system
- player intent system

### 8.3 Output families

The system should expose:
- live inspectors
- timeline/event log
- counters and monitors
- map overlays
- session summaries
- exported trace files

### 8.4 Design rule: structured first, pretty later

No system should emit only human text like:
- “something went wrong”
- “task failed”
- “can’t reach”

Every important event should emit structured fields plus optional human text.

---

## 9. Session fingerprint and reproducibility

Every run used for debugging, balance, or acceptance should store a session fingerprint.

### 9.1 Required session fields
- `session_id`
- `build_version`
- `content_version`
- `balance_version`
- `world_gen_version`
- `seed_world`
- `seed_events`
- `scenario_id`
- `map_profile_id`
- `start_wall_clock_utc`
- `start_tick_usec`
- `build_tier`
- `debug_flags`

### 9.2 Optional but useful fields
- `git_commit` or equivalent build commit marker
- `test_case_id`
- `tester_name`
- `platform`
- `frame_cap`
- `time_scale`

### 9.3 Repro rule

Any exported failure report should include enough information to replay the failure under the same data/build conditions.

---

## 10. Canonical event schema

All telemetry events should use a shared base schema before domain-specific fields.

### 10.1 Base event fields
- `event_id`
- `event_type`
- `severity`
- `tick_index`
- `tick_usec`
- `day_index`
- `hour_of_day`
- `session_id`
- `source_system`
- `primary_entity_type`
- `primary_entity_id`
- `secondary_entity_type`
- `secondary_entity_id`
- `cell_id`
- `structure_id`
- `task_id`
- `process_id`
- `stage_id`
- `reason_code`
- `reason_text`
- `payload`

### 10.2 Severity enum
Use:
- `trace`
- `info`
- `notice`
- `warning`
- `error`
- `critical`

### 10.3 Event-type naming rule

Use lowercase domain-style IDs.
Examples:
- `sim.pulse_phase_begin`
- `npc.body_state_change`
- `task.selected`
- `task.interrupted`
- `reservation.refused`
- `item.transferred`
- `process.stalled`
- `health.escalated`
- `stage.blocker_changed`
- `map.cell_revealed`

### 10.4 Reason-code doctrine

`reason_code` should be machine-stable.
`reason_text` may be refined later for readability.

Examples:
- `missing_input`
- `body_state_critical`
- `reserve_protected`
- `path_unreachable`
- `unsafe_water`
- `weather_interrupt`
- `sleep_site_too_wet`
- `stage_block_sanitation`
- `fog_not_observed`

---

## 11. Snapshot schemas

Events are not enough on their own.
The system also needs sampled snapshots for panels and long-run inspection.

## 11.1 Snapshot cadence classes

Use these cadence classes:
- **pulse snapshot** = once per sim pulse or phase boundary where needed
- **hourly snapshot** = once per in-game hour
- **daily snapshot** = once per in-game day
- **on-change snapshot** = only when tracked state changes meaningfully
- **on-selection snapshot** = generated on demand for inspector panels

## 11.2 NPC snapshot

Minimum fields:
- `npc_id`
- `display_name`
- `current_macro_state`
- `current_task_id`
- `destination_cell_id`
- `hydration_state`
- `hunger_state`
- `fatigue_state`
- `sleep_debt_state`
- `wetness_state`
- `body_temperature_state`
- `injury_state`
- `illness_state`
- `carry_mass_kg`
- `encumbrance_ratio`
- `movement_cost_current`
- `interrupt_reason_code`
- `self_preservation_trigger_next`
- `current_zone_type`

## 11.3 Task snapshot

Minimum fields:
- `task_id`
- `task_def_id`
- `lifecycle_state`
- `owner_npc_id`
- `target_entity_id`
- `target_cell_id`
- `priority_class`
- `score_total`
- `score_breakdown`
- `blocker_codes`
- `dependency_task_ids`
- `reservation_ids`
- `last_state_change_tick`

## 11.4 Item/batch snapshot

Minimum fields:
- `item_instance_id`
- `item_def_id`
- `stack_qty`
- `location_state`
- `holder_entity_id`
- `cell_id`
- `stockpoint_id`
- `reserve_class`
- `owner_household_id`
- `contamination_state`
- `spoilage_state`
- `wetness_state`
- `last_transfer_tick`

## 11.5 Process snapshot

Minimum fields:
- `process_id`
- `process_def_id`
- `process_state`
- `worker_npc_id`
- `structure_id`
- `cell_id`
- `input_status`
- `fuel_status`
- `shelter_status`
- `passive_progress_ratio`
- `failure_risk_class`
- `stall_reason_code`

## 11.6 Settlement snapshot

Minimum fields:
- `stage_current`
- `stage_confidence`
- `population_count`
- `household_count`
- `water_days_cover`
- `food_days_cover`
- `fuel_days_cover`
- `seed_security_state`
- `dry_sleep_capacity`
- `sanitation_separation_score`
- `storage_protection_score`
- `care_supply_score`
- `growth_support_score`
- `current_blockers`
- `regression_risk_codes`

## 11.7 World / exploration snapshot

Minimum fields:
- `known_cell_count`
- `visible_cell_count`
- `unknown_cell_count`
- `revealed_today_count`
- `observed_water_source_count`
- `observed_hazard_count`
- `path_network_cell_count`
- `candidate_site_count`
- `best_site_score`
- `map_memory_age_mean`

---

## 12. Required live debug surfaces

These are mandatory for the MVP debug experience.

## 12.1 Pulse / phase panel

Show:
- current sim pulse index
- current pulse phase
- queued phase work counts
- phase duration
- recent phase overruns
- last `error` / `critical` event

Purpose:
- diagnose scheduler order problems
- confirm that phases run in the expected sequence
- spot runaway work

## 12.2 Selected NPC inspector

Show:
- current macro state
- current task
- destination
- body-state ladder values
- current carry load
- movement cost on current route
- interruption reason
- last three chosen-task reasons
- next likely self-preservation trigger
- recent health/care events

Mandatory subpanel:
- **Why this NPC is doing this now**

It should summarize at least:
- selected task
- top three score contributors
- top two rejected alternatives
- current hard blocker if any

## 12.3 Task inspector

Show:
- lifecycle state
- worker assignment
- score breakdown
- blocker list
- dependencies
- reservation list
- last interruption reason
- expected completion path

Mandatory command:
- “trace this task from creation to completion/cancel”

## 12.4 Reservation / reserve panel

Show:
- active reservations
- who owns them
- what they block
- reserve-protected stock by class
- emergency override cases
- orphan reservation detector

Mandatory alerts:
- reserve below threshold
- reserve locked but emergency active
- item reserved by nonexistent entity

## 12.5 Item flow inspector

For selected item/batch show:
- current location state
- current holder or stockpoint
- ownership / reserve class
- contamination / spoilage / wetness
- last transfer chain
- last use/consume action

Mandatory command:
- “show item journey”

## 12.6 Process inspector

Show:
- current process state
- assigned worker
- required vs present inputs
- passive timer progress
- fuel continuity status
- shelter requirement status
- stall reason
- expected outputs

## 12.7 Settlement stage panel

Show:
- current stage
- promotion readiness
- regression risk
- metric scores by category
- active blockers
- recent blocker changes
- recent shocks affecting confidence

Mandatory explanation line:
- **Why the settlement is not yet at the next stage**

## 12.8 Health / care panel

Show:
- active conditions by NPC
- latest escalations
- care tasks pending/active
- cross-domain amplifiers
- collapse/recovery transitions

Examples of amplifier text:
- `wetness amplified cold stress`
- `fatigue reduced hauling tolerance`
- `unsafe water increased illness risk`

## 12.9 Weather / environment panel

Show:
- current weather state
- temperature band
- precipitation state
- exposure burden
- wet-ground burden
- recent weather transitions
- current hazard amplifiers

## 12.10 World / exploration panel

Show:
- fog state summary
- revealed-today count
- visible vs remembered land
- currently scouting NPCs
- candidate site summary
- selected cell terrain data
- selected cell knowledge state
- path cost and buildability for selected cell

Mandatory selected-cell fields:
- `elevation_step`
- `slope_class`
- `drainage_class`
- `surface_water`
- `ground_firmness`
- `fertility_class`
- `hazard_flags`
- `knowledge_state`
- `last_observed_tick`

## 12.11 Session / scenario panel

Show:
- build version
- seed(s)
- scenario preset
- balance version
- current time scale
- debug channel states
- export buttons

---

## 13. Required map overlays

The map renderer should support lightweight debug overlays toggleable on top of the normal map modes.

## 13.1 Core overlays
- path cost
- slope
- drainage / wetness
- buildability
- sanitation suitability
- fertility / garden suitability
- current visible cells
- remembered cells
- reserve-critical stockpoints
- active jobs
- blocked/unreachable targets

## 13.2 Optional but useful overlays
- travel heatmap
- hauling burden heatmap
- recent interruption locations
- contamination risk zones
- sleep quality zones
- stage blocker footprint

## 13.3 Overlay doctrine

Overlays should help answer “why,” not just paint noise on the screen.

Bad overlay:
- raw random colors without interpretation

Good overlay:
- cells highlighted because they are currently rejected for latrine use due to wetness + too-close-to-water rule

---

## 14. Event domains and required event families

The following domains must emit structured telemetry.

## 14.1 Simulation events
Required:
- `sim.session_started`
- `sim.session_ended`
- `sim.pulse_phase_begin`
- `sim.pulse_phase_end`
- `sim.time_scale_changed`
- `sim.pause_state_changed`

## 14.2 NPC/body events
Required:
- `npc.spawned`
- `npc.body_state_change`
- `npc.self_preservation_triggered`
- `npc.collapsed`
- `npc.recovered`
- `npc.died`
- `npc.idle_reason_changed`
- `npc.arrived_at_destination`

## 14.3 Task events
Required:
- `task.created`
- `task.candidate_generated`
- `task.selected`
- `task.rejected`
- `task.started`
- `task.progressed`
- `task.interrupted`
- `task.canceled`
- `task.completed`
- `task.failed`

## 14.4 Reservation events
Required:
- `reservation.created`
- `reservation.refused`
- `reservation.expired`
- `reservation.released`
- `reservation.orphan_detected`
- `reserve.threshold_warning`
- `reserve.emergency_override`

## 14.5 Item / transfer events
Required:
- `item.spawned`
- `item.transferred`
- `item.dropped`
- `item.stockpiled`
- `item.consumed`
- `item.contamination_state_change`
- `item.spoilage_state_change`
- `item.destroyed`

## 14.6 Process events
Required:
- `process.created`
- `process.started`
- `process.paused`
- `process.stalled`
- `process.resumed`
- `process.completed`
- `process.failed`

## 14.7 Health / care events
Required:
- `health.escalated`
- `health.reduced`
- `care.task_requested`
- `care.started`
- `care.completed`
- `care.failed`

## 14.8 Settlement / stage events
Required:
- `stage.evaluated`
- `stage.blocker_changed`
- `stage.promoted`
- `stage.regressed`
- `stage.confidence_changed`

## 14.9 Weather / environment events
Required:
- `weather.changed`
- `environment.exposure_risk_changed`
- `environment.water_quality_warning`
- `environment.shelter_failure_risk`

## 14.10 World / exploration events
Required:
- `map.cell_revealed`
- `map.cell_memory_updated`
- `map.knowledge_state_changed`
- `map.resource_observed`
- `map.water_source_observed`
- `map.hazard_observed`
- `map.scout_order_started`
- `map.scout_order_completed`

## 14.11 Player intent events
Required:
- `player.priority_changed`
- `player.policy_changed`
- `player.reserve_rule_changed`
- `player.direct_order_created`
- `player.direct_order_canceled`
- `player.direct_order_refused`

---

## 15. Metric families and rolling aggregates

Structured events explain local causes.
Rolling aggregates explain patterns over time.

## 15.1 Survival metrics
Track:
- dehydration incidents per day
- hunger emergencies per day
- wet-cold danger incidents per day
- collapse count per day
- death count per run
- average time spent in severe body states

## 15.2 Labor metrics
Track:
- time spent walking
- time spent hauling
- time spent gathering
- time spent building
- time spent in care/recovery
- idle time by reason
- interrupted-task count
- canceled-task count

## 15.3 Logistics metrics
Track:
- total item transfers per day
- average haul distance by item class
- dropped-item count
- spoiled-item count
- contaminated-item count
- average stockpoint fill by class
- orphan reservation count

## 15.4 Reserve metrics
Track:
- water days of cover
- food days of cover
- fuel days of cover
- care stock days of cover
- seed protection state over time
- reserve warnings per day

## 15.5 Process metrics
Track:
- process start count
- process completion count
- process stall rate
- average passive waiting time
- average missing-input downtime
- fire/fuel interruption count

## 15.6 Settlement metrics
Track:
- stage dwell time
- blocker frequency by category
- promotion attempts
- regression incidents
- population support score over time
- sanitation score over time
- storage protection score over time

## 15.7 World / exploration metrics
Track:
- cells revealed per day
- visible cells vs remembered cells
- scouting distance traveled
- water-source discovery time
- candidate-site discovery time
- path network growth over time
- exploration orders abandoned or rerouted

## 15.8 Performance / technical metrics
Track:
- fps
- process time
- physics process time
- node count
- orphan node count
- memory usage where relevant
- event throughput per second
- active ring-buffer usage
- export file size

---

## 16. Godot-facing implementation guidance

The simulation-facing telemetry design should align with Godot’s actual tooling rather than fighting it.

## 16.1 Built-in engine monitors

Use Godot’s built-in performance monitors for baseline technical health such as:
- FPS
- process time
- physics process time
- node count
- orphan node count
- selected memory/render monitors where useful

These are engine-level technical monitors.
They should not replace project-specific simulation metrics.

## 16.2 Custom project monitors

Register project-specific monitors for graphs and quick inspection.
Recommended early custom monitors:
- `sim/active_npc_count`
- `sim/queued_task_count`
- `sim/active_task_count`
- `reserve/water_days_cover`
- `reserve/food_days_cover`
- `reserve/fuel_days_cover`
- `health/severe_body_state_count`
- `stage/current_stage_index`
- `stage/blocker_count`
- `map/visible_cell_count`
- `map/revealed_cell_count`
- `map/known_water_source_count`
- `debug/orphan_reservation_count`
- `debug/stalled_process_count`

## 16.3 Profiler usage doctrine

The built-in profiler is for targeted technical investigation, not for always-on telemetry.
Use it to inspect spikes and bad code paths.
Do not rely on it as the only way to understand simulation behavior.

## 16.4 File export format

Preferred export format for event streams:
- newline-delimited JSON (`jsonl` style)

Reasons:
- append-friendly
- easy to inspect manually
- easy to diff/filter
- good fit for one-event-per-line records

Suggested output folders:
- `user://telemetry/`
- `user://telemetry/sessions/`
- `user://telemetry/summaries/`

## 16.5 Timestamp doctrine

Use monotonic tick time for precise event ordering.
Do **not** rely on system clock alone for intra-session causality.

Recommended fields:
- monotonic tick time for ordering
- wall-clock UTC only for session labeling/export naming

---

## 17. Logging policy and anti-spam rules

Telemetry becomes useless if spam buries the signal.

## 17.1 Always log
Always log these transitions:
- state escalations
- task selection
- task interruption/cancel/fail
- reservation refusal/orphan
- item destruction/consume/spoilage/contamination change
- process stall/fail/complete
- stage promotion/regression/blocker change
- direct-order refusal
- map reveal and important observations
- session start/end metadata

## 17.2 Sample or compress
These can be sampled, aggregated, or summarized:
- repeated path-step movement
- repeated “still waiting” states
- unchanged hourly snapshots
- identical warnings firing every pulse

## 17.3 Deduplicate noisy warnings

If the same warning remains true across many pulses, emit:
- one initial `warning`
- occasional reminder summary
- one resolution event when cleared

## 17.4 Trace windows

Per-entity detailed traces should be capped in memory by ring buffers.
Suggested rule:
- keep only the most recent high-detail trace window in memory
- export full traces to file only on demand or on failure-triggered dump

---

## 18. Failure-chain reconstruction

The telemetry system should support reconstructing major failure chains without frame-by-frame replay.

## 18.1 Required chain types
- survival collapse chain
- reserve collapse chain
- process failure chain
- stage regression chain
- exploration failure chain

## 18.2 Example survival collapse chain

A reconstructed chain should be able to show something like:
1. rain began
2. wetness increased while shelter incomplete
3. fire relight task created
4. fuel hauling task blocked by reserve rule
5. NPC chose water fetch due to critical hydration
6. return path cost increased due to load and slope
7. fatigue rose to severe
8. emergency sleep triggered on poor dry site
9. cold stress escalated overnight
10. collapse occurred at dawn

This level of reconstruction is sufficient.
Do not require video replay to understand ordinary failures.

---

## 19. Fog-of-war and exploration telemetry rules

Because unknown land is part of the intended play experience, exploration observability is mandatory.

## 19.1 Cell knowledge states to expose
At minimum support and debug:
- `unknown`
- `suspected`
- `observed`
- `familiar`

## 19.2 Required reveal telemetry
When a cell changes from one knowledge state to another, record:
- observing NPC
- old state
- new state
- reveal cause
- time
- whether terrain, water, hazard, resource, or path data changed

## 19.3 Required non-reveal explanations
If a player expects a reveal and does not get one, the system should be able to explain:
- out of observation range
- occluded or low confidence
- no controlled observer present
- memory stale but not currently visible
- reveal suppressed because no meaningful data changed

## 19.4 Exploration success metrics
Track:
- time to first safe water observation
- time to first viable camp-site candidate
- percent of revealed land that is buildable
- percent of revealed land that is hazard-marked
- scouting labor spent per useful discovery

---

## 20. Alerts and warning doctrine

Alerts are not the full telemetry layer.
They are the thin, high-salience layer above it.

## 20.1 Alert categories
Use:
- `body`
- `reserve`
- `task`
- `process`
- `health`
- `stage`
- `world`
- `performance`

## 20.2 Required early-game alerts
At minimum:
- critical dehydration
- no safe water reachable
- no usable sleep site
- fire out with cold/wet risk active
- fuel reserve below emergency threshold
- food reserve below emergency threshold
- seed stock endangered
- sanitation separation broken
- care supply absent during injury/illness
- stage regression imminent
- orphan reservation detected
- stalled process with required output critical
- explorer in severe danger far from camp

## 20.3 Alert design rule

An alert should include:
- what is wrong
- why it matters
- where it is happening
- what caused it if known

Example:
- `Fuel reserve critical: hearth continuity risk at central camp. Firewood reserve below threshold for 0.7 days. Last two haul tasks interrupted by severe fatigue.`

---

## 21. Exported artifacts

The system should be able to export three useful artifact types.

## 21.1 Session summary
Compact file containing:
- session fingerprint
- major outcomes
- stage reached
- deaths/collapses
- reserve minima
- key blocker frequencies
- main alert counts
- performance summary

## 21.2 Event stream dump
Structured `jsonl` file of events for the chosen time window or whole session.

## 21.3 Failure bundle
Small bundle for one major incident containing:
- session fingerprint
- recent event window
- involved entity snapshots
- current map/settlement summary
- active policies/direct orders
- optional screenshot reference later if implemented

---

## 22. Retention policy

## 22.1 In-memory buffers
Use ring buffers for:
- event stream
- selected entity traces
- alert history
- stage blocker history

## 22.2 File retention
For debug builds:
- keep recent session summaries by default
- keep full event dumps only when manually exported or when a critical failure trigger requests it

## 22.3 What not to retain continuously
Avoid always storing:
- every movement step forever
- full map snapshots every pulse
- duplicated unchanged snapshots
- giant binary dumps that cannot be inspected quickly

---

## 23. Performance budget rules

Observability must not quietly destroy simulation performance.

## 23.1 Early rules
- emit structured events only at meaningful transitions
- use ring buffers for volatile detail
- aggregate repeated counts instead of logging every trivial repetition
- keep heavy inspectors on-demand where possible
- avoid generating big strings until a panel actually needs them

## 23.2 Warning sign monitors
Track and display:
- events per second
- average event payload size
- inspector refresh cost
- overlay redraw count
- export write duration

## 23.3 Fallback plan

If the telemetry layer causes visible slowdown:
1. reduce trace verbosity
2. lower snapshot frequency
3. disable selected overlays
4. defer expensive string formatting until viewed
5. preserve critical alerts and causality events first

---

## 24. Recommended implementation order

## Phase 0 — scaffolding
Build first:
- `DebugTelemetrySystem`
- session fingerprint record
- common event schema
- ring buffer helpers
- severity / channel filters
- manual export skeleton

Deliverable:
- events can be emitted, filtered, and dumped

## Phase 1 — survival causality core
Add:
- NPC inspector
- task inspector
- reservation / reserve panel
- body-state events
- task select/interruption events
- reserve warning events

Deliverable:
- “why did the NPC do this / fail this” is answerable

## Phase 2 — item and process observability
Add:
- item flow inspector
- process inspector
- contamination / spoilage / transfer events
- process stall/complete events

Deliverable:
- missing-stock and stalled-process diagnosis is practical

## Phase 3 — settlement and alerts
Add:
- settlement stage panel
- blocker history
- alert layer
- reserve coverage graphs
- daily summary generation

Deliverable:
- progression/regression becomes explainable

## Phase 4 — world / exploration observability
Add:
- world / exploration panel
- debug overlays
- reveal/non-reveal telemetry
- site candidate summary

Deliverable:
- map reading and scouting failures become diagnosable

## Phase 5 — performance and hardening
Add:
- custom monitors
- performance summary panel
- long-run session summary
- failure bundle export
- acceptance-test preset hooks

Deliverable:
- telemetry supports sign-off and regression hunting

---

## 25. Minimum sign-off requirements for this spec

This spec is considered implemented enough for the early-game MVP when all of the following are true:

- a tester can explain solo survival failure without reading code
- a tester can explain at least one failed direct order without reading code
- missing/reserved stock can be located and explained
- a stalled process can be diagnosed from live panels
- settlement stage blockers are visible and understandable
- reserve thresholds and emergency overrides are visible
- exploration reveal and non-reveal can be explained for a selected region
- session export contains seed/build/balance metadata
- long-run tests can surface aggregate failure patterns
- the debug layer itself does not create unacceptable simulation slowdown

---

## 26. Non-goals and anti-patterns

Avoid these mistakes.

### 26.1 Anti-pattern: text-only mystery logs
Bad:
- `npc failed`
- `task canceled`
- `stage not ready`

### 26.2 Anti-pattern: only technical telemetry
Bad:
- FPS graphs but no task reasons
- node count but no reserve warnings
- memory graphs but no collapse chain

### 26.3 Anti-pattern: only local inspection
Bad:
- selected NPC panel exists but no settlement summary
- selected item panel exists but no reserve overview
- selected cell panel exists but no exploration aggregate

### 26.4 Anti-pattern: beautiful but sparse debug UI
Bad:
- polished panel with too little information

### 26.5 Anti-pattern: one giant permanent event flood
Bad:
- every movement step logged forever
- no filtering, no deduplication, no aggregation

---

## 27. Final doctrine summary

For this project, telemetry is not optional polish.
It is part of the MVP.

Because the game is realism-first, a player or tester will often fail due to:
- interacting body pressures
- travel and hauling burden
- shelter and weather mismatch
- reserve protection
- contamination or spoilage
- poor site choice
- weak stage conditions
- unknown land

That means the build must be able to explain **chains**, not just states.

The correct early-game telemetry philosophy is:
- record reasons at decision points
- expose the chain from world conditions to NPC choice to settlement outcome
- keep the tooling dense and explicit
- make failures reproducible
- keep enough performance discipline that the observability layer remains usable during long runs

