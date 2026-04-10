
---
title: "Realistic Idle City — Social / Recruitment Spec"
version: "v0.1"
date: "2026-04-08"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet (3–8 NPCs)"
purpose: "Define the social layer, newcomer arrival routes, trust, belonging, fairness, conflict, mentoring, and early-settlement recruitment logic."
status: "Companion document to the design, NPC, task, item, process, structure, settlement, and knowledge specs."
---

# 1. Purpose of this document

This document defines the **social layer** for the early game.

The project already has:
- NPC body/mind state
- task selection
- items/materials
- processes
- buildings/structures
- settlement stage thresholds
- knowledge/discovery rules

What was still missing is the answer to questions like:

- Why would a second person join a camp?
- Why would they stay instead of leaving?
- What makes strangers trusted, tolerated, feared, or welcomed?
- What turns a group of workers into a functioning social unit?
- Why does unfairness or exclusion destabilize a small settlement?
- How do mentorship, shared work, and care accelerate integration?
- What makes a primitive camp socially viable enough to become a tiny hamlet?

This spec is intentionally focused on the **social logic of the early game**, not on late-city institutions such as courts, police, schools, guilds, or formal citizenship.

---

# 2. Alignment with the existing design stack

This document inherits the following already-established project rules:

- the game begins with **one adult starter NPC**
- the early playable slice is **lone survivor -> primitive camp -> permanent camp -> tiny hamlet**
- new NPCs should not appear only because time passed; they should join only when the settlement can realistically support them
- additional NPCs may arrive through **migration/attraction**, **rescues/wanderers/refugees**, and later **family growth**
- settlement growth is limited by food, potable water, shelter, sanitation, disease burden, security, social stability, and spare labor
- NPCs care about safety, relationships, competence fit, workload fairness, housing quality, status/pride, food quality, warmth, hygiene, rest, and confidence in leadership
- knowledge is social as well as individual, so teaching, apprenticeship, repetition, and shared routines matter

This spec should be read as the **social complement** to the settlement progression and knowledge/discovery documents.

---

# 3. Real-world grounding and design interpretation

## 3.1 Social connection is a survival variable, not decoration

Modern public-health literature consistently shows that social connection and supportive relationships matter for health, stress regulation, sleep quality, resilience, and community well-being. In game terms, this supports treating social integration as a real survival variable rather than flavor text.

For this project, that means:
- a socially connected NPC handles stress better
- a trusted group coordinates better
- a lonely or excluded NPC is more brittle, more likely to leave, and less willing to teach or cooperate
- a settlement with strong social bonds is more resilient during shortage, illness, fear, and uncertainty

## 3.2 Social cohesion is not “everyone likes each other”

Healthy People 2030 defines **social cohesion** as the strength of relationships and the sense of solidarity among members of a community. In game terms, cohesion is not just positive mood; it is whether people believe:
- others will help when needed
- rules are applied fairly enough
- the group shares burdens
- there is some reason to invest in the settlement’s future

## 3.3 Recruitment is not a magical unlock

Migration research treats movement as shaped by multiple drivers, including safety, livelihood, environment, and social networks. For the game, this means new NPC arrivals should be driven by a mix of:
- push factors elsewhere
- pull factors at the player’s settlement
- information carried by rumor, observation, known paths, or prior contacts
- the newcomer’s own needs, skills, fears, and social expectations

## 3.4 Work organization affects social stability

Occupational-health research supports the idea that excessive workload, chronic stress, fatigue, lack of voice, and poor work design undermine well-being and performance. For the game, that means:
- unfair work assignment is socially destabilizing
- overworked settlements become harsher and more brittle
- giving NPCs some voice, fit, and autonomy improves belonging and retention
- care, rest, and predictable routines are social infrastructure

## 3.5 Mentorship is a real integration pathway

Mentoring literature supports treating mentorship as more than skill transfer. It can include work guidance, contextual orientation, and emotional support. In game terms, mentorship should help a newcomer:
- understand camp routines
- learn accepted norms
- acquire practical skills faster
- become known and trusted
- feel less socially isolated

---

# 4. Design goals for the social layer

The social layer should make the settlement feel like a real human group rather than a pile of labor units.

The main goals are:

1. **Explain why people arrive**
2. **Explain why they stay or leave**
3. **Make trust earned rather than granted**
4. **Make fairness and care materially relevant**
5. **Make role fit and mentorship socially meaningful**
6. **Make scarcity and fatigue socially dangerous**
7. **Make the first few NPCs feel especially important**
8. **Keep the model usable for an idle/incremental game**

---

