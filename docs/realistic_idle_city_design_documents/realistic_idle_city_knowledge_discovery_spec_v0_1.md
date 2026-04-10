---
title: "Knowledge & Discovery Spec"
version: "v0.1"
scope:
  - "Lone Survivor"
  - "Primitive Camp"
  - "Permanent Camp"
  - "Tiny Hamlet / Proto-Settlement"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
---

# Knowledge & Discovery Spec v0.1

## Purpose of this document

This document defines how **knowledge** should work in the game.

It answers:

- what counts as knowledge versus skill, aptitude, interest, memory, and intuition
- how one NPC with ordinary human intuition learns about survival, materials, risk, and craft
- how discoveries become reliable camp know-how rather than one-off lucky accidents
- how knowledge moves from one person to another through observation, imitation, explanation, correction, and shared work
- how a camp's knowledge base grows from fragile personal know-how into durable settlement practice
- how players issue orders without turning the game into a flat tech tree
- how knowledge should be stored in data for future Godot implementation

This document sits on top of the existing design set and is meant to connect:

- the early-game design bible
- the NPC simulation spec
- the NPC data schema
- the task evaluation spec
- the item & material bible
- the process bible
- the building & structure bible
- the settlement progression spec

---

# 1. Relationship to the existing design set

The current design stack already established several crucial truths:

- the game should not use a fantasy-like research tree as its main logic
- early progression should stay focused on one NPC, primitive camp, permanent camp, and tiny hamlet
- interest, aptitude, and skill are separate
- tasks require believable conditions, inputs, and know-how
- settlement growth depends on food, water, shelter, storage, sanitation, and labor division
- buildings are not empty shells; they create real working conditions
- later society should eventually depend on records, education, and institutional memory

The earliest design document already described the right broad model: not a standard tech tree, but a **knowledge ecology** with discovery knowledge, procedural knowledge, tool knowledge, measurement knowledge, institutional knowledge, and scientific knowledge. fileciteturn21file1

This document turns that broad idea into a usable system.

---

# 2. Core doctrine

## 2.1 No magic unlocking

A recipe does **not** become usable because a generic research bar filled.

Instead, a process becomes available because the settlement has enough of the following:

- **exposure** to relevant materials, places, or events
- **attention** to what matters
- **interpretation** that converts observation into a usable idea
- **practice** that converts an idea into a repeatable process
- **transmission** that spreads the process beyond one body
- **stabilization** that keeps the process alive through routine, teaching, or records

## 2.2 Ordinary human intuition exists

The starter NPC is **not** a blank slate.

They begin with:

- basic body-protective instincts
- common-sense responses to discomfort, hunger, thirst, fatigue, cold, fear, and dirt
- rough intuitive ideas about shelter, fire, carrying, tying, covering, drying, cooking, and tool use
- a personality, interests, and aptitudes

But they do **not** begin with a perfect mental library of safe procedures, stable crafts, or efficient systems.

Example:
- the NPC may understand that water matters and a fire is useful
- the NPC does **not** automatically know the most reliable local way to store grain, soften hides, temper clay, or keep a latrine from contaminating camp

## 2.3 Knowing that something exists is different from knowing how to use it

The game should distinguish between:

- noticing a thing
- understanding what it might be good for
- knowing how to use it safely
- knowing how to produce it reliably
- knowing how to teach it
- knowing how to build a larger system around it

Example:
- seeing clay in a riverbank is not the same as knowing it can become a storage vessel
- making one accidental pot is not the same as having repeatable pottery
- having one skilled potter is not the same as a settlement with pottery knowledge

## 2.4 Knowledge is embodied before it is institutional

In the early game, most knowledge lives in bodies, habits, gestures, and repeated routines.

Only later does it become more durable through:

- named roles
- repeated work sites
- shared vocabulary
- demonstration routines
- teaching traditions
- records, marks, measurements, and manuals
- formal schools and technical institutions

This matters because the early settlement is fragile:
if one NPC dies, gets sick, leaves, or becomes overworked, some knowledge may partially disappear with them.

## 2.5 Knowledge should feel realistic, not academic for its own sake

The system is not here to simulate philosophy of knowledge.
It is here to make civilization feel earned.

A good knowledge system should answer gameplay questions like:

- why can this camp now keep seed safely from one season to the next?
- why do these NPCs stop ruining hides as often?
- why is fire use now more stable?
- why can a new arrival learn weaving faster in this settlement than in an empty wilderness?
- why does a hamlet keep functioning when one specialist is absent?

---

# 3. What "knowledge" means in this game

Knowledge is **usable understanding** that changes what an NPC or settlement can do, how safely they can do it, how consistently they can do it, and how well they can pass it on.

Knowledge is not identical to:

## 3.1 Interest
Interest affects willingness, attention, persistence, and learning speed.

Example:
- an NPC highly interested in plants may spend more time noticing seasonal growth, seed heads, edible patches, and useful fibers

Interest does not automatically give correct conclusions.

## 3.2 Aptitude
Aptitude affects ceiling, error rate, learning efficiency, and fit.

Example:
- one NPC may have excellent material intuition and hand precision, making them much more likely to become a good potter or basket maker

Aptitude does not replace exposure or practice.

## 3.3 Skill
Skill is trained execution.

Example:
- tying a stronger knot
- cutting straighter stakes
- scraping a hide more cleanly
- judging cooking progress more accurately

Skill answers:
**Can I perform this action well?**

Knowledge answers:
**Do I know what should be done, why, in what order, under what conditions, and with what consequences?**

