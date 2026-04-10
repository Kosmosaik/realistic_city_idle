---
title: "Realistic Idle City — Rail / Bulk Freight / Heavy Logistics Spec"
version: "v0.1"
date: "2026-04-09"
scope: "Late pre-industrial bridge to early industrial city through electrified/modern freight layers"
status: "Design specification"
---

# 1. Purpose

This document defines how **rail**, **bulk freight**, and **heavy logistics** should work in the project.

It sits after:
- roads / paths / internal settlement infrastructure
- animal traction / carts / wagons
- metallurgy / mining / fuel chain
- mills / mechanized workshops
- steam power / boilers / line-shaft factories
- industrial utilities / electrification
- trade / market / exchange
- logistics / hauling / storage flow

Its job is to explain how the simulation should move from:
- local manual hauling,
- then animal and wagon logistics,
- then road-market logistics,
- into **industrial-scale freight systems** that can move coal, ore, stone, timber, grain, fuel, steel, machinery, and containers in volumes large enough to sustain heavy industry and later integrated cities.

This is not a passenger-rail document. Passenger service may exist later, but the design focus here is **freight rail as an industrial backbone**.

---

# 2. Design stance

## 2.1 Core truth

Rail is not just “faster hauling.”

Rail is a whole **infrastructure regime** that changes what kinds of settlements and industries are viable.

A society with freight rail can:
- move very heavy goods much farther at lower unit cost than road haulage,
- connect mines, forests, mills, refineries, ports, factories, warehouses, and cities,
- coordinate regular scheduled flows,
- support bulk commodity systems,
- support standardized freight equipment and terminals,
- support regional specialization,
- make very large cities and industrial districts more sustainable.

A society without freight rail must rely much more heavily on:
- local sourcing,
- waterways where available,
- animal traction,
- road cartage,
- and much smaller heavy-industry catchments.

## 2.2 Realism principle

Rail becomes attractive when three conditions converge:
1. **heavy or repetitive freight demand exists**,
2. **supporting industry exists** to build and maintain rail assets,
3. **the traffic density justifies the fixed infrastructure**.

So rail should never appear as a simple tech unlock.
It should emerge only when the economy is already generating enough demand in coal, ore, stone, timber, grain, fuel, manufactured goods, or intermodal exchange.

## 2.3 Scope ladder inside this document

This specification covers five maturity layers:

1. **Industrial sidings and tramways**
2. **Short mineral/industrial railways**
3. **Regional freight rail network**
4. **Heavy bulk and yard-centered rail logistics**
5. **Electrified / containerized / system-of-systems freight rail**

---

# 3. Real-world anchors that shape the design

The design choices in this document are based on a few strong real-world transport facts:

- Rail freight became transformative because it could move bulk commodities and industrial inputs more cheaply over land than road wagons once track, locomotives, and terminals existed.
- Rail yards are not decorative; they are operational systems for sorting, building, breaking, storing, and dispatching freight trains.
- Rail freight is not one thing. It includes carload traffic, bulk unit trains, switching/service to industries, and intermodal/container operations.
- Rail depends on a full physical chain: rails, ties/sleepers, ballast, drainage, bridges, culverts, switches, sidings, yards, locomotives, rolling stock, depots, shops, dispatch, signaling, and maintenance.
- Bulk freight economics depend strongly on avoiding unnecessary transloading, switching, and delays.
- Intermodal freight depends on terminals and road connections just as much as on the rail line itself.

---

# 4. Place in the project’s progression

## 4.1 Earlier foundation already required

Before freight rail becomes realistic, the society should already have:
- mapped resource regions,
- strong mining/logging/quarrying demand,
- road and wagon systems,
- animal traction or industrial haul alternatives,
- standardized metallurgy,
- steam-power competency,
- machine shops,
- foundries,
- bridge/construction capability,
- administrative scheduling and records,
- enough urban/industrial demand to keep the railway busy.

## 4.2 Settlement-level meaning

Freight rail marks the point where the economy stops being mostly local-plus-road and becomes **corridor-based**.

