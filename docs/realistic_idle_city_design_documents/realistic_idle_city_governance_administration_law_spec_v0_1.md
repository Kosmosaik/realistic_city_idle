---
title: "Realistic Incremental/Idle Colony-to-City Game - Governance / Administration / Law Spec"
version: "v0.1"
scope: "Early slice only: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
status: "Design specification"
author: "OpenAI / ChatGPT"
date: "2026-04-09"
depends_on:
  - realistic_idle_city_design_v1.md
  - realistic_idle_city_early_game_bible_v0_2.md
  - realistic_idle_city_npc_simulation_spec_v0_1.md
  - realistic_idle_city_task_evaluation_spec_v0_1.md
  - realistic_idle_city_npc_data_schema_v0_1.md
  - realistic_idle_city_settlement_progression_spec_bible_v0_1.md
  - realistic_idle_city_knowledge_discovery_spec_v0_1.md
  - realistic_idle_city_social_recruitment_spec_v0_1.md
  - realistic_idle_city_allocation_ownership_rationing_spec_v0_1.md
  - realistic_idle_city_health_injury_care_spec_v0_1.md
  - realistic_idle_city_environmental_hazard_spec_v0_1.md
  - realistic_idle_city_food_water_safety_spec_v0_1.md
  - realistic_idle_city_logistics_hauling_storage_flow_spec_v0_1.md
  - realistic_idle_city_master_simulation_loop_spec_v0_1.md
  - realistic_idle_city_player_orders_policy_spec_v0_1.md
---

# 1. Purpose of this document

This document defines how **governance, administration, and law** work in the early game.

It is not a modern state simulator.
It is a realism-first model of how a tiny human settlement begins to regulate:

- shared resources
- dangerous behavior
- labor expectations
- sanitation and safety
- reserve protection
- outsider entry
- disputes
- role authority
- memory, records, and repeatable procedures

The goal is to make settlement life feel **socially organized**, not merely mechanically productive.

This document is written for the same early slice as the rest of the current stack:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It should integrate directly with:
- NPC simulation
- player orders/policies
- allocation/rationing
- social/recruitment
- knowledge/discovery
- event/incident
- settlement progression
- master simulation loop

---

# 2. Core design interpretation

## 2.1 Why governance exists in this project

A realism-first colony sim cannot treat society as:
- infinite obedience
- perfect sharing
- frictionless coordination
- universal trust
- costless authority

Once more than one person is present, real recurring questions appear:

- Who decides where the latrine goes?
- Who may eat the seed stock?
- Who gets the driest shelter place?
- What happens if someone repeatedly ignores fire safety?
- Who can promise food to a newcomer?
- Who checks whether the water jars are clean?
- Who settles a dispute about a damaged tool?
- Who is allowed to redirect labor during danger?
- Which rules are temporary emergency orders, and which become standing rules?

The game needs answers to those questions because social organization is part of civilization bootstrapping.

## 2.2 Governance is not the same as bureaucracy

In the early slice, governance should begin as:

- routines
- norms
- role-based authority
- camp rules
- communal expectations
- reserve protection
- conflict handling
- memory and recordkeeping

Formal administration grows later.
Early administration is small but important:
- counting stores
- noting obligations
- recording incidents
- remembering who is trusted with what

## 2.3 Law in the early slice

“Law” here does not mean written national statute.
It means the settlement’s active rule system:

- prohibitions
- obligations
- permissions
- recognized claims
- enforcement
- consequences
- dispute resolution
- emergency authority

In early play, law should feel closer to:
- camp rules
- customary practice
- stewardship duties
- leadership legitimacy
- collective survival norms

rather than courts and police.

---

# 3. Governance design pillars

## 3.1 Survival first
The earliest and strongest rule source is survival necessity.

Rules first emerge around:
- water protection
- fire safety
- food reserve protection
- sanitation
- night security
- shelter order
- dangerous tools and zones
- stranger handling

## 3.2 Legitimacy matters more than raw command
NPCs should not obey only because the player clicked a button.

Authority is stronger when NPCs perceive:
- competence
- fairness
- consistency
- transparency
- reciprocity
- care for survival
- voice/consultation where appropriate

## 3.3 Governance emerges from burden
The settlement should not receive a “governance unlock.”
Governance becomes necessary when coordination costs appear:
- multiple sleepers in one camp
- shared stores
- shared work zones
- competing labor claims
- reserve scarcity
- health/sanitation risks
- recurring disputes
- newcomers

## 3.4 Rules should track real common-pool problems
Some resources are difficult to exclude others from and are depleted or damaged by misuse.
In the early slice, those especially include:
- common firewood stacks
- public water points
- common cooking fire
- common tools
- seed reserve
- preserved food reserve
- common sleeping shelter
- shared work zones
- access paths
- clean containers

