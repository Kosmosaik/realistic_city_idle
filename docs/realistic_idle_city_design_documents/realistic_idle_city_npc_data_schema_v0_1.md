---
title: "Realistic Incremental/Idle Colony-to-City Game - NPC Data Sheet / Schema"
version: "v0.1 - research-backed working draft"
date: "2026-04-07"
status: "working draft"
based_on:
  - "realistic_idle_city_design_v1.md"
  - "realistic_idle_city_early_game_bible_v0_2.md"
  - "realistic_idle_city_npc_simulation_spec_v0_1.md"
author: "OpenAI / ChatGPT"
project_notes:
  - "Realism-first, research-backed"
  - "Top-down minimal visuals in Godot"
  - "Player gives orders, priorities, restrictions, and policies"
  - "NPCs are autonomous but bounded by needs, mood, skill, and circumstances"
  - "Interest, aptitude, and skill remain separate systems"
---

# NPC Data Sheet / Schema v0.1

## Purpose of this document

This document converts the broad NPC simulation ideas into a **practical, implementation-facing data schema**.

The goal is to answer:

- What data should exist on every NPC record?
- Which values should be saved permanently, and which should be derived at runtime?
- How should personality, interests, aptitudes, skills, health, social ties, and work preferences be stored?
- What is the **minimum viable NPC record** for the first playable?
- How can this be structured in a way that stays realistic while still being usable in Godot?

This is not just a list of possible stats.
It is a proposal for the **canonical NPC record** that other systems will read:

- task evaluation
- pathing and locomotion
- needs decay
- morale
- learning and skill gain
- injuries and illness
- equipment and clothing
- social simulation
- recruitment and settlement roles

---

# 1. Design stance

## 1.1 What the schema is for

The schema should make it possible to represent an NPC as:

- a body with real needs and limits
- a mind with temperament and motivation
- a worker with uneven competencies
- a colony member with social ties and obligations
- a learner whose behavior changes through practice
- a person whose condition affects judgment, speed, errors, and morale

The schema should **not** assume that all NPCs are generic workers with only:

- work speed
- carry weight
- happiness

That would break the project’s core realism.

## 1.2 Design rules

The schema should follow these rules:

1. **Stable things are stored.**  
   Traits, aptitudes, interests, scars, relationships, and long-term knowledge belong in saved data.

2. **Fast-changing things are updated often.**  
   Hunger, thirst, fatigue, body temperature, pain, mood, and current task are runtime-heavy state.

3. **Expensive calculations should become derived values.**  
   Effective carry capacity, task success chance, heat stress penalty, or “best current role fit” should usually be calculated from base fields rather than saved directly.

4. **Interest, aptitude, and skill remain separate.**  
   They do different jobs in the simulation.

5. **Human limitations matter.**  
   Sleep loss degrades attention, reaction time, reasoning, and decision quality; poor hydration and heat strain can reduce physical and mental performance; strong social connection supports health and resilience; and motivation is helped when people feel some autonomy, competence, and connection. These are useful anchors for the simulation, even though the game remains an abstraction. citeturn976221view0turn976221view1turn976221view4turn412551search3

---

# 2. Schema overview

Every NPC record should be split into the following top-level sections:

1. **Identity**
2. **Demographics and body baseline**
3. **Dynamic body state**
4. **Personality and temperament**
5. **Interests**
6. **Aptitudes**
7. **Skills**
8. **Knowledge and familiarity**
9. **Preferences and tolerances**
10. **Social ties**
11. **Role and labor state**
12. **Inventory / equipment / clothing**
13. **Health history**
14. **Behavioral flags and permissions**
15. **Memory, goals, and current context**
16. **Derived runtime fields**

A good rule is:

- sections 1–13 are mostly save data
- sections 14–16 are mostly runtime or partly cached

---

# 3. Core data model

## 3.1 Identity

These fields answer: *who is this NPC as a unique entity?*

