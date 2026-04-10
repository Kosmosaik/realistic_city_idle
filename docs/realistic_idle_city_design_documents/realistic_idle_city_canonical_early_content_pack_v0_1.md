
# Realistic Idle City — Canonical Early Content Pack
**Version:** v0.1  
**Date:** 2026-04-08  
**Scope:** Lone Survivor -> Primitive Camp -> Permanent Camp -> Tiny Hamlet  
**Purpose:** Concrete starter content pack that turns the early-game design stack into a canonical set of usable items, processes, structures, tasks, knowledge seeds, policies, incidents, and stage packages.

---

## 1. Purpose of this document

This document is the **concrete starter content pack** for the early slice of the project.

It exists to answer a simple production question:

> If the design stack is already defined, what exact content should exist in the game for the first playable survival-to-hamlet arc?

This is **not** another broad philosophy document.  
It is a curated early-game package intended to be used as the canonical base for:

- content databases
- Godot data resources
- task generation
- structure definitions
- starting-world generation
- playtest balancing
- UI surfacing
- alerts and incidents
- onboarding and tutorial sequencing

This pack assumes the project remains:

- realism-first
- provenance-based
- explicit in early survival and camp life
- minimal visually, dense informationally
- centered on one embodied NPC who gradually helps create a small functioning settlement

---

## 2. Scope boundaries

This pack includes only the early slice:

1. **Start State**
2. **Lone Survivor**
3. **Primitive Camp**
4. **Permanent Camp**
5. **Tiny Hamlet**

It intentionally stops **before**:

- draft-animal traction
- metalworking
- wheel/carts as normal infrastructure
- large field agriculture
- market exchange systems
- formal governance institutions
- mills and powered workshops
- village-scale industry

Those belong to later packs.

---

## 3. Canonical assumptions for this pack

### 3.1 Biome and climate
The canonical start is an **Earth-like temperate environment** with:

- surface fresh water within walking distance
- deadwood and brush available
- stone suitable for crude tools
- edible plants and small animal life
- at least some clay or clay-like soil in the wider area
- seasons, including a cold/wet season that makes stockpiling meaningful
- enough open land to support later camp expansion and garden plots

### 3.2 Starter person
The canonical starter is:

- one adult NPC
- no carried gear
- no owned structures
- no formal recipes/manuals
- ordinary human intuition and problem-solving
- personal interests, aptitudes, traits, and baseline health
- physically able to gather, carry, improvise, build, and learn

### 3.3 Realism conventions
The pack assumes:

- water safety is a chain of **source -> treatment -> storage -> handling**
- food safety is a chain of **source -> cleanliness -> processing -> preservation -> storage**
- seed is not ordinary food; it is a strategic living reserve
- dry storage, clean covered storage, and separation of dirty/clean areas matter
- waste must be placed away from water and core living areas
- hauling is real labor, not teleportation
- every content entry should later connect to a dependency-friendly database schema

### 3.4 Research anchors used for this pack
This pack uses public-health and field-practice anchors where they affect early content:

- cloudy water should be clarified before boiling when possible, and boiled water should be stored in clean covered containers
- safe food handling depends on cleaning, separating raw/dirty from ready-to-eat/clean, cooking adequately, and avoiding unsafe storage/handling
- grain/seed storage depends heavily on dryness, cleanliness, temperature stability, and pest protection
- catholes / primitive waste disposal should be located away from camp and water
- hauling burden depends on weight, shape, grip, distance, footing, repetition, and fatigue rather than weight alone
- domestic water access strongly shapes labor burden and daily routine

---

## 4. How to read this content pack

Each stage package contains:

- **items**
- **processes**
- **structures**
- **tasks**
- **knowledge seeds**
- **player-facing policy bundle**
- **incidents / alerts**
- **stage goals**
- **promotion gates** to the next stage

This is the intended early content ordering for implementation, testing, and balancing.

---

## 5. Canonical tag model

Use the following tags consistently across all early content.

### 5.1 Stage tags
- `stage.start`
- `stage.lone_survivor`
- `stage.primitive_camp`
- `stage.permanent_camp`
- `stage.tiny_hamlet`

### 5.2 Content class tags
- `item`
- `process`
- `structure`
- `task`
- `knowledge`
- `policy`
- `incident`
- `alert`
- `reserve`
- `need`
- `hazard`

### 5.3 Gameplay role tags
- `water`
- `fire`
- `shelter`
- `sleep`
- `food`
- `hunting`
- `gathering`
- `hauling`
- `storage`
- `sanitation`
- `clothing`
- `craft`
- `preservation`
- `seed`
- `agriculture`
- `care`
- `social`

---

## 6. Canonical naming format

Suggested canonical IDs:

- items: `itm_<group>_<name>`
- processes: `pro_<group>_<name>`
- structures: `str_<group>_<name>`
- tasks: `tsk_<group>_<name>`
- knowledge: `kno_<group>_<name>`
- policies: `pol_<group>_<name>`
- incidents: `inc_<group>_<name>`

Example:
- `itm_water_raw_clear`
- `pro_water_boil_batch`
- `str_shelter_debris_lean_to`
- `tsk_fetch_water`
- `kno_fire_tinder_selection`
- `pol_reserve_seed_lock`
- `inc_food_spoilage_small`

---

# 7. Start State Package

## 7.1 Purpose
This is the exact content available at world start, before the first reliable camp exists.

## 7.2 Canonical start-state world conditions
The world starts with:

- one NPC standing in unexplored terrain
- no stored reserves
- no built structures
- no guaranteed fire
- no cooked water
- no secure food
- no dry bed
- no protected work zone
- no designated sanitation area

## 7.3 Canonical starting needs pressure
The earliest dominant pressures are:

1. water access
2. exposure / weather
3. exhaustion
4. calories
5. simple cutting / pounding / digging capability
6. safe sleeping surface
7. basic cleanliness / contamination avoidance

## 7.4 Canonical known knowledge at start
The starter NPC should begin with **intuition-grade** knowledge only:

- running out of water is dangerous
- being wet/cold/tired is dangerous
- shelter and fire are useful
- stones and branches can be used as tools
- food can be gathered or hunted
- dirty places should be kept away from living places
- some materials are worth collecting “just in case”

They should **not** begin with guaranteed procedural certainty for:
- clay vessel production
- systematic hide curing
- deliberate seed storage
- stable smoking/drying systems
- regularized agriculture
- permanent camp planning

## 7.5 Canonical starter tasks
- scout immediate area
- locate water source
- pick up stone
- gather deadwood
- gather broad leaves/brush
- gather edible plant matter
- clear sleeping spot
- improvise windbreak
- drink untreated water if necessary
- rest on ground
- observe hazards

## 7.6 Canonical start alerts
- no water reserve
- no dry bed
- no shelter
- no fire capability
- no food reserve
- no sanitation separation
- no carrying aid

---

# 8. Lone Survivor Package

## 8.1 Stage identity
One person, exposed, solving the first day-to-days problems manually.

## 8.2 Stage goals
- survive tonight
- avoid severe dehydration / exposure
- secure a repeatable water route
- create first sleep setup
- gain first working tools
- gather first stable calories
- establish the first safe camp footprint

## 8.3 Canonical items

### Water and containers
| ID | Item | Notes |
|---|---|---|
| `itm_water_raw_clear` | Clear untreated water | Lower contamination burden than muddy water, still unsafe by default |
| `itm_water_raw_cloudy` | Cloudy untreated water | Needs settling/filtering/boiling chain |
| `itm_water_boiled` | Boiled water | Safer only if stored cleanly |
| `itm_container_leaf_bundle` | Leaf bundle | Temporary carry bundle, poor durability |
| `itm_container_bark_fold` | Bark fold container | Very limited capacity |
| `itm_container_shell_cup` | Shell cup | Tiny quantity, fragile/awkward |

### Stone / mineral
| ID | Item | Notes |
|---|---|---|
| `itm_stone_hammer` | Hammer stone | Pounding, cracking, breaking |
| `itm_stone_sharp_flake` | Sharp stone flake | Cutting / scraping, very fragile edge |
| `itm_stone_core` | Flake core | Source for more sharp flakes |
| `itm_stone_flat_hearth` | Flat fire stone | Improves hearth stability |
| `itm_stone_small_round` | Small round stone | General utility / sling stock later |

### Wood / plant matter
| ID | Item | Notes |
|---|---|---|
| `itm_wood_twig_dry` | Dry twig bundle | Ignition fuel |
| `itm_wood_branch_dry_small` | Small dry branch | Light fuel / framework |
| `itm_wood_branch_green_small` | Small green branch | Structure framework, poor fuel |
| `itm_wood_pole_crude` | Crude pole | Lean-to and drying rack support |
| `itm_brush_bundle` | Brush bundle | Bedding, shelter fill |
| `itm_leaf_broad_fresh` | Broad leaves | Temporary cover / wrap |
| `itm_bark_strip_raw` | Raw bark strip | Tying / weaving / wrapping |
| `itm_fiber_raw_mixed` | Mixed wild fibers | Early cordage material |

### Food and body support
| ID | Item | Notes |
|---|---|---|
| `itm_food_berries_mixed` | Wild berries | Quick calories, risk depends on knowledge |
| `itm_food_roots_mixed` | Wild roots/tubers | Requires digging and species knowledge |
| `itm_food_greens_mixed` | Edible greens | Perishable |
| `itm_food_eggs_wild` | Wild eggs | Fragile, spoil quickly in heat |
| `itm_food_insects_edible` | Edible insects | Small but reliable calories where available |
| `itm_food_shellfish_raw` | Raw shellfish | Biome-dependent, contamination/spoilage risk |
| `itm_food_small_game_raw` | Raw small game carcass | Needs prompt processing |
| `itm_food_meat_raw_small` | Raw butchered meat | High perishability |
| `itm_food_meat_cooked` | Cooked meat | Safer, still limited storage life |
| `itm_food_gathered_mixed_lowgrade` | Mixed gathered food | Low certainty / low quality |

### Primitive implements
| ID | Item | Notes |
|---|---|---|
| `itm_tool_digging_stick` | Digging stick | Roots, cathole, soft soil |
| `itm_tool_club_crude` | Crude club | Small game / deterrence |
| `itm_tool_spear_fire_hardened` | Fire-hardened spear | Hunting / defense / probing |
| `itm_tool_scraper_stone` | Stone scraper | Hide/fat/flesh scraping |
| `itm_tool_carry_sling_crude` | Crude carry sling | Improves hauling volume |
| `itm_tool_tinder_bundle` | Tinder bundle | Dry grass/bark/fiber mix |

### Sleep / clothing / body protection
| ID | Item | Notes |
|---|---|---|
| `itm_bedding_brush_pile` | Brush bedding | Ground insulation |
| `itm_bedding_leaf_mat_crude` | Leaf mat | Short-lived improvement over bare ground |
| `itm_wrap_plant_crude` | Crude plant wrap | Minimal modesty / sun / insect / friction protection |
| `itm_hide_raw_small` | Raw small hide | Perishable until processed |
| `itm_skin_strip_raw` | Raw skin strip | Ties, thongs after partial drying |