# 5. Scope boundaries

This v0.1 spec focuses on:
- lone NPC social baseline
- first newcomer arrivals
- trust and belonging
- settlement attractiveness
- social stress and conflict pressure
- mentorship/apprenticeship in the early slice
- group cohesion rules for 2–8 NPCs

This v0.1 spec does **not** yet fully define:
- romance/marriage
- childbirth/family simulation
- formal law and crime systems
- faction politics
- advanced ideology/religion
- prisons, courts, or policing
- diplomacy between settlements
- late-game class structures

Those can be added later if the project needs them.

---

# 6. Core social model

The social layer should exist at **three levels at once**:

## 6.1 Individual level
What a specific NPC feels and believes.

Examples:
- trust in specific people
- fear of strangers
- belonging
- loneliness
- perceived fairness
- confidence in leadership
- willingness to help
- resentment
- grief
- gratitude
- shame/pride
- social energy

## 6.2 Relationship level
What exists between two specific NPCs.

Examples:
- familiarity
- trust
- debt/obligation
- kinship
- mentorship
- friendship
- rivalry
- grievance
- dependency
- authority acceptance

## 6.3 Settlement level
What the group feels like as a social system.

Examples:
- cohesion
- integration capacity
- conflict pressure
- social trust climate
- role clarity
- fairness climate
- care capacity
- leadership legitimacy
- hospitality norm
- newcomer absorptive capacity

These three levels must influence each other.

Example:
- A settlement with low cohesion makes it harder for a stranger to feel belonging.
- A stranger who is well mentored can improve specific relationship ties.
- Enough healthy relationship ties raise settlement cohesion.

---

# 7. Individual social-state variables

Each NPC should have a **social state block** in addition to body state and task state.

## 7.1 Core variables

### Social connectedness
How much meaningful contact and support the NPC currently experiences.

High connectedness supports:
- morale
- resilience
- staying power
- willingness to cooperate

Low connectedness increases:
- loneliness
- departure risk
- conflict sensitivity
- mentorship need

### Belonging
Whether the NPC feels like “one of us” in the current settlement.

Belonging is influenced by:
- time in settlement
- shared meals/work
- acceptance by key members
- voice in decisions
- fair treatment
- role usefulness
- shelter access
- repeated inclusion in routines

### Trust disposition
A personality-flavored baseline tendency to trust or distrust before strong evidence accumulates.

This is **not** settlement trust itself.
It is how easily the NPC moves from uncertainty to provisional trust.

### Settlement trust
How much the NPC trusts the settlement as a place and system.

This differs from trusting any one person.
It includes:
- “Will I be fed fairly?”
- “Will others help if I get sick?”
- “Will rules be enforced consistently enough?”
- “Will I be exposed to needless danger?”

### Confidence in leadership
Whether the NPC believes the settlement’s direction and priorities are competent enough.

In early game, “leadership” may mean:
- the starter NPC as camp founder
- the player’s orders as perceived through action outcomes
- the visible logic of priorities and resource allocation

### Perceived fairness
How fair the NPC thinks burdens, rewards, risk, and access are.

Important inputs:
- food allocation
- shelter allocation
- who gets dangerous jobs
- whether care is given to the weak/injured
- whether favoritism is visible
- whether workloads are obviously unbalanced
- whether skilled/unsuited assignments are handled sensibly

### Social energy
How much interaction an NPC can tolerate before needing solitude or quiet.

This allows more realistic variation between:
- highly social people who gain energy from group life
- more solitary people who still cooperate well but need lower interaction load

### Reciprocity orientation
How strongly the NPC responds to being helped or wronged.

High reciprocity orientation means:
- gratitude and help received are remembered strongly
- exploitation or abandonment also bites harder

### Status sensitivity
How strongly the NPC cares about respect, esteem, visible usefulness, and social rank signals.

### Care orientation
How strongly the NPC prioritizes caregiving, protection of dependents, and support tasks.

### Conflict aversion
How strongly the NPC avoids confrontation versus addressing grievances directly.

## 7.2 Derived variables

Derived values are easier to tune than trying to hand-script everything.

Examples:
- **Leave pressure**
- **Cooperation willingness**
- **Mentorability**
- **Mentoring willingness**
- **Outburst risk**
- **Hospitality willingness**
- **Authority resistance**
- **Rally response** during crisis
- **Social fragility** under fatigue + hunger + perceived injustice

---

# 8. Relationship model

The early game does not need an impossibly detailed life sim, but each pair of NPCs should still be socially distinct.

## 8.1 Relationship record fields

For each pair of NPCs, track some or all of:

- familiarity
- trust
- shared work history
- shared meals/rest events
- rescue/debt memory
- mentorship status
- conflict history
- grievance score
- respect/competence estimation
- comfort level
- kinship/family flag (later)
- attraction/romance flags (later if desired)

## 8.2 How familiarity grows

Familiarity should grow through:
- proximity over time
- repeated shared tasks
- shared shelter area
- eating together
- direct help
- repeated conversations
- visible consistent behavior

It should shrink or become stale through:
- long separation
- avoidance
- repeated negative contact
- betrayal or violence

## 8.3 How trust grows

Trust should rise mainly through:
- promises kept
- consistent behavior
- competent contribution
- fair dealing
- helping during stress
- not exploiting others when resources are tight
- successful mentorship
- standing by others during illness/injury

Trust should fall through:
- theft or suspected theft
- repeated unfairness
- abandonment
- lying / broken promises
- reckless endangerment
- hoarding during shortage
- visible favoritism
- repeated incompetence in high-risk situations

## 8.4 Trust is contextual

A person may trust another:
- with hauling
- but not with food allocation
- with child care later
- but not with conflict mediation
- with hunting
- but not with teaching

So later versions may split trust by domain:
- care trust
- competence trust
- fairness trust
- safety trust

For v0.1, one main trust value plus tags is enough.

## 8.5 Debt and obligation

Small groups remember who helped whom.

Useful relationship memories:
- “saved me from exposure”
- “shared food during shortage”
- “trained me patiently”
- “covered my task when I was ill”
- “took my shelter spot unfairly”
- “refused help when I needed it”

These memories should affect:
- future willingness to help
- deference
- loyalty
- resentment
- departure risk

---

# 9. Settlement-level social variables

The settlement itself needs social metrics.

## 9.1 Cohesion
How strongly the settlement functions as a social whole.

Raised by:
- shared routines
- fair burdens
- visible competence
- mutual aid
- stable shelter access
- successful crisis response
- group meals/work gatherings
- mentorship and onboarding success

Lowered by:
- chronic scarcity
- visible unfairness
- repeated avoidable deaths or injuries
- unsafe water/filth that signals neglect
- idleness for some while others are overloaded
- persistent outsider cliques
- unresolved grievances

## 9.2 Hospitality norm
How willing the settlement is to receive and assist strangers.

Raised by:
- surplus
- strong cohesion
- cultural/trait tendencies toward care or openness
- positive past newcomer outcomes

Lowered by:
- recent betrayal
- hunger
- disease fear
- lack of shelter
- conflict pressure
- overload on caregivers

## 9.3 Legitimacy / leadership acceptance
How strongly the settlement accepts current priorities and authority patterns.

This is raised when:
- player priorities visibly keep people alive
- dangerous work is justified and not arbitrary
- food/water/shelter allocation feels sensible
- care is not withheld unfairly
- specialists are used reasonably
- promises are effectively “kept” through consistent game rules

## 9.4 Fairness climate
The settlement’s general sense of whether burdens and benefits are distributed acceptably.

This is distinct from perfect equality.
A settlement can tolerate unequal roles if the inequality feels:
- necessary
- understandable
- reciprocated
- bounded
- respectful

## 9.5 Integration capacity
How many newcomers the settlement can realistically absorb right now.

It depends on:
- spare calories
- potable water margin
- bedding/shelter margin
- sanitation margin
- social mentor availability
- role slack
- emotional bandwidth of the group
- conflict pressure

A camp may physically fit one more person, but have **zero social integration capacity** if everyone is exhausted and suspicious.

## 9.6 Conflict pressure
A pooled indicator of social strain.

Raised by:
- hunger
- thirst
- fatigue
- cold/wet exposure
- overcrowding
- grief/fear
- unfairness
- gossip/suspicion
- poorly matched roles
- repeated failures
- no private recovery space
- uncertain leadership

Lowered by:
- full bellies
- rest
- predictable routine
- visible fairness
- gratitude events
- successful crisis resolution
- shared meals
- honest explanation/voice systems
- socially useful work fit

## 9.7 Care burden
How much social/emotional/physical support work the group is currently carrying.

Care burden rises with:
- injury
- illness
- many children later
- too many untrained newcomers
- grief events
- elderly/infirm dependents later

This matters because care work consumes labor and can quietly destabilize early settlements if left invisible.

---

# 10. Recruitment channels

The game already leans toward a **mixed/random-feeling model**. This spec formalizes that.

## 10.1 Channel A — Wanderer arrival
A lone traveler or small pair encounters the camp.

