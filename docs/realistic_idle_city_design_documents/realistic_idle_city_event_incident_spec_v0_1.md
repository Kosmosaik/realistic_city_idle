---
title: "Realistic Idle City — Event / Incident Spec"
version: "v0.1"
scope:
  - "Early slice only: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
  - "Temperate biome baseline"
  - "Realism-first, minimal-visual colony simulation"
status: "Design document"
date: "2026-04-08"
author: "OpenAI / ChatGPT"
---

# 1. Purpose of this document

This document defines the **event / incident layer** for the early game.

The project already has documents for:
- NPC simulation
- task evaluation
- items and materials
- processes
- buildings and structures
- settlement progression
- knowledge and discovery
- social/recruitment
- allocation / ownership / rationing
- health / injury / care
- environmental hazards
- food / water safety
- logistics / hauling / storage flow
- player orders / policy
- world / map / site generation
- master simulation loop
- canonical early content

What is still needed is a clear answer to:

> What happens when things go wrong, when something unusual appears, or when the colony faces a meaningful disruption?

This document provides that answer.

It treats events and incidents as **condition-driven consequences** of the simulation, not as arbitrary flavor popups.  
A good event system in this project should:
- surface meaningful danger and opportunity
- create believable interruptions
- pressure the player to build resilience
- reveal weaknesses in layout, reserves, sanitation, leadership, and scheduling
- generate memorable stories without breaking realism

---

# 2. Scope and framing

## 2.1 Scope
This spec only covers the early slice:
- lone starter NPC
- primitive camp
- permanent camp
- tiny hamlet

It does **not** yet cover:
- organized warfare
- advanced policing/law
- industrial accidents
- full epidemics
- large-scale trade shocks
- urban fires at town/city scale
- complex political factions

## 2.2 Core interpretation
An event is not a separate minigame.  
It is a **named state change** or **discrete incident** that emerges from one or more underlying conditions.

Examples:
- "Unsafe water illness" is not random bad luck. It emerges from unsafe source use, poor treatment, dirty storage, or recontamination.
- "Food spoilage" is not random punishment. It emerges from moisture, warmth, pests, long storage, dirty containers, and handling failures.
- "Overwork collapse" is not a drama script. It emerges from sleep debt, thirst, heat/cold burden, load carriage, injury, and high-priority labor.
- "Outsider arrival" is not a magic unlock. It emerges from mobility routes, settlement visibility, season, local safety, and social conditions.

## 2.3 Event layer goal
The event layer should answer four questions:

1. **What happened?**
2. **Why did it happen?**
3. **How urgent is it?**
4. **What must be done now, and what weakness does it reveal?**

---

# 3. Design principles

## 3.1 Events are caused
An event should always have a believable cause or trigger set.

## 3.2 Events reveal systems, not replace them
An event should expose:
- bad site choice
- bad reserve policy
- poor sanitation
- overwork
- unsafe handling
- social strain
- weak shelter
- risky process execution
- bad storage placement
- inadequate fire discipline
- insufficient care capacity

## 3.3 Detection matters
Not every event is instantly known.
Some begin hidden and become visible only when:
- symptoms appear
- someone inspects
- a threshold is crossed
- an NPC reports it
- the player has the right view/open panel/alert rule
- the problem reaches another system (e.g. foul water, rotten smell, smoke, complaints)

## 3.4 Events should have aftermath
Even after resolution, many incidents should leave:
- lost labor time
- damaged morale
- contaminated containers
- wet bedding
- damaged shelter
- spoiled food
- depleted reserves
- distrust
- fear
- injury recovery burden
- knowledge gain or new caution

## 3.5 Small failures should matter
Early survival depends on small things:
- one dropped water vessel
- one wet fuel stack
- one infected cut
- one damaged seed bundle
- one bad rainstorm before shelter is improved
- one night of severe sleep loss

## 3.6 Opportunity events matter too
Not all events are negative.
Some should be conditional opportunities:
- stranger arrival
- found carcass
- exposed clay after rain
- animal trail discovery
- unusually rich berry patch
- recovering a dropped tool
- local calm weather window
- lesson learned from failure
- outsider knowledge exchange

