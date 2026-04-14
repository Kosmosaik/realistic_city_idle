---
title: "Realistic Idle City - Early Game Realism / Fun / Gameplay Audit"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
purpose:
  - "Capture the conclusions reached in the current design review session"
  - "Identify what is already covered well in the early-game design stack"
  - "Identify what is still missing or under-specified for realism and player-facing gameplay"
  - "Recommend the highest-value next documentation and design priorities"
status: "Working audit for design alignment"
---

# 1. Purpose of this document

This document records the design conclusions reached during the current review session focused on:

- early-game realism coverage
- what is still under-specified
- how to improve player fun without sacrificing realism
- what documentation should be created next

This is not a replacement for the existing simulation, UI, policy, logistics, health, or progression specs.
It is a cross-document audit and direction-setting note.

---

# 2. High-level conclusion

## 2.1 Core verdict

The early game is now **strongly covered at the systems level**.

The current document stack already covers the major real-life survival and camp-stabilization pillars well enough that the project is not missing a major foundational realism domain.

Covered pillars already include:

- water access, handling, treatment, and reserve logic
- food gathering, preparation, spoilage, and preservation
- fire, fuel, shelter, dryness, and sleep protection
- sanitation, contamination, waste separation, and illness pressure
- hauling, route cost, storage, stockpoint logic, and access rules
- health, injury, care, and recovery burden
- weather, seasons, labor rhythm, and environmental risk
- embodied NPC logic, morale, and self-preservation
- social trust, newcomer integration, reserve fairness, and work burden
- site generation, terrain relevance, and settlement viability

## 2.2 The real gap is no longer “missing realism pillars”

The strongest remaining gap is now:

**player-facing lived experience**

More specifically:

- the day-to-day feel of running the camp
- the exact decisions the player makes minute to minute
- how the player reads problems and responds through controls
- how progression is surfaced in an exciting but grounded way
- how realism turns into satisfying gameplay rather than just dense simulation

## 2.3 Design implication

The project does **not** mainly need more big realism bibles right now.

The project mainly needs:

- stronger routine-level detail
- stronger player gameplay structure
- stronger “read problem -> intervene -> stabilize -> improve” loop design
- stronger UI/action clarity

---

# 3. What is already covered well enough

## 3.1 Early-game realism domains that are already in good shape

The current docs appear strong enough in the following areas for the intended early-game slice:

### A. Survival basics
- hydration
- food pressure
- fatigue
- thermal exposure
- wetness
- shelter need
- sleep need
- fire continuity

### B. Sanitation and safety
- clean/dirty separation
- contamination risk
- waste handling
- care stock
- illness risk
- emergency water handling

### C. Material reality
- explicit item location
- carrying burden
- storage suitability
- reserve protection
- spoilage
- environmental exposure

### D. Labor reality
- travel time
- route inefficiency
- task scoring
- role fit
- interruption by body state
- skill effect
- training effect

### E. Social realism
- fairness
- trust
- burden-sharing
- guest/stranger handling
- legitimacy of player choices
- reserve and access doctrine

### F. Settlement progression reality
- camp quality derived from actual conditions
- support readiness for more people
- practical thresholds instead of purely decorative stage labels

## 3.2 Conclusion on coverage

The early game is no longer “thin.”
The simulation-side foundation is already broad and believable.

---

# 4. What is still under-specified for realism

These are not missing pillars.
They are under-specified **resolution layers** that would make the early game feel more lived-in and more believable.

## 4.1 Domestic maintenance burden

The current stack covers the major systems, but the daily maintenance rhythm still needs stronger consolidation.

Important examples:

- vessel cleaning
- ash disposal
- bedding dryness maintenance
- clothing drying after rain or wet labor
- routine camp cleanup
- checking vulnerable stores for dampness or contamination
- simple tool and binding upkeep
- replacing worn cordage, wraps, poles, and containers

### Why this matters

In real early settlement life, survival is not only acquisition.
It is also constant maintenance.
A camp often fails through neglected upkeep, not only lack of resource acquisition.

## 4.2 Camp micro-site realism

The design stack already treats map/site viability seriously, but the camp-level micro-environment could be pushed further.

Examples:

- roof drip lines
- muddy traffic lanes
- shelter entrances becoming wet or worn
- runoff problems after rain
- pooled water near sleeping or working areas
- wet firewood storage from bad placement
- unpleasant or unsafe camp corners emerging naturally from layout mistakes

### Why this matters

This would make layout quality matter more and would produce more natural camp stories.

## 4.3 Tool / clothing / carrying-kit upkeep loop

The project should make it clearer that early tools and personal equipment are not permanent.

Examples:

- re-sharpening
- re-binding
- patching wraps or carrying gear
- replacing degraded simple containers
- drying or protecting important wearable gear
- keeping bedding and sleep-related materials usable

### Why this matters

This creates both realism and recurring gameplay pressure without requiring fantasy systems.

## 4.4 Pest / scavenger / camp ecology pressure

The MVP does not need a huge ecology simulation.
But it would benefit from stronger local consequences for sloppy camp management.

Examples:

- exposed food attracting scavengers
- damp stores becoming low-quality
- bad refuse placement increasing nuisance pressure
- dirty handling areas increasing contamination pressure

### Why this matters

This makes camp order and cleanliness matter for more than abstract numbers.

