# Realistic Idle City — Documentation Audit and Sync Note v0.1
_Last synced:_ 2026-04-17

## Purpose

This note records the current documentation-sync position after Branch 05 closeout.

It replaces the earlier “post-Branch-04 sync” interpretation with the current state:
- Branch 05 cleanup/hardening is complete enough to close
- implementation-facing docs have been re-synced
- the next active branch is procedural terrain generation foundation

---

## 1. Current documentation verdict

The documentation stack is still **large but useful**.

The main problem was never massive true duplication.
The main problem was **status drift** in implementation-facing documents.

That drift is now reduced by syncing the files most likely to mislead the next developer/assistant.

---

## 2. What was updated in this sync

Implementation-facing status docs updated:
- `README.md`
- `CHANGELOG.md`
- `docs/realistic_idle_city_development_roadmap_v0_1.md`
- `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
- `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
- `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md`

New next-branch execution doc added:
- `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`

---

## 3. Repo-state confirmations behind this sync

Confirmed in the current source-of-truth zip:
- no `map_placeholder.gd` remains in the active repo
- no temp `scenes/world/test_world_scene.tscn*.tmp` files remain
- the current active terrain path is the authoritative runtime-driven renderer path
- branch-05 modularization helpers are present in the codebase

---

## 4. What is layered overlap vs real duplication

### Mostly layered overlap
Most broader design docs still overlap by topic, but not by function.
They are looking at the project from different design angles:
- realism and daily life
- player actions and gameplay structure
- early-game progression realism
- terrain/world generation
- data contracts and system flow

That is acceptable.

### The biggest practical overlap area
The terrain docs still have the most topic overlap:
- terrain generation spec
- world generation / map rendering spec
- terrain debug/schema overlay plan
- site generation spec

That is still acceptable **as long as the implementation-facing next-step doc stays clear**.
The new procedural terrain implementation plan now fills that role.

---

## 5. Recommended reading order now

1. `README.md`
2. `CHANGELOG.md`
3. `docs/realistic_idle_city_development_roadmap_v0_1.md`
4. `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
5. `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
6. `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
7. `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`
8. older design/spec docs as supporting context

---

## 6. Final position

The project is not suffering from “too many useless docs.”
It mainly needed implementation/status documents brought back in line with the current repo.

That is now done enough for the next branch transition.