### Required fields
- `npc_id` — unique persistent ID
- `display_name`
- `short_name` or nickname if used in UI
- `sex` or body-sex classification if simulated
- `age_years`
- `birth_season_day` if births matter later
- `origin_type` — starter / migrant / rescued / born_here / trader / prisoner / visitor
- `origin_notes` — optional text or tag list
- `portrait_seed` — for deterministic visual variation even if visuals are minimal
- `spawn_world_seed_offset`

### Optional later fields
- family name / lineage
- clan / household ID
- legal status / citizenship / contract status
- literacy ID / schooling history

## 3.2 Demographics and body baseline

These fields describe the NPC’s *longer-term physical baseline*, not current needs.

### Required fields
- `height_class`
- `body_mass_baseline`
- `frame_size`
- `dominant_hand`
- `baseline_strength`
- `baseline_endurance`
- `baseline_dexterity`
- `baseline_balance`
- `baseline_vision`
- `baseline_hearing`
- `baseline_cold_tolerance`
- `baseline_heat_tolerance`
- `baseline_disease_resistance`
- `baseline_pain_tolerance`
- `baseline_sleep_need`
- `baseline_recovery_rate`

### Why this matters
These values help separate:
- a naturally sturdy laborer
- a frail but careful crafter
- a quick but poor endurance scout
- an older skilled worker with reduced recovery

These are not skills. They are biological baselines.

## 3.3 Dynamic body state

These fields change frequently and should be central to behavior.

### Essential early-game fields
- `calorie_reserve`
- `hydration`
- `fatigue`
- `sleep_debt`
- `body_temperature_state`
- `wetness`
- `pain`
- `blood_loss`
- `injury_load`
- `illness_load`
- `stomach_fill`
- `bowel_pressure`
- `bladder_pressure`
- `stress_arousal`
- `current_energy`

### Good early-game supporting fields
- `last_meal_time`
- `last_drink_time`
- `last_sleep_start`
- `last_sleep_quality`
- `hours_awake`
- `exertion_recent`
- `ambient_exposure_risk`
- `infection_risk`

### Why this matters
Sleep and fatigue should not be cosmetic. Sleep loss impairs sustained attention, slows response time, and increases mistakes, especially under time pressure. citeturn976221view0turn976221view7

Hydration should not be a flat timer only. Inadequate water intake is associated with dehydration risk and poorer cognitive performance, while heat strain and dehydration can reduce physical and mental performance. citeturn976221view1turn412551search22

## 3.4 Personality and temperament

This section describes *how the NPC tends to react*.

The game does not need a clinical psychology simulator, but it should benefit from a stable temperament model. A Big Five-style framework is useful because it captures broad, well-studied trait domains such as extraversion, agreeableness, conscientiousness, neuroticism/emotional stability, and openness to experience. citeturn412551search0turn412551search8

### Recommended stored trait axes
- `conscientiousness`
- `caution`
- `curiosity`
- `sociability`
- `agreeableness`
- `emotional_stability`
- `persistence`
- `novelty_seeking`
- `tidiness`
- `risk_tolerance`
- `frustration_tolerance`
- `assertiveness`
- `patience`
- `independence`
- `obedience_to_policy`

### Notes
- Some of these map loosely to Big Five domains.
- Some are game-facing derived subtraits rather than direct psychology labels.
- This is intentional: the model should be human-readable and useful in simulation.

## 3.5 Interests

Interests answer:
> What kinds of work or subjects does this NPC naturally want to engage with?

Interest should mainly affect:
- willingness to start a task
- boredom resistance
- morale during repeated work
- learning speed
- tendency to self-select related tasks when allowed

### Recommended interest categories

#### Survival / land interests
- `plants`
- `wild_foods`
- `animals`
- `fishing`
- `tracking`
- `weather`
- `exploration`
- `navigation`

#### Domestic / camp interests
- `cooking`
- `cleaning`
- `organizing`
- `repairing`
- `caretaking`
- `medicine`
- `childcare`
- `textiles`
- `clothing`

