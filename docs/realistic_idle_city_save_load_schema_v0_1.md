# Realistic Idle City — Save / Load Schema v0.1

## 1. Purpose

This document defines the **canonical save and load contract** for the early-game MVP.

It exists to make the survival-to-hamlet slice:
- resumable
- debuggable
- reproducible
- safe against partial-write corruption
- consistent with the Unified Data Dictionary, System Flow pack, World Generation spec, and Debug / Telemetry spec

This is an implementation document.
It is **not** a content design bible.

It answers:
- what a save slot contains
- what the authoritative save root schema is
- which runtime states must persist
- which states must be rebuilt on load
- how autosaves and backups should work
- how the game should write saves safely
- how strict version compatibility should be during the current hardening phase

---

## 2. Scope

Canonical enum strings come from the Unified Data Dictionary unless the current document is explicitly preserving a more detailed runtime lifecycle that the dictionary mirrors.

This schema covers only the early-game MVP:
- Lone Survivor
- Primitive Camp
- Permanent Camp
- Tiny Hamlet

It must preserve the systems that define this slice:
- body-state pressure
- explicit item locations and hauling
- reserves / rationing / ownership
- shelter / fire / spoilage / contamination
- weather and seasonal progression
- world exploration / fog-of-war / remembered terrain
- first structures, stockpiles, zones, and managed plots
- second/third NPC arrival and small-settlement continuity

It does **not** attempt to finalize:
- cloud sync
- mod save compatibility
- late-game megasettlement partitioning
- long-term backwards migration guarantees
- multiplayer replication save logic

---

## 3. Source-of-truth order

When this document conflicts with older material, use this order:

1. latest user instructions in the active chat
2. handoff summary
3. early-game MVP build spec
4. unified data dictionary
5. balance / constants sheet
6. system flow / state machine pack
7. acceptance criteria / test checklist
8. world generation + map rendering spec
9. debug / telemetry spec
10. this save / load schema
11. older early-game design docs

Practical rule:
- the build spec defines **what systems exist**
- the data dictionary defines **field naming and ID doctrine**
- the state-machine pack defines **runtime state shape**
- the world spec defines **what map/fog knowledge must persist**
- the telemetry spec defines **what metadata must be reproducible**
- this document defines **what is serialized and how**

---

## 4. Current stance for save compatibility

### 4.1 Hardening-phase rule

During the current hardening phase, **save migration is not a priority**.

This means:
- schema clarity matters more than preserving old saves forever
- if a save from an older incompatible schema cannot be loaded cleanly, it may be rejected
- the game should give a clear reason when a save is rejected
- developer-only migration scripts may exist later, but they are optional in v0.1

### 4.2 Practical compatibility policy

Use three compatibility classes:

- `compatible` = load normally
- `load_with_warning` = load allowed, but metadata mismatch exists that is considered low risk
- `reject` = load refused because correctness cannot be trusted

Default rejection reasons:
- `schema_version` mismatch outside the accepted range
- `content_version` mismatch with deleted/renamed definition IDs
- `world_gen_version` mismatch when the save depends on generator behavior no longer guaranteed
- missing required root sections
- corrupted or unreadable payload
- failed checksum/backup recovery when no good copy remains

### 4.3 Why strictness is correct for now

The current goal is to make the early-game build **trustworthy**, not to promise permanent save compatibility before the systems settle.

---

## 5. Core save doctrine

### 5.1 Save authoritative state, not presentation state

Persist:
- authoritative simulation state
- player decisions and settings
- reproducibility metadata
- enough world/map memory to continue exactly

Do **not** persist:
- cosmetic-only UI layout polish
- render caches
- pathfinding caches
- terrain blend caches
- derived debug aggregates that can be recomputed
- temporary scoring scratch buffers

### 5.2 Save at a simulation boundary, never mid-mutation

A save must be captured only after a simulation step reaches a **stable boundary**.

Do not save while:
- an item transfer is half-applied
- a reservation has been removed but not reassigned
- a task interrupt has started but not committed
- a process has consumed inputs but not yet written outputs
- fog reveal is in the middle of updating a chunk
- a stage evaluation is half-finished

