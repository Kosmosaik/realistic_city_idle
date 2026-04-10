---
title: "Realistic Incremental/Idle Colony-to-City Game - Player Orders / Policy Spec"
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
  - "Player requests/orders things to happen"
  - "NPCs are autonomous embodied actors, not puppets"
  - "Simulation remains object-based from the start"
date: "2026-04-08"
---

# Purpose

This document defines the **player control layer** for the current design stack.

It answers:

- what the player is actually allowed to control
- what remains under NPC judgment
- how orders become tasks and policies
- how reserves, safety, care, and legitimacy are shaped by player choices
- how control should feel in a realism-first idle/incremental colony game

This spec is meant to sit on top of the existing stack:

- early-game bible
- NPC simulation spec
- NPC data schema
- task evaluation spec
- item & material bible
- process bible
- building & structure bible
- settlement progression spec
- knowledge & discovery spec
- social / recruitment spec
- allocation / ownership / rationing spec
- health / injury / care spec
- environmental hazard spec
- food / water safety spec
- logistics / hauling / storage flow spec
- master simulation loop spec

---

# 1. Relationship to the existing design set

This document does **not** redefine physical reality, logistics, physiology, health, hazard, or material ownership.

It defines how the player **steers** those systems.

This follows the direction already present in the design stack:

- the player influences priorities, not physical law
- player intent should matter strongly, but not infinitely
- NPCs must still preserve themselves under collapse or extreme danger
- fairness, voice, and confidence in leadership should affect colony stability
- reserve policy, rationing policy, and stranger-intake policy are meaningful early-game decisions
- small settlements need policy and governance before they need bureaucracy

So this document is not a “click to force action” system.
It is a **colony-governance and command layer**.

---

# 2. High-level design stance

## 2.1 The player is a leader, not a puppeteer

The player should feel like:
- founder
- organizer
- planner
- allocator
- crisis leader
- priority setter

The player should **not** feel like:
- remote mind-controller
- omnipotent cursor god
- animation dragger
- direct body owner of every NPC at every second

The player can say:
- "water is top priority"
- "no one touches seed reserve"
- "you two focus on shelter repair"
- "temporary guests may eat but not access strategic stores"
- "everyone seek shelter now"
- "assign Mara to food drying training"
- "this zone is the clean water area"
- "stone hauling is urgent today"

The player cannot truly say:
- "ignore hypothermia and keep digging"
- "teleport that bundle to camp"
- "sleep is forbidden forever"
- "carry more than your body can carry"
- "use seed without opening reserve policy"
- "drink contaminated water and suffer no consequences"

## 2.2 Policy before micromanagement

A realism-first idle colony game works best when the player spends most of their attention on:

- standing rules
- priorities
- work permissions
- reserve doctrine
- role assignments
- zone layout
- exceptions during crises

and only occasionally on:
- a one-off direct job
- a rescue override
- an emergency evacuation
- a specific training push
- a specific item issue or protection rule

This creates a more believable colony-management feeling than constant click-for-click body control.

## 2.3 Direct control still has a place

Because the colony begins with one person and almost no infrastructure, the player should still be able to issue **direct jobs**.

Examples:
- fetch water from that source
- gather deadwood in this patch
- move bedding into the shelter
- light or relight this hearth
- boil a vessel of water
- dry this hide
- build this lean-to here

But even direct jobs should still be mediated by:
- feasibility
- access
- body state
- safety
- reserve rules
- current emergency doctrine
- social willingness later

## 2.4 The control layer must be legible

The game should tell the player:
- what they ordered
- how the order was interpreted
- why it was accepted, delayed, interrupted, or refused
- what policy blocked it
- what reserve it would consume
- what danger it would expose the NPC to
- what alternative the NPC selected instead

A realism-first design becomes frustrating if the player cannot understand why the colony acted the way it did.

## 2.5 Legitimacy is a gameplay system

Player control is not only mechanical.
It is social.

Repeatedly irrational, unsafe, unfair, or humiliating policies should reduce:
- trust
- confidence in leadership
- compliance
- morale
- willingness to endure hardship
- openness of voice and warnings

Consistent, transparent, and survival-relevant leadership should improve:
- trust
- voluntary cooperation
- resilience under scarcity
- mentorship acceptance
- smoother task execution
- lower conflict during shortages

---

# 3. Research anchors informing this spec

This spec is grounded in a few strong real-world ideas.

## 3.1 Autonomy, competence, and relatedness

Self-determination theory argues that autonomy, competence, and relatedness are basic psychological needs that support motivation, internalization, and well-being.
For this design, that means control should not erase all NPC agency.
A well-led colony still allows:
- some discretion
- role fit
- learning
- meaningful contribution
- social belonging

