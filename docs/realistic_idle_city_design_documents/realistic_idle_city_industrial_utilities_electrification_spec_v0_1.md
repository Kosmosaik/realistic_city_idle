---
title: "Realistic Idle City — Industrial Utilities / Electrification Spec"
version: "v0.1"
date: "2026-04-09"
author: "OpenAI / ChatGPT"
status: "Design spec"
scope:
  - "Late Early-Industrial City -> Electrified Industrial City"
  - "Bridges steam-and-line-shaft industry into electric utility society"
  - "Research-backed realism-first design layer"
depends_on:
  - "realistic_idle_city_design_v1.md"
  - "realistic_idle_city_water_sanitation_utilities_spec_v0_1.md"
  - "realistic_idle_city_metallurgy_mining_fuel_chain_spec_v0_1.md"
  - "realistic_idle_city_mills_water_power_mechanized_workshops_spec_v0_1.md"
  - "realistic_idle_city_machine_tools_standardization_interchangeable_parts_spec_v0_1.md"
  - "realistic_idle_city_steam_power_boilers_line_shaft_factories_spec_v0_1.md"
---

# 1. Purpose

This document defines the **Industrial Utilities / Electrification** layer for the project.

It answers the question:

> What has to exist, institutionally and materially, for a settlement to move from steam-powered factories and line shafts to a genuinely electrified industrial city with deeper public utilities?

This is not a "research electricity" unlock.  
It is a **system transition**:

- from local mechanical power to distributed electrical power
- from isolated works to a coordinated grid
- from workshop-by-workshop power transmission to wires, substations, and motors
- from basic urban utilities to electrically intensive utility operations
- from intermittent/fragile service to continuous service expectations

---

# 2. Placement in the progression ladder

This spec sits after:

- coal / steam / boilers
- line-shaft factories
- machine tools and measurable parts
- expanded metallurgy
- urban water and sanitation pressure
- rail and bulk freight viability

And before or alongside:

- chemical / petroleum / fertilizer expansion
- refrigeration-dependent food chains
- telephony/communications expansion
- large vehicle and engine industries
- full modern utility bureaucracy
- later integrated city systems

In the design stack, this is the shift from **Era 7: Early Industrial City** into **Era 8: Electrified Industrial City**.

---

# 3. Core design stance

Electrification is not only "more power."

It changes five deep things:

## 3.1 Power becomes spatially flexible
Machines no longer need to sit on one line shaft or in a narrow belt-driven layout.  
Power can be moved over distance, then stepped down and used at many separate loads.

## 3.2 Utilities become deeper systems
Water, sewer, pumping, storage, and treatment become more scalable and more dependent on continuous service.

## 3.3 Industry becomes motorized
More of industrial work shifts from belts and shafts to electric motors, local drives, controls, and switchgear.

## 3.4 Time discipline changes
Lighting extends safe and useful work hours.  
Night operations, shift work, and municipal service reliability expectations increase.

## 3.5 Failure becomes systemic
A broken belt may stop one machine.  
A grid outage can stop pumps, lights, refrigeration, treatment, communications, and whole districts.

That is the key realism trade:
**electrification increases flexibility and productivity, but also increases dependence on grid integrity, maintenance, copper, insulation, and trained utility labor.**

---

# 4. What the game should simulate at this layer

The game does not need to simulate electromagnetic equations.

It does need to simulate:

- generation capacity
- load demand
- peak demand stress
- fuel/water dependence of generators where relevant
- voltage transformation stages as infrastructure requirements
- distribution reach and service coverage
- outages and maintenance windows
- critical loads vs noncritical loads
- motorized equipment dependence
- water/sewer service dependence on electricity
- wire/copper/insulator/transformer bottlenecks
- skilled operator and maintenance labor
- expansion costs and urban prioritization

---

# 5. The utility chain

A believable electrified city should understand electricity as a chain:

1. **Primary energy or motive source**
2. **Prime mover**
3. **Generator**
4. **Voltage transformation**
5. **Transmission / sub-transmission**
6. **Substation switching and stepping-down**
7. **Distribution feeders**
8. **Local transformation / service connection**
9. **End-use loads**
10. **Protection, maintenance, and restoration**

The same city should understand water and sewer as parallel chains:

### Water chain
source -> treatment -> storage -> pressure/distribution -> customer use -> fire reserve / emergency reserve

### Wastewater chain
collection -> conveyance -> lift/pumping if needed -> treatment -> discharge/reuse/sludge handling

Electrification strengthens those chains but also ties them more tightly together.

