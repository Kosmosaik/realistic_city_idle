---
title: "Realistic Idle City — Education / Apprenticeship / Institutional Training Spec"
version: "v0.1"
date: "2026-04-09"
scope:
  - "Early slice primary focus: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
  - "Scales forward into agrarian village, market town, and later institutional society"
assumptions:
  - "Earth-like setting"
  - "Temperate starting biome"
  - "One adult starter NPC with ordinary human intuition"
  - "Realism-first dependency model"
  - "Minimal visual presentation, information-dense UI"
---

# 1. Purpose

This document defines how **education, apprenticeship, mentoring, cross-training, manuals, drills, and institutional training** should work in the game.

It answers questions such as:
- How does one NPC learn alone in the wilderness?
- How does a second NPC learn from a more experienced NPC?
- When does a repeated task become a teachable trade?
- What separates casual help from real apprenticeship?
- How do training quality, fatigue, safety, and supervision change learning speed and error rates?
- When do manuals, records, schools, drills, and formal institutions start to matter?

This spec is meant to connect and operationalize several existing design layers:
- NPC interests, aptitudes, skills, morale, fatigue, and task choice
- knowledge/discovery and transmission
- craft/workshop specialization
- governance/administration
- settlement progression
- player orders/policies
- health/safety and environmental hazards

---

# 2. Role in the current design stack

The existing design already establishes several core truths that this spec must preserve:

- skill growth comes from **practice**, **supervision/apprenticeship**, **experimentation**, **written materials later**, and **institutional training later**
- interest affects willingness and training speed
- aptitude affects likely ceiling, quality, and error rates
- knowledge is more than recipes: it includes discovery, procedure, tools, measurement, and institutional practice
- buildings should provide not only production but also supervision, quality control, and training value
- workshops become real institutions only once repeated work, surplus, and social organization support them
- governance, records, and legitimacy matter once groups scale beyond a single survivor

This training spec therefore treats education as a **settlement function**, not a detached menu.

---

# 3. Realism principles

## 3.1 Training is embedded in work

For most of the game, learning should occur **inside real work**:
- watching someone do it
- helping with low-risk substeps
- repeating controlled portions of the task
- receiving correction
- gradually handling more of the full workflow

A potter is not created by clicking “study pottery.”
A potter emerges through clay sourcing, preparation, shaping, drying, firing, breakage, repair, observation, and repeated correction.

## 3.2 Tacit knowledge matters

Some knowledge can be written down. Some cannot be fully transferred without doing.
Examples:
- how wet clay should feel
- how a drying hide should flex
- how much smoke is too much around food
- how close to embers a pot can sit
- when a tired worker’s knife control is becoming unsafe

The game should treat this kind of know-how as **experience-sensitive**, not fully reducible to unlocked text.

## 3.3 Training is constrained by time, fatigue, and surplus

Teaching takes labor away from production.
A master craftsperson who is starving, injured, overworked, or facing reserve collapse should not be an efficient trainer.

Training quality should depend on:
- available supervision time
- safety of the environment
- adequacy of tools/materials
- rest/fatigue state
- task interruption level
- learner readiness
- whether the settlement can afford slower short-term output for future competence

## 3.4 Safety gates are real

Not every task can be delegated at full depth immediately.
The game should recognize that unsafe or quality-critical tasks often require staged permission.
Examples:
- fire tending
- butchering with sharp tools
- kiln firing later
- animal handling
- heavy load carrying
- cutting timber
- boiling/treating water
- preserving strategic seed stock

## 3.5 Training is social and political

Who gets taught matters.
In small groups, teaching decisions interact with:
- trust
- kinship/friendship
- fairness
- leadership legitimacy
- trade secrecy
- reserve pressure
- whether a settlement wants redundancy or role protection

## 3.6 Institutions emerge later, but roots begin early

A lone survivor has no school.
A hamlet can still have:
- recognized teachers
- a protected practice area
- simple routines for onboarding novices
- oral rules
- demonstration-based teaching
- work records and checklists later

Formal institutions such as schools, guild-like training systems, examination, standardized manuals, and technical institutes should grow out of these roots.

---

# 4. Core terminology

## 4.1 Exposure
A learner sees or hears a task performed but is not yet responsible for meaningful execution.

