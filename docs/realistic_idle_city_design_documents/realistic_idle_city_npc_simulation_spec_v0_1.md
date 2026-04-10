---
title: "Realistic Incremental/Idle Colony-to-City Game - NPC Simulation Spec"
version: "v0.1 - research-backed working draft"
date: "2026-04-07"
status: "working draft"
based_on:
  - "realistic_idle_city_design_v1.md"
  - "realistic_idle_city_early_game_bible_v0_2.md"
author: "OpenAI / ChatGPT"
project_notes:
  - "Realism-first, research-backed"
  - "Top-down minimal visuals in Godot"
  - "Player gives orders, priorities, restrictions, and policies"
  - "NPCs are autonomous agents with needs, skills, traits, and social behavior"
  - "NPCs are not blank slates and are not generic workers"
---

# NPC Simulation Spec v0.1

## Purpose of this document

This document turns the broad colony concept and the early-game bible into a **research-backed NPC simulation specification**.

The purpose is to answer:

- What exactly is an NPC in this game?
- Which human needs and limitations should be simulated?
- How should personality, interests, aptitudes, and skills differ from each other?
- How should NPCs choose tasks when the player gives orders rather than manually controlling bodies?
- How should learning, morale, social ties, and recruitment work in a realism-first colony game?
- Which parts belong in the **first playable** and which parts should remain later additions?

This is not a final implementation document.  
It is a design spec intended to become:

- a Godot data schema
- a behavior-tree / utility-AI spec
- a task-priority system
- a character generation system
- a skill and training database
- a future social simulation spec

---

# 1. Design stance

## 1.1 What kind of NPC this game needs

The game does **not** need:
- anonymous workers
- "villagers" who all behave the same
- perfectly obedient robots
- blank minds waiting for research unlocks
- all-purpose experts

The game **does** need NPCs who feel like:
- embodied humans
- limited but adaptable
- shaped by temperament
- shaped by interest
- shaped by experience
- shaped by health and rest
- shaped by the camp and the society around them

That means an NPC is not just:
> worker speed + carrying capacity

An NPC is a stack of interacting systems:
- body
- mind
- habits
- interests
- aptitudes
- skills
- knowledge
- social ties
- role expectations
- current context

## 1.2 Player relationship to NPCs

The player is not directly piloting bodies moment-to-moment.

The player:
- issues orders
- sets priorities
- assigns roles
- forbids or allows activities
- defines stock targets
- marks work zones
- controls schedules and policies
- shapes training paths
- shapes settlement norms

The NPC:
- interprets the current situation
- checks survival state
- evaluates safety
- chooses among allowed tasks
- follows current role and orders as long as that remains feasible
- improvises within limits
- resists or fails when needs, morale, or competence are too poor

## 1.3 Simulation principle

The simulation should be realistic in the following ways:

- body state matters
- sleep matters
- hydration matters
- heat/cold and wetness matter
- pain and illness matter
- work quality varies
- practice changes skill
- interest changes willingness and learning rate
- social life matters
- fairness matters
- tools and environment matter
- mistakes, fatigue, and interruptions matter

The simulation should **not** become realistic by forcing the player to micromanage every footstep.  
It should become realistic by making good organization, proper rest, and sound logistics visibly important.

---

# 2. Research anchors used in this spec

This document is informed by a small set of real-world anchors that are useful for game design.

## 2.1 Sleep
CDC and NIH/PMC sources consistently describe sleep as essential for health, emotional regulation, cognitive function, focus, and memory consolidation.[R1][R2][R3]

### Design implication
Sleep is not just an energy refill bar.  
Poor sleep should reduce:
- vigilance
- mood stability
- concentration
- learning efficiency
- work quality
- injury resistance
- willingness to take on demanding tasks

## 2.2 Hydration, heat, and workload
CDC/NIOSH and OSHA materials note that inadequate hydration, heat stress, workload, and poor acclimatization impair safety and performance; work-rest practices, cooling, and staffing changes reduce risk.[R4][R5][R6][R7]

### Design implication
Hydration, temperature, exertion, and clothing load should interact.
An NPC should not perform hard labor the same way:
- in cold rain
- in peak summer heat
- while dehydrated
- while carrying heavy loads
- while sleeping badly

## 2.3 Social connection
WHO materials treat social connection as a real health factor and describe loneliness/social isolation as harmful to physical and mental well-being.[R8][R9]

### Design implication
Even in a minimal colony game, social life should not be decorative.
NPCs should react to:
- living alone
- lack of trust
- isolation
- conflict
- loss of status
- stable companionship
- shared meals
- family ties
- mentorship and belonging

## 2.4 Personality structure
The Five-Factor Model is one of the most influential trait frameworks in personality psychology and is useful as a broad inspiration, even if the game should not expose it in textbook form.[R10][R11]

### Design implication
A trait model should be broad, stable, and reusable across many contexts, but translated into game-facing values that matter for work, stress, and social life.

## 2.5 Skill acquisition
Research on deliberate practice and learning supports the importance of repetition, feedback, supervision, and structured correction rather than raw time alone.[R12][R13]

### Design implication
Skill should not rise only because an NPC spent hours on a task.
Skill gain should depend on:
- exposure
- repetition
- successful attempts
- error feedback
- observation of better workers
- teaching quality
- tool quality
- sleep and recovery
- interest and motivation

---

# 3. Recommended NPC architecture

Each NPC should be composed of the following layers.

## 3.1 Identity layer
Stable identity data:

- internal ID
- display name
- age band
- sex/gender setting if used
- origin/background
- culture/language group later if used
- recruitment source
- family links
- social tags
- notable life history events later