These should still obey realism and risk.

---

# 4. Definitions

## 4.1 Event
A player-facing occurrence with:
- a label
- a cause
- severity
- observability
- consequences
- response options
- resolution conditions

## 4.2 Incident
A narrower operational term for a discrete harmful or disruptive event:
- cut
- burn
- contamination
- flare-up
- spoiled stock
- conflict
- stranger at edge of camp

In this document, "event" is the broad umbrella and "incident" is a more specific disruptive subtype.

## 4.3 Condition
An underlying ongoing state that may or may not become an event:
- wet bedding
- fatigue
- poor sanitation
- contaminated container
- high rodent pressure
- low trust
- excessive smoke burden
- elevated fire risk

## 4.4 Trigger
The rule that converts conditions into an event:
- threshold crossing
- probability roll modified by real conditions
- scheduled check
- external arrival roll
- chain reaction from another event

## 4.5 Response window
The time between event detection and major worsening.

---

# 5. Event model in the simulation

## 5.1 Basic lifecycle
Every event should move through these states:

1. **Latent**
   - conditions exist
   - no player-facing event yet

2. **Triggered**
   - incident begins
   - may still be partially hidden

3. **Detected**
   - player and/or NPC becomes aware
   - alert may appear

4. **Active**
   - consequences are now unfolding
   - tasks and priorities are affected

5. **Stabilized**
   - immediate worsening halted
   - still unresolved or under management

6. **Resolved**
   - primary threat removed

7. **Aftermath**
   - lingering recovery, damage, morale, contamination, or knowledge effects remain

## 5.2 Event object model
Each event should have fields like:

- event_id
- family
- subtype
- severity tier
- involved NPCs
- involved items
- involved structures
- involved location / zone / tile cluster
- origin cause(s)
- detected_by
- observability level
- start tick / start time
- last escalation time
- deadline or response window
- active consequences
- recommended responses
- automatic responses available
- resolution conditions
- failure conditions
- aftermath effects
- memory/log text
- repeat suppression tag

## 5.3 Event generation types

### A. Threshold events
Crossing a meaningful threshold:
- thirst critical
- shelter warmth below survival floor
- bedding wetness above threshold
- smoke load in enclosed space above threshold
- trust below safe cooperation band

### B. Exposure events
Generated by accumulated exposure:
- repeated unsafe water
- multiple nights of poor sleep
- repeated wet-cold exposure
- cumulative strain from hauling

### C. Action-linked events
Generated during a process or task:
- cut while butchering
- burn at hearth
- vessel dropped during hauling
- shelter collapse during storm because it was poorly built
- clay vessel cracking during firing

### D. Storage-linked events
Generated by time plus storage conditions:
- spoilage
- mold
- pest intrusion
- damp seed
- wet fuel

### E. External-contact events
Generated by world context:
- stranger arrival
- animal approach
- scavenger attention
- storm front
- lightning threat
- sudden cold night

### F. Social-threshold events
Generated by accumulated social strain:
- complaint
- refusal
- conflict
- withdrawal
- hoarding suspicion
- outsider tension

---

# 6. Severity framework

## 6.1 Suggested severity tiers

### Tier 0 — Notice
Minor, informative, often self-correcting.
Examples:
- one basket becoming worn
- a brief smoke complaint
- small wildlife seen near camp
- a tool misplaced but recoverable

### Tier 1 — Disruption
A real problem, but limited.
Examples:
- one vessel contaminated
- small amount of food spoiled
- one NPC mildly overworked
- shelter leak discovered
- brief argument

### Tier 2 — Serious
Requires response or the colony will lose important time/resources.
Examples:
- infected cut
- multiple fuel bundles soaked
- sleep collapse risk
- small fire spreading from hearth
- significant water reserve contamination
- outsider conflict risk

### Tier 3 — Critical
Immediate action needed to protect survival or cohesion.
Examples:
- severe dehydration
- hypothermia risk
- active structure fire
- major spoilage in seed reserve
- dangerous social confrontation
- wounded outsider at camp edge during low reserve period

