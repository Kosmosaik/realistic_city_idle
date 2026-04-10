---
title: "Realistic Idle City - Time / Season / Labor Calendar Spec"
version: "v0.1"
scope:
  - "Early slice only: lone survivor -> primitive camp -> permanent camp -> tiny hamlet"
  - "Temperate starting biome"
  - "Research-backed design spec"
status: "Design document"
date: "2026-04-09"
---

# Time / Season / Labor Calendar Spec v0.1

## Purpose

This document defines how **time**, **seasons**, **daylight**, **weather pressure**, **labor capacity**, and **seasonal deadlines** should work in the early slice of the project.

It is the calendar-and-rhythm layer that sits on top of the existing design stack:

- the base design establishes that the starting biome is temperate, that seasons should create real survival pressure, and that the first vertical slice should cover lone survivor -> primitive camp -> permanent camp -> small hamlet with seasonal agriculture, storage, spoilage, and role assignment
- the settlement progression spec already says camps should not stage-up from object count alone
- the logistics spec already says hauling and stock placement are real work
- the health, hazard, food/water safety, allocation, and process docs already say that exhaustion, contamination, exposure, preservation windows, and reserve burdens are all real

This document makes those pressures happen on a believable calendar instead of as random background penalties.

---

# 1. Design role of the calendar

## 1.1 What this layer is for

The calendar system should answer questions like:

- How much usable work time does a day actually contain?
- How does day length affect labor?
- When does drying work well?
- When does wet weather slow or halt work?
- When do food and fuel reserves become dangerous?
- When do planting and harvest windows matter?
- When does the camp need to shift from expansion to preservation and winter prep?
- Why does one season feel abundant and another feel desperate?

The goal is not decorative seasons.

The goal is to make the colony feel like it is living inside a real annual survival loop.

## 1.2 Core realism rule

The calendar is a **constraint-and-opportunity system**, not a cosmetic one.

Seasons should change:

- daylight available for work
- temperature stress and wetness burden
- water access difficulty
- food availability and spoilage risk
- fuel demand
- preservation success
- travel/hauling efficiency
- crop windows
- sickness patterns
- labor allocation priorities

## 1.3 Why the calendar matters so much

In real seasonal livelihoods, calendars are used to understand not only rainfall and planting but also labor peaks, food availability, water availability, income/expenditure stress, and crisis periods. FAO seasonal-calendar guidance treats seasonality as a core way to understand food security and livelihoods rather than as a side note. [R1][R2]

That is exactly how this game should use it.

---

# 2. Scope and assumptions

## 2.1 Scope of this version

This version covers only:

- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

It does **not** yet define later systems such as draft animals, mills, market calendars, industrial shift work, school calendars, or mechanized agriculture.

## 2.2 Biome assumption

The calendar assumes an **Earth-like temperate biome** with:

- four broad seasons
- meaningful changes in daylight length
- periods favorable for gathering and growing
- periods unfavorable for drying and outdoor work
- a winter fuel burden
- a pre-harvest scarcity pressure
- weather variation within each season

The exact dates are not fixed globally. Latitude, elevation, and local climate should shift the timing.

## 2.3 Intentional design boundary

This calendar should be **biome-driven and relative**, not tied to one modern real-world region's planting dates.

That means:
- the system defines **windows**, **pressures**, and **task families**
- world generation and biome parameters shift the exact start/end of those windows

Example:
- "main sowing window opens when soil warmth/moisture become adequate"
- not "plant on April 17"

---

# 3. Calendar architecture

## 3.1 Recommended hierarchy

Use five nested scales:

1. **Tick / simulation pulse**  
   Small internal update unit.

2. **Hour block**  
   Main unit for body drift, visibility, temperature swing, work scheduling, and sleep.

3. **Day**  
   Main unit for reserves, routines, weather summary, task plans, and perishable checks.

4. **Week / multi-day block**  
   Useful for trend checks, repairs, social rhythms, and reserve warnings.

5. **Season / year**  
   Main unit for resource abundance, preservation windows, fuel pressure, planting/harvest timing, and settlement viability.

## 3.2 Recommended practical time model

For design purposes:

- the game should internally track continuous time
- but most player-facing reasoning should happen in **days**, **weeks**, and **seasons**
- the simulation should expose **today**, **season phase**, **weather state**, and **days until key windows close**

