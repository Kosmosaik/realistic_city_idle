# Realistic Idle City — Branch 02 Manual Verification Note v0.1

## Purpose

This is a small reproducibility/smoke-test note for closing Branch 02.

It is intentionally manual and lightweight.

---

## 1. Test setup

Use the default dev flow:
- boot the project normally
- let `BootScene` resolve the default scenario
- enter `scenes/world/test_world_scene.tscn`
- open the dev HUD with **F3** if it is hidden

Expected starting context:
- scenario: `scenario.dev.temperate_valley`
- seed: `100001`
- phase order visible in the HUD
- paused state visible in the HUD

---

## 2. Runtime controls to verify

Branch 02 debug controls:
- **Space** = pause / resume
- **.** = single-step one tick
- **[** = slower speed
- **]** = faster speed
- **F3** = toggle dev HUD

Expected behavior:
- pause state changes immediately
- speed index/multiplier updates immediately
- single-step works while paused

---

## 3. Deterministic phase-order smoke test

While paused:
1. press **.** once
2. inspect the HUD

Expected result:
- tick index advances by exactly 1
- recent phase history shows the full ordered phase sequence for that tick
- last completed tick updates
- determinism event count increases

Expected phase order:
1. `phase.command_intake`
2. `phase.time_step_start`
3. `phase.world_pre_update`
4. `phase.simulation_update`
5. `phase.visibility_refresh`
6. `phase.debug_snapshot`
7. `phase.end_of_tick_bookkeeping`

---

## 4. Scheduled-trigger / queued-command smoke test

The world scene creates `DebugScheduledTriggerProbe` automatically.

That probe schedules a repeating trigger every **6 ticks**.
When the trigger resolves, it enqueues a command **after** command-intake, so the command should process on the **next tick**.

Manual check:
1. boot fresh
2. stay paused
3. press **.** six times
4. inspect the HUD

Expected after 6 steps:
- resolved trigger count has increased
- last resolved trigger fields are populated
- queued command preview should show the probe command waiting for the next tick, or processed-command count should update on the following step depending on when you inspect

Then:
5. press **.** one more time

Expected after step 7:
- processed command count has increased
- last processed command fields are populated
- the trigger queue preview still shows a future heartbeat scheduled again

---

## 5. Reproducibility check

Run this twice from a fresh boot with the same default scenario and seed:
1. boot project
2. keep the simulation paused
3. press **.** exactly 12 times
4. note:
   - tick index
   - day/part-of-day state
   - determinism event count
   - determinism signature
   - resolved trigger count
   - processed command count

Expected result:
- the values above should match between both fresh runs

If they do not match, Branch 02 determinism has regressed and should be investigated before moving forward.

---

## 6. Close criteria for Branch 02

Branch 02 is manually verified enough to close when all of the following are true:
- pause / resume works
- speed controls work
- single-step works
- phase order is stable and visible
- scheduled triggers resolve predictably
- queued commands process on the expected later tick
- determinism signature matches across repeated fresh runs with the same input sequence
