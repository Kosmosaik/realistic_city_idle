---
title: "Realistic Idle City: Chemical / Petroleum / Fertilizer / Rubber / Batteries Spec"
version: "v0.1"
scope: "Late industrial -> chemical/mechanical modern city"
status: "Design spec"
date: "2026-04-09"
---

# 1. Purpose

This document defines the **chemical / petroleum / fertilizer / rubber / batteries layer** of the game.

It bridges the gap between:
- electrified industrial infrastructure
- machine tools / standardization / interchangeable parts
- steam/coal factories and heavy metallurgy

and the next stage of society:
- internal-combustion vehicles
- modern farm equipment
- lubricated, sealed, hose-driven machinery
- high-yield fertilizer-supported agriculture
- tire and battery supply chains
- modern coatings, fuels, and maintenance ecosystems

This document is meant to be used together with:
- the main design progression
- industrial utilities / electrification
- metallurgy / mining / fuel chain
- machine tools / standardization / interchangeable parts
- water / sanitation / utilities
- agriculture & domestication expansion
- trade / market / exchange
- logistics / hauling / storage flow

---

# 2. Era placement

This layer belongs mainly to the transition from:

- **Electrified Industrial City**
to
- **Chemical / Mechanical Modern City**

The design logic is:

1. heavy industry makes steel, machinery, rails, pumps, boilers, machine tools, and electric systems
2. chemical industry unlocks **fuel refinement, synthetic materials, industrial fertilizer, batteries, paints/coatings, acids, alkalis, and process gases**
3. those enable reliable internal-combustion transport, mechanized agriculture, sealed/hydraulic systems, and broader consumer/industrial product diversity
4. modern logistics and maintenance become much more dependent on **specialized consumables**, not just structural parts

This layer should feel like:
> “the city stops being only mechanical and becomes chemically organized.”

---

# 3. Design stance

## 3.1 Main realism law

A tractor, truck, generator set, electric substation backup system, or modern farm does not depend only on metal parts.

It also depends on:
- fuels
- lubricants
- coolants
- batteries
- insulation
- hoses
- seals
- tires
- coatings
- cleaning chemicals
- fertilizers
- controlled process chemistry
- packaging and safe storage
- trained chemical and maintenance labor

## 3.2 What this layer adds to gameplay

Compared with earlier industrial play, this layer adds:

- more **consumable dependencies**
- more **hazard management**
- more **storage restrictions**
- more **environmental and contamination burdens**
- more **supply-chain sensitivity**
- greater agricultural productivity, but also greater system fragility

## 3.3 Core player fantasy

The fantasy is not “unlock chemistry.”

It is:
- crude becomes useful fractions
- gas streams become feedstocks
- nitrogen becomes ammonia
- ammonia becomes fertilizers
- rubber becomes tires, seals, belts, hoses
- lead, acid, and separators become batteries
- fuel, oil, batteries, hoses, tires, and spare parts make mechanized life practical

---

# 4. Chemical-industrial families

This layer is best modeled as several interacting industrial families.

## 4.1 Petroleum and fuels
Outputs:
- gasoline
- diesel
- kerosene / heating fractions
- LPG / refinery gases
- lubricating oils
- asphalt / bitumen
- petrochemical feedstocks
- solvents and blending streams

## 4.2 Base chemical intermediates
Outputs:
- process gases
- acids and alkalis
- ammonia
- nitric-acid-related chains later
- sulfur-related products
- coatings and solvents
- cleaning chemicals

## 4.3 Fertilizers
Outputs:
- ammonia
- urea
- ammonium-based fertilizers
- phosphate fertilizers
- potash-based fertilizers
- blended NPK products later

## 4.4 Rubber and elastomers
Outputs:
- tire compounds
- tubes or tubeless sealing systems depending era
- belts
- hoses
- gaskets
- seals
- vibration mounts
- wire insulation support materials in some product lines