## 4.2 Observation
A learner intentionally watches a skilled person perform a task and may receive explanation.

## 4.3 Assisted practice
A learner performs one or more substeps under supervision.
Examples:
- carrying clean water to the boil point
- scraping the easy sections of a hide
- twisting prepared fibers into cordage after setup

## 4.4 Guided practice
A learner performs a larger or full task while a supervisor monitors, corrects, and intervenes if needed.

## 4.5 Apprenticeship
A structured, repeated, work-embedded training relationship where a more experienced NPC supervises a learner across many repetitions, subskills, and quality standards.

## 4.6 Pre-apprenticeship
Preparatory learning before true apprenticeship.
Examples:
- basic hand skills
- safe posture/tool handling
- material sorting
- cleaning/setup duties
- vocabulary and process order

## 4.7 Cross-training
Deliberately training NPCs outside their primary role so the settlement is not dependent on one person.

## 4.8 Drill
Repetition of a task or response pattern meant to improve speed, reliability, and coordination.
Examples:
- fire response
- storm securement
- “boil and cover water” protocol
- night alarm response

## 4.9 Manual / lesson note / checklist
Codified aid used to preserve procedures, standards, steps, or warnings.
These matter more as literacy, recordkeeping, and institutional complexity grow.

## 4.10 Competence threshold
The minimum practical ability to perform a task with acceptable safety and quality under normal conditions.

## 4.11 Authorization threshold
The policy/governance permission to perform, supervise, or sign off on a task.
Competence and authorization are related but not identical.

---

# 5. Training layers by settlement stage

# 5.1 Lone survivor stage

There is no formal teacher unless the starter NPC begins with some background familiarity.
Learning routes are:
- intuition
- trial and error
- observation of natural effects
- memory of prior life experience
- repeated practice
- accidental discovery

### Training characteristics
- no protected training time
- very high cost of mistakes
- weak feedback quality
- learning limited by fatigue, cold, hunger, dehydration, and fear
- high dependence on simple repetition

### Best-supported learning types
- foraging recognition
- carrying efficiency
- simple shelter improvement
- stone selection/use
- fire tending
- route memory
- water source evaluation

### Poorly supported learning types
- precision craft
- long multi-step production chains
- reliable standardization
- quality assurance
- high-risk specialization

# 5.2 Primitive camp stage

Once survival stabilizes slightly, training becomes more intentional.
A lone NPC can begin pseudo-training by:
- repeating tasks in the same order
- sorting materials by quality
- reserving a safer work area
- using reminders/checklists later if literacy exists
- practicing on low-value materials before strategic stock

This is the first stage where **self-training routines** emerge.

# 5.3 Permanent camp stage

With 2–4 NPCs, true social learning begins.
The key changes are:
- one person can demonstrate while another assists
- low-risk duties can be delegated
- a novice can be corrected before failure grows costly
- repeated camp routines become teachable norms

Typical training forms:
- informal mentoring
- shadowing
- paired work
- supervised repetition
- role rotation on low-risk tasks
- verbal warnings and corrective feedback

# 5.4 Tiny hamlet stage

This is the first stage where education becomes a recognized settlement function.
The hamlet can support:
- designated mentor roles
- beginner task tiers
- restricted access to strategic stock or dangerous tools
- simple training targets
- redundancy planning
- onboarding paths for new arrivals
- short oral “lessons” before seasonal spikes

At this stage, training begins to influence settlement survival materially.
If only one NPC knows water treatment, hide curing, seed selection, or advanced repair, the hamlet is fragile.

# 5.5 Agrarian village and beyond

From here, more formal systems become realistic:
- workshop apprenticeships
- structured labor ladders
- written rules/manuals
- ledgers and checklists
- designated training spaces
- recognized qualification thresholds
- teaching roles separated from production in part of the year
- school/archive/library equivalents later
- institutional cross-training for public functions
- standards and inspection

---

# 6. Types of learning in gameplay

## 6.1 Learning by doing

The default mode for early skills.
Best for:
- gathering
- handling raw materials
- hauling
- cleaning
- repetitive preparation
- simple assembly and maintenance

Strengths:
- realism
- fast for basic competence
- naturally tied to productivity

Weaknesses:
- error-prone without supervision
- can teach bad habits
- may be unsafe with sharp/hot/heavy work

