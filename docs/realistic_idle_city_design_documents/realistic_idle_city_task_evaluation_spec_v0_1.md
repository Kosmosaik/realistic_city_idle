---
title: "Realistic Incremental/Idle Colony-to-City Game - Task Evaluation Spec"
version: "v0.1 - research-backed working draft"
date: "2026-04-07"
status: "working draft"
based_on:
  - "realistic_idle_city_design_v1.md"
  - "realistic_idle_city_early_game_bible_v0_2.md"
  - "realistic_idle_city_npc_simulation_spec_v0_1.md"
  - "realistic_idle_city_npc_data_schema_v0_1.md"
author: "OpenAI / ChatGPT"
project_notes:
  - "Realism-first, research-backed"
  - "Top-down minimal visuals in Godot"
  - "Player gives orders, priorities, restrictions, and policies"
  - "NPCs evaluate work through needs, safety, skill, role fit, and circumstances"
  - "The goal is believable autonomy, not perfect obedience"
---

# Task Evaluation Spec v0.1

## Purpose of this document

This document describes **how NPCs decide what to do** once the player has issued orders, set priorities, or placed work requests.

It answers:

- What is a task in this game?
- How should an NPC decide between thirst, hunger, shelter, hauling, fire tending, food gathering, and player-assigned work?
- Which conditions hard-block a task?
- Which factors merely modify its desirability?
- How should interest, aptitude, skill, fatigue, morale, danger, and distance affect assignment?
- How should the system work in Godot without becoming a giant hard-coded mess?

The design target is:

> The player does **not** puppeteer bodies directly. The player requests and prioritizes outcomes. NPCs then evaluate what is feasible, urgent, safe, and worthwhile.

---

# 1. Design stance

## 1.1 What the system should feel like

The task system should make NPCs feel:

- self-preserving
- somewhat rational
- uneven in judgment
- shaped by personality and condition
- responsive to player intent without being robotic

An NPC should **not** mindlessly continue hauling branches if they are collapsing from thirst, freezing in wet clothes, or badly injured.

Likewise, an NPC should not refuse all colony work simply because they dislike it if the settlement is facing a survival emergency.

## 1.2 Behavioral realism targets

The system should reflect a few grounded ideas:

- severe unmet physiological needs override many other concerns
- sleep loss reduces attention stability and increases mistakes, especially during demanding tasks or time pressure citeturn976221view0turn976221view7
- dehydration and heat strain can reduce physical and mental performance citeturn976221view1turn412551search22
- moderate challenge can be productive, but very high stress impairs performance, especially on harder cognitive tasks citeturn828549search2turn828549search5
- motivation improves when people feel some competence, some choice/volition, and some social connection citeturn412551search3turn828549search15
- social support helps resilience and health, which supports why NPCs should care about belonging, trust, and having others nearby citeturn976221view4turn828549search18

These ideas should guide behavior, but the implementation remains game-tuned rather than clinically literal.

---

# 2. What a task is

A **task** is a bounded unit of intended work that an NPC can evaluate.

Examples:
- drink from water source
- fetch one load of water
- gather dry sticks from patch A
- add fuel to hearth
- sleep at bed spot
- skin small animal carcass
- dry meat batch
- build section of lean-to wall
- move seeds to dry storage
- inspect trap line

A task is not the same thing as a long-term goal.

### Long-term goal examples
- survive the night
- stabilize camp
- prepare for first frost
- maintain food surplus
- support second NPC

### Relationship
- goals generate tasks
- player orders generate tasks
- events generate tasks
- needs generate tasks

---

# 3. Layers of decision making

The system should evaluate work in layers.

## 3.1 Layer A — hard blockers

Can the NPC do this at all right now?

Examples:
- no path
- no required tool
- wrong body posture or hand occupancy
- task forbidden by policy
- task forbidden by injury
- site too dangerous by hard rule
- required knowledge missing
- target object missing or already reserved
- too dark if task requires visibility and no light exists
- cannot leave child/patient if under hard duty later

If any hard blocker fails, the task score becomes zero.

## 3.2 Layer B — physiological override

Should the NPC interrupt most other work because their body state is too critical?

Examples:
- severe thirst
- severe hypothermia risk
- severe fatigue collapse risk
- heavy bleeding
- uncontrolled fire threat nearby
- active predator threat

These states do not merely lower task score.
They may force a change in top priority.