The map is no longer just settlements with nearby hinterlands.
It becomes:
- sources,
- corridors,
- terminals,
- yards,
- depots,
- transload zones,
- port links,
- industrial districts,
- distribution centers,
- and service catchments.

## 4.3 Era mapping

### Late pre-industrial bridge
- mine tramways
- timber tramways
- short industrial rails
- horse- or gravity-assisted local movement in some settings

### Early industrial city
- steam locomotion
- branch lines
- sidings to mines and mills
- yards
- rail workshops
- bulk freight scheduling

### Electrified industrial city / modern city
- denser yards and terminals
- stronger signaling/dispatch logic
- electric traction in some districts or corridors
- intermodal/container terminals
- urban wholesale freight interfaces
- refrigerated and hazardous freight discipline

---

# 5. Freight problems rail solves

Rail should exist in the simulation because it solves specific logistics problems better than roads in the right conditions.

## 5.1 Mass and distance problem

Road wagons and carts become inefficient when the economy must move:
- coal,
- iron ore,
- limestone,
- sand/gravel,
- timber,
- sawn boards,
- brick,
- cement,
- grain,
- petroleum products,
- steel,
- machinery,
- fertilizer,
- containers,
- and repeated industrial replenishment.

## 5.2 Reliability problem

Roads and wagons suffer strongly from:
- mud,
- snow,
- grade,
- axle/bearing wear,
- animal fatigue,
- slower long-haul speeds,
- route congestion,
- higher labor per ton moved.

Rail does not eliminate these problems, but it reduces the cost per ton for regular heavy movement once track and operations are established.

## 5.3 Throughput problem

Industrial districts need not only low cost, but **repeated predictable throughput**.

Examples:
- coal to power plant every day,
- ore to furnace continuously,
- grain from hinterland to mill or terminal every harvest season,
- steel, lumber, and cement to construction districts,
- fuel and chemicals to urban industry,
- outgoing finished goods to ports or regional markets.

## 5.4 Integration problem

Rail becomes especially powerful when it links:
- mine → works,
- forest → sawmill,
- grain region → elevator / terminal,
- refinery → tank terminal,
- factory → warehouse,
- port → inland market,
- city → regional suppliers.

---

# 6. Rail system layers

A believable freight rail system should be modeled as layers, not one building.

## 6.1 Right-of-way layer
- surveyed corridor
- earthworks / cut / fill
- drainage
- culverts
- bridges / viaducts where needed
- tunnel where justified later
- embankment stabilization
- crossing protection where needed

## 6.2 Track layer
- rails
- ties/sleepers
- ballast / sub-ballast
- fasteners / plates / clips / spikes depending era
- turnouts/switches
- derails where needed
- buffers/stops on dead-end tracks

## 6.3 Operating plant layer
- sidings
- passing loops
- spurs
- branch lines
- yards
- terminals
- depots
- locomotive servicing
- water/fuel/sand facilities
- maintenance shops
- signal/interlocking/control systems later

## 6.4 Rolling stock layer
- locomotives
- tenders where relevant
- freight cars / wagons
- brake systems
- couplers
- wheelsets / bearings
- tank cars / boxcars / hopper cars / gondolas / flats / refrigerated cars / container well cars later

## 6.5 Operational control layer
- dispatch / timetable / slots
- crew scheduling
- yardmaster logic
- switching plans
- train makeup rules
- weight/grade/length restrictions
- inspections
- maintenance windows

## 6.6 Commercial/logistics layer
- contracts / traffic commitments
- commodity lanes
- loading/unloading appointments
- warehouse timing
- inventory promises
- interchange with other lines
- terminal fees / handling losses / dwell times

---

# 7. Track and network types

## 7.1 Main line
High-priority through route.
Used for:
- long-distance freight movement,
- scheduled bulk flows,
- connections between major nodes.

Characteristics:
- better alignment,
- stronger maintenance standards,
- dispatch priority,
- passing infrastructure,
- stricter safety and signaling logic.

## 7.2 Branch line
Lower-density feeder route from sources or smaller settlements into the main network.

Typical uses:
- mine branches,
- agricultural branches,
- forest products,
- smaller industrial towns.