### Waste / byproducts
| ID | Item | Notes |
|---|---|---|
| `itm_ash_small` | Small ash pile | Hearth byproduct |
| `itm_bone_small_mixed` | Small bones | Awl/needle potential later |
| `itm_offal_small` | Small offal waste | Needs disposal quickly |
| `itm_spoiled_food_small` | Spoiled food | Attracts pests, contamination burden |

## 8.4 Canonical structures
- `str_site_sleep_spot_cleared`
- `str_site_windbreak_brush`
- `str_shelter_debris_lean_to`
- `str_fire_open_small`
- `str_storage_cache_exposed`
- `str_storage_hanging_branch_simple`
- `str_sanitation_cathole_simple`
- `str_workspot_butchery_groundsheet_none` (unimproved dirty work spot)
- `str_drying_line_branch_simple`

## 8.5 Canonical processes
- `pro_scout_local_area`
- `pro_collect_surface_water`
- `pro_drink_untreated_water`
- `pro_gather_deadwood`
- `pro_gather_brush`
- `pro_pick_stone_useful`
- `pro_knap_simple_flake`
- `pro_clear_sleep_ground`
- `pro_build_brush_windbreak`
- `pro_build_debris_lean_to`
- `pro_make_digging_stick`
- `pro_make_crude_club`
- `pro_make_tinder_bundle`
- `pro_attempt_fire_start`
- `pro_boil_water_simple`
- `pro_gather_edible_plants_mixed`
- `pro_collect_eggs_simple`
- `pro_probe_shellfish_simple`
- `pro_hunt_small_game_opportunistic`
- `pro_butcher_small_game_dirty`
- `pro_roast_food_simple`
- `pro_build_brush_bedding`
- `pro_dig_cathole`
- `pro_dispose_offal_far`
- `pro_rest_exposed`
- `pro_rest_sheltered_simple`

## 8.6 Canonical tasks
- fetch water now
- gather fuel before night
- build sleeping surface
- improve shelter dryness
- start / maintain fire
- gather fast calories
- butcher carcass before spoilage
- move offal away from camp
- create first cathole
- carry more wood to hearth
- rest due to exhaustion
- warm by fire
- inspect weather exposure
- scout for safer site if current site is bad

## 8.7 Canonical knowledge seeds
- `kno_water_source_preference` — flowing/clear water tends to be preferable to stagnant dirty pools
- `kno_fire_tinder_selection` — dry, fine tinder matters
- `kno_sleep_ground_dryness` — wet ground worsens sleep/recovery
- `kno_small_game_fast_processing` — small carcasses spoil quickly
- `kno_dirty_offal_attracts` — waste near camp worsens risk
- `kno_brush_bedding_insulates` — elevation/dry fill improves sleep
- `kno_sharp_flakes_break_fast` — crude cutting edges are useful but fragile

## 8.8 Canonical player policy bundle
At this stage the player can only influence:
- survival priority bias
- avoid dangerous area
- do not consume seed-like finds
- keep waste away from sleep area
- keep at least one fire fuel batch in reserve when possible
- rest at severe exhaustion
- prefer improved water handling when possible

## 8.9 Canonical incidents / alerts
- sudden rain exposure
- fire failure due to wet tinder
- unsafe water sickness signs
- minor cut from flake
- carcass contamination
- food spoilage on ground
- predator noise at night
- exhaustion stumble
- no fuel before sunset
- no safe water on hand

## 8.10 Promotion gates to Primitive Camp
The stage promotes when all of the following are usually true:

- a repeatable camp site exists
- at least one shelter and one hearth exist
- basic water route is repeatable
- at least one carrying aid exists
- sleeping setup is better than bare ground
- waste placement is separated from living core
- the NPC can survive several days without full collapse

---

# 9. Primitive Camp Package

## 9.1 Stage identity
The lone NPC now has a recognizable camp and starts building repeatable survival systems rather than improvising everything every day.

## 9.2 Stage goals
- survive several days reliably
- reduce contamination and exposure risks
- improve tool quality and carrying efficiency
- preserve food
- improve clothing/bedding
- create first true storage
- establish cleaner camp zoning

## 9.3 Canonical new items

### Improved carrying / storage
| ID | Item | Notes |
|---|---|---|
| `itm_container_basket_crude` | Crude basket | Major logistics upgrade |
| `itm_container_hide_bag_crude` | Crude hide bag | Water-resistant only if well made |
| `itm_container_bark_box_crude` | Bark box | Dry storage, light items |
| `itm_container_hanging_bundle` | Hanging bundle | Pest avoidance for small goods |
| `itm_mat_fiber_woven_crude` | Woven fiber mat | Drying and sleeping uses |

### Fire / preservation
| ID | Item | Notes |
|---|---|---|
| `itm_fuelwood_bundle_mixed` | Mixed fuelwood bundle | Core camp fuel stock |
| `itm_charred_wood_partial` | Partially charred wood | Hearth remainder, can help relighting |
| `itm_food_meat_drying` | Meat in drying state | Not yet shelf-stable |
| `itm_food_meat_dried_simple` | Simply dried meat | Better shelf life if kept dry |
| `itm_food_fish_raw_small` | Raw small fish | Perishable |
| `itm_food_fish_dried_simple` | Dried fish | Good early preserved protein |