## 3.4 Memory
Memory is a mechanism, not a full category of game content.

NPCs remember:
- locations
- outcomes
- warnings
- instructions
- social obligations
- patterns
- sequences

Knowledge often depends on memory, but the two are not the same.

## 3.5 Information
The player may possess information the settlement does not.
The UI can show the player possibilities without granting the colony actual mastery.

This is important because the game should support player planning without pretending that every NPC automatically knows everything the player knows.

---

# 4. Main categories of knowledge

These categories should be distinct in the design and in the data model.

## 4.1 Intuitive knowledge

This is the starting layer.

It includes rough, non-formal, humanly plausible expectations such as:

- shelter reduces exposure
- dry ground is preferable to wet ground
- filthy water is suspicious
- fire gives warmth and light
- sharp edges cut
- food spoils
- carrying aids matter
- overexertion has consequences

This layer should be broad but imprecise.

It allows the NPC to attempt survival behavior before explicit discoveries exist.

## 4.2 Discovery knowledge

A discovery is a first meaningful recognition that something in the world matters.

Examples:
- this clay can be shaped and survives drying better than loose mud
- this plant fiber twists into cord
- this location floods after heavy rain
- this water source stays clearer during dry weather
- smoked meat lasts longer than fresh meat left in the open
- the grain pit molded because it was damp
- green wood burns poorly compared with dry wood

Discovery knowledge is often local and contextual.

A discovery can be:
- personal
- shared by conversation
- inferred from observed failure
- brought in by an outsider

## 4.3 Procedural knowledge

Procedural knowledge is repeatable know-how.

It has order, timing, and conditions.

Examples:
- how to clean a hide before it rots
- how to dry meat thin enough and long enough to preserve it
- how to place a hearth safely
- how to set up a lean-to that sheds rain instead of collecting it
- how to boil, cool, and cover water with less contamination risk
- how to collect and reserve seed instead of eating all grain stocks

This is the most important category for the early game.

## 4.4 Material knowledge

Material knowledge is understanding how substances behave.

Examples:
- dry wood vs green wood
- brittle stone vs tougher stone
- fresh hide vs dried rawhide vs softened hide
- wet clay vs tempered clay vs fully dried vessel
- dry seed vs damp seed
- ash as a cleaner/alkaline input
- smoke as preservative help but not magic

Material knowledge reduces waste and failure.

## 4.5 Environmental knowledge

This is knowledge of place, time, and recurring pattern.

Examples:
- where water is more reliable
- where animals pass repeatedly
- which slopes drain better
- where frost lingers
- which patch has useful reeds
- when berries ripen
- when a stream becomes unsafe or muddy
- where wind strips shelter warmth
- where pests are worst

This knowledge is often site-specific and should matter heavily in the early slice.

## 4.6 Risk and safety knowledge

This is knowledge about avoiding injury, illness, spoilage, or catastrophe.

Examples:
- do not foul the water area
- keep refuse and carcass waste away from camp core
- keep sparks away from dry bedding
- do not store wet grain
- do not trust meat that smells wrong
- do not let a hide sit unworked too long
- do not sleep in runoff paths
- do not overload a weak carrying sling
- do not leave cooked food exposed

This category should be powerful because it changes survival odds even before productivity rises.

## 4.7 Tool knowledge

This is knowledge about using tools correctly and about how tools extend action.

Examples:
- which stone shape makes a better scraper
- how a digging stick should be hardened or shaped
- how a basket changes hauling efficiency
- how a drying rack changes spoilage risk
- which cutting edge is good for slicing meat versus scraping hide

Tool knowledge sits between materials and procedures.

## 4.8 Social knowledge

This is knowledge about people and roles.

Examples:
- who is reliable around fire
- who learns fastest by watching
- who should not be trusted with scarce seed
- who is best teaching others cordage
- which pair works well together
- how to ask for help from a new arrival
- which newcomer brings useful know-how

This category becomes more important once the camp has multiple NPCs.

## 4.9 Instructional knowledge

This is knowledge about how to **teach**.

Examples:
- demonstrating first, then supervising
- letting a learner do one step repeatedly
- correcting while the learner still remembers the mistake
- pairing a novice with a tolerant expert
- teaching in daylight rather than at exhaustion
- using a good finished example as reference

Instructional knowledge matters because one skilled NPC does not automatically create a skilled settlement.

## 4.10 Record and organizational knowledge

This is the first bridge to institutional memory.

Examples:
- reserve rules: "do not eat seed stock"
- location marks for water, traps, fiber patches
- counting and allocation rules
- where goods belong
- who checks drying racks
- when to inspect the water store
- routine cleaning schedules

In the earliest slice this may still be mostly oral or spatial, not written.

## 4.11 Institutional knowledge

This exists when a settlement knows how to keep a practice alive beyond one person.

Examples:
- every new arrival is shown the clean water route
- latrine placement follows a camp rule
- seed is stored in one protected area and checked regularly
- hides are processed in a designated work zone
- one NPC teaches, another supervises, another does inspection
- the settlement has a shared "right way" to perform a task

Institutional knowledge is the first real sign that a camp is becoming a society.

## 4.12 Scientific knowledge

This matters much later and should be defined now only for future compatibility.

Examples:
- understanding fermentation more abstractly
- understanding measurement, chemistry, metallurgy, pressure, circuits, disease vectors, and agronomy
- designing systems from general principles instead of mostly from craft tradition

It should exist, but it is not a major early-game category.

---

# 5. Tacit and explicit knowledge

A realism-first design should distinguish between **tacit** and **explicit** knowledge.