## 3.2 Body layer
Short-to-medium-term physical state:

- hydration
- stomach fullness / digestion state
- energy reserve / recent calorie balance
- fatigue
- sleep debt
- body temperature pressure
- wetness
- dirtiness
- pain
- injury severity
- blood loss later
- sickness severity
- infection load later
- intoxication/poisoning later
- menstrual/pregnancy state later if modeled
- bowel/bladder urgency if modeled
- carrying load
- movement impairment

## 3.3 Mind layer
Short-to-medium-term psychological state:

- mood
- stress
- fear
- irritability
- loneliness
- hope/confidence
- boredom
- frustration
- focus
- perceived autonomy
- perceived fairness
- trust in leaders
- grief/attachment effects later

## 3.4 Personality layer
Longer-term stable tendencies:

- caution
- curiosity
- conscientiousness
- sociability
- emotional stability
- cooperation
- stubbornness
- patience
- ambition/status drive
- cleanliness/order preference
- novelty seeking
- risk tolerance

## 3.5 Interest layer
What this NPC naturally likes engaging with:

- plants
- animals
- fire and cooking
- making and crafting
- tools/machines
- building
- numbers and counting
- organizing
- teaching
- caregiving/healing
- trade
- exploration
- defense
- aesthetics/decoration
- cleanliness
- socializing
- solitude
- leadership

Interest affects:
- voluntary task preference
- boredom resistance
- training speed
- willingness to return to a task
- morale bonus from matching work
- morale penalty from repeated mismatch

## 3.6 Aptitude layer
Potential and natural fit, separate from interest:

- strength aptitude
- endurance aptitude
- dexterity aptitude
- balance/coordination aptitude
- observational aptitude
- memory aptitude
- language/communication aptitude
- social-reading aptitude
- spatial aptitude
- mechanical reasoning aptitude
- botanical aptitude
- animal-handling aptitude
- care/medical aptitude
- administrative/numerical aptitude
- teaching aptitude
- leadership aptitude
- artistic/aesthetic aptitude

Aptitude affects:
- starting competence
- learning ceiling
- error rates
- speed at reaching competence
- resilience under difficulty

## 3.7 Skill layer
What the NPC can actually do, based on practice and knowledge.

Skill should be:
- task-relevant
- learned gradually
- partially transferable
- slowed by bad conditions
- improved by repetition and feedback
- degraded by long disuse only in some cases

## 3.8 Knowledge layer
What the NPC or settlement knows.

Knowledge is not the same as skill.

Examples:
- knows that a plant is edible
- knows where clay is found
- knows the steps of hide scraping
- knows that a pot must dry before firing
- knows how to rotate traps
- knows the basic shape of a basket frame
- knows how to safely store embers
- later knows measured procedures and standards

## 3.9 Social layer
How the NPC relates to others:

- family ties
- close bonds
- mentor/apprentice links
- attraction or rivalry later
- trust
- respect
- resentment
- duty ties
- role legitimacy
- grievance history
- faction alignment later

## 3.10 Role layer
Practical work identity:

- current role
- allowed tasks
- forbidden tasks
- default priorities
- emergency override behavior
- workplace assignment
- training target role
- backup roles
- social obligations attached to role

---

# 4. Core needs model

These are the most important needs for a realism-first colony simulation.

## 4.1 Hydration

### Why it matters
Water is essential to life, and inadequate hydration is associated with poorer cognitive performance and physical functioning.[R4]

### What to simulate
- current hydration
- recent fluid intake
- thirst sensation
- water quality risk
- dehydration severity
- electrolyte stress later if desired

### Gameplay effects
Low hydration should reduce:
- stamina recovery
- hauling ability
- concentration
- patience
- heat tolerance
- work quality
- learning speed

Severe dehydration should increase:
- collapse risk
- confusion
- panic
- bad decisions
- injury risk

### Early-game importance
Very high.  
A lone starter NPC should often interrupt lower-priority work to drink or seek water.

## 4.2 Sleep and fatigue

### Why it matters
Sleep is strongly tied to cognitive function, mood, alertness, and memory consolidation.[R1][R2][R3]

### What to simulate
- acute fatigue
- sleep debt
- sleep quality
- time since last proper sleep
- fragmentation of sleep
- circadian disruption later if night shifts exist
- rest opportunities short of sleep

### Gameplay effects
Low sleep should reduce:
- vigilance
- reaction speed
- error checking
- planning quality
- morale
- injury resistance
- disease resistance somewhat
- learning retention

### Sleep quality factors
- dry or wet bed
- warmth / cold stress
- wind exposure
- shelter quality
- noise and threat
- crowding later
- social comfort or discomfort later
- pain
- illness
- bedding quality

## 4.3 Calories and energy balance

### Why it matters
Underconsumption and poor nutrition impair work capacity, mood, and cognitive performance, while micronutrient deficiency can reduce energy level and mental clarity.[R14][R15]

### What to simulate
- stomach fullness
- recent calorie intake
- medium-term energy balance
- nutrient diversity index
- special deficiencies later if desired
- recent meal quality
- food safety risk

### Gameplay effects
Poor nutrition should reduce:
- endurance
- cold tolerance
- mood stability
- wound recovery
- learning quality
- work capacity

### Important distinction
Acute hunger and chronic undernourishment are not the same.

A good game model separates:
- short-term hunger discomfort
- longer-term energy depletion
- still longer-term malnutrition and weakness

## 4.4 Temperature and wetness

### Why it matters
Heat stress combines environmental heat, metabolic heat from work, and clothing burden; cold and wetness likewise reduce safe performance and increase illness/injury risk.[R5][R6][R7]