### Tier 4 — Existential
Could cause death, camp abandonment, or collapse if mishandled.
Examples:
- flash-flood inundation
- major exposure event with no shelter
- life-threatening illness in a lone-NPC phase
- combined reserve failure entering severe weather

## 6.2 Severity is dynamic
Severity can rise or fall based on:
- time since start
- whether a response has begun
- environmental conditions
- reserve levels
- number of affected NPCs
- whether the colony has the right tools, space, skill, and leadership

---

# 7. Detection and observability

## 7.1 Detection classes

### Immediate-visible
The player can see it instantly.
Examples:
- fire
- falling tree branch
- visible shelter damage
- active fight
- stranger spotted in open view

### NPC-reported
The player learns because an NPC notices and reports.
Examples:
- foul smell in water vessel
- pain in foot from blister or sprain
- tool edge damage
- suspicious tracks
- wet seed stock inside container

### Inspection-detected
Needs deliberate inspection.
Examples:
- mold beginning in store pit
- hidden contamination of a vessel
- gradual hide rot
- weakened lashings in a shelter wall
- low-level social resentment

### Symptom-detected
Only becomes known when symptoms appear.
Examples:
- diarrheal illness after bad water
- infection after cut
- smoke irritation
- exhaustion collapse
- grievance becoming open complaint

## 7.2 Detection modifiers
Detection depends on:
- light and visibility
- distance
- inspection frequency
- NPC skill and experience
- caution trait
- cleanliness/organization
- whether the player has the relevant panel/open alert filter
- how obvious the signs are
- noise/distraction load

## 7.3 Misdiagnosis
Realistic early survival includes uncertainty.
The game can support:
- "water may be contaminated"
- "food smells wrong"
- "NPC seems feverish"
- "something is disturbing the cache at night"

The player does not always get perfect information immediately.

---

# 8. Response model

## 8.1 Event response paths
An event can be addressed through:

### A. Immediate direct action
Examples:
- extinguish flare-up
- move bedding out of rain
- fetch water urgently
- apply pressure to bleeding wound
- isolate spoiled food

### B. Support action
Examples:
- assign helper
- bring dry fuel
- bring bandaging material
- reinforce shelter
- boil more water
- move reserve stock

### C. Policy action
Examples:
- raise water reserve threshold
- forbid unsafe water source
- restrict raw-food handling to specific NPCs
- lock seed reserve
- ban indoor smoke-heavy fire use
- increase fire-watch priority

### D. Structural action
Examples:
- build better cache
- move latrine
- raise store floor
- roof fuel storage
- add drainage trench
- create guest area for outsiders

### E. Social action
Examples:
- reassure
- mediate conflict
- formalize ration rules
- assign fairer labor balance
- designate mentor/caretaker
- clarify outsider policy

## 8.2 Resolution should not always be binary
Example:
- a conflict may be "contained" but trust remains damaged
- a water scare may be "managed" but containers still need re-cleaning
- a wounded NPC may be "stable" but unfit for hard labor for days
- a rain event may "pass" but bedding, fuel, and morale remain affected

---

# 9. Event families

# 9A. Physiological and personal state incidents

These are incidents where a body-state problem becomes discrete enough to deserve a named event.

## 9A.1 Typical triggers
- thirst reaches a critical threshold
- body temperature falls below safe range
- heat burden rises too high during exertion
- exhaustion plus sleep debt plus labor demand
- pain plus stress plus low rest
- combined hunger/thirst/fatigue causing task failure

## 9A.2 Example incidents
- severe thirst episode
- dizziness / faintness
- exhaustion stumble
- brief collapse from overexertion
- cold-stiffness episode
- heat-strain episode
- sleep-crash
- panic-like surge under multiple threats

## 9A.3 Why they matter
These are often early warning incidents.  
They prevent the player from treating an NPC as an abstract worker.

---

# 9B. Injury incidents

## 9B.1 Realistic early injury families
Research on everyday work and outdoor/manual activity strongly supports recurring injury classes such as:
- cuts / punctures / scrapes
- slips / trips / falls
- burns
- strains / sprains
- crush/pinch injuries
- eye irritation or foreign body problems