The save system should request a snapshot on the next safe boundary and then freeze serialization from that settled state.

### 5.3 Prefer explicit serialized records over hidden engine state

The save format must not depend on:
- scene tree traversal order
- transient node instance order
- Godot internal object IDs
- cached resource paths as the sole content identity

Use canonical game IDs and explicit records instead.

### 5.4 Rebuild caches on load

Load should restore truth, then rebuild helpers:
- path grids
- route desirability maps
- terrain render caches
- hillshade/fog textures
- selection caches
- debug aggregate counters
- task candidate caches

### 5.5 Deterministic continuation matters

A loaded game should continue from the same world situation, not from a similar approximation.

This means the save must preserve:
- simulation clock
- weather state
- active incidents that still matter
- in-progress tasks/processes that are intended to survive save/load
- RNG stream state or equivalent deterministic continuation metadata

---

## 6. Recommended file-format strategy for v0.1

## 6.1 Format choice

For v0.1, use **plain JSON save payloads written under `user://`**.

Why this is the correct early choice:
- easy to inspect during hardening
- easy to diff during debugging
- easy to export with telemetry bundles
- easy to validate by section
- simple to repair manually in rare dev-only situations

### 6.2 JSON constraints

Because JSON does not natively preserve Godot-specific Variant types such as `Vector2`, the save schema should use only plain JSON-friendly primitives and structures:
- object/dictionary
- array
- string
- integer
- float
- boolean
- null

Practical rule:
- positions should serialize as `{ "x": int, "y": int }` or equivalent cell coordinates
- enums should serialize as canonical strings
- IDs should serialize as canonical strings
- timestamps/ticks should serialize as integers

### 6.3 Do not use binary-first custom save formats yet

A custom binary save format may be useful later for:
- very large worlds
- faster IO
- smaller cloud payloads
- tamper resistance

But it is the wrong priority for this stage.

### 6.4 Separate save payload from content resources

Save files should reference gameplay definitions by stable canonical IDs such as:
- `item_def_id`
- `process_def_id`
- `structure_def_id`
- `knowledge_id`

Do **not** anchor save correctness to editor-facing resource paths alone.

---

## 7. Save-slot layout

Recommended v0.1 layout:

```text
user://saves/
  slot_000/
    slot_manifest.json
    save_current.json
    save_prev_backup.json
    optional_preview.png
  slot_001/
    slot_manifest.json
    save_current.json
    save_prev_backup.json
  autosave/
    slot_manifest.json
    save_current.json
    save_prev_backup.json
```

### 7.1 `slot_manifest.json`

This is a lightweight metadata file used for save-slot UI and quick integrity checks.

Suggested contents:
- `slot_id`
- `slot_type` (`manual`, `autosave`, `quicksave`)
- `display_name`
- `created_at_utc`
- `last_saved_at_utc`
- `schema_version`
- `build_version`
- `content_version`
- `balance_version`
- `world_gen_version`
- `settlement_name`
- `settlement_stage`
- `current_day_index`
- `npc_count`
- `map_profile_id`
- `seed_world`
- `playtime_seconds`
- `is_corrupt_flag`
- `last_write_result`

### 7.2 `save_current.json`

The authoritative serialized game state.

### 7.3 `save_prev_backup.json`

The previously known-good snapshot for that slot.
When a new save succeeds, rotate the old current file into backup.

### 7.4 `optional_preview.png`

Optional thumbnail or map snapshot later.
Not required for v0.1.

---

## 8. Safe write procedure

## 8.1 Write flow

Recommended save flow:

1. Request save at next stable simulation boundary.
2. Build in-memory snapshot object.
3. Serialize to JSON string.
4. Write to temporary path in the same slot directory.
5. Flush and close file.
6. Validate the written temp payload if practical.
7. Rename current save to backup.
8. Rename temp save to current.
9. Update slot manifest last.
10. Emit save-complete telemetry.

### 8.2 Failure behavior

If any step fails:
- preserve the previous `save_current.json`
- do not delete the backup
- mark manifest with `last_write_result = failed`
- surface a readable error to the player/developer
- emit a structured telemetry event

