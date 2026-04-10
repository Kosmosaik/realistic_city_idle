# Realistic Idle City — Unified Data Dictionary v0.1

## 1. Purpose

This document defines the **canonical naming rules, IDs, enums, shared field names, and family taxonomies**
for the early-game implementation stack.

It exists to stop string drift between:
- design docs
- content definitions
- simulation data
- save data
- UI labels
- Godot resources / scripts

This is a **unification document**, not a new design bible.

It should be treated as the naming and schema authority for the early-game MVP unless a later explicit user instruction overrides it.

---

## 2. Scope

This dictionary is intentionally focused on the first playable slice:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It standardizes:
- content definition IDs
- runtime instance ID rules
- shared enum strings
- shared field names
- early skill IDs
- item / process / structure family names
- common state ladders used across systems

It does **not** define final numeric balance values.
Those belong in the future **Balance / Constants Sheet v0.1**.

---

## 3. Core naming doctrine

### 3.1 Machine-readable names
All canonical machine names should use:

- lowercase
- `snake_case`
- no spaces
- no punctuation except underscore and the existing `stage.*` dot namespace

Examples:
- `water_collection`
- `itm_water_boiled`
- `reserve_class`
- `body_temperature_state`

### 3.2 Player-facing names
Player-facing text should stay separate from machine-readable IDs.

Use:
- `display_name` for UI-facing labels
- `description` for tooltip/body text
- IDs only for code, data, save files, filters, lookups, and debug tools

Example:
- ID: `itm_food_meat_dried_simple`
- display name: `Simple Dried Meat`

### 3.3 Singular by default
Use singular nouns for definition IDs and enum values unless the thing is inherently plural.

Prefer:
- `tool`
- `container`
- `seed`
- `household`

Avoid:
- `tools`
- `containers`
- `seeds`

### 3.4 Stable IDs, mutable presentation
Definition IDs should be treated as stable once introduced.
Display names, descriptions, icons, and sorting can change without breaking save compatibility.

### 3.5 No overloaded fields
Do not use one field for multiple meanings.

Examples:
- `task_def_id` is not the same as `task_id`
- `item_def_id` is not the same as a runtime item instance ID
- `ownership_class` is not the same as `reserve_class`
- `quality_class` is not the same as `condition_state`

### 3.6 Prefer explicit suffixes
Use suffixes consistently:

- `_id` = one ID
- `_ids` = list of IDs
- `_def_id` = content definition ID
- `_state` = mutually exclusive enum state
- `_class` = coarse severity / bucket enum
- `_tags` = unordered tag set
- `_tick` = simulation tick timestamp
- `_score` = normalized evaluation value
- `_ratio` = normalized 0.0–1.0 value
- `_count` = integer count
- `_level` = ordinal progression value
- `_load` = accumulated severity / burden float
- `_flag` = boolean-like semantic flag when `is_` / `has_` is awkward

### 3.7 Booleans
Prefer boolean names starting with:

- `is_`
- `has_`
- `can_`
- `allow_`
- `should_`
- `was_`

Examples:
- `is_standardized`
- `has_container`
- `can_fail_partially`
- `allow_guest_rations`

### 3.8 Time naming
Use simulation time as the authority.

Canonical conventions:
- `created_tick`
- `updated_tick`
- `expires_tick`
- `last_used_tick`
- `last_practiced_tick`
- `last_sleep_start_tick`

Calendar fields can exist separately:
- `day_index`
- `season_id`
- `hour_of_day`

### 3.9 Quantities and units
Use explicit suffixes whenever the unit is not obvious.

Recommended:
- `mass_kg`
- `volume_l`
- `distance_m`
- `duration_ticks`
- `temperature_c` later if needed

If the value is intentionally unitless for tuning, use:
- `_score`
- `_ratio`
- `_load`

### 3.10 Ratios and scores
Use the following default conventions unless a system explicitly needs something else:

- `*_ratio` = `0.0 .. 1.0`
- `*_score` = usually `-1.0 .. 1.0` or `0.0 .. 1.0`, documented per system
- `*_level` = non-negative integer
- `*_load` = non-negative float, open upper bound unless capped by system

---

## 4. Definition IDs vs runtime instance IDs

This is the single most important implementation distinction in this document.

### 4.1 Definition IDs
Definition IDs describe **what kind of thing something is**.

Examples:
- `itm_water_boiled`
- `pro_boil_water_simple`
- `str_shelter_debris_lean_to`
- `kno_seed_not_same_as_food`

Definition IDs are content-authoring IDs and should be stable.

### 4.2 Runtime instance IDs
Runtime instance IDs identify **one actual thing that currently exists in the simulation**.

Examples:
- one particular NPC
- one actual basket on the ground
- one specific shelter
- one task instance created this hour
- one stockpoint zone
- one water pot currently reserved

### 4.3 Canonical rule
Wherever possible, store both:

