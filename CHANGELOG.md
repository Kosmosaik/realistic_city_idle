# Changelog

All notable changes to this project should be documented in this file.

The format is intentionally simple and project-oriented.

## [Branch 04 - authoritative-renderer-camera-overlays-fog]

### Added
- authoritative terrain presentation path driven by loaded `WorldState`
- `authoritative_terrain_renderer.gd`
- `terrain_overlay_renderer.gd`
- `terrain_overlay_outline_renderer.gd`
- `world_camera_controller.gd`
- `world_cell_inspector_probe.gd`
- `terrain_inspector_panel.gd`
- authoritative world-root composition through `WorldRootController`
- overlay cycling and legend/debug readout support
- overlay modes for:
  - elevation
  - drainage
  - wetness
  - vegetation
  - buildability
  - site score
  - patch boundaries
  - fog memory
- fog-of-war / remembered-terrain presentation driven by runtime visibility state
- camera pan/zoom controls for reading the authored map at multiple scales
- terrain cell inspection by hover/select
- optional site-hint visibility and force-full-visibility debug toggles

### Changed
- world rendering now reads authoritative terrain/runtime truth instead of a decorative placeholder path
- `SimRoot` debug world snapshot now exposes richer world / overlay / visibility state
- dev HUD now surfaces current overlay mode, visibility counts, camera state, cell inspection details, and world debug snapshots
- world root setup now programmatically ensures the active renderer, overlay renderer, outline renderer, inspector probe, terrain inspector panel, camera, and HUD exist together

### Fixed
- renderer stack alignment issues by separating base terrain, overlay fills, and overlay outlines into distinct presentation layers
- debug readability by exposing overlay legend/help text directly in the HUD
- terrain inspection flow by wiring hover/selection against authoritative cell lookup instead of decorative pixels

### Notes
- Branch 04 is complete enough to close
- the old placeholder map path should now be treated as retired / disposable
- immediate next branch: **Branch 05 — audit and cleanup**
- preferred next feature direction after cleanup: **terrain procgen foundation**, using the terrain branch plan as the guide

## [Branch 03 - authoritative-world-data-and-authored-maps]

### Added
- authoritative world runtime types:
  - `WorldState`
  - `WorldCellState`
  - `WorldChunkState`
  - `WorldPatchState`
  - `WorldRevealSourceState`
- `AuthoredMapLoader` for loading authored world fixtures into runtime truth
- authored map fixture pipeline under `data/world/authored_maps/`
- authored patch stamping and patch summaries
- authored reveal-source loading
- generation warning capture in world runtime
- `WorldVisibilityService` for runtime visibility refresh based on reveal sources
- `SimRoot` world registration / load path for resolved map preset + worldgen context
- current starter authored reference map fixture: `starter_map_balanced.json`

### Changed
- Branch 03 moved the project from “bootable shell with placeholder world” to “authoritative world data that presentation reads”
- world cells now carry terrain, buildability, movement, patch-link, and fog/reveal fields
- patches now expose debug-friendly area / dominant-terrain / site-score summaries
- the branch was proved with authored content first rather than jumping directly to procgen

### Fixed
- world load failure reporting now surfaces more clearly through bootstrap/runtime state
- visibility refresh is now part of the deterministic phase flow instead of an ad-hoc scene concern
- authored data validation catches malformed fixture content earlier

### Notes
- Branch 03 is complete enough to close
- the current repo contains one authored reference map; extra authored maps remain optional follow-up content, not blockers for closing the branch
- Branch 04 then proved that this authoritative world path can render, inspect, and debug correctly

## [Branch 02 - simulation-clock-and-run-loop]

### Added
- deterministic run-loop execution in `TimeService`
- stable phase vocabulary and ordered phase execution for:
  - command intake
  - time-step start
  - world pre-update
  - simulation update
  - visibility refresh
  - debug snapshot
  - end-of-tick bookkeeping
- pause / resume controls
- speed controls
- single-step debug control
- phase listener registration API for external systems
- queued-command runtime queue and processing path
- scheduled-trigger runtime queue and resolution path
- deterministic debug signature/event stream for run reproducibility checks
- debug visibility for:
  - current/latched phase state
  - per-phase durations
  - recent phase history
  - scheduled trigger queue preview
  - processed command queue preview
  - determinism event counters/signature
