---
title: "Realistic Idle City - Exploration / Foraging / Route Risk Spec"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
assumptions:
  - "Temperate starting biome"
  - "Top-down minimal visuals"
  - "Exploration is grounded field movement, not fantasy fog-clearing"
status: "Design document"
date: "2026-04-14"
---

# Purpose

This document defines the early-game system for:

- scouting
- short-range exploration
- foraging trips
- wood / fiber / salvage outings
- route familiarity
- return timing
- burdened travel
- weather and daylight risk outside camp

The current design stack already includes:
- world site generation
- paths / roads
- hazards
- tasks
- logistics
- seasons and weather
- health and burden
- social risk and rescue possibilities

What is still missing is a focused answer to:

- how “going out” should actually work in the early game
- what makes one trip smart and another reckless
- how the player learns the land around the camp
- how distance, weather, load, and familiarity create real decision tension

This document defines that layer.

---

# 1. High-level stance

## 1.1 Exploration should feel local, embodied, and practical

In the early game, exploration is not a heroic expedition system.
It is practical movement through uncertain nearby terrain.

The important questions are:
- can they get there and back safely?
- what burden will they carry home?
- how much daylight margin exists?
- what does weather do to this route?
- how well is the path understood?
- what new opportunity or danger is being revealed?

## 1.2 The player should learn a place, not merely uncover a map

The map should not become “solved” just because it was seen once.

The camp should build layered knowledge:
- seen once
- walked reliably
- known only in dry weather
- known to flood or bog after rain
- good for wood but bad after dark
- safe if lightly loaded, bad if carrying weight
- good for summer forage, poor in cold months

That creates grounded discovery.

## 1.3 Early exploration is a risk/reward judgment layer

The player should not ask:
- “How fast can I clear the fog?”

The player should ask:
- “Is this trip worth today’s risk?”
- “Do we send someone alone or wait?”
- “Can they return before dark with that load?”
- “Will the rain change the route?”
- “Do we scout now or stabilize camp first?”

---

# 2. Types of outings in the early slice

## 2.1 Short forage trip
Goal:
- gather berries, roots, greens, reeds, kindling, or other nearby light resources

Traits:
- low load
- low range
- still sensitive to weather and daylight

## 2.2 Material gathering trip
Goal:
- gather wood, stone, clay, fiber, bark, or other heavier material

Traits:
- higher burden
- slower return
- greater route importance

## 2.3 Scout trip
Goal:
- identify water, shelter spots, useful resource pockets, safe routes, hazard areas

Traits:
- low immediate yield
- high information value
- meaningful risk because time spent scouting is time not spent stabilizing camp

## 2.4 Salvage / retrieval trip
Goal:
- return to a known point to collect something valuable

Traits:
- often urgent
- may happen in bad conditions because of perceived necessity

## 2.5 Search / rescue / follow-up trip
Goal:
- find missing person, confirm hazard, recover dropped goods, assist delayed return

Traits:
- emotionally and logistically intense
- should usually be rare but memorable

---

# 3. Core route knowledge model

## 3.1 Route knowledge states

Each route or travel corridor should have a knowledge state such as:
- unknown
- partially known
- known
- reliable
- conditionally reliable
- currently unsafe

## 3.2 Route knowledge is conditional

A route can be:
- good in daylight but poor at dusk
- good while unburdened but poor while hauling logs
- fine in dry weather but a mud trap after rain
- passable in summer but exposed in winter
- safe for one person, bad for group hauling

Knowledge should attach to conditions, not only to geography.

## 3.3 Familiarity should reduce uncertainty

Repeated use should improve:
- travel time confidence
- hazard anticipation
- willingness to route work there
- chance of late return
- ability to carry heavier loads efficiently

---

# 4. Main variables that define trip risk

## 4.1 Distance / time from camp
Risk rises as:
- walk time increases
- return window shrinks
- injury or delay becomes harder to absorb
- rescue becomes more expensive

## 4.2 Daylight margin
Trips should consider:
- departure time
- expected task duration
- return margin before dusk / darkness
- penalties if forced to travel in poor visibility

## 4.3 Weather
Risk rises with:
- rain
- strong wind
- cold
- storm approach
- fog or visibility loss
- stream changes after weather

## 4.4 Terrain difficulty
Terrain can raise:
- fatigue
- trip duration
- slip / fall / foot injury chance
- load inefficiency

## 4.5 Load burden
Returning with heavy, awkward, or fragile goods should:
- slow speed
- raise injury risk
- make route quality matter much more
- reduce ability to react to surprise danger

