---
title: "Realistic Idle City — Steam Power / Boilers / Line-Shaft Factories Spec"
version: "v0.1"
date: "2026-04-09"
status: "Draft"
depends_on:
  - "realistic_idle_city_design_v1.md"
  - "realistic_idle_city_water_sanitation_utilities_spec_v0_1.md"
  - "realistic_idle_city_metallurgy_mining_fuel_chain_spec_v0_1.md"
  - "realistic_idle_city_mills_water_power_mechanized_workshops_spec_v0_1.md"
  - "realistic_idle_city_machine_tools_standardization_interchangeable_parts_spec_v0_1.md"
scope:
  - "Early Industrial City bridge"
  - "Coal / steam / boilers / stationary power"
  - "Line-shaft and belt-driven factories"
  - "Pre-electrification industrial utilities"
assumptions:
  - "Realism-first dependency model"
  - "Top-down minimal visuals"
  - "Player leads through policies, priorities, reserves, and bounded direct orders"
  - "This document focuses on stationary steam power and factory power distribution, not full electrification"
---

# 1. Purpose

This document defines how **steam power, boilers, and line-shaft factories** should work in the project.

It sits at the transition between:
- **Pre-Industrial Town** systems such as water power, larger foundries, standardized stock, and mechanized workshops
- **Early Industrial City** systems such as coal, steam, factories, rail, machine tools, and urban utility pumping
- the later shift toward **Electrified Industrial City** systems, where distributed electric power gradually replaces shared mechanical shafting

This document is not a generic “factory bonus” spec.
It treats steam power as a **civilizational operating system** with:
- fuel demand
- water demand
- boilers and pressure vessels
- engine houses
- transmission losses
- belts, pulleys, shafts, and bearings
- maintenance crews
- fire, explosion, and entanglement hazards
- smoke, soot, ash, and noise
- planning effects on buildings, roads, rail, mining, water supply, and public health

---

# 2. Placement in progression

## 2.1 Progression position

This spec belongs after the settlement can already support:
- large fuel supply chains
- foundry and forge capability
- improved machining and measurement
- millwright-level mechanical knowledge
- brick and masonry capacity
- roads and freight systems capable of moving heavy machinery and fuel
- more formal administration and safety control

It comes **before** fully electrified industry.

## 2.2 Why steam matters

Steam power changes the game because it is the first broadly practical power system that is:
- **not fixed to a river reach or a wind regime**
- scalable to large stationary industrial loads
- suitable for pumping, hoisting, milling, hammering, textile drive, machine-shop drive, and municipal pumping
- centralizable in one engine house, then redistributed mechanically through shafts and belts

Steam lets industry move away from the geography of waterpower alone.
That is the strategic leap.

## 2.3 Main gameplay identity

The player should experience steam power as:
- a major production multiplier
- a major logistics burden
- a major safety burden
- a major maintenance burden
- a major urban pollution burden
- a major institutional upgrade

Steam is not “free speed.”
It is the beginning of **high-throughput dependency**.

---

# 3. Real-world grounding used in this spec

This spec is grounded in a few central historical/technical truths:

1. A steam engine converts heat into mechanical work by expanding steam supplied by a boiler.
2. Steam power became crucial because it provided motive power independent of river flow and weather.
3. Conventional boilers fall broadly into **fire-tube** and **water-tube** families, with fire-tube widely used in smaller and moderate factory settings and water-tube becoming more important as pressure/output demands rose.
4. Line shafts distributed power from one prime mover to many machines through shafts, belts, pulleys, gears, and countershafts before widespread small electric motors.
5. Boiler explosions were historically frequent enough to drive the creation of formal codes and pressure-vessel safety rules.
6. Belts and line shafts create real operational issues: slip, alignment, bearing wear, lubrication burden, entanglement hazard, layout rigidity, and transmission loss.
7. Steam factories depend on much more than the engine: coal/fuel handling, feedwater handling, ash removal, brick settings, drainage, shops, inspection, and trained operators.

Those truths shape the entire design.

---

# 4. Core design stance

