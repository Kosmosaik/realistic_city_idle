# Realistic Idle City — Unified Data Dictionary v0.1

## Purpose

This document defines the canonical naming rules, IDs, enums, shared field names, and family taxonomies for the early-game implementation stack.

This version includes the implemented Branch 01 families and bootstrap context fields.

---

## 1. Core naming doctrine

### 1.1 Machine-readable names
All canonical machine names should use:
- lowercase
- `snake_case`
- no spaces
- no punctuation except underscore and existing dot namespaces like `stage.*`, `scenario.*`, `season.*`, and `part_of_day.*`

### 1.2 Player-facing names
Player-facing text stays separate from machine IDs.
Use:
- `display_name`
- `description`

### 1.3 Stable IDs
Definition IDs should be treated as stable once introduced.
Display names/descriptions can change.

### 1.4 Explicit suffixes
Use:
- `_id` for one ID
- `_ids` for lists
- `_def_id` for content definition IDs when the family uses prefixed content IDs
- `_state` for mutually exclusive state enums
- `_tags` for unordered tag sets

---

## 2. Canonical implemented definition families

These definition families now exist in code/resources and should be treated as current implementation truth:

| Family | Type key | ID rule | Example |
|---|---|---|---|
| stage | `stage` | dot namespace | `stage.lone_survivor` |
| scenario | `scenario` | dot namespace | `scenario.dev.temperate_valley` |
| skill | `skill` | snake_case | `water_collection` |
| map preset | `map_preset` | snake_case | `starter_map_balanced` |
| species | `species` | snake_case | `common_reeds` |
| terrain profile | `terrain_profile` | snake_case | `temperate_valley_balanced` |
| worldgen profile | `worldgen_profile` | snake_case | `authored_starter_temperate_valley` |
| season profile | `season_profile` | snake_case | `temperate_four_season_basic` |
| UI panel | `ui_panel` | snake_case | `reserve_alerts_panel` |
| item | `item` | `itm_` prefix | `itm_water_boiled` |
| process | `process` | `pro_` prefix | `pro_boil_water_simple` |
| structure | `structure` | `str_` prefix | `str_fire_hearth_stone_small` |
| incident | `incident` | `inc_` prefix | `inc_water_reserve_low` |

---

## 3. Canonical calendar/bootstrap IDs

### 3.1 Season IDs
- `season.spring`
- `season.summer`
- `season.autumn`
- `season.winter`

### 3.2 Part-of-day IDs
- `part_of_day.dawn`
- `part_of_day.day`
- `part_of_day.dusk`
- `part_of_day.night`

### 3.3 Active bootstrap context keys
These are now current implementation-facing keys in `SimRoot` / debug bootstrap context:
- `scenario_id`
- `stage_id`
- `map_preset_id`
- `worldgen_profile_id`
- `season_profile_id`
- `seed`
- `calendar`

### 3.4 Calendar snapshot keys
Current `TimeService` snapshot keys:
- `tick_index`
- `day_index`
- `year_index`
- `season_id`
- `part_of_day_id`
- `season_profile_id`
- `ticks_per_part_of_day`

---

## 4. Canonical runtime/state helper vocabularies already implemented

Implemented code-home helper files:
- `definition_types.gd`
- `id_rules.gd`
- `calendar_ids.gd`
- `shared_enums.gd`
- `task_def_ids.gd`
- `policy_bundle_ids.gd`
- `zone_types.gd`

These should be extended rather than replaced with loose duplicate strings.

---

## 5. Canonical shared enum/value families currently in code

### Alert severities
- `info`
- `warning`
- `urgent`
- `critical`

### Alert domains
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

### Fog states
- `unknown`
- `remembered`
- `visible`

### Terrain/world support enums
- landform types: `ridge`, `slope`, `bench`, `flat`, `depression`, `channel`
- slope classes: `flat`, `gentle`, `moderate`, `steep`
- drainage classes: `very_poor`, `poor`, `moderate`, `good`, `excessive`
- vegetation cover classes: `bare`, `sparse`, `grass`, `brush`, `woodland`, `forest`, `wetland`
- water source types: `river`, `stream`, `spring`, `pond`, `lake`, `seep`

---

## 6. Canonical placeholder ID families already implemented

### Task definition IDs
Examples already in code:
- `tsk_fetch_water`
- `tsk_gather_fuel`
- `tsk_maintain_fire`
- `tsk_get_food`
- `tsk_cook_food`
- `tsk_build_shelter`
- `tsk_prepare_sleep_site`
- `tsk_make_tool`
- `tsk_improve_sanitation`
- `tsk_refill_clean_water_store`
- `tsk_sort_storage`
- `tsk_inspect_drying_food`
- `tsk_make_container`
- `tsk_tend_garden`
- `tsk_clean_camp`

### Policy bundle IDs
Current placeholder bundles:
- `pol_bundle_starter_survival`
- `pol_bundle_starter_food_water`
- `pol_bundle_starter_storage`
- `pol_bundle_starter_sanitation`

### Zone type IDs
Examples already in code:
- `zone_type_water_fetch`
- `zone_type_clean_water_storage`
- `zone_type_sleep_area`
- `zone_type_hearth`
- `zone_type_drying`
- `zone_type_latrine`
- `zone_type_waste`
- `zone_type_seed_storage`
- `zone_type_garden`
- `zone_type_outer_cache`

---

## 7. Canonical scenario/world linkage fields

`ScenarioDef` currently uses:
- `scenario_id`
- `starting_stage_id`
- `default_map_preset_id`
- `worldgen_profile_id`
- `default_seed`
- `starting_item_def_ids`
- `policy_bundle_ids`

`WorldgenProfileDef` currently uses:
- `worldgen_profile_id`
- `map_preset_ids`
- `terrain_profile_ids`
- `season_profile_id`
- `starter_species_ids`
- `authored_only`

`SeasonProfileDef` currently uses:
- `season_profile_id`
- `supported_season_ids`
- `default_start_season_id`
- `part_of_day_ids`
- `ticks_per_part_of_day`

These names should be treated as canonical unless an explicit future migration is planned.

---

## 8. Canonical incident/UI metadata fields

`IncidentDef` currently uses:
- `incident_id`
- `severity`
- `primary_domain`
- `trigger_kind`
- `default_ui_panel_id`
- `related_task_def_ids`
- `related_process_def_ids`
- `related_structure_def_ids`
- `related_item_def_ids`
- `is_player_notifiable`

`UiPanelDef` currently uses:
- `ui_panel_id`
- `panel_group`
- `supported_alert_domains`
- `default_visible`
- `starts_collapsed`
- `is_debug_only`

---

## 9. Final rule

If a string already has a code home in the current Branch 01 shell, do not invent a parallel spelling elsewhere.

Extend the current helpers and definitions.
Do not let IDs drift.