## 3.2 Worker participation and voice

OSHA emphasizes worker participation in establishing, operating, evaluating, and improving safety and health programs.
For this game, that supports:
- NPC warnings
- complaints
- suggestions
- visible preference signals
- stronger outcomes when people have some voice in risky or burdensome work

## 3.3 Fatigue degrades judgment

NIOSH repeatedly notes that fatigue can reduce attention, memory, concentration, reaction time, and judgment.
So the player-control system should not assume perfect compliance or perfect execution under:
- sleep loss
- heavy workload
- heat
- illness
- prolonged stress

## 3.4 Emergency command has different logic from normal work

FEMA incident-management doctrine strongly emphasizes:
1. life safety
2. incident stabilization
3. protection of property and environment

That maps very well onto a settlement command model.
Normal policy can be flexible.
Emergency policy must become sharper.

## 3.5 Opaque algorithmic control harms trust and autonomy

NIOSH has also discussed the downsides of opaque algorithmic management and loss of worker autonomy.
That supports a design where:
- scoring and policy outcomes are legible
- NPCs are not treated like silent black-box drones
- the player gets explanations for compliance and refusal
- colony members are allowed to communicate burden, concern, and conflict

---

# 4. Scope boundaries

This document is limited to the current early slice:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

So the command layer here focuses on:

- direct manual jobs
- standing survival policy
- rationing and reserve rules
- role assignment
- zone designation
- stranger/contact policy
- shelter and work access
- emergency doctrine
- training preferences
- fairness and compliance consequences

This document does **not** yet fully define later:
- municipal law
- tax policy
- wage contracts
- guild charters
- voting structures
- industrial shift management
- district-level bureaucracy
- formal legal courts

---

# 5. Core control principles

## 5.1 Control changes behavior through priorities, permissions, and commitments

The player mainly acts by changing:

- **priority**  
  What the colony should consider more important.

- **permission**  
  What is allowed, restricted, or forbidden.

- **reservation**  
  What stock, space, or labor is protected or earmarked.

- **assignment**  
  Who is expected to focus on what.

- **designation**  
  What a place means: clean water zone, refuse pit, sleeping area, drying yard, work area.

- **commitment**  
  A direct one-off instruction, usually represented as a job ticket or special directive.

## 5.2 Orders should be bounded, not absolute

An order should generally be able to fail or defer because of:
- immediate danger
- collapse risk
- blocked access
- reserve lock
- missing tools/materials
- conflicting higher-priority emergency
- severe morale/trust issues later
- lack of knowledge or confidence

## 5.3 Safety outranks convenience

The control system should strongly bias toward:
- seeking shelter under severe exposure
- avoiding contaminated water when alternatives exist
- not burning strategic fuel casually
- not eating seed reserve casually
- interrupting tasks when injury or collapse risk becomes high
- not forcing novices into high-risk tasks without crisis justification

## 5.4 Policy should matter more than repetitive clicking

The player should be rewarded for:
- building good standing rules
- creating sensible work zones
- maintaining reserves
- assigning the right people
- setting good exception thresholds
- reading warnings and adjusting policy early

not for:
- spam-clicking identical micro-commands

## 5.5 The player must be able to override, but overrides have cost

Sometimes the colony really does need a hard push:
- bring water in a storm
- move embers before rain kills the fire
- retrieve a child or weak NPC
- evacuate from flood channel
- use preserved food early
- open care reserve
- force immediate repair before night

The player should be able to do this.

But the game should record consequences:
- fatigue increase
- trust cost
- injury risk
- reserve depletion
- morale cost
- future scarcity

---

# 6. Command architecture

The control layer works best as a stack, from broadest to narrowest.

## 6.1 Layer A — foundational doctrine

High-level colony stance.

Examples:
- survival-first
- preserve seed at all costs
- shelter-before-expansion
- care for vulnerable first
- balanced growth
- strict reserve discipline
- compassionate intake
- cautious stranger policy

This is not a frequent click layer.
It is a framing layer for default behavior and player intent.

## 6.2 Layer B — standing policies

Persistent rules the colony follows until changed.

Examples:
- potable water reserved for drinking/cooking only
- no seed consumption
- guests may receive emergency food only
- storm fuel is locked
- nasty tasks rotate if possible
- care of injured outranks routine gathering
- direct fire use only in designated zones
- no raw hide in sleeping zone
- children/weak later cannot enter hazard zones without escort

## 6.3 Layer C — spatial designations

Rules attached to map spaces.

Examples:
- clean water fill area
- washing area
- latrine zone
- refuse pit
- carcass work area
- hearth zone
- drying rack zone
- sleeping shelter zone
- clay work area
- seed storage
- protected reserve cache
- temporary guest shelter