## 9B.2 Likely sources in this game
- stone tool shaping
- butchering
- fire handling
- carrying awkward loads
- wet or uneven terrain
- branch and thorn contact
- digging
- shelter building
- climbing / reaching
- pottery firing / hot vessel handling later in the slice

## 9B.3 Core early injury incidents
- minor cut
- deep cut
- puncture / thorn / splinter
- hand blister
- sprain / twist
- fall bruise
- burn from ember, coal, vessel, or hearth
- smoke-in-eye irritation
- back/shoulder strain from hauling
- lashing/rope abrasion

## 9B.4 Escalation rules
Injuries escalate based on:
- cleanliness of wound care
- contamination source
- whether work continued immediately
- rest adequacy
- nutrition/hydration
- weather/wetness
- whether the injured body part is still used heavily

---

# 9C. Illness, contamination, and care incidents

## 9C.1 Core early illnesses
- unsafe water illness
- foodborne gastrointestinal illness
- wound infection
- fever-like nonspecific illness
- smoke burden illness
- parasite/vector-linked irritation or disease abstraction
- vomiting/dehydration spiral

## 9C.2 Trigger patterns
- untreated or badly stored water
- contaminated hands / vessels
- spoiled or dirty food
- poor sanitation layout
- wound plus dirt plus no cleaning
- prolonged smoke exposure
- insect/vector pressure in certain habitats

## 9C.3 Example incidents
- stomach distress
- diarrhea onset
- vomiting onset
- contaminated reserve warning
- infection suspicion
- fever watch
- breathing irritation event
- dehydration crisis after illness

## 9C.4 Detection style
Many of these begin hidden and only later show:
- reduced appetite
- weakness
- repeated bathroom visits
- visible feverishness
- foul smell
- discolored wound
- cough, eye irritation, headache

---

# 9D. Fire, heat, smoke, and combustion incidents

## 9D.1 Core realism
Early camps depend on fire, but fire introduces:
- burns
- ember spread
- structure ignition
- reserve loss
- smoke burden
- enclosed-combustion danger

## 9D.2 Typical triggers
- poorly bounded hearth
- dry material too close to fire
- wind gusts
- unattended coals
- carrying embers badly
- attempting indoor or too-enclosed combustion
- children/guests/animals later disturbing fire areas
- overloaded drying/smoking structures

## 9D.3 Example incidents
- hearth flare-up
- ember ignition in bedding or thatch
- smoke accumulation warning
- enclosed-fire poisoning danger
- cookfire escaped ring
- fuel pile catches
- smoking rack overheating

## 9D.4 Key aftermath
- lost shelter parts
- lost reserves
- smoke-damaged food
- NPC fear of fire area
- stricter fire policy unlocked or justified
- temporary warmth loss after fire suppression in cold weather

---

# 9E. Weather and environmental incidents

## 9E.1 Environmental hazard families
The earlier hazard spec defines:
- heat
- cold
- wind
- rain
- flood threat
- lightning
- wildfire smoke
- terrain danger
- vector habitats
- visibility reduction

This event spec turns those into discrete incidents.

## 9E.2 Example weather incidents
- sudden cold night
- wind-driven rain
- bedding soaked
- shelter leak discovered during storm
- drainage failure / pooling water
- stream rise warning
- nearby lightning strike / exposed-area danger
- heat spike during hauling
- smoke inversion / bad air period
- falling branch after storm

## 9E.3 Why they matter
Weather incidents force:
- reserve use
- shelter repair
- schedule changes
- hauling postponement
- emergency fuel focus
- camp relocation decisions in severe cases

---

# 9F. Animal, pest, and vector incidents

## 9F.1 Core families
- predator or scavenger presence
- rodent intrusion
- insect swarms
- tick exposure
- mosquito surge
- snakes or aggressive small animals where biome supports them
- food theft by animals
- carcass attraction

## 9F.2 Example incidents
- night scavenger disturbance
- animal raided drying rack
- tracks near camp
- rodent in grain/seed area
- tick bite discovered
- mosquito-heavy evening
- carcass attracting scavengers
- animal spooked near camp edge

