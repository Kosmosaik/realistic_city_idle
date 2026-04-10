# Realistic Idle City — Balance / Constants Sheet v0.1

## 1. Purpose

This document defines the **first-pass numerical tuning sheet** for the early-game MVP.

It is the practical balance companion to:
- the Early Game MVP Build Spec
- the Unified Data Dictionary
- the Time / Season / Labor Calendar Spec
- the Settlement Progression Spec
- the Logistics / Storage / Food-Water / Health specs

This is **not** a realism museum.
It is a playable starting sheet where:
- real-world anchors set the direction
- game tuning sets the first implementation values
- harsh systems stay legible and recoverable
- later telemetry can retune values without changing the core model

---

## 2. How to use this sheet

Every value below should be treated as one of three types:

### 2.1 Research anchor
A real-world planning or safety reference that informs the system direction.
These anchors justify the shape of the mechanic.
They do **not** mean the game must reproduce the real world literally at 1:1 severity.

### 2.2 Starting gameplay value
A concrete first implementation value for the MVP.
This should be used in code/data first unless later playtesting proves it wrong.

### 2.3 Derived value
A value computed from other constants.
Where possible, code should derive these instead of storing duplicates.

---

## 3. Design stance for balance

The current tuning stance is:

**Realism provides the bottlenecks. Balance provides the playability.**

Practical rule:
- thirst should become urgent before it becomes opaque
- fatigue should slow and distort work before it becomes pure hard-lock
- spoilage should punish laziness and bad layout, not require spreadsheet play every minute
- hauling should matter enough that containers, routes, and site choice feel important
- fire/fuel should remain a serious camp pressure, but not become nonstop click-tax
- reserves should feel like security and planning, not pointless hoarding

---

## 4. Canonical tuning assumptions

Unless otherwise stated, all first-pass values assume:
- one healthy adult starter NPC
- `frame_size = medium`
- temperate canonical start
- mixed open / wooded terrain
- no beasts of burden
- no metal tools
- no refrigeration
- basic campfire / hearth technology
- manual hauling only
- default stage target = survival to tiny hamlet

---

## 5. Global simulation constants

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_sim_tick_minutes` | 1 | One simulation tick equals one in-game minute. |
| `const_ticks_per_hour` | 60 | Derived from tick length. |
| `const_hours_per_day` | 24 | Fixed. |
| `const_days_per_season` | 24 | Gives enough seasonal identity without making the year drag. |
| `const_days_per_year` | 96 | Derived. |
| `const_reserve_review_interval_hours` | 6 | How often reserve alerts recalculate. |
| `const_stage_review_interval_hours` | 24 | Settlement stage recomputed at least once per day. |
| `const_daily_plan_review_hour` | 5 | Early morning review / reprioritization. |
| `const_evening_plan_review_hour` | 18 | Evening reserve / shelter / fire check. |
| `const_default_adult_body_mass_kg` | 72 | Balance anchor for medium-frame adult. |
| `const_default_walk_speed_mps_unloaded` | 1.25 | ~4.5 km/h on decent ground. |

### 5.1 Why 1-minute ticks
This is fine-grained enough for:
- body drift
- task interruption
- path cost accumulation
- fire decay
- wetness / exposure
- short travel actions

But it is still coarse enough to simulate large spans quickly.

---

## 6. Research anchors informing this sheet

These anchors shape the model:

1. **Food-energy planning anchor**  
   Use roughly **2,100 kcal/person/day** as the basic planning reference for a typical population in warm conditions, then adjust upward for harder labor, cold, and local conditions.

2. **Water planning anchor**  
   Treat **7.5–15 liters/person/day** as the broad household survival-to-functioning water range for drinking, food preparation, and hygiene. Short emergency response can begin lower, but functioning settlement life should push upward.

3. **Drinking-water anchor**  
   Of the above, roughly **2.5–3.0 liters/person/day** is the meaningful survival drinking baseline for one adult under non-extreme conditions.

4. **Sleep anchor**  
   A healthy adult should generally be modeled around **7–8 hours** of sleep need per day, with quality strongly affecting the usefulness of those hours.

5. **Heat hydration anchor**  
   Hard work in heat can require much more frequent drinking than thirst alone suggests; the game should increase water demand sharply in hot work conditions.

6. **Manual load anchor**  
   A single healthy adult can briefly lift or move substantial weight under ideal conditions, but **routine carrying over distance and rough terrain must be tuned much lower** than an ideal one-off lift.

7. **Ambient perishability anchor**  
   Cooked and highly perishable foods left at warm ambient temperatures should become unsafe quickly. The game should treat same-day food handling as a real pressure.

---

## 7. Need-state core constants

## 7.1 Hydration planning constants

### Research shape
Use a split model:
- **drinking water** for direct survival
- **potable prep water** for cooking / safe food handling
- **basic hygiene water** for minimum cleanliness

### Starting values

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_water_drinking_lpd_cool` | 2.5 L | Cool day baseline. |
| `const_water_drinking_lpd_temperate` | 3.0 L | Canonical normal target. |
| `const_water_drinking_lpd_hot` | 4.5 L | Hot day outdoor work target. |
| `const_water_drinking_lpd_heat_heavy` | 6.0 L | Heavy work / high heat first-pass cap target. |
| `const_water_potable_prep_lpd` | 1.0 L | Cooking / basic safe prep. |
| `const_water_basic_hygiene_lpd` | 2.0 L | Hand/face/basic wash, not comfort bathing. |
| `const_water_household_emergency_lpd` | 5.0 L | Short-lived bare minimum. |
| `const_water_household_survival_lpd` | 7.5 L | Matches survival floor logic. |
| `const_water_household_functioning_lpd` | 10.0 L | Good early camp planning target. |
| `const_water_household_good_lpd` | 12.5 L | Comfortable early settlement target. |
| `const_water_fetch_point_soft_max_distance_m` | 300 | Above this, hauling starts becoming highly punitive. |
| `const_water_fetch_point_hard_max_distance_m` | 500 | Beyond this, site quality should be strongly penalized. |