Characteristics:
- lighter traffic,
- often lower speed,
- more vulnerable to closure if traffic declines,
- important for economic reach.

## 7.3 Spur / industrial lead
Track serving a specific customer or site.

Examples:
- coal mine spur,
- grain elevator spur,
- refinery siding,
- steelworks lead,
- warehouse district tracks,
- team track / public freight loading track.

## 7.4 Siding / passing track
Track used so trains can meet, pass, or be staged clear of the main.

Gameplay role:
- line capacity,
- congestion relief,
- staging,
- work windows.

## 7.5 Yard tracks
Tracks for:
- classification,
- storage,
- repair set-out,
- locomotive handling,
- loading/unloading,
- assembling trains.

## 7.6 Tramway / industrial railway
Simpler rail system for mines, quarries, timber, or plant-internal movement.

Useful as a bridge stage before a full railroad.

---

# 8. Nodes and facilities

## 8.1 Industry siding
Minimum rail-served industry interface.

Requires:
- turnout connection,
- loading/unloading area,
- safe clearance,
- local switching access,
- inventory buffer nearby,
- road access or internal works handling.

## 8.2 Team track / public freight track
Shared public loading point where multiple shippers without their own rail spurs can send/receive freight.

Gameplay use:
- transitional freight access for smaller settlements,
- lower capital than private sidings,
- good for market towns and mixed industry districts.

## 8.3 Freight station / goods shed
Covered transfer node for smaller manufactured goods, tools, crates, mail/freight equivalents, and less-than-carload traffic in earlier eras.

## 8.4 Bulk terminal
Purpose-built node for a repeated commodity.

Examples:
- coal tipple / coal terminal,
- grain elevator,
- ore loading facility,
- petroleum tank terminal,
- cement bulk terminal,
- aggregate terminal.

## 8.5 Classification yard / marshaling yard
Central yard for receiving cars, sorting them by destination, and building outbound trains.

Key subzones:
- arrival tracks,
- classification bowl,
- departure tracks,
- switching lead,
- engine tracks,
- repair-in-place tracks,
- bad-order / damaged-car set-out,
- yard office/control.

### Yard forms
- **flat switching yard**: cars placed by locomotive switching movements
- **hump yard**: cars pushed over an artificial hill and sorted by gravity at very high traffic volumes

Gameplay meaning:
- high capacity but high infrastructure/labor cost,
- major bottleneck for rail network performance,
- source of dwell time,
- source of accident and congestion risk.

## 8.6 Interchange yard
Where freight cars or blocks transfer between different railway companies / network domains.

## 8.7 Intermodal terminal
Where containers or trailers transfer between rail and truck, or rail and port.

Needs:
- paved staging areas,
- cranes/reach stackers later,
- truck gates,
- container storage planning,
- strong road connectors,
- scheduling discipline.

## 8.8 Port rail terminal
Rail interface for seaport or river-port trade.

Critical for:
- export bulk,
- imported fuel/materials,
- containerized inland distribution,
- large-scale industrial sourcing.

---

# 9. Freight traffic types

A realism-first game should not treat all freight trains the same.

## 9.1 Carload / mixed freight
Multiple customers, multiple commodities, more switching complexity.

Advantages:
- flexible,
- supports dispersed industry.

Costs:
- slower,
- more yard labor,
- more dwell,
- more rehandling.

## 9.2 Unit train
All cars carry one commodity to one destination or a stable dedicated lane.

Examples:
- coal train,
- ore train,
- grain shuttle,
- petroleum product train.

Advantages:
- minimal switching,
- high efficiency,
- high asset utilization,
- strong for predictable bulk flows.

Requires:
- large source and destination facilities,
- heavy enough volume to justify dedicated trainsets.

## 9.3 Intermodal train
Containers or trailers moved by rail between terminals, then transferred to truck or ship.

Advantages:
- high long-haul efficiency combined with flexible local distribution,
- very important for retail and manufactured goods in modern eras.

Requires:
- standardized containers,
- terminals,
- connectors,
- appointment/yard discipline,
- good road access.

