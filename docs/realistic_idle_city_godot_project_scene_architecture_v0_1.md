# Realistic Idle City — Godot Project / Scene Architecture v0.1

## Purpose

This document describes the practical architecture currently intended for the early-game MVP and notes the parts that are already implemented after Branch 01.

It should be read as both:
- an architecture guide
- a reality check against the current project shell

---

## 1. Current implementation snapshot after Branch 01

Implemented shell pieces:
- boot scene
- dev world scene
- placeholder world presentation
- debug HUD
- small autoload service layer
- definition registry
- definition-driven bootstrap resolution

Current autoloads:
- `AppRoot`
- `SimRoot`
- `TimeService`
- `EventBus`
- `DefinitionRegistry`
- `TelemetryService`
- `SaveService`

Current runtime flow:
1. `scenes/bootstrap/boot_scene.tscn`
2. definitions reload and validate
3. `SimRoot` resolves scenario -> worldgen -> season -> map preset bootstrap context
4. `TimeService` adopts season-profile bootstrap defaults
5. app transitions into `scenes/world/test_world_scene.tscn`

---

## 2. Architectural stance

The project should use:
- a **small autoload/service layer**
- **Resource-based static definitions**
- **authoritative runtime state outside scene trees**
- **scene/node presentation that mirrors but does not own truth**
- **schema-driven save/load** later

Core rule:
- static design/content data lives in Resources
- authoritative runtime simulation state lives in service/manager-owned data
- presentation scenes are disposable views
- UI reads state and sends intent back inward

---

## 3. Current top-level project layout

```text
res://
  autoload/
    app_root.gd
    definition_registry.gd
    event_bus.gd
    save_service.gd
    sim_root.gd
    telemetry_service.gd
    time_service.gd

  data/
    defs/
      incidents/
      items/
      map_presets/
      processes/
      scenarios/
      season_profiles/
      skills/
      species/
      stages/
      structures/
      terrain_profiles/
      ui_panels/
      worldgen_profiles/
    balance/

  scripts/
    core/
      defs/
    runtime/
      state/
    presentation/
      ui/
      world/
    sim/
    util/

  scenes/
    bootstrap/
    world/
    ui/

  assets/
```

---

## 4. Autoload responsibilities

### 4.1 `AppRoot`
Owns:
- high-level scene switching
- build/version/session metadata access
- app-level orchestration

### 4.2 `SimRoot`
Owns:
- current bootstrap/session context
- active scenario ID
- active stage ID
- active map preset ID
- active worldgen profile ID
- active season profile ID
- active seed
- world-root registration hooks

### 4.3 `TimeService`
Owns:
- calendar snapshot
- season/part-of-day bootstrap defaults
- future authoritative clock/tick state

### 4.4 `DefinitionRegistry`
Owns:
- definition loading
- ID validation
- duplicate-ID detection
- cross-reference validation
- boot-time lookup service for static defs

### 4.5 `EventBus`
Owns:
- cross-system signal/event plumbing

### 4.6 `TelemetryService`
Owns:
- debug/runtime logging
- boot/validation telemetry

### 4.7 `SaveService`
Owns:
- future save/load entry points
- currently safe to remain mostly stubbed

### 4.8 What should not be autoloaded yet
Do not autoload:
- world renderer
- camera controller
- HUD controller
- simulation managers that only matter during an active world
- gameplay subsystems too early

---

## 5. Current scene/presentation layer

### Current scenes
- `scenes/bootstrap/boot_scene.tscn`
- `scenes/world/test_world_scene.tscn`

### Current presentation scripts
- `scripts/presentation/world/world_root_controller.gd`
- `scripts/presentation/world/map_placeholder.gd`
- `scripts/presentation/ui/dev_hud.gd`

### Important rule
The current map view is **placeholder presentation only**.
It is not the authoritative world model and should be treated as disposable once Branch 03–04 land.

---

## 6. Current definition layer

Implemented definition families:
- stage
- skill
- item
- process
- structure
- scenario
- map preset
- species
- terrain profile
- worldgen profile
- season profile
- incident
- UI panel

Current shared runtime/state helpers:
- `calendar_ids.gd`
- `definition_types.gd`
- `id_rules.gd`
- `policy_bundle_ids.gd`
- `shared_enums.gd`
- `task_def_ids.gd`
- `zone_types.gd`

---

## 7. Bootstrap chain rule

The active bootstrap chain should stay definition-driven.

Current intended rule:
- scenario chooses stage + map preset + worldgen profile
- worldgen profile chooses season profile
- season profile bootstraps the initial calendar defaults
- `SimRoot` stores the resolved active context
- `TimeService` exposes the resolved calendar snapshot

Do not replace this with loose hardcoded startup state in random scene scripts.

---

## 8. Near-term branch boundaries

### Branch 02
Should add:
- deterministic ticking
- pause/resume/single-step
- stable phase order

### Branch 03
Should add:
- authoritative world data model
- authored map loading into runtime state

### Branch 04
Should add:
- renderer/camera/fog driven by world truth instead of the current placeholder map

---

## 9. Final position

The project should continue as:
- Resource-defined static content
- small autoload/service shell
- runtime truth outside presentation scenes
- definition-driven bootstrap
- explicit, debug-friendly boundaries

That keeps the project aligned with the realism-first design while still being safe to build incrementally.