### Hydration state thresholds
Use `hydration_debt_liters` as the main hidden continuous variable.

| State | Threshold |
|---|---|
| `hydrated` | `< 0.75 L debt` |
| `thirsty` | `0.75–1.49 L debt` |
| `very_thirsty` | `1.50–2.49 L debt` |
| `dehydration_risk` | `>= 2.50 L debt` |

### Hydration demand multipliers

| Condition | Multiplier |
|---|---:|
| cool weather | `0.90x` |
| canonical temperate day | `1.00x` |
| hot weather | `1.35x` |
| hot + heavy labor | `1.75x` |
| sick with diarrhea / vomiting | `1.50x` minimum |
| sheltered low-activity rest day | `0.85x` |

---

## 7.2 Food-energy constants

### Starting values

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_kcal_day_rest` | 2100 kcal | Basic planning anchor. |
| `const_kcal_day_light_work` | 2400 kcal | Light gathering / camp upkeep. |
| `const_kcal_day_moderate_work` | 2700 kcal | Default working target. |
| `const_kcal_day_heavy_work` | 3200 kcal | Sustained hard labor. |
| `const_kcal_cold_wet_bonus` | +300 kcal/day | Add for cold/wet exposure. |
| `const_kcal_recovery_injury_bonus` | +150 kcal/day | Mild recovery support. |

### Hunger state thresholds
Use `food_energy_debt_kcal` as the main hidden variable.

| State | Threshold |
|---|---|
| `fed` | `< 500 kcal debt` |
| `hungry` | `500–1199 kcal debt` |
| `very_hungry` | `1200–2399 kcal debt` |
| `starving` | `>= 2400 kcal debt` |

### Gameplay rules
- Do **not** make all calorie shortfall immediate. Use a rolling deficit.
- Moderate food shortage should first reduce morale, work speed, and recovery.
- Severe shortage should then reduce judgment, hauling capacity, and resilience.
- Full starvation collapse should be slow enough to be readable, not instant.

---

## 7.3 Sleep and fatigue constants

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_sleep_target_hours` | 8.0 h | First-pass target for healthy adult. |
| `const_sleep_minimum_hours` | 7.0 h | Below this, debt begins building clearly. |
| `const_sleep_poor_threshold_hours` | 6.0 h | Below this, performance penalties increase sharply. |
| `const_sleep_critical_threshold_hours` | 4.0 h | Severe impairment threshold. |
| `const_awake_soft_limit_hours` | 14 h | Tiredness begins rising strongly. |
| `const_awake_hard_limit_hours` | 18 h | Emergency-only territory. |
| `const_sleep_recovery_bonus_sheltered` | +15% | Better recovery under shelter. |
| `const_sleep_recovery_bonus_dry_bedded` | +20% | Applies on top of shelter bonus. |
| `const_sleep_recovery_penalty_cold_wet` | -35% | Severe recovery impairment. |