### What to simulate
- ambient temperature pressure
- wind exposure
- rain/snow exposure
- wet clothing/bedding
- shelter protection
- internal heat from activity
- clothing insulation
- drying opportunities
- acclimatization to heat/cold later

### Gameplay effects
Cold/wet:
- faster fatigue
- slower dexterity
- lower morale
- worse sleep
- greater illness risk
- slower fine craft work

Heat:
- greater water demand
- faster exhaustion
- poorer skilled performance
- more breaks required
- higher collapse/injury risk

## 4.5 Pain and injury

### Why it matters
Humans do not keep working normally when cut, bruised, sprained, burned, infected, or sleep-deprived.

### What to simulate
- pain level
- wound type
- wound location
- infection risk
- mobility penalty
- dexterity penalty
- blood loss severity later
- healing progress
- scar/permanent impairment later

### Gameplay effects
Pain and injury affect:
- willingness to work
- speed
- quality
- mood
- sleep quality
- social need for care

## 4.6 Illness

### Why it matters
Illness is a major settlement bottleneck and should emerge naturally from:
- contaminated water
- poor waste handling
- poor food safety
- exposure
- crowding later
- parasites later
- untreated wounds

### What to simulate
For early game:
- sickness severity
- likely cause
- dehydration from illness
- fever/chills
- weakness
- contagiousness later when relevant

### Gameplay effects
Illness should force:
- rest
- water demand
- reduced labor
- need for care
- camp sanitation pressure

## 4.7 Hygiene and cleanliness

### Why it matters
Cleanliness matters for comfort, dignity, wound care, and disease risk.

### What to simulate
- body dirtiness
- hand cleanliness abstraction
- clothing cleanliness later
- bedding cleanliness later
- latrine/waste discipline
- camp filth load

### Gameplay effects
Poor hygiene should affect:
- mood
- social perception
- wound infection risk
- food safety risk
- settlement disease pressure

## 4.8 Safety

### Why it matters
Threat changes human behavior even before it causes damage.

### What to simulate
- perceived predator risk
- enemy/raider risk later
- darkness exposure
- unsafe task conditions
- fire hazard
- structural hazard later
- tool hazard
- social threat later

### Gameplay effects
High perceived danger should affect:
- route choice
- sleep quality
- willingness to work alone
- morale
- obedience to risky orders
- need for light, fencing, watch, or company

## 4.9 Social connection

### Why it matters
WHO materials treat social connection as a real health factor, and isolation/loneliness as harmful.[R8][R9]

### What to simulate
- isolation
- companionship
- recent positive interaction
- conflict exposure
- trust network
- belonging to household/work group
- grief later

### Gameplay effects
Low social connection should affect:
- mood
- resilience
- compliance
- recovery from setbacks
- willingness to stay in settlement
- recruitment retention

---

# 5. Personality model

## 5.1 Why personality matters in this game

This game is not improved by making every NPC only a set of skill bars.
The colony becomes memorable when two equally healthy workers behave differently because one is:
- cautious and orderly
- curious but distractible
- sociable and cooperative
- stoic but not imaginative
- moody yet brilliant at craft
- brave and strong but poor with routine

## 5.2 Recommended approach

Use a **broad stable trait layer** plus smaller secondary quirks.

The broad layer can be inspired by the Five-Factor Model without exposing the player to raw psychology jargon.[R10][R11]

## 5.3 Recommended game-facing broad traits

### Caution
High caution:
- avoids unnecessary danger
- checks conditions more often
- wastes less on reckless errors
- may refuse risky scouting or hunting

Low caution:
- takes more risk
- explores sooner
- may perform better in crises
- suffers more preventable injuries

### Curiosity
High curiosity:
- explores unknown tiles/zones more readily
- notices unusual materials faster
- gains more from discovery tasks
- becomes bored by routine

Low curiosity:
- sticks to familiar tasks
- excels at repetitive labor
- discovers less

### Conscientiousness
High:
- finishes tasks
- stores items properly
- follows procedures
- keeps camps tidier
- produces more consistent quality

Low:
- abandons tasks
- misplaces goods more often
- creates avoidable disorder
- needs more supervision

### Sociability
High:
- prefers group tasks
- gains morale from company
- easier recruitment/teaching fit
- may suffer more from isolation

Low:
- tolerates solitude better
- may do well in scouting or watch tasks
- may resist crowded work environments

### Emotional stability
High:
- steadier under setbacks
- less panic
- less morale collapse from bad weather or failure
- recovers faster emotionally

Low:
- stronger reaction to danger, hunger, isolation, conflict
- more likely to spiral after repeated failures

### Cooperation
High:
- shares
- assists others
- responds well to communal rules
- makes smoother workshops

Low:
- hoards time or resources
- resists unfair burdens
- more prone to conflict

### Patience
High:
- tolerates slow repetitive work
- better for weaving, drying, teaching, careful craft, waiting tasks

Low:
- prefers immediate-result tasks
- abandons long processes or monitoring jobs sooner

### Orderliness
High:
- keeps stores sorted
- cleans workspaces
- reduces camp disorder
- performs better in production chains

Low:
- creates clutter and losses
- thrives more in opportunistic field tasks than in organized logistics

### Ambition / status drive
High:
- wants recognition
- responds strongly to promotion, role titles, superior housing
- may become competitive

Low:
- accepts humble roles more easily
- may be less motivated by prestige structures

### Stubbornness
High:
- persists through hardship
- resists correction
- may refuse role changes

Low:
- adapts more easily
- gives up sooner when unsupported

## 5.4 Quirks