This should feel like the management of a fragile common store, not a magical shared inventory.

## 3.5 Governance should stay lightweight early
The early slice should not bury the player in paperwork.
Governance should be compact and mostly visible through:
- policies
- reserve rules
- role authority
- alerts
- complaints
- meeting outcomes
- simple records

## 3.6 Procedure matters
NPC compliance should be affected by *how* a rule is applied, not only *what* the rule is.

A rule enforced with:
- explanation
- consistency
- respect
- hearing both sides
- proportional response

should produce better trust than arbitrary command.

---

# 4. Real-world grounding used for this spec

This design is informed by a few strong real-world anchors:

## 4.1 Commons governance
Research synthesized by FAO drawing on Elinor Ostrom identifies durable patterns in successful common-pool resource governance, including:
- clearly defined boundaries
- proportionality between benefits and costs
- collective-choice arrangements
- monitoring
- graduated sanctions
- conflict-resolution mechanisms
- recognition of users’ rights to organize
- nested governance for larger systems

These are highly useful for modeling shared camp stores, water points, fuelwood, and communal labor.

## 4.2 Legitimacy and procedural justice
Procedural justice research summarized by NIJ shows that legitimacy and perceived fairness are strong drivers of cooperation and compliance.
This supports a design where NPC trust is affected by:
- respectful treatment
- explanation
- consistency
- being heard
- predictable enforcement

## 4.3 Participation improves management
OSHA guidance on worker participation in safety programs emphasizes that workers should participate in establishing, operating, evaluating, and improving systems that affect them.
This supports governance mechanics where NPC input improves:
- hazard policies
- work arrangements
- compliance
- problem detection
- legitimacy

## 4.4 Recordkeeping is a real management tool
FAO guidance repeatedly treats recordkeeping as a practical management tool for knowing the state of an enterprise, planning ahead, and making reliable decisions.
That supports simple early records for:
- stock counts
- reserve levels
- incidents
- outsider status
- role assignments
- seasonal obligations

## 4.5 Mediation as structured conflict handling
DOJ Community Relations Service materials frame mediation as a structured process where parties identify issues and develop agreements to address them.
That supports a realistic early dispute ladder:
- direct discussion
- mediated discussion
- settlement ruling
- restitution / obligation adjustment

---

# 5. Governance scope in the early slice

The early settlement governance system should regulate the following domains.

## 5.1 Water governance
- who can draw from which source
- source protection rules
- treatment requirements
- clean container rules
- washing/no-washing zones
- emergency drought restrictions
- reserve priority during scarcity

## 5.2 Fire governance
- who may light new fires
- where open flame is allowed
- spark/watch rules
- fuel stacking around fires
- children/newcomer restrictions later if relevant
- night fire watch expectations
- emergency fire suppression authority

## 5.3 Food and reserve governance
- seed reserve separation
- preserved food reserve access
- ration priority
- spoilage reporting
- cooked vs raw handling rules
- outsider feeding protocols
- emergency reserve release conditions

## 5.4 Shelter governance
- sleeping assignment
- protected rest rules for sick/injured NPCs
- quiet/rest periods
- wet gear handling
- fire/smoke rules inside or near shelter
- weather emergency crowding rules

## 5.5 Sanitation governance
- latrine placement/use rules
- waste dumping zones
- carcass disposal zones
- contaminated item isolation
- handwashing and clean-hand expectations near food/water work
- illness-specific restrictions where relevant

## 5.6 Labor governance
- role obligations
- emergency labor recall
- reserve-work priority
- minimum communal labor expectations
- accepted refusal reasons
- rest exemptions for injury/illness/exhaustion
- seasonal work obligations

## 5.7 Tool and equipment governance
- personal vs common tools
- checkout/return expectations
- tool cleaning/repair duty
- who may use fragile or critical tools
- breakage reporting
- repair priority

## 5.8 Outsider governance
- guest treatment
- watch/supervision rules
- food/water hospitality rules
- probationary work participation
- trust thresholds
- theft/violence protocols
- acceptance or departure process

## 5.9 Conflict governance
- direct dispute process
- mediated process
- who can rule in urgent disputes
- restitution rules
- repeated offender handling
- when exclusion becomes possible

## 5.10 Knowledge and record governance
- who may declare a method “approved”
- what must be written/remembered
- who updates stock counts
- who records incidents
- who teaches new rules to newcomers
- how mistaken beliefs are corrected

---

# 6. Governance stages by settlement stage

## 6.1 Stage 0 — Lone survivor
There is no social governance yet, only self-regulation.

Practical equivalents:
- routines
- habits
- self-imposed reserve rules
- repeated site choices
- risk aversion patterns

