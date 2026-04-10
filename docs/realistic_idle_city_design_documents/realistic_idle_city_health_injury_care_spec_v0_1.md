# Realistic Idle City — Health / Injury / Care Spec v0.1

## Status
Draft v0.1

## Scope
This document defines the **health, injury, illness, recovery, and caregiving layer** for the early playable slice of the project:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It is meant to sit on top of the existing design stack:

- overall design and progression
- early-game design bible
- NPC simulation spec
- NPC schema and task evaluation
- item & material bible
- process bible
- building & structure bible
- settlement progression spec
- knowledge & discovery spec
- social / recruitment spec
- allocation / ownership / rationing spec

This is a **game design document**, not real-world medical advice.

---

# 1. Purpose of this spec

The project already defines NPCs as embodied people with body state, morale, skills, interests, and social ties. Health cannot therefore be a flat hit-point bar. It must be a practical system that answers questions like:

- What happens when someone is thirsty, cold, sleep-deprived, or injured?
- Which conditions are immediate emergencies versus slow burdens?
- How does bad sanitation create illness pressure?
- How does care consume labor, fuel, clean water, food, textiles, and shelter quality?
- When is self-care enough and when is another NPC needed?
- What turns a camp from "survivable" into "healthy enough to grow"?

The goal is not to simulate modern medicine from the beginning. The goal is to model **realistic early survival medicine and care burdens**:

- hydration
- warmth/cooling
- sleep and rest
- clean wounds and bleeding control
- sanitation and contamination control
- safe food and water
- observation, nursing, and recovery time
- gradual emergence of dedicated care roles

---

# 2. Design posture

## 2.1 Core rule
In the early game, the greatest killers are not exotic diseases. They are ordinary burdens handled badly:

- not enough safe water
- cold and wet exposure
- heat stress
- exhaustion
- dirty wounds
- unsafe food and water
- poor sanitation
- lack of rest
- lack of nursing attention

## 2.2 Health is both personal and systemic
Health outcomes should depend on:

### Personal state
- constitution / resilience
- age category later if added
- temperature tolerance
- disease resistance
- current fatigue
- nourishment and hydration
- morale / willingness to comply with rest or care
- pain tolerance

### Environmental state
- weather exposure
- bedding dryness
- shelter quality
- water source quality
- camp cleanliness
- waste placement
- crowding
- smoke burden
- food spoilage risk
- presence of insects/vermin

### Social state
- whether someone notices deterioration
- whether another NPC is free to help
- whether reserves can be allocated
- trust in the caregiver / leadership
- whether the settlement has routines for hygiene, rest, and observation

## 2.3 Realism rule
Health recovery should rarely be a single "use item -> fixed heal" interaction.
Early recovery is mainly the result of:

- stopping the damage source
- cleaning and protecting the person
- warming or cooling them
- fluids and food
- rest and sleep
- time
- observation
- repeat care

---

# 3. High-level health model

Each NPC should have a **health state** made of interacting sub-systems rather than one pooled value.

## 3.1 Recommended top-level health domains

### A. Hydration state
Tracks water balance and fluid loss pressure.

### B. Energy / nourishment state
Tracks short-term food sufficiency and longer recovery support.

### C. Temperature state
Tracks cold stress, heat stress, wetness, exposure, and thermal stability.

### D. Fatigue / sleep debt state
Tracks acute exhaustion, sleep deprivation, and recovery quality.

### E. Injury state
Tracks physical damage: cuts, punctures, blunt trauma, sprains, fractures later, burns later.

### F. Illness state
Tracks non-injury sickness: diarrhea, vomiting, fever-like infections, respiratory irritation, parasites later.

### G. Pain / functional impairment state
Tracks how much the person can still work, think, and move.

### H. Contamination / infection risk state
Tracks how dirty a wound/body/item is and the chance that it progresses into illness or wound infection.

### I. Recovery reserve state
Tracks whether the body has enough rest, warmth, water, calories, and attention to heal.

## 3.2 What not to do
Do not reduce early health to:

- HP only
- hunger bar only
- poisoned / not poisoned binary
- heal-over-time potion logic