Quirks are smaller flavor traits layered on top:
- hates cold rain
- loves campfire work
- poor sleeper
- tidy eater
- hates butchery
- fascinated by animals
- easily grossed out
- hand-steady
- weak stomach
- natural teacher
- dislikes authority
- likes night watch
- hates blood
- protective of children later
- territorial
- superstitious later if culture system exists

Quirks help keep NPCs memorable without requiring a hundred fully independent psychological variables.

---

# 6. Interests, aptitudes, and skills: keep them separate

This separation is one of the most important design rules in the entire NPC system.

## 6.1 Interest
Interest answers:
> "What does this person naturally like engaging with?"

Effects:
- willingness
- voluntary task choice
- boredom resistance
- morale match
- faster practice accumulation
- more initiative in related discovery

## 6.2 Aptitude
Aptitude answers:
> "How naturally suited is this person to becoming good at this?"

Effects:
- learning slope
- likely ceiling
- error tendency
- ability under pressure
- ability to generalize from experience

## 6.3 Skill
Skill answers:
> "What can this person actually do right now?"

Effects:
- speed
- quality
- reliability
- salvage yield
- safe handling
- independence

## 6.4 Example
A person may have:
- high interest in plants
- moderate botanical aptitude
- low current foraging skill

That NPC will:
- enjoy plant work
- learn it readily
- still initially make mistakes

Another person may have:
- low interest in cooking
- high sensory/precision aptitude
- medium cooking skill

That NPC might cook well but avoid it unless assigned.

---

# 7. Aptitude model

Below is a recommended aptitude set.

## 7.1 Physical aptitudes
- raw strength
- endurance
- fine motor control
- gross coordination
- balance
- hand steadiness
- pain tolerance
- recovery rate
- disease resilience
- heat tolerance
- cold tolerance

## 7.2 Cognitive aptitudes
- observation
- memory
- problem solving
- pattern recognition
- spatial reasoning
- numerical reasoning
- verbal communication
- planning
- improvisation
- sustained attention

## 7.3 Practical aptitudes
- mechanical reasoning
- craft precision
- field intuition / tracking sense
- botanical recognition
- animal handling
- food judgment
- cleanliness and contamination awareness
- caregiving intuition
- administrative order
- teaching aptitude

## 7.4 Social aptitudes
- empathy
- conflict de-escalation
- persuasion
- authority projection
- trustworthiness
- teamwork instinct

---

# 8. Skills taxonomy

The user specifically wants realism and does not mind a large number of skills.  
So the best structure is a **hierarchical skill taxonomy** with:
- broad categories
- individual skills under them
- role bundles later

Not every skill needs to exist in the first playable, but the taxonomy should already be designed broadly.

## 8.1 Survival and fieldcraft
- water finding
- water carrying
- water boiling and purification handling
- fire starting
- ember keeping
- fuel selection
- shelter siting
- debris shelter building
- camp weatherproofing
- route finding
- path memory
- scouting
- hazard spotting
- edible plant identification
- dangerous plant recognition
- mushroom judgment later if included
- insect gathering
- shellfish gathering where biome fits
- fishing
- fish cleaning
- snare making
- deadfall setting
- trap maintenance
- tracking
- stalking
- spear use
- club use
- bow use later
- carcass recovery
- skinning
- butchery
- marrow/fat extraction
- bone use
- sinew preparation
- hide scraping
- hide drying
- brain/fat softening later
- smoke curing hides
- cordage making
- knot tying
- bundle carrying
- improvised stretcher/drag use

## 8.2 Camp life and domestic survival
- hearth tending
- ash management
- basic cooking
- roasting
- boiling
- stone heating later
- smoking food
- drying food
- rationing
- fuel stacking
- water vessel management
- bedding preparation
- camp cleaning
- waste pit use
- latrine discipline
- washing
- drying clothing/bedding
- camp layout sense
- pest prevention
- rodent-proof storage later
- simple childcare later
- sick care
- body cleaning
- garment patching
- simple sewing
- wrapping and binding
- foot care
- rest management

## 8.3 Gathering and extraction
- branch collecting
- firewood selection
- green wood cutting
- deadwood judging
- stone selection
- flake stone knapping
- hammerstone use
- digging
- clay locating
- clay digging
- sand collecting
- reed cutting
- fiber plant harvesting
- bark stripping
- resin gathering
- pitch collection later
- salt gathering later
- peat cutting later
- ore spotting later
- quarrying later
- logging later

## 8.4 Food production
- seed selection
- seed saving
- sowing
- transplanting
- hoe use
- weeding
- watering by hand
- mulching
- pest watching
- crop harvesting
- threshing
- winnowing
- grain drying
- storage crop curing
- orchard care later
- pruning later
- irrigation handling later
- manure spreading later
- composting later

## 8.5 Animal skills
- animal observation
- calming
- capture and restraint
- feeding
- watering livestock
- shelter cleaning
- breeding observation later
- milking later
- shearing later
- egg collection later
- herding later
- harness handling later
- traction handling later
- slaughter handling
- hide and offal sorting

## 8.6 Fiber, leather, and clothing
- cordage making
- basket weaving
- mat weaving
- net making
- spindle use later
- spinning
- carding/combing later
- simple loom setup later
- weaving
- cloth cutting
- sewing
- patching
- hide cutting
- hide piercing
- lacing
- soft leather making later
- tanning later
- footwear making
- glove/mitten making later
- cold-weather layering judgment

## 8.7 Pottery and containers
- clay judging
- temper selection
- clay wedging
- coil building
- pinch pot forming
- slab shaping later
- drying control
- pit firing
- simple kiln loading later
- pottery salvage sorting
- lid fitting later
- container sealing later
- liquid storage handling
- fracture risk handling