### Hide / bone / fiber
| ID | Item | Notes |
|---|---|---|
| `itm_hide_scraped_wet` | Scraped wet hide | Intermediate state |
| `itm_hide_dried_rawhide` | Rawhide | Tough, useful for lashings |
| `itm_hide_softened_smoke_cured_low` | Smoke-softened hide | Primitive clothing/container material |
| `itm_bone_awl_crude` | Crude bone awl | Piercing hide, basket work |
| `itm_bone_needle_crude` | Crude bone needle | Stitching with fiber/sinew |
| `itm_sinew_dried` | Dried sinew | Cord and stitching material |
| `itm_cordage_crude_short` | Short crude cordage | Binding, hanging, repairs |
| `itm_cordage_crude_long` | Long crude cordage | Larger shelter/storage uses |

### Clothing / body support
| ID | Item | Notes |
|---|---|---|
| `itm_wrap_hide_crude` | Crude hide wrap | Warmth, weather protection |
| `itm_foot_wrap_crude` | Crude foot wrap | Friction and cold reduction |
| `itm_cloak_brush_thatch_crude` | Crude brush/thatch cloak | Low durability weather layer |
| `itm_bedding_hide_layer` | Hide bedding layer | Warmer sleep |
| `itm_bedding_mat_improved` | Improved woven sleeping mat | Better dryness and comfort |

### Simple food diversity
| ID | Item | Notes |
|---|---|---|
| `itm_food_nuts_mixed` | Mixed nuts | High energy, variable seasonal access |
| `itm_food_mushrooms_known_safe` | Known safe mushrooms | Knowledge-gated |
| `itm_food_fat_renderable_small` | Small animal fat | Energy source, hide/soap relevance later |
| `itm_food_broth_simple` | Simple broth | Warm hydration and nutrient salvage |
| `itm_food_mixed_stew_simple` | Simple stew | Safer use of mixed gathered food if cooked |

## 9.4 Canonical new structures
- `str_storage_cache_covered`
- `str_storage_cache_raised_simple`
- `str_storage_hide_bag_hanging`
- `str_fire_hearth_stone_small`
- `str_shelter_lean_to_improved`
- `str_shelter_low_hut_brush`
- `str_drying_rack_small`
- `str_smoke_frame_simple`
- `str_workspot_hide_processing_simple`
- `str_workspot_fiber_processing_ground`
- `str_sanitation_waste_pit_small`
- `str_water_storage_clean_area_simple`
- `str_fuel_stack_basic`

## 9.5 Canonical new processes
- `pro_weave_crude_basket`
- `pro_make_hide_bag_crude`
- `pro_make_long_cordage`
- `pro_scrape_hide`
- `pro_stretch_hide_simple`
- `pro_smoke_soften_hide_simple`
- `pro_make_bone_awl`
- `pro_make_bone_needle`
- `pro_dry_meat_simple`
- `pro_dry_fish_simple`
- `pro_smoke_food_light`
- `pro_improve_hearth_ring`
- `pro_store_water_clean_covered`
- `pro_relocate_waste_zone`
- `pro_sort_food_clean_vs_dirty`
- `pro_repair_sleeping_mat`
- `pro_make_hide_wrap`
- `pro_make_foot_wrap`
- `pro_make_small_hanging_cache`
- `pro_create_fuel_stack`
- `pro_patrol_trapline_short`
- `pro_check_drying_rack`
- `pro_render_small_fat_simple`
- `pro_make_simple_broth`

## 9.6 Canonical tasks
- fetch and boil water
- refill clean water store
- gather and sort fuelwood
- maintain hearth
- inspect drying food
- collect trapline
- scrape or smoke hide before spoilage
- move food into covered storage
- repair carry basket
- make cordage
- upgrade shelter weatherproofing
- expand bedding insulation
- clean camp core
- dump waste farther out
- check for pests around food
- prepare warm meal before sleep

## 9.7 Canonical knowledge seeds
- `kno_cover_stored_water`
- `kno_clean_container_matters`
- `kno_dry_food_must_stay_dry`
- `kno_hanging_storage_reduces_pests`
- `kno_hide_flesh_removal_first`
- `kno_smoke_and_dry_not_same`
- `kno_fiber_twist_strength`
- `kno_fuel_sorting_small_to_large`
- `kno_hearth_stability_reduces_loss`
- `kno_clean_dirty_workspot_split`

## 9.8 Canonical player policy bundle
Add:
- keep one day of drinking water if possible
- keep one night of fuel if possible
- dry/cook small carcasses before other low-priority work
- do not store dirty vessels in clean water zone
- move waste and offal away from camp edge
- reserve one warm/sheltered sleep period daily when heavily fatigued
- prefer repair of baskets and containers before making duplicates

## 9.9 Canonical incidents / alerts
- drying rack wetted by rain
- hide rots before scraping
- basket break during haul
- smoke blows into shelter
- pests in exposed food
- hearth collapses / spreads embers
- contaminated water vessel used
- overwork without rest
- poor sleep due to damp bedding
- spoiled cache discovered

## 9.10 Promotion gates to Permanent Camp
Promote when the camp usually has:

- at least one improved shelter
- one stable hearth
- one or more covered storage methods
- a persistent water-handling workflow
- food preservation beyond same-day cooking
- distinct sanitation placement
- basic clothing/bedding improvement
- enough routine stability that some time can be spent on non-urgent work

---

# 10. Permanent Camp Package

## 10.1 Stage identity
The site becomes a place intended to survive across seasons rather than a temporary refuge.