## 4.5 Lead-acid batteries
Outputs:
- starter batteries
- stationary backup batteries
- workshop and utility backup banks
- ignition / lighting / controls support for engines and equipment

## 4.6 Paints, coatings, and protective finishing
Outputs:
- anti-rust coatings
- primers
- enamel paints
- industrial coatings
- marked safety surfaces
- preservative oils/compounds

---

# 5. Petroleum refining

## 5.1 Why refining matters

Petroleum refineries convert crude oil into petroleum products used both as fuels and as feedstocks for making chemicals. Refining works through three broad steps: **separation, conversion, and treatment**. Modern refining starts with distillation, then reworks fractions into higher-value or specification-compliant products.

In game terms, refining is what turns “crude oil” from a bulk raw liquid into a usable civilization platform.

## 5.2 Upstream requirements

A functioning refinery chain needs:
- crude oil source or imports
- tank storage
- pumping
- pipe or bulk transport
- water supply
- heat / fuel for process units
- corrosion-resistant equipment maintenance
- trained operators
- laboratory / testing capability
- fire control systems
- sulfur / contaminant handling
- environmental waste handling

## 5.3 Core refinery logic

### A. Separation
Mainly:
- atmospheric distillation
- vacuum distillation in more advanced plants

Outputs are fractions by boiling range.

### B. Conversion
Mainly:
- cracking
- reforming
- hydroprocessing / upgrading
- blending adjustments

This is how heavier or less desirable fractions become higher-value products.

### C. Treatment
Mainly:
- impurity removal
- sulfur reduction
- quality control for finished products
- stabilization and specification matching

## 5.4 Main refinery outputs to model

### Light fuels
- gasoline-range fractions
- LPG / refinery gas
- light naphtha

### Middle distillates
- kerosene
- diesel
- heating fuel

### Heavy products
- heavy fuel fractions
- lubricating stock
- waxes / heavy oils
- asphalt / bitumen

### Petrochemical feedstocks
- naphtha
- aromatic streams
- gas-derived feedstocks
- synthesis-gas-related branches downstream

## 5.5 Game-facing refinery buildings

Minimum chain:
- crude receiving yard / terminal
- storage tank farm
- distillation unit
- process heaters
- treatment unit(s)
- blending / dispatch
- flare / safety systems abstraction
- lab / quality office
- maintenance shop
- firewater and containment systems

Expanded chain:
- cracking unit
- reforming unit
- lubricant finishing
- asphalt section
- petrochemical feedstock dispatch
- sulfur recovery abstraction
- rail / truck / pipeline terminal

## 5.6 Refinery gameplay burdens
- fire and explosion risk
- toxic exposure risk
- contamination spill risk
- shutdowns from poor maintenance
- product imbalance
- storage bottlenecks
- demand mismatch between fractions
- dependence on transport and tank capacity

---

# 6. Petrochemicals and feedstocks

## 6.1 Why petrochemicals matter

Petrochemical feedstocks sit between refining and modern materials.

Ethylene-, propylene-, butadiene-, aromatic-, and synthesis-gas-related streams support:
- plastics
- synthetic rubber
- solvents
- adhesives
- fibers
- coatings
- detergents
- intermediates for many industrial products

## 6.2 Game abstraction recommendation

Do not force the player to model every monomer at the same level.

Use a layered model:

### Tier 1
- petrochemical feedstock (generic)
- aromatic feedstock
- synthesis gas
- solvent stream
- rubber feedstock

### Tier 2
Split only where gameplay payoff is high:
- synthetic rubber feedstock
- plastics feedstock
- paint/solvent feedstock
- ammonia feedstock

## 6.3 Why this matters for later machinery
Petrochemicals support:
- synthetic rubber
- paint/coatings
- sealants and adhesives
- plastics and insulation
- some synthetic fibers
- packaging materials

This is a major reason the late game starts to feel “modern” rather than purely metallic.

---

# 7. Fertilizer chain

## 7.1 Why fertilizer is a major realism gate