## 8.8 Wood, bone, and simple toolmaking
- shaft straightening
- stake shaping
- spear point hardening
- hafting
- scraping tool shaping
- handle fitting
- bone awl making
- bone needle making later
- mallet making
- digging stick making
- sled/drag making later
- ladder making later
- simple joinery later
- wheelmaking much later

## 8.9 Building and site work
- camp siting
- drainage judgment
- brush clearing
- post setting
- frame lashing
- roof thatching later
- bark roofing later
- wattle making later
- daubing later
- mud floor prep
- stone placement
- simple retaining work
- fence building
- gate lashing later
- windbreak building
- drying rack building
- storage platform building
- granary building later
- barn building later
- masonry later
- roofing later
- carpentry later

## 8.10 Food preparation and preservation
- gutting
- trimming
- drying strips
- smoking schedule management
- fermentation later
- salting later
- rendering fat
- broth making
- grinding later
- baking later
- spoilage detection
- contamination avoidance
- ration planning
- guest meal provisioning later

## 8.11 Health and care
- wound cleaning
- bandaging
- splinting
- fever care
- hydration support
- recognizing dangerous symptoms
- rest enforcement
- herbal trial knowledge later
- sanitation discipline
- birthing assistance later
- infant care later
- elder care later

## 8.12 Social and communication
- teaching
- mentoring
- explaining steps
- persuasion
- reassurance
- conflict calming
- negotiation
- trading
- record recitation
- storytelling
- public speaking later
- leadership
- authority maintenance
- hospitality later

## 8.13 Logistics and organization
- counting
- stock checking
- storage sorting
- load planning
- hauling route planning
- pack arrangement
- task sequencing
- queue awareness
- handoff reliability
- timekeeping by sun/season later
- ledger use later
- procurement later
- dispatch later

## 8.14 Administration and knowledge work
- tallying
- memory aids
- marking stores
- schedule setting
- ration policy
- labor assignment
- recordkeeping
- teaching plans
- measurement later
- drafting later
- standards maintenance later
- inspection later

## 8.15 Security and defense
- watch duty
- alarm raising
- perimeter checking
- defensive positioning
- spear fighting
- shield use later
- ranged weapons later
- prisoner handling later
- fire emergency response
- panic control

## 8.16 Trade and exchange
- barter judgment
- value estimation
- trust assessment
- market buying/selling later
- contract following later
- inventory for trade
- caravan support later

## 8.17 Craft and industrial skills for later eras
These do not need to be implemented now, but the taxonomy should leave room for them:
- charcoal burning
- bloomery tending
- forging
- smithing
- casting
- carpentry
- joinery
- wheelwrighting
- masonry
- lime burning
- brickmaking
- milling
- sawmilling
- machine operation
- machining
- fitting/assembly
- electrical work
- plumbing
- chemistry/process control
- vehicle operation
- diagnostics
- maintenance
- inspection
- scheduling
- clerical work
- scientific observation
- laboratory procedure

---

# 9. Skill representation model

## 9.1 Recommended format
Each skill should have:

- numeric value
- familiarity state
- last-used date
- experience pool
- confidence level
- known techniques
- error tendency
- independent-work threshold

## 9.2 Useful skill states
A skill can be interpreted in stages such as:

- **unknown**
- **aware**
- **novice**
- **practiced**
- **competent**
- **proficient**
- **expert**
- **master** later for very rare high-end roles

These stages are useful for:
- task gating
- work supervision needs
- teaching eligibility
- role assignment
- quality expectations

## 9.3 Confidence versus competence
These should be separate when possible.

An NPC may be:
- competent but anxious
- incompetent but overconfident
- competent and calm
- low skill but cautious and teachable

That difference creates better stories and better failure behavior.

---

# 10. Needs-to-performance model

Work output should depend on more than skill.

## 10.1 Recommended production logic
A task result should roughly depend on:

**output speed**
=
base task speed  
× body condition  
× morale/focus  
× skill effect  
× tool quality  
× environment suitability  
× interruption penalty  
× supervision effect

**output quality**
=
base quality  
+ skill effect  
+ aptitude effect  
+ supervision effect  
- fatigue penalty  
- pain penalty  
- distraction penalty  
- poor environment penalty

**accident chance**
=
task danger  
- skill safety factor  
- supervision factor  
+ fatigue  
+ panic/fear  
+ darkness  
+ weather penalty  
+ bad tool penalty

## 10.2 Practical consequences
A tired but skilled worker may still outperform a novice for a while, but:
- make more mistakes
- cut corners
- misjudge risk
- learn less
- damage tools or goods more often

This is important because it makes overwork a trap instead of a free efficiency strategy.

---

# 11. Learning model

## 11.1 Core rule
Practice matters, but practice under good conditions matters more.[R12][R13]

## 11.2 Sources of skill gain
Skill should grow from:
- repetition
- successful completion
- partially failed attempts with feedback
- observation
- direct teaching
- working with better tools
- reading/manuals later
- formal schooling later
- experimentation if curiosity is high
- role repetition and routine

## 11.3 Multipliers on learning rate

### Positive
- high interest
- good aptitude
- good sleep
- moderate challenge
- useful feedback
- nearby mentor
- high-quality tools
- stable work environment
- repeated task within same context

### Negative
- dehydration
- hunger/undernourishment
- severe fatigue
- pain
- fear
- chaotic interruptions
- no correction/feedback
- constant task switching
- low morale
- social humiliation
- being forced into hated work

## 11.4 Sleep and learning
Because sleep supports concentration and memory consolidation, learning should not fully "bank" until adequate rest occurs.[R1][R2][R3]

### Simple implementation idea
- practice gives **raw practice points**
- good sleep converts part of them into durable skill experience
- poor sleep reduces conversion efficiency