The player may still interact with early proto-governance concepts through:
- reserve locks
- danger prohibitions
- work priorities
- shelter/fire safety rules

But socially, there is no law yet because there is no second person to disagree.

## 6.2 Stage 1 — Primitive camp with 2 people
Governance appears as interpersonal survival rules.

Typical traits:
- ad hoc verbal agreements
- recognized temporary task authority
- simple sharing expectations
- role-based trust
- first complaints/conflicts
- first obligation memory

Typical rule content:
- do not foul the water
- do not burn reserve fuel carelessly
- do not consume seed reserve
- report injuries and spoilage
- respect sleep/watch cycles
- no unsupervised use of hazardous tasks if untrained

Administrative load:
- very light
- mostly memory-based
- perhaps only minimal simple marks/notes later if the world allows it

## 6.3 Stage 2 — Permanent camp
Governance becomes standing camp order.

Typical traits:
- named roles
- reserve stewardship
- sanitation rules
- newcomer procedure
- role authority
- recurring shared labor
- simple sanctions
- simple incident logs
- simple stock counts
- explicit rules about shared buildings

This is the first stage where governance should feel structurally visible.

## 6.4 Stage 3 — Tiny hamlet
Governance becomes proto-institutional.

Typical traits:
- repeated meetings or consultations
- steward roles
- clearer common vs personal ownership
- basic records
- reserve accounting
- accepted dispute ladder
- designated leadership authority
- emergency command rules
- guest/probation integration rules
- duty rotation
- standard operating rules for food, water, fire, and hygiene

This is not yet a formal government, but it is absolutely social organization.

---

# 7. The governance stack

The settlement’s governance system should be divided into layers rather than modeled as one number.

## 7.1 Norms
Soft expectations:
- help extinguish stray fire
- do not waste drinking water
- return common tools
- do not disturb sick sleepers
- do not leave waste near food areas

Violation effect:
- mild morale/trust hit
- complaints
- reputation shift

## 7.2 Standing rules
Explicit camp rules that are always active unless changed.

Examples:
- seed jars are not ordinary food
- latrine use is mandatory except in emergencies
- raw carcass work stays outside living zone
- treated water containers stay covered
- no cooking at sleeping platform
- reserve fuel stack requires approval in warm season

Violation effect:
- warnings, sanctions, trust loss, event risk

## 7.3 Role authority
Authority attached to role rather than personal dominance.

Examples:
- storekeeper can deny access to protected reserve
- water steward can mark a source unsafe
- care lead can require rest/isolation for a sick NPC
- fire steward can order immediate spark control
- camp leader can trigger emergency labor reallocation

## 7.4 Case decisions
One-off rulings for specific problems.

Examples:
- which of two NPCs gets the only dry bedding
- restitution for broken common pot
- whether a newcomer may stay one more night
- whether a worker too tired to haul should be excused

## 7.5 Policies
Player-set settlement-wide directives that shape behavior until changed.

Examples:
- reserve strictness
- newcomer hospitality level
- ration policy
- tool checkout strictness
- conflict escalation threshold
- sanitation strictness
- consultation level before rule changes

## 7.6 Customs
Repeated patterns that become de facto governance.

Examples:
- elder or most experienced worker speaks first
- every evening the stores are checked
- anyone returning from carcass work washes before cooking
- the most heat-tolerant NPC handles noon hauling in hot periods

Customs matter because they reduce coordination cost without needing explicit constant orders.

---

# 8. Sources of authority

Authority in the early settlement should come from multiple sources, not one.

## 8.1 Survival necessity
Some commands gain instant legitimacy because danger is obvious.

Examples:
- move from rising water
- extinguish this ember now
- stop drinking from that fouled source
- isolate this spoiled food batch

## 8.2 Competence authority
NPCs accept authority more easily from someone who is competent in the relevant domain.

Examples:
- best water handler rules on source safety
- best caregiver rules on fever rest
- best storekeeper rules on seed reserve
- best builder rules on structural safety

## 8.3 Contribution authority
Those who carry visible burdens may gain moral authority.

Examples:
- the person who maintains the fire expects fuel discipline
- the person who manages stores expects accurate return/check-in behavior

## 8.4 Recognized leadership
The settlement can recognize a leader or coordinator.

Early leader functions:
- emergency coordination
- final tiebreaks
- outsider acceptance decisions
- labor priority calls
- sanction approval for serious cases

## 8.5 Collective consent
Some authority becomes stronger when NPCs have had voice in making the rule.

This should especially matter for:
- labor expectations
- reserve restrictions
- shelter assignments
- newcomer policy
- sanctions that affect daily life

---

# 9. Legitimacy model