Industrial fertilizer is one of the biggest productivity multipliers in agricultural history.

It should not behave like a flat farm upgrade.
It should behave like:
- an energy-intensive industry
- a transport-heavy bulk good
- a knowledge-sensitive input
- a contamination-sensitive material
- a major support for large urban populations

## 7.2 Nitrogen fertilizers

### A. Ammonia
Ammonia production is the core nitrogen gate.

The Haber-Bosch process directly synthesizes ammonia from nitrogen and hydrogen using:
- high pressure
- moderately high temperature
- iron-based catalysts
- substantial energy input

Nitrogen comes from air.
Hydrogen is commonly sourced from natural gas or other hydrocarbon feedstocks, and historically coal has also been used.

### B. Downstream nitrogen products
From ammonia, the game can later produce:
- anhydrous ammonia use
- urea
- ammonium nitrate / nitric-acid-related branches
- ammonium sulfate or blended products
- liquid or granular nitrogen fertilizers

For gameplay, a practical mid-resolution model is:
- ammonia
- urea
- nitrate fertilizer
- blended nitrogen fertilizer

## 7.3 Phosphorus fertilizers

Phosphorus-based fertilizers begin with:
- phosphate rock mining
- acid treatment
- phosphoric acid intermediates
- downstream phosphate fertilizer products

This chain is important because fertilizer realism should not be only nitrogen.

## 7.4 Potassium fertilizers

Potassium-based fertilizers begin with:
- potash source
- processing
- granulation / packaging / blending

This supports a more credible N-P-K system.

## 7.5 Fertilizer gameplay model

Each fertilizer class should have:
- production cost
- storage rules
- transport bulk burden
- crop suitability
- yield effect
- soil effect
- misuse risk
- contamination/runoff burden

## 7.6 Fertilizer realism rules

### Rule 1
Fertilizer does not replace:
- water
- labor
- timing
- soil suitability
- seed quality
- pest management

### Rule 2
Overapplication should have consequences:
- wasted product
- runoff / contamination pressure
- crop damage possibility in some cases
- cashflow loss
- storage hazard if poorly managed

### Rule 3
Nitrogen fertilizer should strongly increase dependence on:
- chemical plants
- energy
- rail/truck logistics
- storage depots
- seasonal planning

## 7.7 Buildings
- ammonia plant
- fertilizer granulation / finishing plant
- acid plant abstraction where relevant
- bulk fertilizer warehouse
- fertilizer bagging line
- rail/truck loading depot
- farm supply dealer
- agronomy/testing office later

---

# 8. Rubber and elastomers

## 8.1 Why rubber matters

Rubber is not just “for tires.”

It is critical for:
- tires
- tubes
- belts
- hoses
- seals
- gaskets
- mounts
- dampers
- some insulation-support uses
- conveyor systems
- protective wear items

Without elastomers, modern machines leak, slip, vibrate badly, and fail much faster.

## 8.2 Natural rubber

Commercial natural rubber comes primarily from **Hevea brasiliensis** latex.

Game implications:
- it is geographically constrained
- many societies must import it
- it creates trade dependence
- it is not automatically available just because the city is industrial

If your map/region is not tropical or connected to trade, natural rubber availability should be limited.

## 8.3 Synthetic rubber

Synthetic rubber is derived from petroleum and natural gas feedstocks and became industrially important because it could substitute for natural rubber and be tuned for different properties.

This is the major late-game route for:
- tire compounds
- hoses
- belts
- gaskets
- seals
- specialized elastomer products

## 8.4 Vulcanization

Rubber is not useful at industrial scale without curing/vulcanization.

Vulcanization improves:
- tensile strength
- abrasion resistance
- swelling resistance
- elastic behavior across a wider temperature range

In gameplay, vulcanization should be a real processing step, not assumed.

## 8.5 Rubber product families

### Tire compounds
Need:
- natural and/or synthetic rubber
- reinforcing fillers
- sulfur/curing system
- textile and/or steel reinforcement
- controlled mixing
- molding and curing