## 9.4 Local switcher / industrial service
Short trains or switching jobs serving industries off the main network.

## 9.5 Work train / maintenance train
For ballast, rail, ties, repair crews, construction materials, and incident response.

---

# 10. Commodity families and their logistics behavior

## 10.1 Coal and coke
Rail is ideal because:
- very heavy,
- large volume,
- repetitive movement,
- mine-to-plant corridors are stable.

Needs:
- mine loading,
- hopper or gondola logic,
- dust/spillage control,
- unloading facilities,
- storage stockpiles.

## 10.2 Ore and flux stone
Similar to coal, but often tied directly to blast furnace / smelter chains.

## 10.3 Grain
Strongly seasonal, highly volume-sensitive, moisture-sensitive.

Needs:
- elevator/silo/granary staging,
- cleaning/drying/storage discipline,
- harvest surge handling,
- loading efficiency.

## 10.4 Timber and forest products
May move as:
- logs,
- pulpwood,
- sawn lumber,
- boards,
- poles.

Often starts on branch lines or industrial tramways.

## 10.5 Stone / sand / gravel / cement
Very important for construction-heavy eras.

Rail is often attractive because these are heavy, low-value-per-unit goods that punish truck/road systems over longer distances.

## 10.6 Petroleum / fuels
Needs:
- tank cars,
- spill/fire safety,
- tank farms,
- pump/loading systems,
- strict hazard handling.

## 10.7 Steel / machinery / manufactured goods
May move in:
- boxcar logic,
- flatcar logic,
- specialized wagon logic,
- containerized logic later.

## 10.8 Refrigerated/perishable goods later
Needs strong schedule reliability and supporting cold chain.

---

# 11. Rolling stock families

## 11.1 Locomotives
### Steam locomotives
Requirements:
- coal/wood/oil fueling depending era,
- water supply,
- ash disposal,
- servicing,
- heavy maintenance,
- skilled crews.

### Diesel locomotives later
Requirements:
- fuel depots,
- engine maintenance,
- electrical systems,
- less fixed watering infrastructure.

### Electric locomotives later where justified
Requirements:
- electrified route,
- substations,
- catenary/third-rail systems where applicable,
- high-capital corridor with sufficient traffic density.

## 11.2 Freight car families
- boxcar / covered wagon logic
- flatcar
- gondola
- hopper / bulk car
- tank car
- ore car
- timber/log car
- refrigerated car later
- intermodal well/platform car later

## 11.3 Shared technical subsystems
- couplers
- draft gear
- wheelsets
- bearings
- brake rigging / air brake logic
- loading restraints / lashing
- inspection points

---

# 12. Operations model

## 12.1 Train planning
A train should not exist just because there is cargo waiting.

A valid train plan should consider:
- volume threshold,
- destination grouping,
- commodity compatibility,
- car availability,
- locomotive availability,
- crew availability,
- route capacity,
- siding length,
- grade limits,
- time sensitivity,
- hazardous segregation rules.

## 12.2 Dispatch and pathing
Mainline capacity depends on:
- track count,
- passing loops,
- timetable/scheduled windows,
- signal and dispatch quality,
- maintenance windows,
- yard congestion,
- incident disruption.

## 12.3 Switching
Switching is a distinct labor system.
It consumes:
- time,
- crews,
- locomotives,
- yard space,
- safety attention.

Switching cost should be visible because it is one of the reasons unit trains are so powerful.

## 12.4 Dwell
Cars and containers do not only move; they also sit.

Important dwell types:
- waiting to be loaded,
- waiting to be unloaded,
- waiting in classification,
- waiting for customs/inspection later if modeled,
- waiting for connecting train,
- held due to no storage space at destination,
- held due to congestion or breakdown.

Dwell should matter because it ties up rolling stock and reduces effective network throughput.

## 12.5 Blocking and train makeup
Cars may be grouped into blocks for destinations to reduce repeated resorting.

This can become a later optimization mechanic.

---

# 13. Infrastructure condition and maintenance

Rail is capital-intensive and maintenance-intensive.
That needs to be visible in the simulation.