- external scheduled-trigger probe node to prove that:
  - external systems can schedule triggers
  - resolved triggers can enqueue commands
  - commands enqueued after command-intake resolve on the next tick
- scrollable dev HUD layout so the full Branch 02 debug surface remains readable

### Changed
- `TimeService` moved from bootstrap-only calendar holder to authoritative Branch 02 clock/run-loop service
- `SimRoot` boot context now exposes the richer Branch 02 calendar snapshot
- dev HUD now reflects Branch 02 runtime state instead of only Branch 01 bootstrap state
- runtime debug surface is now centered on deterministic inspection rather than only startup validation

### Fixed
- active phase visibility problem where live phase transitions were too fast to see clearly in the HUD
- dev HUD clipping problem by making the panel scrollable
- run-loop debug readability by latching visible phase/tick/transition values and recent queue history

### Notes
- Branch 02 is complete enough to close
- Branch 02 intentionally does **not** implement authoritative world cells, authored-map loading, or fog-of-war state; that arrived in Branch 03–04

## [Branch 01 - core-definitions-and-ids]

### Added
- `DefinitionRegistry` autoload and startup validation pipeline
- shared runtime state helpers:
  - `calendar_ids.gd`
  - `definition_types.gd`
  - `id_rules.gd`
  - `policy_bundle_ids.gd`
  - `shared_enums.gd`
  - `task_def_ids.gd`
  - `zone_types.gd`
- definition resource classes for:
  - stages
  - skills
  - items
  - processes
  - structures
  - scenarios
  - map presets
  - species
  - terrain profiles
  - worldgen profiles
  - season profiles
  - incidents
  - UI panels
- startup bootstrap resolution through:
  - `ScenarioDef`
  - `WorldgenProfileDef`
  - `SeasonProfileDef`
  - `MapPresetDef`
- visible definition validation status in the dev HUD
- on-screen boot failure panel for broken definitions/bootstrap chains
- canonical seed definition pack for the early-game MVP
- current definition pack size: **122 validated definitions**

### Changed
- `SimRoot` now resolves active bootstrap context from definitions
- `TimeService` now adopts calendar defaults from `SeasonProfileDef`
- dev HUD now shows:
  - scenario ID
  - stage ID
  - map preset ID
  - worldgen profile ID
  - season profile ID
  - seed
  - calendar snapshot
  - definition validation counts
- scenario resources now explicitly point at `worldgen_profile_id`
- startup validation now checks scenario/worldgen/map/season coherence

### Fixed
- definition files placed in the wrong family folder now fail loudly
- grey-screen boot failures replaced with readable failure UI
- constant-expression issues from `PackedStringArray([...])` in `const` declarations
- multiple early ID drift problems in skills/items/processes/structures

### Notes
- Branch 01 is complete enough to close
- deterministic ticking and pause/step controls were implemented later in Branch 02

## [Branch 00 - repo-bootstrap]

### Added
- initial Godot project bootstrap shell
- project folder structure aligned to the current architecture docs
- autoload service layer:
  - `EventBus`
  - `TelemetryService`
  - `SaveService`
  - `TimeService`
  - `SimRoot`
  - `AppRoot`
- boot scene and dev world scene
- compact debug HUD showing:
  - build version
  - current scene
  - scenario ID
  - seed
  - stage ID
  - year/day/season/part-of-day
- HUD toggle with **F3**
- placeholder synthetic aerial-style world renderer
- seeded tree placement pass
- site hint debug marker
- zoomed-out world camera

### Changed
- bootstrap singleton access stabilized through `/root/...` lookup
- bootstrap scripts updated to use explicit local typing where needed
- placeholder tree placement now avoids:
  - open river water
  - pond water
  - overlapping tree placement
  - site-clearance radius
- debug HUD made smaller and less intrusive

### Fixed
- autoload registration/class-name collision issue
- `SimRoot` lookup/parsing issue in the placeholder map path
- inferred-type parser errors in bootstrap scripts

### Notes
- initial map rendering was placeholder/debug presentation only
- no survival gameplay systems are implemented yet