Why they appear:
- scouting
- displacement
- getting lost
- seasonal movement
- searching for water or food
- following smoke, sound, cleared land, or tracks

Good early use:
- first or second newcomer
- uncertain but flexible personality types
- high narrative tension

## 10.2 Channel B — Rescue / recovery arrival
The settlement finds someone injured, starving, exposed, trapped, or otherwise vulnerable.

Why this is good design:
- it makes compassion materially relevant
- it creates immediate social debt/obligation possibilities
- it makes care work visible
- it produces strong story memories

Risks:
- disease
- care burden
- low immediate labor contribution
- trust uncertainty

## 10.3 Channel C — Attraction migration
A person hears of or sees a relatively safe and productive camp and chooses to approach.

Pull factors may include:
- visible smoke/fire
- maintained shelter
- cultivated ground
- stored food
- signs of stable water access
- rumor of fair treatment
- kin/friend already present later
- route convenience
- lower violence risk

This channel should become stronger once the camp becomes more permanent.

## 10.4 Channel D — Skilled opportunist
A person with a useful specialty arrives because they believe the settlement can support their role.

This should be rare in the early slice but possible toward tiny hamlet stage:
- potter
- hideworker
- healer
- trader
- builder
- herder

This arrival should require stronger pull conditions.

## 10.5 Channel E — Dependent arrival
A newcomer comes with a dependent or becomes a dependent.

Examples:
- injured adult
- older adult later
- child later
- grieving partner later

This channel is socially interesting because it tests whether the settlement values pure labor only, or society-building.

---

# 11. Recruitment drivers and filters

A newcomer does not join only because they physically appeared on the map.

## 11.1 Push factors
Why they left or cannot stay elsewhere.

Examples:
- hunger
- unsafe water
- predation or violence
- environmental shock
- social expulsion
- loss of household
- failed harvest
- disease pressure
- lack of shelter

## 11.2 Pull factors
Why this settlement is attractive.

Examples:
- visible fire and order
- reliable water
- food surplus or at least food stability
- safe sleeping place
- signs of cooperation rather than chaos
- clear hygiene and waste separation
- visible competence
- chance to contribute usefully
- chance to belong

## 11.3 Social-network factors
Movement is strongly influenced by known people and known routes.

Examples:
- “someone from my old area may be here”
- “I heard this camp shares work and food fairly”
- “this camp rescued others”
- “the path is known and survivable”
- “I saw cultivated ground and smoke repeatedly”

## 11.4 Entry filters used by the settlement
The settlement should evaluate:
- immediate threat level
- disease/injury concern
- current surplus margin
- current fear/conflict level
- skill usefulness
- care burden
- shelter margin
- water margin
- whether a sponsor/mentor exists

A starving, frightened camp should not behave like a comfortable village.

---

# 12. Newcomer lifecycle

A clean social lifecycle makes recruitment readable and realistic.

## 12.1 Stage 0 — Unknown outsider
The stranger is seen or discovered.

Settlement questions:
- Are they dangerous?
- Are they contagious?
- Are they desperate?
- Are they alone?
- Are they armed?
- Are they coherent enough to communicate?
- Do we have spare food/water to help them at all?

## 12.2 Stage 1 — Contact
Initial controlled interaction.

Possible outputs:
- avoid
- observe from distance
- warn away
- offer limited aid at distance
- escort to edge of camp
- admit to temporary safe zone

## 12.3 Stage 2 — Temporary guest
They are not a full member yet.

Typical rights:
- emergency water
- one simple meal
- temporary bedding/shelter edge
- supervised warmth/fire access

Typical restrictions:
- no access to strategic storage unsupervised
- no sensitive tasks
- no control roles
- limited roaming until some trust exists

## 12.4 Stage 3 — Probationary participant
They begin contributing small, low-risk, socially visible tasks.

Good tasks:
- water hauling
- firewood gathering
- cleaning
- simple hauling
- helping on garden plots
- drying assistance
- maintenance/repair assistance
- supervised processing tasks

This stage is crucial because it lets the group test:
- reliability
- work ethic
- cooperation style
- learning ability
- hygiene habits
- reciprocity

## 12.5 Stage 4 — Accepted member
They are considered part of the settlement.

Markers:
- regular food share
- defined sleeping place
- named role or role tendency
- normal participation in work rotation
- access to more spaces/tasks
- at least one moderate-trust tie
- belonging above threshold

## 12.6 Stage 5 — Integrated contributor
They are no longer “the newcomer.”
They:
- mentor later arrivals
- carry trusted work
- participate in norm transmission
- may hold key responsibilities