### Fatigue state thresholds
Use combined **sleep debt + awake duration + recent exertion**.

| State | Threshold |
|---|---|
| `rested` | `< 1.0 h effective sleep debt` |
| `tired` | `1.0–2.49 h debt` or `12–14 h awake` |
| `fatigued` | `2.5–4.0 h debt` or `14–18 h awake` |
| `exhausted` | `> 4.0 h debt` or `> 18 h awake` |

### Sleep quality multipliers

| Sleep quality | Recovery multiplier |
|---|---:|
| `awful` | `0.45x` |
| `poor` | `0.70x` |
| `adequate` | `1.00x` |
| `good` | `1.15x` |
| `restorative` | `1.30x` |

---

## 7.4 Wetness and thermal burden constants

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_wetness_gain_rain_exposed_per_hour` | 1.00 | Exposed rain quickly saturates. |
| `const_wetness_gain_damp_ground_sleep_per_hour` | 0.35 | Sleeping on damp ground matters. |
| `const_wetness_dry_rate_sun_breeze_per_hour` | -0.50 | Fastest practical passive drying. |
| `const_wetness_dry_rate_sheltered_per_hour` | -0.25 | Normal sheltered drying. |
| `const_wetness_dry_rate_fire_side_per_hour` | -0.60 | Warm fire-side drying. |

### Wetness state thresholds

| State | Threshold |
|---|---|
| `dry` | `0.00–0.19 wetness load` |
| `damp` | `0.20–0.49` |
| `wet` | `0.50–0.79` |
| `soaked` | `0.80–1.00` |

### Thermal rules
First playable should use coarse thermal burden rather than exact body-temperature physiology.

Recommended starting logic:
- `cold_stressed` risk rises quickly when `wet >= wet` and night exposure is unsheltered
- `heat_stressed` risk rises mainly from hot-weather work + poor hydration
- cold is the more important early-MVP killer than heat in the canonical temperate profile

---

## 8. Hauling, carrying, and movement constants

## 8.1 Load classes for a medium adult

These values are for **routine single-person carrying over distance**, not ideal gym lifts.

| Load class | Mass threshold |
|---|---|
| `trivial` | `<= 1.5 kg` |
| `light` | `1.6–6.0 kg` |
| `moderate` | `6.1–12.0 kg` |
| `heavy` | `12.1–20.0 kg` |
| `extreme` | `20.1–28.0 kg` |

### Hard caps

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_hand_carry_routine_cap_kg` | 20 kg | Beyond this, routine solo hauling should be heavily discouraged. |
| `const_hand_carry_emergency_cap_kg` | 28 kg | Very short-distance emergency movement only. |
| `const_drag_carry_cap_kg` | 45 kg | Very slow, terrain-sensitive, awkward. |
| `const_two_person_lift_recommended_from_kg` | 24 kg | Start offering two-person handling. |

### Carry-mode adjustments

| Carry mode | Effective burden modifier | Notes |
|---|---:|---|
| `hand_carry` | `1.00x` | Baseline. |
| `bundle_carry` | `0.95x` | Slightly better if grip is good. |
| `shoulder_sling` | `0.90x` | Good for bundles. |
| `basket_carry` | `0.85x` | Better for awkward loose goods. |
| `bag_carry` | `0.90x` | Similar to sling for dry goods. |
| `shoulder_pole_carry` | `0.80x` | Strong logistics upgrade once unlocked. |
| `drag_carry` | `0.70x` | Better on load, worse on speed and terrain. |
| `litter_carry` | `0.75x` | Usually multi-person or care use. |