## 9F.3 Gameplay role
These incidents pressure:
- better food storage
- cleaner waste handling
- better camp layout
- safer carcass disposal
- location-aware sleeping/sitting areas
- defensive readiness without turning the game into a combat sim

---

# 9G. Resource, storage, and reserve incidents

## 9G.1 Core realism
A large share of early failures are not dramatic.  
They are slow reserve losses.

## 9G.2 Example incidents
- water vessel recontaminated
- water reserve too low
- fuel stock soaked
- kindling depleted
- hide beginning to rot
- seed reserve dampness
- grain mold suspicion
- dried food pest damage
- container crack discovered
- lashing failure on cache or rack
- food cache disturbed
- reserve mix-up (seed used as food risk)

## 9G.3 Why they matter
These incidents are central to realism because settlement stability depends on:
- preserving surplus
- separating categories of stock
- keeping containers clean and dry
- respecting reserve locks
- maintaining structures and handling routines

---

# 9H. Process and equipment incidents

## 9H.1 Triggered during work
These incidents happen during tasks or process execution.

## 9H.2 Examples
- fire-start attempt fails and wastes tinder
- clay vessel cracks during drying
- clay vessel bursts in firing
- basket fails under load
- cordage snaps
- spear point loosens
- cutting edge chips
- trap misfires or springs early
- drying batch spoiled by unexpected rain
- overcooked / scorched food
- ash contamination in food
- smoking process too cool / too hot

## 9H.3 Design value
They make skill, supervision, weather awareness, and maintenance matter.

---

# 9I. Social and leadership incidents

## 9I.1 Core realism
As soon as more than one NPC exists, not all problems are physical.

The design stack already establishes that NPCs care about:
- safety
- workload fairness
- leadership confidence
- food quality
- warmth
- status/pride
- competence fit
- relationships
- trust and belonging

## 9I.2 Social incident families
- complaint
- grievance
- open conflict
- refusal or delay
- fear spread
- distrust of outsider
- rationing resentment
- hoarding suspicion
- neglect accusation
- grief / shock after major injury or death
- role mismatch burnout

## 9I.3 Example incidents
- "Workload unfair" complaint
- "Unsafe order" refusal
- ration dispute
- outsider sleeping arrangement tension
- mentor frustration
- caregiver overload
- low-trust newcomer conflict
- morale dip after reserve loss
- panic after fire or predator scare

## 9I.4 Resolution paths
- reassignment
- policy change
- reserve clarification
- mediation
- apology/repair action
- visible fairness
- giving rest
- providing better shelter/clothing/food access
- assigning shared labor or rotating burden

---

# 9J. Recruitment and external-contact incidents

## 9J.1 Why this is separate
Outsiders are part of growth, risk, and story.
They should not appear as plain unlock tokens.

## 9J.2 Early external-contact incidents
- distant figure sighted
- stranger approaches cautiously
- injured wanderer found
- hungry wanderer requests food/water
- outsider leaves after poor reception
- outsider shares warning or local knowledge
- outsider steals or is suspected of stealing
- outsider accepted as temporary guest
- outsider conflict with resident
- outsider dies or departs, affecting morale and trust

## 9J.3 Trigger influences
- season
- location on travel corridors
- settlement visibility
- smoke column visibility
- reserve abundance/scarcity
- overall camp safety
- local social climate
- recent danger level

---

# 10. Event interactions and cascades

## 10.1 Cascades are essential
The best events are often chains, not isolated problems.

## 10.2 Example cascade chains

### Chain A — Rain -> wet bedding -> poor sleep -> overwork error -> cut -> infection risk
A realistic early-game chain.

### Chain B — Unsafe water -> stomach illness -> dehydration -> reduced labor -> low reserve -> ration tension
This links public health to social strain.

### Chain C — Carcass near camp -> scavenger attention -> night disturbance -> fear -> sleep loss -> task inefficiency
A good example of ecology affecting morale.

### Chain D — Fuel left exposed -> wet fuel -> firemaking failure -> cold night -> low morale -> poor next-day productivity
A reserve management lesson.