## 6.2 Demonstration

A skilled NPC performs the task while a novice watches.
Useful for:
- process order
- body positioning
- tool grip
- hazard cues
- quality cues

Demonstration should grant:
- procedural familiarity
- reduced first-attempt penalty
- improved chance of recognizing common mistakes

## 6.3 Shadowing

The learner follows a worker through a full workflow without full responsibility.
Useful for:
- butchery sequence
- camp sanitation routine
- water safety routine
- seed handling
- storekeeping
- animal checks later

## 6.4 Assisted participation

The learner takes only selected substeps.
This is one of the most important modes for realism because it allows safe gradual entry.
Examples:
- gather temper for pottery, not final firing
- wash/clean vessels, not decide seed release
- carry split fuelwood, not fell trees
- scrape easy hide surfaces, not final softening/judgment

## 6.5 Guided repetition

The learner performs the task repeatedly while receiving feedback.
This is the main bridge from novice to reliable worker.

## 6.6 Deliberate practice blocks

Sometimes the settlement should choose to practice specifically for improvement rather than immediate output.
Examples:
- making cordage from low-value fibers to improve consistency
- practicing basket weave patterns using spare material
- drilling fire-start methods in dry conditions
- rehearsing emergency response

This mode should be more structured than ordinary work:
- clear subgoal
- repeated attempts
- feedback after each attempt or short set
- lower stakes material when possible
- slower but more skill-efficient than ordinary production

## 6.7 Oral teaching

Short explanations, warnings, mnemonics, and routines.
Examples:
- “seed stock must never touch damp ground”
- “raw carcass tools do not touch clean eating vessels”
- “keep latrine downhill and away from the water path”

Useful from the earliest social stage.

## 6.8 Written/codified teaching

Later unlock.
Examples:
- lesson notes
- recipe/procedure sheets
- hazard checklists
- maintenance checklists
- role manuals
- seasonal preparation lists
- quality criteria tables

Written teaching should not replace all tacit learning, but it should:
- reduce forgetting
- speed onboarding
- improve consistency
- enable standards across multiple workers/shops

---

# 7. Training quality model

Training is not binary. It should have quality dimensions.

## 7.1 Training quality inputs

### Teacher-side
- relevant skill level
- teaching aptitude
- patience/temperament
- current fatigue
- current morale
- available uninterrupted time
- legitimacy/trust with learner

### Learner-side
- interest in the domain
- aptitude fit
- current fatigue
- hydration/nourishment
- morale/confidence
- fear/stress level
- willingness to accept correction
- prior related skills

### Environment-side
- safety of site
- adequate light/visibility
- tool adequacy
- material adequacy
- enough spare stock for mistakes
- weather/distraction burden
- whether time pressure is extreme

### Organization-side
- training policy support
- role permission
- reserve status
- whether rework is acceptable right now
- record/checklist support

## 7.2 Training quality outputs

- skill gain rate
- procedural memory gain
- reduction in novice error rate
- quality consistency gain
- safety compliance gain
- morale effect
- trust/bond effect

## 7.3 Bad training outcomes

Poor supervision should be able to produce:
- bad habits
- unsafe shortcuts
- incomplete procedures
- contamination mistakes
- brittle overconfidence
- resentment toward the role or trainer
- hidden skill gaps that only appear under pressure

---

# 8. Teacher, mentor, and supervisor roles

## 8.1 Teacher is a skill, not just a title

A highly skilled worker is not automatically a good teacher.
Teaching performance should depend on:
- communication clarity
- patience
- error recognition
- willingness to slow down and explain
- ability to stage the task safely
- ability to choose appropriate practice tasks
- ability to give feedback without destroying morale

## 8.2 Mentor role

A mentor relationship should be broader than task correction.
It can also affect:
- belonging
- role identity
- confidence
- persistence after failure
- loyalty to the settlement
- willingness to remain in a difficult specialization

## 8.3 Supervisor role

A supervisor is responsible not only for learner growth but also for:
- safe delegation
- quality control
- throughput tradeoffs
- deciding when the learner can advance
- protecting strategic materials from being wasted carelessly

## 8.4 Teacher burden

Training should cost the mentor:
- time
- output
- cognitive effort
- social effort
- possible stress if reserves are low or accidents occur