- a runtime instance ID, such as `item_id`
- and the content definition ID behind it, such as `item_def_id`

Example:
- `item_id = item_000182`
- `item_def_id = itm_container_basket_crude`

### 4.4 Recommended runtime ID prefixes
These are now canonical for implementation-facing work:

- `npc_` — NPC instance
- `item_` — item instance
- `structure_` — placed structure instance
- `container_` — container instance if split from generic item handling
- `stockpoint_` — stockpoint / reserve node instance
- `zone_` — zone instance
- `task_` — task instance
- `settlement_` — settlement instance
- `household_` — household instance
- `event_` — event / incident runtime instance
- `rel_` — relationship record instance if independently stored
- `route_` — cached route or route preference instance
- `claim_` — claim / reservation / assignment record instance

### 4.5 Canonical field split
Use this pattern consistently:

- `item_id` = runtime instance
- `item_def_id` = content definition

Likewise:
- `structure_id` / `structure_def_id`
- `task_id` / `task_def_id`
- `zone_id` / `zone_type_id`
- `knowledge_id` remains the definition ID because knowledge instances are keyed by `npc_id + knowledge_id`

---

## 5. Canonical definition ID namespaces

The early content pack already established the core definition prefixes.
This document makes them authoritative.

### 5.1 Stage IDs
Use dot namespace for settlement stages:

- `stage.start`
- `stage.lone_survivor`
- `stage.primitive_camp`
- `stage.permanent_camp`
- `stage.tiny_hamlet`

### 5.2 Content definition prefixes

| Prefix | Meaning | Example |
|---|---|---|
| `itm_` | item definition | `itm_water_raw_clear` |
| `pro_` | process definition | `pro_boil_water_simple` |
| `str_` | structure definition | `str_fire_hearth_stone_small` |
| `tsk_` | task definition | `tsk_fetch_water` |
| `kno_` | knowledge definition | `kno_fire_tinder_selection` |
| `pol_` | policy definition | `pol_reserve_seed_lock` |
| `inc_` | incident definition | `inc_food_spoilage_small` |
| `alt_` | alert definition | `alt_water_reserve_low` |
| `need_` | need tag / need definition | `need_hydration` |
| `haz_` | hazard definition | `haz_cold_wet_exposure` |
| `role_` | role definition | `role_water_keeper` |
| `zone_type_` | zone type definition | `zone_type_latrine` |
| `reserve_` | reserve bucket definition | `reserve_seed` |

### 5.3 Canonical ID formatting rule
Use:

`<prefix><domain_or_group>_<specific_name>`

Examples:
- `itm_food_meat_cooked`
- `pro_store_seed_protected`
- `str_storage_seed_cache_protected`
- `kno_clean_container_matters`

### 5.4 Reserved future compatibility
These prefixes are reserved now even if lightly used in MVP code:

- `recipe_`
- `trait_`
- `apt_`
- `interest_`
- `weather_`
- `terrain_`

Do not use these casually for unrelated objects.

---

## 6. Shared field dictionary

This section defines field names that multiple systems should share instead of inventing near-duplicates.

### 6.1 Identity and references

| Field | Meaning |
|---|---|
| `id` | only for internal generic helpers; avoid in saved content where type matters |
| `npc_id` | one NPC runtime instance |
| `item_id` | one runtime item instance |
| `item_def_id` | one item definition ID |
| `structure_id` | one runtime structure instance |
| `structure_def_id` | one structure definition ID |
| `task_id` | one runtime task instance |
| `task_def_id` | one task definition ID |
| `knowledge_id` | one knowledge definition ID |
| `policy_id` | one policy definition ID |
| `zone_id` | one runtime zone instance |
| `zone_type_id` | zone type definition ID |
| `stockpoint_id` | one runtime stockpoint instance |
| `settlement_id` | one settlement runtime instance |
| `household_id` | one household runtime instance |

### 6.2 Time and lifecycle

| Field | Meaning |
|---|---|
| `created_tick` | time created |
| `updated_tick` | time last materially updated |
| `expires_tick` | time after which the record is invalid |
| `completed_tick` | time completed |
| `last_used_tick` | last meaningful use |
| `last_practiced_tick` | last practice for skill/knowledge |
| `last_taught_tick` | last teaching episode |
| `last_meal_tick` | last meal |
| `last_drink_tick` | last drink |
| `last_sleep_start_tick` | start of last sleep period |
| `last_sleep_end_tick` | end of last sleep period |

### 6.3 Spatial and world references

| Field | Meaning |
|---|---|
| `position` | current world position |
| `target_position` | intended target position |
| `home_position` | preferred default return location |
| `worksite_id` | runtime worksite or work-location anchor |
| `source_entity_id` | source object/entity |
| `destination_entity_id` | destination object/entity |
| `pickup_entity_ids` | runtime items/containers to collect from |
| `dropoff_entity_id` | legacy-compatible destination field; prefer `destination_entity_id` in new work |
| `assigned_district_id` | later district reference |
| `path_tags_required` | tags required to use or prefer a route |