### 8.3 Why manifest should be updated last

The slot list must not claim a new save exists until the payload is safely written.

---

## 9. Root schema

Top-level recommended shape:

```json
{
  "save_header": { },
  "session_fingerprint": { },
  "simulation_clock": { },
  "rng_state": { },
  "world_static_ref": { },
  "world_dynamic_state": { },
  "map_memory_state": { },
  "settlement_state": { },
  "npc_state": { },
  "item_state": { },
  "structure_state": { },
  "zone_state": { },
  "task_state": { },
  "process_state": { },
  "event_state": { },
  "ui_player_state": { },
  "validation_state": { }
}
```

Every top-level section above is required in v0.1, even if some subsections are empty.

---

## 10. `save_header`

Purpose:
- schema identity
- compatibility checks
- coarse slot metadata

Suggested fields:
- `schema_name`
- `schema_version`
- `minimum_loadable_schema_version`
- `save_uuid`
- `slot_id`
- `slot_type`
- `created_at_utc`
- `saved_at_utc`
- `save_reason` (`manual`, `autosave`, `quicksave`, `acceptance_test`, `dev_snapshot`)
- `is_dev_build`
- `notes` (optional dev/user note)

Required rule:
- `schema_version` is the first gate checked during load

---

## 11. `session_fingerprint`

This should mirror the reproducibility doctrine from the telemetry spec.

Suggested fields:
- `build_version`
- `content_version`
- `balance_version`
- `world_gen_version`
- `git_commit`
- `seed_world`
- `seed_events`
- `seed_settlement`
- `scenario_profile_id`
- `canonical_map_profile_id`
- `build_tier`
- `started_at_utc`
- `accumulated_playtime_seconds`

Why it matters:
- testers must know what exact build/content/balance/world seed produced the save
- long-run failures must be reproducible from save exports

---

## 12. `simulation_clock`

Suggested fields:
- `sim_tick`
- `day_index`
- `day_phase`
- `hour_of_day`
- `minute_of_hour`
- `season_id`
- `season_day_index`
- `weather_state`
- `weather_intensity_class`
- `recent_weather_history`
- `next_daily_review_tick`
- `next_hourly_review_tick`
- `next_weather_roll_tick`

This section is required because time/season/weather alter:
- visibility
- movement burden
- dehydration risk
- spoilage
- exposure
- farming/garden viability
- fire behavior

---

## 13. `rng_state`

Persist deterministic continuation state.

Recommended fields:
- `rng_world_state`
- `rng_events_state`
- `rng_ai_state`
- `rng_loot_or_forage_state`
- `rng_weather_state`

Implementation rule:
- either store full stream state
- or store enough deterministic generator state to continue exactly

Do **not** rely on re-seeding from `seed_world` alone after the run has advanced.

---

## 14. `world_static_ref`

This section identifies the generated or authored local world the save belongs to.

Suggested fields:
- `map_id`
- `scenario_profile_id`
- `world_gen_version`
- `seed_world`
- `map_width`
- `map_height`
- `chunk_size`
- `origin_cell`
- `embedded_static_snapshot_present`
- `static_snapshot_hash`
- `generator_profile_summary`

### 14.1 Embedded static snapshot policy

For v0.1, use the following pragmatic rule:

- the save format **supports** seed regeneration
- but the default save payload may also include an **embedded static local-map snapshot** during hardening

Reason:
- world generation is still evolving
- embedded static data prevents false breakage caused by generator drift
- save migration is not prioritized anyway

---

## 15. `world_dynamic_state`

This section stores dynamic world facts that cannot be trusted to regenerate from the base seed alone.

Recommended structure:

```json
{
  "changed_cells": [],
  "feature_instances": [],
  "active_path_cells": [],
  "water_access_points": [],
  "dynamic_hazard_marks": [],
  "harvested_feature_ids": [],
  "fallow_plot_ids": []
}
```

### 15.1 `changed_cells`

Store only cells whose dynamic state differs from the static baseline.