### Chain E — Seed reserve dampness -> reduced planting viability -> lower future food security -> harsher rationing -> complaint
A slow strategic failure.

### Chain F — Fire flare-up -> shelter damage -> emergency repairs -> delayed water haul -> dehydration risk
A true survival tradeoff.

## 10.3 Cascade design rule
A cascade should be possible, but not inevitable.
Good preparation should break the chain early.

---

# 11. Event frequency and anti-spam rules

## 11.1 Problem
A realism-first game can generate too many incidents if every condition becomes a popup.

## 11.2 Rules to prevent noise
- aggregate similar low-level warnings
- suppress repeats for a cooldown period
- escalate only when severity meaningfully rises
- convert background chronic issues into meter/panel states instead of repeated alerts
- only create named events when action or attention is warranted

## 11.3 Good practice
Do **not** fire a new event every tick for:
- same wet bedding
- same mild smoke problem
- same low reserve
- same unresolved complaint

Instead:
- maintain one active case
- update severity and age
- resurface only on escalation or major consequence

---

# 12. Player-facing presentation rules

## 12.1 Notification classes

### Info
Non-urgent awareness.
Examples:
- tracks found near camp
- stranger sighted at distance
- one container cracked
- minor morale complaint logged

### Warning
Needs attention soon.
Examples:
- water reserve low
- wet bedding before cold night
- stomach illness suspected
- fuel stock partly soaked

### Critical
Needs immediate action.
Examples:
- active fire
- severe dehydration
- hypothermia risk
- major reserve contamination
- escalating social confrontation

## 12.2 What the player should see
Each event card should include:
- event name
- what is affected
- why it likely happened
- urgency
- time window
- recommended actions
- what might happen if ignored
- whether it is hidden/uncertain/confirmed

## 12.3 Realism rule for UI wording
Use concrete language:
- "Bedding soaked in overnight rain"
- "Water pot may be contaminated"
- "Nila is dizzy from thirst and overwork"
- "Rodents may have reached the seed basket"
- "A stranger is waiting at the edge of camp"

Avoid overly abstract system-only messages.

---

# 13. Event design schema

## 13.1 Suggested data fields
For each authored event template:

- id
- name
- family
- stage_min
- stage_max
- description_short
- detection_mode
- observability
- base_severity
- max_severity
- trigger_conditions
- trigger_weights
- suppression_rules
- involved_entity_types
- location_requirements
- weather_requirements
- season_requirements
- reserve_requirements
- social_requirements
- process_requirements
- likely_followup_events
- resolution_tasks
- policy_responses
- automatic_npc_responses
- aftermath_effects
- knowledge_gain_hooks
- narrative_log_text
- ui_icon / tag set

## 13.2 Trigger style
Prefer rules like:
- condition score + modifiers + threshold
- weighted chance from exposure
- deterministic trigger at critical failure
- gated external roll only when world conditions support it

Avoid:
- pure random drama with no cause

---

# 14. Early-stage authored event catalog

Below is a canonical first-pass event library for the early slice.

## 14.1 Lone survivor stage events

### Survival pressure
- Severe thirst episode
- Unsafe source drinking decision
- Cold night exposure
- Wet bedding at dusk
- Overexertion stumble
- Sleep-crash
- Heat-strain during hauling
- Sudden dizziness from hunger/thirst mix

### Injury / process
- Hand cut while shaping tool
- Puncture / thorn event
- Ember burn
- Fall on uneven ground
- Load-drop strain
- Spear point failure during hunt attempt
- Fire-start bundle wasted

### Resource / storage
- Water vessel contamination
- Water vessel cracked
- Fuel stock soaked
- Dry tinder exhausted
- Gathered food spoils in sun
- Carcass too warm / unsafe
- Hide begins to rot
- Carry bundle lost or scattered

### Environmental
- Night wind shift hits shelter
- Heavy rain enters lean-to
- Lightning warning in exposed area
- Rising stream warning
- Thick mosquito evening
- Tick bite discovered
- Animal tracks near sleep site

### External
- Strange sound at night
- Scavenger disturbance at carcass/cache
- Distant smoke sighted
- Lost object rediscovered nearby

## 14.2 Primitive camp events