## 3.3 Layer C — urgency

How time-sensitive is this task?

Examples:
- drinking when dehydrated = very urgent
- covering stored food before rain = urgent
- harvesting ripe crop before storm = urgent
- sweeping camp = low urgency unless disease/pest pressure is high

## 3.4 Layer D — desirability

How attractive is this task to this NPC under current conditions?

This is where:
- interests
- role fit
- player priority
- morale expectations
- repetition fatigue
- social context

should matter.

## 3.5 Layer E — expected outcome quality

If the NPC attempts the task, how likely are they to:
- succeed
- finish quickly
- avoid injury
- produce decent quality
- avoid waste

This is where:
- skill
- aptitude
- fatigue
- lighting
- tools
- supervision
- environmental condition

should matter.

## 3.6 Layer F — strategic colony value

Some tasks matter because the colony needs them even if they are not the NPC’s favorite.

Examples:
- fetching water when camp reserves are empty
- tending fire in cold rain
- moving spoiled meat away from camp
- basic sanitation when illness risk is rising

This allows the settlement to remain functional.

---

# 4. Task object schema

Each generated task should expose these fields.

## 4.1 Identity and ownership
- `task_id`
- `task_type`
- `source_type` — need / player_order / building_request / schedule / event / emergency
- `created_tick`
- `expires_tick` if relevant
- `creator_id` or system source

## 4.2 Target and location
- `target_entity_id`
- `target_position`
- `worksite_id`
- `pickup_entity_ids`
- `dropoff_entity_id`
- `required_path_tags`

## 4.3 Inputs and requirements
- `required_tools`
- `required_equipment`
- `required_materials`
- `required_knowledge`
- `required_skills_minimum`
- `required_work_tags`
- `forbidden_health_states`
- `required_light_level`
- `required_temperature_window`

## 4.4 Safety and risk metadata
- `injury_risk_base`
- `illness_risk_base`
- `hostile_risk_base`
- `weather_exposure_risk`
- `fire_risk`
- `contamination_risk`

## 4.5 Work characteristics
- `estimated_duration`
- `estimated_exertion`
- `estimated_attention_demand`
- `estimated_precision_demand`
- `estimated_noise_or_stress`
- `interruptible`
- `multi_stage`
- `can_fail_partially`

## 4.6 Colony relevance
- `need_tags_satisfied`
- `settlement_priority`
- `role_affinity_tags`
- `seasonal_importance`
- `emergency_class`

## 4.7 Reservation and concurrency
- `is_reserved`
- `reserved_by`
- `max_workers`
- `current_workers`
- `dependency_task_ids`

---

# 5. NPC evaluation pipeline

Each available NPC should evaluate candidate tasks through the same general pipeline.

## 5.1 Pipeline step 1 — gather candidate set

Candidate tasks come from:
- self-preservation needs
- scheduled commitments
- active player orders
- nearby opportunistic tasks
- settlement maintenance tasks
- emergency tasks
- queued production tasks

## 5.2 Pipeline step 2 — eliminate impossible tasks

Remove tasks with hard blockers.

Examples:
- no route
- no access permission
- missing required tool
- lacking required knowledge gate
- task already reserved
- outside allowed work zone
- too injured

## 5.3 Pipeline step 3 — compute self-preservation pressure

Generate or score internal tasks such as:
- drink
- eat
- sleep
- warm self
- dry clothing/body
- seek shelter
- self-treat wound
- use latrine area
- flee danger
- ask for help / regroup later

This step is crucial. The NPC should always be comparing colony work against bodily necessity.

## 5.4 Pipeline step 4 — compute utility score for each remaining task

Every candidate receives a score from multiple components.

### Recommended broad score shape

```text
FinalScore =
  Feasibility
  * SurvivalOverride
  * SafetyMultiplier
  * (Urgency + ColonyNeed + PlayerPriority + RoleFit + Interest + SocialPull + TrainingValue)
  * SuccessExpectation
  * AccessEfficiency
  * ConditionPenalty
```

This exact formula can be tuned, but the design idea matters more than the final constants.

## 5.5 Pipeline step 5 — choose best task above threshold

- highest score wins
- if all scores are too low, choose idle-safe fallback or self-preservation task
- if close scores tie, add small deterministic personality noise or rotation logic

## 5.6 Pipeline step 6 — commit and reserve