### Hose and belt products
Need:
- elastomer compounds
- reinforcement layers
- dimension control
- pressure/heat ratings

### Seals and gaskets
Need:
- shaped cured elastomer
- tighter quality control
- compatibility with oils, fuels, heat, or water depending use

## 8.6 Buildings
- rubber compounding shop
- mixing room
- curing/vulcanization section
- tire works
- hose and belt shop
- gasket/seal shop
- reinforcement stock area
- test lab / quality station

## 8.7 Gameplay burdens
- strong dependence on additives and feedstocks
- quality-sensitive batch errors
- fire/toxic-smoke risk
- storage sensitivity for some compounds
- labor specialization
- imported natural rubber dependence in many regions

---

# 9. Lead-acid batteries

## 9.1 Why batteries matter in this stage

Batteries support:
- starter-lighting-ignition systems
- engine starting
- backup power
- utility control systems
- workshop resilience
- vehicle electrical systems
- communication and alarm systems
- substation/plant emergency support later

In a realism-first game, batteries should be a major reason electrified and engine-based society becomes maintainable.

## 9.2 Battery fundamentals

A battery stores energy chemically and releases it on demand through:
- two electrical terminals/electrodes
- an electrolyte
- an external circuit
- ion movement inside and electron flow outside

For the specific lead-acid family:

- positive plate: lead dioxide
- negative plate: spongy lead
- electrolyte: sulfuric acid
- casing and separators complete the assembly

## 9.3 Why lead-acid fits this era

Lead-acid is the right first major battery family for this design layer because it is:
- historically important
- rechargeable
- widely used in vehicles and backup systems
- deeply tied to industrial lead, sulfuric acid, plastic/casing, and recycling systems
- suitable for starter and stationary roles

## 9.4 Lead-acid production chain

Needs:
- lead production and refining
- sulfuric acid supply
- plate/grid manufacture
- active-material preparation
- separators
- casing manufacture
- assembly
- electrolyte filling
- charging/formation
- testing
- distribution

## 9.5 Battery gameplay model

Track at least:
- capacity
- charge state
- aging
- sulfation-like degradation abstraction
- temperature sensitivity
- maintenance state (if flooded type)
- replacement cycles
- recycling return value

## 9.6 Battery product classes

### Starter batteries
Primary uses:
- engine starting
- lighting/ignition
- vehicle controls

### Stationary backup batteries
Primary uses:
- substations
- telecom
- workshops
- emergency lighting/control
- pump stations

### Utility-scale banks later
Can be modeled later if desired.

## 9.7 Hazards and environmental issues
Lead-acid batteries contain:
- large amounts of lead
- sulfuric acid electrolyte
- high short-circuit energy potential

Gameplay consequences:
- storage hazard
- acid spill hazard
- toxic contamination
- recycling necessity
- transport rules
- worker protection requirements

## 9.8 Recycling
Battery recycling should matter a lot.

Reasons:
- recovered lead reduces virgin mining demand
- cases/plastic can be recovered
- old batteries have real value
- hazardous disposal should be unacceptable or strongly punished

This makes batteries a strong “circular industry” candidate inside the game economy.

## 9.9 Buildings
- battery plate/grid shop
- battery assembly plant
- acid handling area
- formation/charging room
- battery warehouse
- battery testing station
- battery recycling / breaker yard / secondary lead link
- return-deposit or core-return system later through market institutions

---

# 10. Lubricants, coolants, and maintenance chemicals

## 10.1 Why this family matters

Machines do not become modern just because they have metal precision.

They become modern because they can be **run repeatedly without destroying themselves**.

That requires:
- lubricating oil
- gear oil
- hydraulic fluid
- grease
- coolants
- cleaning fluids
- rust preventives
- solvents
- fuel additives / specialty fluids later

## 10.2 Gameplay significance
This family should drive:
- ongoing maintenance demand
- workshop supply chains
- service garages
- spare-parts + fluid bundles
- downtime if fluids are missing
- failure acceleration if wrong fluid is used