### Camp operations
- Hearth flare-up
- Smoke accumulation in sleeping area
- Drying rack overloaded
- Food left uncovered
- Waste area too close warning
- Latrine contamination concern
- Wood stack instability
- Cordage failure on storage rack

### Food / water safety
- Stomach distress after unsafe water
- Vomiting / diarrhea onset
- Pot likely unclean
- Water recontaminated after boiling
- Smoked food batch questionable
- Dried food dampness found
- Rodents at food cache

### Knowledge / opportunity
- Better clay source exposed after rain
- New trail to water found
- Better sleeping material discovered
- Animal path identified
- Repeated task improves reliability enough to log procedure

## 14.3 Permanent camp events

### Reserve / structure
- Seed reserve dampness warning
- Storage pit moisture problem
- Pottery firing batch cracks
- Shelter wall loosening
- Thatch patch leak
- Fuel reserve below storm safety level
- Waste pit too near runoff route
- Drainage trench failure

### Social / second-NPC transitions
- Newcomer requests temporary stay
- Resident complains of unfair hauling burden
- Unsafe order hesitation
- Care burden complaint
- Shared food dispute
- Stranger distrust event
- Mentor frustration / teaching impatience
- Outsider leaves after low-trust interaction

### Health / care
- Infected cut suspicion
- Fever watch
- Smoke-cough in one resident
- Exhausted resident ignores rest warning
- Caregiver fatigue

## 14.4 Tiny hamlet events

### Collective operations
- Granary-equivalent cache pest breach
- Shared reserve accounting mismatch
- Missed maintenance causes leak or collapse
- Garden damage from animal intrusion
- Community work turnout dispute
- Water hauling queue delay crisis
- Child/elder equivalent dependent-care pressure later if used

### Social cohesion
- Cliques or pair-bond exclusion tension
- "Why is outsider getting rations?" complaint
- leadership confidence drop
- grief shock after serious event
- role mismatch resentment
- neglect accusation
- rumor/fear spread after illness

### Opportunity / growth
- Stranger with useful know-how
- Stranger with injury requiring care
- Nearby resource lead from traveler
- Seasonal abundance window
- chance to salvage from abandoned old campsite
- small social celebration after hardship, improving cohesion

---

# 15. First-playable minimum event set

A practical first implementation does not need every event above.  
A strong minimum set would be:

1. Severe thirst
2. Cold exposure
3. Wet bedding
4. Overexertion stumble
5. Minor cut
6. Burn from fire
7. Water vessel contaminated
8. Water reserve low
9. Unsafe water illness
10. Fuel stock soaked
11. Food spoilage found
12. Rodent or scavenger food theft
13. Hearth flare-up
14. Shelter leak in rain
15. Tick or mosquito pressure spike
16. Stranger arrival
17. Workload unfair complaint
18. Unsafe order refusal
19. Seed reserve dampness
20. Infected wound suspicion

This set already covers:
- body
- environment
- fire
- storage
- illness
- social strain
- outsider contact
- strategic reserve failure

---

# 16. Relationships to other design documents

## 16.1 Health / Injury / Care Spec
Defines body-state consequences, treatment, recovery, and care burden.
This event spec is the naming/trigger/presentation layer on top of that.

## 16.2 Environmental Hazard Spec
Defines chronic risk fields like cold, wetness, flood threat, vector habitat, smoke, and terrain danger.
This event spec turns those risks into active incidents.

## 16.3 Food / Water Safety Spec
Defines contamination pathways and handling rules.
This event spec surfaces failures and outbreaks from those rules.

## 16.4 Social / Recruitment Spec
Defines trust, belonging, grievance, outsider integration, and leadership legitimacy.
This event spec translates those into complaints, refusals, tensions, and arrival incidents.

## 16.5 Allocation / Ownership / Rationing Spec
Defines reserve logic and fair distribution.
This event spec creates disputes, shortfalls, and reserve misuse incidents when those systems are stressed.

## 16.6 Logistics / Hauling / Storage Flow Spec
Defines physical stock movement and storage placement.
This event spec covers dropped loads, broken containers, contamination during movement, and delayed essential hauling.