A settlement under crisis should often train less effectively unless it deliberately accepts the short-term cost.

---

# 9. Learner stages

## 9.1 Unaware
Has no meaningful map of the task.

## 9.2 Exposed
Knows the task exists and has seen it.

## 9.3 Assisted novice
Can help with substeps under direction.

## 9.4 Guided novice
Can attempt most of the task with close supervision.

## 9.5 Basic competent worker
Can complete normal tasks under ordinary conditions with acceptable safety and quality.

## 9.6 Reliable practitioner
Can handle variation, maintain tools/materials, and catch common mistakes.

## 9.7 Advanced practitioner
Can adapt, diagnose, recover failures, and teach basic learners.

## 9.8 Master / institutional bearer
Can set standards, teach, inspect, improve process, and help codify knowledge.

These stages do not need to be visible as hard RPG levels, but they should exist in the simulation.

---

# 10. Skill families that should interact with training

The training system should not treat every skill as identical. Different skill families learn differently.

## 10.1 Perceptual recognition skills
Examples:
- edible plant recognition
- spoiled vs usable food recognition
- water source judgment
- weather cue reading
- noticing infection or smoke burden

These rely heavily on exposure, examples, correction, and memory.

## 10.2 Motor/tool skills
Examples:
- knife handling
- scraping hides
- carving stakes
- weaving fibers
- shaping clay

These rely heavily on repeated guided practice and fatigue state.

## 10.3 Sequenced procedural skills
Examples:
- butchering order
- water treatment order
- preservation workflow
- pottery workflow
- safe hearth routine

These benefit strongly from demonstration, checklists later, and rehearsal.

## 10.4 Judgment-heavy craft skills
Examples:
- drying readiness
- fire heat control
- hide softening judgment
- pot firing judgment
- seed selection

These often require tacit transfer and many repetitions.

## 10.5 Social/administrative skills
Examples:
- teaching
- mediation
- storekeeping
- ration explanation
- role assignment
- recordkeeping later

These depend on temperament, legitimacy, and communication.

## 10.6 Coordination skills
Examples:
- paired carrying
- team shelter building
- watch changeover
- emergency response
- harvest coordination later

These benefit from drills, leadership, and shared routine.

---

# 11. Early-game training domains

For the early slice, the most important training domains are:

## 11.1 Survival basics
- water collection
- water treatment and clean storage
- fuel gathering and drying
- shelter maintenance
- bedding/dryness upkeep
- fire tending
- hazard recognition

## 11.2 Food and preservation
- foraging recognition
- fishing/trapping/hunting assistance where applicable
- carcass cleanliness
- drying/smoking workflow
- contamination avoidance
- seed reservation discipline

## 11.3 Material preparation
- fiber collection and sorting
- cordage making
- basketry basics
- clay locating/cleaning/tempering
- hide fleshing/scraping/softening/smoking
- simple stone and wood tools

## 11.4 Camp institutions
- latrine placement and use discipline
- refuse handling
- store placement and stock rotation
- reserve awareness
- ration compliance
- watch routines
- newcomer onboarding

## 11.5 Role foundations for hamlets
- water stewarding
- storekeeping
- cook/preserver
- hide/fiber worker
- clay worker
- field/garden caretaker
- basic builder/maintainer

---

# 12. Apprenticeship design

## 12.1 When apprenticeship becomes available

A role should become apprenticeship-capable when all of the following are true:
- the task recurs often enough to justify instruction
- there is at least one practitioner above basic competence
- the settlement has enough material slack to tolerate trainee error
- the role matters enough to settlement resilience or output
- there is time/space to supervise without constant emergency interruption

## 12.2 Apprenticeship structure

Each apprenticeship should have:
- trade/role name
- mentor(s)
- candidate requirements
- allowed substeps by stage
- restricted substeps by stage
- safety prerequisites
- expected practice volume
- expected common errors
- graduation threshold(s)
- fallback/remedial track

## 12.3 Typical apprenticeship flow

1. Observe and assist setup/cleanup
2. Learn material identification and tool names
3. Perform low-risk repetitions
4. Perform partial workflow
5. Perform full workflow under supervision
6. Perform full workflow with spot checks
7. Handle variation and basic troubleshooting
8. Teach the first beginner substeps to someone else