---

# 6. Generation families for this era

## 6.1 Steam-turbine and steam-engine generation
This is the default backbone for many early electrified industrial cities in this design.

Typical dependency chain:
- coal or other combustible fuel
- fuel delivery and ash handling
- boiler house
- feedwater treatment/management
- steam prime mover
- generator
- cooling water / condenser needs where relevant
- controls, switchgear, and operators

In some cities, older reciprocating steam engine plants may coexist with newer steam-turbine stations.

### Game meaning
Steam-electric generation should inherit many burdens from the steam-power era:
- boiler inspection
- fuel stock
- ash/clinker management
- water quality issues
- skilled operators
- shutdown and warm-up constraints
- explosion / fire / heat hazard

## 6.2 Hydroelectric generation
This should exist only where geography permits.

Realistic prerequisites:
- suitable head or flow
- civil works
- turbine house
- water control works
- long-term maintenance against debris, flooding, and seasonal variation
- transmission connection to loads

### Game meaning
Hydroelectricity should be:
- fuel-light
- site-specific
- capital-heavy
- seasonally sensitive
- strategically valuable for urban loads and industry

## 6.3 Local engine-generator sets
These are useful as:
- emergency power
- remote district power
- construction or industrial backup
- temporary supply before full grid buildout

Potential fuels:
- coal gas or producer-gas variants in some settings
- diesel later
- gasoline/naphtha in some later settings
- biogas or biomass-derived fuels in niche conditions

### Game meaning
These should not replace a city grid, but they should matter for:
- hospitals/clinics later
- pumping redundancy
- cold storage backup
- mines, quarries, and detached industrial yards
- military/security sites if that layer later expands

## 6.4 Combined heat and power
Some industrial sites may generate electricity while also using recovered heat for process needs.

### Game meaning
CHP should become attractive where:
- a plant already burns large amounts of fuel
- process heat is valuable
- a reliable industrial micro-grid or captive power setup makes sense

---

# 7. Why AC grid logic matters in this era

The game should not drown the player in current wars history, but it should reflect the practical reason AC becomes dominant for broad grid development:

- electricity can be transformed to higher voltage for more efficient long-distance movement
- it can then be stepped down again closer to users
- that makes wider urban and regional power systems much more viable than a tightly local direct-current-only model

### Game-facing abstraction
You do not need to model full AC/DC engineering.
You do need to model that true city-scale electrification requires:
- transformers
- substations
- transmission/distribution hierarchy
- insulation and switching
- different service levels for different users

---

# 8. Grid layers

## 8.1 Generator-side equipment
The city must support:
- generator hall
- step-up transformers where appropriate
- switchgear
- protective equipment
- metering and control
- operator rooms
- cooling/ventilation
- maintenance access

## 8.2 Transmission or sub-transmission layer
This exists to move power from generator sites to demand centers.

Needs:
- towers or poles depending distance/voltage/layout
- conductors
- insulators
- rights-of-way / route protection
- switching/control points
- maintenance crews
- storm repair capability

## 8.3 Substations
These are major realism gates.

A substation is not just a decorative node.  
It can serve as:
- step-down point
- switching point
- protection point
- sectionalization point
- distribution feeding point
- sometimes interconnection point between utility segments

Requirements:
- transformers
- oil or other insulating/cooling arrangements depending technology
- breakers / switching equipment
- grounded site
- fencing / security
- fire risk management
- inspection routines
- spares planning

## 8.4 Distribution feeders
Once power leaves the substation, feeders deliver it across districts.

Needs:
- poles/conduits/trenches depending development level
- conductor stock
- support hardware
- sectional isolation
- local maintenance access
- vegetation/clearance management where overhead
- load balancing and capacity planning

## 8.5 Local transformation and service
Districts and major facilities need local transformation and service connections.

Typical major service classes:
- heavy industrial
- municipal utility facilities
- commercial/institutional
- street lighting
- residential / worker housing
- emergency / protected loads

---

# 9. Core materials and upstream industries

Electrification should only become possible when the city has or can trade for the following upstream chains.

## 9.1 Copper and conductive metals
Needed for:
- generators
- wires/cables
- busbars
- motor windings
- transformers
- controls and switchgear

Required upstream systems:
- mining
- ore concentration / smelting / refining
- rod/strip production
- wire drawing
- insulation and spool handling

## 9.2 Iron and steel
Needed for:
- generator housings
- plant structures
- turbine shafts
- transmission towers
- substation frames
- motor housings
- machine frames
- pipes, pumps, supports, and utility structures