These designations influence:
- what tasks can spawn there
- what items may be stored there
- contamination risk
- morale
- logistics efficiency
- NPC willingness

## 6.4 Layer D — role and labor preferences

Who the colony expects to focus on what.

Examples:
- founder = survival generalist
- NPC 2 = water / fuel logistics
- NPC 3 = food drying / meal prep
- NPC 4 = builder / shelter maintainer
- learner = apprentice in hide work
- strongest carrier = heavy hauling preference

These are **preferences and expectations**, not magical class locks.

## 6.5 Layer E — production / reserve / storage rules

Material governance.

Examples:
- reserve levels
- issue permissions
- stockpile priorities
- bed allocation
- tool return policy
- clean-vessel policy
- protected seed storage
- guest ration rules
- fuel ration rules
- emergency release thresholds

## 6.6 Layer F — task priority bands

Category-level importance.

Examples:
- water > shelter repair > fuel > food drying > gathering clay
- care > sanitation > routine expansion
- harvest spike tasks elevated during seasonal window
- rain prep tasks elevated before storm front

This layer is the main bridge between policy and the task evaluator.

## 6.7 Layer G — direct job tickets

Specific requests from the player.

Examples:
- "haul these branches to camp"
- "rebuild this lean-to"
- "boil this pot"
- "fetch this dropped tool"
- "repair this container"
- "escort stranger to guest shelter"
- "move this item into reserve storage"

These tickets may expire, fail, be superseded, or be reinterpreted if conditions change.

## 6.8 Layer H — incident command / emergency mode

Temporary crisis command structure.

Examples:
- cold emergency
- storm prep
- wildfire smoke
- flash-flood escape
- contamination event
- shelter collapse
- hunger crisis
- illness cluster
- predator threat

Emergency mode can:
- reorder priorities instantly
- open or close reserves
- restrict travel
- direct all NPCs to shelter or fire/fuel/water tasks
- suspend low-priority jobs
- tighten or relax stranger policy

---

# 7. What the player controls

## 7.1 Always-available early controls

The player should always be able to:
- pause/unpause and change speed
- inspect NPC status
- inspect item ownership/access state
- inspect reserve levels
- inspect zone designation
- change category priorities
- allow/forbid broad task groups
- set or adjust standing policies
- place buildings/structures/markers
- designate storage and work areas
- assign preferred roles
- issue direct job tickets
- toggle emergency modes
- review warnings and reasons

## 7.2 Medium-granularity controls

The player should also be able to:
- assign one NPC to a temporary focus
- reserve a structure or container
- protect specific stock
- change who may access a stockpile
- change stranger-contact rules
- define training targets
- define care intensity
- define burden-sharing rules for nasty tasks
- approve risky reserve release
- prioritize repair vs new construction

## 7.3 High-granularity controls that should exist but be used sparingly

The player may also issue:
- one-off "do this now if feasible" orders
- "drop current task and report" orders
- "escort / carry / deliver" orders
- "rest now" orders
- "seek shelter now" orders
- "do not touch this" orders
- "use this exact item/container" orders

These are powerful and should be socially and cognitively costly if overused.

---

# 8. What remains under NPC control

Even with strong player authority, NPCs should still govern:

- exact path choice
- local opportunism when allowed
- moment of interruption due to body state
- whether they must drink/rest/warm first
- whether a direct order seems too dangerous
- whether a task should pause because of nearby hazard
- social reactions to unfair burden or humiliation
- local warning generation
- micro-optimizations within their competence

This keeps the simulation believable.

---

# 9. Categories of player control

# 9.1 Survival policy

Controls the basic life-support doctrine.

Examples:
- emergency water collection threshold
- who may use potable water
- minimum fire maintenance level
- nighttime shelter-before-work doctrine
- wet-clothing emergency priority
- storm preparation trigger
- cold-night fuel threshold
- whether long-range exploration is allowed

# 9.2 Food, water, and reserve policy

Derived heavily from the allocation/rationing spec.

Examples:
- meal ration state
- preserve dried food
- open preserved stores only below threshold
- no seed release
- guest feeding allowed / restricted / emergency only
- clean water for drinking/cooking only
- field-water issue required
- reserve water trigger
- care reserve access permissions
- storm fuel lock

# 9.3 Work distribution policy

How labor is assigned.

Examples:
- strict player assignment
- preferred roles with override
- volunteer-first inside priority bands
- rotation for dirty/unpleasant work
- skilled-only for critical tasks
- apprentice slots open / limited
- founder carries final override authority

# 9.4 Role and training policy

How the colony grows competence.