## 10.3 Product families
- engine oil
- transmission / gear oil
- hydraulic fluid
- bearing grease
- coolant
- cleaning solvent
- rust preventive
- paint thinner / coating support chemicals

## 10.4 Buildings
- lubricant finishing / packaging
- drum filling / packaging line
- industrial chemical store
- service depot
- fleet maintenance supply depot

---

# 11. Paints, coatings, and corrosion control

## 11.1 Why coatings matter
Coatings are not cosmetic fluff.

They protect:
- steel structures
- tanks
- pipes
- tractors
- tools
- water towers
- vehicles
- machine housings
- agricultural equipment
- exposed fittings

## 11.2 Gameplay role
Coatings should influence:
- corrosion rate
- weather durability
- sanitation/cleanability
- equipment lifespan
- storage life
- visual marking / safety coding

## 11.3 Product families
- primer
- anti-rust coating
- machinery enamel
- industrial protective coating
- tank/pipe coating
- marking paints

---

# 12. Cross-industry dependency map

## 12.1 Petroleum -> fuels -> vehicles
Crude oil
-> refinery
-> diesel / gasoline / lubricants
-> fuel depot
-> engine fleet / tractors / trucks / generators

## 12.2 Petroleum -> feedstocks -> rubber / coatings / solvents
Crude oil or gas streams
-> petrochemical feedstocks
-> synthetic rubber / solvents / coatings / plastics branches
-> tires / hoses / belts / gaskets / paint systems

## 12.3 Air + hydrocarbon feedstock -> ammonia -> fertilizer
air separation abstraction + hydrogen source
-> ammonia plant
-> nitrogen fertilizer products
-> farms
-> higher yields / larger supported population

## 12.4 Lead + sulfuric acid -> batteries -> electrified mobility and resilience
lead refining + acid supply + casing/separators
-> lead-acid battery assembly
-> vehicle starting + backup systems
-> workshops / substations / pumps / communications

## 12.5 Refinery + rubber + battery + machine shop + fuel depot -> tractor ecosystem
This is the late-game payoff chain:
- diesel
- lubricants
- battery
- tires
- hoses/seals
- paints/coatings
- standardized repair parts
- service garage
- trained mechanics

---

# 13. Buildings and districts

## 13.1 Recommended district separation

Because of fire, odor, contamination, and transport burden, these industries should not sit in the camp core or dense residential zone.

Use district logic:

### Petroleum district
- refinery
- tank farm
- flare/safety abstraction
- dispatch yard

### Chemical district
- ammonia/fertilizer
- acid/alkali support
- solvent/coating works

### Rubber district
- mixing
- curing
- tire works
- hose/belt works

### Battery district
- lead handling
- acid handling
- assembly
- charging/formation
- recycling intake

### Support district
- industrial lab
- fire station
- maintenance shop
- rail/truck terminal
- hazardous storage yard
- wastewater / containment support

## 13.2 Shared infrastructure requirements
- abundant water
- reliable power
- freight access
- hazardous-material storage
- trained maintenance
- emergency response
- waste/byproduct handling
- environmental monitoring abstraction later

---

# 14. NPC roles

## 14.1 Petroleum and fuels
- refinery operator
- distillation technician
- process operator
- tank farm worker
- dispatch planner
- maintenance fitter
- industrial fire/safety crew
- lab technician

## 14.2 Fertilizer and chemicals
- chemical engineer
- ammonia plant operator
- fertilizer blender / granulation worker
- acid-handling technician
- warehouse operator
- agricultural input planner

## 14.3 Rubber
- compound mixer
- curing operator
- tire builder
- hose/belt fabricator
- mold technician
- rubber quality inspector

## 14.4 Batteries
- grid/plate worker
- battery assembler
- acid technician
- formation-room operator
- battery tester
- recycling worker
- hazardous-material handler