## 10.2 Stage goals
- survive across season change
- keep meaningful food/fuel reserves
- use containers more effectively
- formalize storage and sanitation
- start strategic seed handling
- begin proto-horticulture and first garden plots
- attract or safely support another person

## 10.3 Canonical new items

### Clay / pottery / better storage
| ID | Item | Notes |
|---|---|---|
| `itm_clay_raw` | Raw clay | Needs cleaning and tempering |
| `itm_temper_sand` | Sand temper | Strength/stability aid |
| `itm_temper_grog_crude` | Crushed fired shards | Useful temper |
| `itm_clay_prepared` | Prepared clay body | Ready to shape |
| `itm_pot_uncured_small` | Unfired small pot | Fragile greenware |
| `itm_pot_fired_small` | Small fired pot | Better cooking/storage |
| `itm_jar_fired_small` | Small fired jar | Dry goods and water storage |
| `itm_lid_fired_crude` | Crude fired lid | Helps keep out dust/pests |
| `itm_shard_pottery` | Pottery sherds | Grog, scraping, discard |

### Strategic food and seed
| ID | Item | Notes |
|---|---|---|
| `itm_seed_saved_mixed` | Saved seed mix | Strategic planting reserve |
| `itm_seed_selected_small` | Selected seed stock | Better future use than mixed edible stock |
| `itm_grain_wild_harvest_small` | Wild-harvest grain/seed heads | Drying/processing required |
| `itm_food_dried_roots` | Dried roots/tubers | Storable if kept dry |
| `itm_food_dried_berries` | Dried berries | Preserved gathered food |
| `itm_food_nut_cache_clean` | Clean nut reserve | Dry reserve item |
| `itm_food_stew_pot_batch` | Pot-cooked batch food | Good for household feeding |
| `itm_food_rendered_fat_small` | Rendered fat | Dense calories, hide care, lamp/soap future |

### Fiber / woven goods
| ID | Item | Notes |
|---|---|---|
| `itm_thread_crude_plant` | Crude plant thread | Sewing/binding |
| `itm_netting_small_crude` | Small crude netting | Fishing/trapping aid |
| `itm_basket_storage_improved` | Improved storage basket | Better dry storage |
| `itm_mat_drying_improved` | Improved drying mat | Better drying sanitation |
| `itm_sack_fiber_crude` | Crude fiber sack | Dry low-moisture storage |

### Garden / soil / camp maintenance
| ID | Item | Notes |
|---|---|---|
| `itm_mulch_plant_dry` | Dry mulch | Soil cover |
| `itm_stake_garden_small` | Garden stake | Support / marking |
| `itm_ash_screened_small` | Screened ash | Limited cleaning / soil use later |
| `itm_composting_plant_waste_early` | Early rotting plant waste | Not formal compost yet |

## 10.4 Canonical new structures
- `str_storage_pit_lined_simple`
- `str_storage_pit_dry_cool`
- `str_storage_seed_cache_protected`
- `str_storage_food_house_small`
- `str_water_store_pot_cluster_clean`
- `str_pottery_workspot_simple`
- `str_kiln_pit_simple`
- `str_shelter_hut_improved`
- `str_shelter_shared_hut_small`
- `str_latrine_area_simple`
- `str_wash_area_offstream_simple`
- `str_garden_plot_small`
- `str_seed_drying_rack_small`
- `str_workspot_basketry_simple`
- `str_workspot_cooking_clean`
- `str_fence_light_garden`
- `str_path_camp_basic`
- `str_store_fuel_covered_small`

## 10.5 Canonical new processes
- `pro_find_clay_source`
- `pro_clean_clay`
- `pro_prepare_temper`
- `pro_mix_clay_body`
- `pro_shape_small_pot`
- `pro_air_dry_greenware`
- `pro_fire_small_pottery_batch`
- `pro_sort_seed_edible_vs_planting`
- `pro_dry_seed_for_storage`
- `pro_store_seed_protected`
- `pro_prepare_garden_plot`
- `pro_mulch_garden_plot`
- `pro_plant_seed_small_plot`
- `pro_water_garden_by_hand`
- `pro_weed_garden_small`
- `pro_make_fiber_sack`
- `pro_make_small_netting`
- `pro_cook_pot_stew_batch`
- `pro_store_dried_food_clean`
- `pro_inspect_pit_storage`
- `pro_move_water_to_clean_pot`
- `pro_establish_wash_area`
- `pro_build_latrine_zone`
- `pro_cover_latrine_use`
- `pro_make_shared_hut`
- `pro_build_light_garden_fence`

## 10.6 Canonical tasks
- collect clay
- temper and prepare clay
- shape/dry/fire small vessel
- fill clean jars with water
- protect seed stock from consumption
- water garden during dry spell
- weed and protect plots
- inspect covered storage and pits
- rotate drying stock
- repair hut weather gaps
- move wash activity away from water source
- clean cooking zone
- carry fuel under cover
- prepare second sleeping place
- make containers before seasonal rain
- maintain path between hearth, storage, water, latrine

## 10.7 Canonical knowledge seeds
- `kno_clay_needs_temper`
- `kno_greenware_breaks_easy`
- `kno_slow_dry_before_fire`
- `kno_seed_must_stay_dry`
- `kno_seed_not_same_as_food`
- `kno_pit_storage_stays_cool_if_dry`
- `kno_wash_zone_should_not_be_at_source`
- `kno_garden_needs_protection`
- `kno_shared_housing_changes_morale`
- `kno_clean_cooking_area_reduces_illness`