Examples:
- broad generalist culture
- specialist push for food preservation
- prioritize teaching water safety
- mentor one novice per expert
- training tasks allowed only at low hazard
- no experimentation during scarcity
- quality-first training vs throughput-first training

# 9.5 Safety and hazard policy

How cautious the settlement is.

Examples:
- no travel into flood channels
- no open fire inside enclosed shelter
- avoid smoke-heavy zones after dark
- no lone travel beyond safe radius
- injury risk threshold for interrupting work
- no novice carcass handling without clean surface
- weather work cutoff
- lightning shelter doctrine
- severe cold work reduction
- aggressive tick/mosquito avoidance later if relevant

# 9.6 Social and intake policy

How the colony treats outsiders and internal voice.

Examples:
- deny contact
- aid at distance only
- temporary guest
- probationary intake
- immediate intake only in rare cases
- equal rationing
- need-based rationing
- labor-priority rationing
- founder-priority shelter
- vulnerability-priority shelter
- soft complaint channel
- normal complaint channel
- strong voice consequences if ignored
- formal mentorship for newcomers
- no full store access until trust threshold

# 9.7 Construction and layout policy

How physical effort is directed.

Examples:
- shelter-first building
- storage-first building
- sanitation-first layout
- firewood staging near hearth
- no raw-hide work in sleeping core
- clean and dirty zones strictly separated
- drying structures before decorative expansion
- fenced garden protection priority
- temporary shelter expansion during stranger intake

# 9.8 Logistics policy

How movement and stock flow are managed.

Examples:
- nearest-use stock first
- preserve central reserve stock
- cache at source allowed
- do not split loads below threshold
- long haul only with container support
- daily water-haul windows
- fuel staging before storm
- return tools to rack
- assign stronger haulers to heavier loads
- no mixing dirty/clean vessels
- protected seed handled only by designated keeper

# 9.9 Care policy

How much labor and stock are devoted to health.

Examples:
- minimal survival care
- balanced care
- protect vulnerable
- high-compassion mode
- rest orders enforceable
- care reserve release threshold
- who gets bedding first
- who gets warmth priority
- who may pause work to assist care tasks

---

# 10. Direct orders and job tickets

## 10.1 Why direct orders are needed

The earliest game begins with:
- one person
- no institutions
- no routines
- no established specialization

So the player needs the ability to issue specific work requests.

Without this, the early game can feel disconnected.

## 10.2 Direct order types

### A. Immediate action order
"Do this next if feasible."

Examples:
- fetch water
- add fuel
- move inside shelter
- carry hide to rack
- relight hearth

### B. Short project order
Finish a bounded multi-step task.

Examples:
- build lean-to
- boil one vessel batch
- gather enough deadwood for tonight
- set up a drying rack
- prepare a latrine area

### C. Delivery / transfer order
Move a specific thing or class of thing.

Examples:
- move safe water to shelter storage
- move seed to protected cache
- move raw meat to drying area
- bring tool to work area

### D. Escort / accompany order
Stay with another NPC or group.

Examples:
- escort weak arrival to shelter
- accompany novice to water source
- carry wounded person with helper later

### E. Stop / avoid order
Prevent an action or class of actions.

Examples:
- no one touch seed cache
- stop using this water source
- stop burning dry reserve fuel
- stop entering smoke-heavy zone

### F. Reassignment order
Change current focus.

Examples:
- stop gathering clay and return for storm prep
- abandon expansion and repair shelter
- shift from foraging to care support

## 10.3 Direct order lifecycle

A direct order should move through these states:

1. issued
2. interpreted
3. checked for blockers
4. accepted / deferred / rejected
5. converted into task(s) or sub-tasks
6. reserved
7. executed
8. interrupted / completed / failed / expired
9. reported back to the player

## 10.4 Direct orders are not absolute puppeteering

A direct order should still be blocked by:
- impossible path
- missing item
- protected reserve
- unsafe exposure
- collapse risk
- higher emergency mode
- contradictory standing policy unless override exists
- no knowledge to perform safely
- lack of trust/obedience in more advanced social states

## 10.5 Override strength bands

Useful model:

### Soft order
Strong preference, easy to supersede.

### Normal order
Expected next action if feasible.

### Strong order
Should be obeyed unless safety or impossibility blocks it.

### Emergency order
Temporarily overrides most non-safety rules.
Still cannot override hard physical impossibility.
Should carry social and fatigue consequences if abused.

---

# 11. NPC interpretation of player intent

## 11.1 Order understanding

An NPC should not merely see raw task IDs.
They should interpret:
- what is being asked
- how urgent it is
- whether it conflicts with current emergency
- whether they are the intended person
- whether required tools/items/zones exist
- whether they believe they can succeed

## 11.2 Acceptance score