That makes rest relevant without requiring a neuroscience simulator.

## 11.5 Teaching and apprenticeship
A more skilled worker should improve learning by:
- demonstrating
- correcting errors
- reducing waste
- preventing accidents
- structuring repetition

A mentor should not simply "beam XP."
The mentor should improve:
- safe practice opportunities
- feedback quality
- confidence
- pace of progression from novice to competent

## 11.6 Transfer of training
Some skills should partially support others.

Examples:
- basket weaving helps mat weaving
- cordage helps net making
- hide scraping helps leather work
- basic cooking helps preservation work
- stock counting helps warehousing
- pathfinding helps scouting and hauling

This makes broad experience feel valuable without collapsing all skills into one.

---

# 12. Task choice and autonomy model

## 12.1 Why task choice matters
If the player gives orders and policies rather than direct control, then task choice is the heart of the simulation.

A convincing NPC should not:
- ignore thirst to obey a woodcut order
- continue crafting while collapsing from exhaustion
- wander into a predator zone because the hauling job scored slightly higher
- stop all assigned work forever because one bad mood debuff appeared

## 12.2 Recommended decision hierarchy

### Layer 1 — emergency self-preservation
Overrides most other behavior:
- seek drink if critically dehydrated
- seek shelter/heat if exposure risk is critical
- flee immediate threat
- stop dangerous work if collapse/injury risk is extreme
- seek rest if near total exhaustion
- seek care if severely injured or sick

### Layer 2 — dependent/household emergency
If relevant later:
- protect infant/child/dependent
- respond to fire
- respond to attack
- respond to severe illness in bonded NPC if socially important

### Layer 3 — player hard orders and prohibitions
The player defines:
- what is allowed
- what is forbidden
- zones
- stock targets
- target buildings
- role locks
- work schedules
- emergency policies

### Layer 4 — role obligations
The NPC checks:
- current role
- assigned workplace
- expected routine
- communal responsibilities
- current shortages

### Layer 5 — local feasibility
The NPC scores candidate tasks by:
- reachable?
- materials available?
- tools available?
- daylight sufficient?
- weather acceptable?
- task safe enough?
- storage space available?
- task blocked by another missing step?

### Layer 6 — self-fit
The NPC prefers tasks that fit:
- interest
- aptitude
- competence
- current body condition
- social setting preference
- boredom state

### Layer 7 — efficiency and switching cost
The NPC then factors:
- distance
- already carrying relevant materials?
- already at the worksite?
- already in the right clothing/load state?
- will switching waste time?
- how urgent is the shortage?

## 12.3 Recommended task score components
Each task can be scored by:
- urgency
- survival importance
- settlement importance
- player priority
- role match
- body-state compatibility
- skill fit
- interest fit
- social fit
- resource feasibility
- travel time
- interruption cost
- morale effect
- danger penalty

## 12.4 Refusal and partial compliance
NPCs should sometimes:
- delay
- stop early
- seek help
- do a safer version
- ignore a low-priority order due to survival need
- refuse an extreme risk

This should be explainable in UI, not mysterious.

---

# 13. Morale and emotional state

## 13.1 Why morale matters
Morale should be treated as functional, not decorative.

Good morale improves:
- persistence
- initiative
- recovery after failure
- cooperation
- teaching
- role acceptance

Poor morale increases:
- task abandonment
- irritability
- mistakes
- conflict
- refusal risk
- turnover/desertion risk later

## 13.2 Main morale drivers

### Body-driven
- hunger
- thirst
- fatigue
- sleep quality
- pain
- illness
- warmth/cold
- dryness/wetness

### Social
- companionship
- conflict
- fairness of workload
- respect
- recognition
- living with trusted people
- having one's skills used well
- grief/loss later

### Environmental
- shelter quality
- clutter/filth
- darkness
- beauty/comfort later
- safety perception
- crowding later

### Work-driven
- role fit
- meaningful contribution
- repeated failure
- monotonous mismatch
- autonomy
- impossible orders
- overwork
- visible progress

## 13.3 Emotional states worth modeling
A compact set could include:
- calm
- focused
- content
- tired
- frustrated
- anxious
- lonely
- fearful
- proud
- angry
- grieving later
- inspired later

These states can be temporary overlays on top of broader morale.

---

# 14. Social simulation

## 14.1 Minimum useful social model
For the first playable, NPCs do not need a novel-length social brain.
But they should still have:

- familiarity
- trust
- bond strength
- role respect
- conflict level
- mentor links
- household membership
- perceived fairness

## 14.2 Important social effects

### Trust
High trust:
- smoother teamwork
- easier handoffs
- less stock theft fear later
- better teaching and care

Low trust:
- more conflict
- hoarding tendencies later
- reluctance to depend on others
- worse morale

### Respect
Respect should depend on:
- competence
- reliability
- bravery
- fairness
- leadership behavior
- ability to care for others

### Familiarity
Even a simple repeated-contact bonus matters.  
People work better with others they know well.

### Mentorship
A social link between teacher and learner should matter.
A good mentor can make an apprentice tolerate frustration better.

## 14.3 Social events that should matter
- shared meal
- successful rescue/help
- receiving care while ill
- being publicly blamed
- being praised
- working alone too long
- losing a close bond
- unfair workload
- unsafe leadership decision
- role promotion
- being forced into disliked work repeatedly

---

# 15. Recruitment and retention

The user chose a mixed/random early recruitment idea, which fits well.

## 15.1 Recommended recruitment sources
Early game:
- wanderer
- injured survivor
- refugee
- small kin group later
- neighbor from nearby camp later
- attracted laborer later