#### Making / technical interests
- `woodworking`
- `stonework`
- `pottery`
- `leatherwork`
- `weaving`
- `metalwork`
- `machines`
- `measurement`
- `quality_control`

#### Social / institutional interests
- `teaching`
- `recordkeeping`
- `trade`
- `leadership`
- `ritual`
- `conflict_resolution`
- `guarding`
- `planning`

#### Aesthetic / curiosity interests
- `beautification`
- `music`
- `storytelling`
- `craft_detail`
- `experimentation`
- `collecting`

## 3.6 Aptitudes

Aptitudes answer:
> If this NPC practices, what kinds of work are they naturally better suited to?

Aptitude should mainly affect:
- rate of improvement ceiling
- error rate
- efficiency ceiling
- consistency under difficulty

### Recommended aptitude categories

#### Physical aptitudes
- `lifting_power`
- `stamina_for_labor`
- `fine_motor_control`
- `gross_motor_control`
- `hand_eye_precision`
- `footing_balance`

#### Cognitive aptitudes
- `working_memory`
- `spatial_reasoning`
- `procedural_memory`
- `numeracy`
- `pattern_recognition`
- `problem_solving`
- `attention_control`

#### Social aptitudes
- `teaching_ability`
- `leadership`
- `soothing`
- `negotiation`
- `team_coordination`

#### Specialized aptitudes
- `mechanical_reasoning`
- `botanical_reasoning`
- `animal_handling`
- `craft_precision`
- `diagnostic_reasoning`
- `logistics_planning`

## 3.7 Skills

Skills answer:
> What can this NPC currently do with actual competence?

Skills should be broad in the database, even if the first playable uses only a smaller subset.

Each skill entry should include at least:
- `level`
- `xp` or practice exposure
- `last_used`
- `confidence`
- `formal_training_level`
- `self_taught_fraction`
- `failure_memory`
- `quality_tendency`

### Suggested skill taxonomy

#### Core survival
- foraging
- water_collection
- firemaking
- fuel_selection
- shelter_building
- bedding_prep
- camp_layout
- hauling
- knotting
- cordage_making
- primitive_toolmaking
- stone_knapping
- digging
- observation
- hazard_spotting

#### Food acquisition
- trapping
- tracking
- spear_hunting
- bow_hunting
- fishing
- butchery
- hide_removal
- bone_processing
- fat_rendering
- gathering_shellfish

#### Food processing and preservation
- roasting
- boiling
- smoking
- drying
- fermenting
- grinding
- seed_cleaning
- storage_prep
- rationing
- spoilage_detection

#### Domestic survival
- cooking
- washing
- sanitation
- waste_management
- water_boiling
- basic_first_aid
- nursing
- patient_watching

#### Early materials
- basketry
- mat_weaving
- hide_scraping
- hide_softening
- tanning_basics
- sewing
- patching
- pottery_handbuilding
- clay_selection
- pit_firing
- wood_splitting
- rough_carpentry

#### Early land use
- seed_saving
- garden_tending
- soil_preparation
- hoe_use
- transplanting
- crop_watch
- weed_control
- pest_control
- harvest_timing

#### Animal work
- calming_animals
- feeding_livestock
- pen_cleaning
- milking
- shearing
- herding
- breeding_management
- slaughtering

#### Construction
- stake_setting
- post_setting
- wall_wattle_work
- roof_thatching
- mud_plastering
- trenching
- drainage_work
- fencing
- storage_building

#### Craft branches
- spinning
- weaving
- loom_use
- leatherwork
- carving
- joinery
- wheelmaking
- smithing
- charcoal_burning
- ore_sorting
- bloom_working
- casting
- masonry
- lime_burning
- brickmaking
- glassworking

#### Administrative / social
- counting
- stockkeeping
- scheduling
- teaching
- persuading
- mediation
- guarding
- leadership
- trading
- bookkeeping

#### Mechanical / industrial later
- machine_operation
- lubrication
- inspection
- fitting
- machining
- electrical_work
- engine_maintenance
- chemistry
- lab_testing
- quality_assurance