The player should rarely need to think in seconds.
They should constantly need to think in:
- "before nightfall"
- "before the rain arrives"
- "before first hard cold"
- "before stores run out"
- "before sowing window closes"

## 3.3 Day partition

A day should be divided into functional periods, not just numbers on a clock.

Recommended daily segments:

- pre-dawn
- morning
- midday
- afternoon
- dusk
- night

These matter because:
- visibility changes
- cold/heat peaks shift
- water trips feel different
- hunting/foraging success windows can vary
- fire tending and sheltering matter more at night
- long manual work late into the night should carry fatigue and safety penalties

---

# 4. Daylight, circadian rhythm, and work window

## 4.1 Daylight as a real labor limit

In the early slice, most work should be strongly tied to natural light.

Without strong artificial lighting, darkness should reduce:
- movement speed
- search efficiency
- harvesting accuracy
- safety
- spotting hazards and animals
- construction speed
- fine craft quality

Night should remain possible for limited activities:
- fire tending
- short water trip if urgent
- feeding/care tasks
- simple nearby hauling
- shelter maintenance
- watch duty
- indoor or near-fire handwork

But the player should generally not want routine night labor.

## 4.2 Seasonal daylight variation

The calendar should vary:
- sunrise/sunset times
- useful light duration
- dawn/dusk transition length

Effects:
- summer = longer work window
- winter = shorter work window
- shoulder seasons = unstable balance between labor ambition and weather risk

## 4.3 Human performance and circadian timing

CDC/NIOSH material notes that changes in light and time can disrupt circadian rhythms and sleep, while fatigue and poor sleep impair attention, reasoning, memory, and safety. [R3][R4][R5]

Game implication:
- forcing repeated late-night work should have a real cost
- even if the player can push labor, the colony should pay in errors, injuries, morale, and slower learning

## 4.4 Workable rule

Each NPC should have:
- **potential waking time**
- **safe efficient work time**
- **unsafe overextension time**

This prevents the colony from functioning like tireless machinery.

---

# 5. Season model

## 5.1 Recommended season structure

Use four macro-seasons, each optionally split into early/late phases:

- spring
- summer
- autumn
- winter

Why not only monthly logic?
Because the early slice works better when the player thinks in broad survival phases:
- recovery and sowing
- gathering and building
- harvest and stockpiling
- endurance and maintenance

## 5.2 What seasons change

Each season should modify:

- daylight length
- average temperature range
- wetness / drying conditions
- storm probability
- river/stream behavior
- edible plant availability
- insect/pest pressure
- small game behavior/availability
- preservation success
- hauling difficulty
- water carrying burden
- fuel consumption
- sleeping burden
- clothing/bedding importance
- outdoor work efficiency
- morale tone

## 5.3 Season phase labels

Each season should also have a meaningful phase label, for example:

### Spring
- thaw / mud
- growth / sowing

### Summer
- early abundance
- high-work / preservation peak

### Autumn
- harvest / stock build
- cold-prep / late harvest

### Winter
- early winter
- hard winter / late winter scarcity

This gives the player a better mental model than only "Spring Day 18".

---

# 6. Seasonal labor logic

## 6.1 Labor is seasonal, not flat

FAO guidance and related labor literature repeatedly emphasize that labor, food, water, and livelihood pressures are seasonal, and that missing a seasonal window can create knock-on damage in the next season. [R1][R2][R6]

That should be a central law of the game.

## 6.2 Main labor types by season

### Spring labor profile
Main pressure:
- site repair after winter
- drainage and cleanup
- water access stabilization
- seed selection and protection
- plot preparation
- sowing/transplanting
- tool repair before peak season

Risk:
- cold snaps
- mud
- wet work
- overcommitting before reserves stabilize

### Summer labor profile
Main pressure:
- long workdays
- gathering
- gardening
- tending
- drying and smoking
- fuel gathering and drying start
- basketry / cordage / simple building
- clay work when weather supports drying
- stock processing

Risk:
- heat stress
- dehydration
- overwork
- spoilage if processing lags

### Autumn labor profile
Main pressure:
- harvest
- threshing/cleaning/drying
- reserve accounting
- seed separation and storage
- intensive firewood cutting, splitting, moving, stacking
- shelter weatherproofing
- clothing/bedding reinforcement
- culling/preservation decisions