## 4.1 Steam is a system, not a building

A “Steam Factory” should never be one object that grants throughput.

A real steam-driven factory requires:
- fuel supply
- boiler system
- boiler house / furnace setting
- chimney / stack
- feedwater supply and treatment at least in basic form
- prime mover (beam engine, horizontal engine, Corliss-type engine, traction/portable engine in some cases, later turbine in other eras)
- flywheel / governor / controls
- main shafting
- countershafts
- belts and pulleys
- guards / safe zones where applicable
- foundations
- maintenance space
- oil and grease
- repair crews
- schedule discipline
- heat management
- noise and smoke tolerance
- waste handling

## 4.2 Shared-power logic

Unlike later electrified workshops where each machine can have its own motor, the steam factory is organized around **shared motion**.

That means:
- one engine can power many machines
- but machine placement becomes constrained by shaft routes
- machine uptime becomes linked to engine uptime
- a failed belt or seized bearing can disable part of a building
- adding machines is not just buying more machines; it may require new shaft capacity or a new engine set

## 4.3 Industrial power is spatial

Steam power should strongly affect building layout.

The engine house, boiler house, chimney, coal yard, ash pit, shaft corridors, and heavily driven workshops should not be treated as arbitrary decorations.
They determine:
- where machines can be placed
- how efficiently power can be delivered
- how much noise/heat/smoke affects nearby functions
- how accessible the system is for maintenance
- how severe a local incident becomes when something fails

---

# 5. Steam power ladder

This document recommends a staged ladder rather than one instant “unlock.”

## 5.1 Stage A — Boiler craft and low-pressure stationary steam

Earliest practical steam adoption in the settlement/city should focus on:
- small stationary engines
- mine drainage
- simple pumping
- workshop auxiliaries
- intermittent heavy work
- proving the city can sustain pressure systems safely

Characteristics:
- low pressure compared with later systems
- heavy dependence on skilled operators
- high fuel use relative to output
- frequent breakdowns if water/fuel/maintenance are poor
- major value in pumping and centralized repetitive work

## 5.2 Stage B — Mature stationary steam plant

Once metallurgy, machining, and administration improve, the city can support:
- larger fire-tube boilers
- more dependable stationary engines
- broader line-shaft power distribution
- powered machine shops
- textile or wood-working lines
- municipal pumping stations
- larger drainage works
- more regular shift work

Characteristics:
- stronger foundations and better alignment
- larger flywheels and smoother operation
- better governors and speed control
- more formal inspection routines
- larger coal and water budgets
- more rigid building/floor layout

## 5.3 Stage C — Multi-building steam industrial block

At this stage steam becomes a district-scale organizing force:
- central engine/boiler houses
- factory blocks with multiple floors or halls
- machine-room and transmission-room separation
- yard rail spurs or heavy wagon delivery
- integrated foundry + machine shop + assembly hall complexes
- utility pumping integrated into city services

Characteristics:
- administrative scheduling matters
- breakdowns have city-scale ripple effects
- smoke burden becomes a civic issue
- labor specialization deepens
- electrification pressure starts to appear as an answer to shafting rigidity

## 5.4 Stage D — Transitional steam-to-electric hybrid

Still part of this document’s edge, but not its main endpoint:
- steam engines or steam turbines drive dynamos/generators
- some line-shaft sections remain
- some equipment shifts to electric motor drive
- lighting and pumping improve first
- power becomes easier to distribute over space

This stage belongs mostly to the next electrification document, but should be foreshadowed here.

---

# 6. Prime movers covered by this spec

## 6.1 Steam engine families to model

For gameplay, it is enough to distinguish a few broad classes:

### A. Pumping engine
Used for:
- mine drainage
- waterworks lifting
- dewatering low areas
- boiler feed support in some systems
- large repetitive pumping duty

Traits:
- high strategic value
- often site-tied
- fewer distributed mechanical outputs
- directly linked to mine/water system uptime

### B. Stationary workshop/factory engine
Used for:
- line shafts
- machine shops
- textile halls
- woodworking halls
- hammer shops / bellows / presses in some cases