That would break the realism foundation already established in the project.

---

# 4. Body-state axes and what they should do

## 4.1 Hydration
Hydration should degrade from:

- time without drinking
- heavy labor
- heat
- fever
- vomiting
- diarrhea
- long hauling trips
- carrying loads uphill

Hydration affects:

- stamina recovery
- speed
- concentration
- morale
- heat tolerance
- task error rate
- collapse risk in severe cases

### Suggested state bands
- **Satisfied**
- **Needs Drink**
- **Thirsty**
- **Dehydrated**
- **Severely Dehydrated / Critical**

### Visible early indicators
- seeking water more often
- reduced work pace
- irritability
- darker-urine proxy in hidden simulation / debug only
- dizziness / slower reactions in worse states

## 4.2 Energy and nourishment
This is not just hunger. It should separate:

### A. Short-term calories
Enough energy to keep moving and working today.

### B. Recovery nutrition
Enough ongoing food quality to support healing, temperature regulation, and sustained labor.

Effects of poor nourishment:
- reduced work capacity
- worse cold tolerance
- worse wound healing
- worse illness recovery
- morale decline
- reduced reserve for childbearing/family growth later

## 4.3 Temperature and exposure
Temperature should be driven by:

- ambient weather
- wind
- rain/snow/wetness
- clothing coverage
- bedding insulation
- shelter dryness
- fire access
- recent exertion
- rest vs movement

Effects:
- cold lowers dexterity, speed, judgment, and sleep quality
- heat raises water demand and fatigue
- wetness sharply worsens cold exposure
- repeated borderline exposure weakens overall recovery even without dramatic collapse

### State bands
- Comfortable
- Chilled / Hot
- Cold-Stressed / Heat-Stressed
- Dangerous Cold / Heat Exhaustion
- Critical Exposure / Heat Stroke-like crisis

## 4.4 Fatigue and sleep debt
Fatigue should come from:

- long work without pauses
- interrupted sleep
- poor bedding
- cold sleep
- wet sleep
- night activity
- illness
- pain
- caregiving during usual sleep hours

Effects:
- slower movement
- poor judgment
- lower morale
- reduced learning
- higher accident risk
- higher task interruption/failure
- weaker immune/recovery performance

This should be one of the heaviest hidden drivers of mistakes in the early game.

## 4.5 Pain and functional impairment
Pain should not only be flavor text.
It should affect:

- willingness to choose hard tasks
- tool precision
- movement speed
- sleep quality
- mood
- whether assistance is required

Pain should come from:
- open wounds
- bruising
- sprains
- burns later
- severe dehydration
- fever/illness

## 4.6 Hygiene burden
Hygiene is not the same thing as cleanliness score for camp beauty.
It should matter because it changes:

- wound contamination risk
- diarrheal disease risk
- food contamination risk
- morale
- social acceptance of close contact/care

---

# 5. Injury model

## 5.1 Injury families for the early slice

### A. Minor cuts and scrapes
Sources:
- stone work
- wood work
- brush clearing
- butchering
- falls

Gameplay effect:
- mild pain
- small infection risk if left dirty
- minor efficiency reduction only if multiple or on hands/feet

### B. Deep cuts / lacerations
Sources:
- sharp stone tools
- axe/hatchet equivalents later
- hide processing blades
- severe accidents

Gameplay effect:
- bleeding
- stronger pain
- possible task interruption
- high contamination risk
- real danger if untreated

### C. Puncture wounds
Sources:
- thorns
- splinters
- bone awls
- stakes
- animal bites later

Gameplay effect:
- deceptively small external wound
- meaningful infection risk
- hand/foot impairment especially important

### D. Bruises / blunt trauma
Sources:
- falls
- dropping loads
- hauling accidents
- animal strikes later

Gameplay effect:
- pain
- reduced carrying / movement
- usually lower infection risk than open wounds

### E. Sprain / strain
Sources:
- overexertion
- slips
- awkward load carrying
- digging / lifting

Gameplay effect:
- reduced hauling
- reduced travel speed
- increased rest need
- recurring pain if pushed too early

### F. Fracture-like injury
Should be rare in the earliest slice, but possible from major falls or heavy accidents.