UNESCO's craft preservation material emphasizes that craft heritage is fundamentally about **skills and knowledge**, not just finished products, and that many craft traditions survive through apprenticeship and practical transmission rather than object preservation alone. [R1]

## 5.1 Tacit knowledge

Tacit knowledge is hard to fully explain in words.
It often lives in:

- timing
- touch
- posture
- pace
- pressure
- attention
- judgment
- "feel"

Examples in the early game:
- judging when a drying rack location is "dry enough"
- feeling whether a cord twist is too loose
- sensing when clay is workable but not too wet
- scraping a hide without cutting through it
- reading flame behavior
- noticing whether a shelter site "feels wrong" because of wind or drainage

Tacit knowledge should be:

- learned slowly
- improved most by doing
- improved faster by watching a capable person
- vulnerable to loss if not practiced

## 5.2 Explicit knowledge

Explicit knowledge is easier to state, demonstrate, list, name, or record.

Examples:
- "keep the latrine away from the water source"
- "reserve some of the best seeds for planting"
- "dry meat in thinner strips, not thick chunks"
- "do not store wet grain"
- "this basket type is for seed, not wet clay"
- "clay needs temper or vessels crack more often"

Explicit knowledge spreads more easily once language, routine, and records improve.

## 5.3 Why both types matter in the game

A camp can possess explicit rules but still fail because tacit craft feel is weak.

Example:
- everyone may "know" that hides must be scraped and dried
- but only one NPC may truly know how to do it without ruining them

Likewise, a skilled individual may perform well without being able to teach others unless the camp builds explicit routines around that skill.

---

# 6. Where knowledge lives

Knowledge should not be stored in only one place.

It lives in several layers at once.

## 6.1 In the individual NPC

This is the earliest and most fragile layer.

Each NPC can hold:
- observed facts
- remembered places
- warnings
- material familiarity
- procedural familiarity
- teaching familiarity
- confidence levels
- misconceptions

## 6.2 In shared practice

A group may collectively "know" something because they keep repeating it together.

Examples:
- the whole camp uses one clean water route
- everyone avoids sleeping in one low wet area
- several people help smoke meat the same way
- new arrivals are immediately shown the waste zone

This is social memory.

## 6.3 In places and layout

Spatial arrangement stores knowledge.

Examples:
- the latrine is not random; it teaches separation
- the drying rack is in the windy sun-exposed area
- the clean water pots are kept covered near the hearth but not on dirty ground
- the hide work yard is away from sleeping space

A well-laid-out camp reduces the need to remember everything verbally.

## 6.4 In artifacts and exemplars

Objects can carry knowledge.

Examples:
- a well-shaped basket teaches form
- a good scraper shape becomes a standard
- a correctly built hearth becomes the local reference model
- a good pot becomes a pattern for later pots

This matters because tacit knowledge can be partly externalized through good examples.

## 6.5 In routines

Routines are memory structures.

Examples:
- check water pot covers at dawn
- add wood to drying fire at dusk
- inspect seed storage after rain
- clean food work surface after butchering
- bring fibers to the shade before twisting cordage

A routine is not just time management; it is knowledge preservation.

## 6.6 In oral instruction and naming

Naming things matters.

Once the camp can say:
- clean water area
- waste pit
- seed reserve
- rawhide rack
- smoke frame
- bad flood hollow

then knowledge becomes easier to coordinate.

## 6.7 In records

Very early records may be minimal or absent.

Later records can include:
- counts
- marks
- tags
- simple logs
- maps
- task boards
- ledgers
- manuals
- standards

The system should be built so written or formal records can become important later without changing the early-game foundation.

---

# 7. How knowledge is created

The knowledge pipeline should be broken into steps rather than treated as a single "unlock."

## 7.1 Exposure

The NPC must encounter a relevant material, place, event, object, person, or outcome.

No clay contact, no clay knowledge.
No hide work, no hide knowledge.

Exposure can come from:
- direct contact
- scouting
- gathering
- work
- accidents
- weather events
- outsiders
- trade goods
- old ruins later

## 7.2 Attention

Not every exposure becomes learning.

Attention is shaped by:
- interest
- urgency
- fatigue
- stress
- skill load
- novelty
- player instruction
- social prompting

A severely thirsty and exhausted NPC may miss useful details.

This should matter because sleep deprivation and fatigue reduce attention stability, learning, reasoning, and decision-making. [R4]

## 7.3 Interpretation

The NPC forms a candidate conclusion.

Examples:
- "this pit stayed cooler"
- "this rack dried meat better"
- "this hide spoiled because we waited too long"
- "this clay cracks less if mixed with grit"
- "this basket is bad for wet material"

Interpretation is where mistakes and myths can also appear.

## 7.4 Trial

A candidate idea is tested in action.

Examples:
- dry meat in thinner strips
- move the sleeping area upslope
- add temper to clay
- twist fibers tighter
- boil this batch of water
- cover storage better

## 7.5 Feedback

The world returns results.

Feedback can be:
- visible success
- visible failure
- delayed success
- delayed spoilage
- injury
- illness
- praise
- correction
- comparison with others' results

Good feedback is essential for realistic learning.
Research on deliberate practice consistently emphasizes repeated performance plus feedback and correction, not mere repetition. [R5]

## 7.6 Consolidation

The NPC or settlement converts experience into more stable knowledge.

This is affected by:
- repetition
- sleep/rest
- re-use
- teaching others
- role relevance
- success clarity
- emotional salience
- records or routines

This should matter because sleep supports memory consolidation and next-day learning, while sleep loss impairs attention, memory, and reasoning. [R4][R6]

