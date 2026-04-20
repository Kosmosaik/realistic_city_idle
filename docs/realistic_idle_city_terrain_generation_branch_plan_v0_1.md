# Realistic Idle City — Terrain Generation Branch Plan v0.1
_Last synced:_ 2026-04-17  
_Status:_ retained as a bridge/history document; superseded as the active next-step plan by `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`

## 1. Purpose

This document originally mapped the project from authored-world/bootstrap work toward future terrain generation work.

That bridge job has now largely been completed:
- the authored-world runtime path exists
- the authoritative terrain renderer exists
- the debug HUD / terrain inspector / overlay tooling exists
- Branch 05 cleanup/hardening is complete enough to close

So this file should now be read mainly as **historical branch-bridge context**, not as the primary active branch checklist.

---

## 2. Current interpretation

### What this document got right
It correctly anticipated that the project should:
- prove a world contract with authored maps first
- avoid jumping straight into full procgen too early
- perform a cleanup/hardening pass before starting terrain generation

That sequence still stands.

### What has changed
The active next branch is no longer a vague future terrain branch.
It is now explicitly:

**Branch 06 — procedural terrain generation foundation**

Use the newer implementation plan doc for concrete next-branch execution details.

---

## 3. Current branch progression

### Closed enough to move past
- bootstrap/definitions foundation
- active scenario bootstrap
- authoritative world-state groundwork
- authored-map terrain/world bootstrap
- authoritative terrain rendering and debug inspection
- branch 05 cleanup / modular hardening / doc sync

### Active next step
- procedural terrain generation foundation

---

## 4. What remains valid from the older branch logic

These older principles remain authoritative:
- generated terrain must produce the same runtime world contract the authored maps already proved out
- hydrology and buildability matter more than decorative randomness
- site viability must be checked through simulation-facing data, not marker hacks
- broader terrain variety should come after the first stable starter-area generator

---

## 5. Where to go now

For actual next-branch implementation work, use:
- `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`
- `docs/realistic_idle_city_terrain_generation_spec_v0_1.md`
- `docs/realistic_idle_city_world_generation_map_rendering_spec_v0_1.md`
- `docs/realistic_idle_city_design_documents/realistic_idle_city_world_map_site_generation_spec_v0_1.md`

---

## 6. Final note

This file is still useful for context, but it should no longer be the main execution document for terrain work.