Once chosen:
- reserve targets
- claim inventory if needed
- mark destination
- enter execution state

## 5.7 Pipeline step 7 — monitor interruption conditions

Interrupt if:
- body state crosses emergency threshold
- fire/predator threat appears
- task becomes impossible
- higher emergency task appears nearby
- weather shift creates severe exposure risk
- player forbids or cancels the task

---

# 6. Scoring components

## 6.1 Feasibility

Binary or near-binary gate.

### Inputs
- path exists
- target exists
- tool exists
- permissions okay
- required knowledge available
- minimum body capability available

### Output
- 0.0 = impossible
- 1.0 = feasible

## 6.2 Survival override

This is the most important modifier.

If thirst, cold exposure, severe fatigue, collapse risk, major pain, or danger are too high, the NPC must heavily prefer body-preserving tasks.

### Example
- mild thirst: hauling wood still possible
- severe thirst: fetching water or drinking should dominate
- severe cold + wetness: drying/warming should dominate
- severe fatigue + darkness: sleep or shelter should dominate over non-emergency labor

## 6.3 Safety multiplier

Tasks should be penalized when current risk is too high.

### Inputs
- injury risk
- hostile risk
- weather exposure risk
- contamination risk
- fire risk
- darkness
- isolation

### Modifiers from the NPC
- caution
- bravery/risk tolerance
- current pain
- current morale
- available escort or buddy
- known site familiarity

## 6.4 Urgency

Urgency should rise when:
- the window is closing
- deterioration is fast
- other tasks depend on it
- spoilage/weather/loss risk is imminent

### Examples
- meat on ground in warm weather = fast urgency growth
- sleeping at dawn after full rest = low urgency
- tending active hearth during cold rain = high urgency
- sanitation after illness outbreak = high urgency

## 6.5 Colony need

This reflects settlement-level importance.

Examples:
- water reserves nearly empty
- no dry fuel stock
- food reserves falling
- patient unattended
- camp filth rising
- seed stock left exposed

The colony need score stops NPCs from over-optimizing for personal preference.

## 6.6 Player priority

This reflects explicit player intent.

The player can influence:
- task category priority
- district priority
- emergency flags
- forbid/allow lists
- per-NPC role preference
- job tickets

Player priority should matter strongly, but not infinitely.

An NPC should still abandon “gather clay” if they are collapsing from thirst.

## 6.7 Role fit

Tasks matching the NPC’s current role should get a bonus.

Examples:
- assigned cook prefers food processing tasks
- assigned water hauler prefers water logistics
- assigned learner prefers apprentice-friendly work near trainer

Role fit should remain weaker than hard survival but stronger than mild interest.

## 6.8 Interest

Interest should affect:
- willingness to start
- morale while doing the task
- boredom accumulation
- learning speed

This is where your core idea matters:
- high interest = faster willing engagement and better long-term growth

## 6.9 Training value

Sometimes the colony wants an NPC to practice a skill.

Training value should rise when:
- the task teaches a targeted skill
- a trainer is nearby
- task risk is acceptable
- repetition has not yet saturated this day

This supports apprenticeship and deliberate practice logic: improvement is stronger when practice is structured, repeated, and feedback-rich rather than purely incidental. citeturn828549search10turn828549search1

## 6.10 Success expectation

This predicts likely outcome quality.

### Inputs
- related skill level
- related aptitudes
- confidence
- available tools
- material quality
- current fatigue
- current hydration
- lighting
- weather
- supervision

This prevents unskilled NPCs from repeatedly wrecking critical work unless the colony is desperate.

## 6.11 Access efficiency

Travel time matters in an idle colony game.

A task should score better when:
- close by
- target already familiar
- required items already carried
- drop-off near next likely task

This improves realism and colony throughput.

## 6.12 Condition penalty

Even if a task is feasible, body state can reduce its score.

### Common penalties
- fatigue
- sleep debt
- low calories
- dehydration
- cold/wetness
- pain
- fear/stress
- sadness/grief
- sickness

---

# 7. Hard blockers vs soft penalties

## 7.1 Hard blockers

Use for rules that should not be negotiated.

Examples:
- unconscious
- no path
- no tool that is absolutely required
- forbidden by quarantine
- wrong worker category for critical hazard job
- target destroyed or already consumed
- cannot carry required mass at all

## 7.2 Soft penalties

Use for rules where humans *can* attempt the task, but it is a bad idea.

