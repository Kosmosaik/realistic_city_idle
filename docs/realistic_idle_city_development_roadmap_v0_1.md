# Realistic Idle City — Development Roadmap v0.1

> Filename retained for replacement convenience. This version is synced after **Branch 04**.

## 1. Current status snapshot

Current branch status:
- **Branch 00 — repo bootstrap: complete**
- **Branch 01 — core definitions and IDs: complete enough to close**
- **Branch 02 — simulation clock and run loop: complete enough to close**
- **Branch 03 — authoritative world data + authored map loading: complete enough to close**
- **Branch 04 — authoritative renderer + overlays + fog + camera + inspection: complete enough to close**
- **Immediate next branch: Branch 05 — audit and cleanup**

Current project now proves:
- definition-driven bootstrap works
- deterministic time/run-loop backbone works
- authored terrain data can load into authoritative runtime state
- authoritative terrain data can render, inspect, and debug correctly
- fog / remembered / visible states can be refreshed from runtime reveal sources
- the project is ready for a cleanup branch before more feature work

---

## 2. Roadmap intent

This roadmap is still meant to keep the game buildable in safe layers:

1. bootstrap shell
2. definitions / IDs / data vocabulary
3. deterministic runtime backbone
4. authoritative world substrate
5. authoritative terrain rendering / overlays / visibility
6. cleanup / branch-close audit
7. procedural terrain foundation
8. later gameplay and simulation systems on top of stable world truth

The important change is that the project has now **already completed the authored-world + renderer proof path**.  
That means the immediate need is **not** another large feature branch. It is a short cleanup pass.

---

## 3. Completed or closeable branches

## Branch 00 — repo-bootstrap
### Status
Complete.

### Why it mattered
It established the Godot shell, autoload structure, boot scene, and an initial dev-facing runtime surface.

### Closed outcome
The project has a stable base entry path and service shell.

---

## Branch 01 — core-definitions-and-ids
### Status
Complete enough to close.

### Why it mattered
It created the shared definition vocabulary and validation pipeline needed for all later data-driven work.

### Closed outcome
Definitions, IDs, bootstrap resolution, and validation are stable enough for continued development.

---

## Branch 02 — simulation-clock-and-run-loop
### Status
Complete enough to close.

### Why it mattered
It created the deterministic backbone needed for later survival simulation and visibility refresh.

### Closed outcome
Time progression, phase order, debug stepping, and deterministic queue handling are in place.

---

## Branch 03 — authoritative-world-data-and-authored-maps
### Status
Complete enough to close.

### Why it mattered
It replaced “decorative world idea” with actual world truth:
- cells
- chunks
- patches
- reveal sources
- authored map loading
- visibility service integration

### Closed outcome
The game now has an authoritative world substrate that later systems can trust.

### Scope note
The repo currently proves this with one authored reference map. More authored fixtures may still be useful later, but they are no longer required to close the branch.

---

## Branch 04 — authoritative-renderer-camera-overlays-fog
### Status
Complete enough to close.

### Why it mattered
It proved that the new world substrate is actually usable in practice:
- renderable
- inspectable
- overlay-readable
- fog-aware
- navigable with camera controls

### Closed outcome
The project can now visually debug and inspect terrain truth instead of relying on placeholder pixels.

---

## 4. Immediate next branch

## Branch 05 — audit-and-cleanup
### Status
Next.

### Goal
Create a short, explicit cleanup branch between Branch 04 and the next major feature track.

### Must deliver
- sync the implementation/status docs with the actual codebase after Branch 03–04
- remove or confirm removal of dead placeholder-only files
- remove editor temp scene files / stray artifacts from the repo
- verify scene/script names still match their current responsibilities
- verify the debug controls and current renderer stack are documented correctly
- add a brief manual verification note for the closeout if needed
- leave the project in a clean handoff state for the next feature branch

### Example cleanup targets already visible
- stale references to `map_placeholder.gd` in docs
- any leftover dead placeholder renderer script in older working copies
- `scenes/world/test_world_scene.tscn*.tmp`
- any outdated branch-status wording that still says Branch 02 or Branch 03 is “next”

### Exit criteria
- docs match the actual current project
- repo no longer contains obviously stale temporary scene artifacts
- branch naming / next-step language is consistent
- the next GPT / developer can start from a cleaner baseline without re-auditing everything first

---

## 5. Preferred next feature direction after cleanup

After Branch 05 closes, the preferred next feature direction is:

## Terrain procgen foundation
Use `docs/realistic_idle_city_terrain_generation_branch_plan_v0_1.md` as the active sub-plan.

The next feature branch should begin the **first structured terrain generator track**, rather than jumping directly into unrelated gameplay systems.

Why:
- Branch 03 gave the authoritative terrain substrate
- Branch 04 gave the renderer, overlays, and visibility debug tools
- that means the project is now finally in a safe position to start procedural terrain generation without guessing blindly

---

## 6. Roadmap guardrails

- do not reintroduce decorative placeholder terrain as hidden authority
- do not bury runtime truth in UI/presentation scripts
- do not start large new gameplay systems from a dirty branch-close state
- keep progression realism-oriented and condition-driven instead of over-hardcoding stage-gated play
- keep later feature branches small enough that closeout and handoff remain easy

---

## 7. Final position

The project is no longer in “bootstrap only” territory.

It now has:
- stable definitions
- a deterministic runtime backbone
- authoritative world data
- authoritative world rendering and inspection

That is enough progress that a dedicated **audit/cleanup branch** is the right move before continuing.
