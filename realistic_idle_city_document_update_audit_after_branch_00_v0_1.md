# Realistic Idle City — Document Update Audit After Branch 01 v0.2

> Filename retained for replacement convenience. Content now reflects the project **after Branch 01**, not after Branch 00.

## Purpose

This document records which project documents were updated after the **Branch 01 — core definitions and IDs** implementation pass, which documents can remain unchanged for now, and what should be revisited next.

It exists to:
- keep the documentation set honest
- avoid stale implementation guidance
- make handoff to the next assistant cleaner
- prevent unnecessary edits to broader design docs that still remain valid

---

## 1. Audit result

### 1.1 Short answer

The documentation stack is still broadly healthy, but a specific set of implementation-facing documents needed updates after Branch 01.

The main reason is simple:
- Branch 00 is no longer the current implementation state
- Branch 01 is now complete enough to hand off
- the project has a real definition backbone, seed pack, and resolved bootstrap chain that older docs did not yet describe accurately

### 1.2 High-priority docs that required updates now

These needed updates because they are directly used for implementation and handoff:
- `README.md`
- `CHANGELOG.md`
- `realistic_idle_city_handoff_summary_after_branch_00_v0_1.md`
- `realistic_idle_city_document_update_audit_after_branch_00_v0_1.md`
- `realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
- `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
- `docs/realistic_idle_city_development_roadmap_v0_1.md`
- `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `docs/realistic_idle_city_unified_data_dictionary_v0_1.md`

### 1.3 Docs that can stay largely unchanged for now

These remain conceptually valid and do not need immediate edits just because Branch 01 finished:
- early-game design docs
- broader realism/design bibles
- later-era bridge specs
- save/load schema docs beyond noting that save/load is still mostly stubbed
- terrain/world-generation deep specs that are still for later branches

---

## 2. What Branch 01 actually accomplished

Branch 01 did much more than just “a few IDs.”

Implemented:
- `DefinitionRegistry` autoload
- canonical ID validation rules
- duplicate-ID detection
- cross-reference validation
- on-screen boot failure UI for broken definitions/bootstrap
- shared code vocabulary modules (`calendar_ids`, `definition_types`, `id_rules`, `policy_bundle_ids`, `shared_enums`, `task_def_ids`, `zone_types`)
- definition resource classes for 13 families
- early canonical seed pack now loading **122 definitions**
- explicit bootstrap resolution through scenario -> worldgen -> season -> map preset -> time bootstrap
- debug HUD visibility for the resolved bootstrap chain

This means the docs can no longer describe the project as merely “ready to begin Branch 01.”

---

## 3. What the updated docs now need to say

### 3.1 README
Should now say:
- Branch 01 is complete enough to hand off
- current next branch is Branch 02
- the current important folders include `scripts/core/defs/` and `scripts/runtime/state/`
- `DefinitionRegistry` is part of the autoload shell

### 3.2 Changelog
Should now include a Branch 01 section covering:
- definition system added
- bootstrap chain resolution added
- seed pack size and families
- visible validation and failure UI
- Branch 02 as the next planned branch

### 3.3 Handoff summary
Should now say:
- Branch 01 is done enough to hand off
- the project has a real data backbone
- the next assistant should start Branch 02
- the next assistant should not jump ahead into world model or gameplay depth

### 3.4 Document update audit
Should stop speaking as if Branch 00 were the latest implementation milestone and instead capture the post-Branch-01 state.

### 3.5 Implementation plan
Should now record:
- Branch 00 complete
- Branch 01 complete
- actual implementation result of Branch 01
- current next active branch is Branch 02
- SeedService was folded into `SimRoot`
- bootstrap resolution lives in `SimRoot` + `BootScene`, not a separate `scenario_bootstrapper.gd`

### 3.6 Development roadmap
Should now mark:
- Branch 00 complete
- Branch 01 complete
- Branch 02 next active branch

### 3.7 Architecture doc
Should now reflect the actual shell more accurately:
- `DefinitionRegistry` instead of a hypothetical `DefinitionDB`
- `SimRoot` instead of a generic `GameSession`
- current actual autoload set
- current bootstrap scene path and runtime flow

### 3.8 Unified Data Dictionary
Should now explicitly record the implemented ID families and fields used in Branch 01, including:
- `worldgen_profile_id`
- `season_profile_id`
- `incident_id`
- `ui_panel_id`
- current bootstrap context keys

---

## 4. What does not need urgent edits yet

The broader design documents inside `docs/realistic_idle_city_design_documents/` still should **not** be edited just because Branch 01 was implemented.

Reason:
- Branch 01 was a data/backbone pass, not a design-direction change
- those docs still describe the realism-first target correctly
- they become more relevant again once Branch 02–05 start

---

## 5. New branch-level audit conclusion

### Branch 01 audit result

**Branch 01 is successfully complete enough to hand off.**

It achieved the correct goals:
- canonical definition backbone exists
- vocabulary has a code home
- content pack seed set is large enough to anchor later work
- startup bootstrap is definition-driven
- bad definitions fail loudly

### What Branch 01 did not try to do

It correctly did **not** try to implement:
- simulation ticking
- authored world runtime model
- fog systems
- NPC survival logic
- task runtime execution

That restraint is a success, not a gap.

---

## 6. Recommended next document review point

Revisit the implementation-facing docs again after **Branch 02** lands.

At that point, the likely update targets will be:
- `CHANGELOG.md`
- `README.md`
- current handoff summary
- roadmap
- implementation plan
- telemetry/debug docs if new time-step observability is added

That is enough to keep the handoff clean and begin **Branch 02 — simulation-clock-and-run-loop** next.