## 10.8 Canonical player policy bundle
Add:
- lock planting seed reserve
- lock one emergency food reserve if possible
- keep clean water vessels in protected zone
- keep wash/dish activity away from source
- prefer covered storage before expanding food gathering farther
- prioritize hut repair before major rain/cold
- keep one spare sleeping space once recruitment becomes possible

## 10.9 Canonical incidents / alerts
- pottery firing failure
- seed dampness discovered
- pit storage mold risk
- rats/pests near food house
- garden browsing damage
- latrine too close to camp/water
- shared shelter crowding complaint
- container break causing water loss
- long-distance water hauling fatigue
- cold spell before enough bedding/fuel exists

## 10.10 Promotion gates to Tiny Hamlet
Promote when the site usually has:

- more than one regularly used sleeping place
- persistent reserves of food, fuel, and safer water
- sanitation area plus wash separation
- strategic seed handling
- at least one garden plot or reliable proto-cultivation area
- multiple specialized workspots
- sufficient stability that a second/third person can join and remain

---

# 11. Tiny Hamlet Package

## 11.1 Stage identity
The site now supports multiple people with real labor division, shared reserves, and the first recognizable social/economic roles.

## 11.2 Stage goals
- maintain food stability for multiple adults
- support first role separation
- coordinate shared storage and care labor
- formalize household / communal reserves
- expand gardens and start true small surplus
- provide enough shelter, sanitation, and trust for newcomers to remain

## 11.3 Canonical new items

### Shared household and settlement items
| ID | Item | Notes |
|---|---|---|
| `itm_ledger_memory_tokens_primitive` | Primitive tally markers | Non-written record aids |
| `itm_ration_bundle_day` | Daily ration bundle | Allocation unit |
| `itm_tool_set_camp_basic` | Shared camp tool set | Bundle concept for core tools |
| `itm_bedding_set_basic` | Basic sleeping set | Mat + hide/wrap + cover |
| `itm_water_day_reserve_household` | Daily household water reserve | Allocation concept |
| `itm_food_household_dry_reserve` | Shared dry reserve | Emergency communal reserve |
| `itm_seed_household_reserve` | Protected seed reserve | Communal strategic stock |
| `itm_clothing_bundle_basic` | Basic clothing bundle | Minimum dignity/warmth kit |

### Expanded food and garden outputs
| ID | Item | Notes |
|---|---|---|
| `itm_crop_garden_harvest_small` | Small garden harvest | Mixed plot output |
| `itm_food_pulse_like_dried_small` | Small dried legume-like output | If biome/crop set allows |
| `itm_food_leaf_crop_bundle` | Garden greens bundle | Fast perishability |
| `itm_food_storage_mix_household` | Household mixed stored food | Multi-item reserve category |
| `itm_mulch_bundle_large` | Larger mulch bundle | Garden maintenance |

### Craft support / role items
| ID | Item | Notes |
|---|---|---|
| `itm_apron_hide_crude` | Hide work apron | Minor hygiene/protection aid |
| `itm_basket_hauling_large` | Large hauling basket | Better labor efficiency |
| `itm_sling_pole_drag_simple` | Pole drag / travois-like aid | Terrain-dependent haul assist |
| `itm_cordage_bundle_workshop` | Cordage stock bundle | Shared workshop supply |
| `itm_pottery_batch_household` | Household pottery set | Cooking + storage cluster |
| `itm_repair_bundle_basic` | Basic repair stock | Fiber, thongs, patches, pegs |

## 11.4 Canonical new structures
- `str_household_hut_2to3`
- `str_granary_proto_small`
- `str_storehouse_small`
- `str_cookhouse_small`
- `str_meeting_fire_common`
- `str_workhut_mixed_small`
- `str_garden_cluster_household`
- `str_fence_camp_light_perimeter`
- `str_path_core_network`
- `str_latrine_cluster_small`
- `str_wash_line_improved`
- `str_care_bed_sheltered`
- `str_guest_sleep_spot`
- `str_cache_outer_foraging_route`
- `str_watch_post_simple` (very light lookout / awareness point)

## 11.5 Canonical new processes
- `pro_allocate_daily_rations`
- `pro_refill_household_water_reserve`
- `pro_prepare_shared_meal`
- `pro_rotate_reserves_fifo_simple`
- `pro_transfer_goods_to_storehouse`
- `pro_mark_seed_reserve_do_not_touch`
- `pro_train_newcomer_basic_camp_rules`
- `pro_assign_work_role`
- `pro_run_shared_cleanup`
- `pro_maintain_core_paths`
- `pro_build_guest_sleep_spot`
- `pro_expand_garden_cluster`
- `pro_harvest_plot_batch_small`
- `pro_dry_harvest_batch_small`
- `pro_store_harvest_proto_granary`
- `pro_check_household_bedding_sets`
- `pro_check_all_water_pots`
- `pro_run_evening_headcount_and_fire_check`

## 11.6 Canonical tasks
- draw communal water
- cook shared pot meal
- clean shared cooking zone
- distribute day rations
- move dry goods into common storage
- teach newcomer camp rules
- escort newcomer to water / latrine / fire / sleeping zones
- maintain guest sleeping place
- inspect all huts for crowding/wetness
- check reserve thresholds
- harvest and process garden output
- repair large hauling basket
- carry goods from outer cache
- watch for perimeter hazards
- provide care/rest support to sick or injured member
- hold group clean-up before rain
- restock fuel at common fire

