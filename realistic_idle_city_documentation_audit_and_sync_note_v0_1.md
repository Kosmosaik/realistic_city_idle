# Realistic Idle City — Documentation Audit and Sync Note v0.1

## Purpose

This note records the documentation sync performed after Branch 04 and explains what was actually stale, what was only overlapping, and what the immediate cleanup branch should watch.

---

## 1. Audit result summary

Reviewed scope:
- root status docs
- roadmap / implementation / architecture docs
- terrain branch-planning docs
- broader design-doc stack under `docs/realistic_idle_city_design_documents/`

High-level result:
- the doc stack is **large**, but not wildly redundant
- the main problem was **status drift**, not design-doc duplication
- several implementation/status docs were still describing the project as if it had only finished Branch 02
- the current codebase is already meaningfully beyond that

Main stale areas found:
- README status
- changelog status
- roadmap status
- first sprint implementation plan status
- scene architecture note
- class/file responsibility matrix
- terrain branch-plan intro/mapping

---

## 2. What was actually duplicated vs what was just layered

### Not true duplication
Most of the broader design docs are not literal duplicates.
They are different views of the same project from different angles:
- realism / daily life
- player actions and UI
- early-game realism audits
- terrain generation
- data dictionary
- system flow
- save/load planning

That overlap is acceptable because those files are serving different design questions.

### Closest overlap
The closest overlap remains:
- `realistic_idle_city_terrain_generation_spec_v0_1.md`
- `realistic_idle_city_terrain_data_schema_debug_overlay_plan_v0_1.md`

Even there, they still have different jobs:
- one is the broader terrain-generation design/spec view
- one is closer to implementation/schema/debug-overlay planning

Recommendation:
- keep both for now
- do **not** merge them during the cleanup branch unless they start drifting badly in content, not just topic

---

## 3. What needed syncing right now

These were the key files updated in this sync:
- `README.md`
- `CHANGELOG.md`
- `docs/realistic_idle_city_development_roadmap_v0_1.md`
- `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
- `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
- `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md`

Reason:
these are the files most likely to mislead the next developer/GPT if they remain stale.

---

## 4. Repo cleanup targets observed during audit

### Confirmed documentation-level cleanup targets
- stale references to the old placeholder map path in status/architecture docs
- stale “next active branch = Branch 03” or “Branch 04 not started” wording
- stale “after Branch 02” wording in implementation-facing docs

### Repo artifact cleanup targets
- `scenes/world/test_world_scene.tscn*.tmp`

### Placeholder renderer note
The provided zip still included `scripts/presentation/world/map_placeholder.gd`, but the user stated that it had already been removed from the live working copy after the zip was made.

Documentation should therefore now treat that path as:
- retired
- disposable
- not part of the current architecture

---

## 5. Recommended source-of-truth reading order for the next branch

For the next assistant/developer, the most important reading order should be:

1. `README.md`
2. `CHANGELOG.md`
3. `docs/realistic_idle_city_development_roadmap_v0_1.md`
4. `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
5. `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
6. `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
7. `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md`
8. broader design docs as needed for realism/detail context

That keeps implementation work anchored to the current repo reality first.

---

## 6. Immediate branch recommendation

The correct immediate branch is:

## Branch 05 — audit-and-cleanup

Why:
- Branch 03 and Branch 04 are complete enough to close
- the project already has a usable authoritative world + renderer path
- continuing feature work immediately from a stale branch-close state would create avoidable confusion

The cleanup branch should stay short and focused.

---

## 7. Final position

This was mainly a **status-sync problem**, not a “throw away half the docs” problem.

The doc stack is still useful.
It just needed the implementation-facing files brought back in line with the actual codebase.