## 8.2 Movement speed multipliers by load

| Load class | Speed multiplier |
|---|---:|
| `trivial` | `1.00x` |
| `light` | `0.96x` |
| `moderate` | `0.84x` |
| `heavy` | `0.68x` |
| `extreme` | `0.52x` |

## 8.3 Movement speed multipliers by terrain

| Terrain class | Speed multiplier |
|---|---:|
| `clear_flat` | `1.00x` |
| `open_grass_scrub` | `0.95x` |
| `forest_understory` | `0.85x` |
| `rocky_uneven` | `0.75x` |
| `mud_marsh_edge` | `0.60x` |
| `slope_ridge` | `0.70x` |
| `interior_camp_clutter` | `0.80x` |

## 8.4 Route preference modifiers

| Route state | Travel-cost multiplier |
|---|---:|
| `unknown` | `1.10x` |
| `disliked` | `1.20x` |
| `neutral` | `1.00x` |
| `preferred` | `0.92x` |
| `core_path` | `0.82x` |

## 8.5 Hauling-performance penalties

| Condition | Extra burden multiplier |
|---|---:|
| `tired` | `1.10x` |
| `fatigued` | `1.25x` |
| `exhausted` | `1.45x` |
| `wet` | `1.10x` |
| `soaked` | `1.20x` |
| `cold_stressed` | `1.10x` |
| `minor injury` | `1.10x` |
| `moderate injury` | `1.25x` |
| `severe injury` | task usually blocked |

---

## 9. Fire, fuel, and heat constants

These are **gameplay starting values**, not claims about all real campfires.

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_fire_fuel_kgph_embers` | 0.08 kg/h | Ember preservation / tiny maintenance burn. |
| `const_fire_fuel_kgph_cookfire` | 0.35 kg/h | Active small cooking fire. |
| `const_fire_fuel_kgph_night_hearth` | 0.30 kg/h | Low night maintenance burn. |
| `const_fire_fuel_kgph_cold_wet_hearth` | 0.55 kg/h | Cold/wet survival night. |
| `const_fire_start_time_minutes_dry` | 20 | Friction/spark-like early attempt average. |
| `const_fire_start_time_minutes_from_embers` | 5 | Much easier. |
| `const_fire_start_wet_weather_multiplier` | 1.75x | Wet kindling hurts. |
| `const_gathered_wet_fuel_usable_fraction_same_day` | 0.60 | Wet fuel partly works, badly. |
| `const_drying_fuel_bonus_under_cover_after_24h` | +25% usable value | Very first-pass simplification. |

### Derived planning numbers

| Scenario | Fuel use |
|---|---|
| solo temperate day with two cook periods + night hearth | `~3.5 to 4.5 kg/day` |
| solo cold/wet day with more heating need | `~5.5 to 7.0 kg/day` |
| two adults, temperate primitive camp | `~6 to 8 kg/day` |
| tiny hamlet common-hearth baseline | `~10 to 16 kg/day` depending weather |

### Fuel reserve planning
Use the **higher** of:
- `2 x average recent daily fuel burn`
- `forecast cold/wet next 48h burn`

---

## 10. Water handling and sanitation constants

## 10.1 Water quality handling times

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_boil_small_pot_total_minutes` | 30 | Includes heating to useful boil + short handling. |
| `const_boil_large_pot_total_minutes` | 50 | Household batch. |
| `const_settle_dirty_water_minutes` | 60 | Simple settling step. |
| `const_fill_small_pot_minutes_no_travel` | 5 | At source only. |
| `const_fill_multi_container_minutes_no_travel` | 12 | Batch fill at source. |

## 10.2 Stored potable water safety windows

| Storage case | First-pass safe window |
|---|---|
| boiled water in `container_clean_covered` | `48 h` |
| boiled water in open or frequently handled vessel | `24 h` |
| raw settled water | not potable |
| coarse-filtered only | not reliably potable |
| recontaminated stored water | must be reboiled |

## 10.3 Sanitation siting constants