## 12.4 Apprentice compensation logic

In realistic society terms, apprentices are often lower-output workers who are also helping with production.
In game terms, apprentices may:
- produce lower-quality output
- slow the mentor
- consume stock through mistakes
- still contribute useful labor on prep/cleanup/substeps

This tradeoff is important because it prevents “free skill growth.”

## 12.5 Graduation

Graduation should not be only XP-based.
It should consider:
- enough repetitions
- enough success under normal conditions
- low enough critical error rate
- ability to explain or demonstrate steps
- safe independent handling
- acceptance by mentor and/or local authority later

---

# 13. Cross-training and redundancy

A realism-first settlement should avoid single points of failure.

## 13.1 Why it matters
If only one NPC can:
- boil and safely store water
- identify dangerous spoilage
- tend the hearth safely
- manage seed stock
- maintain reserve records later
- de-escalate conflict
then sickness, injury, death, or departure creates systemic fragility.

## 13.2 Cross-training policy
The player/governance layer should be able to push:
- no cross-training
- minimum redundancy in critical roles
- broad resilience training
- seasonal role refreshers

## 13.3 Critical early cross-trained roles
At minimum, a hamlet should want 2+ NPCs who can reliably do:
- water treatment/storage
- fire/hearth care
- basic first aid and illness isolation behaviors
- reserve protection/storekeeping basics
- alarm/watch response
- shelter/weather securement

---

# 14. Manuals, memory aids, and codification

## 14.1 Oral memory aids
Before writing matters, the settlement can still use:
- repeated sayings
- ritualized order of steps
- role handoff routines
- visible tool placement norms
- labeled zones later

## 14.2 Checklists and procedure notes
Once writing or symbolic recording exists, the game should support:
- “safe water checklist”
- “storm securement list”
- “seed store rules”
- “newcomer sanitation briefing”
- “kiln firing notes” later
- “maintenance schedule” later

## 14.3 What codification changes
Codified knowledge should:
- reduce dependence on one teacher’s memory
- improve consistency across workers
- make auditing and correction easier
- support institutional scaling

It should **not** fully replace practice.
A written note that says “do not over-dry the hide” is less valuable than repeated supervised handling of hides at different stages.

---

# 15. Training spaces and structures

Training quality should be affected by place.

## 15.1 Informal training spaces
Early examples:
- sheltered work mat
- hearth edge
- hide rack area
- fiber sorting area
- clay prep patch
- practice corner with low-value stock

## 15.2 Workshop-linked training spaces
As village specialization grows, workshops should gain training value when they provide:
- protected work surface
- tool storage
- material storage
- line of sight for supervision
- safe novice zone
- display of examples/patterns later
- quality-check point

## 15.3 Institutional training spaces later
- lesson area
- guild/workshop classroom equivalent
- practice benches
- archive/manual store
- demonstration rigs
- drill yard
- public health training space later

---

# 16. Governance integration

Education should interact with governance.

## 16.1 Governance questions
- Who is allowed to teach?
- Who may touch strategic stock during training?
- Who authorizes dangerous practice?
- Is the settlement prioritizing speed, redundancy, excellence, or fairness?
- Are outsider apprentices allowed?
- Are some techniques restricted?

## 16.2 Rule examples
- only competent workers may supervise knife training
- seed handling trainees require direct oversight
- no novice may fire pots using strategic clay stock
- all new arrivals receive a sanitation and water-safety briefing
- every critical role must maintain one backup learner

## 16.3 Legitimacy effects
If training access is unfair or nepotistic, likely outcomes include:
- resentment
- lower morale
- slower cooperation
- role bottlenecks
- hoarded expertise
- lower trust in leadership

If training policy is fair and intelligible, likely outcomes include:
- better retention
- better redundancy
- stronger legitimacy
- more willingness to accept hard ration/work decisions

---

# 17. Health and safety integration

## 17.1 Fatigue effects
Fatigue should reduce:
- learning retention
- working memory in sequenced tasks
- attention to warnings
- safe knife/fire handling
- patience in teaching
- capacity to receive correction calmly