## 7.7 Social spread

One person's knowledge becomes camp knowledge through:
- imitation
- demonstration
- instruction
- correction
- shared work
- assigned mentoring
- story and warning
- visible camp design
- records later

## 7.8 Stabilization

Knowledge becomes robust when:
- more than one NPC can perform it
- the camp layout supports it
- the process has designated tools and spaces
- it survives absence of one individual
- it is integrated into routine or policy

That is the difference between personal craft and institutional know-how.

---

# 8. Main sources of knowledge gain

## 8.1 Direct observation

The NPC learns by seeing:
- smoke behavior
- rot
- mold
- pest damage
- drying times
- animal paths
- soil wetness
- material breakage
- tool wear

Observation should be one of the most common early-game sources.

## 8.2 Observational learning from others

Humans learn from watching other people.
This should be one of the most important transmission channels in the game.

Examples:
- watching someone shape a hearth
- watching a hide scraping motion
- seeing how an expert packs seed storage
- copying how a bundle is tied

Research on observational learning and social learning supports this strongly: watching a model can meaningfully improve skill acquisition, especially when the learner can attend, retain, reproduce, and receive feedback. [R7][R8]

## 8.3 Apprenticeship and guided practice

For many crafts, the realistic transmission path is apprenticeship.

UNESCO repeatedly describes traditional crafts as being passed through apprenticeship, practical work, oral guidance, and intergenerational transfer rather than through objects alone. [R1][R2]

This should become a major mechanic once the camp has 2+ NPCs.

Apprenticeship should provide:
- better learning speed
- lower catastrophic failure rates
- more tacit knowledge transfer
- stronger alignment with settlement standards

## 8.4 Repetition with feedback

Some knowledge should only stabilize after repeated success.

Examples:
- making a shelter that survives repeated bad weather
- repeatedly keeping seed dry
- drying several batches of food without spoilage
- producing usable cordage consistently

## 8.5 Learning from failure

Failure should be one of the strongest knowledge generators in the game.

Examples:
- the water pot contaminated because it was left open
- the pit flooded
- the fire spread
- the seed stock molded
- the hide rotted
- the rack collapsed
- the sling snapped

But failure should not always generate perfect insight.
Sometimes it produces only suspicion until repeated or compared with better practice.

## 8.6 Teaching and explanation

Verbal or gestural explanation matters more once multiple NPCs exist.

A teacher can transmit:
- warnings
- sequences
- standards
- shortcuts
- quality cues
- role boundaries

## 8.7 Comparison and exemplars

A good example object or output can teach.

Examples:
- comparing two baskets
- comparing two meat-drying outcomes
- comparing cracked vs intact pots
- comparing spoiled vs preserved storage

## 8.8 Outsider transfer

Newcomers should sometimes bring knowledge.

This fits your recruitment direction and also matches real settlement development:
not all progress is invented locally.

Examples:
- a wanderer knows better fish drying
- a refugee knows a better basket weave
- a traveler knows safer camp drainage practices
- later, a specialist brings a whole craft tradition

## 8.9 Environment-linked experimentation

The player should be able to order trial work:
- test clay from a new source
- try a new storage pit cover
- assign someone to compare two drying methods
- experiment with a different hearth shape

This is more realistic than a magic research lab at the start.

---

# 9. How knowledge spreads

## 9.1 Personal discovery does not instantly become settlement knowledge

A realistic system should avoid instant global diffusion.

A discovery first belongs to:
- the discoverer
- perhaps the work pair nearby
- perhaps the task supervisor
- then the camp if it is taught, copied, routinized, or physically embedded

## 9.2 Diffusion should be shaped by social conditions

Knowledge spread depends on:
- trust
- teaching skill
- shared language / mutual comprehension
- time available
- camp stability
- whether the discovery solves a visible problem
- whether materials are available
- whether the process is easy to observe
- whether the result is delayed or immediate

World Bank work on agricultural extension and farmer-to-farmer extension shows that knowledge transfer and adoption are strongly affected by social dissemination channels, not just by invention itself. [R9][R10]

## 9.3 Demonstration beats abstract instruction in early craft

In the early slice, many tasks are best learned by:
- seeing it done
- trying it immediately
- being corrected quickly

This should beat pure verbal explanation for many manual processes.

## 9.4 Group work creates shared knowledge faster

Some work should transfer knowledge rapidly when done together:
- hide processing
- basket making
- shelter construction
- smoke preservation
- pit digging and lining
- garden bed preparation

## 9.5 Distributed camps lose knowledge more easily

If the camp is physically scattered, poorly organized, or constantly exhausted, shared knowledge should spread more slowly.

This gives real gameplay value to:
- compact layout
- common workspaces
- role assignment
- routine teaching

---

# 10. Validation, confidence, and misconception

Not all knowledge should be equally reliable.

## 10.1 Confidence states

Each knowledge unit should have a confidence / maturity state.

Suggested ladder:

1. **Rumor / hunch**  
   Weak belief, low confidence, based on one event, story, or guess.

2. **Observed**  
   The NPC saw something relevant but has limited understanding.

3. **Tentative**  
   There is a usable idea, but repeatability is uncertain.

4. **Practiced**  
   The process has been used with some success.

5. **Reliable**  
   The process works often enough to be trusted in normal conditions.

6. **Established**  
   The settlement treats it as standard practice.

7. **Institutionalized**  
   It is embedded in role assignment, routines, layout, or records.

## 10.2 Misconceptions should exist

A realism-first system should allow incorrect conclusions.