## 13.1 Track maintenance burdens
- ballast fouling / drainage failure
- tie/sleeper wear or rot
- rail wear / corrugation / defects later
- turnout/switch wear
- embankment settlement
- vegetation and sight-line management
- culvert blockage
- bridge inspection/repair
- winter snow/ice issues where modeled

## 13.2 Rolling stock maintenance burdens
- wheel wear
- bearing failure risk
- brake system faults
- coupler/draft issues
- body corrosion later
- door/hatch/seal issues
- tank integrity / valve issues for liquids

## 13.3 Locomotive servicing burdens
### Steam era
- boiler washout / inspection
- tube/firebox issues
- running gear lubrication
- ash disposal
- water treatment quality matters later

### Diesel/electric era
- engine/electrical maintenance
- fuel system
- traction motors later
- batteries/control systems later

## 13.4 Shop infrastructure
A mature railway needs:
- locomotive shop,
- car shop,
- wheel / bearing / brake shop capability,
- track gangs,
- stores / spare parts,
- engineering records.

---

# 14. Safety model

This document is not a detailed regulatory manual, but a realism-first freight system should treat rail safety as structural.

## 14.1 Persistent rail hazards
- crushing/pinch hazards in switching
- runaway cars
- foul-of-track errors
- brake failure or insufficient securement
- collision risk from dispatch/signal failures
- turnout misalignment
- derailment from poor track condition
- boiler/steam hazards in steam era
- fuel fire / tank spill
- worker fatigue and human-factor errors

## 14.2 Settlement-facing risks
- blocked crossings
- fires and explosions around fuel terminals
- smoke/air burden in steam districts
- noise
- track severing neighborhoods or work zones
- hazardous cargo incidents

## 14.3 Safety institutions required
- operating rules
- inspection routines
- signaling/authority systems
- yard procedures
- crew qualification
- speed restrictions
- maintenance standards
- incident reporting
- emergency response plans

---

# 15. Labor and roles

## 15.1 Infrastructure roles
- surveyor
- civil engineer
- bridge/earthworks crew
- track layer
- ballast crew
- signal/utility installer later
- bridge inspector
- maintenance-of-way foreman

## 15.2 Operating roles
- dispatcher
- yardmaster
- switch crew / shunter
- locomotive engineer / driver
- fireman in steam era
- conductor / train foreman role as modeled
- terminal clerk
- intermodal gate/yard planner later

## 15.3 Mechanical roles
- locomotive mechanic
- boiler mechanic/inspector
- car repairer
- brake fitter
- wheel/axle worker
- machinist
- electrician later

## 15.4 Commercial/administrative roles
- freight planner
- traffic clerk
- scheduler
- warehouse/terminal manager
- interchange coordinator
- safety officer
- cost accountant / records clerk

---

# 16. Rail and other modes

Rail should complement, not erase, other transport modes.

## 16.1 Road + rail
Roads remain essential for:
- first/last-mile access,
- settlements without sidings,
- local collection/distribution,
- emergency rerouting,
- terminal connections.

## 16.2 Water + rail
Ports and river terminals create strong synergies.

## 16.3 Warehouse + rail
Warehousing is not optional. Rail needs staging, buffering, and handling space.

## 16.4 Factory + rail
Rail-served industry becomes materially different from road-served industry:
- larger shipment lots,
- different building orientation,
- more siding space,
- more inventory buffering,
- less daily wagon clutter if flows are stable,
- stronger dependence on schedule slots.

---

# 17. Economic and gameplay implications

## 17.1 What rail should make possible
- much larger steel/coal/cement chains
- regional specialization
- larger cities supplied from farther away
- more stable heavy-industry production
- bulk exports/imports
- lower unit logistics cost on dense corridors

## 17.2 What rail should not do
Rail should not be a universal upgrade that simply dominates all transport.

It should be poor or inefficient for:
- tiny sporadic shipments,
- remote places with no viable traffic density,
- routes where roads or waterways are clearly superior for the current volume,
- highly fragmented low-volume goods without terminal structure.