Governance should include a settlement legitimacy state and a leader legitimacy state.

## 9.1 Settlement legitimacy
How much NPCs believe that camp rules are:
- sensible
- fair
- survival-serving
- consistently applied
- socially acceptable

## 9.2 Leader legitimacy
How much NPCs believe that the current authority figure deserves compliance.

Influenced by:
- competence
- fairness
- predictability
- contribution
- burden-sharing
- communication clarity
- protection of vulnerable NPCs
- favoritism or lack thereof
- handling of crises
- whether the leader abuses emergency power

## 9.3 Core legitimacy inputs

### A. Procedural fairness
- heard both sides
- explained decision
- treated people respectfully
- consistent with prior rules
- proportional consequence

### B. Outcome fairness
- distribution feels defensible
- reserves are not hoarded arbitrarily
- burden is shared reasonably
- dangerous work is not unfairly dumped on one person
- protected people are protected for visible reason

### C. Competence
- rules actually improve survival
- leader notices hazards
- leader does not keep causing avoidable crises

### D. Reciprocity
- those asking sacrifice also contribute
- authority carries burden too

## 9.4 Effects of legitimacy
High legitimacy:
- better compliance
- fewer complaints
- faster emergency response
- lower sanction need
- easier integration of newcomers
- less resentment during rationing

Low legitimacy:
- passive resistance
- hidden stock misuse
- refusal or delay
- more disputes
- gossip/factionalism
- outsider integration problems
- crisis mismanagement

---

# 10. Governance actors and roles

## 10.1 Camp leader / coordinator
Early responsibilities:
- final tiebreak authority
- emergency command
- work reallocation in danger
- outsider acceptance decisions
- sanction approval in major cases
- convening discussions
- keeping rules coherent

This does not have to be autocratic.
The role may be:
- player-designated
- socially emergent
- temporarily assigned
- tied to legitimacy score

## 10.2 Storekeeper / reserve steward
Responsibilities:
- count stores
- protect seed reserve
- enforce ration policy
- note spoilage
- log shortages
- approve reserve release if authorized
- report missing items

## 10.3 Water steward
Responsibilities:
- source safety checks
- clean container discipline
- treatment reminders
- reserve water warnings
- water-point separation enforcement

## 10.4 Fire / safety steward
Responsibilities:
- fire placement and watch
- spark and ember hazards
- unsafe fuel stacking reports
- weather risk responses
- hazardous task restrictions

## 10.5 Care steward / health lead
Responsibilities:
- rest recommendations
- isolation recommendations
- contamination warnings
- care item priority
- triage support during incidents

## 10.6 Watch / perimeter coordinator
Responsibilities:
- night watch rotation
- outsider observation
- predator alert procedure
- weather watch
- emergency gathering call

## 10.7 Recordkeeper / scribe-lite
Very early recordkeeping can be minimal, but by tiny hamlet this role can track:
- stock totals
- reserve status
- accepted outsiders
- incident history
- work obligations
- rule changes
- seasonal notes

## 10.8 Council-like consultation group
At tiny hamlet scale, there may be no permanent council yet, but there can be a recurring consultation cluster:
- leader
- storekeeper
- water steward
- one or two respected workers
- caregiver if health issue relevant

This should help rule changes feel social rather than absolute.

---

# 11. Law content types

## 11.1 Prohibitions
Things not allowed.

Examples:
- fouling a water source
- opening protected seed storage without permission
- storing carcass waste near the sleeping zone
- leaving open flame unattended in hazard conditions
- withholding known contamination information
- violence against settlement members except in immediate defense

## 11.2 Obligations
Things a member must do.

Examples:
- report spoilage or contamination
- help with fire suppression if capable
- join emergency haul/protection work if fit
- return common tools
- follow illness-control instructions in outbreak conditions
- contribute agreed communal labor where capable

## 11.3 Permissions
Things allowed only under conditions.

Examples:
- draw from reserve water if approved
- host outsider overnight if guest protocol followed
- use fragile cutting tool if trained
- enter seed store if role-authorized
- redirect common labor during declared emergency

## 11.4 Claims / recognized rights
Socially recognized claims.

Examples:
- sick/injured have claim to care and protected rest
- contributors have claim to fair share consistent with policy
- members have claim to hearing in disputes
- guests have claim to minimum treatment if accepted as guests
- children later would have special protective claims

## 11.5 Duties of office
Rules attached to role.

Examples:
- storekeeper must count honestly
- leader must not hide reserve status
- water steward must mark unsafe water clearly
- health lead must not conceal contamination risk

## 11.6 Emergency powers
Temporary rule intensification in danger.

Examples:
- immediate evacuation from flood channel
- emergency food/water ration tightening
- mandatory fire line labor
- temporary access closure to unsafe source
- sleep interruption for acute rescue