## 11.7 Canonical knowledge seeds
- `kno_shared_store_requires_rules`
- `kno_fairness_affects_compliance`
- `kno_reserves_must_be_visible`
- `kno_newcomers_need_orientation`
- `kno_communal_cleanup_prevents_decay`
- `kno_small_surplus_supports_specialization`
- `kno_household_and_common_stores_can_conflict`
- `kno_path_maintenance_saves_labor`
- `kno_guest_space_improves_integration`
- `kno_common_fire_supports_social_cohesion`

## 11.8 Canonical player policy bundle
Add:
- communal versus personal storage rules
- household ration policy
- emergency reserve policy
- newcomer probation permissions
- role assignment preferences
- shared cleanup schedule
- sleep-space minimum rule
- common fire maintenance rule
- “care first” escalation for the sick/injured

## 11.9 Canonical incidents / alerts
- dispute over stored food use
- newcomer mistrust / low compliance
- crowding lowers sleep quality
- common storage contamination event
- seed reserve nearly consumed
- garden failure patch
- hauling route too long for current labor
- one worker overloaded with water/fuel labor
- morale drop from unfair rationing
- unmaintained latrine / wash area begins affecting health

## 11.10 Tiny Hamlet success criteria
A tiny hamlet should feel “real” when all of the following can happen reliably:

- multiple people survive together for an extended period
- daily water, food, sleep, and sanitation routines are stable
- at least one reserve category is visibly protected from casual consumption
- at least two or three roles emerge naturally (e.g. gatherer/water, cook/store, builder/crafter, gardener)
- newcomers can be housed, oriented, and integrated
- the settlement can absorb a small setback without immediate collapse

---

# 12. Canonical early content categories across all stages

## 12.1 Item family index
Early item families that should exist in the data:

- water
- untreated water containers
- clean water containers
- stones and flakes
- wood fuel grades
- poles / structural wood
- brush / leaf cover
- bark / fiber / cordage
- hides in multiple processing states
- bone / sinew
- gathered plant foods
- animal foods
- cooked foods
- dried foods
- fats
- bedding
- crude clothing
- clay / temper / greenware / fired pottery
- seed and harvest states
- storage and repair bundles
- waste / spoilage / ash / offal / sherds

## 12.2 Process family index
Early process families:

- scouting
- water collection
- water clarification/boiling/storage
- fuel gathering/sorting
- fire lighting/maintenance
- shelter clearing/building/repair
- bedding creation/repair
- primitive toolmaking
- hunting/trapping/fishing
- butchery and waste disposal
- cooking
- drying and light smoking
- hide scraping/drying/softening/smoking
- fiber gathering/twisting/weaving
- basketry and sacks
- clay preparation and vessel firing
- sanitation placement and upkeep
- garden preparation/planting/weeding/protection
- reserve sorting/locking/rotation
- orientation/training/newcomer integration
- cleanup and path maintenance

## 12.3 Structure family index
Early structure families:

- sleeping spots
- windbreaks
- lean-tos and low huts
- hearths and common fires
- exposed / covered / raised caches
- hanging storage
- drying racks and smoke frames
- hide/fiber/clay workspots
- water storage zones
- fuel stacks
- catholes / waste pits / latrine zones
- wash areas
- garden plots and fences
- paths
- storehouses / proto-granaries
- guest and care spaces

## 12.4 Task family index
Early task families:

- emergency survival
- daily maintenance
- reserve support
- hygiene and sanitation
- food acquisition
- food preservation
- container creation/repair
- shelter upkeep
- hauling
- gardening
- social onboarding
- care labor
- camp/hamlet cleanup
- preparation for weather / night / season change

## 12.5 Knowledge family index
Early knowledge families:

- safe water handling
- fire and tinder handling
- sleep/dryness/warmth
- contamination awareness
- carcass spoilage speed
- hide workflow
- fiber and cordage
- storage pests/moisture
- seed separation
- pottery workflow
- camp zoning
- communal reserve rules
- newcomer integration
- fairness / compliance / morale links

---

# 13. Canonical early role emergence

This pack assumes roles emerge gradually, not instantly.

## 13.1 Lone survivor roles
The single NPC cycles among:
- scout
- gatherer
- water hauler
- fire tender
- shelter improver
- food preparer
- self-carer

## 13.2 Primitive camp role bias
The lone NPC may begin to bias toward:
- food procurer
- hide/fiber worker
- container maker
- shelter maintainer

## 13.3 Permanent camp role emergence
With a second person:
- one tends daily water/fuel/cooking/storage
- one leans toward gathering/building/garden/clay
- both still cover emergencies

## 13.4 Tiny hamlet role emergence
With 3–8 people, the first stable roles might be:

- water and fuel laborer
- cook/storekeeper
- gatherer/hunter
- shelter/builder
- garden tender / seed keeper
- crafter (hide/fiber/pottery)
- care-oriented helper
- newcomer support / general labor

These are not rigid professions yet.

---

# 14. Canonical early reserve model

The content pack assumes the following reserve buckets exist by the end of the tiny hamlet stage:

- drinking water reserve
- fuel reserve
- immediate food reserve
- dry food reserve
- emergency food reserve
- seed reserve
- bedding/clothing reserve
- repair materials reserve
- clean container reserve

Each reserve should later have:
- minimum target
- warning threshold
- hard lock / soft lock behavior
- preferred storage location
- contamination / spoilage exposure risks

---

# 15. Canonical early alert model

The early game should repeatedly surface these alert classes:

## 15.1 Red alerts
- no drinkable water
- severe weather exposure risk
- no safe sleeping arrangement before night
- severe exhaustion
- active wound / infection danger
- food reserve exhausted
- fire out in cold conditions
- contamination of core water store
- seed reserve consumed

