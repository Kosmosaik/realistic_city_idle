---
title: "Realistic Idle City - Pre-Tech Clothing / Bedding / Footwear / Body Maintenance Spec"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
assumptions:
  - "Pre-textile or minimal-textile early slice"
  - "Temperate starting biome"
  - "Cold, wetness, abrasion, and sleep quality matter"
status: "Design document"
date: "2026-04-14"
---

# Purpose

This document defines the early-game system for:

- simple body coverings
- bedding and sleep insulation
- foot and hand protection
- dryness management
- wear / tear / repair
- practical body maintenance burdens that affect labor capacity

The existing design stack already covers:
- shelter
- fire and warmth
- health and injury
- rest and sleep pressure
- allocation and rationing
- item classes and process thinking

What is still missing is a focused answer to:

- how early humans stay functional before advanced textiles
- how wetness, abrasion, and poor bedding degrade survival
- how simple clothing and footwear become meaningful early-game priorities
- how drying and mending become daily work rather than decorative detail

This is **not** a full textile industry document.
It is a **pre-tech and early-tech survival-wear document**.

---

# 1. High-level stance

## 1.1 This layer is about function, not fashion

In the early game, clothing and bedding exist to solve practical problems:

- warmth retention
- wind reduction
- wetness management
- sleep recovery
- skin protection
- abrasion reduction
- foot safety
- ability to keep working across repeated days

The game should treat body maintenance as a meaningful survival burden.

## 1.2 “Has shelter” is not enough

A camp can have a structure and still fail physically because:
- people sleep damp
- bedding never properly dries
- feet are damaged by mud, stone, cold, or constant wetness
- hands are exposed during cutting, hauling, or hide work
- no one reserves good coverings for those who most need them

This layer turns those truths into simulation and gameplay.

## 1.3 Scope boundary

This document covers:
- wraps
- cloaks / hide coverings
- simple belts / ties / cord fastenings
- foot wraps
- rawhide / hide footwear
- hand coverings only in simple form
- bedding materials and sleep insulation
- drying, storage, and repair

It does not yet cover:
- full loom-based textiles
- tailoring professions
- advanced layered clothing systems
- decorative status clothing

---

# 2. Core design goals

The system should make the player care about:
- staying dry
- protecting feet
- preserving one or two dependable sleep setups
- rotating items between use, drying, and repair
- allocating the best protection to the most exposed or vulnerable people
- understanding that body maintenance preserves labor power

---

# 3. Item families in scope

## 3.1 Basic body coverings
Examples:
- hide wrap
- fur or hide shoulder covering
- simple weather cape
- woven grass / reed temporary wrap where appropriate
- crude belt or cord tie

## 3.2 Foot protection
Examples:
- foot wrap
- bark or fiber foot covering
- rawhide slipper / moccasin-like simple shoe
- insulated simple footwear later within early slice

## 3.3 Hand protection
Examples:
- simple hand wrap
- crude work mitt
- hide scrap gripping wrap

These should be limited and rough, not perfect gloves.

## 3.4 Bedding and sleep materials
Examples:
- brush bedding
- dry grass bedding
- hide bedding layer
- fur bedding layer
- rolled sleeping wrap
- elevated / improved sleep setup later

---

# 4. Core item states

Every early wearable or bedding item should track a few meaningful states.

## 4.1 Dryness state
- dry
- slightly damp
- damp
- wet
- soaked

## 4.2 Condition state
- intact
- worn
- fraying / thinning
- damaged
- nearly failing

## 4.3 Cleanliness / contamination state
At minimum:
- acceptable
- dirty
- foul / contamination risk

This matters more for bedding, wraps used during sickness, and items dragged through waste or spoiled work areas.

## 4.4 Warmth / protection class
A simple numeric or tier value is enough:
- minimal
- low
- medium
- high for the early slice

## 4.5 Fit / usefulness category
Not exact tailoring.
Just:
- usable by anyone
- better for small frame
- better for large frame
- specialized for feet
- specialized for sleep only

---

# 5. Functional effects

## 5.1 Dryness effects
Dryness should strongly affect:
- sleep quality
- cold burden
- morale / comfort
- skin stress
- readiness for the next day

Sleeping in wet gear or on wet bedding should feel materially bad.

## 5.2 Foot protection effects
Footwear should affect:
- travel speed
- injury / soreness chance
- willingness to cross rough ground
- work endurance in wet and cold conditions

Bare or poorly protected feet should be viable only for mild / short tasks in forgiving conditions.

## 5.3 Hand protection effects
Simple hand coverings should reduce:
- abrasion
- minor cuts from rough hauling and hide work
- tolerance loss during repeated harsh tasks

## 5.4 Bedding effects
Bedding quality should affect:
- sleep recovery
- warmth during rest
- injury recovery support
- resilience in poor weather