---

# 13. Why people stay

Joining is not enough. The game needs a model for retention.

## 13.1 Core stay factors
An NPC is more likely to stay when they have:

- safer access to food/water than outside
- acceptable shelter and warmth
- meaningful role fit
- at least one trusted tie
- increasing belonging
- workable fairness
- some voice/autonomy
- future prospects
- not too much humiliation or exclusion

## 13.2 Role fit matters
A settlement feels more worth staying in when the NPC can contribute in a way that fits:
- interests
- aptitudes
- existing skills
- body condition
- social identity/pride

A person repeatedly forced into badly mismatched work may remain temporarily but should accumulate:
- frustration
- poor learning
- lower belonging
- higher departure pressure

## 13.3 Care and dignity matter
A settlement that keeps people alive but treats them as expendable labor should not retain people as well as one that:
- shelters the sick
- shares emergency food
- allows recovery
- remembers contributions
- uses people competently rather than wastefully

## 13.4 Predictability matters
People tolerate hardship better when routines are legible.

Retention improves with:
- known meal times/patterns
- known work expectations
- visible storage and reserve logic
- clear sleeping arrangements
- understandable rules

---

# 14. Why people leave

An NPC may leave, attempt to leave, or mentally detach before physically departing.

## 14.1 Material reasons
- persistent hunger
- unsafe water
- repeated cold/wet sleeping
- overcrowding
- no path to role usefulness
- total surplus collapse

## 14.2 Social reasons
- persistent exclusion
- repeated humiliation
- favoritism
- broken trust
- theft without response
- no close ties
- leadership seen as arbitrary or incompetent
- burden without recognition
- conflict with no repair

## 14.3 Psychological reasons
- grief
- fear after violence/death
- identity mismatch
- inability to adapt to group life
- chronic loneliness
- shame from repeated failure

## 14.4 Trigger thresholds
A well-designed model should not eject people randomly.
Leaving should usually happen after:
- sustained pressure
- a triggering incident
- a plausible alternative destination or desperate gamble

---

# 15. Trust, fairness, and legitimacy

These are the three most important abstract social variables in the early game.

## 15.1 Trust
“Will others behave in ways that do not exploit or endanger me?”

Built by:
- repeated successful cooperation
- promises/actions matching
- competence under stress
- protection and care
- good mentorship
- reciprocity

## 15.2 Fairness
“Are burdens, risks, and benefits distributed in a way I can accept?”

Fairness is affected by:
- food distribution
- shelter assignment
- who gets rest
- who does dangerous work
- whether injured NPCs are cared for
- whether contribution is recognized
- whether rules have exceptions for favorites only

## 15.3 Legitimacy
“Is the settlement’s authority/order worth following?”

Legitimacy rises when:
- leadership keeps people alive
- allocations are explainable
- voice exists
- decisions are not wildly inconsistent
- dangerous orders are not foolish
- long-term patterns look sensible

For gameplay, legitimacy is how the player’s rule becomes socially accepted rather than purely imposed.

---

# 16. Voice, autonomy, and player control

The player wants to request/order things. This spec supports that.

## 16.1 The player can set:
- settlement priorities
- zone designations
- task priorities
- role preferences
- intake policies for strangers
- rationing and reserve policies
- care priorities
- housing assignment rules later

## 16.2 NPCs should still retain:
- refusal under extreme danger or collapse
- self-preservation overrides
- task preference weighting
- social reactions to unfair or irrational policy
- variation in obedience/acceptance by trait and trust

## 16.3 Voice as a social mechanic
Research on worker well-being supports the importance of autonomy and voice in fostering belonging.

In game terms, “voice” can be abstracted as:
- preference signals
- complaints
- warnings
- requests for reassignment
- visible morale shifts when ignored or honored

The player still leads, but NPCs are not silent machines.

---

# 17. Mentorship, apprenticeship, and sponsorship

## 17.1 Why this matters
Small settlements do not only absorb newcomers through shelter and calories.
They absorb them through human guidance.

## 17.2 Mentor functions
A mentor can provide:
- skill instruction
- rule/context explanation
- social introduction
- reassurance
- correction without humiliation
- quality/safety habits
- role matching advice

## 17.3 Sponsor function
A sponsor is not always a teacher.
A sponsor simply vouches for or takes responsibility for a newcomer’s integration.

This is useful when:
- a shy or distrustful newcomer arrives
- a newcomer has low skill but high willingness
- the settlement is cautious and needs a responsible tie

## 17.4 Mentor effects
Strong mentorship should:
- increase newcomer belonging
- increase knowledge transfer speed
- reduce early task errors
- reduce outsider suspicion
- create at least one stronger tie