Examples:
- assuming smoke can save already spoiled meat
- over-trusting one water source after a few lucky days
- using the wrong basket for wet clay
- blaming the wrong cause for a cracked pot
- storing seed too close to the hearth because "warm is dry"

Misconceptions matter because they make learning feel earned.

## 10.3 Correction pathways

Misconceptions can be corrected by:
- repeated failure
- contradiction from better outcomes
- skilled instruction
- better comparison
- outsider correction
- new tools or clearer observations
- records later

---

# 11. Knowledge loss, fragility, and resilience

## 11.1 Individual forgetting

Some knowledge should decay when:
- not practiced
- weakly learned
- learned under exhaustion
- learned without reinforcement
- rarely used
- crowded out by other demands

## 11.2 Fatigue and stress matter

Very poor sleep and chronic overload should reduce:
- retention
- attention
- instructional quality
- confidence in judgment

This is grounded in the evidence that insufficient sleep impairs attention, memory, learning, reasoning, and decision-making. [R4][R6]

## 11.3 Loss through death, departure, or sickness

If only one NPC holds knowledge in usable form, the settlement is vulnerable.

This should especially apply to:
- tacit craft knowledge
- local route knowledge
- role-specific routines
- teaching knowledge

## 11.4 Resilience factors

Knowledge becomes resilient when:
- multiple NPCs know it
- it is practiced regularly
- it is tied to a fixed place
- it has a visible artifact/example
- it is part of a named role
- it is written or recorded later
- the camp depends on it daily

---

# 12. Interaction with NPC simulation

Knowledge should interact deeply with the NPC model.

## 12.1 Curiosity

Curiosity should raise:
- attention to novelty
- chance of noticing patterns
- willingness to test
- willingness to scout
- willingness to learn unfamiliar processes

## 12.2 Discipline

Discipline should raise:
- routine adherence
- record-keeping adherence later
- careful repetition
- reserve protection
- instruction-following

## 12.3 Caution

Caution should raise:
- risk awareness
- sanitation compliance
- slower but safer adoption

But excessive caution may reduce experimentation.

## 12.4 Sociability

Sociability should raise:
- knowledge exchange
- willingness to ask for help
- group learning speed
- teaching receptiveness

## 12.5 Memory aptitude

Memory aptitude should affect:
- retention speed
- recall stability
- fewer dropped steps in longer processes
- better reuse of place-based knowledge

## 12.6 Interest

Interest should affect:
- what gets noticed
- what gets practiced voluntarily
- how long difficult learning is tolerated
- how much attention is paid during demonstrations

## 12.7 Fatigue, hunger, thirst, and pain

These should reduce:
- observation quality
- interpretation quality
- teaching quality
- retention
- complex-task learning

## 12.8 Morale and trust

A demoralized, fearful, or socially isolated NPC should learn and teach worse than a stable, trusted one.

Research on social interaction strongly supports that human learning is deeply embedded in social context. [R8]

---

# 13. Interaction with tasks

Knowledge should influence tasks in several distinct ways.

## 13.1 Availability gating

Some tasks should not be available at all until some knowledge exists.

Example:
- deliberate clay tempering should not appear before at least some clay behavior has been discovered
- a formal seed-reserve process should not appear before seed preservation logic exists

## 13.2 Safety gating

A task may be physically possible but unsafe without enough knowledge.

Example:
- butchering a carcass is possible
- doing it hygienically enough to avoid major contamination is knowledge-sensitive

## 13.3 Efficiency modifiers

Knowledge can improve:
- speed
- yield
- quality
- waste rate
- spoilage rate
- breakage rate
- fuel use
- tool wear

## 13.4 Error profile

Without knowledge, NPCs should make different kinds of mistakes:
- wrong sequence
- bad timing
- poor site choice
- contamination
- bad material selection
- under-drying or over-drying
- panic consumption of reserved stock

## 13.5 Teaching value

Some tasks should have high training value:
- cord twisting
- basket weaving
- shelter framing
- hide scraping
- boiling and storing water
- seed sorting and drying

The task system should be able to score "training usefulness" separately from immediate productivity.

---

# 14. Interaction with items, processes, structures, and settlement stages

## 14.1 Items

The item database should include knowledge requirements such as:
- identification required
- safe handling knowledge required
- processing knowledge required
- storage knowledge required
- known uses
- known hazards

## 14.2 Processes

The process database should include:
- prerequisite knowledge units
- knowledge gained from performing
- common misconceptions
- confidence thresholds for reliable output
- whether a teacher meaningfully reduces failure

## 14.3 Buildings and structures

The building database should include:
- knowledge prerequisites for siting
- knowledge prerequisites for construction
- knowledge prerequisites for safe use
- whether the structure acts as a training aid
- whether it stabilizes knowledge through spatial embedding

Example:
- a drying rack is not only a structure; it is also a knowledge scaffold that teaches correct separation from ground moisture and contamination

## 14.4 Settlement progression

Settlement state should depend partly on the maturity of shared knowledge.

A camp should not become a **Permanent Camp** merely because it has a few fixed objects.
It should also have:
- stable water handling norms
- stable waste placement norms
- reserve and storage discipline
- repeated food preservation practice
- repeatable shelter siting logic

A **Tiny Hamlet** should additionally have:
- role-based knowledge distribution
- some apprenticeship or guided transmission
- shared rules that survive one NPC's absence
- a small body of communal practice

---

# 15. Early-game knowledge domains

Below is the early-game domain map that best fits the current project scope.

