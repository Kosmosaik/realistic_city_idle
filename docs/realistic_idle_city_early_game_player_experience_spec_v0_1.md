---
title: "Realistic Idle City - Early Game Player Experience Spec"
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
  - "NPCs are autonomous embodied actors, not puppets"
  - "The player leads by priority, policy, layout, and intervention"
status: "Design document"
date: "2026-04-14"
---

# Purpose

This document defines the **player experience layer** for the early game.

The existing design stack already explains a great deal about:
- physical survival
- bodies, health, and stress
- items and materials
- processes and structures
- logistics and storage
- hazards and seasons
- recruitment and fairness
- player orders and task generation

What is still needed is one document that answers:

- what the player is actually trying to solve from moment to moment
- what makes the early game satisfying rather than merely correct
- how realism turns into readable choices
- how the first survival phase should pace tension, recovery, discovery, and growth
- what kinds of progress should feel meaningful to the player

This spec is not a replacement for the other documents.
It is the **player-facing synthesis layer** that sits on top of them.

---

# 1. High-level stance

## 1.1 The game should be fun because reality creates pressure

The early game should not become fun by ignoring realism.
It should become fun by making realistic pressures:
- legible
- actionable
- emotionally meaningful
- visibly improvable

The player should feel:

- “we might not make it through the next rain”
- “we can probably stabilize this if we stop doing the wrong work”
- “this camp is becoming more dependable”
- “that routine used to be a crisis”
- “the place is starting to work because of my judgment”

## 1.2 The player fantasy

The player is not a wizard and not a foreman of perfect robots.

The player fantasy is:

- founder
- organizer
- planner
- allocator
- risk manager
- practical leader under uncertainty

The player wins by making better judgments about:
- what matters first
- what can wait
- where things should be
- what must be protected
- who should do what
- when to intervene directly
- when to stop chasing growth and stabilize the camp

## 1.3 Core experiential rule

The early game should feel like **solving survival questions**.

Not:
- clicking for output
- spamming build orders
- chasing abstract score

But:
- can we stay dry tonight?
- can we keep the fire alive through dawn?
- do we have enough safe water?
- is this food safe to store?
- is this route worth the risk before dark?
- is taking in this newcomer wise right now?
- are we expanding too fast for our sanitation and reserve capacity?

---

# 2. Relationship to the existing design stack

This document should be read together with:

- early-game bible
- canonical early content pack
- player orders / policy spec
- UI information architecture spec
- task evaluation spec
- NPC simulation spec
- logistics / hauling / storage flow spec
- food / water safety spec
- health / injury / care spec
- social / recruitment spec
- time / season / labor calendar spec
- environmental hazard spec
- settlement progression spec

Those documents explain **what is true** in the simulation.

This document explains **how that truth should feel to play**.

---

# 3. Core player experience pillars

## 3.1 Concrete short-horizon problems

The player should always have one or more near-term questions that matter in human terms.

Good early-game questions:
- tonight’s sleeping dryness
- next day’s water safety
- fire continuity
- food spoilage risk
- shelter weatherproofing
- route safety before dark
- burden of an injured or weak person
- whether the group is orderly enough to take on more work

Bad early-game questions:
- maximize generic efficiency score
- stack as many buildings as possible
- unlock next tier because the tree says so

## 3.2 Problems becoming routines

A major source of satisfaction should be:

1. crisis
2. partial stabilization
3. routine
4. freed labor / attention
5. new level of responsibility

Examples:
- keeping a fire alive stops being a daily disaster
- water hauling becomes organized
- sleeping arrangements stop causing collapse
- basic storage becomes trustworthy
- waste handling stops contaminating camp space
- the group can finally spare labor for better structures or scouting

This is the intended feel of progression.

## 3.3 Visible before/after states

The player should clearly see when a problem has improved.

Visible improvements matter more than hidden numbers alone.

Examples:
- fuel stored under cover instead of exposed
- sleeping area becomes drier and cleaner
- fire is protected and no longer flickers on the edge of failure
- path is cleared and hauling looks faster
- water containers are closer to camp and handled better
- an NPC who used to look ragged and overburdened looks more stable
- a risky work zone becomes a controlled known route

## 3.4 Human-scale drama

The most effective early drama is small, concrete, and believable.