## 17.3 Main bottlenecks to model
- insufficient traffic to justify line
- yard congestion
- inadequate siding length
- no destination storage
- no loading/unloading plant
- poor connectors from railhead to final user
- locomotive shortage
- rolling-stock shortage
- maintenance backlog
- bridge/grade restrictions
- switching overload

---

# 18. Progression ladder for gameplay

## 18.1 Stage A — Industrial tramway / works rail
Unlock drivers:
- quarry, mine, sawmill, or plant needing repeated heavy movement
- simple rail fabrication available
- local gradient/haul problem severe enough to justify rails

Typical assets:
- very short rail line
- small wagons/cars
- animal, stationary engine, or simple locomotive haul depending era

## 18.2 Stage B — Branch industrial railway
Unlock drivers:
- one dominant commodity lane
- repeated mine/forest/works output
- depot and siding logic established

Typical cargo:
- coal, ore, timber, stone

## 18.3 Stage C — Regional freight railroad
Unlock drivers:
- multiple towns/industries need connection
- enough workshops and maintenance exist
- steam locomotives and car repair supported

Adds:
- branches
- sidings
- small yards
- goods depots
- scheduled freight

## 18.4 Stage D — Yard-centered heavy freight network
Unlock drivers:
- multiple origin-destination flows
- large industry clusters
- bulk trains and car sorting become necessary

Adds:
- classification yard
- interchange logic
- larger terminals
- bigger locomotive/car shops

## 18.5 Stage E — Intermodal / modern heavy logistics
Unlock drivers:
- container standards
- truck-road connectors
- high-value general freight volume
- modern dispatch and terminal equipment

Adds:
- intermodal terminals
- container yards
- port rail interfaces
- denser warehousing and distribution centers

---

# 19. City-building consequences

Once rail exists, city form should change.

## 19.1 Spatial consequences
- industrial districts cluster near tracks
- warehouses prefer terminal access
- fuel and bulk terminals require buffers
- yards consume large footprints
- bridges/corridors create barriers and crossings
- worker housing may cluster near shops/yards in some eras

## 19.2 Institutional consequences
- stronger scheduling bureaucracy
- more maintenance institutions
- stronger safety administration
- more specialized logistics labor
- greater dependence on external supply chains

## 19.3 Environmental consequences
- smoke/soot in steam era
- noise and vibration
- fuel spills and drainage contamination risk
- land fragmentation
- concentrated rail-yard emissions in diesel eras
- but lower unit land freight emissions than all-road heavy movement in many cases

---

# 20. System interfaces with other specs

## 20.1 Trade / market / exchange
Rail lowers cost for long-haul bulk and later intermodal exchange, enabling bigger markets and stronger regional price integration.

## 20.2 Logistics / hauling / storage flow
Rail changes where inventories sit and how long they dwell, but does not remove the need for terminals, warehouses, loaders, and handlers.

## 20.3 Water / sanitation / utilities
Rail supplies coal, chemicals, pipe, cement, steel, fuel, machinery, and treatment materials needed by urban utilities.

## 20.4 Metallurgy / fuel / machine tools
Rail both depends on these systems and expands them by making bulk feedstock movement viable.

## 20.5 Event / incident system
Rail introduces derailments, yard accidents, blocked terminals, bridge washouts, fuel shortages, turnout failures, rolling-stock shortages, and labor bottlenecks.

## 20.6 Governance / law / administration
Rail requires operating rules, corridor control, rights-of-way, land use, labor discipline, tariff/contract administration, and dangerous-goods governance.

---

# 21. What to simulate explicitly vs abstractly

## 21.1 Simulate explicitly
- line ownership / route map
- yards and terminals
- commodity lanes
- loading and unloading capacity
- train length / weight restrictions as summarized stats
- dwell
- switching burden
- maintenance condition
- rolling-stock pool availability
- major incidents and route disruptions

## 21.2 Semi-abstract
- exact coupler-by-coupler train handling
- full signal logic on every block in the first implementation
- every bolt/clip on trackwork
- every individual wheel bearing unless maintenance/failure system demands it

