# Changelog

## 2026-04-17 — Branch 05 closeout, docs sync, and next-branch planning

### Summary
Branch 05 functioned as a hardening / cleanup pass before procedural terrain generation.  
The repo is now in a cleaner state for the next world-generation branch.

### Architecture / cleanup outcomes reflected in the repo
- removed stale placeholder-world leftovers from the active architecture path
- removed temp scene artifacts from the repo working set
- kept authored-map bootstrap as the authoritative world-load path

### Runtime modularization
- authored map loading responsibilities were split into smaller helpers:
  - `AuthoredMapStampApplicator`
  - `AuthoredRevealSourceLoader`
  - `AuthoredTerrainObjectLoader`
  - `AuthoredMapFixtureValidator`
- time-service support responsibilities were split into helper modules:
  - `TimeCommandQueue`
  - `TimeTriggerQueue`
  - `TimeRandomStreamManager`

### Presentation / debug modularization
- extracted `DevHudTextFormatter` from the main HUD controller
- centralized overlay-mode metadata and legends in `TerrainDebugVisualConfig`
- centralized presentation-side SimRoot lookup utility in `SimRootLocator`
- kept terrain inspector / overlay systems aligned to SimRoot debug state

### Documentation sync
Updated the implementation-facing docs so they now match the current repo reality:
- `README.md`
- `docs/realistic_idle_city_development_roadmap_v0_1.md`
- `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
- `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
- `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
- `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md`

### Next step
- Branch 06 should begin the first procedural terrain generation implementation using the already-proven authored-world runtime contract.

---

## 2026-04-14 — Branch 04 closeout and documentation sync

### Summary
Branch 04 completed the move from earlier bootstrap/testing world rendering toward an authoritative terrain presentation path backed by runtime world data.

### Key outcomes
- the terrain renderer now reads runtime terrain truth instead of relying on a placeholder-only path
- dev/debug tooling for terrain inspection is in place
- branch-closeout docs were synced to the Branch 04/05 transition state

### Notes
- Branch 05 was reserved for audit/cleanup before procedural terrain work
- broader design docs remained intentionally layered rather than fully merged

---

## 2026-04-13 — Branch 02 closeout

### Summary
Branch 02 consolidated the authoritative runtime/bootstrap path so later world rendering and authored-world work could build on a cleaner simulation core.

### Key outcomes
- active scenario bootstrap became more coherent
- the runtime side became more explicit and easier to inspect
- docs and handover notes were updated for the next branch transition

---

## 2026-04-10 — Branch 01 closeout

### Summary
Branch 01 established the first real end-to-end bootstrap flow for the project.

### Key outcomes
- active scenario bootstrap flow in place
- early project docs synced to match the implementation reality
- branch-close audit and handover completed