Suggested per-cell fields:
- `cell_id`
- `position`
- `surface_state`
- `vegetation_state`
- `wetness_state`
- `firmness_state`
- `buildability_state`
- `path_wear_level`
- `contamination_load`
- `fire_scorch_state`
- `dug_state`
- `occupied_by_structure_id`
- `reserved_use_tags`
- `last_changed_tick`

### 15.2 `feature_instances`

For world objects that exist as distinct features rather than generic terrain:
- `feature_id`
- `feature_type`
- `cell_id`
- `feature_def_id`
- `state`
- `remaining_yield`
- `regrowth_state`
- `quality_class`
- `is_depleted`
- `last_interacted_tick`

Examples:
- berry patch
- spring access point
- stone outcrop
- clay exposure
- felled log cluster
- planted plot marker

### 15.3 `active_path_cells`

Optional helper data if path wear or trail emergence exists in MVP:
- `cell_id`
- `wear_level`
- `last_used_tick`

### 15.4 `water_access_points`

If water logic uses explicit access nodes rather than only terrain:
- `water_access_id`
- `cell_id`
- `water_source_class`
- `flow_reliability_class`
- `contamination_state`
- `last_verified_tick`

---

## 16. `map_memory_state`

This section persists the exploration/fog-of-war truth defined by the world spec.

Recommended structure:

```json
{
  "cell_memory": [],
  "feature_knowledge": [],
  "frontier_cells": [],
  "last_map_recalc_tick": 0
}
```

### 16.1 `cell_memory`

Suggested per-record fields:
- `cell_id`
- `fog_state` (`unseen`, `explored`, `visible`)
- `first_seen_tick`
- `last_seen_tick`
- `last_scouted_tick`
- `terrain_memory_quality`
- `dynamic_memory_quality`
- `reported_by_npc_ids`

### 16.2 `feature_knowledge`

Suggested per-record fields:
- `feature_id`
- `knowledge_state` (`unknown`, `suspected`, `observed`, `familiar`)
- `confidence_state` (`tentative`, `reliable`, `trusted`)
- `last_verified_tick`
- `seasonal_reliability_notes`

### 16.3 `frontier_cells`

Optional persisted helper.
May be rebuilt on load if desired.
Persist only if it materially reduces recomputation cost.

---

## 17. `settlement_state`

This is the high-level continuity record for the player-controlled settlement.

Suggested fields:
- `settlement_id`
- `settlement_name`
- `current_stage_id`
- `stage_progress_state`
- `household_count`
- `population_count`
- `claimed_core_cells`
- `camp_center_cell_id`
- `reserve_status_summary`
- `food_security_state`
- `water_security_state`
- `fuel_security_state`
- `sleep_capacity_summary`
- `sanitation_status_summary`
- `morale_state`
- `active_policy_ids`
- `ration_policy_state`
- `default_work_policy_state`
- `newcomer_policy_state`
- `last_stage_eval_tick`
- `stage_blocker_tags`

This section should not duplicate every entity detail.
It is the summary truth needed for quick load/UI integrity and stage continuity.

---

## 18. `npc_state`

Recommended structure:

```json
{
  "npc_records": [],
  "next_npc_id_counter": 0
}
```

### 18.1 Per-NPC required fields

- `npc_id`
- `display_name`
- `life_state`
- `spawn_origin_class`
- `current_cell_id`
- `facing_dir` (optional)
- `home_structure_id`
- `household_id`
- `current_posture_state`
- `current_macro_state`
- `current_task_id`
- `current_order_id`
- `current_path_state`
- `carried_weight`
- `carry_capacity`
- `inventory_item_ids`
- `equipment_item_ids`

### 18.2 Body / needs / health fields

- `hydration_level`
- `hunger_level`
- `fatigue_level`
- `sleep_debt_hours`
- `body_temperature_state`
- `wetness_state`
- `pain_state`
- `injury_records`
- `illness_records`
- `sanitation_exposure_load`
- `morale_state`

### 18.3 Skill / aptitude / knowledge fields

- `skill_levels`
- `interest_profile`
- `aptitude_profile`
- `knowledge_records`
- `role_preference_tags`
- `work_restriction_tags`

### 18.4 Social / scheduling fields