A practical hidden variable for direct orders:
**acceptance score**

Contributors:
- trust in leadership
- discipline/obedience trait
- perceived fairness
- role fit
- confidence in ability
- hazard perception
- fatigue
- pain
- hunger/thirst severity
- relationship with order source later if authority differentiates
- whether the order makes obvious survival sense

## 11.3 Refusal conditions

An NPC may refuse or auto-defer when:
- at collapse threshold
- in immediate environmental danger
- order requires crossing hard forbidden hazard
- task is effectively impossible with current tools
- order is blocked by protected reserve and no override exists
- severe illness or injury is active
- trust/legitimacy has collapsed badly later

Early game should keep outright refusal relatively rare except under genuine danger or impossibility.
The player should not feel powerless.
But refusal should exist enough to preserve realism.

## 11.4 Delay conditions

An NPC may delay even when accepting:
- must drink first
- must warm up first
- must drop unsafe load first
- must finish micro-commit point of current process
- must find missing container/tool
- must wait for another NPC to clear a bottleneck
- must rest briefly to avoid injury spike

---

# 12. Compliance, legitimacy, and trust

## 12.1 Compliance is not the same as morale

A person may comply while:
- resentful
- frightened
- exhausted
- skeptical

So the system should separate:
- immediate compliance
- emotional response
- long-term trust
- future willingness

## 12.2 What increases legitimacy

Player choices should improve legitimacy when they are:
- survival-relevant
- clearly explained in UI
- consistent over time
- fairness-aware
- competence-aware
- protective of vulnerable bodies
- visibly reserve-conscious
- respectful of effort and burden
- responsive to warnings

## 12.3 What damages legitimacy

Player choices should reduce legitimacy when they are:
- irrational
- obviously unsafe
- contradictory
- humiliating
- careless with reserves
- unfairly burdening the same people
- ignoring voice repeatedly
- assigning work grossly mismatched to competence
- wasting food/water/fuel while asking for sacrifice

## 12.4 Enforcement styles

Useful policy posture options:

### A. Gentle expectation
Strongly preferred, weak social penalty if ignored.

### B. Normal expectation
Standard colony rule.

### C. Strict enforcement
High compliance pressure, stronger morale cost if rule seems unfair.

### D. Crisis discipline
Temporary sharp compliance due to emergency mode.
Should not stay on indefinitely without social cost.

---

# 13. Voice, complaints, and requests

## 13.1 Why voice must exist

A realism-first colony should not have silent NPCs.
People should signal:
- discomfort
- concern
- danger
- overload
- resentment
- preferences
- requests for help or reassignment

## 13.2 Types of voice signals

### A. Passive preference signal
Examples:
- low enthusiasm
- visible reluctance
- “prefers food work”

### B. Operational warning
Examples:
- “this water source is muddy”
- “the shelter leaks”
- “the drying rack is too full”
- “I’m too tired for another heavy haul”

### C. Complaint
Examples:
- “I keep getting the dirtiest tasks”
- “the guest got warm bedding before me”
- “we are burning reserve fuel”
- “that order was reckless”

### D. Request
Examples:
- reassignment
- rest
- training
- mentorship
- shelter change
- care access

### E. Refusal / pushback
Rare early, more relevant later if trust breaks.

## 13.3 How the player should receive voice

Through:
- alerts
- NPC thought/status tooltips
- settlement notices
- policy conflict markers
- “why task failed” reasons
- trust/fairness trend indicators
- event cards for repeated unresolved grievances

## 13.4 Consequences of ignoring voice

Ignoring warnings should increase:
- accidents
- spoilage
- bad task fit
- hidden resentment
- trust decay
- complaint intensity
- future refusal risk

---

# 14. Emergency command doctrine

## 14.1 Emergency priorities

Following the spirit of real incident command, emergency mode should prioritize:

1. life safety
2. incident stabilization
3. protection of critical property, reserves, and environmental safety

## 14.2 Common early emergencies

- cold snap
- heavy rain / shelter failure
- rising water / flood channel threat
- fire spread
- loss of hearth
- potable water collapse
- severe injury
- illness cluster
- predator threat
- smoke overload
- spoiled core food stock
- reserve breach

## 14.3 What emergency mode does

Emergency mode may:
- suspend low-priority tasks
- elevate shelter / care / water / fuel / rescue tasks
- allow stronger direct orders
- unlock special reserve-release prompts
- tighten zone access
- concentrate labor
- create mandatory report points
- shorten task reevaluation interval
- change stranger/contact policy temporarily

## 14.4 Emergency mode should not be free

Costs:
- fatigue spikes
- morale strain
- reserve depletion
- postponed growth work
- trust loss if emergency mode is used carelessly or falsely
- injury risk if the player runs repeated false alarms

