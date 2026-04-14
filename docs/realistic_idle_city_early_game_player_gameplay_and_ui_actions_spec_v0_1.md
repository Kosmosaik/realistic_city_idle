---
title: "Realistic Idle City - Early Game Player Gameplay and UI Actions Spec"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
purpose:
  - "Define what the player actually does during play"
  - "Define what can be clicked, inspected, designated, and ordered"
  - "Define the control hierarchy for priorities, policies, roles, reserves, jobs, and emergency modes"
  - "Define the player-facing menus that make the realism stack feel like a game"
status: "New design spec derived from current review session"
alignment:
  - "Build on the existing player orders / policy spec"
  - "Build on the UI information architecture spec"
  - "Stay compatible with the MVP build stance"
---

# 1. Purpose of this document

This document translates the early-game simulation and policy stack into concrete player gameplay.

It answers:

- what the player does most of the time
- what the player can click on
- what commands the player can issue
- how orders and priorities should be structured
- what menus and panels make the game fun and readable
- how progression and generated tasks should be surfaced

This is not a graphics document.
It is a **player interaction and gameplay structure document**.

---

# 2. Core gameplay identity

## 2.1 Player role

The player is not primarily a puppeteer.
The player is primarily:

- planner
- organizer
- doctrine-setter
- crisis responder
- improvement chooser
- social decision-maker

## 2.2 What the player should feel like they are doing

The player should spend most of their attention on:

- reading camp state
- choosing what matters most right now
- adjusting priorities and permissions
- issuing a small number of focused interventions
- shaping layout and zone logic
- protecting key reserves
- selecting the next improvement or capability goal
- responding to requests, incidents, and emerging social tension

## 2.3 The intended loop

A strong early-game loop should generally look like:

1. notice a pressure, opportunity, or blocker
2. inspect why it exists
3. change policy, priority, zoning, or access rules
4. issue 1–3 targeted jobs if needed
5. pin or advance an improvement goal
6. watch the camp stabilize, fail, or partially recover
7. react to the next consequence

---

# 3. The four layers of player control

The player should interact through four distinct layers.

## 3.1 Layer A - Observation and diagnosis

The player sees:

- alerts
- reserve status
- NPC body state
- blocked tasks
- weather/risk
- route inefficiency
- structure condition
- social complaints or requests
- readiness blockers

This layer must be extremely readable.

## 3.2 Layer B - Standing doctrine

The player sets ongoing control rules such as:

- category priorities
- reserve protection
- allow/forbid rules
- stranger contact stance
- risky travel permission
- fire use restrictions
- role preferences
- care intensity
- build vs repair emphasis

This layer shapes the camp’s normal behavior.

## 3.3 Layer C - Tactical intervention

The player issues short, focused action orders such as:

- fetch water now
- haul this to shelter
- build this structure first
- boil this vessel
- dry these materials
- repair this structure
- seek shelter now
- rest now
- inspect this problem spot

This layer is powerful but should be used sparingly.

## 3.4 Layer D - Improvement and progression choice

The player chooses what the camp is trying to become better at.

Examples:

- safe water routine
- covered firewood storage
- proper dry sleeping area
- better food drying/smoking
- cleaner work separation
- stronger fuel reserve
- support for another person
- first reliable care stock

This layer provides much of the game’s long-term fun.

---

# 4. What the player can click on

The player should play primarily through the map and compact anchored interface panels.

## 4.1 Clickable world objects

The map should allow interaction with at least:

- NPCs
- structures
- containers / stockpiles
- zones
- placed items or item piles
- resource patches
- alerts / hazard markers
- task markers or route indicators
- knowledge or progression anchors where relevant

## 4.2 Recommended basic input rules

### Left-click
- select and inspect

### Right-click
- open contextual actions

### Drag
- designate zone
- paint area job
- place or expand structure footprint
- assign area-based gather / clear / move intent

### Double-click or list jump
- focus camera on target
- optionally open the relevant filtered inspector state

## 4.3 Why this interaction model works

It keeps the map central while still allowing deep information-heavy control.
It also avoids requiring giant detached menus for ordinary play.

---

# 5. NPC interaction design

## 5.1 What an NPC panel should show