Gameplay effect:
- massive role disruption
- long recovery
- care burden on others
- possible permanent weakness if badly managed

### G. Burn / smoke injury
Useful but can enter a bit later in the slice.
Sources:
- hearth accidents
- pottery firing
- hot stones / coals
- smoke-heavy sleeping spaces

Gameplay effect:
- pain
- infection risk for broken skin
- respiratory strain from smoke

## 5.2 Injury attributes
Every injury instance should carry:

- body location
- severity
- open or closed
- bleeding rate
- contamination level
- pain value
- mobility/hand-use penalty
- treatment status
- healing stage
- infection state if applicable
- scar / long-term effect later

## 5.3 Body location matters
Examples:
- hand injuries reduce crafting, tool use, butchery, weaving, cordage
- foot injuries reduce hauling, scouting, water trips
- torso injuries reduce endurance and sleep comfort
- face/eye injuries severely reduce safety and precision

## 5.4 Bleeding model
Bleeding should be a separate immediate threat from infection.

### Suggested bands
- none
- oozing
- steady bleeding
- severe bleeding

Immediate priorities:
1. stop/slow bleeding
2. clean when safe to do so
3. protect wound
4. observe for later infection or reopening

---

# 6. Illness model

## 6.1 Illness families for the early slice

### A. Unsafe-water / unsafe-food illness
This is one of the most important early disease routes.

Typical gameplay presentation:
- nausea
- vomiting
- diarrhea
- weakness
- thirst
- dehydration risk
- reluctance to eat

Why it matters:
Even when not instantly lethal, it steals time, water, fuel, and labor.

### B. Wound infection
This should emerge from dirty injury care rather than appearing randomly.

Typical gameplay presentation:
- worsening pain
- redness/spreading heat/swelling proxies
- discharge/pus proxy
- fever-like burden
- reduced function
- worse sleep

### C. Respiratory irritation / smoke burden
Likely in primitive camps with poorly ventilated fire use.

Presentation:
- coughing
- eye irritation
- worse sleep
- worse work tolerance
- higher discomfort indoors

### D. Exposure illness burden
Not every cold/wet event should become a named disease.
Often the important result is:
- deep fatigue
- poor sleep
- lowered resilience
- slower healing
- greater vulnerability to later illness

### E. Fever-like systemic illness
Useful as a broad category for infections without pretending early camps can diagnose precisely.

Presentation:
- hot/cold alternation
- weakness
- desire to lie down
- thirst
- appetite loss
- work incapacity

### F. Parasite / chronic contamination burden
May appear later in the early slice as a slow pressure rather than a dramatic event.

Presentation:
- intermittent gastrointestinal trouble
- lower long-term vigor
- poorer growth in children later
- weight loss later if modeled

## 6.2 Illness attributes
Each illness should track:

- likely source route
- onset speed
- severity
- contagiousness if relevant
- fluid loss rate
- appetite suppression
- work impairment
- rest need
- care demand
- mortality risk if untreated
- recurrence chance if source persists

## 6.3 Named diagnosis vs practical condition
Early game should often use practical labels, not modern exact diagnoses.

Examples:
- bad water sickness
- infected cut
- heat collapse
- cold exposure
- smoke sickness
- stomach illness

That fits the realism of a low-tech settlement much better.

---

# 7. Emergency pathways

Not all health problems are equal. The system needs a real triage hierarchy.

## 7.1 Immediate life-threat categories
These should interrupt most normal work:

- severe bleeding
- collapse from dehydration/heat/cold
- inability to stay warm
- inability to keep fluids down for long enough
- confusion/delirium-level illness burden
- rapidly worsening infected wound / sepsis-like crisis
- fracture-like immobility when exposed or alone

## 7.2 High-priority urgent categories
These should strongly compete with production tasks:

- steady bleeding
- wound needing cleaning and protection
- fever with weakness
- repeated diarrhea/vomiting
- severe sleep deprivation / exhaustion collapse risk
- dangerous hand/foot injury in key worker

## 7.3 Routine but important categories
These can be scheduled if reserves exist:

- dressing change
- wound inspection
- assisted bathing/washing
- fire warming supervision
- rehydration rounds
- extra meal allocation for recovery
- reduced-duty schedules

---

# 8. Care model

## 8.1 Care is work
Care should consume:

- labor time
- water
- clean cloth/textiles
- fuel for boiling water / warming
- protected indoor or sheltered space
- food reserves
- morale bandwidth

This is one of the main reasons a healthier settlement can grow faster: it can absorb setbacks.

## 8.2 Care modes

### A. Self-care
Possible when impairment is mild.
Examples:
- drink more
- sit by fire
- wash wound
- rest
- rewrap simple cut

### B. Assisted care
Needed when the person is weak, confused, immobile, or in pain.
Examples:
- fetching water for them
- helping clean wound
- maintaining warmth
- carrying to bed/shelter
- preparing easy food
- monitoring condition

### C. Watch care
A special mode where another NPC periodically checks:
- temperature/exposure state
- alertness
- fluid intake
- bleeding status
- whether condition is worsening

### D. Continuous nursing burden
Rare in the earliest slice, but possible in severe illness/injury.
This sharply reduces settlement labor capacity.

## 8.3 Core care actions

### Hydration care
- bring drinkable water
- prioritize safest available water
- encourage repeated drinking
- provide broths/gruels later
- if vomiting/diarrhea persists, care becomes time-intensive

### Warming care
- move out of wind/wet conditions
- replace wet bedding/clothing when possible
- fire access
- insulated sleep setup
- shared shelter warmth if socially acceptable

### Cooling care
- reduce exertion
- move to shade/airflow
- cool wet cloths / water use later if available
- prioritize fluids

### Wound care
- stop bleeding
- rinse/clean with safest practical water
- remove obvious debris when possible
- cover/protect wound
- change dressing when dirty/wet
- reduce further contamination and strain

### Rest care
- protected sleeping time
- reduced task load
- pain-compatible posture/location
- less night interruption

### Illness nursing
- fluids
- warmth/cooling as needed
- easy-to-digest food if tolerated
- sanitation around vomit/feces
- observation for worsening status

---

# 9. Environmental health and sanitation

## 9.1 Sanitation as a health multiplier
Poor sanitation should not be a background mood penalty. It should actively change disease pressure.

It affects:
- water contamination risk
- flies/vermin attraction
- food contamination risk
- wound contamination risk
- recruitment attractiveness
- morale and dignity

## 9.2 Early sanitation rules

### Waste placement
Human waste areas should be:
- away from water collection
- away from food prep
- away from sleeping core
- reachable enough that NPCs actually use them

### Washing separation
Separate at least conceptually:
- drinking water storage
- dirty washing water use
- carcass cleaning area
- latrine area

### Carcass management
Badly handled carcasses should create:
- contamination pressure
- vermin attraction
- morale penalty
- illness risk for butchery workers

### Dirty textiles/bedding
Wet or soiled bedding should worsen:
- cold stress
- skin irritation burden
- sleep quality
- infection/wound outcomes

## 9.3 Hygiene labor
Hygiene should create repeatable tasks:
- empty/cover refuse pits later
- maintain latrine area
- wash/air bedding
- clean food surfaces/areas
- rotate water containers
- burn or bury foul waste where appropriate
- isolate dirty and clean textiles

---

# 10. Food, water, and healing support

## 10.1 Safe water matters twice
Water is needed both for:

- ordinary survival
- recovery from illness and wounds

So health crises increase pressure on:
- hauling labor
- boiling fuel
- clean containers
- water ration rules

## 10.2 Nutrition and healing
Recovery should be faster when the NPC has:
- enough calories
- enough protein/fat quality later where modeled
- enough fluids
- less ongoing cold stress
- enough sleep

This should not require precise micronutrient simulation early on, but poor diets should still prolong healing.

## 10.3 Appetite loss
Illness should often reduce appetite.
This creates a dangerous loop:
- illness -> less eating/drinking -> slower recovery -> worse weakness

Good care can partly break that loop.

## 10.4 Recovery foods
Early game care foods should be simple and realistic:
- warm water / boiled water
- diluted broths if ingredients exist
- soft cooked foods / gruels later
- easy-to-chew cooked roots or mash