- `relation_edges`
- `trust_flags`
- `is_newcomer_flag`
- `last_full_rest_tick`
- `last_meal_tick`
- `last_drink_tick`
- `last_medical_check_tick`

### 18.5 Path and task continuity fields

Persist enough state to continue or safely resume:
- `current_path_cells` or resumable path token
- `task_progress_state`
- `interruption_state`
- `reservation_refs`
- `last_decision_tick`

If the path cache itself is rebuilt on load, the resumed path state may be simplified to:
- goal cell
- next immediate target
- movement progress fraction

---

## 19. `item_state`

Recommended structure:

```json
{
  "item_records": [],
  "next_item_instance_id_counter": 0
}
```

### 19.1 Per-item required fields

- `item_instance_id`
- `item_def_id`
- `stack_count`
- `quality_class`
- `condition_state`
- `contamination_state`
- `spoilage_state`
- `temperature_state` (if used by MVP)
- `owner_npc_id`
- `ownership_class`
- `reserve_class`
- `holder_type`
- `holder_id`
- `cell_id`
- `container_slot_key`
- `created_tick`
- `last_changed_tick`

### 19.2 Location rule

Every item must have exactly one authoritative location mode at save time.

Valid location modes:
- world cell
- NPC inventory
- structure storage
- loose container
- process input slot
- process output slot
- equipped

Implementation rule:
- never save an item in two holders
- never save an item with no valid holder and no cell location unless marked destroyed/pending_cleanup intentionally

### 19.3 Why item truth matters

This project’s identity depends on:
- no teleporting items
- hauling taking time
- reserve classes actually protecting stock
- contamination and spoilage traveling with the item

So item persistence must be exact.

---

## 20. `structure_state`

Recommended structure:

```json
{
  "structure_records": [],
  "next_structure_id_counter": 0
}
```

### 20.1 Per-structure fields

- `structure_id`
- `structure_def_id`
- `display_name`
- `cell_ids`
- `build_state`
- `condition_state`
- `owner_household_id`
- `assigned_use_tags`
- `sleep_capacity`
- `storage_slot_refs`
- `sanitation_role_state`
- `fire_source_state`
- `weather_protection_state`
- `last_maintained_tick`

Examples:
- lean-to
- shelter
- hearth
- rack
- storage pit
- latrine
- work area
- clay pit marker
- drying rack

### 20.2 Incomplete structures

Partially built structures must persist:
- placed footprint
- required remaining inputs
- current build progress
- blocked reasons
- assigned build tasks

---

## 21. `zone_state`

Recommended structure:

```json
{
  "zone_records": [],
  "next_zone_id_counter": 0
}
```

### 21.1 Per-zone fields

- `zone_id`
- `zone_type`
- `display_name`
- `cell_ids`
- `priority_level`
- `zone_rules`
- `allowed_item_tags`
- `denied_item_tags`
- `sanitation_rule_state`
- `harvest_rule_state`
- `gather_rule_state`
- `last_updated_tick`

Examples:
- stockpile zone
- refuse zone
- latrine zone
- no-cut preserve zone
- gather zone
- scout target area
- managed plot

### 21.2 Zone truth vs structure truth

Zones express:
- policy
- claimed space
- preferred use

Structures express:
- built objects
- capacity
- workflow affordances

Do not collapse these into one save table.

---

## 22. `task_state`

Recommended structure:

```json
{
  "task_records": [],
  "order_records": [],
  "reservation_records": [],
  "next_task_id_counter": 0,
  "next_order_id_counter": 0,
  "next_reservation_id_counter": 0
}
```

### 22.1 Task records

Required fields:
- `task_id`
- `task_def_id`
- `task_state`
- `priority_score`
- `origin_reason_tags`
- `requested_by_system_class`
- `assigned_npc_id`
- `target_cell_id`
- `target_item_ids`
- `target_structure_id`
- `created_tick`
- `claimed_tick`
- `started_tick`
- `progress_state`
- `blocked_reason_tags`
- `interruption_state`

### 22.2 Order records