Traits:
- central industrial power source
- needs transmission network
- vulnerable to alignment and bearing problems
- creates shared-failure risk

### C. Portable / semi-portable steam engine
Used for:
- field threshing
- temporary drives
- mobile work support
- remote pumping
- construction or saw operations

Traits:
- lower integration than permanent factory engines
- transport and setup burden
- maintenance heavy
- important transition technology

### D. Locomotive / traction-specific systems
Mostly out of scope here except where stationary industry depends on rail freight.
Locomotive power belongs more fully in a dedicated rail/freight spec.

---

# 7. Boiler systems

## 7.1 Boiler identity

A boiler is not a magical input box.
In simulation terms it is:
- a pressure vessel or system
- heated by a furnace
- filled with water
- producing steam under managed pressure
- dependent on safe feedwater levels and pressure control

## 7.2 Broad boiler classes for the game

### A. Fire-tube boiler
Game identity:
- common and practical in many small to moderate industrial settings
- easier conceptual entry for early industrial adoption
- lower complexity than later high-output utility boilers
- suitable for many factory and workshop roles

Gameplay traits:
- simpler early industrial option
- slower to raise steam than very small improvised systems but manageable
- major shell integrity and water-level safety dependence
- still dangerous if neglected

### B. Water-tube boiler
Game identity:
- higher-capacity / higher-pressure / later-more-demanding systems
- more suitable as industrial output grows
- better fits larger steam demand and later electrical generation support

Gameplay traits:
- higher capital requirement
- higher knowledge requirement
- stronger inspection/maintenance requirement
- unlocks larger industrial blocks and later steam-electric bridges

## 7.3 Boiler subsystems that matter

Every boiler installation should track:
- furnace / firebox
- grate / firing regime
- shell or tube bank
- steam space / drum logic
- feedwater input
- blowdown or dirty-water management abstraction
- pressure relief / safety valve
- gauge glass / water level indication abstraction
- pressure gauge abstraction
- chimney / draft system
- insulation / lagging abstraction
- ash collection
- access for cleaning and inspection

## 7.4 Fuel side

Boilers should accept a defined fuel class:
- wood or slabwood in some early or small settings
- charcoal in limited or earlier specialist contexts
- coal as the defining industrial fuel
- coke only where the system specifically justifies it
- oil/gas are later and outside primary scope here

Coal should generally dominate once the city truly industrializes because:
- energy density improves logistics compared with raw wood
- continuous steam demand overwhelms many wood-only supply systems
- high-throughput urban industry needs denser fuel chains

## 7.5 Water side

Boiler water matters.
This spec recommends tracking:
- water availability
- water cleanliness class
- sediment/scaling tendency abstraction
- feedwater temperature class abstraction if later desired
- contamination risk from poor intake or dirty storage
- priming / carryover / fouling risk as an advanced abstraction

Poor boiler-water management should cause:
- lower efficiency
- more cleaning downtime
- scaling
- tube/shell stress
- more failure risk
- higher fuel consumption

---

# 8. Steam plant support systems

## 8.1 Coal yard and fuel handling

A steam plant requires:
- coal delivery access
- storage protected from drainage failure and total saturation
- shoveling/feeding labor or later mechanical feed systems
- internal routes to boilers
- dust, dirt, and spillage cleanup

Gameplay effects:
- fuel placement changes hauling time
- bad yard siting creates mud, runoff, waste, and fire risk
- fuel interruption can idle entire factory blocks

## 8.2 Ash and clinker handling

Coal and boiler firing create ash and clinker.
These require:
- removal labor
- hot waste handling rules
- ash pits or designated dump spaces
- possible reuse pathways where appropriate
- routing away from clean work zones and water-sensitive areas

## 8.3 Feedwater supply

A working plant needs:
- dependable intake or storage
- pumping or lifting if the source is not gravity-fed
- covered or at least managed storage
- route to boiler house
- contingency during drought, freeze, or pump failure

## 8.4 Chimney and draft