Risk:
- missing the pre-winter prep window
- rain damaging harvest or firewood
- exhausting workers before winter starts

### Winter labor profile
Main pressure:
- fuel consumption
- water access friction
- keeping people warm, fed, and dry
- maintenance and repair
- indoor or sheltered craft
- care burden
- reserve rationing
- path clearing / snow or mud workaround depending climate

Risk:
- exposure
- reserve collapse
- sickness clustering
- morale decline
- reduced outdoor productivity

## 6.3 Labor peaks and bottlenecks

The early slice should have **real labor peaks**:

- urgent site-making at start
- first preservation rush
- main sowing window
- main harvest window
- main fuel stockpile period
- pre-winter shelter weatherproofing
- late-winter scarcity management

These peaks create realism because they force tradeoffs:
- expand camp or dry food?
- gather wood or finish hide work?
- plant on time or keep foraging?
- harvest everything or lose some yield?
- build one more hut or split and stack fuel?

---

# 7. Daily labor capacity

## 7.1 Base idea

Each NPC should have a **daily labor budget**, but not as one simple number.
It should be built from:

- wakefulness / sleep quality
- calories/hydration
- temperature strain
- load strain
- pain/injury/illness
- morale and willingness
- role familiarity
- daylight
- interruptions
- care burden
- weather drag

## 7.2 Capacity bands

Use three bands:

### A. Sustainable capacity
Work level the NPC can repeat without major degradation.

### B. Strained capacity
Possible for short periods, but increases fatigue, error, and mood cost.

### C. Emergency capacity
Reserved for crises:
- fire
- exposure rescue
- urgent water shortage
- violent storm prep
- medical emergency
- predator breach

## 7.3 Rest and recovery

NIOSH guidance supports short recovery breaks during demanding work and highlights heavy workload, extreme temperatures, and insufficient breaks as fatigue risks. [R7][R8]

Game implication:
- long, unbroken labor should be a bad policy
- better scheduling and reasonable pauses should outperform brute-force overextension over time

## 7.4 Cooperative efficiency

Some tasks should become materially easier with more than one worker:
- carrying water in multiple containers
- moving logs
- erecting larger structures
- processing bulk harvest quickly
- emergency weather prep
- heat-safe work rotation

NIOSH heat guidance also explicitly recommends reducing metabolic demand and increasing workers per task where possible. [R8]

---

# 8. Calendar-coupled reserve systems

## 8.1 Why reserves are calendar objects

A reserve is not only "how much exists."
It is also:
- how long it lasts
- whether it can survive the current season
- whether it is in the right form
- whether it is accessible when needed
- whether it is protected from spoilage

So each reserve should be evaluated against the calendar.

## 8.2 Main early reserves

### Water reserve
Questions:
- Is water nearby?
- Is source reliability changing with season?
- Is enough safe water stored for evening/night or storm periods?
- Are containers clean and covered?

WHO emergency water guidance supports the idea that practical domestic needs span drinking, food preparation, and hygiene, with minimums around 7.5–15 liters per person per day depending conditions and more if higher hygiene provision is to be maintained. [R9][R10]

Game implication:
- water hauling burden rises sharply with distance and poor storage
- winter or drought-like conditions can turn a manageable site into a dangerous one

### Food reserve
Questions:
- How many days of edible food are on hand?
- How much is perishable vs preserved?
- Is late-winter reserve modeled as high-risk scarcity?
- Are seed reserves protected from consumption?

### Fuel reserve
Questions:
- Is enough dry burnable material stored for coming cold/wet periods?
- Is the pile dry enough to be efficient?
- Is it staged near camp?

Extension sources consistently recommend that firewood be split, stacked off the ground, given airflow, and typically seasoned for roughly 6–12 months to reach efficient burn moisture; rain/snow rewetting is a real issue if stored badly. [R11][R12][R13][R14]

Game implication:
- "cut wood" is not the same thing as "ready heating fuel"
- autumn fuel preparation should be one of the major strategic races in the early game

### Seed reserve
Questions:
- Is seed clean, dry, cool enough, and protected from pests?
- Is edible grain being confused with seed stock?
- Is reserve viability declining?