Required fields:
- `order_id`
- `order_type`
- `issuer_class`
- `target_ref`
- `order_state`
- `created_tick`
- `expires_tick`
- `linked_task_ids`
- `completion_rule`

### 22.3 Reservation records

Required fields:
- `reservation_id`
- `holder_npc_id`
- `target_ref_type`
- `target_ref_id`
- `reservation_kind`
- `reservation_state`
- `created_tick`
- `expires_tick`

### 22.4 Why task state must persist

This game is not pure turn-based recalculation on every load.
If work was underway, load should preserve or safely recover it.

Permitted fallback:
- if an active task cannot be resumed safely, convert it on load into a clean re-evaluation state with an explicit debug note

---

## 23. `process_state`

Recommended structure:

```json
{
  "process_records": [],
  "next_process_id_counter": 0
}
```

### 23.1 Per-process fields

- `process_id`
- `process_def_id`
- `process_state`
- `worker_npc_id`
- `host_structure_id`
- `input_item_ids`
- `output_item_ids`
- `progress_ratio`
- `started_tick`
- `expected_finish_tick`
- `interruption_reason_tags`
- `stall_reason_tags`
- `quality_modifier_state`
- `contamination_risk_state`

Examples:
- boiling water
- drying meat
- smoking food
- crafting basket
- shaping crude clay vessel
- building shelter segment

### 23.2 Process commit rule

On load, process state must be one of:
- resumable as-is
- rolled back to pre-start if the process is atomic and had not committed inputs
- advanced to a clean post-commit state if it had completed before the save boundary

Never load a process into a half-consumed impossible state.

---

## 24. `event_state`

This section stores only **active or still-relevant** events/incidents.

Do not dump a full long-term event history into the save file unless explicitly needed later.

Suggested fields:
- `active_event_records`
- `scheduled_event_records`
- `weather_alert_records`
- `newcomer_arrival_state`
- `injury_followup_records`
- `decay_cleanup_queue`

Per-event fields:
- `event_id`
- `event_type`
- `event_state`
- `created_tick`
- `scheduled_tick`
- `expires_tick`
- `target_refs`
- `severity_class`
- `resolution_state`

Examples:
- incoming rain burst
- newcomer arrival pending
- wound infection risk watch
- latrine overflow warning
- food stock emergency alert

---

## 25. `ui_player_state`

Persist only what meaningfully improves continuation.

Suggested fields:
- `camera_center_cell`
- `camera_zoom_level`
- `active_map_mode` (`aerial`, `topographic`, `hybrid`, `debug`)
- `overlay_visibility_flags`
- `selected_entity_ref`
- `pinned_panel_refs`
- `tracked_alert_filters`
- `last_opened_tab_id`
- `pause_speed_state`

Do **not** let UI state bloat the save or become load-critical.
If this section is missing, the save should still load.

---

## 26. `validation_state`

This section exists to help corruption checks and dev diagnosis.

Suggested fields:
- `payload_sha256`
- `entity_counts_summary`
- `required_section_presence`
- `last_validation_result`
- `writer_build_version`
- `writer_machine_time_utc`

Recommended `entity_counts_summary` contents:
- npc count
- item count
- structure count
- zone count
- active task count
- active process count
- changed cell count
- explored cell count

### 26.1 Validation should not become a blocker for healthy saves

If one noncritical derived count is missing, the save may still be loadable.
If the payload root is malformed or authoritative records are missing, reject it.

---

## 27. What should be rebuilt on load

Rebuild these after the authoritative state is loaded:

- pathfinding grids
- movement-cost overlays
- hillshade and contour render textures
- fog render masks
- frontier list if not persisted
- route desirability overlays
- candidate task caches
- UI sorting/filter caches
- debug aggregates
- telemetry rolling windows

The save file should not become a dump of every cache the runtime can derive.

---

## 28. Load procedure

Recommended load flow:

1. Read slot manifest.
2. Attempt to read `save_current.json`.
3. If current save fails integrity, attempt `save_prev_backup.json`.
4. Parse JSON.
5. Validate root sections and version compatibility.
6. Establish session fingerprint and compatibility mode.
7. Reconstruct authoritative world/settlement/entity records.
8. Rebuild non-authoritative caches and render helpers.
9. Re-link references:
   - item holders
   - structure storage slots
   - active task assignments
   - process host bindings
   - fog/memory overlays