### 6.4 Classification and labeling

| Field | Meaning |
|---|---|
| `category` | broad family |
| `subcategory` | narrower family |
| `domain` | system domain such as `water`, `fire`, `hide`, `seed` |
| `role_tags` | work/role alignment tags |
| `need_tags` | needs touched by an item/process/task |
| `hazard_tags` | hazard types present |
| `access_tags` | permissions / access labels |
| `storage_tags` | storage handling tags |
| `quality_class` | coarse quality bucket |
| `condition_state` | condition enum |
| `contamination_state` | contamination enum |
| `ownership_class` | governance / custody class |
| `reserve_class` | reserve protection class |

### 6.5 Task-related fields

| Field | Meaning |
|---|---|
| `source_type` | why the task exists |
| `task_status` | lifecycle state of task instance |
| `interruptible` | whether a task can be safely interrupted |
| `multi_stage` | whether the task/process has multiple distinct steps |
| `can_fail_partially` | whether partial outcome exists |
| `required_tools` | required tool definition IDs or tags |
| `required_equipment` | required worn/equipped items |
| `required_materials` | input item requirements |
| `required_knowledge` | required or strongly preferred knowledge IDs |
| `required_skills_minimum` | minimum skill thresholds |
| `required_work_tags` | required labor/role tags |
| `forbidden_health_states` | body states that hard-block work |
| `estimated_duration_ticks` | estimated task duration |
| `estimated_exertion` | coarse exertion score |
| `settlement_priority` | settlement-level urgency band |
| `emergency_class` | normal / urgent / emergency / catastrophe |
| `reserved_by` | reserving NPC/task/claim |
| `dependency_task_ids` | tasks that must complete first |

### 6.6 Knowledge-related fields

| Field | Meaning |
|---|---|
| `awareness_state` | how aware an individual is of the knowledge unit |
| `confidence_state` | how trustworthy/mature it is for that individual |
| `settlement_confidence_state` | settlement-level maturity |
| `retention_strength` | how likely it is to be retained |
| `times_observed` | observed count |
| `times_performed` | performed count |
| `times_successful` | successful outcome count |
| `times_failed` | failed outcome count |
| `teacher_ids` | teachers linked to this knowledge instance |
| `misconception_flags` | incorrect beliefs attached to this knowledge instance |
| `is_standardized` | settlement treats as standard practice |
| `is_spatially_embedded` | encoded into layout/zones/placement |
| `is_recorded` | represented in records/tokens/writing later |

### 6.7 Reserve and stock fields

| Field | Meaning |
|---|---|
| `reserve_bucket_id` | reserve definition such as `reserve_seed` |
| `reserve_threshold_min` | lower desired threshold |
| `reserve_threshold_target` | normal target threshold |
| `reserve_release_policy` | release rule |
| `is_locked_for_normal_use` | protected from ordinary consumption |
| `owner_governance_class` | who governs access |
| `stockpoint_priority` | refill/cleanup/empty priority |
| `allowed_categories` | what a stockpoint can hold |
| `cleanliness_class` | clean/dirty suitability |
| `dryness_class` | dryness suitability |
| `pest_exposure_class` | pest risk suitability |

---

## 7. Global enum conventions

### 7.1 Severity ladders
Unless a system has a better reason, use this five-step ladder:

- `none`
- `low`
- `moderate`
- `high`
- `critical`

### 7.2 Binary state ladders that need one middle band
Use:

- `no`
- `partial`
- `yes`

or, if quality/readiness is being described:

- `poor`
- `fair`
- `good`

### 7.3 Condition ladders
Use these terms consistently where coarse condition is enough:

- `intact`
- `worn`
- `damaged`
- `failing`
- `broken`

### 7.4 Cleanliness ladders
Use:

- `dirty`
- `mixed`
- `clean`
- `clean_protected`

### 7.5 Dryness ladders
Use:

- `wet`
- `damp`
- `dry`
- `dry_protected`

### 7.6 Exposure ladders
Use:

- `exposed`
- `partly_sheltered`
- `sheltered`
- `well_sheltered`

---

## 8. Settlement and progression enums

### 8.1 Settlement stage IDs
Canonical stage IDs:

- `stage.start`
- `stage.lone_survivor`
- `stage.primitive_camp`
- `stage.permanent_camp`
- `stage.tiny_hamlet`

### 8.2 Stage ordering field
Use:

- `stage_rank = 0` for `stage.start`
- `stage_rank = 1` for `stage.lone_survivor`
- `stage_rank = 2` for `stage.primitive_camp`
- `stage_rank = 3` for `stage.permanent_camp`
- `stage_rank = 4` for `stage.tiny_hamlet`

This allows quick comparison without replacing the authoritative stage ID string.