## 15.1 Water domain
Knowledge examples:
- reliable source recognition
- cloudy vs clearer source judgment
- contaminated area avoidance
- boil-and-cover routine
- clean vessel handling
- storage placement
- rain collection later
- drought sensitivity by source

## 15.2 Shelter and site domain
Knowledge examples:
- drainage
- wind exposure
- sun exposure
- flood risk
- bedding dryness
- hearth distance
- smoke venting
- work zone separation

## 15.3 Fire domain
Knowledge examples:
- tinder selection
- dry fuel selection
- fuel size sequence
- spark/fire spread risk
- hearth tending
- preserving embers
- smoke effects
- cook fire vs drying fire differences

## 15.4 Food acquisition domain
Knowledge examples:
- edible familiarity
- risky food avoidance
- animal path knowledge
- simple trap placement
- seasonal patch memory
- foraging depletion awareness

## 15.5 Carcass and food safety domain
Knowledge examples:
- fast processing matters
- clean cutting surfaces matter
- separate dirty and clean steps
- off-smell warning
- flies and heat raise risk
- do not trust already questionable food

## 15.6 Preservation domain
Knowledge examples:
- thin slicing for drying
- airflow matters
- smoke supports preservation but does not reverse rot
- dryness before storage
- container choice matters
- rain protection matters

## 15.7 Fiber and cordage domain
Knowledge examples:
- which fibers can be split or twisted
- dry vs damp working conditions
- twist direction and tension
- stronger cord through multiple strands
- storing cord dry
- cord wear recognition

## 15.8 Basketry and carrying domain
Knowledge examples:
- choosing fibers
- sizing basket to contents
- using liners
- dry goods vs wet goods baskets
- repair before catastrophic failure
- bundle tie methods

## 15.9 Hide domain
Knowledge examples:
- fresh hide urgency
- fleshing and scraping sequence
- drying tension
- softening effort
- smoke exposure
- contamination and rot risk
- storage once prepared

## 15.10 Clay and vessel domain
Knowledge examples:
- clay source suitability
- cleaning clay
- adding temper
- drying slowly
- not firing wet vessels
- accepting breakage
- porous vessel uses and limitations

## 15.11 Seed and garden domain
Knowledge examples:
- choosing mature seed
- drying before storage
- pest protection
- reserve discipline
- patch timing
- protection from trampling
- soil observation
- simple seasonal timing

## 15.12 Sanitation domain
Knowledge examples:
- latrine distance from water
- refuse separation
- wash area separation
- food area cleanliness
- carcass waste placement
- standing water avoidance
- dirty tool cleanup

## 15.13 Social and organizational domain
Knowledge examples:
- role fit
- who can teach what
- who should inspect what
- reserve rules
- newcomer onboarding
- work pairing
- shared camp vocabulary

---

# 16. Discovery chains for the early slice

This section shows how knowledge progression should feel.

## 16.1 Clean water chain

**Intuitive layer**
- thirst matters
- dirty-looking water may be risky

**Discovery layer**
- one source is clearer than another
- uncovered stored water becomes foul faster
- boiled water causes fewer problems over time

**Procedural layer**
- collect from cleaner location
- settle/filter if visibly dirty
- boil
- cool in cleaner vessel
- cover
- keep vessel out of dirty traffic

**Institutional layer**
- one designated water route
- separate water vessels
- no foul work near water area
- repeated inspection routine

## 16.2 Hide processing chain

**Discovery**
- fresh hides stiffen, stink, or rot if neglected
- scraping matters
- drying and smoke change behavior

**Procedural**
- flesh promptly
- scrape clean
- stretch/dry or soften/smoke depending intended product
- keep away from camp sleeping area and food area
- inspect for mold or rot

**Institutional**
- hide work yard exists
- one or two NPCs teach hide handling
- raw and worked hides are stored separately

## 16.3 Seed reserve chain

**Discovery**
- not all harvested grain should be eaten
- damp seed stores badly
- pests and moisture ruin future planting

**Procedural**
- choose viable mature seed
- dry it
- keep it in protected storage
- inspect after storms or damp weather
- enforce reserve rules

**Institutional**
- seed store is recognized as off-limits for casual consumption
- one NPC tracks reserve adequacy
- planting plans refer to actual seed stock

## 16.4 Pottery chain

**Discovery**
- some clay can be shaped
- some vessels crack badly
- added grit/sand changes behavior
- full dryness matters before firing

**Procedural**
- collect suitable clay
- clean it
- temper it
- shape
- dry slowly
- fire carefully
- sort by quality and use

**Institutional**
- clay source is known
- a consistent work area exists
- exemplar pots are kept
- novices learn by helping prep clay and dry vessels before full shaping

---

# 17. Teaching and apprenticeship model

## 17.1 Why apprenticeship should matter

For many manual processes, the most realistic transfer route is:
- demonstration
- imitation
- guided attempt
- immediate correction
- repeated supervised work
- gradual independence

This fits both craft history and modern evidence on skill acquisition. [R1][R5][R7]

## 17.2 Teacher qualities

A good teacher should not only be highly skilled.

Teaching effectiveness should depend on:
- patience
- sociability
- discipline
- tolerance for errors
- ability to notice mistakes
- ability to explain simply
- willingness to slow down for training

## 17.3 Apprentice qualities

A good apprentice should benefit from:
- interest
- curiosity
- memory
- patience
- low panic under correction
- enough rest and nutrition to focus

## 17.4 Training modes

Suggested training modes:

### Demonstration only
Fast, cheap, low transfer fidelity.

### Shared work
Teacher and learner do the task together.
Best early default.