| Constant ID | Starting value | Notes |
|---|---:|---|
| `const_waste_zone_min_distance_from_sleep_cook_core_m` | 15 m | Early simple spatial separation. |
| `const_dirty_workspot_min_distance_from_clean_food_prep_m` | 8 m | Prevent overlap. |
| `const_latrine_min_distance_from_water_source_m` | 30 m | Strong first-pass rule. |
| `const_latrine_min_vertical_clearance_above_water_table_m` | 1.5 m | If the game models local water table risk. |
| `const_latrine_prefer_downslope_from_water_source` | true | Hard siting preference. |
| `const_surface_drainage_must_not_flow_to_water_fetch` | true | Non-negotiable contamination rule. |

---

## 11. Food spoilage and preservation constants

## 11.1 Storage modifiers

Apply these to base shelf life.

| Storage protection class | Shelf-life multiplier |
|---|---:|
| `ground_exposed` | `0.50x` |
| `ground_sorted` | `0.65x` |
| `covered_ground` | `0.80x` |
| `raised_protected` | `1.20x` |
| `container_open` | `1.00x` |
| `container_closed` | `1.20x` |
| `container_clean_covered` | `1.40x` |
| `pit_storage` | `1.15x` for suitable roots / tubers only |
| `hanging_storage` | `1.15x` for pest-sensitive dry goods |

## 11.2 Weather modifiers

| Condition | Shelf-life multiplier |
|---|---:|
| cool season | `1.20x` |
| canonical temperate ambient | `1.00x` |
| wet weather | `0.80x` |
| hot weather | `0.60x` |
| hot + insects high | `0.45x` |

## 11.3 Base ambient shelf-life values

These are **temperate ambient** starting points before modifiers.

| Item class / state | Base shelf life |
|---|---|
| berries, soft fruit | `12 h` |
| mushrooms | `12 h` |
| leafy greens | `18 h` |
| raw fish, small catch | `6 h` |
| raw butchered meat, small game | `6 h` |
| shellfish raw | `6 h` |
| cooked short-life meal | `2 h` safe target / `6 h` hard discard |
| roots/tubers, dirty intact | `7 d` |
| nuts / hard seeds, dry | `30 d` |
| simple dried fish | `14 d` |
| simple dried meat | `10 d` |
| simple smoked fish/meat | `14 d` |
| properly dried seed reserve | `90 d` minimum planning value |

### Hot-weather override
When ambient heat is high:
- cooked short-life meal safe target becomes `1 h`
- cooked short-life meal hard discard becomes `3 h`
- raw fish/meat hard discard becomes `4 h`

### Food safety doctrine for MVP
Use three states:
- `safe`
- `questionable`
- `unsafe`

Recommended conversion:
- `safe` until base shelf life reached
- `questionable` from `1.0x` to `1.5x` shelf life
- `unsafe` beyond `1.5x` shelf life

Exception:
- cooked meals in warm conditions should turn `unsafe` aggressively
- visibly contaminated items can jump directly to `unsafe`

---

## 12. Task duration constants

These are **base durations excluding travel** unless explicitly stated.
They are meant to seed the first implementation, not end discussion forever.

## 12.1 Core survival tasks

| Task / process | Base duration |
|---|---:|
| drink from carried vessel | 3 min |
| fill one small vessel at source | 5 min |
| gather deadwood nearby patch | 20 min |
| gather brush for bedding / shelter fill | 20 min |
| gather edible plant patch | 25 min |
| catch shellfish simple | 30 min |
| simple fishing attempt | 60 min |
| clear sleep spot | 20 min |
| light fire from embers | 5 min |
| light fire from scratch, dry conditions | 20 min |
| light fire from scratch, damp conditions | 40 min |
| cook simple single meal | 20 min |
| boil one small pot water | 30 min |
| basic wash / hand cleaning episode | 8 min |

## 12.2 Primitive construction / craft tasks

| Task / process | Base duration |
|---|---:|
| knap crude stone edge tool | 20 min |
| make short crude cordage | 30 min |
| repair crude tool | 15 min |
| build debris lean-to | 120 min |
| minor shelter repair | 30 min |
| build improved lean-to | 180 min |
| weave crude basket | 180 min |
| repair crude basket | 25 min |
| dig simple latrine / waste pit | 90 min |
| set simple drying rack | 45 min |
| set simple smoking frame | 60 min |