## 9.3 Insulators and ceramic/glass components
Needed for:
- overhead line support
- bushings
- switchgear isolation
- substation equipment
- some lighting assemblies

## 9.4 Transformer materials
Realistic transformer production depends on:
- magnetic core material
- winding conductors
- insulating material
- tank or enclosure fabrication
- cooling/insulating fluid in many cases
- precision assembly and testing

## 9.5 Electrical insulation and cable protection
Depending period and sophistication:
- rubber-based insulation
- cloth/varnish systems
- gutta-percha or related historical insulation in some specialized lines
- later plastics and synthetic insulation

## 9.6 Lighting materials
Depending period:
- carbon-filament / tungsten-lamp supply chains
- glass bulbs
- sockets and fittings
- fixtures and reflectors
- switches, fuses, and distribution hardware

---

# 10. Major load classes

The city should not treat all electrical demand as interchangeable.

## 10.1 Critical municipal loads
These are the first loads to defend during outage or overload:
- water intake pumps
- treatment plant process loads
- distribution pumps
- sewer lift stations
- wastewater treatment aeration/pumping where present
- emergency lighting in key facilities
- hospitals/clinics later
- emergency communications later

## 10.2 Strategic industrial loads
These are economically decisive:
- electric machine shops
- wire works
- compressor houses
- fans and blowers
- hoists and cranes
- electrically driven pumps
- electric furnaces later
- refrigeration/cold storage

## 10.3 Urban/public loads
- street lighting
- market lighting
- station/yard lighting
- public-building lighting
- depots and warehouses
- water-storage monitoring / alarm systems later

## 10.4 Domestic/commercial loads
Initially, these should rise slowly:
- lighting
- small motors
- refrigeration later
- fans/ventilation
- small appliance classes later in more modern stages

### Design stance
Early electrification in this game should not immediately mean "every home is fully electrified."  
It should begin with:
- municipal loads
- industrial loads
- public lighting
- selected premium/private service
- gradual spread outward

---

# 11. Electrified factories and workshops

## 11.1 What changes inside a factory
Electrification changes factory organization by allowing:
- machine-by-machine power instead of one shaft
- easier rearrangement of floor plans
- more flexible expansion
- better isolation of some hazard zones
- reduced belt/shaft clutter in some layouts
- more specialized machine placement

## 11.2 What does not disappear
Electrification does not remove:
- maintenance burden
- alignment issues
- lubrication
- spare-part needs
- noise
- fire risk
- dust and contamination
- training requirements
- inspection needs

## 11.3 The motor layer
A realistic electrified factory now depends on:
- motors
- motor controls/starters
- wiring and protection
- drives/transmissions
- switchboards
- maintenance electricians and mechanics

### Important realism note
Electric motors should be treated as a huge enabler because they allow useful work to be placed at many points in an industrial process.  
But they also create:
- new maintenance classes
- new spare-part categories
- overload/heat/failure risks
- new dependence on voltage quality and utility uptime

## 11.4 Hybrid era realism
For a long transition, cities may use mixed layouts:
- some belt-driven legacy shops
- some electrically retrofitted workshops
- some plants with central shafts plus selected electric drives
- some sites with captive generators before full public-grid integration

That mixed era is more realistic than an instant total conversion.

---

# 12. Waterworks under electrification

Electrification should deepen water service in three ways:

## 12.1 Pumping becomes more scalable
Electric pumps allow:
- larger throughput
- more reliable pressure zones
- easier lifting to elevated storage
- more flexible siting than purely mechanical shafting
- easier operation at distributed sites

## 12.2 Treatment becomes more operationally demanding
As the city scales, water systems depend on:
- intake works
- treatment stages
- clearwell/storage
- pumping stations
- pressure management
- storage tanks / towers / reservoirs
- distribution mains
- inspection and water-quality management

## 12.3 Storage becomes strategic
Finished-water storage should matter for:
- pressure equalization
- peak demand buffering
- emergency reserve
- fire protection support
- partial resilience during short outages

### Game meaning
Water service should fail gradually or unevenly, not always instantly:
- treatment may continue while distribution pressure falls
- a tank may bridge a short outage
- some districts may lose pressure earlier
- water age / stagnation issues can worsen when operations are poor

---

# 13. Sewer and wastewater under electrification

Sewerage and treatment should become much more institution-heavy here.

## 13.1 Collection
The city now needs:
- trunk lines / mains
- branch collection
- maintenance crews
- blockage response
- stormwater interaction choices
- lift stations where gravity alone is insufficient