Examples:
- very tired
- very unhappy
- low skill
- bad weather
- darkness
- moderate fear
- low interest
- social conflict with coworker

This distinction is important. It allows desperate behavior without making NPCs stupid all the time.

---

# 8. Special self-preservation tasks

These tasks should always exist, even when the player issues no orders.

## 8.1 Body-maintenance tasks
- drink
- eat
- sleep
- rest briefly
- warm self
- dry off
- use latrine zone
- wash hands/body later when implemented
- self-bandage
- seek medicine/help

## 8.2 Safety tasks
- flee immediate hazard
- move to shelter
- move away from fire spread
- regroup with colony
- seek guarded area later

## 8.3 Social stabilization tasks
- seek company if isolation and stress are severe
- check on bonded person if crisis flag exists
- ask for help if confidence and capacity are too low

Social connection matters enough to justify this category, though it should be light in the first playable. citeturn976221view4turn828549search3

---

# 9. Early-game task categories

These are the categories the first playable should support.

## 9.1 Survival core
- fetch water
- drink water
- gather fuelwood
- tend fire
- gather edible plants
- inspect traps
- cook food
- dry food
- smoke food
- sleep
- warm self
- seek shelter

## 9.2 Camp stabilization
- build lean-to segment
- move bedding material
- clean sleeping area
- move food to safer storage
- move tools to cache
- make cordage
- make basket
- shape digging stick

## 9.3 Sanitation and safety
- remove carcass waste
- dump refuse to waste zone
- dig latrine pit
- cover waste
- move spoiled food away
- drain puddle / improve dry footing later

## 9.4 Early craft tasks
- scrape hide
- soften hide
- sew wrap
- collect clay
- prepare clay
- shape vessel
- dry vessel
- fire simple pot

## 9.5 Early land use
- collect seeds
- sort seeds
- clear patch
- till small patch
- plant seeds
- water garden if used
- weed patch
- protect patch from animals

---

# 10. Role of player control

## 10.1 What the player controls

The player should control:
- overall priorities
- allowed and forbidden work
- emergency overrides
- where buildings and zones exist
- which jobs are queued
- who is assigned as primary role
- training targets
- stockpile and storage rules

## 10.2 What the NPC controls

The NPC should control:
- exact moment-to-moment choice among feasible tasks
- whether their body state forces interruption
- route-level opportunism if allowed
- whether they need recovery first

This creates the right colony-management feeling.

---

# 11. Suggested runtime evaluation order

A practical update cycle for each NPC:

1. refresh body-state penalties
2. check immediate danger
3. generate self-preservation tasks
4. gather external candidate tasks
5. filter hard blockers
6. score remaining tasks
7. choose best task
8. reserve resources/targets
9. execute
10. re-check interruption triggers at intervals

Do not re-score everything every frame if avoidable.
Use sensible intervals and event-triggered refreshes.

---

# 12. Example scoring pseudocode

```text
for each npc:
    update_condition(npc)

    if immediate_danger(npc):
        choose_escape_or_shelter_task()
        continue

    candidate_tasks = []
    candidate_tasks += generate_self_preservation_tasks(npc)
    candidate_tasks += gather_available_world_tasks(npc)

    best_task = null
    best_score = -INF

    for task in candidate_tasks:
        if not feasible(npc, task):
            continue

        score = 1.0
        score *= survival_override(npc, task)
        score *= safety_multiplier(npc, task)
        score *= success_expectation(npc, task)
        score *= access_efficiency(npc, task)
        score *= condition_penalty(npc, task)

        score += urgency(npc, task)
        score += colony_need(task)
        score += player_priority(task)
        score += role_fit(npc, task)
        score += interest_bonus(npc, task)
        score += training_value(npc, task)
        score += social_pull(npc, task)

        if score > best_score:
            best_score = score
            best_task = task

    if best_task == null:
        best_task = choose_safe_idle_or_rest_task(npc)

    assign(best_task)
```

---

# 13. Example cases

## 13.1 Example A — thirsty NPC ordered to gather wood

### State
- player priority on fuel = high
- NPC is moderately tired
- NPC hydration is critically low
- water source is near

### Expected result
The NPC should interrupt wood gathering, drink or fetch water, then resume colony work.

## 13.2 Example B — skilled crafter in cold rain