Weak or hostile mentorship should:
- slow integration
- increase shame/failure
- increase leave pressure
- possibly create grievance chains

## 17.5 Mentor load
Mentoring costs time and emotional energy.
A settlement with no spare mentor capacity should integrate newcomers worse even if it has spare food.

---

# 18. Shared rituals and social infrastructure

The early game does not need religion or elaborate ceremony yet, but it benefits from simple recurring social acts.

## 18.1 Shared meals
Shared meals should be one of the strongest low-cost early cohesion builders.

Why:
- visible fairness
- visible inclusion
- repeated contact
- emotional decompression
- memory formation around survival together

## 18.2 Shared crisis response
Nothing builds trust faster than surviving difficulty together.

Events that should strongly shape ties:
- storm preparation
- caring for the sick
- rescue from exposure
- emergency fire maintenance
- protecting seed/food stores
- recovering from a bad hunt

## 18.3 Shared work
Some work should be especially social:
- house raising later
- hauling heavy timber
- group harvesting later
- collective fuel gathering
- digging sanitation features
- building fences or racks

## 18.4 Social spaces
Even early camps should gain social bonuses from:
- hearth circle
- sheltered shared sitting area
- shared meal zone
- clean work yard
- maintained central path/space

This supports the idea that physical camp layout shapes social cohesion.

---

# 19. Scarcity, fatigue, and social breakdown

The social system must become more fragile under real survival pressure.

## 19.1 Scarcity effects
Hunger, thirst, and cold should do more than reduce stats.
They should alter social behavior:
- lower patience
- increase suspicion
- shorten time horizon
- reduce generosity
- increase conflict sensitivity
- weaken willingness to mentor
- intensify fairness disputes

## 19.2 Fatigue effects
Fatigue should reduce:
- emotional regulation
- patience
- teaching quality
- attention during social judgment
- safe conflict handling

This is strongly supported by fatigue research showing effects on attention, reaction, and error.

## 19.3 Overload effects
A settlement under too much simultaneous load should show:
- more short tempers
- more avoidance
- poorer onboarding
- more rule inconsistency
- lower cohesion
- higher chance of scapegoating or exclusion

---

# 20. Conflict model

Conflict in the early game should mostly be about **friction and stress**, not murder mystery drama.

## 20.1 Common early conflict sources
- suspected unfair food allocation
- perceived laziness or free-riding
- unsafe work by others
- shelter crowding
- noise/disruption during recovery
- newcomer mistrust
- repeated task failure
- role mismatch
- jealousy over better tools or better sleeping spots
- risk imposed without consultation

## 20.2 Conflict severity bands

### Low
Irritation, complaints, avoidance, sarcasm, low cooperation.

### Moderate
Argument, refusal, open grievance, factional preference, work slowdown.

### High
Departure attempt, sabotage, theft, fight, expulsion demand.

For the early slice, physical violence should be rare but possible under extreme breakdown.

## 20.3 Conflict resolution routes
- rest + food + time
- mediated conversation later in a light form
- reassignment
- visible compensation
- apology/repair behavior
- mentor intervention
- player policy adjustment
- separating sleeping/work areas
- proving competence through successful work

## 20.4 Conflict memory
Resolved conflict should not vanish instantly.
It should decay over time depending on:
- repair action
- subsequent good behavior
- group support
- repeated re-triggering

---

# 21. Hospitality, quarantine, and disease caution

Because the setting is realism-first, the social system must acknowledge contamination fear without making every stranger unusable.

## 21.1 Stranger caution policy
The settlement can have policy settings such as:
- open hospitality
- cautious hospitality
- emergency aid only
- closed except rescue
- closed due to disease/famine

## 21.2 Social consequences of policy
Open policies:
- improve moral identity and some recruitment opportunities
- increase disease and burden risk

Closed policies:
- reduce immediate risk
- lower rescue opportunities
- may reduce cohesion if care-oriented NPCs see the group as cruel

## 21.3 Disease-aware integration
Useful early rules:
- wash before shared food work
- separate sleeping spot for new arrival initially
- do not allow immediate access to all food/water handling
- monitor visible illness
- increase acceptance threshold during outbreaks

---

# 22. Stage-by-stage social expectations

## 22.1 Lone survivor
There is no society yet, but the NPC still has:
- loneliness
- hope/despair
- memory of former ties if desired later
- fear response to strangers
- relief when finding signs of safety

Main social gameplay:
- none directly, but the NPC’s personality and trust disposition matter for future recruitment.