---

# 15. Policy categories in detail

# 15.1 Food policy

Possible controls:
- equal ration
- need-based ration
- labor-adjusted supplement
- vulnerable-first supplement
- guest feeding level
- preserved food release threshold
- emergency hunger mode
- shared meal expectation
- raw-food handling restrictions
- no eating from seed cache
- founder priority allowed / disallowed

Social consequences:
- equal ration may feel fair but ignore hard labor differences
- labor-priority ration may improve output but create resentment
- vulnerable-first may improve legitimacy but reduce work pace
- harsh guest restriction may protect reserves but harm social reputation

# 15.2 Water policy

Possible controls:
- potable-only for drinking/cooking
- process-water separation
- field-water issue for long hauls
- boil-before-use threshold
- emergency clean reserve lock
- personal water carry required beyond range
- unsafe-source ban
- rainy-period water harvesting priority
- vessel-cleanliness requirement

# 15.3 Fuel policy

Possible controls:
- maintain active burn pile minimum
- dry reserve lock
- storm reserve lock
- evening comfort fire allowed / restricted
- smoking/drying fuel approval requirement
- wet-fuel use allowed only if necessary
- greenwood burning discouraged
- emergency burn threshold

# 15.4 Tool policy

Possible controls:
- personal issue when possible
- return-to-rack required
- shared rack allowed
- worksite lock
- novice-use restrictions for sharp/hazardous tools
- emergency reclaim allowed
- damaged tool auto-repair queue
- no using food vessels for dirty process work

# 15.5 Shelter and bedding policy

Possible controls:
- founder priority
- vulnerability priority
- role priority
- equal claim after acceptance
- guest shelter only
- dry sleep layer priority
- reserve bedding release threshold
- no raw dirty work items in sleep zone
- smoke limit inside shelter
- crowding tolerance band

# 15.6 Stranger policy

Possible controls:
- no contact
- aid at distance
- supervised contact only
- guest access only
- probationary intake
- immediate intake
- food access band
- shelter access band
- work permission band
- reserve access prohibited until trust threshold

# 15.7 Work distribution policy

Possible controls:
- strict direct assignment
- preferred roles with override
- volunteer-first inside priority bands
- rotation for nasty tasks
- skilled-only critical work
- broad generalist expectation
- learner shadowing allowed
- care tasks shared / specialized
- hauling assigned to strongest carriers

# 15.8 Care policy

Possible controls:
- minimal survival care
- balanced care
- protect vulnerable
- high compassion
- forced rest threshold
- who may pause work to help
- care reserve access
- warm bedding priority
- infection/isolation caution rules

# 15.9 Mentorship / training policy

Possible controls:
- no formal mentorship
- sponsor new arrivals automatically
- teach only critical roles
- broad apprenticeship culture
- novice work only under supervision
- quality-first instruction
- throughput-first training pause during crisis
- trial-and-error allowed / restricted

# 15.10 Voice policy

Possible controls:
- preferences only
- normal complaints and requests
- strong morale penalty when ignored
- anonymous-style broad concern channel later if abstraction needed
- warning-first routing
- role-based deference later

---

# 16. How policies affect the task system

Policies should not sit in a separate menu universe.
They must change live task behavior.

## 16.1 They can change candidate generation

Examples:
- fuel-saving policy suppresses comfort-fire tasks
- strict stranger policy suppresses full-integration tasks
- no seed consumption suppresses meal-use task candidates
- training policy spawns more apprentice-compatible tasks

## 16.2 They can change scoring

Examples:
- water emergency boosts water logistics tasks
- preserve dried food policy lowers routine consumption score
- skilled-only policy reduces novice success expectation
- vulnerability-priority shelter policy raises care/shelter transfer scores

## 16.3 They can change permissions

Examples:
- guests cannot access strategic reserve
- only seed keeper may open seed store
- no novice carcass processing without clean zone
- only assigned handler may issue medicinal or care reserve stock later

## 16.4 They can change interruption logic

Examples:
- strong storm mode interrupts distant foraging
- smoke hazard mode interrupts drying-yard work
- care-first emergency interrupts low-value expansion
- nightfall doctrine interrupts exploration

## 16.5 They can change reporting

Examples:
- strict reserve doctrine creates stronger warnings when reserve use is attempted
- strong voice policy surfaces more complaints visibly
- skilled-only policy logs why direct assignment was refused
- clear emergency doctrine shows "life safety override" messages

---

# 17. Interaction with ownership, reserves, and access

## 17.1 Player control must respect ownership classes

Because the allocation spec already distinguishes:
- personal intimate goods
- issued tools
- communal stock
- strategic reserve
- reproductive reserve
- care reserve