### State
- high pottery skill
- low cold tolerance
- clothing wet
- external order to shape vessels
- hearth is low and shelter incomplete

### Expected result
If body temperature risk is rising, the NPC should prefer warming/drying or shelter-fortifying work first.

## 13.3 Example C — low-skill learner near trainer

### State
- basketry interest high
- basketry skill low
- trainer nearby
- camp already somewhat stable

### Expected result
The task score for basketry practice should rise because of training value and interest.

## 13.4 Example D — sanitation dislike vs outbreak risk

### State
- NPC dislikes waste tasks
- camp filth high
- disease risk rising
- no one else available

### Expected result
The NPC may still do the work because colony need and urgency outweigh dislike.

---

# 14. Tuning principles

## 14.1 The system should produce believable imperfection

NPCs should sometimes make suboptimal but understandable choices.

Sources of imperfect behavior:
- low knowledge
- overconfidence or low confidence
- fatigue
- stress
- poor visibility
- bad mood
- conflicting goals
- incomplete information

## 14.2 Avoid chaos from too much randomness

Use small noise, not wild randomness.
The player should be able to learn the system.

## 14.3 Avoid total obedience

Do not let player priority erase:
- thirst
- sleep collapse
- freezing risk
- pain
- fear
- medical emergency

That would destroy the realism of embodied NPCs.

## 14.4 Avoid excessive self-care loops

Needs tasks should have hysteresis / cooldown logic so NPCs do not constantly micro-switch:
- drink once enough, not every few seconds
- sleep until real recovery threshold
- warm until sufficiently safe, not perfectly comfortable every time

---

# 15. Godot implementation notes

## 15.1 Keep task templates data-driven

Task types should live in data definitions rather than giant if/else blocks.

Each task template should define:
- required tools
- related skills
- relevant needs satisfied
- exertion level
- attention demand
- precision demand
- danger tags
- duration formula hooks
- quality formula hooks

## 15.2 Separate generation from scoring

- **task generation system** creates possible jobs
- **task scoring system** evaluates jobs per NPC
- **task execution system** performs chosen job

This separation will keep the project maintainable.

## 15.3 Log score breakdowns for debugging

For any chosen task, log:
- urgency contribution
- colony need contribution
- player priority contribution
- role fit contribution
- interest contribution
- safety multiplier
- success expectation
- condition penalties

Without this, tuning will be painful.

---

# 16. First playable subset

The first playable does not need the full eventual evaluation system, but it should use the same architecture.

## 16.1 Must-have scoring factors for first playable
- feasibility
- thirst/hunger/fatigue override
- cold/wetness safety check
- urgency
- player priority
- skill effect
- interest effect
- distance/travel time

## 16.2 Good first-playable tasks
- drink
- fetch water
- gather branches
- gather stones
- gather edible plants
- tend fire
- sleep
- build simple shelter
- cook food
- dry food
- move items to cache
- clean immediate camp filth

## 16.3 Can wait until later
- deep social pull scoring
- advanced training logic
- mentor weighting
- district optimization
- multi-building industrial assignment
- shift rosters
- advanced childcare or healthcare duties

---

# 17. Short conclusion

The task evaluation system is where your colony game either becomes believable or turns into generic worker automation.

The correct foundation is:

- player sets intent
- world generates opportunities and pressures
- NPC body state creates urgent internal tasks
- feasibility and safety filter possibilities
- scoring weighs urgency, colony need, player priority, role fit, interest, skill, and condition
- NPC chooses the best currently sensible task

That gives you NPCs who feel like:
- useful colony members
- imperfect humans
- trainable specialists
- self-preserving agents

and not like robotic resource drones.

---

# References and grounding

## Prior project documents
- `realistic_idle_city_design_v1.md`
- `realistic_idle_city_early_game_bible_v0_2.md`
- `realistic_idle_city_npc_simulation_spec_v0_1.md`
- `realistic_idle_city_npc_data_schema_v0_1.md`

## Research grounding used for this task spec
- CDC / NIOSH material on sleep deprivation and performance
- CDC / NCHS material on water intake and dehydration risk
- CDC material on social connection and resilience
- Self-Determination Theory literature on autonomy, competence, and relatedness
- stress/arousal literature often summarized through the Yerkes-Dodson framework
- deliberate practice literature for structured learning value

These sources are used as grounding for system behavior, not as a claim that the game should perfectly model laboratory psychology.