### 8.3 Promotion state
Use:

- `not_met`
- `partially_met`
- `ready`
- `promoted`

---

## 9. Need, body, and health enums

### 9.1 Canonical early need tags
These should be shared by tasks, alerts, policies, and UI summaries.

- `need_hydration`
- `need_food`
- `need_warmth`
- `need_dryness`
- `need_sleep`
- `need_shelter`
- `need_sanitation`
- `need_safety`
- `need_care`
- `need_social`
- `need_morale`
- `need_storage`
- `need_fuel`
- `need_seed_protection`
- `need_clean_water`
- `need_clean_food_prep`

### 9.2 Body temperature state
Use:

- `hypothermic_risk`
- `cold_stressed`
- `stable`
- `heat_stressed`
- `heat_illness_risk`

### 9.3 Wetness state
Use:

- `dry`
- `damp`
- `wet`
- `soaked`

### 9.4 Fatigue state
Use:

- `rested`
- `tired`
- `fatigued`
- `exhausted`

### 9.5 Hunger / food stress state
Use:

- `fed`
- `hungry`
- `very_hungry`
- `starving`

### 9.6 Hydration state
Use:

- `hydrated`
- `thirsty`
- `very_thirsty`
- `dehydration_risk`

### 9.7 Injury severity state
Use:

- `none`
- `minor`
- `moderate`
- `severe`
- `critical`

### 9.8 Illness severity state
Use:

- `none`
- `mild`
- `moderate`
- `severe`
- `critical`

### 9.9 Pain state
Use:

- `none`
- `low`
- `moderate`
- `high`
- `overwhelming`

### 9.10 Morale state
Use:

- `broken`
- `low`
- `steady`
- `good`
- `high`

### 9.11 Social comfort state
Use:

- `isolated`
- `strained`
- `stable`
- `supported`

### 9.12 Sleep quality state
Use:

- `awful`
- `poor`
- `adequate`
- `good`
- `restorative`

---

## 10. NPC demographic and role enums

### 10.1 Origin type
Canonical values:

- `starter`
- `migrant`
- `rescued`
- `born_here`
- `trader`
- `prisoner`
- `visitor`

### 10.2 Height class
Use:

- `short`
- `average`
- `tall`

### 10.3 Frame size
Use:

- `small`
- `medium`
- `large`

### 10.4 Dominant hand
Use:

- `left`
- `right`
- `mixed`

### 10.5 Employment / colony status
Canonical values:

- `colonist`
- `visitor`
- `apprentice`
- `patient`
- `prisoner`
- `child`

### 10.6 Early role IDs
These are role definitions, not hard classes.

- `role_generalist`
- `role_water_keeper`
- `role_fire_keeper`
- `role_forager`
- `role_food_preparer`
- `role_storekeeper`
- `role_hide_worker`
- `role_basket_fiber_worker`
- `role_potter_early`
- `role_garden_keeper`
- `role_caregiver`
- `role_builder`
- `role_watchkeeper`

### 10.7 Emergency role IDs
Use:

- `role_emergency_water`
- `role_emergency_fire`
- `role_emergency_care`
- `role_emergency_shelter`
- `role_emergency_food`

---

## 11. Task enums

### 11.1 Task source type
Canonical values:

- `need`
- `player_order`
- `building_request`
- `schedule`
- `event`
- `emergency`

### 11.2 Task status
Canonical runtime task lifecycle:

- `generated`
- `screened_out`
- `candidate`
- `scored`
- `selected`
- `reserved`
- `in_transit`
- `setup`
- `active`
- `passive_wait`
- `blocked`
- `interrupted`
- `completed`
- `partial_success`
- `failed`
- `cancelled`
- `expired`

- this enum is the canonical runtime lifecycle for tasks
- UI may collapse these into broader display buckets if desired

### 11.3 Emergency class
Use:

- `normal`
- `urgent`
- `emergency`
- `catastrophe`

### 11.4 Settlement priority band
Use:

- `lowest`
- `low`
- `normal`
- `high`
- `critical`

### 11.5 Task interruption reason
Use:

- `body_override`
- `danger_spike`
- `missing_input`
- `target_invalid`
- `policy_block`
- `player_cancelled`
- `night_or_light_block`
- `weather_block`
- `path_block`
- `reservation_lost`

### 11.6 Feasibility class
Use:

- `impossible`
- `poor`
- `acceptable`
- `good`
- `excellent`

### 11.7 Work tag IDs
These are shared between NPC labor preferences, tasks, and policies.

- `work_water`
- `work_fire`
- `work_shelter`
- `work_food_gathering`
- `work_butchery`
- `work_cooking`
- `work_preservation`
- `work_storage`
- `work_hauling`
- `work_sanitation`
- `work_hide`
- `work_fiber`
- `work_pottery`
- `work_garden`
- `work_building`
- `work_care`
- `work_teaching`
- `work_cleanup`
- `work_watch`
- `work_maintenance`