USDA Forest Service and extension material emphasize that many seeds store better under cool, dry, low-humidity conditions, and that moisture is a major driver of viability loss. [R15][R16][R17]

Game implication:
- seed is not just food with a different tag
- bad storage can erase next season before it starts

### Clothing / bedding reserve
Questions:
- Are there enough wraps, hides, mats, bedding, and repair materials?
- Are sleeping places still insulated enough for the season?
- Are wet textiles/hides drying between uses?

## 8.3 Reserve clocks

Every core reserve should have at least three time-facing measures:
- amount on hand
- safe days remaining under current season
- days until next replenishment window or relief opportunity

That makes the calendar legible to the player.

---

# 9. Weather, season, and task suitability

## 9.1 Task-weather matrix

Tasks should not merely speed up or slow down.
Some should become:
- favorable
- tolerable
- inefficient
- risky
- blocked

Examples:

### Favorable in warm/dry weather
- drying meat/fish/plants
- basketry gathering and processing
- clay shaping and pre-fire drying
- thatch collection
- firewood splitting and stacking
- repair work outdoors

### Favorable in cold season or indoor time
- tool repair
- cordage finishing
- hide softening/finishing under shelter
- planning/accounting
- teaching and memory work
- container inspection
- clothing repair

### Discouraged in heavy wet conditions
- long-distance carrying
- building with moisture-sensitive materials
- open-air drying
- exposed sleep without upgraded shelter
- unnecessary river crossings

## 9.2 Seasonal suitability windows

Every major early process should declare:
- preferred season
- workable season(s)
- blocked conditions
- weather_sensitivity
- daylight_sensitivity
- urgency_curve
- reserve_dependency
- consequence_if_missed

This is the exact bridge between the Process Bible and the Calendar Spec.

---

# 10. First-year survival arc

## 10.1 Why first year is special

The first year is the colony's harshest teacher because:
- there is no stockpile history
- there is almost no redundancy
- mistakes compound fast
- the first winter is usually underprepared
- the first spring can expose whether the settlement actually has seed, tools, and labor structure

## 10.2 Stage A — Arrival / immediate survival

Main calendar logic:
- time to nightfall matters more than long-term plans
- safe sleep, water, and fire matter more than perfect tool chains
- every wasted trip hurts

Main labor priorities:
1. water
2. emergency shelter
3. fire
4. immediate food
5. minimal sanitation
6. short-range stockpiling

## 10.3 Stage B — First stable days

Main calendar logic:
- each day should begin to differentiate into work, processing, and recovery
- the camp starts laying down routine

Main labor priorities:
1. better carrying
2. better storage
3. better bedding/clothing
4. repeatable food acquisition
5. preservation start
6. fuel storage start

## 10.4 Stage C — First seasonal commitment

Main calendar logic:
- the colony begins to stop reacting only to today
- work is now chosen partly for next week/next season

Main labor priorities:
1. food preservation
2. clay/container experimentation where feasible
3. seed protection and plot prep
4. camp drainage and layout improvement
5. winter-facing reserve thinking

## 10.5 Stage D — First winter confrontation

Main calendar logic:
- success is measured by endurance, not growth
- expansion should slow unless reserves are unusually strong

Main labor priorities:
1. maintain heat
2. protect sleep and dryness
3. preserve safe water access
4. ration stores intelligently
5. repair damage
6. avoid unnecessary injury

## 10.6 Stage E — First spring recovery

Main calendar logic:
- winter damage is assessed
- reserve truth becomes visible
- the settlement either transitions toward permanence or falls back toward desperation

Main labor priorities:
1. water and drainage stabilization
2. shelter repair
3. sowing / transplanting
4. tool restoration
5. food gap management
6. role differentiation if more NPCs exist

---

# 11. Seasonal food rhythm

## 11.1 Food should feel different by season

The early slice should not offer the same food logic year-round.

Recommended pattern:

### Spring
- possible hunger gap
- lower preserved reserves than player wants
- fresh greens and early gathered foods start returning
- agricultural labor starts before new harvest arrives

### Summer
- wider gathering range
- more fresh foods
- preservation race begins
- food abundance can still be lost if processing lags

### Autumn
- biggest stock-building chance
- grain/seed separation matters
- root storage and drying matter
- slaughter/preservation decisions can intensify