## 4.6 NPC condition and equipment
Trip viability depends on:
- thirst / hunger / fatigue
- foot protection
- injury state
- carried tools
- weather protection
- local knowledge

---

# 5. Risk categories the player should understand

## 5.1 Manageable risk
The trip is not perfectly safe, but the camp can accept it.

## 5.2 Elevated risk
The trip is possible, but should make the player hesitate.

## 5.3 Poor judgment risk
The trip is technically possible but likely reflects bad leadership given present conditions.

## 5.4 Emergency-only risk
The trip should normally be rejected unless it solves a greater immediate danger.

---

# 6. What exploration should reveal

Exploration should discover more than resources.

Good discoveries:
- reliable dry path
- hidden wet patch / mud trap
- water source quality differences
- seasonal berry or reed pocket
- wind-exposed ridge
- fallen wood source near camp
- flood-prone crossing
- sheltered work spot
- signs of animals or stranger movement
- possible future camp / sub-site potential

This turns local terrain knowledge into meaningful strategy.

---

# 7. Player controls for outings

The player should guide outings through policy and commitments rather than constant tactical micromanagement.

## 7.1 Area designation
The player can mark:
- preferred gather zone
- avoid zone
- scout zone
- emergency-only zone
- high-value salvage point

## 7.2 Risk tolerance settings
Possible policies:
- no distant work late in the day
- avoid stream crossings after storms
- do not haul heavy loads alone
- suspend exploration in severe weather
- prioritize familiar routes over shorter risky shortcuts

## 7.3 Direct outing commitments
The player can still issue direct orders such as:
- scout this corridor
- retrieve this item
- search for delayed worker
- gather emergency fuel from nearest safe source

---

# 8. Return timing and lateness

## 8.1 Late return should matter

A late return should cause:
- camp worry
- possible search dilemma
- missed evening routine labor
- greater exposure risk
- possible legitimacy or trust impact if leadership caused reckless timing

## 8.2 Causes of lateness
- overburdened haul back
- route degraded by weather
- poor daylight judgment
- injury / fatigue
- indecisive searching
- avoidable player risk choice

## 8.3 Late return should not always mean death

Good outcomes include:
- returns exhausted after dark
- drops some load to move faster
- reaches shelter point and returns next day
- requires assistance
- becomes a memorable warning for future route policy

---

# 9. Relationship between exploration and camp maturity

## 9.1 Lone survivor phase
Exploration is highly risky because every absence threatens camp continuity.

## 9.2 Primitive camp phase
Exploration becomes more viable once:
- sleep and fire are more stable
- water routine is safer
- minimal reserves exist

## 9.3 Permanent camp / tiny hamlet phase
Exploration becomes more strategic:
- specialization begins
- paired outings become possible
- route network knowledge deepens
- scouting can be justified for future growth

---

# 10. UI and readability requirements

The player should be able to inspect:
- estimated range from camp
- daylight safety margin
- route familiarity
- expected burdened return difficulty
- current weather interaction
- why a task is being deferred or refused

The UI should help the player read:
- “close but dangerous after rain”
- “safe when lightly loaded”
- “barely worth the trip before dusk”
- “good scout target, bad hauling target”
- “currently too risky for this worker”

---

# 11. Integration with other systems

## 11.1 Paths / roads
Any improvement to paths should make route reliability and burdened hauling meaningfully better.

## 11.2 Footwear / body maintenance
Poor feet or soaked clothing should directly reduce trip confidence and performance.

## 11.3 Weather / season
The same route should not behave identically across all conditions.

## 11.4 Social / recruitment
Newcomers may arrive through, be found through, or be lost through route events.

## 11.5 Player experience spec
Exploration is one of the main sources of discovery-driven fun in the early game.

---

# 12. Failure cases this system should support

- a “short” route proves awful under load
- the player sends someone too late and they return after dark
- a storm changes a familiar crossing
- the camp misses evening maintenance because one trip was misjudged
- a valuable find exists, but the camp is not yet stable enough to exploit it safely
- a resource patch is real, but not yet worth the walking burden

These are good failures because they are understandable and rooted in place.

---

# 13. Minimum viable implementation for the first playable slice

The first implementation does not need full world simulation.
It does need a believable local route layer.

Minimum valuable features:
- familiar vs unfamiliar route state
- daylight-aware outing judgment
- burdened return penalty
- weather modifier on at least some routes
- one or two visible hazard route tags
- clear player policy for “how risky should outings be right now?”

That is enough to make local exploration feel real and strategically interesting.

---

# 14. Final design rule

The early game should teach that **distance is not the only cost**.

What matters is:
- when the trip happens
- who goes
- what they carry
- how well the route is understood
- what the weather will do before they return