10. Run post-load validation pass.
11. If validation passes, enter play.
12. If validation fails critically, refuse load and explain why.

---

## 29. Post-load validation checklist

Immediately after load, validate at minimum:

### 29.1 Referential integrity
- every referenced `npc_id` exists
- every referenced `item_instance_id` exists
- every structure/zone/task/process reference resolves
- every holder reference is legal

### 29.2 Spatial integrity
- all occupied cells exist in map bounds
- all structure footprints are valid
- no item has contradictory location ownership
- no NPC stands in a permanently invalid cell unless a known recovery rule exists

### 29.3 Task/process integrity
- no task assigned to dead/missing NPC
- no reservation points to deleted target
- no process references missing inputs without a valid stall reason
- no structure build state missing required progress records

### 29.4 Settlement integrity
- stage ID is valid
- reserve summaries can be recomputed
- food/water/fuel counts are nonnegative
- stage blockers can be recomputed without crash

### 29.5 World-memory integrity
- visible cells are a subset of explored cells or can be promoted cleanly
- feature knowledge references known feature IDs
- fog state values are legal
- frontier can be regenerated

If post-load validation finds only recoverable issues, load may continue with a warning and a telemetry record.

---

## 30. Recovery rules

Recommended recoverable fixes:
- stale frontier list -> rebuild
- invalid selected UI entity -> clear selection
- old overlay flag set missing new field -> default it
- resumable path token invalid -> recalc path from current cell
- task references missing optional cache fields -> rebuild task helpers

Recommended hard-fail cases:
- missing root sections
- malformed JSON payload
- duplicate authoritative IDs in the same table
- item holder contradictions that cannot be resolved safely
- missing map dimensions/static reference
- incompatible schema version beyond allowed range

---

## 31. Autosave policy

Recommended v0.1 policy:
- one rolling autosave slot
- autosave only at stable boundaries
- autosave disabled during explicit catastrophic-failure popup states if desired
- autosave interval based on simulation time or real-time cadence, whichever proves saner in testing

Suggested defaults:
- autosave every 5 real minutes
- plus autosave at dawn
- plus autosave immediately after settlement stage promotion
- plus optional dev autosave before high-risk acceptance scenarios

### 31.1 Why autosave at dawn is useful

Dawn is a strong simulation checkpoint in this game because:
- overnight fire/sleep/exposure pressures have resolved
- daily planning can restart cleanly
- the player is less likely to reload into a confusing midnight crisis fragment

---

## 32. Quicksave and manual save policy

- manual save: always allowed at stable boundary
- quicksave: one rolling quicksave slot
- quickload: developer/testing convenience, optional in player release

Do not pause halfway through a mutation just to satisfy an instant save key.
Queue it to the next stable boundary instead.

---

## 33. Recommended ID handling rules

### 33.1 Definition IDs
Persist canonical definition IDs from the data dictionary:
- `item_def_id`
- `process_def_id`
- `structure_def_id`
- `knowledge_id`
- `task_def_id`

### 33.2 Runtime IDs
Persist stable runtime IDs for instances:
- `npc_id`
- `item_instance_id`
- `structure_id`
- `zone_id`
- `task_id`
- `process_id`
- `event_id`

### 33.3 Counters
Persist next-ID counters so newly spawned entities do not collide after load.

---

## 34. Recommended world-state strategy for v0.1

For the early game, use this hybrid persistence model:

### 34.1 Static baseline
- identified by seed + world profile + generator version
- may be embedded in save during hardening for robustness

### 34.2 Dynamic world deltas
- cell changes
- feature depletion/regrowth
- created paths
- built structures
- pollution/contamination marks
- planted/harvested plot changes

### 34.3 Map knowledge layer
- persisted separately from terrain truth
- includes fog state, memory quality, and feature trust

This keeps the architecture future-proof without forcing over-optimization now.

---

## 35. What should not be saved

Do **not** serialize these as authoritative truth:

- live profiler values
- temporary telemetry rolling windows
- A* internal buffers
- visual fog textures
- hillshade render targets
- temporary score breakdown arrays
- per-frame animation timers
- hovered tooltip state
- path preview lines
- camera easing momentum if it complicates load correctness
- obsolete events already fully resolved
- full long-term debug log history

At most, save only the minimal continuity information needed to rebuild them.

---

## 36. Minimal example root payload

```json
{
  "save_header": {
    "schema_name": "realistic_idle_city_save",
    "schema_version": "0.1.0",
    "save_uuid": "save_000123",
    "slot_id": "slot_000",
    "slot_type": "manual",
    "saved_at_utc": "2026-04-09T18:20:00Z"
  },
  "session_fingerprint": {
    "build_version": "0.1.0-dev",
    "content_version": "0.1.0",
    "balance_version": "0.1.0",
    "world_gen_version": "0.1.0",
    "seed_world": 48219015,
    "seed_events": 9001772,
    "scenario_profile_id": "temperate_stream_edge_mvp"
  },
  "simulation_clock": {
    "sim_tick": 183420,
    "day_index": 7,
    "season_id": "late_spring",
    "weather_state": "light_rain"
  },
  "rng_state": {
    "rng_world_state": "..."
  },
  "world_static_ref": {
    "map_id": "map_local_0001",
    "map_width": 192,
    "map_height": 192,
    "embedded_static_snapshot_present": true
  },
  "world_dynamic_state": {
    "changed_cells": [],
    "feature_instances": []
  },
  "map_memory_state": {
    "cell_memory": [],
    "feature_knowledge": []
  },
  "settlement_state": {
    "settlement_id": "stl_0001",
    "current_stage_id": "stage.primitive_camp",
    "population_count": 2
  },
  "npc_state": {
    "npc_records": []
  },
  "item_state": {
    "item_records": []
  },
  "structure_state": {
    "structure_records": []
  },
  "zone_state": {
    "zone_records": []
  },
  "task_state": {
    "task_records": [],
    "order_records": [],
    "reservation_records": []
  },
  "process_state": {
    "process_records": []
  },
  "event_state": {
    "active_event_records": []
  },
  "ui_player_state": {
    "camera_zoom_level": 1.0,
    "active_map_mode": "hybrid"
  },
  "validation_state": {
    "entity_counts_summary": {
      "npc_count": 2,
      "item_count": 34
    }
  }
}
```

---

## 37. Godot-facing implementation guidance

### 37.1 Storage path
Use `user://` for save data.

### 37.2 IO APIs
Use `FileAccess` for reading/writing files and `DirAccess` for slot directories and file replacement flow.

### 37.3 Serialization
Use JSON text serialization for v0.1 save payloads.
Keep save data as plain primitives/arrays/objects instead of engine-specific opaque objects.

### 37.4 Future-friendly option
If later the project wants:
- compressed saves
- binary saves
- resource-based save objects
- cloud transport packing

those can be layered on top of the same logical schema rather than changing the simulation truth model.

---

## 38. Acceptance requirements for the save system

The save/load system passes v0.1 only if all of the following are true:

1. A healthy in-progress settlement can be saved and reloaded without entity loss.
2. A critical crisis state can be saved and reloaded without changing the underlying danger.
3. Fog-of-war / explored memory remains intact across reload.
4. Item locations and reserve protection remain intact across reload.
5. In-progress tasks and processes either resume correctly or reset cleanly with explicit explanation.
6. Autosave failure does not delete the last known-good save.
7. Slot manifest never points at a broken current save as if it were healthy.
8. Post-load validation can explain why a failed save is rejected.
9. Session fingerprint metadata survives save/load/export correctly.
10. The loaded game continues from the same simulation truth, not from a hand-waved approximation.

---

## 39. Recommended next engineering step

After this schema, the strongest follow-up is a **Godot Save/Load Implementation Plan v0.1** that defines:
- save service class breakdown
- snapshot builders per domain
- validation pipeline
- backup rotation logic
- post-load relinking order
- acceptance test harness for corruption/recovery cases

That is the shortest path from this schema to working code.