Do not make recovery food magical. It supports healing; it does not instantly cure disease.

---

# 11. Heat and cold pathways

## 11.1 Cold exposure pathway
Common route:
- rain/wetness
- wind exposure
- insufficient shelter
- poor bedding
- night cold
- fatigue reducing heat production/response

Effects should escalate like this:
1. discomfort and slower work
2. dexterity loss and morale drop
3. bad sleep and poor judgment
4. dangerous cold stress with collapse risk
5. possible death without intervention

## 11.2 Heat stress pathway
Common route:
- intense midday labor
- long hauling trips
- poor access to water/shade
- fever/illness on top of heat
- heavy clothing later

Effects:
1. faster stamina drain
2. higher fluid demand
3. slowing, irritability, mistakes
4. heat exhaustion-type state
5. heat-stroke-like crisis if ignored

## 11.3 Fire as health infrastructure
The hearth is not only a crafting station.
It is health infrastructure because it supports:
- warming
- drying
- safer water
- better sleep comfort
- some food safety
- morale and watch care at night

---

# 12. Wound contamination, infection, and escalation

## 12.1 Contamination sources
A wound becomes more dangerous when exposed to:
- soil
- dirty water
- fecal contamination
- animal matter / butchery mess
- old dirty bandages
- repeated handling with dirty hands

## 12.2 Contamination states
Suggested hidden model:
- clean
- lightly contaminated
- contaminated
- heavily contaminated

Contamination should raise chance of:
- delayed healing
- pain increase
- wound reopening
- infection

## 12.3 Infection pathway
A reasonable early-game pathway:
1. wound occurs
2. bleeding controlled or not
3. wound cleaned poorly / not at all
4. contamination remains
5. local infection signs appear
6. sleep/work worsen
7. fever-like systemic burden may emerge
8. sepsis-like crisis possible in the worst cases

## 12.4 Sepsis-like abstraction
The game does not need detailed microbiology early.
But it should respect the reality that an infection can become whole-body and life-threatening.

Use a practical late-stage label such as:
- severe infection
- whole-body infection
- septic crisis

This state should be rare but frightening.

---

# 13. Fatigue, sleep, and care burden

## 13.1 Fatigue as a health hazard
Fatigue should increase:
- accident chance
- poor triage decisions
- missed symptoms
- task abandonment
- emotional volatility
- resistance to social cooperation

## 13.2 Caregiver fatigue
A small settlement can be destabilized if one sick NPC forces another into chronic night care.

Caregiver fatigue should reduce:
- their work output
- patience
- judgment
- morale
- social warmth

## 13.3 Sleep quality inputs
Sleep quality should depend on:
- dryness
- warmth
- bedding thickness
- noise/disruption
- pain
- smoke burden
- fear / recent danger
- overcrowding later
- childcare later

Good sleep should be one of the strongest non-material recovery multipliers in the game.

---

# 14. Morale and social effects of illness

## 14.1 Illness is social
When someone is hurt or sick, others should react.
Possible effects:
- sympathy / care motivation
- fear of infection
- irritation if burdens feel unfair
- stronger bonding after successful care
- trust gained or lost depending on leadership choices

## 14.2 Leadership legitimacy
If the player or colony policies repeatedly:
- deny water to the sick
- overwork injured people
- consume seed reserves while ignoring recovery food
- force unsafe tasks while feverish/exhausted

then NPC trust and social cohesion should fall.

## 14.3 Care and belonging
Successful care should increase:
- relationship strength
- perceived safety of settlement
- outsider willingness to stay
- sense that the colony is becoming a real community

---

# 15. Care roles and skills

## 15.1 Early care-related skills
There is no problem with having many skills here, as long as they group well.

Suggested early care skill set:

### Core survival-care skills
- hydration care
- rest/sleep management
- warming and cooling care
- wound cleaning
- bleeding control
- wrapping/bandaging
- sanitation maintenance
- food safety
- water safety handling
- bedside observation

