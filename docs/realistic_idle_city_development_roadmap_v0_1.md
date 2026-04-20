# Realistic Idle City — Development Roadmap v0.1
_Last synced:_ 2026-04-17  
_Current status focus:_ Branch 05 closed, Branch 06 next

## 1. Roadmap purpose

This roadmap tracks the implementation-facing branch order for the current Godot prototype.

It is not the full game-design roadmap.
It is the **engineering progression roadmap** for getting the project from bootstrap foundations into believable world generation and then into deeper settlement systems.

---

## 2. Current branch status

### Complete enough to close
- Branch 00 — bootstrap + definitions foundation
- Branch 01 — active scenario bootstrap
- Branch 02 — authoritative runtime/state wiring
- Branch 03 — authored world bootstrap
- Branch 04 — authoritative terrain rendering + debug inspection
- Branch 05 — audit, cleanup, modular hardening, docs sync

### Immediate next branch
- **Branch 06 — procedural terrain generation foundation**

---

## 3. What Branch 05 accomplished

Branch 05 was intentionally a cleanup/hardening branch, not a feature-explosion branch.

It resolved or confirmed:
- no active dependency on the retired placeholder renderer path
- no temp `test_world_scene.tscn*.tmp` artifacts in the working repo
- authored map loading split into smaller responsibilities
- time-service support logic split into smaller helpers
- overlay/debug visual metadata centralized
- implementation-facing docs updated to match the real repo state

This is the point where it makes sense to transition into procedural terrain generation.

---

## 4. Active roadmap order

## Branch 06 — procedural terrain generation foundation
Goal:
- add the first procedural starter-area world-build path **without breaking authored-map support**

Primary objectives:
- keep the current authored world path fully functional
- introduce a procedural world-build orchestrator that outputs the same `WorldState` contract
- derive elevation/relief first, then hydrology, drainage, wetness, vegetation, patches, and site candidates
- keep reveal/bootstrap logic separate from terrain paint semantics
- validate starter-map survivability with deterministic checks

Expected outputs:
- first procedural worldgen profile/resource set
- first procedural terrain generation config/resource set
- procedural world build integrated into bootstrap through definitions
- debug overlays/inspector working on authored and procedural maps alike

## Branch 07 — procgen expansion and starter-area quality
Goal:
- improve terrain variety and quality once the first procedural path is stable

Likely scope:
- stronger landform variation
- better patch semantics
- improved terrain object seeding
- better candidate-site scoring and validation
- more than one viable terrain-generation profile

## Branch 08 — early survival systems deepen against procgen worlds
Goal:
- use the procedural maps to pressure-test realism and survival gameplay

Likely scope:
- camp placement pressure
- terrain-sensitive hauling / path costs
- water / wet ground / buildability consequences
- stronger interaction between map affordances and early player actions

---

## 5. Non-goals for the immediate next branch

The next branch should **not**:
- rewrite the existing authored loader path
- bypass `WorldState` with renderer-only shortcuts
- add continent-scale map generation
- jump straight into decorative procgen before hydrology/site logic exists
- merge broad design docs just because they overlap in topic

---

## 6. Recommended reading order for Branch 06

1. `README.md`
2. `CHANGELOG.md`
3. `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
4. `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
5. `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
6. `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`
7. supporting terrain/spec/design docs as reference

---

## 7. Final roadmap note

The project does **not** need a large refactor before continuing.
The correct next move is to build procedural terrain generation on top of the cleaned, authored-world-backed runtime contract that now exists.