Mid/later game:
- migrants
- traders settling
- marriage/family ties
- apprentices
- hired specialists
- births

## 15.2 Recruitment conditions
A newcomer should be more likely when the settlement has:
- reliable water
- visible food stability
- spare sleeping space
- some safety
- visible fire/light
- low filth
- decent social climate
- not obviously starving

## 15.3 Retention conditions
A newcomer staying should depend on:
- food quality and reliability
- treatment by others
- usefulness / role fit
- safety
- health conditions
- autonomy and fairness
- prospects for belonging
- adequate shelter and warmth

## 15.4 Newcomer variability
A newcomer should bring:
- personality
- interests
- aptitudes
- weak or moderate pre-existing skills
- injuries/illness sometimes
- social baggage sometimes
- not always a clean optimization target

This is more realistic and gives the colony texture.

---

# 16. Knowledge model at the NPC level

## 16.1 Personal knowledge vs settlement knowledge
A useful split is:

### Personal knowledge
What this person personally knows:
- where water is
- how to set a snare
- how to scrape a hide
- which path floods
- which tasks are dangerous

### Settlement knowledge
What the colony as a social organism knows:
- clay location
- storage rules
- seed-saving rules
- smoking times
- common work procedures
- who knows which craft
- where danger zones are
- ration policy

## 16.2 Discovery flow
A realistic chain is:
1. person notices something
2. person tests it
3. result is uncertain
4. repeated success makes it trusted
5. teaching spreads it
6. recordkeeping later formalizes it

This supports your realism goal much better than instant unlock popups.

---

# 17. Recommended starter NPC generation

## 17.1 Starter philosophy
The first NPC should not be:
- helpless
- omniscient
- a maxed generalist
- a blank random number bundle

They should feel like:
- an ordinary capable adult
- with some intuitions
- some strengths
- some weaknesses
- some interests
- a few lightly practiced skills
- enough competence to survive if managed well
- enough limitations to make progress meaningful

## 17.2 Suggested generation template
Generate:

### Basic identity
- age band: young adult / adult / mature adult
- origin background tag: woodsman-adjacent, farm-adjacent, coastal-adjacent, craft-adjacent, drifter, etc.

### Trait profile
- 6–10 broad personality values
- 2–4 quirks

### Interests
- 3 strong interests
- 3 weak dislikes or indifferences
- rest neutral

### Aptitudes
- 2 high
- 3 above average
- several average
- 2 low

### Skills
Starting at mostly:
- aware
- novice
- a few practiced

No advanced specialist start unless chosen by scenario.

### Health
- mostly healthy baseline
- maybe one minor condition or quirk

## 17.3 Good starting examples
A few example starter NPCs:

### The Careful Gatherer
- high caution
- high botanical interest
- good observation
- weaker hunting and social leadership

### The Tough Improviser
- high endurance
- low orderliness
- good sheltering and carrying
- poor storage discipline

### The Fire-and-Food Worker
- high cooking interest
- good patience
- average strength
- weaker exploration

### The Curious Maker
- high curiosity
- high craft precision
- poor routine
- quickly learns tools and containers

These create different early stories without breaking realism.

---

# 18. First-playable implementation subset

This section narrows the huge system into what should exist first in Godot.

## 18.1 Core needs to implement first
- hydration
- hunger / stomach fullness
- medium-term nutrition/energy
- fatigue
- sleep quality
- temperature pressure
- wetness
- pain/injury
- sickness
- morale
- loneliness/social comfort

## 18.2 Core personality traits to implement first
- caution
- curiosity
- conscientiousness
- sociability
- emotional stability
- patience

## 18.3 Core interests to implement first
- plants
- animals
- cooking/fire
- making/crafting
- building
- exploring
- cleaning/order
- helping/care

## 18.4 Core aptitudes to implement first
- strength
- endurance
- dexterity
- observation
- memory
- spatial reasoning
- craft precision
- botanical sense
- animal handling
- social empathy

## 18.5 Core skills to implement first
- water finding
- water hauling
- fire starting
- fuel gathering
- shelter building
- edible plant gathering
- fishing or trapping depending biome
- skinning/butchery
- cooking
- drying/smoking
- cordage making
- basketry
- clay gathering
- crude pottery
- camp cleaning
- basic first aid
- hauling
- stock sorting
- simple teaching

## 18.6 Core behaviors to implement first
- seek drink when needed
- seek rest when needed
- seek shelter from dangerous weather
- follow player order if safe and feasible
- switch to emergency action when necessary
- prefer role-matching work
- prefer interest-matching work when equal
- learn from repetition
- gain morale from success and matched work
- lose morale from repeated failure, isolation, and neglect
- respond to injury and sickness
- form simple trust/bond values

## 18.7 First settlement social features
When the second and third NPCs arrive, first add:
- trust
- familiarity
- mentor/apprentice links
- conflict meter
- shared meal bonus
- household assignment

---

# 19. Data schema suggestions for Godot

This is a practical starting point, not a final programming spec.

## 19.1 NPC data blocks

### Identity
- id
- name
- age_band
- background_tags
- origin_type
- recruitment_source

### Core body state
- hydration
- fullness
- energy_balance
- fatigue
- sleep_debt
- thermal_stress
- wetness
- pain
- sickness
- dirtiness
- carry_load

### Psychological state
- morale
- stress
- fear
- loneliness
- focus
- autonomy_satisfaction
- fairness_satisfaction

### Personality
dictionary of broad trait values

### Interests
dictionary of interest values

### Aptitudes
dictionary of aptitude values

### Skills
dictionary of skill objects:
- value
- familiarity_stage
- confidence
- recent_practice
- last_used_time

