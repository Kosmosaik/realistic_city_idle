# Realistic Idle City — Godot Bootstrap / First Sprint Implementation Plan v0.2
_Last synced:_ 2026-04-17  
_Status:_ historical implementation plan, updated to reflect current repo state

## 1. Purpose

This document records the implementation plan that established the project’s first real bootstrap/runtime path.

It remains important because many current systems still inherit their architectural contract from this sprint:
- definition-driven bootstrap
- active scenario selection
- authoritative runtime world state
- explicit separation of runtime truth from presentation/debug UI

This file is now partly **historical**, because the project has already moved beyond the first sprint.
It has been retained and synced so it stays useful instead of misleading.

---

## 2. Current status summary

The first-sprint/bootstrap goals are complete enough to close.

What now exists in the repo:
- definition registry and validation flow
- scenario / stage / map preset / worldgen / season bootstrap
- authoritative `WorldState` runtime foundation
- authored map loading into runtime cells/patches/reveal sources/terrain objects
- authoritative terrain rendering and terrain inspection/debug overlays
- cleaned-up helper modules extracted during Branch 05

This means the bootstrap sprint should no longer be treated as the active work branch.

---

## 3. What changed after the original plan

After the original bootstrap work, the project continued through authored-world and renderer/debug branches.

Notable follow-on architecture now present:
- `AuthoredMapLoader` is no longer carrying every sub-responsibility alone
- terrain overlay/debug state is explicitly modeled and presentation-aware
- HUD formatting and some utility concerns were split into dedicated helpers
- the repo no longer depends on the retired placeholder world path

---

## 4. Stable architectural outcomes from this sprint

These remain the important takeaways from the first sprint:

### 4.1 Definitions drive bootstrap
Scenarios and related content should still be resolved through definitions/resources, not hardcoded scene setup.

### 4.2 Runtime world truth is authoritative
World cells, patches, reveal sources, and terrain-object validation live in runtime state, not in decorative renderer-only structures.

### 4.3 Presentation should remain a consumer
Terrain rendering, overlays, HUDs, and inspectors should continue consuming runtime truth instead of inventing parallel state.

### 4.4 Save migration is not a priority during this phase
Current save files remain disposable during this hardening/prototype stage unless explicitly elevated later.

---

## 5. Current file/status interpretation

When this document mentions earlier bootstrap targets, interpret them as:
- **implemented**
- **validated enough for current prototype scope**
- **not the immediate next branch**

The immediate next branch is no longer “finish bootstrap.”  
It is now **procedural terrain generation foundation**.

---

## 6. Branch 05 closeout note

Branch 05 addressed the main cleanup debt that had accumulated after the original bootstrap sprint:
- modular helper extraction from larger scripts
- repo artifact cleanup
- implementation-doc sync
- final pre-procgen hardening pass

So the bootstrap stack should now be considered a **stable platform** rather than an active refactor target.

---

## 7. Use this document together with

Read this file together with:
- `docs/realistic_idle_city_development_roadmap_v0_1.md`
- `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
- `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`

Those documents reflect the current branch direction more directly.

---

## 8. Final note

Do not reopen the first sprint as a broad cleanup/refactor project.
Keep using its contracts, but direct new implementation effort into the next world-generation branch.