player orders must interact with those classes explicitly.

## 17.2 Order permission checks

Before a direct job can commit, the system should ask:
- is the item accessible?
- is the item personally issued?
- is it communal?
- is it protected reserve?
- who has issue rights?
- is emergency override active?
- would this violate seed doctrine, care reserve, or water reserve rules?

## 17.3 Policy should be the normal way to touch protected stock

The player should rarely be asked to micromanage a single grain.
Instead:
- set release thresholds
- set emergency rules
- approve crisis override prompts
- designate handlers
- read future-cost warnings

---

# 18. Policy resolution order

When multiple rules conflict, use a stable order.

Suggested order:

1. physical impossibility
2. immediate life safety
3. hard emergency doctrine
4. health/care interruption
5. protected reserve locks
6. standing safety policy
7. direct order strength
8. role assignment / work distribution policy
9. ordinary category priority
10. preference and interest

This helps make outcomes explainable.

---

# 19. Player-facing UI and legibility requirements

Because the visual presentation is minimal, the control layer must be extremely legible.

## 19.1 Every order should show:

- issuer/source (player, policy, emergency mode)
- target NPC or eligible group
- urgency level
- required inputs
- expected location
- reserve impact
- current status
- blockers
- fallback if known

## 19.2 Every policy should show:

- active state
- what it changes
- who is affected
- what exceptions exist
- what reserve thresholds matter
- what warning signs trigger escalation
- likely social tradeoffs

## 19.3 NPC tooltip / panel should show:

- current task
- why this task was chosen
- current direct order if any
- whether acting voluntarily or under assignment
- whether worried, resistant, or compliant
- key blockers
- body-state reasons for interruption
- trust/fairness reaction if relevant

## 19.4 Reserve and restriction feedback should show:

- what is protected
- why it is protected
- who may access it
- what would release it
- what future cost release would create

## 19.5 Emergency mode UI should show:

- current emergency type
- current objective order
- active overrides
- time urgency
- exit conditions
- visible consequences if ignored

---

# 20. Suggested data model

## 20.1 Policy object schema

Each policy should minimally include:

- id
- name
- category
- scope (settlement / zone / group / role / individual)
- active_state
- priority_weight_modifiers
- task_generation_modifiers
- permission_rules
- interruption_rules
- reserve_rules
- exception_rules
- social_effect_profile
- visibility_text
- trigger_conditions
- expiry_conditions
- audit_log_reference

## 20.2 Direct order / job ticket schema

- id
- issuing_time
- issuing_source
- target_scope
- order_type
- strength_band
- target_object / location / process
- desired_deadline
- required_items
- required_skill_hint
- reserve_override_flag
- emergency_link
- acceptance_state
- refusal_reason if any
- expiration_time
- fallback_rule
- completion_report

## 20.3 NPC order-response fields

Per NPC, useful runtime values:

- current_order_id
- perceived_order_urgency
- acceptance_score
- compliance_state
- current_blocker
- protest_state
- trust_in_leadership
- perceived_fairness
- current_role_commitment
- voice_pending_flag
- emergency_mode_exemption flag if any

---

# 21. Example policy bundles

## 21.1 Lone-survivor opening bundle

- water top priority
- no long-range exploration in darkness
- shelter before expansion
- maintain minimum fire if possible
- boil suspicious water before storage
- no raw carcass processing in sleeping spot
- preserve dry bedding
- gather enough fuel for night before optional projects

This is mostly silent default policy because only one NPC exists.

## 21.2 Primitive-camp conservative bundle

- strict potable/process water separation
- storm fuel reserve
- no seed consumption
- basic latrine discipline
- dry food preservation before experimentation
- repair shelter before camp beautification/expansion
- role preference: one food, one water/fuel, one maintenance/generalist
- guests only after reserve check
- voice policy normal

## 21.3 Tiny-hamlet balanced-growth bundle

- moderate role specialization
- broad apprenticeship
- strategic reserve locked
- vulnerability-based care
- nasty-task rotation
- probationary stranger intake
- seed handled only by keeper
- daily status review for water, food, fuel, care, shelter
- social voice visible but not dominant
- emergency mode available for weather and illness events

---

# 22. First-playable recommendation

To keep the first implementation manageable, the earliest version should not try to expose every policy at once.

## 22.1 Minimum player controls to implement first

### Global priorities
- water
- shelter
- food
- fuel
- care
- sanitation
- building

### Allow / forbid toggles
- exploration
- stranger contact
- reserve use
- risky travel
- nonessential fires

### Role preferences
- generalist
- water/fuel
- food/prep
- builder/maintainer
- learner

