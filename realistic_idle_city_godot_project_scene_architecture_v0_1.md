# Realistic Idle City — Godot Project / Scene Architecture v0.1

> Filename retained for replacement convenience. This version updates the architecture note after **Branch 02**.

## 1. Purpose

This document defines the intended Godot-side scene/runtime structure for the early-game MVP.

It explains:
- what scenes should exist
- what autoloads should own
- what should stay presentation-only
- what should become authoritative later

---

## 2. Current scene stack

Current entry path:
- `scenes/bootstrap/boot_scene.tscn`
- `scenes/world/test_world_scene.tscn`

Current world-scene support is created/ensured by `WorldRootController`:
- placeholder map renderer
- world camera
- dev HUD
- Branch 02 debug scheduled-trigger probe

---

## 3. Autoload shell

Current autoloads:
- `EventBus`
- `TelemetryService`
- `SaveService`
- `TimeService`
- `DefinitionRegistry`
- `SimRoot`
- `AppRoot`

Current responsibility split:
- `DefinitionRegistry` = static definition loading/validation
- `SimRoot` = resolved active bootstrap/session context
- `TimeService` = authoritative Branch 02 calendar + deterministic tick/run loop
- world scene = temporary presentation/dev shell

---

## 4. Presentation-vs-authority rule

Current rule:
- the world scene is **not** the authoritative simulation state
- the placeholder map renderer is **not** the authoritative terrain model
- autoload/runtime services own active session truth
- future Branch 03 world state should become the authoritative terrain/cell truth

---

## 5. Current world scene doctrine

The current world scene is allowed to:
- render placeholder terrain
- host a camera
- host the dev HUD
- host dev-only debug probes
- surface data from runtime services

The current world scene should **not**:
- become the source of truth for simulation state
- own canonical terrain facts
- own hidden gameplay progression state
- bypass autoload/runtime services for deterministic time advancement

---

## 6. Bootstrap chain rule

The active bootstrap chain should stay definition-driven.

Current intended rule:
- scenario chooses stage + map preset + worldgen profile
- worldgen profile chooses season profile
- season profile bootstraps the initial calendar defaults
- `SimRoot` stores the resolved active context
- `TimeService` exposes the resolved calendar snapshot and run-loop state

Do not replace this with loose hardcoded startup state in random scene scripts.

---

## 7. Current Branch 02 runtime rule

The deterministic runtime clock now belongs to `TimeService`.

Current phase order:
1. command intake
2. time-step start
3. world pre-update
4. simulation update
5. visibility refresh
6. debug snapshot
7. end-of-tick bookkeeping

External systems should subscribe through stable APIs/signals/listeners rather than creating parallel time loops in scene code.

---

## 8. Near-term branch boundaries

### Branch 03
Should add:
- authoritative world data model
- authored map loading into runtime state
- world cell inspector/debug access

### Branch 04
Should add:
- renderer/camera/fog driven by world truth instead of the current placeholder map

---

## 9. Final position

The project should continue as:
- Resource-defined static content
- small autoload/service shell
- deterministic runtime truth outside presentation scenes
- definition-driven bootstrap
- explicit, debug-friendly boundaries

That keeps the project aligned with the realism-first design while still being safe to build incrementally.