## 13.2 Treatment
Depending sophistication:
- screening / grit removal
- primary settling
- secondary biological treatment
- disinfection and discharge control later
- sludge handling

## 13.3 Electric dependence
Wastewater systems become highly dependent on:
- pumps
- aeration/blowers where used
- controls and alarms later
- reliable staffing
- standby procedures during outages

### Game meaning
Wastewater electrification should create a major strategic truth:
**a city can become cleaner and healthier, but also more vulnerable to power failure.**

---

# 14. Street lighting and public time extension

Street lighting should not just be cosmetic.

It should change:
- work-day extension
- night safety
- market activity after dark
- station/yard operations
- policing/watch efficiency
- accident reduction in some zones
- prestige and legitimacy of the city government

Costs and burdens:
- fixture maintenance
- lamp replacement
- wires and poles
- switching/control
- vandalism/weather damage
- energy demand

### Design stance
Street lighting is one of the clearest public proofs that a city has entered an electrified era.

---

# 15. Refrigeration and cold-chain dependence

This era should mark the beginning of true electrical refrigeration dependence in selected sectors.

Likely early users:
- cold storage warehouses
- food wholesalers
- high-value medical storage later
- meat/dairy chains later
- selected institutional kitchens later

### Game meaning
Refrigeration should:
- reduce spoilage
- expand food trade radius
- stabilize some perishables
- enable more urban density
- create high-value outage vulnerability

Power failure consequences should be serious:
- spoiled stock
- emergency consumption pressure
- waste spikes
- public-health risk

---

# 16. Utility governance and administration

A real electrified city needs more than poles and generators.

It needs institutions:

## 16.1 Utility ownership/operation models
Possible models:
- municipal utility
- company/private utility
- industrial captive network with limited public service
- mixed municipal + private franchise arrangement

## 16.2 Administrative functions
- load planning
- district prioritization
- outage logs
- maintenance scheduling
- inventory / spare management
- worker dispatch
- tariff or allocation systems
- capital planning
- incident investigation
- safety and inspection recordkeeping

## 16.3 Public legitimacy
Electrification increases expectations.
People begin to expect:
- lights to work
- pumps to run
- pressure to hold
- sewer service to function
- outages to be repaired
- public authorities to explain failures

This should create stronger governance pressure than early camp/village society.

---

# 17. Safety and hazard layer

Electrification introduces new major hazard classes.

## 17.1 Electrical hazards
- shock/electrocution
- arc/flash/fire analogues at the game-abstraction level
- contact with damaged lines
- wet-environment risks
- poor grounding/bonding consequences
- switchgear mishandling

## 17.2 Fire hazards
- overloaded conductors
- insulation failure
- generator/transformer failures
- plant fires
- substation fires
- electrical ignition in dusty or oily industrial sites

## 17.3 Utility-interdependence hazards
- grid loss causing pump failure
- water loss reducing firefighting capacity
- sewer backup from lift-station failure
- cold storage warming during outage
- signaling/lighting failures increasing accidents

## 17.4 Storm/environment hazards
- line damage
- pole/tower failure
- flooding of utility sites
- lightning damage
- contamination at utility facilities
- snow/ice/wind outages depending climate

### Game stance
This era should feel more technologically powerful and more brittle at the same time.

---

# 18. Maintenance burden

Electrification should create an entire maintenance economy.

## 18.1 Generation-side maintenance
- boilers where present
- turbines/engines
- generators
- condensers/cooling systems
- bearings and lubrication
- insulation condition
- switchgear and controls

## 18.2 Grid maintenance
- pole/tower inspection
- conductor repairs
- insulator replacement
- vegetation or clearance control
- substation inspection
- transformer inspection/testing
- fault repair
- storm restoration

## 18.3 Load-side maintenance
- motors
- switchboards
- local transformers
- building wiring
- lamp and fixture replacement
- pump motors
- refrigeration equipment
- controls and protection devices

### Design result
Electrification should create many new roles and spare-part demands rather than simply reducing labor.

---

# 19. New NPC roles and professions

A believable electrified industrial city should introduce at least the following roles:

- electrical engineer
- station engineer / chief operator
- generator operator
- boiler operator (where steam-electric generation exists)
- substation operator / maintainer
- lineman / line crew
- cable/wire worker
- transformer assembler / maintainer
- switchgear technician
- motor rewinder / motor repair worker
- electric machine tool mechanic
- utility planner
- meter/records clerk
- outage dispatcher
- pump station operator
- wastewater electrical maintenance worker
- street-light crew
- refrigeration mechanic later in the era