### Storage recommendation
Store skills in a dictionary keyed by skill ID rather than as hard-coded properties.

Example:

```json
"skills": {
  "foraging": {"level": 14, "xp": 238.2, "confidence": 0.68, "formal_training": 0},
  "water_collection": {"level": 9, "xp": 91.0, "confidence": 0.80, "formal_training": 0},
  "firemaking": {"level": 6, "xp": 51.3, "confidence": 0.40, "formal_training": 0}
}
```

## 3.8 Knowledge and familiarity

Skills are not the same as knowledge.

An NPC may know *that* clay exists nearby without being good at pottery.
An NPC may know that smoked meat lasts longer without being especially skilled at preserving it.

### Recommended knowledge fields
- `known_materials`
- `known_sites`
- `known_hazards`
- `known_recipes`
- `known_procedures`
- `known_people`
- `known_animals`
- `known_plants`
- `known_storage_rules`
- `known_social_rules`
- `known_building_blueprints`
- `known_machine_procedures` later

### Familiarity values
Each knowledge item should have:
- `known` yes/no
- `familiarity_score`
- `confidence`
- `learned_from` (self / teacher / book / observation / rumor)
- `verified` yes/no

This supports realistic situations like:
- uncertain mushroom knowledge
- partly remembered shelter procedure
- incorrect rumor about safe water source

## 3.9 Preferences and tolerances

These fields create believable variation without needing huge drama systems.

### Examples
- preferred foods
- disliked foods
- smoke tolerance
- dirt tolerance
- cold dislike
- heat dislike
- preferred sleep quality threshold
- privacy need
- social contact need
- preferred work rhythm
- night-owl / dawn-riser tendency
- tolerance for repetitive labor
- tolerance for blood / carcasses
- tolerance for foul smells
- tolerance for confinement

These values help make two equally skilled NPCs behave differently.

## 3.10 Social ties

Humans are social. Social connection supports resilience, stress handling, health, sleep quality, and community stability. citeturn976221view4turn828549search12

### Required fields
- `household_id`
- `bond_map`
- `trust_map`
- `resentment_map`
- `respect_map`
- `dependency_map`
- `teacher_student_links`
- `romantic_partner_id` if any
- `children_ids` later
- `grief_flags`

### Per-relationship structure
For each known NPC:
- familiarity
- trust
- affection
- tension
- perceived_competence
- felt_safety
- obligation
- recent_positive_events
- recent_negative_events

## 3.11 Role and labor state

This section stores the NPC’s place in the colony economy.

### Recommended fields
- `primary_role`
- `secondary_roles`
- `work_tags_allowed`
- `work_tags_forbidden`
- `manual_priorities`
- `training_targets`
- `certifications` later
- `assigned_workplace_id`
- `assigned_district_id`
- `shift_template`
- `emergency_role`
- `leadership_chain_id`
- `current_employment_status` — colonist / visitor / apprentice / patient / prisoner / child

## 3.12 Inventory, clothing, and equipment

This section matters a lot in a realism-first game.

### Equipment slots
- head
- torso_inner
- torso_outer
- legs
- feet
- hands
- back
- belt
- neck
- tool_main_hand
- tool_off_hand
- carried_container
- water_container
- fire_kit
- utility_slot_1..n

### Condition fields
Each equipped item should expose:
- item ID
- material
- quality
- durability
- insulation
- water resistance
- encumbrance
- contamination state
- warmth contribution
- task bonuses/penalties

## 3.13 Health history

This section stores lasting changes.

### Recommended fields
- old fractures
- scars
- chronic pain flags
- disease history
- parasite flags
- missing teeth / tooth pain later if wanted
- old burns
- recurring injuries
- fertility / pregnancy later if simulated
- allergy flags if used
- disability / impairment flags

## 3.14 Behavioral flags and permissions

These fields are simple but important.