## 4.5 Scenario variation as realism

The project would benefit from several grounded early starts instead of one narrowly implied setup.

Examples:

- poor shelter terrain but easy water
- good shelter terrain but long water walk
- cold/wet opening
- injury opening
- early second-person arrival vs delayed arrival
- good deadwood but weak food access

### Why this matters

This adds realism through circumstance rather than through artificial difficulty settings alone.

---

# 5. What is still under-specified for gameplay

## 5.1 The player-facing loop is not documented deeply enough yet

The simulation documents describe how the world works.
The missing piece is a more concrete definition of:

- what the player is actually doing every minute
- what they click on
- what control layers they use most often
- what kinds of decisions are intended to feel satisfying
- how progression should be surfaced
- how alerts turn into action
- how the player experiences success, recovery, and improvement

## 5.2 The project needs a stronger “camp leadership” play pattern

The player should mainly feel like they are:

- reading the state of the camp
- setting doctrine and restrictions
- protecting key reserves
- deciding where work should happen
- intervening in moments of danger or opportunity
- choosing which improvement to pursue next
- handling social and readiness tradeoffs

That is the intended gameplay identity.

## 5.3 The project needs stronger short-horizon play goals

A realism-first colony game becomes much more fun when the player is repeatedly trying to improve near-term readiness, not only long-term stage advancement.

Strong near-term goals include:

- make tonight survivable
- reduce tomorrow’s labor burden
- prepare for incoming rain
- secure 2–3 days of water or fuel
- create one protected reserve
- support one more person safely

These are stronger gameplay drivers than abstract progression alone.

---

# 6. How to make the game more fun without sacrificing realism

## 6.1 Main principle

Do not solve “fun” by making the simulation less grounded.
Solve it by making realism produce:

- clearer choices
- clearer consequences
- stronger anticipation
- stronger readability
- stronger visible competence growth

## 6.2 The strongest fun sources for this project

### A. Preparedness gameplay
The player should repeatedly prepare for:

- tonight
- next rain
- next cold period
- illness/care burden
- arrival of another person

### B. Layout optimization gameplay
The player should get real value from improving:

- route length
- clean/dirty separation
- fuel storage placement
- shelter arrangement
- work area placement
- reserve protection

### C. Recovery / salvage gameplay
Mistakes should create interesting recovery play instead of only punishment.

Examples:

- bedding got soaked -> drying effort and sleep tradeoff
- food is close to spoilage -> emergency processing push
- fire continuity failed -> next-day fatigue consequences and response
- bad refuse placement -> nuisance pressure -> cleanup/relocation

### D. Knowledge-to-routine gameplay
A strong realism-first reward loop is:

- try method
- fail or partly succeed
- learn workable method
- stabilize method
- spread method socially
- institutionalize it as camp routine

### E. Socially legible gameplay
NPCs should not only be labor units.
Their needs, objections, requests, and observations should produce readable, grounded player decisions.

Examples:

- request for drier sleeping arrangement
- complaint about too much hauling burden
- warning about reserve misuse
- suggestion to move dirty work away from water handling
- request to teach or learn a procedure

---

# 7. Highest-value additions recommended

## 7.1 New documentation to create first

### 1. Early-game player gameplay / UI action spec
This is the single highest-value new document.
It should define:

- what the player clicks on
- what menus/actions exist
- how orders are issued
- how priorities work
- how alerts are resolved
- how progression is surfaced
- what the expected minute-to-minute loop is

### 2. Early routine / maintenance cadence spec
A companion document should define recurring routine burdens such as:

- water/fuel checks
- camp cleanup
- bedding/clothing dryness maintenance
- ash and waste handling
- simple repair and replenishment

### 3. Scenario start pack spec
This should define grounded early starting-condition variants.

### 4. Readiness / goal surfacing spec
This should define how the player sees:

- tonight readiness
- rain readiness
- cold readiness
- reserve readiness
- newcomer readiness

## 7.2 Systems and content to emphasize next

The project should emphasize these gameplay-rich areas before adding many more late-era systems:

- readiness-driven short-horizon goals
- player-facing progression visibility
- contextual tasks and projects
- NPC requests and suggestions
- stronger alert-to-action flows
- stronger route/layout consequences

---

# 8. Recommended design stance on “unlocks”

## 8.1 Keep the idea, but ground the language

The session discussion concluded that an “upcoming unlocks” surface is a good idea.
However, it should not feel like a fantasy or arcade tech tree.

Preferred framing:

- capabilities
- camp progress
- what the settlement is close to stabilizing
- learned procedures
- workable methods

## 8.2 Why this framing is better

This preserves realism by making progression feel tied to:

- observation
- repeated success
- materials on hand
- working conditions
- social knowledge transfer
- structural readiness

rather than purely abstract unlock points.

---

# 9. Final summary

## 9.1 Audit summary

The early game is already well covered in major realism terms.
The current design stack does **not** appear to be missing a major foundational survival or settlement pillar.

## 9.2 What still matters most

The project now needs stronger definition of:

- player-facing gameplay
- moment-to-moment control
- routine maintenance burden
- readiness and short-horizon goals
- grounded progression surfacing

## 9.3 Best next step

The single strongest next step is to create a concrete gameplay/UI action spec for the early game and use it to connect the existing realism stack to actual play.