### Reserve rules
- protect seed
- protect clean water reserve
- protect storm fuel
- protect care stock

### Direct jobs
- fetch
- haul
- build
- boil
- dry
- repair
- seek shelter
- rest now

### Emergency modes
- storm
- cold
- injury/care
- contamination/water safety
- fire

## 22.2 NPC control to preserve from the first build

Even in the first implementation, preserve:
- self-preservation interruption
- body-state-based delay
- reserve lock refusal
- warning generation
- visible reason for deferral
- role-fit influence

## 22.3 Policies that can wait

These can be added later:
- nuanced complaint handling
- complex guest access ladders
- fine-grained bedding rights
- layered shelter law
- later household ownership doctrines
- formal disciplinary structures
- later industrial shift policy

---

# 23. Anti-patterns to avoid

## 23.1 Total puppet control
Breaks realism and removes the value of NPC traits, interests, trust, and body state.

## 23.2 Hidden policy effects
If a policy changes behavior invisibly, the game becomes confusing.

## 23.3 Infinite player override
If the player can always brute-force any action, reserves, health, danger, and legitimacy stop mattering.

## 23.4 Silent NPCs
Removes the social layer and makes leadership feel meaningless.

## 23.5 Too many tiny policy switches too early
The system should be rich, but not unusable.
Bundle where possible.

## 23.6 Punishing the player without explanation
Every refusal, delay, or conflict should have a clear reason.

---

# 24. Open questions for the next draft

These do not block v0.1, but are worth deciding later.

- How much direct order spam should be tolerated before morale/control penalties appear?
- Should the founder’s orders carry more legitimacy than later delegated leaders?
- Should there be a “strict obedience” doctrine trait interaction for certain NPCs?
- When does the colony gain delegated leadership roles?
- How formal should work rosters become in later eras?
- How much should the player be able to script repeated routines?
- When should complaint systems become more formal than simple warnings/morale effects?

---

# 25. Short conclusion

The right player-control model for this project is:

- broad policy and reserve governance
- meaningful role and zone assignment
- clear task priorities
- bounded direct orders
- visible emergency command
- NPC autonomy under real physical and social limits
- legitimacy and trust as real outcomes of leadership

That keeps the game aligned with the existing realism-first design:

people are embodied,
matter has location,
reserves matter,
safety matters,
and the player leads a colony rather than dragging chess pieces.

---

# References

These sources were used to ground the realism and management logic of this spec.

- OSHA, *Safety Management - Worker Participation*  
  https://www.osha.gov/safety-management/worker-participation

- OSHA, *Recommended Practices for Safety and Health Programs*  
  https://www.osha.gov/safety-management  
  https://www.osha.gov/sites/default/files/publications/OSHA3885.pdf

- OSHA, *Be Safe + Sound at Work: Worker Participation*  
  https://www.osha.gov/sites/default/files/SHP_Worker_Participation.pdf

- CDC/NIOSH, *Fatigue and Work*  
  https://www.cdc.gov/niosh/fatigue/about/index.html

- CDC/NIOSH, *Work-related Fatigue Reaches Beyond the Workplace*  
  https://www.cdc.gov/niosh/blogs/2020/fatigue-work.html

- CDC/NIOSH, *The Who, What, How and When of Implementing Fatigue Management*  
  https://www.cdc.gov/niosh/bulletin/2021/fmdt_implementation.html

- CDC/NIOSH, *Using Total Worker Health Concepts to Reduce Fatigue*  
  https://www.cdc.gov/niosh/docs/wp-solutions/2019-102/default.html

- CDC/NIOSH, *Social Connection and Worker Well-Being*  
  https://www.cdc.gov/niosh/bulletin/2023/social-connection-and-work.html

- CDC/NIOSH, *Algorithms and the Future of Work*  
  https://www.cdc.gov/niosh/bulletin/2022/algorithms-fow.html

- FEMA, *National Incident Management System*  
  https://www.fema.gov/sites/default/files/2020-07/fema_nims_doctrine-2017.pdf

- FEMA, *ICS Organizational Structure and Elements*  
  https://training.fema.gov/emiweb/is/icsresource/assets/ics%20organizational%20structure%20and%20elements.pdf

- Ryan, R.M. & Deci, E.L. (2000), *Self-Determination Theory and the Facilitation of Intrinsic Motivation, Social Development, and Well-Being*  
  https://selfdeterminationtheory.org/SDT/documents/2000_RyanDeci_SDT.pdf

- Ryan, R.M. & Deci, E.L. (2020), *Self-Determination Theory: Basic Psychological Needs in Motivation, Development, and Wellness*  
  https://stial.ie/resources/Ryan%20and%20Deci%202020%20self%20determination%20theory.pdf