Emergency powers should:
- be time-limited
- be explainable
- be reviewable afterward

---

# 12. Ownership and jurisdiction

This document builds on the allocation/ownership spec but adds governance consequences.

## 12.1 Ownership classes in governance terms
- **Personal**: individual clothing, keepsakes, perhaps assigned knife or tool
- **Assigned-use**: personally used but settlement-retainable tool or bedding
- **Household/bed-group**: small shared cluster goods
- **Common stock**: settlement food, water, fuel, containers, raw materials
- **Protected reserve**: seed, emergency food, emergency water, critical medicine/care items
- **Role-controlled stock**: items released only via responsible steward
- **Guest-use stock**: limited hospitality items

## 12.2 Governance implications by class
Personal property:
- stronger expectation against arbitrary seizure
- still may be commandeered in extreme emergency with legitimacy cost

Common property:
- use regulated for fairness and sustainability

Protected reserve:
- strongest access control
- misuse treated as serious offense

Role-controlled stock:
- requires accountability of the steward

## 12.3 Jurisdiction zones
Rules can differ by space:
- water point
- clean storage zone
- dirty processing zone
- sleeping shelter
- common fire area
- latrine area
- guest area
- seed store
- emergency assembly point

This lets governance feel spatial and realistic.

---

# 13. Decision-making model

## 13.1 Decision classes

### Class A — Instant emergency command
Examples:
- flood escape
- active fire response
- predator defense
- collapse danger
- contamination stop order

Authority:
- whoever is recognized as competent/leader and present

Consultation:
- minimal

### Class B — Operational decision
Examples:
- today’s hauling priority
- who uses scarce dry bedding
- where to place a new storage jar
- who escorts a guest

Authority:
- role owner or leader

Consultation:
- low to moderate

### Class C — Policy decision
Examples:
- reserve strictness
- newcomer hospitality level
- shared labor expectations
- sanctions ladder strictness
- shelter assignment rules
- guest probation rules

Authority:
- player plus settlement consultation effects

Consultation:
- moderate to high

### Class D — Dispute ruling
Examples:
- responsibility for broken pot
- accusation of hoarding
- repeated sanitation violation
- contested work refusal

Authority:
- mediator then leader/camp ruling if unresolved

Consultation:
- hearing expected

## 13.2 Early meeting forms
Tiny hamlet governance can use:
- evening camp check-in
- crisis meeting
- policy review
- outsider hearing
- dispute hearing
- seasonal readiness meeting

These should be lightweight and event-driven, not constant.

## 13.3 Consent thresholds
Not every rule needs full consensus.
Suggested categories:
- emergency: no consent threshold
- routine operational: leader/role authority sufficient
- standing policy: consultation recommended
- severe sanction / expulsion: high legitimacy requirement

---

# 14. Administration system

## 14.1 What administration means in early play
Administration is the settlement’s ability to:
- remember
- count
- assign
- verify
- review
- communicate repeatable expectations

It is not yet a paperwork mini-game.

## 14.2 Minimal administrative records
By permanent camp / tiny hamlet, the following records make sense:

### A. Store ledger
- food by category
- protected reserve totals
- water reserve status
- fuel reserve status
- key container counts
- spoilage losses

### B. Role roster
- primary role
- fallback role
- watch participation
- care exemption if needed
- steward role if any

### C. Incident log
- injuries
- contamination events
- fire scares
- outsider visits
- repeated disputes
- severe weather impacts

### D. Rule register
- active standing rules
- last changed date/season
- who proposed
- who approved
- emergency-only rules

### E. Outsider register
- guest name/description
- arrival reason
- trust status
- stay deadline
- obligations/restrictions
- sponsor/member responsible

### F. Obligation notes
- restitution owed
- shared labor obligations
- watch rotation debt
- restricted access duration

## 14.3 Administrative quality
Administration can vary in quality:
- poor
- basic
- reliable
- disciplined

Higher quality improves:
- reserve awareness
- planning
- continuity across illness/injury
- reduced double-claiming
- better dispute evidence
- better legitimacy

Poor administration causes:
- forgotten promises
- missing stock
- untracked outsiders
- repeated mistakes
- unfair seeming decisions

## 14.4 Administrative burden
Administration takes labor and attention.
Too much formality too early should be harmful.
The game should reward only those records that solve real bottlenecks.

---

# 15. Monitoring and enforcement

## 15.1 Monitoring should be mostly social and spatial early
In a tiny camp, most monitoring is:
- line-of-sight
- role observation
- repeated routines
- store checks
- visible zones
- peer reporting

There should not yet be an abstract surveillance system.