## 15.2 Amber alerts
- low fuel
- poor bedding dryness
- drying food threatened by rain
- storage pest signs
- latrine / wash placement problem
- pot/container breakage
- low reserve trend
- role overload on one NPC
- unfair rationing complaints
- newcomer trust slipping

## 15.3 Informational alerts
- berries in season
- clay source discovered
- drying batch complete
- basket repaired
- new path saves travel time
- guest space available
- garden plot ready for planting

---

# 16. Canonical incident pack

These are the recommended early incidents/events that should exist from the start, even if some are rare:

- brief rain soak
- cold night
- hot dry spell
- muddy water after rain
- dirty vessel contaminates safe water
- accidental cross-contamination in cooking area
- basket tears under load
- hide spoils before processing
- trapline empty streak
- small animal steal from exposed cache
- mold starts in damp pit storage
- pottery cracks during drying
- pottery breaks during firing
- newcomer arrives weak/tired/hungry
- disagreement over reserve use
- low morale after repeated wet sleep
- overexertion strain after repeated hauling
- night fright / animal sound / alarm
- minor fire spread from hearth
- latrine too near active path or water approach

---

# 17. Canonical first-playable minimum subset

If implementation needs a smaller starting cut, use this minimum subset first.

## 17.1 Minimum items
- clear untreated water
- boiled water
- hammer stone
- sharp flake
- dry twig bundle
- small dry branch
- brush bundle
- crude pole
- edible mixed plants
- raw small game
- cooked meat
- brush bedding
- crude basket
- crude cordage
- hide bag crude
- dried meat simple
- raw clay
- small fired pot
- saved seed mix
- mixed fuelwood bundle

## 17.2 Minimum processes
- scout local area
- collect water
- boil water
- gather deadwood
- clear sleep ground
- build debris lean-to
- build hearth
- gather edible plants
- hunt small game
- butcher small game
- cook food
- make crude basket
- make cordage
- scrape hide
- dry meat
- prepare garden plot
- plant seed
- shape small pot
- fire small pot
- store seed protected

## 17.3 Minimum structures
- cleared sleep spot
- lean-to
- small hearth
- covered cache
- drying rack
- waste pit / cathole area
- clean water area
- improved hut
- small garden plot
- small pottery workspot

## 17.4 Minimum tasks
- fetch water
- gather fuel
- maintain fire
- get food
- cook food
- rest
- build shelter
- repair shelter
- make container
- preserve food
- protect seed
- tend garden
- clean camp
- inspect reserve thresholds

## 17.5 Minimum knowledge seeds
- cover stored water
- keep dirty work away from clean water/food
- dry food must stay dry
- seed is not ordinary food
- better bedding improves recovery
- waste near camp worsens risk
- clay needs careful drying and firing
- carrying aids save labor

---

# 18. Recommended implementation order for this content pack

1. Start-state tasks and alerts
2. Lone survivor items/processes/structures
3. Primitive camp carrying, storage, drying, hide, and bedding content
4. Permanent camp pottery, seed, sanitation, and garden content
5. Tiny hamlet communal stores, guest space, rationing, and onboarding content
6. Incidents and alerts across all stages
7. Tuning and pruning after playtest

This order best matches the survival logic and the early-stage milestone ladder already established elsewhere in the design stack.

---

# 19. References and grounding notes

The content choices in this pack are grounded partly in the project’s own design stack and partly in real-world public-health, storage, sanitation, and handling guidance relevant to early survival/settlement logic.

## External reference notes
- CDC: making water safer in emergencies; clarification for cloudy water; boiling; clean covered storage
- CDC: emergency water storage handling and sanitizing containers
- USDA FSIS / FoodSafety.gov: clean, separate, cook, chill and cross-contamination basics
- FAO: grain and seed storage; dryness, pest pressure, storage cleanliness, temperature stability
- Leave No Trace / NPS: cathole depth and distance from water, camp, and trails
- WHO: domestic water quantity and service level; water access burden and minimum survival/hygiene quantities
- CDC / NIOSH: manual material handling burden and carry-distance risk

## URLs
- https://www.cdc.gov/water-emergency/about/index.html
- https://www.cdc.gov/water-emergency/about/how-to-create-and-store-an-emergency-water-supply.html
- https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/food-safety-basics/steps-keep-food-safe
- https://www.foodsafety.gov/keep-food-safe/4-steps-to-food-safety
- https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content
- https://www.fao.org/4/i2433e/i2433e10.pdf
- https://lnt.org/why/7-principles/dispose-of-waste-properly/
- https://www.nps.gov/articles/leave-no-trace-seven-principles.htm
- https://iris.who.int/bitstream/handle/10665/338044/9789240015241-eng.pdf
- https://www.who.int/teams/environment-climate-change-and-health/water-sanitation-and-health/environmental-health-in-emergencies/humanitarian-emergencies
- https://www.cdc.gov/niosh/media/pdfs/Ergonomic-Guidelines-for-Manual-Material-Handling_2007-131.pdf

---

# 20. Short conclusion

This content pack is the recommended **canonical early database seed** for the project.

It gives the early slice actual substance:
- concrete things
- concrete work
- concrete places
- concrete risks
- concrete reserves
- concrete progression gates

From here, the next layer should either be:

1. **World / Map / Site Generation Spec**, to define where this content lives spatially, or
2. **Event / Incident Spec**, to deepen how instability and surprise reshape the early loop.