## 16.7 Master Simulation Loop Spec
Determines when events are checked, escalated, logged, and resolved.

---

# 17. Practical authoring rules

## 17.1 Good event authoring
A good event:
- has a clear cause
- changes priorities or reveals a weakness
- has at least one meaningful response
- can leave aftermath
- fits the current stage
- does not spam
- uses language the player immediately understands

## 17.2 Bad event authoring
Avoid events that:
- exist only for drama
- have no cause
- resolve automatically with no lesson
- are invisible but devastating without warning
- duplicate another event with no different gameplay meaning
- punish the player for information they could not realistically know

## 17.3 Event pacing
Early game should feel:
- tense
- interruptible
- fragile
- but not relentlessly chaotic

The player should believe:
> I could have prevented this if I had prepared better.

That is the right emotional outcome for a realism-first colony game.

---

# 18. Open questions for the next draft

These can wait until implementation or later expansion:

- How much hidden information should the player see without inspection?
- How many event families should use uncertainty vs certainty?
- How much text should event logs include?
- How many follow-up chains should be authored by hand vs emerge from generic state logic?
- Should opportunity events use the same framework as hazards, or a lighter "lead/opportunity" system?
- How often should outsider events occur in very isolated starts?
- When death exists, how explicitly should bereavement and body handling become eventized in the early slice?

---

# 19. Short conclusion

The event / incident layer should make the colony feel vulnerable, reactive, and real.

It should not behave like a random story machine.
It should behave like:
- weather meeting weak shelter
- unsafe water meeting poor storage
- fatigue meeting hard labor
- fire meeting careless layout
- scarcity meeting fairness pressure
- outsiders meeting trust and reserve limits

That is how events become believable.

The best early events in this project are not giant cinematic disasters.
They are:
- one wet bed before a cold night
- one infected cut during a labor crunch
- one cracked pot when water reserves are low
- one argument over fairness when food is tight
- one stranger arriving when the settlement is barely stable

That is where realism and story meet.

---

# References

These sources were used to ground the event / incident logic in real-world health, safety, and public-health patterns relevant to the early slice.

1. CDC, *Guidelines for Cleaning Safely After a Disaster*  
   https://www.cdc.gov/natural-disasters/safety/index.html

2. CDC, *Safety Guidelines: Reentering Your Flooded Home*  
   https://www.cdc.gov/floods/safety/reentering-your-flooded-home-safety.html

3. CDC, *What to Do to Prevent Getting Hurt or Sick After a Disaster*  
   https://www.cdc.gov/natural-disasters/response/index.html

4. CDC / NIOSH, *Ergonomic Guidelines for Manual Material Handling*  
   https://www.cdc.gov/niosh/media/pdfs/Ergonomic-Guidelines-for-Manual-Material-Handling_2007-131.pdf

5. CDC / NIOSH, *National Safety Month 2023 | NIOSH Science Bulletin*  
   https://www.cdc.gov/niosh/bulletin/2023/national-safety-month.html

6. WHO, *Household Water Treatment and Safe Storage*  
   https://iris.who.int/bitstream/handle/10665/206916/9789290616153_eng.pdf

7. WHO, *Water, sanitation and hygiene interventions to prevent diarrhoea*  
   https://www.who.int/tools/elena/interventions/wsh-diarrhoea

8. WHO, *Diarrhoeal disease*  
   https://www.who.int/news-room/fact-sheets/detail/diarrhoeal-disease

9. WHO, *Preventing diarrhoea through better water, sanitation and hygiene*  
   https://iris.who.int/bitstream/handle/10665/150112/9789241564823_eng.pdf

10. FEMA, *Shelter-in-Place Guidance*  
    https://www.fema.gov/sites/default/files/documents/fema_shelter-in-place_guidance.pdf

11. FEMA, *Winter Ready Toolkit*  
    https://www.fema.gov/sites/default/files/documents/fema_r5_winter-ready-toolkit_2024.pdf

12. CDC, *Mold Cleanup After Disasters*  
    https://www.cdc.gov/mold-health/media/Homeowners_and_Renters_Guide.pdf