### Guided repetition
Learner repeats one sub-step many times.
Excellent for cordage, scraping, sorting, carrying setup, vessel finishing.

### Inspection and correction
Teacher checks finished output and gives feedback.
Good once the learner is somewhat competent.

### Formal instruction
More important later when records, diagrams, and measurements exist.

## 17.5 Training costs

Training should have real costs:
- lower immediate throughput
- teacher time
- more material loss
- some morale effects depending personalities
- safer long-term settlement resilience

---

# 18. Player interaction model

## 18.1 The player should guide discovery without acting as a magical brain implant

The player can:
- prioritize exploration
- order experiments
- order observation tasks
- assign mentoring
- define reserve rules
- define sanitation rules
- choose what gets standardized
- choose what gets documented later

The player should not:
- instantly upload a full process into every NPC
- bypass all material exposure
- erase uncertainty everywhere

## 18.2 What the player should see

The UI should show knowledge in practical form.

Suggested early states:

- **Unknown**
- **Suspected**
- **Observed**
- **Usable**
- **Reliable**
- **Camp Standard**

For each knowledge entry, the UI can show:
- who knows it
- how well it is known
- whether it is teachable
- whether it is standardized
- what tasks/buildings/items it affects
- what failures or risks remain

## 18.3 Discovery log

The camp should maintain a compact event-style discovery log.

Examples:
- "A covered pot kept water cleaner longer."
- "Two hides spoiled after being left overnight."
- "Clay from the east bank cracked less after grit was mixed in."
- "Seed stored near the hearth dried faster but some overheated or were spilled."
- "The low hollow floods after heavy rain."

This makes knowledge feel grounded in events rather than abstract bars.

## 18.4 Standard-setting

Once the camp has enough confidence, the player should be able to mark some practices as standards.

Examples:
- standard water storage method
- standard latrine distance rule
- standard hide work area
- standard seed reserve percentage
- standard teacher-apprentice pairings later

That is how the settlement begins behaving like a settlement.

---

# 19. First playable scope

The first usable slice of this knowledge system should stay narrow.

## 19.1 Needed in the first slice

### Categories
- intuitive knowledge
- discovery knowledge
- procedural knowledge
- environmental knowledge
- risk/safety knowledge
- simple social/teaching knowledge

### Transmission channels
- personal observation
- shared work
- demonstration
- repeated practice
- failure feedback
- outsider transfer for recruited NPCs

### Confidence states
- observed
- tentative
- practiced
- reliable
- camp standard

### Early domains
- water
- shelter/site
- fire
- food gathering
- carcass handling
- drying/smoking
- fiber/cordage
- basketry
- hide work
- seed handling
- sanitation

## 19.2 Can wait until later

- detailed written manual systems
- full scientific knowledge graph
- schools and formal institutions
- numerical measurement culture
- advanced technical standards
- complex innovation diffusion across settlements
- libraries, laboratories, and formal research bodies

---

# 20. Suggested data schema

Below is a design-facing schema, not final code.

## 20.1 KnowledgeDefinition

- `knowledge_id`
- `name`
- `domain`
- `category`
- `description`
- `scope_level`
  - individual
  - group
  - settlement
- `tacit_weight`
- `explicit_weight`
- `default_visibility_to_player`
- `related_items`
- `related_processes`
- `related_structures`
- `related_settlement_states`
- `prerequisite_knowledge_ids`
- `blocked_by_conditions`
- `common_misconceptions`
- `typical_failure_signals`
- `teaching_value`
- `documentation_possible`
- `future_upgrade_paths`

## 20.2 KnowledgeInstance_Individual

- `npc_id`
- `knowledge_id`
- `awareness_state`
- `confidence_state`
- `retention_strength`
- `last_practiced_time`
- `last_taught_time`
- `times_observed`
- `times_performed`
- `times_successful`
- `times_failed`
- `teacher_ids`
- `place_links`
- `example_object_links`
- `misconception_flags`

## 20.3 KnowledgeInstance_Settlement

- `knowledge_id`
- `settlement_confidence_state`
- `holders`
- `critical_holders`
- `apprentice_holders`
- `is_standardized`
- `is_spatially_embedded`
- `is_recorded`
- `standard_operating_rule_text`
- `layout_links`
- `artifact_example_links`
- `resilience_score`
- `loss_risk_score`

## 20.4 DiscoveryEvent

- `event_id`
- `timestamp`
- `location`
- `trigger_type`
  - observation
  - task_success
  - task_failure
  - outsider_transfer
  - experiment
  - weather_event
  - illness_event
- `participants`
- `knowledge_candidates_created`
- `evidence_strength`
- `notes`

## 20.5 TrainingSession

- `teacher_id`
- `learner_id`
- `knowledge_id`
- `process_id`
- `mode`
  - demonstration
  - shared_work
  - guided_repetition
  - inspection
  - explanation
- `duration`
- `fatigue_context`
- `quality_of_attention`
- `quality_of_feedback`
- `outcome`

---

# 21. Example early knowledge entries

## 21.1 Covered water storage
- **Category:** procedural / risk-safety
- **Why it matters:** lowers recontamination risk
- **Discovery sources:** foul taste, visible debris, illness pattern, observation of cleaner stored water
- **Tacit/explicit mix:** mostly explicit, some tacit cleanliness discipline
- **Standardization potential:** very high

## 21.2 Safe waste separation
- **Category:** environmental / risk-safety / organizational
- **Why it matters:** sanitation, smell, insects, contamination
- **Discovery sources:** filth near camp, foul runoff, sickness, pests
- **Standardization potential:** very high