## 15.2 What gets monitored first
Highest-priority monitored domains:
- fire
- water safety
- food reserve
- seed reserve
- contamination
- critical tool return
- outsider movement
- severe fatigue or illness-related unsafe work

## 15.3 Monitoring actors
- role steward
- nearby peers
- night watch
- leader during inspection
- recordkeeper later

## 15.4 Enforcement style
Early enforcement should favor:
1. reminder
2. warning
3. correction order
4. restitution / extra obligation
5. restricted access / role loss
6. close supervision / probation
7. expulsion in severe or repeated extreme cases

This is intentionally a graduated ladder.

---

# 16. Sanctions and consequences

## 16.1 Sanction principles
Sanctions should be:
- proportional
- explainable
- domain-relevant
- survival-compatible
- legitimacy-sensitive
- reviewable after crisis

## 16.2 Sanction ladder

### Tier 0 — Quiet correction
Used for:
- minor accidental mistakes
- first-time low-harm violations

Examples:
- “That jar stays covered.”
- “Wash before touching cooked food.”

### Tier 1 — Formal warning
Used for:
- repeated low-harm behavior
- clear negligence
- ignored instruction

Effects:
- trust decrease
- reputation note
- future violation judged more severely

### Tier 2 — Restitution
Used for:
- damage to common goods
- wasted supplies
- avoidable spoilage
- broken tool through carelessness

Examples:
- extra repair labor
- replacement obligation
- extra hauling or cleaning duty

### Tier 3 — Restricted access
Used for:
- misuse of critical tools
- reserve violations
- unsafe behavior around water/fire/food

Examples:
- no seed store access
- no unsupervised fire tending
- no sharp tool checkout without approval

### Tier 4 — Role removal / probation
Used for:
- failed stewardship
- repeated dishonesty
- high-risk negligence
- outsider unreliability

### Tier 5 — Temporary exclusion from some spaces or decisions
Used for:
- aggression
- contamination refusal
- repeated severe disruption

### Tier 6 — Expulsion / forced departure
Used rarely and only for severe threat:
- violence
- theft of critical reserves
- sabotage
- repeated dangerous disregard after escalation
- outsider threat too high to retain

## 16.3 Sanction side effects
Too harsh:
- legitimacy drops
- fear and concealment rise
- factional grievance grows

Too weak:
- rules stop mattering
- reserve misuse rises
- safety failures recur

---

# 17. Conflict and dispute resolution

## 17.1 Why disputes must exist
In a realistic settlement, disputes will emerge from:
- scarce goods
- hard labor
- fatigue
- broken promises
- damage attribution
- role boundaries
- outsider suspicion
- shelter crowding
- reserve restriction

## 17.2 Dispute categories
- property/use dispute
- labor burden dispute
- authority dispute
- insult/disrespect dispute
- safety negligence dispute
- outsider trust dispute
- care priority dispute
- ration fairness dispute

## 17.3 Resolution ladder

### Step 1 — Direct resolution
If safe, the two parties talk directly.

### Step 2 — Informal mediation
A respected third party helps clarify:
- what happened
- what is needed
- what restitution is fair

### Step 3 — Formal camp hearing
Leader or steward hears both sides, checks evidence/records, and rules.

### Step 4 — Settlement review
Used for severe outcomes, repeated behavior, or sanction review.

## 17.4 Mediation goals
Mediation should aim at:
- restoring cooperation
- clarifying facts
- assigning fair correction
- reducing repeated callback disputes
- preserving group function

## 17.5 Evidence sources
Early evidence can include:
- witness accounts
- visible stock counts
- location history
- tool checkout history
- contamination/incident log
- role authority notes
- physical state of item/place

---

# 18. Participation, voice, and consultation

## 18.1 Why participation matters
NPCs should comply better when they can contribute knowledge about:
- hazard conditions
- workload feasibility
- tool problems
- poor procedures
- storage problems
- outsider concerns
- sanitation failures

## 18.2 Participation channels
- complaint
- suggestion
- hazard report
- reserve warning
- disagreement note
- policy concern
- meeting contribution
- steward report

## 18.3 Voice quality
A settlement can have:
- ignored voice
- tolerated voice
- useful voice
- trusted voice

Higher voice quality increases:
- hazard detection
- legitimacy
- innovation uptake
- morale
- problem-solving

## 18.4 Costs of voice
Too much consultation in acute survival crisis can slow necessary action.
So governance should distinguish:
- emergency command
- consultative policy

---

# 19. Governance of newcomers and membership

## 19.1 Membership statuses
- stranger
- supervised guest
- provisional helper
- accepted member
- restricted member / probationary member

## 19.2 Governance questions for newcomers
- who can host them?
- what resources can they access?
- where can they sleep?
- can they join work?
- can they handle tools?
- can they be alone near seed/reserves?
- who vouches for them?
- when do they become members?