## 17.2 Illness and injury effects
Ill or injured NPCs may:
- need reduced or suspended training
- benefit from observation/oral lessons when not fit for hard labor
- regress in physical skill reliability if idle too long
- shift to teaching or recordkeeping later instead of heavy work

## 17.3 Safe training windows
Some training should be discouraged during:
- severe dehydration
- active storm emergency
- near-night exhaustion
- reserve crisis
- contaminated worksite conditions
- smoke-heavy indoor spaces

---

# 18. Player control and policy hooks

The player should be able to influence training without micromanaging every repetition.

## 18.1 Suggested player policies
- allow/disallow apprenticeships by trade
- minimum backups required for critical roles
- permit training on strategic stock or not
- preferred training intensity: low / balanced / aggressive
- role rotation frequency
- newcomer mandatory briefings
- emergency suspend training
- mentor assignment preferences

## 18.2 Direct player actions
- assign mentor to learner
- pin a trade as “needs backup”
- mark a practice batch as expendable
- protect high-value stock from trainee use
- promote/demote authorization level

## 18.3 Player feedback views
UI should make visible:
- who knows what
- who can teach what
- critical single-point-of-failure roles
- who is training and at what stage
- expected mentor burden
- likely graduation time band
- unsafe training conflicts

---

# 19. Integration with task evaluation

Training should feed into task choice and scoring.

## 19.1 Learners should prefer training when
- the role is personally interesting
- the settlement lacks redundancy
- a mentor is available
- reserves are stable enough
- the learner’s current body state is adequate
- the player/governance gives training weight

## 19.2 Mentors should accept training when
- production pressure is not extreme
- learner fit is decent
- the role is critical
- legitimacy/fairness supports the pairing
- the task can be staged safely

## 19.3 Task score modifiers from training
Training-related modifiers can affect:
- role fit
- learning value
- redundancy value
- mentor availability
- stock risk penalty
- danger penalty
- fatigue penalty
- governance compliance bonus/penalty

---

# 20. Institutional training later

Although this project is currently focused on the early slice, the training system should scale forward naturally.

## 20.1 Agrarian village stage
- recognized apprentices in workshops
- seasonal teaching cycles
- more formal role ladders
- written marks/records begin mattering more

## 20.2 Market town stage
- manuals and standards matter
- bookkeeping and measurement training emerge
- trader/storekeeper clerk training appears
- larger workshops need consistent onboarding

## 20.3 Industrial stages
- formal in-house training
- machine-specific authorization
- maintenance manuals
- inspection standards
- schools/technical institutes
- public utility training
- safety certification and drills

## 20.4 Modern city stage
- institutional education system
- pre-service and in-service training
- specialist schools
- standardized curricula
- retraining/upskilling
- safety and quality systems tied to regulation

---

# 21. Failure modes

Education/training should be able to fail or degrade in believable ways.

## 21.1 Undertraining
- workers attempt tasks above competence
- higher accident rates
- fragile reserves
- hidden contamination or quality failures

## 21.2 Over-specialization
- only one or two experts hold critical know-how
- settlement becomes brittle when they are absent

## 21.3 Poor teacher fit
- impatient or abusive mentor
- frequent learner discouragement
- social conflict
- bad habit formation

## 21.4 No codification later
- repeated rediscovery
- loss of standards
- poor maintenance continuity
- inability to scale reliably

## 21.5 Overformalization too early
- too much recordkeeping before surplus exists
- training paperwork burden crowds out actual practice
- unrealistic school-like systems appearing before the settlement can support them

---

# 22. Data schema proposal

## 22.1 `TrainingDomain`
- id
- name
- description
- related_skills[]
- related_knowledge_ids[]
- hazard_tags[]
- prerequisite_domains[]
- novice_allowed_subtasks[]
- restricted_subtasks[]
- preferred_training_modes[]
- training_space_tags[]

## 22.2 `TrainingRelationship`
- teacher_npc_id
- learner_npc_id
- domain_id
- relationship_type (mentor/apprentice, coach, cross-trainer, observer)
- start_time
- trust_level
- current_stage
- authorization_cap
- notes/flags

## 22.3 `TrainingSession`
- domain_id
- teacher_id
- learner_ids[]
- mode
- task_instance_ids[]
- start_time
- duration
- location_id
- material_quality_used
- strategic_stock_used(bool)
- interruptions
- safety_incidents
- feedback_count
- quality_outcomes
- skill_delta_summary
- morale_delta_summary