### Extended practical care skills
- splinting/stabilization
- supportive feeding
- fever care
- vomiting/diarrhea care
- smoke-safe hearth management
- bedding maintenance
- lifting/carrying injured people safely
- quarantine/isolation practice later if needed

### Knowledge-linked later care skills
- herbal preparation knowledge later, if grounded carefully
- childbirth care later
- animal health / veterinary care later
- dedicated nursing
- surgery/dentistry much later

## 15.2 Role emergence across the early slice

### Lone survivor
The NPC performs crude self-care only.

### Primitive camp
One NPC can maintain hygiene routines, safer water handling, and basic wound care.

### Permanent camp
Part-time care specialization appears:
- one NPC may be best at watching, cleaning, wrapping, preparing easy food, and organizing rest.

### Tiny hamlet
Possible role labels:
- caregiver
- cleaner / sanitation worker
- cook / recovery food worker
- water safety worker
- elder/mentor with care knowledge

---

# 16. Care items and care materials

## 16.1 Early care items
These should come from existing item/process layers.

### Water and fluids
- raw water
- settled water
- boiled water
- safest stored water
- broth / thin soup later
- soft recovery food later

### Textile care items
- clean cloth strip
- dirty cloth strip
- dry wrapping cloth
- padded dressing cloth later
- sling later

### Shelter care items
- dry bedding
- wet bedding
- insulated bedding
- spare wrap
- warm hide covering

### Cleaning / handling items
- wash bowl / vessel
- clean storage pot
- dirty vessel
- soap later when unlocked
- ash/abrasive cleaning agents only where appropriate later

### Stabilization items
- straight sticks / splint materials later
- cordage ties
- padded supports

## 16.2 Important realism rule for care items
A bandage should not be an abstract consumable with no quality.
At minimum it should care about:
- clean vs dirty
- dry vs wet
- rough vs soft
- enough length/coverage

## 16.3 Degradation and contamination
Care items should become dirty through use.
That creates laundry/cleaning or disposal pressure later.

---

# 17. Care spaces and buildings

## 17.1 No hospital at the start
Early care happens in ordinary spaces, but those spaces still matter.

## 17.2 Early care-capable spaces

### A. Warm rest corner in shelter
Supports:
- fever rest
- cold recovery
- wound observation
- reduced night exposure

### B. Hearth-adjacent care zone
Supports:
- warming
- boiled water preparation
- supervised rest
- wet-cloth drying

### C. Clean water handling zone
Supports:
- drink preparation
- wound rinsing
- storage rotation

### D. Wash / dirty-work zone
Keeps contamination away from sleep and food spaces.

### E. Quiet sleeping space
Improves sleep quality and recovery.

## 17.3 Later early-game structures
By permanent camp / hamlet stage, useful structures include:
- dedicated wash area
- better-located latrine
- sheltered rest hut or expanded sleeping hut
- clean food prep area
- quarantine/rest corner for foul illness later if needed

---

# 18. Health events and settlement progression

## 18.1 Lone survivor stage
Dominant dangers:
- dehydration
- exposure
- fatigue collapse
- minor injuries becoming serious because no one helps
- unsafe water/food sickness

Design meaning:
Health is mainly about not letting ordinary burdens spiral.

## 18.2 Primitive camp stage
New benefits:
- fire-supported recovery
- better sleep
- safer water routines
- protected food and bedding
- designated waste area

Design meaning:
Health becomes somewhat manageable, but one bad illness can still halt everything.

## 18.3 Permanent camp stage
New benefits:
- stored water/fuel/food
- containers and better textiles
- cleaner work separation
- more repeatable care routines
- another NPC can cover work while one recovers

Design meaning:
Illness and injury stop being automatic catastrophes.
They become burdens the settlement may be able to absorb.

## 18.4 Tiny hamlet stage
New benefits:
- basic reserve planning for sickness
- care labor can be assigned intentionally
- cleaner camp zoning
- role differentiation
- stronger observation and watch routines

Design meaning:
The settlement begins to act like a society with health resilience, not just a cluster of bodies.

---

# 19. Interaction with allocation, ownership, and rationing

## 19.1 Sick-room priority logic
The allocation system should recognize that health crises temporarily change fairness rules.