## 19.3 Sponsor logic
A current member may sponsor a newcomer.
Sponsor responsibilities:
- explain rules
- watch first compliance
- report problems
- support integration
- bear some legitimacy cost if sponsorship fails badly

## 19.4 Early expulsion threshold
The tiny hamlet must be able to refuse or expel dangerous outsiders.
But doing so should carry social and moral effects depending on context.

---

# 20. Governance and safety / health integration

## 20.1 Health can override ordinary rights
Under realistic survival conditions:
- infectious diarrhea can justify water/food handling restriction
- severe fatigue can justify work refusal approval
- delirium/fever can justify supervision
- contamination risk can justify access restriction
- shelter priority can temporarily shift toward vulnerable NPCs

## 20.2 Safety governance examples
- no cooking in enclosed unventilated sleeping area
- no carrying overload when medically restricted
- no untreated source use after contamination warning except emergency
- no unattended ember in high-wind condition
- no spoiled batch mixing into common pot

## 20.3 Care ethics in governance
A realistic system should not treat vulnerability only as inefficiency.
Care obligations should strengthen legitimacy if handled well.

---

# 21. Governance and knowledge integration

## 21.1 Approved procedure
Some procedures should become “approved” camp practice once:
- repeated success exists
- trusted mentor confirms
- steward accepts
- record or custom stabilizes

Examples:
- safe boiling/storage sequence
- hide-smoking sequence
- seed-drying method
- food-drying racks placement
- fire watch routine

## 21.2 Rule memory and forgetting
Without records or reliable teaching:
- rules drift
- exceptions get misremembered
- reserve discipline erodes
- newcomers learn badly

Governance and knowledge therefore reinforce each other.

## 21.3 Institutional knowledge begins here
Institutional knowledge in the early slice is not advanced bureaucracy.
It begins when the settlement can say:
- “This is how we do it here.”
- “Only this person releases seed stock.”
- “We always wash after carcass work.”
- “Guests stay in this zone first.”
- “These marks count as accepted reserve jars.”

---

# 22. Governance and player control

## 22.1 Relationship to player orders/policy
The player sets:
- policy
- priorities
- permissions
- reserve strictness
- role designation
- emergency overrides
- consultation level

The settlement simulation then determines:
- whether NPCs understand
- whether they accept
- whether they comply quickly
- whether complaints arise
- whether legitimacy changes
- whether informal practice bends the rule

## 22.2 What the player should not be able to do for free
To preserve realism, the player should not get costless absolute control over:
- obedience
- sanction acceptance
- confiscation
- dangerous overwork
- secret reserve use
- arbitrary expulsion
- permanent emergency powers

## 22.3 Player-facing governance actions
- assign/reassign leader
- designate stewards
- set standing rules
- set reserve access level
- approve/reject guest stay
- call meeting
- mediate dispute
- issue formal warning
- approve sanction
- review incident
- publish new standard procedure
- declare emergency mode
- end emergency mode

---

# 23. Governance buildings, spaces, and artifacts

Governance is strengthened by certain physical supports.

## 23.1 Meeting place
A simple regular gathering space improves:
- consultation
- announcements
- outsider hearings
- sanction explanation
- dispute handling

## 23.2 Storehouse / reserve structure
Makes reserve governance visible and enforceable.

## 23.3 Rule marks / simple record board / ledger shelf
Even simple physical record supports improve continuity.

## 23.4 Guest area
Supports controlled hospitality and reduced reserve risk.

## 23.5 Watch point / lookout
Supports early security and emergency coordination.

## 23.6 Quarantine / isolation sleeping corner
Supports health-linked governance without requiring advanced medicine.

---

# 24. Stage-specific governance content

## 24.1 Lone survivor
Relevant governance content:
- personal reserve discipline
- self-imposed danger prohibitions
- emergency priority rules
- routine development

## 24.2 Primitive camp
Relevant governance content:
- shared fire rules
- shared sleeping rules
- water-source protection
- simple tool sharing
- first complaints
- role authority emergence

## 24.3 Permanent camp
Relevant governance content:
- latrine and waste rules
- protected reserve rules
- guest rules
- recurring communal labor
- basic sanctions
- basic records
- steward roles

## 24.4 Tiny hamlet
Relevant governance content:
- designated leader
- consultation events
- role roster
- stock and reserve ledger
- sanction ladder
- dispute handling structure
- onboarding rules
- duty rotation
- emergency authority review

---

# 25. Data model recommendations

