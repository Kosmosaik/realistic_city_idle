# RealisticCityIdle

RealisticCityIdle is a realism-first colony / settlement simulation in Godot focused on grounded early-game survival, camp formation, and the transition toward a small permanent settlement.

The project uses:
- externalized definitions in `data/defs`
- authoritative runtime state in `scripts/runtime`
- presentation/debug layers in `scripts/presentation`
- bootstrap/autoload orchestration in `autoload`

The current playable technical baseline is a **definition-driven authored world bootstrap** with:
- scenario / stage / map preset / worldgen profile resolution
- authoritative `WorldState`, `WorldCellState`, `WorldPatchState`, and reveal-source runtime data
- authored fixture loading into world runtime truth
- terrain rendering from runtime state rather than placeholder visuals
- dev HUD / terrain inspector / overlay tooling for debugging terrain semantics

---

## Current project status

### Branches completed enough to close
- Branch 00 — bootstrap and definitions foundation
- Branch 01 — active scenario bootstrap and world start flow
- Branch 02 — authoritative runtime + early debug wiring
- Branch 03 — authored terrain/world bootstrap
- Branch 04 — authoritative renderer + inspection/debug layers
- Branch 05 — audit, cleanup, modular hardening, documentation sync

### Immediate next branch
**Branch 06 — procedural terrain generation foundation**

Branch 05 was the hardening pass before procgen.  
The next branch should build the first procedural starter-area generator **on top of the already-proven authored world contract**, not replace it.

---

## What Branch 05 locked down

Branch 05 focused on architectural cleanup rather than new gameplay scope.

Key outcomes now reflected in the codebase:
- stale placeholder-world leftovers removed
- temp scene artifacts removed
- authored map loading responsibilities split into smaller modules
- time-service helper responsibilities extracted into dedicated queue/stream helpers
- dev HUD formatting extracted from the HUD controller
- terrain overlay mode metadata centralized in a dedicated visual-config helper
- scene/script lookup helpers centralized where appropriate
- docs brought back in sync with the real repo state

This means the project is now in a better place to start procedural terrain work without first paying off avoidable cleanup debt.

---

## Source-of-truth reading order

Use this order when resuming implementation work:

1. `README.md`
2. `CHANGELOG.md`
3. `docs/realistic_idle_city_development_roadmap_v0_1.md`
4. `docs/realistic_idle_city_godot_bootstrap_first_sprint_implementation_plan_v0_2.md`
5. `docs/realistic_idle_city_godot_project_scene_architecture_v0_1.md`
6. `docs/realistic_idle_city_godot_class_file_responsibility_matrix_v0_1.md`
7. `docs/realistic_idle_city_procedural_terrain_generation_implementation_plan_v0_1.md`
8. older terrain/spec/design docs as supporting reference material

---

## Important development rules

- Treat the latest project zip / working copy as the only source of truth.
- Prefer data-driven definitions over hardcoded gameplay content.
- Keep runtime world truth separate from rendering/debug UI.
- Do not bypass `WorldState` with renderer-only shortcuts.
- Do not replace authored-map support when adding procgen; add procgen as a second world-build path using the same runtime contract.
- Keep save compatibility low-priority during this hardening/prototype phase unless explicitly requested otherwise.

---

## Short next-step summary

The next implementation branch should:
1. keep the authored-map pipeline working unchanged
2. introduce a procedural world-build pipeline beside it
3. generate the same runtime world fields that the renderer/debug tools already understand
4. validate starter-map survivability through structured generation checks rather than decorative randomness