Good bedding is one of the first real survival upgrades.

---

# 6. Body maintenance burdens

## 6.1 Dampness accumulation

NPCs should accumulate dampness from:
- rain exposure
- wet brush and ground contact
- stream crossings
- hauling in storms
- sleeping on wet bedding
- poor storage of body coverings

## 6.2 Wear accumulation

Wear should rise from:
- repeated use
- rough terrain
- hauling
- hide work and heavy kneeling work
- bad storage
- using sleeping materials for daytime work

## 6.3 Contamination accumulation

Items can become badly dirty from:
- waste area exposure
- blood or sickness use
- spoiled food handling
- muddy pooling zones
- prolonged damp rot conditions

---

# 7. Drying and preservation

## 7.1 Drying is a real camp function

The camp should need:
- a place to dry items
- time to rotate items
- fuel or sunlight / airflow decisions
- protection from rain during drying

Drying should be a real labor and layout concern.

## 7.2 Drying methods in the early slice
- near-fire drying with risk if poorly managed
- sun / air drying during good weather
- sheltered rack or line drying
- spreading bedding to air during safe daylight

## 7.3 Dry reserve concept

The settlement should try to preserve:
- at least one dependable dry sleep setup
- at least one dependable dry body covering
- one dry reserve for storm / sickness / newcomer emergency if capacity allows

This is especially important once the camp supports more than one person.

---

# 8. Repair and maintenance

## 8.1 Early repair methods
- re-tying
- patching with hide scraps
- rewrapping bindings
- drying and reshaping simple footwear
- replacing laces / cords
- discarding or demoting ruined items to lower-value uses

## 8.2 Repair should compete for labor

Repair is not free.
It uses:
- time
- materials
- attention
- sometimes the camp’s better tools or dry workspace

## 8.3 Degradation path

A useful early path is:
1. everyday use item
2. repaired item
3. rough-use item
4. sleep-only or emergency-only item
5. scrap / patch source
6. discard or fuel if appropriate material allows

This creates believable material life cycles.

---

# 9. Allocation logic

## 9.1 Best items should not always go to the most “important” worker

Allocation can prioritize:
- the sick or injured
- night fire keeper
- scout in bad weather
- person sleeping outdoors or in weaker shelter
- newcomer in emergency stabilization
- child / elder later when those systems arrive

## 9.2 Policy hooks

Player policy should be able to influence:
- preserve best bedding for injured
- reserve one dry wrap for storm emergencies
- do not send barefoot workers into rough / cold zones
- prioritize drying before low-value expansion work
- issue emergency clothing transfer during cold or wet crisis

---

# 10. NPC decision implications

NPC reasoning should include:
- avoid soaked bedding if alternative exists
- prefer drying valuable items before rain
- avoid rough route if footwear is poor
- use sleep-only coverings less for daytime labor if reserves are low
- protect better items from contamination
- seek repair or replacement when function drops below tolerable level

---

# 11. UI and readability requirements

The player should be able to see:
- who is under-protected
- who is sleeping badly because of dampness / poor bedding
- whether the camp has any truly dry reserve items
- whether foot protection is limiting route choices
- whether repair backlog is becoming dangerous

Useful readouts:
- dry sleep capacity
- protected feet count
- damp bedding count
- damaged wearables needing repair
- emergency reserve coverings

---

# 12. Early content suggestions

## 12.1 Suggested early items
- crude body wrap
- hide shoulder wrap
- simple weather cape
- foot wraps
- crude rawhide footwear
- dry grass bedding
- hide bedding roll
- drying rack / drying line
- repair scrap bundle

## 12.2 Suggested early tasks
- gather dry bedding material
- rotate bedding into sun
- move bedding under cover
- repair footwraps
- patch damaged wrap
- dry emergency sleep set before night
- strip ruined item for repair scraps

---

# 13. Failure cases this system should support

- the camp technically has shelter but everyone sleeps damp
- the scout returns with food but can barely walk the next day
- an injured NPC recovers slowly because the bedding is bad
- the group has enough hide, but no one made usable coverings
- one storm destroys effective sleep quality because there was no dry reserve

These are good realism failures because they are understandable and recoverable.

---

# 14. Relationship to other docs

This document should connect especially to:

- health / injury / care spec
- allocation / ownership / rationing spec
- item & material bible
- process bible
- building & structure bible
- early game player experience spec
- time / season / labor calendar spec
- logistics / hauling / storage flow spec

---

# 15. Final design rule

The early game should teach:

**dry, intact, usable body equipment preserves labor and survival.**

This layer should make the player respect the truth that a person can have food, water, and a roof nearby and still perform badly because:
- they are wet
- they are cold
- they slept poorly
- their feet are failing
- their bedding and coverings were neglected