Examples:
- the febrile/dehydrated NPC may receive safer water first
- the wounded NPC may receive cleaner cloth first
- the cold-exposed NPC may receive the driest bedding first
- the vomiting NPC may receive easier foods and more fire access

## 19.2 Emergency reserve release
Medical-like emergencies should be one of the main reasons a settlement breaks reserve rules.

Emergency reserve categories:
- clean water reserve
- easy-food reserve
- fuel reserve for warming/boiling
- clean-cloth reserve
- sheltered bed space

## 19.3 Social risk
If priority care is given unfairly, opaquely, or repeatedly to favored NPCs, resentment should rise.
If clearly justified and communicated, compliance should be better.

---

# 20. Interaction with knowledge and discovery

## 20.1 Care knowledge is not all innate
An NPC may have care intuition, but reliable health management should improve through observation and repetition.

Examples of early discoveries:
- this water source causes less sickness
- boiling and covered storage reduce bad-water episodes
- wet bedding sharply worsens cold nights
- dirty wraps worsen wound outcomes
- certain work-rest schedules reduce collapse in heat
- smoke-heavy sleeping huts worsen cough and bad sleep

## 20.2 Care knowledge categories

### Observation knowledge
"People sleeping dry near the fire recover better."

### Procedural knowledge
"Clean the wound first, then cover it with a clean dry wrap."

### Institutional knowledge
"We keep the drinking-water pots covered and separate from wash water."

### Triage knowledge
"This wound can wait, that bleeding cannot."

## 20.3 Misconceptions
Health systems feel more real if mistaken beliefs can exist.
Examples:
- overtrusting dirty-looking but "cold" water
- thinking rest is laziness during fever
- reusing filthy cloth because cloth is scarce
- sleeping too many people around a smoky fire

These should be correctable through experience and teaching.

---

# 21. Suggested simulation rules

## 21.1 Health outcome formula philosophy
Health outcomes should emerge from weighted factors, not single hard scripts.

### Example: wound infection pressure
Could be influenced by:
- wound depth
- contamination level
- time before cleaning
- water cleanliness used for cleaning
- dressing cleanliness
- repeated re-contamination
- NPC resilience
- overall nourishment/hydration
- sleep quality

### Example: illness recovery speed
Could be influenced by:
- hydration status
- calorie intake
- temperature comfort
- rest quality
- severity at onset
- care attention time
- ongoing contamination exposure

## 21.2 Hard blockers for work
An NPC should refuse or fail most ordinary work when:
- severe bleeding
- collapse / near-collapse
- critical dehydration
- severe exposure
- delirium/confusion
- fracture-like immobility

## 21.3 Soft blockers for work
NPCs may still work, but badly, when:
- thirsty
- chilled
- in moderate pain
- feverish but stubborn
- sleep-deprived
- limping

This is important because realism often means people keep working too long.

---

# 22. Suggested data schema

## 22.1 Health state block
For each NPC:

- hydration_band
- energy_band
- temperature_band
- wetness_level
- fatigue_band
- sleep_debt_score
- pain_score
- illness_load_score
- infection_load_score
- mobility_penalty
- hand_use_penalty
- appetite_modifier
- recovery_reserve_score
- current_rest_need
- care_priority_level

## 22.2 Injury record
- injury_id
- type
- body_location
- severity
- bleeding_state
- contamination_state
- pain_value
- functional_penalties
- time_since_injury
- cleaned_flag
- covered_flag
- stabilized_flag
- infection_stage
- healing_stage
- permanent_effect_flag later

## 22.3 Illness record
- illness_id
- source_route
- onset_time
- severity
- fluid_loss_rate
- fever_flag
- contagious_flag
- appetite_penalty
- fatigue_penalty
- care_intensity_needed
- work_restrictions
- improvement_trend
- crisis_risk

## 22.4 Care plan record
- patient_npc_id
- urgency
- prescribed_rest_level
- target_fluid_intake_band
- target_temperature_support
- wound_care_interval
- observation_interval
- food_priority_rule
- isolation_rule if any
- assigned_caregiver_npc_id if any
- current_compliance

---

# 23. First-playable subset