### Cross-trained overlaps
Some roles should overlap with:
- machinists
- boilermakers
- steam engineers
- instrument/controls workers later
- copper workers and metalworkers
- public-health / utility administrators

---

# 20. Buildings and infrastructure unlocked at this layer

## 20.1 Core power buildings
- power station
- generator hall
- turbine hall / engine hall
- boiler house where relevant
- coal yard / fuel yard
- ash and residual handling area
- cooling-water works where relevant
- control room / switch room

## 20.2 Grid buildings and nodes
- step-up station
- main substation
- district substations
- switching yard
- pole yard / line depot
- cable yard or conduit works later

## 20.3 Utility buildings
- electrically pumped waterworks
- finished-water storage with pressure role
- sewer lift stations
- electrified treatment works
- cold storage plant
- public lighting depot

## 20.4 Industrial buildings
- electric machine shop
- wire works
- motor shop
- transformer shop/works
- electrical supply warehouse
- instrument/repair room later

---

# 21. Key item and component families

This era should add or elevate the importance of:

- copper cathode / refined copper
- wire rod
- drawn wire
- insulated wire / cable
- busbars
- insulators
- lamps and lamp assemblies
- sockets and fixtures
- switches
- fuses and protective hardware
- breaker / switchgear families at the abstraction level
- generator parts
- motor parts
- transformer parts
- poles / crossarms / tower members
- meters and control panels later
- pump motors
- blower motors
- refrigeration compressors/motors later
- spare coils, bearings, insulation, brushes where relevant by technology era

---

# 22. Process families introduced or expanded

This era needs new processes such as:

- generate electricity
- step up voltage
- transmit power
- step down power at substations
- distribute power through feeders
- connect new district service
- install street lighting
- run electric pumping station
- operate electric water treatment load
- operate wastewater lift station
- maintain substation
- inspect and repair lines
- draw and insulate wire
- assemble transformer
- assemble/repair motor
- electrify workshop
- convert shaft-driven process to motor drive
- manage outage restoration
- test backup generation
- inspect finished-water storage for utility integration
- monitor critical loads and load shedding

---

# 23. Knowledge and training gates

Electrification should require more than material availability.

## 23.1 Knowledge layers needed
- practical generation operation
- electrical safety discipline
- motor operation/maintenance
- transformer and substation understanding at the operational level
- utility dispatch and record-keeping
- electrical installation standards
- load prioritization and outage procedures
- integration of water/sewer with electric service

## 23.2 Institutional learning
This era should strongly reward:
- manuals/checklists
- apprenticeship
- formal technical instruction
- incident reporting
- standard diagrams/drawings
- maintenance schedules
- lockout/isolation-equivalent procedures at the game abstraction level

## 23.3 Misconceptions and false starts
Good realism comes from allowing:
- underbuilt lines
- poor insulation choices
- overloaded districts
- inadequate transformer capacity
- bad waterworks siting
- no backup for critical pumps
- over-electrified growth before maintenance institutions mature

---

# 24. Gameplay gates for unlocking electrification

A city should not be able to electrify just because it has "coal + copper."

Suggested prereqs:
- reliable heavy fuel supply or hydro site
- advanced metallurgy and machine tools
- standardized parts and measurement practices
- copper refining and wire drawing capability or dependable imports
- ceramic/glass insulator capability or dependable imports
- switchgear and transformer production/import chain
- skilled operators and line crews
- municipal administrative capacity
- enough urban demand to justify grid investment
- enough maintenance capacity to keep outages from being constant

---

# 25. Suggested stage ladder within electrification

## Stage A — isolated generation
- one plant powers one works or district
- limited night lighting
- no deep public grid
- high fragility
- selective loads only

## Stage B — municipal backbone
- one or more central stations
- substations begin
- waterworks and public lighting are electrified
- selected industrial users connect
- outage management becomes a formal institution

## Stage C — district grid expansion
- multiple districts served
- electric motors spread through workshops/factories
- sewer pumping/treatment deepens
- cold storage appears
- maintenance depots and spares systems mature

## Stage D — utility society threshold
- electrified industry is normal
- municipal water and sewer are deeply grid-dependent
- public lighting is widespread
- critical-load planning matters
- the city is ready for chemical/petroleum and more modern mechanized layers

---

# 26. Failure modes and event hooks