## 12.3 Early permanent-camp tasks

| Task / process | Base duration |
|---|---:|
| shape small pot | 45 min |
| air-dry green pot to firing-ready state | 24 h passive |
| fire small pottery batch | 180 min |
| move water to clean pot cluster | 12 min |
| sort / dry / secure seed batch | 20 min |
| tend small garden plot | 15 min |
| plant small plot | 45 min |
| harvest small plot | 60 min |
| repair storage area / raised cache | 35 min |

## 12.4 Duration modifiers

| Modifier source | Multiplier |
|---|---:|
| novice worker | `1.25x` |
| practiced worker | `1.00x` |
| skilled worker | `0.85x` |
| high interest alignment | `0.90x` |
| low interest alignment | `1.10x` |
| `tired` | `1.10x` |
| `fatigued` | `1.25x` |
| `exhausted` | `1.45x` |
| darkness outdoor task | `1.15x` |
| rain / wet conditions | `1.20x` |
| missing proper tool | `1.35x` minimum |

---

## 13. Reserve targets and alert thresholds

Reserve logic should scale by **active resident count**.
Use person-days where possible.

## 13.1 Drinking-water reserve

| Stage | Alert threshold | Target reserve |
|---|---|---|
| `stage.lone_survivor` | `< 0.5 person-day` | `1.0 person-day` |
| `stage.primitive_camp` | `< 0.75 person-day` | `1.5 person-days` |
| `stage.permanent_camp` | `< 1.0 person-day` | `2.0 person-days` |
| `stage.tiny_hamlet` | `< 1.5 person-days` | `3.0 person-days` |

## 13.2 Fuel reserve

| Stage | Alert threshold | Target reserve |
|---|---|---|
| `stage.lone_survivor` | `< 0.5 night` | `1.0 day/night cycle` |
| `stage.primitive_camp` | `< 1.0 cycle` | `2.0 cycles` |
| `stage.permanent_camp` | `< 1.5 cycles` | `3.0 cycles` |
| `stage.tiny_hamlet` | `< 2.0 cycles` | `4.0 cycles` |

## 13.3 Food reserve

| Reserve bucket | Primitive Camp target | Permanent Camp target | Tiny Hamlet target |
|---|---:|---:|---:|
| `reserve_immediate_food` | 1.0 person-day | 1.0 person-day | 1.5 person-days |
| `reserve_dry_food` | 0.5 person-day | 2.0 person-days | 4.0 person-days |
| `reserve_emergency_food` | 0.0–0.5 person-day | 1.0 person-day | 2.0 person-days |

## 13.4 Seed reserve

| Stage | Rule |
|---|---|
| before plant management exists | no formal seed reserve yet |
| first managed plots | hold `125%` of next sowing requirement |
| permanent camp onward | hold `150%` of next sowing requirement if supply allows |

### Seed release policy
Default release should be:
- `never_normal_use` for `reserve_seed`
- downgrade only under explicit emergency ration state or player override

## 13.5 Clean-container reserve

| Stage | Minimum rule |
|---|---|
| Primitive Camp | at least `2` dedicated potable-capable vessels |
| Permanent Camp | potable vessel capacity >= `2 person-days` of drinking water |
| Tiny Hamlet | potable vessel capacity >= `3 person-days` of drinking water |

---

## 14. Numeric stage-gate support values

These values should support stage computation, not replace the broader stage logic.

## 14.1 Lone Survivor -> Primitive Camp support values

Require all or almost all of the following over the last `3 days`:

| Condition | Starting requirement |
|---|---|
| water routine stability | no `dehydration_risk` longer than `2 h` on any day |
| sheltered sleep | sheltered sleep on at least `2/3` nights |
| fire continuity | usable fire or preserved embers on at least `2/3` nights |
| intentional storage | at least `20 kg` or `25 L` deliberate storage capacity |
| preservation proof | at least one preserved or next-day-usable food batch exists |
| sanitation separation | waste zone >= `15 m` from sleep/cook core |
| improved tool chain | at least `2` improved primitive tools in active use |
| improvement labor | average `>= 90 min/day` spent on improvement tasks |

## 14.2 Primitive Camp -> Permanent Camp support values