---

## 12. Logistics enums

### 12.1 Load class
Use the logistics doc’s coarse ladder as the canonical enum:

- `trivial`
- `light`
- `moderate`
- `heavy`
- `extreme`

### 12.2 Carry mode
Canonical values:

- `hand_carry`
- `bundle_carry`
- `shoulder_sling`
- `basket_carry`
- `bag_carry`
- `shoulder_pole_carry`
- `drag_carry`
- `litter_carry`

### 12.3 Terrain class
Canonical early logistics terrain values:

- `clear_flat`
- `open_grass_scrub`
- `forest_understory`
- `rocky_uneven`
- `mud_marsh_edge`
- `slope_ridge`
- `interior_camp_clutter`

### 12.4 Route preference state
Use:

- `unknown`
- `disliked`
- `neutral`
- `preferred`
- `core_path`

### 12.5 Location state model
Every item or batch should always be in one of these runtime lifecycle states:

- `in_world_source`
- `harvested_at_source`
- `claimed_in_transit`
- `temporarily_staged`
- `stored_at_stockpoint`
- `reserved_locked`
- `issued_to_person_or_worksite`
- `being_processed`
- `waste_salvage_quarantine`

Notes:
- these are runtime lifecycle states
- container/storage classes remain separate from location-state values
- UI may collapse or relabel these for readability, but the save/debug/runtime vocabulary should keep the canonical enum strings

### 12.6 Process state
Canonical runtime process lifecycle:

- `planned`
- `waiting_inputs`
- `setup`
- `active_work`
- `passive_progress`
- `paused`
- `completed`
- `failed`
- `salvageable_failure`
- `cancelled`

### 12.7 Storage protection class
Use:

- `ground_exposed`
- `ground_sorted`
- `covered_ground`
- `raised_protected`
- `container_open`
- `container_closed`
- `container_clean_covered`
- `pit_storage`
- `hanging_storage`

### 12.8 Pest exposure class
Use:

- `high`
- `moderate`
- `low`
- `protected`

### 12.9 Dryness suitability class
Use:

- `wet_risk`
- `mixed`
- `dry`
- `dry_protected`

## 13. Allocation, ownership, and reserve enums

### 13.1 Ownership class
Canonical values:

- `wild_unclaimed`
- `claimed_unstored`
- `personal_intimate`
- `personal_issued_tool`
- `household_good`
- `worksite_inventory`
- `communal_stock`
- `strategic_reserve_stock`
- `reproductive_reserve_stock`
- `care_reserve_stock`
- `waste_salvage_stock`

### 13.2 Access right verbs
Use these exact access-right labels where bundles are stored:

- `inspect`
- `carry`
- `use`
- `consume`
- `issue`
- `reserve`
- `reassign`
- `discard`
- `repair`
- `clean`

### 13.3 Reserve classes
Canonical values:

- `working_stock`
- `daily_meal_stock`
- `short_term_buffer`
- `strategic_reserve`
- `reproductive_reserve`
- `care_reserve`
- `morale_reserve`

### 13.4 Canonical reserve bucket IDs for the early game
Use these as first-playable reserve definitions:

- `reserve_drinking_water`
- `reserve_fuel`
- `reserve_immediate_food`
- `reserve_dry_food`
- `reserve_emergency_food`
- `reserve_seed`
- `reserve_bedding_clothing`
- `reserve_repair_materials`
- `reserve_clean_containers`

### 13.5 Ration state
Canonical values:

- `open`
- `normal`
- `tight`
- `restricted`
- `emergency_only`

### 13.6 Release policy
Canonical values:

- `always_allowed`
- `threshold_only`
- `leader_approval`
- `care_only`
- `never_normal_use`

---

## 14. Water, food, sanitation, and contamination enums

### 14.1 Water quality state
Use this state family consistently:

- `raw_dirty_surface_water`
- `settled_water`
- `coarse_filtered_water`
- `boiled_water`
- `stored_potable_water`
- `recontaminated_stored_water`
- `utility_water`

### 14.2 Food safety class
Use:

- `safe`
- `questionable`
- `unsafe`

### 14.3 Food perishability class
Use:

- `hours`
- `days`
- `weeks`
- `months`
- `years`

### 14.4 Meal state
Use:

- `raw`
- `prepared_uncooked`
- `cooked_short_life`
- `dried_preserved`
- `smoked_preserved`
- `spoiled`

### 14.5 Contamination state
Use:

- `clean`
- `handled_unclean`
- `cross_contaminated`
- `heavily_contaminated`

### 14.6 Clean/dirty zone doctrine types
Canonical zone types for the early game:

- `zone_type_water_fetch`
- `zone_type_clean_water_storage`
- `zone_type_wash_area`
- `zone_type_clean_food_prep`
- `zone_type_dirty_processing`
- `zone_type_sleep_area`
- `zone_type_hearth`
- `zone_type_drying`
- `zone_type_latrine`
- `zone_type_waste`
- `zone_type_seed_storage`
- `zone_type_garden`
- `zone_type_common_area`
- `zone_type_outer_cache`
- `zone_type_care_area`

---

## 15. Knowledge enums

### 15.1 Knowledge category
Canonical values:

- `intuitive`
- `discovery`
- `procedural`
- `material`
- `environmental`
- `risk_safety`
- `tool`
- `social`
- `instructional`
- `organizational`
- `institutional`
- `scientific`

### 15.2 Knowledge scope level
Canonical values:

- `individual`
- `group`
- `settlement`

### 15.3 Early knowledge domain IDs
Canonical early domains:

- `water`
- `shelter_site`
- `fire`
- `food_gathering`
- `carcass_food_safety`
- `preservation`
- `fiber_cordage`
- `basketry_carrying`
- `hide_work`
- `clay_vessel`
- `seed_garden`
- `sanitation`
- `social_organization`

### 15.4 Awareness state
This is the individual’s proximity to the knowledge unit.

Canonical values:

- `unknown`
- `aware`
- `observed`
- `attempted`
- `understood`

### 15.5 Confidence state
Canonical values:

- `observed`
- `tentative`
- `practiced`
- `reliable`
- `camp_standard`

### 15.6 Settlement confidence state
Canonical values:

- `rare`
- `emerging`
- `shared`
- `standardized`
- `institutionalized`

### 15.7 Knowledge source type
Canonical values:

- `intuition`
- `observation`
- `demonstration`
- `practice`
- `failure_feedback`
- `conversation`
- `outsider_transfer`
- `recorded_reference`

---

## 16. Skill dictionary

### 16.1 Skill record schema
Each skill entry should share this shape:

```json
{
  "level": 0,
  "xp": 0.0,
  "last_used_tick": 0,
  "confidence": 0.0,
  "formal_training_level": 0,
  "self_taught_fraction": 1.0,
  "failure_memory": 0.0,
  "quality_tendency": 0.0
}
```

### 16.2 First-playable required skill IDs
These should be implemented first and treated as canonical early skill IDs:

#### Core survival
- `foraging`
- `water_collection`
- `firemaking`
- `fuel_selection`
- `shelter_building`
- `bedding_prep`
- `camp_layout`
- `hauling`
- `primitive_toolmaking`
- `stone_knapping`
- `digging`
- `observation`
- `hazard_spotting`

#### Food and water
- `roasting`
- `boiling`
- `drying`
- `cooking`
- `water_boiling`
- `spoilage_detection`
- `seed_cleaning`
- `storage_prep`

#### Domestic survival
- `washing`
- `sanitation`
- `waste_management`
- `basic_first_aid`
- `nursing`

#### Early materials
- `basketry`
- `mat_weaving`
- `cordage_making`
- `knotting`
- `hide_scraping`
- `hide_softening`
- `sewing`
- `clay_selection`
- `pottery_handbuilding`
- `pit_firing`

#### Early land use
- `seed_saving`
- `garden_tending`
- `soil_preparation`
- `crop_watch`
- `weed_control`
- `harvest_timing`

#### Social / organizational
- `counting`
- `stockkeeping`
- `teaching`
- `leadership`

### 16.3 Present but not first-required skill IDs
These are canonical and valid, but can be dormant in the first slice:

- `tracking`
- `trapping`
- `spear_hunting`
- `fishing`
- `butchery`
- `hide_removal`
- `bone_processing`
- `fat_rendering`
- `gathering_shellfish`
- `smoking`
- `fermenting`
- `rough_carpentry`
- `transplanting`
- `pest_control`
- `guarding`
- `persuading`
- `mediation`
- `trading`
- `bookkeeping`

### 16.4 Skill naming rules
Use verbs or verb-like craft nouns.

Prefer:
- `firemaking`
- `seed_saving`
- `stockkeeping`

Avoid:
- `fire_skill`
- `seed_skill`
- `storekeeping_skill`

---

## 17. Item family taxonomy

### 17.1 Item category
Canonical broad item categories:

- `water`
- `container`
- `stone_mineral`
- `wood_plant_structural`
- `fiber_flexible_plant`
- `animal_material`
- `food`
- `fuel`
- `tool`
- `bedding`
- `clothing`
- `clay_pottery`
- `seed_agriculture`
- `waste_byproduct`
- `reserve_bundle`

### 17.2 Common item subcategories
Use these subcategories when needed:

- `raw_water`
- `treated_water`
- `potable_water`
- `utility_water`
- `liquid_container`
- `dry_goods_container`
- `cutting_tool`
- `striking_tool`
- `digging_tool`
- `carrying_aid`
- `sleep_material`
- `body_wrap`
- `hide_state`
- `bone_tool`
- `raw_clay`
- `prepared_clay`
- `greenware`
- `fired_pottery`
- `edible_raw`
- `edible_cooked`
- `edible_preserved`
- `seed_stock`
- `garden_input`
- `fuelwood`
- `tinder`
- `ash_char`
- `spoilage_refuse`