### Examples
- `can_self_assign_tasks`
- `can_leave_safe_zone`
- `can_hunt_large_animals`
- `can_use_fire`
- `can_handle_raw_meat`
- `can_handle_medicine`
- `can_use_tools_above_tier_X`
- `can_train_others`
- `must_be_supervised_for_task_tags`
- `quarantine_restricted`
- `bed_rest_only`

## 3.15 Memory, goals, and current context

These fields sit between deep psychology and moment-to-moment AI.

### Recommended fields
- `current_goal`
- `current_task_id`
- `current_target_id`
- `recent_failures`
- `recent_successes`
- `recent_threats`
- `current_mood_drivers`
- `active_promises`
- `scheduled_commitments`
- `unmet_needs_alerts`
- `last_known_safe_water_source`
- `last_known_sleep_spot`
- `last_known_tool_cache`

## 3.16 Derived runtime fields

These should usually not be saved permanently unless caching is needed.

### Examples
- effective_move_speed
- effective_carry_capacity
- current_error_rate_modifier
- current_attention_stability
- current_hand_steadiness
- social_buffer_bonus
- morale_trend
- role_fit_score
- best_task_category_now
- sickness_spread_risk
- thermal_risk_now
- predicted_task_success

---

# 4. Field definitions and scales

## 4.1 Use normalized internal ranges where possible

Recommended internal conventions:

- 0.0 to 1.0 for many state values
- integers for age and IDs
- dictionaries for skills/interests/aptitudes
- enums for categorical statuses
- timestamps in world minutes or ticks

### Example
- hydration 1.0 = fully hydrated
- hydration 0.5 = meaningful performance penalty begins
- hydration 0.2 = severe risk zone

The exact thresholds should remain tunable in game rules, not hardcoded in NPC records.

## 4.2 Keep raw values and interpreted states separate

Good example:

- `hydration = 0.41`
- `hydration_state = "dehydrated"`

The first is useful for math.
The second is useful for UI, debugging, and rules.

---

# 5. Recommended Godot structure

## 5.1 Recommended implementation model

Use a primary `NPCData` resource or script-backed data object with nested components.

### Suggested structure
- `IdentityBlock`
- `BodyBaselineBlock`
- `BodyStateBlock`
- `PersonalityBlock`
- `InterestBlock`
- `AptitudeBlock`
- `SkillBlock`
- `KnowledgeBlock`
- `SocialBlock`
- `LaborBlock`
- `EquipmentBlock`
- `HealthHistoryBlock`
- `BehaviorFlagsBlock`
- `RuntimeContextBlock`

This is better than one gigantic flat file because it keeps the project maintainable.

## 5.2 Suggested serialization principle

Save:
- stable fields
- slow-changing progression values
- relationship states
- health history
- learned knowledge

Do not over-save:
- every pathing detail
- transient score calculations
- low-value cached evaluation outputs

---

# 6. Minimum viable schema for first playable

For the first playable, you do **not** need the entire eventual schema active.
But the full structure should still exist conceptually so the prototype grows in the right direction.

## 6.1 Minimum required sections

### Identity
- npc_id
- display_name
- age_years
- origin_type

### Body baseline
- baseline_strength
- baseline_endurance
- baseline_dexterity
- baseline_cold_tolerance
- baseline_heat_tolerance
- baseline_recovery_rate

### Dynamic body state
- calorie_reserve
- hydration
- fatigue
- sleep_debt
- body_temperature_state
- wetness
- pain
- illness_load

### Personality
- conscientiousness
- caution
- curiosity
- sociability
- emotional_stability
- patience

### Interests
- plants
- animals
- exploration
- cooking
- organizing
- repairing
- woodworking
- pottery
- leatherwork
- teaching

### Aptitudes
- lifting_power
- stamina_for_labor
- fine_motor_control
- working_memory
- spatial_reasoning
- craft_precision
- problem_solving

### Skills
- foraging
- water_collection
- firemaking
- shelter_building
- hauling
- primitive_toolmaking
- cooking
- drying
- smoking
- basketry
- sewing
- hide_scraping
- clay_selection
- pottery_handbuilding
- pit_firing
- seed_saving
- garden_tending
- sanitation
- basic_first_aid