## 21.3 Good summary metrics
- tons moved per route per period
- average dwell
- on-time departure rate
- yard congestion index
- terminal utilization
- locomotive availability
- rolling-stock shortage by car type
- track condition index
- derailment/incident rate
- freight cost per ton-km / ton-mile equivalent

---

# 22. First-playable late-game slice for rail

A sensible first rail implementation for the larger project is not the whole rail world.

It is:
- one mine or quarry,
- one industrial town,
- one branch line,
- one siding,
- one small yard,
- one locomotive depot,
- two to four car types,
- two to four freight types,
- visible switching and dwell,
- visible bottlenecks around loading, dispatch, and maintenance.

That is enough to prove:
- rail changes industrial viability,
- yards matter,
- freight is not teleportation,
- heavy logistics can become a true systems layer.

---

# 23. Data schema recommendations

## 23.1 Rail line record
- id
- name
- owner/operator
- era/maturity tier
- line_type (main / branch / spur / siding / tramway)
- gauge if modeled
- route length
- ruling grade summary
- curvature difficulty summary
- track condition
- capacity class
- electrified yes/no later
- allowed axle/load class summary
- connected_nodes[]
- maintenance burden
- speed class summary
- hazard exposure tags (flood / snow / landslide / fire / bridge-intensive)

## 23.2 Node / terminal record
- id
- node_type (yard / siding / bulk terminal / goods shed / intermodal / port link)
- loading_modes[]
- unloading_modes[]
- storage_buffers[]
- switch complexity
- max_train_length support
- workforce roles[]
- congestion metrics
- connector_modes[] (road / water / internal conveyor / pipeline later)

## 23.3 Rolling stock record
- id
- type
- cargo families allowed
- nominal capacity
- loading restrictions
- brake/maintenance class
- availability state
- repair state
- owner/pool assignment

## 23.4 Train service record
- id
- service_type (unit / mixed / local / intermodal / work train)
- route
- scheduled windows
- commodity block rules
- locomotive requirement
- car requirement mix
- crew requirement
- capacity
- priority
- hazard constraints

## 23.5 Commodity lane record
- commodity
- origin node
- destination node
- expected volume per period
- seasonality
- urgency
- storage risk at origin
- storage risk at destination
- alternative modes
- profitability / strategic value

---

# 24. References

These are grounding references for this design pass.

- Federal Railroad Administration (FRA), *Freight Rail Overview*  
  https://railroads.dot.gov/rail-network-development/freight-rail-overview

- Association of American Railroads (AAR), *Freight Rail Operations 101: Overview & Basics*  
  https://www.aar.org/operations-101/

- Encyclopaedia Britannica, *Marshaling yard*  
  https://www.britannica.com/technology/marshaling-yard

- Encyclopaedia Britannica, *Railroad* and freight/intermodal sections  
  https://www.britannica.com/technology/railroad

- Encyclopaedia Britannica, *Unit train*  
  https://www.britannica.com/technology/unit-train

- Encyclopaedia Britannica, *Containerization*  
  https://www.britannica.com/technology/containerization

- FHWA, *Freight Intermodal Connectors Study*  
  https://ops.fhwa.dot.gov/Publications/fhwahop16057/index.htm

- eCFR, 49 CFR Part 213, *Track Structure*  
  https://www.ecfr.gov/current/title-49/subtitle-B/chapter-II/part-213/subpart-D

- eCFR, 49 CFR Part 232, *Brake System Safety Standards for Freight and Other Non-Passenger Trains and Equipment*  
  https://www.ecfr.gov/current/title-49/subtitle-B/chapter-II/part-232

- eCFR, 49 CFR Part 218, *Railroad Operating Practices*  
  https://www.ecfr.gov/current/title-49/subtitle-B/chapter-II/part-218

- EPA, *Regulations for Emissions from Locomotives*  
  https://www.epa.gov/regulations-emissions-vehicles-and-engines/regulations-emissions-locomotives

- AAR, *Freight Rail Facts & Figures*  
  https://www.aar.org/wp-content/uploads/2023/04/AAR-Facts-Figures-Fact-Sheet.pdf