Selecting an NPC should show:

- current task
- why the task was chosen
- whether the task is self-chosen or ordered
- hydration / hunger / fatigue / thermal / wetness / pain / illness state
- morale / social comfort / stress signal
- carried items
- current role preference
- recent work history or recent difficulties
- blockers
- reserve or policy restrictions affecting them
- complaints, requests, or trust reactions if relevant

## 5.2 What the player can do from an NPC panel

The player should be able to:

- set temporary focus
- set preferred role
- issue direct job
- issue “rest now”
- issue “seek shelter now”
- issue “report / stop current work if safe”
- inspect current reasoning breakdown
- compare with another NPC
- pin this NPC for monitoring

## 5.3 Why this is fun

The NPC becomes understandable and readable rather than random.
The player learns how body state, skill, role fit, and policy interact.

---

# 6. Structure, place, and item interaction design

## 6.1 Structure panel should answer

For any selected structure, area, or work support:

- what is it for
- is it usable now
- what condition is it in
- what risks does it have
- what processes does it support
- who uses it
- what stock is linked to it
- what policy or reserve rule affects it

## 6.2 What the player can do with structures

The player should be able to:

- raise or lower build priority
- raise or lower repair priority
- reserve the structure
- restrict who may use it
- set preferred use category
- inspect linked shortages
- inspect linked tasks
- assign or change local policy

## 6.3 Stockpile / container / item actions

The player should be able to:

- protect or reserve stock
- restrict or allow use
- mark as communal / personal / seed / care / storm reserve
- move or reassign destination
- forbid touching
- inspect who has reserved it
- inspect why it is not being used

## 6.4 Why this matters

Much of the project’s realism becomes gameplay through reserve control, material placement, and controlled access.

---

# 7. Zone interaction design

Zones are one of the strongest early-game clarity and fun tools.

## 7.1 Recommended early zones

- sleeping area
- hearth area
- clean water handling area
- dirty work area
- butchery area
- drying/smoking area
- latrine/waste area
- seed/garden area
- communal storage area

## 7.2 What zone editing should allow

- drag paint or click placement
- rename zone
- recolor zone
- set permissions
- set preferred storage categories
- set supported process categories
- highlight policy conflicts immediately
- jump to related alerts or contamination risks

## 7.3 Why zone play is important

Zones make spatial logic into actual gameplay.
The player improves the camp by making better separations and shorter, cleaner, safer route networks.

---

# 8. The order hierarchy

The control model should remain layered and readable.

## 8.1 Tier 1 - Standing priorities

These are always-available global priority bands.

Minimum early categories:

- water
- shelter
- food
- fuel
- care
- sanitation
- building

These should affect task generation visibility and task scoring influence.

## 8.2 Tier 2 - Allow / forbid control

Minimum early toggles:

- exploration
- stranger contact
- reserve use
- risky travel
- nonessential fires

These should be clear, global, and fast to change.

## 8.3 Tier 3 - Role preferences

Minimum early role preferences:

- generalist
- water/fuel
- food/prep
- builder/maintainer
- learner

These should influence but not fully hard-lock task behavior.

## 8.4 Tier 4 - Reserve rules

Minimum early reserve rules:

- protect seed
- protect clean water reserve
- protect storm fuel
- protect care stock

These should be visible everywhere they matter.

## 8.5 Tier 5 - Direct jobs

Minimum early job types:

- fetch
- haul
- build
- boil
- dry
- repair
- seek shelter
- rest now

### Strong recommended additions

- inspect / check
- stabilize / secure

Examples:

- inspect this water source
- inspect this damp store
- secure this food before rain
- stabilize this hearth setup

## 8.6 Tier 6 - Emergency modes

Minimum emergency modes:

- storm
- cold
- injury/care
- contamination/water safety
- fire

Emergency mode should temporarily reorder the objective structure of the camp without fully removing NPC self-preservation.

---

# 9. What remains under NPC control

To preserve realism, the player should not directly control everything.
NPCs should still govern:

- exact path choice
- local movement timing
- drinking/resting/warming interruption timing
- whether a direct job is too dangerous right now
- local opportunism when permitted
- micro-optimizations within skill/knowledge limits
- personal reaction to unfairness or over-control
- body-state-based delay or refusal