### Social
- trust_map
- affection_map
- respect_map

### Labor
- primary_role
- work_tags_allowed
- work_tags_forbidden
- manual_priorities
- training_targets

### Equipment
- clothing slots
- tool slots
- carried container
- water container

### Runtime
- current_goal
- current_task_id
- current_target_id
- recent_failures
- current_mood_drivers

---

# 7. Suggested schema for interests, aptitudes, and skills

## 7.1 Interest record

```json
"woodworking": {
  "level": 0.82,
  "hidden": false,
  "discovered": true,
  "notes": []
}
```

### Interpretation
- 0.00–0.20 = avoids when possible
- 0.21–0.40 = dislikes / low willingness
- 0.41–0.60 = neutral
- 0.61–0.80 = enjoys
- 0.81–1.00 = strongly drawn to

## 7.2 Aptitude record

```json
"craft_precision": {
  "level": 0.74,
  "stability": 0.68
}
```

### Interpretation
- affects quality ceiling
- affects error rate
- affects learning efficiency for related skills

## 7.3 Skill record

```json
"foraging": {
  "level": 12,
  "xp": 223.4,
  "confidence": 0.71,
  "formal_training": 0,
  "self_taught_fraction": 1.0,
  "last_used_tick": 14820,
  "rust": 0.03
}
```

### Interpretation
- `level` = usable competence tier
- `xp` = practice accumulation
- `confidence` = willingness to attempt hard variants
- `formal_training` = institutional training depth
- `rust` = temporary reduction from disuse

---

# 8. Example canonical NPC record

```json
{
  "npc_id": "npc_0001",
  "display_name": "Edda",
  "age_years": 27,
  "origin_type": "starter",
  "identity": {
    "sex": "female",
    "dominant_hand": "right"
  },
  "body_baseline": {
    "baseline_strength": 0.54,
    "baseline_endurance": 0.68,
    "baseline_dexterity": 0.63,
    "baseline_cold_tolerance": 0.47,
    "baseline_heat_tolerance": 0.61,
    "baseline_recovery_rate": 0.58
  },
  "body_state": {
    "calorie_reserve": 0.46,
    "hydration": 0.62,
    "fatigue": 0.31,
    "sleep_debt": 0.18,
    "body_temperature_state": "cool",
    "wetness": 0.22,
    "pain": 0.05,
    "illness_load": 0.00,
    "stress_arousal": 0.42
  },
  "personality": {
    "conscientiousness": 0.74,
    "caution": 0.58,
    "curiosity": 0.69,
    "sociability": 0.36,
    "emotional_stability": 0.55,
    "patience": 0.72,
    "tidiness": 0.67,
    "risk_tolerance": 0.41
  },
  "interests": {
    "plants": {"level": 0.88},
    "woodworking": {"level": 0.66},
    "cooking": {"level": 0.61},
    "pottery": {"level": 0.22},
    "trade": {"level": 0.13},
    "teaching": {"level": 0.48}
  },
  "aptitudes": {
    "stamina_for_labor": {"level": 0.71},
    "fine_motor_control": {"level": 0.60},
    "working_memory": {"level": 0.57},
    "spatial_reasoning": {"level": 0.64},
    "craft_precision": {"level": 0.51},
    "problem_solving": {"level": 0.67}
  },
  "skills": {
    "foraging": {"level": 11, "xp": 190.0, "confidence": 0.73},
    "water_collection": {"level": 10, "xp": 140.2, "confidence": 0.81},
    "firemaking": {"level": 5, "xp": 39.0, "confidence": 0.34},
    "shelter_building": {"level": 6, "xp": 52.6, "confidence": 0.49},
    "hauling": {"level": 8, "xp": 92.1, "confidence": 0.75},
    "cooking": {"level": 4, "xp": 31.4, "confidence": 0.44}
  },
  "knowledge": {
    "known_sites": ["stream_01", "deadwood_patch_02"],
    "known_materials": ["green_branch", "dry_branch", "round_stone", "clay_pocket"],
    "known_procedures": ["boil_water_basic", "lean_to_basic"],
    "known_hazards": ["thorn_patch_03"]
  },
  "social": {
    "household_id": "household_01",
    "trust_map": {},
    "respect_map": {},
    "affection_map": {}
  },
  "labor": {
    "primary_role": "general_survivor",
    "secondary_roles": ["forager", "water_hauler"],
    "work_tags_allowed": ["survival", "gathering", "camp"],
    "work_tags_forbidden": [],
    "manual_priorities": {
      "water": 1.0,
      "food": 0.9,
      "shelter": 0.8,
      "cleanup": 0.4
    }
  },
  "equipment": {
    "head": null,
    "torso_outer": null,
    "legs": null,
    "feet": null,
    "tool_main_hand": null,
    "carried_container": null,
    "water_container": null
  },
  "runtime": {
    "current_goal": "stabilize_camp",
    "current_task_id": "task_fetch_water_12",
    "current_target_id": "stream_01",
    "recent_failures": [],
    "current_mood_drivers": ["thirst_rising", "camp_unstable"]
  }
}
```