Steam plants need stack/draft management.
Gameplay purposes:
- enable combustion efficiency
- affect smoke distribution
- impose structural requirements
- create maintenance and collapse risk if neglected
- influence siting due to soot/smoke burden

## 8.5 Foundations and engine beds

Heavy engines and shafting require:
- rigid foundations
- alignment
- vibration control
- stable floors and bearings
- maintenance access

Poor foundations should cause:
- power loss
- belt misbehavior
- wear
- noise
- breakdowns
- catastrophic failure risk in severe cases

---

# 9. Line-shaft power distribution

## 9.1 What a line shaft is in game terms

A line shaft is a rotating power-distribution trunk that takes mechanical power from one prime mover and distributes it across rooms/floors/work zones through:
- main shafts
- secondary shafts / countershafts
- pulleys
- belts
- clutching or belt-shifting arrangements
- sometimes gears

## 9.2 Why it matters

Line shafting is the defining pre-electrification factory power logic.

Its advantages:
- one engine can drive many machines
- strong central maintenance and supervision
- easier to concentrate heavy power production
- suitable for clustered machine halls

Its disadvantages:
- factory layout becomes rigid
- all machines in a section depend on shared shaft health
- belts and bearings create constant maintenance burden
- distributed power is noisy and dangerous
- idle running wastes energy
- expansion often means rebuilding shaft networks

## 9.3 Game-facing line-shaft metrics

Track at least:
- shaft length / network complexity
- number of driven machines
- alignment quality
- belt condition
- bearing lubrication condition
- slip/load factor
- power transmission losses
- sectional redundancy or lack thereof
- guarding/safety quality
- clutter clearance around moving drives

## 9.4 Belts

Belts should have properties such as:
- material class
- width/capacity
- tension quality
- alignment quality
- wear state
- moisture/oil contamination sensitivity
- slip tendency

Belts are not permanent.
They stretch, crack, glaze, slip, throw, or break.

## 9.5 Countershafts and floor layout

Countershafts matter because they:
- branch power to more machines
- reduce awkward machine placement
- allow floor-by-floor or row-by-row distribution
- create more bearings, more maintenance points, and more hazard zones

## 9.6 Idle loss and partial operation

A key realism point:
a line-shaft factory often cannot power one machine with the neat precision of later individual motors.

This suggests several useful gameplay concepts:
- section startup cost
- whole-room power-on state
- idle belt/shaft losses
- partial disengagement possible but not perfect
- machines closer to ideal shaft geometry perform better

---

# 10. Factory building logic

## 10.1 Factory as an industrial organism

A steam-driven factory should be represented as an interconnected building complex, not a single craft bench.

Core spaces may include:
- boiler house
- engine house
- flywheel/drive room
- main machine hall
- shaft corridor or vertical shaft connections
- belt-safe clearance zones
- oil/grease/tool room
- repair bay
- coal yard
- ash/clinker zone
- water intake or storage zone
- clerk/scheduler/inspection office
- yard loading area
- sometimes pattern shop or fitting room

## 10.2 Building layout pressure

Steam factories should reward layouts that:
- minimize excessive shaft length
- separate fire/boiler risk from sensitive stock where possible
- keep coal and ash routes out of delicate work areas
- maintain access for repairs
- separate clean fitting/inspection from soot-heavy spaces
- use robust floors where shaft loads and machine loads are high
- keep wet/muddy traffic away from precision work

## 10.3 Multi-story implications

Multi-story factories may be powerful but come with:
- vertical shaft distribution requirements
- stronger structural demands
- vibration concerns
- more complex evacuation/safety issues
- more complex material movement between floors

## 10.4 Environmental burden

A steam factory changes nearby districts through:
- smoke and soot
- noise
- vibration
- heat
- traffic
- coal dust
- ash
- wastewater / dirty runoff
- crowding and accident exposure

This should push the player toward proto-zoning, street planning, and utility planning.

---

# 11. Steam-era industrial roles

## 11.1 Core steam plant roles