Good examples:
- a leak discovered during bad weather
- one bad spoilage event
- a stranger arriving at the wrong time
- a person returning late from a trip
- one injury that forces the camp to reprioritize
- a storage mistake that almost ruins reserves
- a storm that tests whether routines are real or superficial

The game should not need constant giant disasters.
Small believable setbacks are enough.

## 3.5 Recovery should feel earned

The player should be able to recover from many early failures if:
- they understand what went wrong
- they can reassign labor or policy
- they can sacrifice expansion for stabilization
- they still have at least one intact survival foundation left

The game should punish neglect and arrogance more than bad luck.

---

# 4. Core player verbs

The player’s main verbs should come from judgment, not excessive clicking.

## 4.1 Priority verbs

The player can:
- raise or lower urgency
- protect or release reserves
- change rationing or care policies
- switch focus between stabilization and expansion
- temporarily elevate one problem above others

## 4.2 Spatial verbs

The player can:
- choose where camp functions happen
- place or designate sleeping, storage, waste, work, and fuel areas
- pull risky activity away from contamination or exposure
- reshape flow so people walk less and work more safely

## 4.3 Commitment verbs

The player can:
- assign direct jobs
- call for emergency response
- halt nonessential work
- send scouting / foraging / hauling effort to one place instead of another
- decide whether the group absorbs a newcomer burden now or later

## 4.4 Interpretation verbs

The player can:
- read warnings
- inspect conditions
- compare burdens
- infer causes of failure
- notice patterns in weather, route risk, workload, and social strain

This interpretation layer is crucial.
The game should reward good reading of the camp.

---

# 5. The core early-game loop

The early game loop should be understood as:

1. **Observe**
   - What is unstable right now?
   - What is trending toward danger?
   - What did weather, illness, or labor shortage just change?

2. **Choose**
   - What matters most today?
   - Which reserve must be protected?
   - Which risk can be accepted?

3. **Order / shape**
   - Set priorities
   - change policies
   - place or adjust designations
   - issue direct work if necessary

4. **Watch consequences**
   - NPCs respond
   - camp flow changes
   - condition improves or degrades
   - hidden fragility may reveal itself

5. **Stabilize**
   - convert a problem into a routine
   - reduce repeated emergencies
   - preserve labor for the next challenge

6. **Expand carefully**
   - only add new burdens once foundations are dependable enough

---

# 6. Survival questions that should drive play

The game should constantly be able to formulate the camp’s condition as answerable practical questions.

## 6.1 Shelter and sleep
- Can everyone sleep under sufficient cover tonight?
- Is bedding dry enough to support recovery?
- Is wind / rain exposure still breaking rest?

## 6.2 Fire and fuel
- Can the settlement maintain one dependable live fire?
- Is enough dry fuel staged for night or storm?
- Is fire maintenance stealing too much labor?

## 6.3 Water
- Is drinking water safe enough?
- Is hauling burden sustainable?
- Is the chosen source too vulnerable to contamination or weather?

## 6.4 Food
- Is today’s food enough?
- Is tomorrow’s food enough?
- Is any valuable food about to spoil or be wasted?

## 6.5 Sanitation
- Is waste placement threatening camp hygiene?
- Is washing burden too low or too high?
- Is one bad habit poisoning the whole camp environment?

## 6.6 Health and function
- Is someone becoming too injured, cold, thirsty, sleep-deprived, or demoralized to perform?
- Is the player preserving labor capacity or burning it down?

## 6.7 Exploration and growth
- Is scouting worth the risk today?
- Is the group ready to absorb a stranger?
- Is this the right time to expand structures, or is it false progress?

---

# 7. Intended pacing of the first playable arc

## 7.1 Phase A - exposed survival

The first phase should feel fragile.

Typical pressures:
- exposed sleep
- unstable fire
- unreliable water practice
- labor spent on basic continuity rather than progress
- very small mistakes causing large consequences

Player emotion:
- caution
- urgency
- relief from small wins

## 7.2 Phase B - first stabilization

The player learns to secure:
- a dependable sleeping arrangement
- safer water practice
- protected fuel
- more orderly placement of the camp
- at least one or two real routines

Player emotion:
- “we can probably survive”
- “I understand this place better now”

## 7.3 Phase C - camp competence

The camp begins to function rather than merely persist.

New possibilities:
- limited reserve building
- controlled scouting
- better weather prep
- safer intake of help / newcomers
- more specialized work