To keep the first implementation grounded, the minimum health slice should include:

## Conditions
- thirst / dehydration
- cold/wet exposure
- heat stress
- fatigue / sleep debt
- minor wound
- bleeding wound
- infected wound
- bad-water / bad-food stomach illness
- fever-like illness burden

## Care actions
- drink water
- fetch water for patient
- boil water
- rest / lie down
- warm by fire
- move to shelter
- replace wet bedding / wrapping
- clean wound
- apply clean cloth wrap
- inspect patient
- reduce work duty

## Health-linked environmental systems
- sheltered sleep
- fire
- safe water chain
- latrine placement
- dirty/clean zone separation
- food spoilage / contamination
- bedding dryness

That is enough to make the early settlement feel alive and vulnerable.

---

# 24. Anti-patterns to avoid

## 24.1 Do not make sickness random noise
Illness should usually arise from identifiable causes:
- unsafe water
- spoiled food
- dirty wounds
- exposure
- smoke burden
- overwork

## 24.2 Do not make care free
If care costs no labor or resources, health stops mattering systemically.

## 24.3 Do not make all injuries equivalent
A hand cut and a foot cut should not behave the same.

## 24.4 Do not make rest optional fluff
Sleep and recovery should be mechanically important.

## 24.5 Do not make herbalism magical by default
Later herbal content can exist, but early care should remain grounded in:
- water
- warmth/cooling
- cleanliness
- pressure/wrapping/stabilization
- food
- rest
- time

---

# 25. Recommended next companion docs

The strongest next documents after this one are:

1. **Environmental Hazard Spec**
   Weather, smoke, vermin, insects, contamination zones, dangerous terrain, seasonal disease pressure.

2. **Food Safety / Water Safety Spec**
   A deeper document focused only on contamination routes, spoilage, safe handling, boiling, storage, washing, and settlement routines.

3. **Agriculture / Husbandry Spec**
   Needed because animal disease, manure, fodder, and food security will soon interact heavily with health.

4. **Policy / Priority Rules Spec**
   Needed to translate all of this into player-settable camp rules.

---

# 26. References used for grounding

These were used as realism anchors for this spec.

- CDC — About Water and Healthier Drinks  
  https://www.cdc.gov/healthy-weight-growth/water-healthy-drinks/index.html

- CDC — Preventing Hypothermia  
  https://www.cdc.gov/winter-weather/prevention/index.html

- CDC — Emergency Wound Care After a Natural Disaster  
  https://www.cdc.gov/natural-disasters/communication-resources/emergency-wound-care-after-a-natural-disaster-factsheet.html

- CDC / NIOSH — Work-related Fatigue Reaches Beyond the Workplace  
  https://www.cdc.gov/niosh/bulletin/2020/fatigue-work.html

- CDC / NIOSH — Choosing the “Right” Fatigue Monitoring and Detection Technology  
  https://www.cdc.gov/niosh/bulletin/2021/fatigue.html

- CDC — Treatment of Salmonella Infection  
  https://www.cdc.gov/salmonella/treatment/index.html

- WHO — Diarrhoeal disease  
  https://www.who.int/news-room/fact-sheets/detail/diarrhoeal-disease

- WHO — Drinking-water  
  https://www.who.int/news-room/fact-sheets/detail/drinking-water

- WHO — Water, sanitation and hygiene (WASH)  
  https://www.who.int/health-topics/water-sanitation-and-hygiene-wash

- WHO — Hand washing promotion for preventing diarrhoea  
  https://www.who.int/tools/elena/review-summaries/wsh-diarrhoea--hand-washing-promotion-for-preventing-diarrhoea

- MedlinePlus — Hypothermia  
  https://medlineplus.gov/hypothermia.html

- MedlinePlus — Heat Illness  
  https://medlineplus.gov/heatillness.html

- MedlinePlus — Sepsis  
  https://medlineplus.gov/sepsis.html

- NIH — Halting Hypothermia  
  https://newsinhealth.nih.gov/2015/12/halting-hypothermia

- NIH document — Eating Well for Wound Healing  
  https://www.nih.org/documents/Wound-Healing_Nutrition-2021.pdf