At minimum, a working steam industrial district may require:
- fireman/stoker
- boiler operator
- engine operator
- mechanic / engine tender
- oiler / lubrication runner
- millwright / shafting mechanic
- belt repair worker
- coal hauler / fuel yard laborer
- ash/clinker laborer
- machinist
- fitter / assembler
- foundry worker
- pattern maker
- inspector / foreman
- clerk / scheduler
- waterworks or pump operator where relevant
- safety steward / watch lead in more advanced governance setups

## 11.2 Skill families relevant here

Useful skills include:
- boiler firing
- furnace management
- steam plant operation
- mechanical alignment
- shafting maintenance
- lubrication discipline
- bearing fitting
- belt maintenance
- brick setting / refractory repair
- pipe fitting
- pump maintenance
- machine operation
- industrial safety discipline
- inspection / recordkeeping

## 11.3 Interest and aptitude effects

NPC differences should matter here strongly.

Examples:
- high discipline + mechanical interest + caution = strong boiler operator
- high spatial reasoning + mechanical aptitude = strong millwright
- high endurance + lower precision = viable stoker/fuel labor
- high conscientiousness + record orientation = good inspector/clerk

Steam power should amplify the consequences of poor role fit.

---

# 12. Inputs, outputs, and dependencies

## 12.1 Main inputs

A steam plant depends on:
- fuel
- water
- maintenance supplies
- lubrication
- replacement belts
- replacement bearings or bearing materials
- spare fittings / valves / gauges abstraction
- boiler cleaning downtime
- skilled labor
- administrative scheduling
- masonry / structural upkeep
- freight access

## 12.2 Main outputs

A steam plant outputs:
- shaft power
- pumping capacity
- workshop throughput
- continuous operation potential
- municipal service support in some cases
- production-scale increase for machine shops and larger factories

## 12.3 Byproducts and externalities

A steam plant also outputs:
- smoke
- soot
- ash
- heat
- noise
- accident risk
- contaminated runoff from dirty yards
- strained water systems
- urban crowding pressure
- maintenance burden

---

# 13. Maintenance doctrine

## 13.1 Central maintenance truth

Steam and shafting only feel realistic if upkeep is constant.

This era should introduce a strong rule:
> industrial power survives through routine attention, not just construction.

## 13.2 Boiler maintenance burden

Track:
- tube/shell cleaning abstraction
- scale/fouling level
- refractory and brick setting condition
- fittings and valve condition
- gauge/indicator reliability
- relief-device inspection state
- leak state
- downtime windows

## 13.3 Engine maintenance burden

Track:
- lubrication state
- governor reliability
- valve gear condition
- piston/rod/seal packing abstraction
- alignment
- bearing wear
- flywheel condition
- startup/shutdown care

## 13.4 Shafting maintenance burden

Track:
- hanger/bearing condition
- lubrication
- belt tension/alignment
- pulley condition
- shaft straightness / balance abstraction
- guarding state
- cleanliness/clutter near moving parts

## 13.5 Maintenance philosophy in gameplay

There should be two kinds of maintenance:
- **routine preventive** maintenance
- **reactive repair** after symptoms/failure

Neglect should be allowed, but it should create:
- efficiency loss
- rising failure odds
- safety events
- output inconsistency
- major shutdown risk

---

# 14. Safety doctrine

## 14.1 Why safety matters here

Steam is the first era in your design where:
- one incident can kill many people
- one machine failure can disable a whole production section
- one pressure failure can wreck a building
- one fire can shut down an industrial block
- one governance failure in inspection can become a city-scale scandal

## 14.2 Main hazard classes

### A. Boiler explosion / rupture
Causes may include:
- overpressure
- low water / overheating abstraction
- severe material degradation
- failed safety devices
- poor maintenance
- operator error
- bad construction / bad repairs

### B. Steam release / scalding
Danger from:
- leaks
- valve/fitting failures
- line rupture
- poor isolation practices

### C. Fire
Sources:
- furnace/boiler room
- coal dust and embers
- oily waste
- hot ash disposal
- timber-heavy factory structures
- belt friction/overheating in neglected systems