Player emotion:
- competence
- cautious ambition

## 7.4 Phase D - transition toward permanent camp / tiny hamlet

Growth becomes socially and logistically meaningful.

New pressures:
- fairness
- division of labor
- reserve policy
- storage order
- newcomer integration
- sanitation and workflow strain caused by greater population

Player emotion:
- stewardship
- responsibility
- balancing growth against resilience

---

# 8. Milestone design

The game should not rely only on stage labels.
It should also track **practical milestones**.

## 8.1 Good milestone examples

- first dry sleeping night after rain
- first fully protected fuel reserve
- first dependable safe-water routine
- first proper waste separation from living space
- first storm survived without camp breakdown
- first successful scouting return before dark with meaningful discovery
- first time a second person joins and remains stable
- first time the camp can absorb a setback without near-collapse

## 8.2 Why milestones matter

Milestones should:
- give emotional shape to play
- teach the player what matters
- mark progress without becoming artificial quest markers
- show that capability is increasing in believable steps

## 8.3 Milestones should be observed, not merely granted

Where possible, milestones should be confirmed by the simulation:
- the reserve actually exists
- the sleeping area actually stayed dry
- the route actually worked
- the camp actually remained sanitary enough
- the newcomer actually integrated without destabilizing the whole group

---

# 9. Failure model

## 9.1 The player should usually fail by misjudgment, not randomness alone

Good failure causes:
- overexpansion
- poor reserve policy
- bad camp layout
- taking in too much burden too fast
- sending labor too far at the wrong time
- neglecting maintenance or dryness
- ignoring warning signs

## 9.2 Failures should teach

A failure should usually leave the player saying:
- “I protected the wrong thing”
- “I should have stopped expansion earlier”
- “I underestimated weather / distance / wetness / burden”
- “I solved the visible problem and ignored the real one”

## 9.3 Catastrophic unwinnable spirals should be limited early

The game can be harsh, but the early slice should favor:
- near misses
- costly recovery
- partial collapse
- meaningful tradeoffs

over:
- sudden irreversible total destruction from one opaque mistake

---

# 10. What makes the early game satisfying

The early game is satisfying when the player can feel all of the following:

- clearer judgment than before
- fewer repeat crises
- better organized space
- stronger routines
- more trustworthy reserves
- healthier and more capable NPCs
- more confident willingness to scout, build, or recruit
- survival turning into stewardship

The emotional transition should be:

**fear -> caution -> competence -> responsibility**

---

# 11. UI and feedback requirements

The player experience depends on readable information.

The UI should make it obvious:
- what is urgent
- what is merely inefficient
- what is trending toward danger
- what improved recently
- which routine is still fake and brittle
- who is becoming a bottleneck
- which reserve is safe versus performative

The player should be able to answer questions like:
- Why did this person stop working well?
- Why is the fire still unstable?
- Why is this route a problem?
- Why is the camp “technically alive” but visibly failing?
- What must be fixed before growth resumes?

---

# 12. Integration hooks for other docs

This document depends especially on:

## 12.1 Player orders / policy spec
The player experience succeeds only if policy choices genuinely change behavior.

## 12.2 UI information architecture spec
Warnings, inspections, comparisons, and camp condition readouts must make survival legible.

## 12.3 Task evaluation spec
NPCs must respond to danger and burden in a believable way, or player judgment stops feeling meaningful.

## 12.4 Canonical early content pack
Milestones and practical questions should map onto actual starter content and tasks.

## 12.5 Social / recruitment spec
Taking in new people should feel exciting, risky, and transformative, not like free labor.

## 12.6 Time / season / labor calendar spec
The year and the day must create real pacing pressure.

---

# 13. Implementation guidance for the early playable slice

For the first playable version, the game does not need every future system.
It does need the player experience loop to be clear.

That means the MVP should be able to express:

- fragile shelter vs dependable shelter
- wet vs dry sleep
- unstable vs stable fire continuity
- unsafe vs controlled water practice
- disorderly vs efficient storage / layout
- risky vs controlled excursions
- one or two social burden decisions that matter
- visible improvement after correct prioritization

If the player can feel those truths, the early game will already be much more engaging.

---

# 14. Final design rule

The early game should never ask:
**“How do we make realism less real so the game becomes fun?”**

It should ask:
**“How do we make realistic survival pressures understandable, consequential, and satisfying to solve?”**