## 21.3 Thin-strip drying for meat
- **Category:** procedural / material
- **Why it matters:** preservation reliability
- **Discovery sources:** comparison of thick vs thin cuts
- **Teaching mode:** demonstration + guided repetition
- **Failure signs:** interior remains wet, spoilage, insects

## 21.4 Dry fuel selection
- **Category:** discovery / material / procedural
- **Why it matters:** fire reliability
- **Discovery sources:** repeated ignition failure with wet wood
- **Tacit element:** judging dryness by weight, sound, feel, and look
- **Camp benefit:** better heat planning and less wasted effort

## 21.5 Hide urgency
- **Category:** risk-safety / procedural
- **Why it matters:** prevents rot and waste
- **Discovery sources:** spoiled hides
- **Standardization potential:** medium early, high later with dedicated hide workers

## 21.6 Tempered clay
- **Category:** material / procedural
- **Why it matters:** lower crack rate, better survival through drying/firing
- **Discovery sources:** trial and comparison
- **Teaching mode:** shared prep work
- **Standardization potential:** high once pottery begins

## 21.7 Seed reserve discipline
- **Category:** organizational / procedural
- **Why it matters:** future survival
- **Discovery sources:** scarcity after overconsumption or failed planting
- **Teaching mode:** rule + oversight
- **Standardization potential:** extremely high

## 21.8 Flood-safe sleeping site
- **Category:** environmental / risk-safety
- **Why it matters:** sleep quality, exposure, survival
- **Discovery sources:** rain event
- **Transmission:** scouting report, camp relocation, visible marker
- **Standardization potential:** high through camp layout

---

# 22. Open design questions

These are worth deciding later, not now.

## 22.1 How visible should hidden knowledge be to the player?
Should the player see:
- only what NPCs know
- likely possibilities
- or both?

## 22.2 How harsh should misconception persistence be?
A stricter model is more realistic but also more punishing.

## 22.3 How strong should outsider knowledge transfer be?
Should one newcomer be able to bring:
- only personal craft skill
- or also partially stabilized methods?

## 22.4 How much should camp layout itself count as institutional memory?
I strongly recommend: a lot.

## 22.5 How often should knowledge be lost without practice?
This needs tuning for fun, not just realism.

---

# 23. Recommended next step after this document

The strongest next companion document is either:

### Option A — Social / Recruitment Spec
Because knowledge transmission depends heavily on trust, teaching, pairings, newcomer onboarding, and role formation.

### Option B — Economy / Allocation Spec
Because a large amount of early knowledge becomes meaningful only when the camp can enforce reserve rules, ownership rules, storage discipline, and distribution priorities.

If staying closest to the current stack, **Social / Recruitment Spec** is probably the best next move.

---

# 24. Conclusion

The game should treat knowledge as one of the settlement's most important survival resources.

In the early game, knowledge is:
- local
- practical
- fragile
- embodied
- unevenly distributed
- often tacit
- often born from error, discomfort, and repeated trial

As the camp stabilizes, knowledge becomes:
- shared
- routinized
- teachable
- standardized
- spatially embedded
- socially enforced

And only later does it become:
- recorded
- measured
- institutionalized
- scientifically expanded

That arc matches the fantasy of your project:
one person in the wilderness becomes a community, then a society, not only by gathering more resources, but by learning how to live, work, teach, remember, and improve together.

---

# References

## Existing project documents
- Existing uploaded design documents in this conversation, especially:
  - `realistic_idle_city_design_v1.md`
  - `realistic_idle_city_early_game_bible_v0_2.md`
  - `realistic_idle_city_npc_simulation_spec_v0_1.md`
  - `realistic_idle_city_task_evaluation_spec_v0_1.md`
  - `realistic_idle_city_item_material_bible_v0_1.md`
  - `realistic_idle_city_process_bible_v0_1.md`
  - `realistic_idle_city_building_structure_bible_v0_1.md`
  - `realistic_idle_city_settlement_progression_spec_bible_v0_1.md`

## External grounding
- [R1] UNESCO, *Traditional craftsmanship*  
  https://ich.unesco.org/en/traditional-craftsmanship-00057

- [R2] UNESCO, *Compagnonnage, network for on-the-job transmission of knowledge and identities through the trade*  
  https://ich.unesco.org/en/RL/compagnonnage-network-for-on-the-job-transmission-of-knowledge-and-identities-00441

- [R3] Malgard et al., *The Procedures for Documenting Organizational Knowledge and Differentiating Explicit and Tacit Knowledge*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC11230601/

- [R4] CDC / NIOSH, *Sleep deprivation impairs your performance*  
  https://www.cdc.gov/niosh/work-hour-training-for-nurses/longhours/mod3/04.html

- [R5] Duvivier et al., *The role of deliberate practice in the acquisition of clinical skills*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC3293754/

- [R6] Abel, *The role of sleep for memory consolidation*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC10728269/

- [R7] Han et al., *Use of Observational Learning to Promote Motor Skill Learning in Physical Education*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC9407861/

- [R8] De Felice et al., *The role of social interaction in human acquisition of new knowledge*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC9791495/

- [R9] Hörner et al., *Knowledge and Adoption of Complex Agricultural Technologies*  
  https://openknowledge.worldbank.org/entities/publication/c9bb121f-6ec8-480f-b78c-0f38b60aed46

- [R10] World Bank, *Agricultural extension* / farmer-to-farmer and dissemination literature  
  https://documents1.worldbank.org/curated/en/956441468763806805/pdf/28646.pdf