### D. Line-shaft entanglement / strike hazards
Sources:
- exposed belts
- loose clothing
- hair/limb catch
- thrown belts
- rotating shafts at worker height
- cramped layout near moving drive elements

### E. Mechanical crush / pinch
Sources:
- gears
- flywheels
- belts and pulleys
- shifting machinery
- lifting and rigging during repair

### F. Air-quality burden
Sources:
- boiler smoke
- soot
- poorly vented engine/boiler spaces
- hot dusty coal rooms

## 14.3 Safety controls to model

Safety should improve through:
- better inspection policy
- trained boiler operators
- maintenance routines
- guarded shaft sections
- clear work zones
- hot-work and ash rules
- water-level/pressure monitoring abstraction
- better building separation
- emergency drills / emergency command quality
- recordkeeping and incident follow-up

## 14.4 Safety and governance

Steam should be one of the strongest places where governance becomes meaningful.
The player should feel pressure to create:
- formal operating rules
- shift logs
- inspection logs
- accountability roles
- shutdown authority
- repair authority
- emergency response plans

---

# 15. Steam, water, and municipal utilities

## 15.1 Steam before electrification in utilities

Steam should be able to support pre-electrical municipal systems such as:
- pumping raw water
- pumping treated or settled water
- drainage pumping
- sewer lift support in some cases
- mine drainage
- flood control or dewatering in limited contexts

## 15.2 Why this matters

This connects industrial power to city survival.
Steam is not only for factories.
It is the first general-purpose urban power backbone.

## 15.3 Utility dependency logic

If a settlement uses steam-powered pumping for water supply, then:
- fuel shortage can become a water crisis
- boiler outage can become a water crisis
- maintenance backlog can become a water crisis
- staffing shortage can become a water crisis

This is exactly the kind of realism dependency the game should celebrate.

---

# 16. Steam, rail, and industrial freight

## 16.1 Rail relationship

A full rail spec is separate, but this document should integrate with it:
- steam industry creates demand for coal freight
- coal freight makes larger steam plants viable
- rail workshops are ideal steam-driven industrial users
- locomotives create new repair and boiler skill clusters
- freight yards reshape siting of factories and coal depots

## 16.2 Pre-rail freight reality

Before rail fully matures, heavy steam industry still needs:
- roads
- wagons
- pack and animal systems where terrain demands
- canal/river support if available
- local yard track or industrial tram systems later

Steam should sharply pressure the freight system.

---

# 17. Transition pressure toward electrification

## 17.1 Why steam-line-shaft factories do not remain ideal forever

This document should actively create reasons for electrification later:
- line shafts waste power
- layouts stay rigid
- machine-level control is poor
- belts are dangerous and maintenance-heavy
- long shaft runs lose efficiency
- upper-floor distribution is awkward
- light-duty scattered workshops are poorly served by central shafts
- city lighting and communications need different infrastructure

## 17.2 Steam does not disappear immediately

Even after electrification begins:
- steam may still drive dynamos/generators
- older shafts may remain in service
- hybrid buildings may exist
- some heavy steam plants may remain cheaper than full motor replacement for a while

This should allow long transition periods rather than a magical tech swap.

---

# 18. Suggested simulation model

## 18.1 Key simulation objects

Suggested major records:
- SteamPlant
- BoilerUnit
- EngineUnit
- ShaftNetwork
- BeltSection
- MachineDriveNode
- FuelYard
- AshHandlingNode
- FeedwaterNode
- MaintenanceSchedule
- SafetyInspectionRecord
- SteamIncidentRecord

## 18.2 Core steam plant metrics

Recommended metrics:
- max steam output
- current steam output
- fuel burn rate
- water draw rate
- startup time
- warm state / cold state
- pressure safety margin abstraction
- maintenance state
- fouling/scaling abstraction
- staffing sufficiency
- shaft load factor
- belt failure risk
- smoke burden
- noise burden
- accident risk
- output stability

## 18.3 Core shaft metrics

Recommended metrics:
- network length
- branches count
- machine count
- current load
- alignment quality
- lubrication quality
- guarding quality
- loss factor
- sectional redundancy
- accessibility for maintenance