Evaluate over the last `7 days`:

| Condition | Starting requirement |
|---|---|
| collapse resistance | no full loss of water + sleep + fire routine on the same day |
| protected food storage | at least `60 kg` or `100 L` protected dry storage equivalent |
| seed protection | at least `1` protected dedicated seed container or zone |
| water containerization | stored potable capacity >= `2 person-days` |
| preservation routine | preserved food production on `>= 3 of last 7 days` |
| zoning discipline | separate clean prep, dirty work, storage, sleep, waste zones all exist |
| fuel reserve | maintained above Primitive Camp alert threshold on `>= 5 of last 7 days` |
| planning ahead | at least one protected reserve exists for next weather / next season |
| spare support margin | shelter + bedding + food can absorb `+1 adult` for `1 day` |

## 14.3 Permanent Camp -> Tiny Hamlet support values

Evaluate over the last `10 days`:

| Condition | Starting requirement |
|---|---|
| sustained residents | `>= 3` resident adults present on `>= 7 of last 10 days` |
| role split | at least `2` ongoing roles each claim `>= 20%` of labor time |
| water throughput | average stored potable reserve >= `2 person-days`, target `3` |
| reserve depth | total edible reserve >= `5 person-days`, with `>= 2` preserved |
| fuel reserve | maintained above Permanent Camp target on `>= 7 of last 10 days` |
| plant management | active managed plots tended on `>= 5 of last 10 days` |
| layout as infrastructure | no overlapping sleep / dirty-work / waste core alert during window |
| redundancy | one worker hitting `fatigued` or `mild illness` does not break all loops within `24 h` |

---

## 15. Alert thresholds and warnings

## 15.1 Reserve alerts

| Alert ID | Trigger |
|---|---|
| `alert.reserve_drinking_water_low` | below stage alert threshold |
| `alert.reserve_fuel_low` | below stage alert threshold |
| `alert.reserve_food_low` | immediate + dry food together below stage floor |
| `alert.reserve_seed_at_risk` | seed reserve consumed, contaminated, or exposed to damp |
| `alert.clean_container_shortage` | clean potable capacity below target |

## 15.2 Body alerts

| Alert ID | Trigger |
|---|---|
| `alert.body.dehydration_risk` | hydration state enters `dehydration_risk` |
| `alert.body.exhaustion_risk` | fatigue state `exhausted` for > `2 h` |
| `alert.body.cold_sleep_risk` | unsheltered wet sleep likely tonight |
| `alert.body.food_shortfall` | `very_hungry` or worse |
| `alert.body.sickness_spread_risk` | unsafe food/water + poor sanitation overlap |

---

## 16. Deliberate simplifications for MVP

To keep the MVP buildable, the constants sheet intentionally simplifies:
- micronutrients into broader recovery / morale / illness pressure
- thermal physiology into coarse burden states
- exact fluid-electrolyte balance into water + meal logic
- lifting biomechanics into load classes and burden modifiers
- microbiology into food/water contamination state transitions
- fire combustion into fuel-per-hour classes

This is acceptable for first playable.
What matters is that:
- the pressures behave believably
- the player can read the cause of failure
- the numbers tune toward realism without turning invisible

---

## 17. High-retune priority constants

These values are most likely to move after the first real test build:
- `const_days_per_season`
- all task durations in Section 12
- `const_fire_fuel_kgph_*`
- spoilage values for dried / smoked foods
- hauling thresholds for `heavy` and `extreme`
- `const_water_fetch_point_soft_max_distance_m`
- reserve targets for `stage.permanent_camp` and `stage.tiny_hamlet`

Recommended process:
1. build with this sheet exactly once
2. run AI-only simulation tests
3. run player-observed debug sessions
4. adjust rates in small batches
5. never retune ten systems at the same time

---

## 18. Sources used as realism anchors

This sheet is informed by widely used planning/safety guidance, especially:
- Sphere / WHO emergency water planning
- UNHCR / WFP humanitarian food-energy planning
- CDC sleep guidance
- OSHA / NIOSH hydration and manual handling guidance
- USDA / FDA food safety timing guidance

These sources justify the broad ranges and thresholds.
The exact game values remain implementation choices for this project.