## 22.2 Primitive camp
Possible first contact phase.

Main social needs:
- safe stranger handling
- emergency hospitality decisions
- first trust formation
- first shared routines

The biggest social question is:
> Can two people tolerate and help each other enough to survive together?

## 22.3 Permanent camp
The group can support repeated interaction and primitive role separation.

Main social needs:
- fairness in burdens
- sleeping arrangement stability
- handling low-grade conflict
- first mentor/sponsor relationships
- visible belonging markers

The biggest social question is:
> Is this still “my camp with extra hands,” or has it become “our place”?

## 22.4 Tiny hamlet
The group now has enough people for:
- cliques to begin
- social comparison to matter more
- care roles to emerge
- newcomer absorptive capacity to become a real limiter
- proto-governance and norm enforcement to matter

The biggest social question is:
> Can this group maintain cohesion while becoming more specialized?

---

# 23. Player-facing policies

A realism-first game benefits from explicit social policies.

## 23.1 Stranger intake policy
- deny contact
- aid at distance only
- temporary guest
- probationary intake
- immediate full intake (rarely wise early)

## 23.2 Food sharing policy
- strict equal rationing
- need-based rationing
- labor-priority rationing
- reserve-first rationing
- emergency triage

Each should have social pros and cons.

## 23.3 Shelter policy
- founder priority
- vulnerability priority
- role priority
- equal claim after acceptance
- temporary guest shelter only

## 23.4 Work distribution policy
- strict player assignment
- preferred roles with override
- volunteer-first within priority bands
- rotational burden for nasty tasks
- skilled-only for key tasks

## 23.5 Care policy
- minimal survival care
- balanced care
- high compassion / protect vulnerable

## 23.6 Mentorship policy
- no formal mentorship
- automatic sponsor assignment
- teach only high-value roles
- broad apprenticeship culture

## 23.7 Voice / complaint policy
- no visible voice
- soft voice (preferences only)
- normal voice (complaints and requests)
- strong voice (high morale effect if ignored)

---

# 24. Social events library

Events help make the system legible.

## 24.1 Positive events
- shared meal after shortage
- successful rescue
- first night survived together
- mentor/newcomer breakthrough
- fair allocation noticed
- group finishes new shelter
- sick member recovers because others cared

## 24.2 Negative events
- ration dispute
- sleeping place conflict
- newcomer caught near storage
- trusted worker fails dangerously
- care denied under stress
- repeated freeloading suspicion
- overwork resentment
- perceived favoritism

## 24.3 Ambiguous events
- stranger approaches during shortage
- gifted but abrasive newcomer
- injured person who consumes much and works little
- socially warm but unreliable worker
- competent worker who refuses communal norms

---

# 25. Data model proposal

## 25.1 NPC social state schema
Suggested fields:

- `social_connectedness`
- `belonging`
- `settlement_trust`
- `confidence_in_leadership`
- `perceived_fairness`
- `social_energy`
- `leave_pressure`
- `cooperation_willingness`
- `mentoring_willingness`
- `mentorability`
- `conflict_sensitivity`
- `care_orientation`
- `status_sensitivity`
- `trust_disposition`
- `conflict_aversion`
- `reciprocity_orientation`
- `current_grief`
- `current_loneliness`

## 25.2 Relationship record schema
- `npc_a_id`
- `npc_b_id`
- `familiarity`
- `trust`
- `respect`
- `comfort`
- `shared_work_score`
- `shared_meal_score`
- `rescue_debt_score`
- `mentorship_state`
- `grievance`
- `positive_memory_tags`
- `negative_memory_tags`
- `last_significant_event`
- `kinship_type` (later)

## 25.3 Settlement social state schema
- `cohesion`
- `fairness_climate`
- `hospitality_norm`
- `leadership_legitimacy`
- `integration_capacity`
- `conflict_pressure`
- `care_burden`
- `social_fear`
- `social_order`
- `newcomer_reputation`
- `shared_identity_strength`

## 25.4 Recruitment candidate schema
- `arrival_channel`
- `push_factors`
- `pull_factors`
- `visible_injury_or_illness`
- `immediate_need_level`
- `skill_profile`
- `interest_profile`
- `threat_assessment`
- `compatibility_estimate`
- `care_cost_estimate`
- `settle_probability`
- `departure_if_rejected_probability`

---

# 26. Example early-game flow

## Scenario: first wanderer arrives at primitive camp

Starter camp state:
- stable fire
- enough water for one extra day
- minimal stored food
- one semi-dry lean-to plus crude rack
- no true spare bed
- founder exhausted but not starving