### 17.3 Item family naming rule
The second segment after `itm_` should usually be the family/domain:

- `itm_water_*`
- `itm_container_*`
- `itm_food_*`
- `itm_tool_*`
- `itm_hide_*`
- `itm_clay_*`
- `itm_pot_*`
- `itm_seed_*`
- `itm_fuelwood_*`

### 17.4 Canonical item state families

#### Water state family
- `raw_dirty_surface_water`
- `settled_water`
- `coarse_filtered_water`
- `boiled_water`
- `stored_potable_water`
- `recontaminated_stored_water`
- `utility_water`

#### Wood / fuel state family
- `green_wood`
- `seasoning_wood`
- `dry_fuelwood`
- `charred_wood`
- `ash`

#### Hide state family
- `raw_hide`
- `fleshed_hide`
- `scraped_hide`
- `air_dried_rawhide`
- `softened_hide`
- `smoked_hide`
- `damaged_hide`
- `hide_scrap`

#### Clay / vessel state family
- `raw_clay`
- `cleaned_clay`
- `tempered_clay`
- `shaped_greenware`
- `air_dried_greenware`
- `fired_earthenware`
- `cracked_pottery`
- `pottery_sherd_grog`

#### Food animal state family
- `fresh_raw_animal_food`
- `butchered_dirty`
- `butchered_cleaner`
- `cooked_short_life`
- `drying_in_progress`
- `dried_preserved`
- `smoked_preserved`
- `spoiled`

#### Food plant / seed state family
- `fresh_plant_food`
- `drying_plant_food`
- `dried_plant_food`
- `seed_bearing_harvest`
- `cleaned_seed`
- `dried_seed_stock`
- `damaged_seed_low_viability`

---

## 18. Process taxonomy

### 18.1 Process domain
Canonical process domains:

- `scouting`
- `water`
- `gathering`
- `toolmaking`
- `shelter`
- `fire`
- `food_acquisition`
- `carcass_processing`
- `cooking`
- `preservation`
- `hide_processing`
- `fiber_work`
- `basketry`
- `clay_pottery`
- `seed_handling`
- `garden`
- `sanitation`
- `storage_management`
- `reserve_management`
- `teaching_social`
- `maintenance`

### 18.2 Process naming rule
Use:
`pro_<domain>_<specific_action>`

Examples:
- `pro_water_boil_batch`
- `pro_hide_scrape`
- `pro_garden_prepare_plot`
- `pro_storage_rotate_fifo_simple`

### 18.3 Process outcome class
Use:

- `transform`
- `move`
- `consume`
- `maintain`
- `inspect`
- `teach`
- `assign`
- `clean`
- `construct`

---

## 19. Structure taxonomy

### 19.1 Structure family
Canonical broad structure families:

- `site`
- `shelter`
- `fire`
- `storage`
- `sanitation`
- `workspot`
- `drying`
- `smoke`
- `water_store`
- `fuel_store`
- `pottery`
- `garden`
- `fence`
- `path`
- `household`
- `communal`
- `care`
- `watch`

### 19.2 Structure naming rule
Use:
`str_<family>_<specific_form>`

Examples:
- `str_shelter_low_hut_brush`
- `str_storage_seed_cache_protected`
- `str_sanitation_waste_pit_small`

### 19.3 Structure function tags
These tags can be used on structure definitions and placed instances:

- `func_sleep`
- `func_warmth`
- `func_cooking`
- `func_storage`
- `func_clean_storage`
- `func_preservation`
- `func_hide_work`
- `func_fiber_work`
- `func_pottery`
- `func_sanitation`
- `func_water_storage`
- `func_garden_support`
- `func_meeting`
- `func_care`
- `func_watch`

---

## 20. Zone taxonomy

### 20.1 Zone type definitions
Canonical early zone types:

- `zone_type_water_fetch`
- `zone_type_clean_water_storage`
- `zone_type_wash_area`
- `zone_type_clean_food_prep`
- `zone_type_dirty_processing`
- `zone_type_sleep_area`
- `zone_type_hearth`
- `zone_type_drying`
- `zone_type_latrine`
- `zone_type_waste`
- `zone_type_seed_storage`
- `zone_type_garden`
- `zone_type_common_area`
- `zone_type_care_area`
- `zone_type_outer_cache`

### 20.2 Zone governance fields
Shared fields for zone instances:

- `zone_id`
- `zone_type_id`
- `display_name`
- `allowed_categories`
- `forbidden_categories`
- `cleanliness_class`
- `dryness_class`
- `pest_exposure_class`
- `hazard_tags`
- `priority_band`
- `is_player_designated`
- `is_core_life_support_zone`