### Social
- trust_by_npc
- bond_by_npc
- conflict_by_npc
- mentor_id
- household_id
- role_respect

### Work state
- current_role
- current_task
- current_target
- schedule_template
- allowed_tasks
- forbidden_tasks
- workplace_id
- queue_state

### Knowledge
- discovered_resources
- known_locations
- known_procedures
- taught_recipes/procedures
- warnings/danger tags

## 19.2 Useful derived values
Rather than storing everything directly, compute:
- current work capacity
- current learning efficiency
- accident susceptibility
- cooperation readiness
- desertion risk later
- care need level
- safe labor window
- preferred task families

---

# 20. UI implications for a minimal top-down game

The visuals can stay tiny and abstract if the UI is strong.

## 20.1 On-map representation
An NPC can remain:
- a colored dot
- a few pixels
- maybe one small status pip

Meaning comes from UI overlays, not art complexity.

## 20.2 NPC detail panel
Selecting an NPC should show:

### Top line
- name
- current task
- role
- immediate condition label

### Body
- water
- food
- fatigue
- temperature/wetness
- health

### Mind
- morale
- stress
- loneliness
- focus

### Traits and interests
- key traits
- strong interests
- dislikes

### Skills
- top relevant skills
- current learning targets

### Social
- household
- close bonds
- trust/conflict flags

### Recent log
- "Stopped hauling: severe thirst"
- "Slept poorly: rain leakage"
- "Improved basketry from repeated practice"
- "Avoided north path: predator sign"
- "Enjoyed fire tending task"

## 20.3 Important design rule
The simulation is only fair if the UI explains why NPCs did what they did.

---

# 21. Open design questions for later versions

## 21.1 How detailed should illness become?
Options:
- light and abstract
- sanitation-linked named illnesses
- more complex body system later

## 21.2 How deep should social simulation go?
Options:
- light trust/conflict only
- households and mentorship
- marriage/family/faction/politics later

## 21.3 How persistent should trauma/grief be?
Could matter later when deaths become common enough to shape settlement history.

## 21.4 How much hidden information should there be?
For fairness, I recommend:
- most current need pressures visible
- some exact trait values hidden behind words or ranges
- some discovery knowledge partially uncertain

## 21.5 Should NPCs have ideology/culture/religion layers later?
Potentially yes, but not needed for the first playable.

---

# 22. Recommended next step after this document

The strongest next move is to create the first **NPC Data Sheets** and **Task Evaluation Spec**.

That means:

## 22.1 NPC Data Sheets
Define the actual fields and ranges for:
- needs
- traits
- interests
- aptitudes
- skills
- morale drivers
- social links

## 22.2 Task Evaluation Spec
Define:
- task score formula
- emergency override rules
- interruption logic
- compliance/refusal logic
- teaching behavior
- hauling/path choice logic

## 22.3 Early skill database
Turn the early skill subset into:
- exact skill names
- parent categories
- what each skill affects
- what trains it
- what items/buildings/processes use it

That will make implementation much easier.

---

# 23. Short conclusion

A realism-first colony game stands or falls on whether its people feel believable.

The right NPC model for this project is not:
- a spreadsheet-only labor unit
- a fully scripted character drama simulator

It is something in between:

- a human body with real needs
- a mind shaped by sleep, stress, and morale
- a personality that changes work style
- interests that shape motivation
- aptitudes that shape talent
- skills that grow through practice and feedback
- social ties that change resilience and cooperation
- a work brain that follows orders, but only within believable human limits

That is the foundation that can later support:
- camps
- hamlets
- workshops
- towns
- factories
- utilities
- institutions
- and eventually a functioning city full of specialized people

---

# References

- [R1] CDC, *About Sleep*  
  https://www.cdc.gov/sleep/about/index.html

- [R2] CDC, *Sleep Deprivation, Sleep Disorders, and Chronic Disease*  
  https://www.cdc.gov/pcd/issues/2023/23_0197.htm

- [R3] PMC / NIH, *The role of sleep for memory consolidation*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC10728269/

- [R4] CDC, *Daily Water Intake Among US Men and Women, 2009–2012*  
  https://www.cdc.gov/nchs/products/databriefs/db242.htm

- [R5] CDC / NIOSH, *Heat Stress and Workers*  
  https://www.cdc.gov/niosh/heat-stress/about/index.html

- [R6] CDC / NIOSH, *Workplace Recommendations | Heat*  
  https://www.cdc.gov/niosh/heat-stress/recommendations/index.html

- [R7] OSHA, *Heat Stress Guide*  
  https://www.osha.gov/emergency-preparedness/guides/heat-stress

- [R8] WHO, *Social connection*  
  https://www.who.int/news-room/questions-and-answers/item/social-connection

- [R9] WHO, *Social Isolation and Loneliness*  
  https://www.who.int/teams/social-determinants-of-health/demographic-change-and-healthy-ageing/social-isolation-and-loneliness

- [R10] PubMed, McCrae & John, *An introduction to the five-factor model and its applications*  
  https://pubmed.ncbi.nlm.nih.gov/1635039/

- [R11] PMC, *The Five Factor Model of personality structure: an update*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC6732674/

- [R12] PMC, *The role of deliberate practice in the acquisition of clinical skills*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC3293754/

- [R13] PMC, Ericsson, *Deliberate Practice and Proposed Limits on the Effects of Practice on the Acquisition of Expert Performance*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC6824411/

- [R14] NCBI Bookshelf, *Impact of Underconsumption on Cognitive Performance*  
  https://www.ncbi.nlm.nih.gov/books/NBK232439/

- [R15] WHO, *Micronutrients*  
  https://www.who.int/health-topics/micronutrients