## 25.1 GovernanceState
Suggested fields:
- settlement_id
- current_stage
- active_leader_id
- legitimacy_score
- camp_order_score
- consultation_style
- emergency_mode
- emergency_reason
- current_standing_rules[]
- active_role_authorities[]
- active_sanctions[]
- last_meeting_time
- unresolved_disputes_count
- governance_quality
- recordkeeping_quality

## 25.2 StandingRule
- rule_id
- domain
- title
- description
- severity
- applies_in_zones[]
- applies_to_statuses[]
- exceptions[]
- created_by
- approved_by
- created_time
- review_time
- emergency_only
- legitimacy_cost_if_broken_outcome

## 25.3 GovernanceRoleAuthority
- role_name
- powers[]
- domain_limits[]
- emergency_powers[]
- review_requirements[]
- legitimacy_modifier_if_role_is_competent
- legitimacy_modifier_if_role_abuses_power

## 25.4 SanctionRecord
- sanction_id
- npc_id
- violation_type
- incident_id
- tier
- start_time
- end_time
- restitution_required
- restrictions[]
- approved_by
- reviewed_by
- review_result

## 25.5 DisputeCase
- case_id
- category
- involved_npc_ids[]
- complainant_id
- respondent_id
- witnesses[]
- evidence_refs[]
- mediator_id
- hearing_status
- proposed_resolution
- final_resolution
- restitution_terms
- legitimacy_impact

## 25.6 GovernanceMeeting
- meeting_id
- type
- agenda[]
- invited_ids[]
- attended_ids[]
- decisions[]
- unresolved_items[]
- followup_time

## 25.7 OutsiderStatusRecord
- outsider_id
- sponsor_id
- current_status
- restrictions[]
- permitted_zones[]
- resource_access_level
- probation_end_time
- decision_notes

---

# 26. First-playable governance minimum

To keep the early slice manageable, the first playable governance package should only include:

## 26.1 Roles
- camp leader
- storekeeper
- water steward

## 26.2 Rule domains
- fire
- water
- reserve food
- seed reserve
- sanitation
- outsider sleeping/food access

## 26.3 Sanctions
- warning
- restitution
- restricted access
- expulsion for extreme outsider threat only

## 26.4 Administrative records
- stock totals
- protected reserve totals
- outsider status
- incident notes
- active rules list

## 26.5 Meetings
- crisis meeting
- evening status review
- outsider acceptance review

## 26.6 Player actions
- assign leader
- assign storekeeper
- set reserve strictness
- approve guest stay
- declare emergency
- issue formal warning
- approve restitution
- lock protected reserve

This is enough to make governance present without making it dominate the game too early.

---

# 27. Expansion path after the early slice

This document is intentionally early-game focused.
Later eras should expand governance into:

- household vs workshop jurisdiction
- market rules
- debt and exchange records
- apprenticeship standards
- contract-like obligations
- formal guard/watch institutions
- zoning
- public works labor obligations
- taxation/subscription equivalents
- permits/inspection
- courts/tribunals
- formal offices
- written codes
- guild-like regulation
- policing and incarceration questions if desired
- larger nested governance structures

But none of that is needed yet.

---

# 28. Final design stance

The early settlement should not feel like:
- a dictatorship by click
- a perfect commune with no friction
- a modern legal state
- a spreadsheet without people

It should feel like a fragile human group learning to coordinate survival.

The realistic heart of governance in this game is:

- people need rules when they share fragile resources
- people comply better when authority feels fair and competent
- records matter once memory is not enough
- sanctions work best when graduated and proportional
- conflict resolution preserves group function
- governance grows because survival and coordination demand it

That is how a camp begins to become a society.

---

# References

These sources were used to ground the realism assumptions in this document.

1. FAO, discussion of common-pool resource governance and Ostrom-style design principles  
   https://www.fao.org/fileadmin/templates/solaw/files/thematic_reports/TR_09_web.pdf

2. National Institute of Justice, legitimacy and procedural justice as drivers of cooperation/compliance  
   https://nij.ojp.gov/topics/articles/overlooked-role-jails-discussion-legitimacy-implications-trust-and-procedural-justice

3. OSHA, worker participation in establishing, operating, evaluating, and improving safety and health programs  
   https://www.osha.gov/safety-management/worker-participation

4. FAO, record keeping as a management tool for reliable information and planning  
   https://www.fao.org/4/w6864e/w6864e0f.htm

5. U.S. DOJ Community Relations Service, mediation as a structured conflict-resolution process  
   https://www.justice.gov/crs/media/1162011/dl?inline=

6. World Bank, community mediation for local and low-economic disputes  
   https://thedocs.worldbank.org/en/doc/19fccdbe5545f75d9a52be44f04c7417-0260012023/original/LJD-Community-Mediation-for-Local-Familial-and-Low-Economic-Disputes-pdf-2023-2.pdf