---

## 21. Policy taxonomy

### 21.1 Policy family
Canonical early policy families:

- `survival_policy`
- `water_policy`
- `food_policy`
- `reserve_policy`
- `ration_policy`
- `work_policy`
- `role_policy`
- `training_policy`
- `hazard_policy`
- `social_policy`
- `layout_policy`

### 21.2 Policy effect verbs
Use these effect labels across policy definitions:

- `allow`
- `forbid`
- `prefer`
- `discourage`
- `reserve`
- `release`
- `prioritize`
- `deprioritize`
- `assign`
- `protect`
- `route_to`
- `lock`
- `unlock`

### 21.3 Canonical early policy IDs
Useful policy definitions for the first slice:

- `pol_reserve_seed_lock`
- `pol_potable_water_drinking_only`
- `pol_keep_latrine_away_from_water`
- `pol_keep_raw_hide_out_of_sleep_zone`
- `pol_fire_use_designated_zone_only`
- `pol_guest_rations_restricted`
- `pol_protect_clean_container_pool`

---

## 22. Alert and incident taxonomy

### 22.1 Alert severity
Use:

- `info`
- `warning`
- `urgent`
- `critical`

### 22.2 Alert domain
Use:

- `water`
- `food`
- `fire`
- `shelter`
- `sleep`
- `storage`
- `reserve`
- `sanitation`
- `health`
- `weather`
- `social`
- `task_flow`

### 22.3 Incident family
Use:

- `spoilage`
- `contamination`
- `injury`
- `illness`
- `weather_damage`
- `fire_loss`
- `reserve_breach`
- `social_conflict`
- `arrival_departure`
- `predator_threat`
- `tool_failure`
- `storage_failure`

---

## 23. Compatibility and deprecation notes

### 23.1 `task_type` vs `task_def_id`
Older descriptive docs often say `task_type`.
For implementation, use:

- `task_def_id` as the canonical field
- `task_type` only as a compatibility alias during transition work

### 23.2 `quality` vs `quality_class`
Use `quality_class` for coarse buckets.
Reserve plain `quality` for rare cases where a numeric scalar is truly intended.

### 23.3 `condition` vs `condition_state`
Use `condition_state` for enum storage.
Reserve plain `condition` only for temporary local variables.

### 23.4 `known` boolean vs knowledge states
Do not reduce knowledge to one boolean once the knowledge system exists.

Prefer:
- `awareness_state`
- `confidence_state`

A derived boolean such as `is_known_enough_for_use` may exist, but it is not the authoritative storage model.

### 23.5 `dropoff_entity_id`
This may remain in task payloads for backward readability.
For new generic implementations, prefer:

- `destination_entity_id`

because the destination may be a container, stockpoint, structure, or zone.

### 23.6 `material`
This word is too broad by itself.

Use one of:
- `material_def_id`
- `primary_material_tag`
- `material_category`

depending on what is actually intended.

---

## 24. First-playable canonical minimum set

This is the minimum vocabulary that should already be hard-coded or data-authored before major implementation grows further.

### 24.1 Must exist immediately
- stage IDs in Section 8
- need tags in Section 9.1
- task statuses in Section 11.2
- load classes in Section 12.1
- ownership / reserve classes in Sections 13.1–13.4
- water and contamination states in Section 14
- knowledge states in Section 15
- required early skill IDs in Section 16.2
- item / process / structure families in Sections 17–19
- zone types in Section 20

### 24.2 Can remain data-authored but not fully simulated yet
- some later role IDs
- some non-MVP skill IDs
- some future policy IDs
- some future incident families
- reserved compatibility prefixes

---

## 25. Implementation guidance

### 25.1 One string, one meaning
The point of this document is to avoid situations like:
- `safe_water` in one file
- `clean_water` in another
- `potable` in a third
- `drinkable_water` in a fourth

Pick the canonical term once and reuse it everywhere.

### 25.2 Prefer enums over free text
If a field is meant to be one of a small number of options, store the enum value, not a prose string.

### 25.3 Keep IDs short but readable
Prefer:
- `str_fire_hearth_stone_small`

Avoid:
- `structure_for_small_stone_campfire_place`

### 25.4 Keep display text separate
Do not rename IDs for flavor writing.
Flavor belongs in UI strings, not identifiers.

### 25.5 Use this document as the shared source for:
- GDScript constants
- JSON data definitions
- save schema field names
- debug inspector labels
- content validation scripts
- editor tooling

---

## 26. Short conclusion

This dictionary establishes the canonical implementation vocabulary for the early game.

It is meant to make the next documents easier and safer to build:
- Balance / Constants Sheet
- System Flow / State Machine Pack
- Acceptance Criteria / Test Checklist
- actual Godot data resources and code

The goal is simple:

**stop arguing with strings, and make the early game buildable.**