This preserves the project’s realism-first identity.

---

# 10. Menus and panels that make the game fun

The player needs stable information domains rather than a pile of detached windows.

## 10.1 Recommended core menu set

- Overview
- NPCs
- Tasks
- Inventory
- Structures
- Policies
- Knowledge / Capabilities
- Health / Safety
- History / Events

## 10.2 Always-visible compact surface

The main screen should also always surface:

- urgent alerts
- pinned goals
- highest-risk blockers
- reserve warnings
- current command mode

---

# 11. The Overview panel

The Overview panel is the camp heartbeat.
It should show at a glance:

- day / season / time block
- weather summary
- hazard summary
- population count
- urgent alert count
- potable water reserve
- edible food reserve
- dry fuel reserve
- available sleeping spots
- current settlement state/readiness state
- blocked task count
- injured / sick / exhausted count

It should answer one core question:

**What is most likely to hurt us next?**

---

# 12. The Tasks panel

The Tasks panel is critical to making the simulation feel fair.

## 12.1 Task categories to show

- open tasks
- reserved tasks
- blocked tasks
- forbidden tasks
- urgent survival tasks
- direct player jobs
- policy-triggered tasks
- emergency tasks
- follow-up or subtask chains

## 12.2 Each task row should show

- task type
- source
- location
- urgency
- assigned NPC if any
- blockers
- expected reserve impact
- reason it matters

## 12.3 Player actions on tasks

- boost
- assign if allowed
- forbid
- defer
- convert into project
- jump camera to source
- pin for tracking

---

# 13. Knowledge / Capabilities panel

## 13.1 Design stance

The project should use a grounded progression surface that behaves somewhat like a tech tree, but should not feel like an abstract fantasy tech tree.

Preferred framing:

- capabilities
- camp progress
- learned procedures
- workable methods
- what we are close to stabilizing

## 13.2 Suggested categories

- Water & sanitation
- Fire & fuel
- Shelter & bedding
- Food & preservation
- Storage & logistics
- Tools & materials
- Care & safety
- Social organization
- Early craft / construction

## 13.3 What each capability entry should show

- title
- short grounded description
- category
- what it unlocks
- current blockers
- required materials
- required structure or zone
- required knowledge or observed success threshold
- who can currently perform it
- current confidence / reliability
- whether it is personal knowledge or community-known

## 13.4 Example capability entries

- boiled water routine
- covered firewood storage
- reliable dry sleeping setup
- drying rack use
- smoking rack use
- simple pot forming
- clean/dirty handling separation
- seed reserve discipline
- stable care stock routine
- better hauling path practice
- temporary guest shelter
- apprenticeship routine

## 13.5 Pin as goal

The player should be able to pin a capability goal.
Doing so should:

- track blockers
- highlight missing resources
- highlight required structures/zones
- surface relevant NPC knowledge holders
- generate or prioritize supporting tasks

This is one of the strongest fun loops in the game.

---

# 14. Generated tasks and player-facing goals

The game should not rely only on player-created tasks.
It should also generate grounded tasks and goals from simulation state.

## 14.1 Four strong categories of generated tasks

### A. Survival needs
Examples:

- low potable water
- low dry fuel
- no usable sleeping protection
- contamination risk
- untreated injury or sickness

### B. Improvement opportunities
Examples:

- build covered storage
- establish drying area
- improve latrine separation
- reduce water hauling burden
- protect care stock

### C. NPC requests
Examples:

- request drier bedding
- warning about reserve misuse
- request safer work arrangement
- request chance to teach or learn
- complaint about unfair unpleasant work burden

### D. Knowledge / procedure tasks
Examples:

- test a drying method
- repeat a successful boiling routine
- gather materials for first vessel attempt
- assign learner with trainer
- formalize a stable process into routine

## 14.2 Why this system is good

It creates gameplay-rich task variety without turning the game into an artificial quest machine.

---

# 15. Projects system

## 15.1 Why projects matter

A flat task list is not enough.
The player also needs multi-step improvement arcs.

## 15.2 What a project is