---

# 9. Generation rules for new NPCs

## 9.1 Creation principles

When generating a new NPC:

1. Generate body baseline.
2. Generate personality/temperament.
3. Generate interests.
4. Generate aptitudes.
5. Generate starting skills based on origin.
6. Generate knowledge based on origin.
7. Generate preferences and tolerances.
8. Generate social predispositions.

## 9.2 Origin templates

### Starter NPC
- broad survival competence
- little formal knowledge
- some practical intuition
- no settlement social ties yet

### Migrant wanderer
- more variable health
- a few stronger learned skills
- personal belongings possible
- origin trauma or fatigue possible

### Rescued NPC
- low immediate body state
- possibly strong latent skills
- trust starts unstable

### Born in settlement later
- more socially embedded
- more narrow but cleaner early training
- higher familiarity with settlement rules

---

# 10. What should remain outside the NPC record

Not every colony fact belongs on the NPC.

Keep these elsewhere:
- building definitions
- item definitions
- process definitions
- world-site data
- global policy rules
- task templates
- settlement-wide knowledge registry
- path grids
- weather systems

The NPC should reference these, not duplicate them.

---

# 11. Recommended debugging views

To make this usable in development, every NPC should have an inspect panel showing:

- current needs and penalties
- current morale drivers
- current task and reason chosen
- interest/aptitude/skill snapshot
- equipment and clothing effects
- relationship summary
- recent failures and injuries
- current derived penalties/bonuses

This will save enormous time when tuning the simulation.

---

# 12. Short conclusion

The NPC schema should be rich because the game’s realism depends on the player managing *people*, not just work rates.

The most important structural decision is to keep these separate:

- **body baseline**
- **body state**
- **personality**
- **interest**
- **aptitude**
- **skill**
- **knowledge**
- **social ties**
- **current labor state**

That separation is what allows the colony to feel believable.

It lets the game represent:
- a tired but skilled worker
- a curious novice
- a strong but sloppy hauler
- a precise but socially difficult craftsperson
- a highly motivated learner
- a sick, grieving, or cold NPC whose work behavior changes for real reasons

That is the correct foundation for the task evaluation system that comes next.

---

# References and grounding

## Prior project documents
- `realistic_idle_city_design_v1.md`
- `realistic_idle_city_early_game_bible_v0_2.md`
- `realistic_idle_city_npc_simulation_spec_v0_1.md`

## Research grounding used for this schema
- CDC / NIOSH, sleep deprivation and performance
- CDC / NCHS, water intake and dehydration risk
- CDC, social connection and health
- Five-Factor personality literature (McCrae & John; Widiger & Oltmanns)
- Self-Determination Theory literature on autonomy, competence, and relatedness
- Deliberate practice literature on skill acquisition

These sources are used as grounding for system design, not as a claim that the game is a literal biomedical simulator.