### Winter
- preserved and stored food dominate
- fresh food is limited
- spoilage, pests, and rationing mistakes become very visible
- morale becomes linked to food quality and monotony

## 11.2 Hunger-gap logic

The calendar should strongly support a **late-winter / pre-harvest stress period** in many starts.
This creates believable seasonal tension without forcing instant famine every year.

---

# 12. Seasonal water rhythm

## 12.1 Water is not equally easy year-round

Season and weather should affect:
- source quality
- source accessibility
- carrying difficulty
- freezing risk
- contamination risk
- queue/competition at sources later when more NPCs exist

## 12.2 Water calendar examples

### Wet season / snowmelt / muddy phase
- more surface water present
- more contamination risk
- harder movement
- worse camp wetness

### Warm stable phase
- easier hauling and washing
- higher daily consumption
- higher heat stress and dehydration risk

### Winter phase
- surface access can be slower or partially blocked
- carrying is harder
- liquid storage near freezing is a management issue
- water trips become more dangerous if distant

---

# 13. Seasonal fuel rhythm

## 13.1 Fuel should be strategic

Fuel is not just a winter number.
The calendar should model:
- collection timing
- drying/seasoning delay
- stacking labor
- re-wetting risk
- proximity to shelter/hearth
- seasonal consumption spikes

## 13.2 Firewood as a time-lagged resource

Because real firewood often needs months of drying to burn efficiently, the colony should be rewarded for:
- cutting early enough
- splitting to size
- stacking off ground
- providing airflow
- covering top after it dries sufficiently

Poorly handled firewood should:
- smoke more
- heat less
- consume faster
- worsen indoor air burden
- waste labor

## 13.3 Fuel calendar pattern

### Spring
- carryover fuel use still matters
- poor stocks are felt hard
- some cutting can begin

### Summer
- ideal time to create next cold-season fuel supply
- drying opportunity strongest

### Autumn
- last big chance to cut/split/stack/move fuel
- major priority shift before cold season

### Winter
- mostly consume, protect, and replenish emergency shortfall
- green wood use should feel like failure management, not normal practice

---

# 14. Seasonal preservation and spoilage windows

## 14.1 Preservation is weather-coupled

Drying, smoking, cool storage, and cleanliness should not perform identically year-round.

### Drying tends to be easier when:
- ambient moisture is lower
- temperatures are warm enough
- airflow is good
- insects can be managed

### Drying tends to be harder when:
- air is humid
- weather is rainy
- nights are damp
- protected drying space is weak

## 14.2 Post-harvest urgency

Harvest and post-harvest literature consistently treats timing and handling delays as loss drivers. [R18]

Game implication:
- not all successful gathering/harvest becomes reserve
- insufficient labor during a short window should cause believable losses

## 14.3 Pottery and clay rhythm

Clay processing should have seasonal preferences:
- digging may vary with ground condition
- shaping can occur broadly
- drying before firing is easier in drier periods
- wet/cold weather should raise crack and failure risk unless protected drying space exists

---

# 15. Hamlet labor calendar

## 15.1 Why roles need a calendar

Once the hamlet forms, the player should not manage "all workers do the same thing."
Seasonal role shift matters.

## 15.2 Example seasonal role emphasis

### Gatherer / forager
- high relevance in spring and summer
- still relevant in autumn
- narrower but still possible in winter depending landscape

### Water hauler / camp maintainer
- year-round
- spikes in distance, freezing, or illness events
- more critical when source quality drops or population rises

### Preserver / cook
- peaks during abundance and slaughter/harvest windows
- winter shifts toward rationing, safe preparation, and reserve control

### Builder / repairer
- big outdoors peak in drier, brighter seasons
- winter emphasis shifts toward maintenance and sheltered repair

### Seed keeper / gardener
- strongest spring and autumn responsibilities
- winter includes inspection and reserve protection

### Hide / fiber / handcraft worker
- can absorb more winter indoor labor
- becomes useful when outdoor conditions limit expansion

## 15.3 Labor-sharing rule

The hamlet should gain realism when surplus labor is not idle but redirected:
- from gathering to drying when food glut appears
- from building to harvest when the crop window opens
- from expansion to fuel when autumn warning thresholds hit
- from ordinary work to care during illness clusters