## 14.5 Maintenance and support
- industrial electrician
- instrumentation/control technician later
- mechanic
- environmental/sanitation specialist
- scheduler
- procurement clerk
- fleet manager

---

# 15. Hazards, pollution, and safety

## 15.1 Petroleum hazards
- fire
- explosion
- toxic vapor
- spill / soil contamination
- tank leak
- high-heat process accidents

## 15.2 Chemical/fertilizer hazards
- corrosives
- toxic inhalation or contact hazards
- pressurized equipment risks
- runoff and water contamination
- dust or granule handling issues

## 15.3 Rubber hazards
- fire
- smoke
- solvent exposure
- hot-curing equipment injuries
- additive handling hazards

## 15.4 Battery hazards
- acid burns
- lead exposure
- short-circuit / spark / explosion risk
- charging-gas risk abstraction
- contamination from poor disposal

## 15.5 Why safety matters in gameplay
This layer should strongly reward:
- zoning
- ventilation
- training
- PPE abstraction
- inspection
- emergency planning
- recycling discipline
- spill control
- worker assignment quality

---

# 16. Trade and logistics implications

## 16.1 Trade intensity increases sharply here
This layer is one of the strongest arguments against full autarky.

A realistic city may import:
- crude oil
- phosphate rock
- potash
- natural rubber
- additives
- catalysts
- sulfur
- lead concentrates
- specialized casings or separator materials
- tires or battery cores

## 16.2 Bulk goods and storage
Important stored goods:
- crude oil
- refined fuels
- asphalt/bitumen
- ammonia/fertilizer products
- sulfuric acid
- rubber stock
- battery cores
- lubricant drums

This means:
- tank storage
- dry covered warehouses
- hazardous-material yards
- return-loop logistics
- rail or truck dispatch
- contamination containment

## 16.3 Seasonal ties
Fertilizer and fuel systems should be strongly seasonal in demand:
- farm season fuel spikes
- fertilizer distribution windows
- harvest transport fuel demand
- winter heating / cold-start / maintenance burdens
- spring equipment-prep battery demand

---

# 17. Knowledge and training gates

## 17.1 Required knowledge families
- chemical process knowledge
- pressure/temperature safety
- fluid handling knowledge
- contamination control
- industrial measurement and testing
- quality assurance
- maintenance chemistry
- agricultural input knowledge

## 17.2 Training pathway
A believable route:
1. operator assistance
2. supervised line work
3. hazard and procedure training
4. specialist process certification / institutional training
5. lab and troubleshooting roles
6. supervisory/engineering roles

## 17.3 Why codified knowledge matters here
This layer should rely much more on:
- checklists
- standard operating procedures
- measurements
- labels
- storage rules
- inspection logs
- maintenance records
- specification testing

It is one of the clearest transitions from craft society to procedure-governed industrial society.

---

# 18. Stage progression within this layer

## Stage A — Fuel and lubricant dependency
The city first gains:
- reliable refined fuels
- basic lubricant products
- fuel depots
- service economy for generators, engines, and fleets

## Stage B — Ammonia and fertilizer
The city then gains:
- industrial nitrogen fertilizer
- higher crop support
- denser urban support capacity
- stronger farm-input logistics

## Stage C — Rubber and battery support
Now the city can sustain:
- tire systems
- better hoses/seals/belts
- starter batteries
- backup electrical systems
- more reliable transport and mobile machinery

## Stage D — Integrated mechanical modernity
Now tractors, trucks, generator sets, electric pumps with backup, service garages, and large-scale mechanized agriculture become sustainable.

---

# 19. Gameplay recommendations

## 19.1 Do not reduce this layer to one unlock
Avoid:
- “unlock petrochemicals”
- “unlock fertilizer”
- “unlock tires”
- “unlock batteries”

Instead require multiple enablers and visible subchains.

## 19.2 Use strategic shortages
This layer becomes interesting when shortages create believable bottlenecks:
- diesel shortage
- battery shortage
- tire shortage
- fertilizer shortage
- lubricant shortage
- sulfuric acid shortage
- natural rubber import interruption