Good event families for this era:
- generator trip or forced shutdown
- boiler failure affecting power output
- transformer fire/failure
- substation overload
- feeder damage after storm
- district blackout
- low-water-pressure district event after pump failure
- sewer backup after lift-station outage
- cold storage spoilage event
- motor burnout in high-value shop
- line crew injury
- shortage of lamp stock / insulators / wire
- coal shortage forcing load curtailment
- water contamination risk after storage breach
- political/public anger over unequal restoration order

---

# 27. Metrics the game should track

## Power metrics
- installed generation capacity
- available generation capacity
- current load
- peak load
- reserve margin
- district service coverage
- outage minutes / district downtime
- critical-load protection score

## Utility metrics
- pumped water capacity
- treated water capacity
- water storage reserve
- pressure reliability
- sewage conveyed vs untreated overflow pressure
- treatment throughput
- lift-station dependency count

## Industrial electrification metrics
- number of motorized processes
- share of industrial demand electrified
- workshop electrification level
- line-shaft dependence still remaining
- cold-chain capacity

## Institution metrics
- trained electrical workers
- transformer/motor spare stock
- maintenance backlog
- inspection coverage
- public service legitimacy
- restoration performance

---

# 28. Transition gate to the next era

The city can be considered firmly inside an electrified industrial era when all of the following are broadly true:

- generation is more than isolated novelty and serves multiple districts or major user groups
- substations and distribution feeders exist as a maintained network
- waterworks depend materially on electric pumping and storage management
- wastewater handling depends materially on electric infrastructure
- electric motors are common in workshops and factories
- public lighting is institutionally maintained
- outage response exists as a formal municipal or utility function
- copper/wire/transformer maintenance has become a normal recurring burden
- public and industrial life now assume electricity will usually be available

At that point, the city is ready for the next great transition:
**chemical/petroleum intensification, broader refrigeration, more advanced communications, and mechanized modern production.**

---

# 29. First implementation slice for this era

When the game eventually implements this era, the smallest convincing slice is not "full national grid."

It is:

- one steam-electric station
- one main substation
- two service districts
- electrified water pumping
- public street lighting in one district
- one electric machine shop
- one cold storage facility
- one outage/restoration loop
- one overloaded/underbuilt district as a design lesson

That slice is enough to prove the most important truths:
- electricity is flexible
- electricity is transformative
- electricity is maintenance-heavy
- electricity binds utilities and industry together
- electricity creates new kinds of failure

---

# 30. References

## Internal design basis
- realistic_idle_city_design_v1.md
- realistic_idle_city_water_sanitation_utilities_spec_v0_1.md
- realistic_idle_city_steam_power_boilers_line_shaft_factories_spec_v0_1.md
- realistic_idle_city_machine_tools_standardization_interchangeable_parts_spec_v0_1.md

## External references
- U.S. Energy Information Administration (EIA), *Delivery to consumers*  
  https://www.eia.gov/energyexplained/electricity/delivery-to-consumers.php

- U.S. Energy Information Administration (EIA), *How electricity is generated*  
  https://www.eia.gov/energyexplained/electricity/how-electricity-is-generated.php

- U.S. Energy Information Administration (EIA), *Photovoltaics and electricity*  
  https://www.eia.gov/energyexplained/solar/photovoltaics-and-electricity.php

- U.S. Department of Energy, *How It Works: Electric Transmission & Distribution and Protective Measures*  
  https://www.energy.gov/sites/default/files/2023-11/FINAL_CESER%20Electricity%20Grid%20Backgrounder_508.pdf

- U.S. Department of Energy, *Optimizing Your Motor-Driven System*  
  https://www.energy.gov/sites/prod/files/2014/04/f15/mc-0381.pdf

- U.S. Environmental Protection Agency (EPA), *Drinking Water Distribution System Tools and Resources*  
  https://www.epa.gov/dwreginfo/drinking-water-distribution-system-tools-and-resources

- U.S. Environmental Protection Agency (EPA), *Primer for Municipal Wastewater Treatment Systems*  
  https://www.epa.gov/sites/default/files/2015-09/documents/primer.pdf

- U.S. Environmental Protection Agency (EPA), *Protecting Water Quality Through Finished Water Storage Facility Inspection and Cleaning*  
  https://www.epa.gov/system/files/documents/2022-04/ds-toolbox-fact-sheets_sfi_final-508_revised.pdf

- Centers for Disease Control and Prevention (CDC), *What to Do to Protect Yourself During a Power Outage*  
  https://www.cdc.gov/natural-disasters/response/what-to-do-protect-yourself-during-a-power-outage.html