---

# 16. Calendar warnings and player-facing signals

## 16.1 The player must see future pressure

The calendar is only useful if it creates decision-making.

The UI should expose warnings such as:
- cold season approaching
- safe fuel reserve below target
- sowing window open / closing
- harvest window open / threatened by rain
- seed reserve at risk
- late-winter food risk
- short daylight period active
- heat-heavy workday conditions
- extended wet spell reducing drying success

## 16.2 Forecast horizon

Recommended player-facing horizons:
- **today**: tactical
- **next 3 days**: prep
- **this season**: planning
- **days until next threshold**: urgency

## 16.3 Calendar goals by stage

### Lone survivor
- survive night
- build routine

### Primitive camp
- stabilize daily flow
- begin preservation and reserve thinking

### Permanent camp
- survive across seasons
- store fuel, food, and seed
- align work with weather windows

### Tiny hamlet
- coordinate people across seasonal peaks
- create enough reserve and timing discipline to support specialization

---

# 17. Failure states caused by calendar mismanagement

The calendar layer should produce believable failure chains.

## 17.1 Common early failures

- too much expansion before fuel stockpile
- planting too late
- harvest delayed into bad weather
- insufficient labor allocated to drying/preservation
- eating seed reserve
- relying on green/wet fuel in cold season
- repeated night work causing fatigue cascade
- no rest during heat-intensive labor
- poor winter water access planning
- no repair window reserved before bad weather
- no buffer for illness during peak labor windows

## 17.2 What failure should feel like

Failure should feel like:
- "we missed the window"
- "we did not prepare enough"
- "we could not move/process it in time"
- "we ran too hard in the wrong season"
- "we survived summer but lost the winter"

That is much more realistic than arbitrary penalties.

---

# 18. Calendar-driven growth gates

## 18.1 Primitive Camp gate

The site should count as a stable Primitive Camp only when it can:
- sustain daily routines repeatedly
- survive several day/night cycles without crisis every night
- maintain a small buffer of water, food, and fuel
- allocate labor to non-immediate work

## 18.2 Permanent Camp gate

The site should count as a Permanent Camp only when it can:
- survive a seasonal transition
- hold food/fuel/seed reserves across time
- maintain sanitation in repeated use
- use seasonal windows intentionally rather than accidentally
- preserve at least some materials successfully

## 18.3 Tiny Hamlet gate

The site should count as a Tiny Hamlet only when it can:
- coordinate multiple workers across seasonal peaks
- absorb at least some labor specialization
- protect core reserves through one difficult season
- survive both abundance management and scarcity management

---

# 19. Data model recommendations

## 19.1 Calendar state

Recommended data fields:

- absolute_day_index
- year_index
- season
- season_phase
- day_of_season
- daylight_hours
- sunrise_time
- sunset_time
- average_temperature_band
- wetness_index
- storm_risk
- frost_risk
- heat_risk
- preservation_modifier
- hauling_modifier
- water_access_modifier
- fuel_consumption_modifier
- outdoor_work_modifier
- sickness_pressure_modifier

## 19.2 Seasonal task window definition

For each season-sensitive task/process:

- preferred_seasons
- workable_seasons
- blocked_conditions
- weather_sensitivity
- daylight_sensitivity
- urgency_curve
- reserve_dependency
- consequence_if_missed

## 19.3 Reserve calendar object

For each reserve:

- quantity
- edible_or_usable_fraction
- spoilage_risk
- season_consumption_rate
- safe_days_remaining
- next_replenishment_window
- protected_status
- reserve_class
- emergency_threshold
- warning_threshold

## 19.4 NPC labor day object

Per NPC, per day:

- expected_sleep_need
- actual_sleep
- wake_quality
- daylight_work_capacity
- sheltered_work_capacity
- emergency_capacity
- fatigue_carryover
- heat_or_cold_drag
- hydration_drag
- illness_drag
- injury_drag
- morale_drag_or_bonus
- care_burden
- travel_burden

---

# 20. First-playable minimum

## 20.1 Minimum calendar features worth implementing first

For the first robust version of the simulation, the calendar should at minimum include:

- day/night cycle
- daylight-limited work efficiency
- four seasons
- basic weather state
- temperature burden by season
- water need increase in hot conditions
- fuel need increase in cold conditions
- preservation bonus/penalty by season/wetness
- sowing window
- harvest window
- firewood drying delay
- seed reserve protection
- late-winter scarcity pressure
- seasonal warnings

## 20.2 What can wait

These can come later:
- highly detailed astronomical daylight calculations
- many crop-specific calendars
- religious/festival time
- advanced schooling/work rosters
- industrial shift calendars
- nuanced phenology by dozens of species

---

# 21. Recommended design stance

The calendar should become one of the main reasons the game feels alive.

A good early-game colony should not feel like:
- "do the same tasks every day with different numbers"

It should feel like:
- "summer work must pay for winter"
- "daylight is short, choose carefully"
- "the harvest is here and we cannot process all of it"
- "we need dry wood now, not logs later"
- "the spring window is opening and we are not ready"
- "our routines kept us alive through the hard season"

That is the right realism fantasy for this project.

---

# References

[R1] FAO, *Module 3: Field research tool box*  
https://www.fao.org/climatechange/31738-02d44a0b59ada9cd543e22bda87ce9465.pdf

[R2] FAO, *Field Level Handbook*  
https://www.fao.org/4/ak214e/ak214e00.pdf

[R3] CDC/NIOSH, *Here Comes the Sun! Tips to Adapt to Daylight Saving Time*  
https://www.cdc.gov/niosh/bulletin/2022/time-change.html

[R4] CDC/NIOSH, *Shift work: health, performance and safety problems, traditional countermeasures, and innovative management strategies*  
https://stacks.cdc.gov/view/cdc/223710/cdc_223710_DS1.pdf

[R5] CDC/NIOSH, *Center for Work and Fatigue Research*  
https://www.cdc.gov/niosh/docket/archive/pdfs/niosh-278/bsc_may2021_wong_cwfr-508.pdf

[R6] FAO, *Saving Time and Labour*  
https://www.fao.org/4/y5572e/y5572e02.pdf

[R7] CDC/NIOSH, *Reducing Fatigue and Stress in the Retail Industry*  
https://www.cdc.gov/niosh/bulletin/2019/reducing-fatigue.html

[R8] CDC/NIOSH, *Workplace Recommendations | Heat*  
https://www.cdc.gov/niosh/heat-stress/recommendations/index.html

[R9] WHO, *How much water is needed in emergencies*  
https://cdn.who.int/media/docs/default-source/wash-documents/who-tn-09-how-much-water-is-needed.pdf

[R10] WHO, *Water sanitation and health in humanitarian emergencies*  
https://www.who.int/teams/environment-climate-change-and-health/water-sanitation-and-health/environmental-health-in-emergencies/humanitarian-emergencies

[R11] University of Maryland Extension, *Measuring Wood Moisture & Drying Time for Hardwood Firewood*  
https://extension.umd.edu/sites/extension.umd.edu/files/publications/MeasuringWoodMoisture_FS-1074.pdf

[R12] UNH Extension, *How can I tell if my firewood is seasoned and okay to burn?*  
https://extension.unh.edu/blog/2017/12/how-can-i-tell-if-my-firewood-seasoned-okay-burn

[R13] UNH Extension, *Drying Firewood*  
https://extension.unh.edu/blog/2018/02/drying-firewood

[R14] Illinois Extension, *Seasonal tips and reminders for firewood*  
https://extension.illinois.edu/blogs/over-garden-fence/2020-10-19-seasonal-tips-and-reminders-firewood

[R15] USDA Forest Service, *Storage of Seeds*  
https://www.fs.usda.gov/nsl/Wpsm%202008/Chapter%204.pdf

[R16] USDA Forest Service, *Collecting, Processing, and Storing Seeds*  
https://www.fs.usda.gov/rm/pubs_series/wo/wo_ah730/wo_ah730_113_131.pdf

[R17] South Dakota State University Extension, *How to Store Leftover Garden Seeds*  
https://extension.sdstate.edu/how-store-leftover-garden-seeds

[R18] FAO, *Post-harvest food losses estimation - development of methodology*  
https://www.fao.org/fileadmin/templates/ess/documents/meetings_and_workshops/GS_SAC_2013/Improving_methods_for_estimating_post_harvest_losses/Final_PHLs_Estimation_6-13-13.pdf