Wanderer state:
- hungry
- cautious
- mild foot injury
- moderate hauling/building interest
- low craft skill
- high gratitude tendency
- medium trust disposition

Possible system flow:
1. outsider detected near water path
2. founder assesses threat and current surplus
3. settlement policy = cautious hospitality
4. wanderer receives water and one meal near edge of camp
5. temporary guest status assigned
6. next day: low-risk help task (gather brush, carry water, maintain firewood)
7. shared work + meal raises familiarity
8. mild injury treated; gratitude memory added
9. sponsor bond forms
10. after several successful low-risk tasks, belonging crosses provisional threshold
11. accepted member status granted
12. camp social load rises but survival capacity also improves
13. if fairness stays intact, the pair becomes a stable primitive camp household unit

This is the scale of social storytelling the early game should produce regularly.

---

# 27. Balancing notes

## 27.1 The system should reward humane competence
A cruel but efficient player should sometimes gain short-term labor efficiency,
but pay in:
- lower trust
- weaker retention
- worse mentorship
- higher conflict pressure
- lower willingness to take risks for the settlement later

## 27.2 The system should not be “friendship points only”
Material conditions still matter massively.
A starving, soaked, diseased camp should not become socially healthy because of a few positive interactions.

## 27.3 Early social systems must remain readable
The player should understand:
- why a person joined
- why they are upset
- why they feel bonded
- why they are thinking of leaving
- why a newcomer is not yet trusted

## 27.4 Social stability should feel earned
A tiny hamlet with stable membership, rotating burdens, a few trusted ties, and functioning mentorship should feel like a major achievement.

---

# 28. What this spec unlocks next

With this document in place, the project can now define:

- **role assignment & labor legitimacy rules**
- **allocation / ownership / rationing spec**
- **health, injury, and care spec**
- **event/narrative system**
- **trade & outsider interaction spec**
- **family / household spec later**
- **proto-governance spec later**

The most immediate companion document should probably be either:

1. **Allocation / Ownership / Rationing Spec**
2. **Health / Injury / Care Spec**

Those are the two systems most tightly coupled to early social stability.

---

# 29. Short conclusion

The early settlement should not grow only because more bodies appeared.

It should grow because:
- strangers can be assessed and absorbed
- trust can be built
- care can be given without collapsing the group
- burdens can be shared with tolerable fairness
- people can find a place in the work and in the camp
- mentorship can turn outsiders into contributors
- the player’s leadership becomes socially legible and accepted

That is what turns survival into society.

---

# References and research anchors

## Existing project documents
- Realistic Incremental/Idle Colony-to-City Game Design Document, v0.1
- Early Game Bible, v0.2
- NPC Simulation Spec, v0.1
- NPC Data Schema, v0.1
- Task Evaluation Spec, v0.1
- Item & Material Bible, v0.1
- Process Bible, v0.1
- Building & Structure Bible, v0.1
- Settlement Progression Spec Bible, v0.1
- Knowledge & Discovery Spec, v0.1

## External research anchors used for this spec
- CDC — Social Connection: Why it matters and community effects
  https://www.cdc.gov/social-connectedness/about/index.html
  https://www.cdc.gov/social-connectedness/promoting/index.html
  https://www.cdc.gov/social-connectedness/risk-factors/index.html

- Healthy People 2030 — Social Cohesion
  https://odphp.health.gov/healthypeople/priority-areas/social-determinants-health/literature-summaries/social-cohesion

- CDC / NIOSH — Social connection and worker well-being
  https://www.cdc.gov/niosh/bulletin/2023/social-connection-and-work.html

- CDC / NIOSH — Stress at work
  https://www.cdc.gov/niosh/docs/99-101/default.html

- CDC / NIOSH — Working hours and fatigue
  https://www.cdc.gov/niosh/bulletin/2023/fatigue.html

- CDC — Mentorship and collaboration in a public health network
  https://www.cdc.gov/pcd/issues/2015/15_0103.htm

- WHO / IRIS — Social determinants of health / social cohesion references
  https://iris.who.int/bitstream/handle/10665/326568/9789289013710-eng.pdf
  https://www.who.int/health-topics/social-determinants-of-health

- IOM / migration data resources on migration drivers
  https://www.migrationdataportal.org/themes/migration-drivers
  https://emm.iom.int/handbooks/global-context-international-migration/drivers-international-migration
  https://www.iom.int/fundamentals-migration

- UNHCR — Livelihoods, integration, and self-reliance resources
  https://www.unhcr.org/what-we-do/build-better-futures/livelihoods-and-economic-inclusion