## 22.4 `CompetenceProfile`
- npc_id
- domain_id
- exposure_level
- practical_stage
- independent_operation_allowed
- supervision_required_level
- can_teach_beginner(bool)
- can_sign_off(bool)
- recent_error_burden
- confidence_estimate

## 22.5 `TrainingPolicy`
- settlement_id
- critical_roles_minimum_backups
- training_intensity
- allow_strategic_stock_training
- mandatory_newcomer_briefings[]
- authorized_trainers[] / rule set
- dangerous_task_training_rules[]
- cross_training_targets[]
- emergency_suspend_training(bool)

---

# 23. First-playable minimum slice

For the first playable vertical slice, the training system does not need full later complexity.
It does need:

## 23.1 Minimum learning modes
- self-learning through repetition
- observation
- assisted practice
- guided practice
- simple apprenticeship relationship

## 23.2 Minimum domains
- safe water handling
- fire tending
- shelter maintenance
- fuel prep/storage
- basic first aid behaviors
- food drying/smoking basics
- cordage/basketry basics
- hide processing basics
- storekeeping/reserve protection basics

## 23.3 Minimum policy hooks
- train backups for critical roles
- forbid trainee use of strategic stock
- assign mentor
- pause training during crisis

## 23.4 Minimum visible feedback
- who is learning what
- who can teach what
- who is the only person able to do a critical task
- whether fatigue or danger is making training ineffective

---

# 24. Design stance summary

The game should treat education as:
- embodied
- social
- labor-costly
- safety-limited
- gradually formalized
- deeply tied to settlement resilience

A believable colony does not become durable because the player unlocked “pottery.”
It becomes durable because:
- someone learned it,
- someone else could repeat it,
- the settlement could spare time and stock to teach it,
- the process became reliable enough to survive the loss of one person,
- and later the knowledge could be preserved, inspected, and passed on.

That is the core of this spec.

---

# References

- [R1] UNESCO, *Traditional craftsmanship*  
  https://ich.unesco.org/en/traditional-craftsmanship-00057

- [R2] UNESCO, *Safeguarding strategy of traditional crafts for peace building*  
  https://ich.unesco.org/en/BSP/safeguarding-strategy-of-traditional-crafts-for-peace-building-01480

- [R3] ILO, *Overview of apprenticeship systems and issues*  
  https://www.ilo.org/media/31156/download

- [R4] ILO, *Chapter 2 - Volume I: Guide for Policy Makers*  
  https://www.ilo.org/resource/chapter-2-volume-i-guide-policy-makers

- [R5] ILO, *A framework for quality apprenticeships*  
  https://www.ilo.org/sites/default/files/wcmsp5/groups/public/%40ed_norm/%40relconf/documents/meetingdocument/wcms_731155.pdf

- [R6] ILO, *Toolkit for Quality Apprenticeships*  
  https://www.ilo.org/sites/default/files/wcmsp5/groups/public/%40ed_emp/%40ifp_skills/documents/publication/wcms_748751.pdf

- [R7] WHO, *Health workforce education and training*  
  https://www.who.int/teams/health-workforce/health-workforce-education-and-training

- [R8] WHO, *Teaching for better learning*  
  https://iris.who.int/bitstream/handle/10665/39062/9241544422_eng.pdf

- [R9] WHO, *Supportive supervision*  
  https://iris.who.int/bitstreams/2da1db37-4ccb-4a2a-a144-44a2dcd83cac/download

- [R10] CDC / NIOSH, *Sleep deprivation impairs your information processing and learning*  
  https://www.cdc.gov/niosh/work-hour-training-for-nurses/longhours/mod3/05.html

- [R11] CDC / NIOSH, *Fatigue monitoring and detection implementation*  
  https://www.cdc.gov/niosh/bulletin/2021/fmdt_implementation.html

- [R12] PubMed, Ericsson, *Deliberate practice and acquisition of expert performance*  
  https://pubmed.ncbi.nlm.nih.gov/18778378/

- [R13] PMC / NIH, *Phases of procedural learning and memory*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC8048153/

- [R14] PMC / NIH, *Tips for teaching procedural skills*  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC7712522/