## 18.4 Failure and degradation

Degradation should come from:
- continuous operation hours
- poor lubrication
- dirty water / scaling
- overload
- rushed maintenance
- misalignment
- poor foundations
- poor operators
- fuel interruptions causing bad firing behavior
- unsafe startup/shutdown
- deferred inspection

---

# 19. Stage gates and unlock logic

## 19.1 Reasonable prerequisites

The city should not unlock true steam industry until it can sustain:
- regular coal or equivalent dense fuel supply
- reliable water access
- larger foundry/forge capacity
- cylinder/shaft/bearing-level machining
- pressure-vessel craft at least in early form
- brick/refractory construction
- maintenance administration
- enough food and housing surplus to support specialist operators
- freight routes suitable for fuel and machinery

## 19.2 Steam adoption gates

### Initial stationary steam
Requires:
- proven boiler craft
- adequate mine/water/drainage demand or industrial demand
- one safe engine house and boiler house
- trained operators
- inspection routines

### Steam factory block
Requires:
- stronger metallurgy
- machine shop support
- shafting manufacture and repair
- coal yard logistics
- stable municipal order and safety rules
- regular labor scheduling

### City-scale steam utility support
Requires:
- governance and recordkeeping
- reserve fuel policy
- dedicated waterworks staff
- maintenance reserves
- emergency response capacity

## 19.3 Transition gate to electrification
Suggested criteria:
- high shafting complexity penalties
- demand for night lighting and distributed machines
- copper/wire readiness
- generator/dynamo capability
- larger urban service demands
- maintenance pressure from older steam-drive layouts

---

# 20. Recommended player-facing presentation

## 20.1 What the player should see

At minimum:
- plant state: cold / warming / running / overloaded / unsafe / down
- fuel days remaining
- water sufficiency
- current power delivered vs capacity
- shaft load map
- belt/bearing trouble markers
- inspection due indicators
- smoke burden indicator
- active sections and idle-loss indicator
- operator staffing sufficiency
- recent incidents and near misses

## 20.2 Good player decisions to create

The player should have to decide:
- where to site boiler and engine houses
- whether to centralize or split power
- whether to overrun old shaft networks or build new ones
- whether to prioritize pumping, machine shop, textile hall, or sawmill duty
- whether to spend resources on preventive maintenance
- whether to increase inspection strictness
- when to retire shaft-heavy layouts in favor of electrification later

## 20.3 Bad but tempting choices

The game should allow:
- under-inspection
- overloading
- running dirty boilers
- storing too little reserve fuel
- packing too many machines onto one shaft line
- siting coal/ash badly
- skipping guards to save cost
- starving maintenance labor
- extending old systems beyond safe limits

These choices should sometimes work briefly, then punish the player.

---

# 21. Data schema suggestion

## 21.1 SteamPlant
- id
- district_id
- plant_name
- plant_type
- building_ids
- boiler_ids
- engine_ids
- shaft_network_ids
- fuel_node_ids
- water_node_ids
- ash_node_ids
- maintenance_policy_id
- inspection_policy_id
- staffing_profile
- current_operating_state
- rated_output
- current_output
- fuel_burn_rate
- water_draw_rate
- smoke_burden
- incident_risk
- notes

## 21.2 BoilerUnit
- id
- boiler_class
- pressure_class
- furnace_type
- fuel_types_allowed
- rated_steam_output
- water_volume_class
- current_condition
- fouling_level
- scale_level
- relief_device_state
- indicator_state
- leak_state
- brickwork_state
- inspection_due
- assigned_operator_ids

## 21.3 EngineUnit
- id
- engine_family
- rated_power
- governor_quality
- flywheel_mass_class
- lubrication_state
- bearing_state
- alignment_state
- current_load
- current_speed_stability
- assigned_operator_ids

## 21.4 ShaftNetwork
- id
- network_class
- length_total
- branch_count
- belt_count
- driven_machine_ids
- guarding_quality
- lubrication_quality
- alignment_quality
- current_loss_factor
- overload_state
- maintenance_due