## 19.3 Favor service ecosystems
The most realistic late-game feel comes from support institutions:
- fuel depots
- parts counters
- tire service
- battery exchange/recycling
- farm supply stores
- industrial maintenance shops
- fleet garages
- testing labs

## 19.4 Let agriculture depend on this layer without becoming trivial
Mechanized agriculture should require:
- fuel
- tires
- battery
- fluids
- fertilizer
- spare parts
- trained operators
- road access
- repair capacity

That is much more believable than a flat “+yield” bonus.

---

# 20. Suggested data schema

## 20.1 Item families
For each product define:
- name
- category
- hazardous class
- storage class
- transport class
- state (liquid / gas / solid / bulk / packaged)
- shelf life / degradation
- contamination sensitivity
- production chain
- downstream uses
- waste/byproduct notes
- recycling value if relevant

## 20.2 Process records
For each process define:
- inputs
- outputs
- byproducts
- labor roles
- energy/fuel demand
- water demand
- tools/buildings required
- heat/pressure class
- hazard class
- quality/failure states
- environmental burden

## 20.3 Building records
For each facility define:
- footprint
- district suitability
- fire risk
- contamination risk
- ventilation need
- storage interfaces
- staffing
- maintenance burden
- utility requirements
- emergency response need

---

# 21. Transition gate to later modern systems

A city should not be considered fully in the chemical/mechanical modern stage until it can sustain, at minimum:

- reliable refined fuel output or imports
- lubricant supply
- battery production or secure battery trade/recycling loop
- tire / elastomer supply or imports
- fertilizer supply chain
- chemical storage and hazard management
- service garages / fleet maintenance
- agricultural mechanization support
- industrial recordkeeping and quality control

Only after this does it make sense to push further into:
- mass motorization
- advanced consumer chemistry
- modern plastics expansion
- large tractor/manufacturing ecosystems
- broader modern retail and distribution networks

---

# 22. References

- U.S. Energy Information Administration (EIA), “Refining crude oil: the refining process.”  
  Refineries convert crude oil into fuels and chemical feedstocks; refining follows separation, conversion, and treatment steps.

- U.S. Energy Information Administration (EIA), “Refining crude oil inputs and outputs.”  
  Refinery outputs depend on crude characteristics and process complexity.

- Encyclopaedia Britannica, “Petrochemical.”  
  Petrochemical feedstocks support products such as plastics, solvents, synthetic rubber, adhesives, and ammonia-related chemistry.

- Encyclopaedia Britannica, “Haber-Bosch process.”  
  Industrial ammonia synthesis combines nitrogen and hydrogen at high pressure and elevated temperature using an iron-based catalyst.

- International Fertilizer Association (IFA), “Nitrogen, Phosphorus, Potassium plant nutrients.”  
  Nitrogen fertilizers derive mainly from ammonia; phosphorus comes from phosphate rock processing; potassium from potash.

- U.S. Department of Energy, “DOE Explains…Batteries.”  
  Batteries store energy chemically and release it through external-circuit electron flow and internal ion movement.

- U.S. EPA / transboundary-lead-acid guidance.  
  Lead-acid batteries contain plastic casings, lead-based plates, and sulfuric acid electrolyte.

- U.S. EPA battery management / collection resources.  
  Lead-acid batteries should be recycled; recovered lead and plastics are valuable industrial inputs.

- Encyclopaedia Britannica, “Rubber,” “Synthetic rubber,” and “Vulcanization.”  
  Natural rubber comes mainly from latex of Hevea brasiliensis; synthetic rubber derives from petroleum and natural gas; vulcanization improves strength, abrasion resistance, and temperature behavior.

- U.S. Tire Manufacturers Association, “Tires 101.”  
  Tires rely on natural rubber, synthetic polymers, steel, textiles, fillers, antioxidants, and curing systems.