A project is a player-facing improvement plan that can generate or group subtasks.

Examples:

- establish safe water routine
- prepare for storm
- make sleeping area weather-safe
- stabilize hearth use
- create dry fuel reserve
- support second-person arrival
- prepare first winter cache

## 15.3 What each project should show

- objective
- why it matters
- current blockers
- subtasks
- material needs
- related structures/zones
- expected payoff
- urgency if delayed

## 15.4 Why projects are fun

They give the player medium-term intention and turn realism into visible progress.

---

# 16. Requests / social decision panel

## 16.1 Purpose

Human texture is an important part of gameplay.
NPCs should not only generate labor; they should also generate readable social decisions.

## 16.2 Content examples

- complaints
- suggestions
- warnings
- trust/fairness concerns
- newcomer intake questions
- requests for rest/care
- requests for training or role change

## 16.3 Player responses

- approve
- deny
- defer
- change policy instead
- create task from request
- create project from request

## 16.4 Why this matters

This makes the player feel like they are governing a real group of people rather than only directing a logistics machine.

---

# 17. Readiness gameplay

One of the strongest non-arcadey gameplay loops available to this project is readiness.

## 17.1 Readiness categories worth surfacing

- tonight readiness
- rain readiness
- cold readiness
- reserve readiness
- illness/care readiness
- newcomer readiness

## 17.2 Why readiness is important

This gives the player a short-horizon play goal structure that feels highly realistic.
It also reduces over-reliance on rigid stage labels as the main source of progression.

## 17.3 Design recommendation

Use readiness surfaces and pinned goals aggressively in early play.
A large part of “fun” should come from turning a fragile camp into a prepared camp.

---

# 18. Alert-to-action design

Alerts should never be dead text.
Each alert should drive action.

## 18.1 Each alert should show

- what is wrong
- why it happened
- where it is happening
- what is blocking resolution
- what will get worse next if ignored
- suggested actions or linked surfaces

## 18.2 Example alert flow

Alert:
“Rain incoming. Dry fuel reserve low.”

Player response options:

- raise fuel priority
- pin storm prep project
- lock storm fuel reserve
- assign gather deadwood job
- move exposed stock
- suspend nonessential fires
- assign one NPC to water/fuel focus

This is the kind of grounded, fun gameplay flow the project should encourage repeatedly.

---

# 19. What the player should spend most of their time doing

The player should mostly be:

- reading the camp
- setting policy
- protecting stock
- placing zones and structures
- choosing what to improve next
- responding to alerts and requests
- issuing occasional tactical jobs

The player should **not** mostly be:

- manually controlling every step
- spamming low-level move commands
- drag-moving every item individually
- micromanaging pathing

That would break the intended identity.

---

# 20. Example early-game play loop

A representative short play sequence might look like this:

1. Player notices low dry fuel and incoming rain.
2. Player clicks the alert and jumps to the affected stock and route overlay.
3. Player raises fuel priority and activates storm mode.
4. Player locks storm fuel reserve.
5. Player drag-designates a better dry storage area.
6. Player issues one gather/haul job and one repair/secure job.
7. Player opens capabilities and pins “covered firewood storage” as the next improvement.
8. Supporting subtasks appear or are highlighted.
9. An NPC complains about soaked bedding.
10. Player converts that request into a sleeping-area stabilization project.

This is the intended kind of grounded, playable decision chain.

---

# 21. Recommended next implementation/document priorities

## 21.1 Highest-value immediate follow-ups

1. define exact context actions per clickable object type
2. define exact task row/action formatting
3. define capabilities panel data schema
4. define project schema and project-to-task logic
5. define readiness panel / readiness calculation surface
6. define NPC request and social decision event formatting

## 21.2 Strong related companion document

A companion spec should be written for:

**early-game routine and maintenance cadence**

This would connect gameplay to recurring upkeep burdens and readiness pressures.

---

# 22. Final summary

The player gameplay of the early game should be built around:

- map-centered inspection
- layered control
- doctrine over puppeteering
- targeted tactical intervention
- readiness and improvement goals
- grounded capability progression
- projects and generated tasks
- social requests and incident response

This approach keeps the project realistic while making it meaningfully gameable.