## 21.5 SteamIncidentRecord
- id
- date_time
- plant_id
- incident_type
- severity
- root_cause_tags
- injuries
- downtime_estimate
- required_repairs
- governance_followup
- inspection_changes
- notes

---

# 22. Relationship to other specs

This document should integrate especially with:
- **Metallurgy / Mining / Fuel Chain** for coal, coke, metal stock, castings, pipe, valves, shafts, and bearings
- **Mills / Water Power / Mechanized Workshops** because steam first supplements and then partly escapes water-power geography
- **Machine Tools / Standardization / Interchangeable Parts** because sustainable steam industry depends on machined repeatable parts, gauges, inspection, and repair systems
- **Water / Sanitation / Utilities** because pumping and urban water services are major steam uses before electrification
- **Pollution / Waste / Byproduct** because smoke, soot, ash, and dirty runoff become civic burdens
- **Governance / Administration / Law** because inspection, logs, sanctions, and operating authority matter strongly in the steam era
- **Trade / Market / Exchange** and **Infrastructure / Roads / Paths** because coal and machinery movement reshape industrial geography
- the future **Electrification** spec because that is the direct successor to steam-shaft power

---

# 23. First implementation slice recommendation

Do **not** start by simulating every valve.

A good first design slice for this era would be:
1. one coal yard
2. one fire-tube boiler house
3. one stationary engine
4. one short line-shaft machine hall
5. three to six driven machine nodes
6. fuel, water, ash, lubrication, and staffing tracked explicitly
7. basic incident categories:
   - belt break
   - bearing overheating
   - low water / unsafe boiler state
   - steam leak
   - fire in boiler room
   - smoke burden complaints
8. one utility use case:
   - steam-driven municipal pump or mine pump
9. one management tension:
   - machine output vs inspection downtime

That is enough to prove the era.

---

# 24. Design summary

Steam power should feel like the beginning of **true industrial dependency**.

It should:
- break industry loose from river-only power
- concentrate work into large plants
- enable pumping, shops, factories, and urban services
- demand coal, water, metal, maintenance, and administration
- make safety, inspection, and governance newly important
- create visible pressure toward later electrification

If it is designed correctly, the player should look at a steam factory and feel both:
- “this changes everything”
- and
- “this is now a monster I must feed, maintain, inspect, and survive”

---

# References

These references were used to ground the technical and historical assumptions in this document.

1. Encyclopaedia Britannica, **Steam engine**  
   https://www.britannica.com/technology/steam-engine

2. Encyclopaedia Britannica, **Boiler**  
   https://www.britannica.com/technology/boiler

3. Encyclopaedia Britannica, **Fire-tube boiler**  
   https://www.britannica.com/technology/fire-tube-boiler

4. Encyclopaedia Britannica, **Watertube boiler**  
   https://www.britannica.com/technology/watertube-boiler

5. Encyclopaedia Britannica, **The Industrial Revolution, 1750–1900**  
   https://www.britannica.com/technology/history-of-technology/The-Industrial-Revolution-1750-1900

6. National Park Service, **Weave Room Frequently Asked Questions**  
   https://www.nps.gov/articles/000/weave-room-frequently-asked-questions.htm

7. National Park Service, **Suffolk Mills Turbine Exhibit**  
   https://www.nps.gov/lowe/learn/historyculture/suffolk-mills-turbine-exhibit.htm

8. ASME, **The True Harnessing of Steam**  
   https://www.asme.org/topics-resources/content/the-true-harnessing-of-steam

9. ASME, **The History of ASME’s Boiler and Pressure Vessel Code**  
   https://www.asme.org/topics-resources/content/the-history-of-asmes-boiler-and-pressure

10. ASME, **History of ASME Standards**  
    https://www.asme.org/codes-standards/about-standards/history-of-asme-standards

11. NIST, **The Gauge Block Handbook**  
    https://nvlpubs.nist.gov/nistpubs/Legacy/MONO/nistmonograph180.pdf