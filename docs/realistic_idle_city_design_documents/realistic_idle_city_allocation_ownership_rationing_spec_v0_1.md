---
title: "Allocation / Ownership / Rationing Spec"
version: "v0.1"
scope:
  - "Lone Survivor"
  - "Primitive Camp"
  - "Permanent Camp"
  - "Tiny Hamlet (3–8 NPCs)"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
status: "Companion document to the design, NPC, task, item, process, building, settlement, knowledge, and social/recruitment specs."
---

# Allocation / Ownership / Rationing Spec v0.1

## Purpose of this document

This document defines the **resource-governance layer** for the early game.

The project already has:
- NPC body and morale simulation
- task selection logic
- item/material definitions
- process definitions
- building/structure definitions
- settlement stage thresholds
- knowledge/discovery rules
- social/recruitment rules

What was still missing is the answer to questions like:

- When does something belong to one NPC versus the camp?
- What should always remain communal?
- Which goods must be protected from everyday consumption?
- How should food, water, tools, bedding, clothing, containers, and seed be issued?
- What happens when stock becomes scarce?
- How should fairness, trust, and explanation affect compliance?
- What makes a rationing system feel believable rather than arbitrary?
- How should this be stored in data later for Godot?

This spec is focused on the same early slice already established elsewhere:

- **State 0 — Lone Survivor / emergency site**
- **State 1 — Primitive Camp**
- **State 2 — Permanent Camp**
- **State 3 — Tiny Hamlet / proto-settlement**

It is intentionally practical.  
The goal is not to simulate modern law or economics. The goal is to create a realistic early-settlement system in which **scarce goods are governed, reserves are protected, and social trust is preserved**.

---

# 1. Relationship to the existing design set

This document assumes the following are already established elsewhere:

- NPCs care about fairness, food quality, warmth, shelter, hygiene, rest, status, and confidence in leadership.
- Settlement growth is constrained by calories, potable water, shelter, sanitation, and social stability.
- The early game is explicit and material: one meal, one hide, one pot, one sleeping place, and one water container matter.
- Camps and hamlets only count as stable when they maintain storage, reserves, sanitation, and recurring production.
- Knowledge is not a flat tech tree; reliable practice, explanation, and institutional memory matter.
- Recruitment is mixed and socially contingent: newcomers join, stay, and integrate only if the group is materially and socially viable.

This document answers a different question:

> Given a real small settlement with limited goods, how are access, custody, use, reserves, and emergency restrictions handled?

---

# 2. High-level design stance

## 2.1 Ownership is not binary

In a realism-first early settlement, property is not best modeled as just:
- **personal**, or
- **communal**

A more realistic model is **layered access and obligation**.

An item can be:
- physically carried by one person
- regularly used by one person
- still considered camp property
- locked away from ordinary use
- reserved for seed, emergency, or care
- temporarily loaned
- socially "theirs" but reassignable under emergency conditions

That distinction matters enormously.

Example:
- A stone knife used daily by one hide worker may be **personally issued** but still reclaimable by the camp.
- A water pot assigned to one shelter cluster may be **household-use** but not free for personal trade.
- A seed basket may sit in a storehouse but be **untouchable** for ordinary meals.
- Firewood gathered by one NPC may enter the **communal fuel pile**, not become private wealth.

## 2.2 Early society is usually mixed, not pure-communal or pure-private

The most believable early-game model is a **mixed regime**:
- **body-bound and intimate items** trend personal
- **mission-critical goods** trend communal
- **strategic reserves** are protected from everyday use
- **issued tools and work kits** sit in a middle zone
- **food distribution** becomes increasingly governed as population rises

That gives realism without requiring a modern legal code.

## 2.3 Allocation is part survival, part legitimacy

A camp can physically survive and still socially destabilize if allocation feels:
- arbitrary
- opaque
- disrespectful
- biased
- wasteful
- unsafe

So the game should treat allocation as both:
- a **material survival system**
- a **social trust system**

## 2.4 Rationing is not only about starvation

Rationing should not appear only when famine has already begun.

Realistic rationing starts earlier as:
- reservation of seed
- preservation of breeding stock later
- restriction of high-value tools to appropriate tasks
- safeguarding fuel before storms or winter
- protecting clean water when contamination risk rises
- reducing waste and spoilage when resupply is uncertain

---

# 3. Research anchors informing this spec

This spec is guided by a few strong real-world principles:

1. **Basic survival needs are not identical for every person or context.**  
   Humanitarian guidance commonly uses average food-energy baselines such as about **2,100 kcal/person/day** for planning, while also recognizing that needs vary and that some groups require additional support. [R1]

2. **Water allocation is not just "drink when thirsty."**  
   Basic survival water planning uses minimum ranges such as roughly **7.5–15 liters/person/day** for drinking, food preparation, and hygiene, and emphasizes safe household storage. [R2]

3. **Seed is not ordinary food stock.**  
   FAO material repeatedly stresses that seeds are fragile living organisms whose viability depends on moisture, temperature, and handling. Treating seed as just another edible stock is unrealistic. [R3][R4]

4. **Fair process increases acceptance and co-operation.**  
   OECD material on trust and fairness shows that when people feel they have been treated fairly, heard, respected, and given explanations, they are more likely to accept decisions and co-operate even when outcomes are painful. [R5]

5. **Social connection is protective and operationally important.**  
   CDC material supports the idea that belonging, supportive relationships, and perceived care matter for resilience, health, and capacity to cope with stress. [R6]

6. **Fatigue impairs attention, memory, and judgment.**  
   This matters because tired leaders and tired workers make worse allocation decisions, miscount stock, and violate rationing discipline more easily. [R7]

7. **Common-property regimes often emerge to regulate use and exclude outsiders.**  
   FAO material on collaborative management notes that common-property systems can emerge specifically to control access, regulate member use, and protect stressed resources. [R8]

These are enough to justify a realistic early-settlement system built around:
- differentiated access rights
- protected reserves
- needs-aware distribution
- transparent rules
- trust-sensitive enforcement

---

# 4. Core concepts

## 4.1 Ownership vs possession vs access

The game should separate these ideas:

### Ownership
The social or institutional claim over an item, place, or stock.

### Possession / custody
Who physically has it right now.

### Access
Who is allowed to use it.

### Consumption right
Who is allowed to eat, drink, burn, wear out, or otherwise deplete it.

### Issue right
Who is allowed to assign it to others.

### Reserve protection
Whether the item is intentionally shielded from ordinary use.

### Reassignment
Whether the camp can reclaim or redirect it when needs change.

This lets the simulation handle realistic cases such as:
- "This bedroll is yours unless someone is critically exposed."
- "This knife is assigned to you for work, but it belongs to the camp."
- "This seed grain may be touched only by designated seed handlers."
- "This smoked meat batch is communal, but priority goes to the sick first."
- "This pot is stored in the cook yard and cannot leave camp without approval."

## 4.2 Access rights bundle

Each stock or item should eventually support a rights bundle such as:

- **observe** — can see it in UI / knows it exists
- **retrieve** — can physically take it from storage
- **carry** — can transport it
- **use** — can use it for a process without destroying it
- **consume** — can deplete it
- **issue** — can assign it to someone else
- **reserve** — can lock it from normal use
- **borrow** — can temporarily take it under return rules
- **maintain** — can repair/clean it
- **reassign** — can transfer standing assignment
- **trade/gift** — can intentionally move it out of the camp economy
- **discard** — can mark it as waste/salvage

Not every right needs to be fully simulated immediately, but the design should assume they exist.

---

# 5. Ownership classes for the early game

## 5.1 Wild / unclaimed
Things still in the world:
- standing wood
- wild edible plants
- loose stone
- surface clay
- water in stream/pond
- roaming animals

These are not yet part of camp inventory.

## 5.2 Claimed but not yet stored
Things gathered or produced but still in transit:
- bundle of brush
- filled water skin or pot being carried
- carcass on a drag
- harvested seeds not yet sorted
- wet hide brought back to camp

These are vulnerable to spoilage, loss, theft, and interruption.

## 5.3 Personal intimate goods
These are the strongest early candidates for personal assignment:
- worn clothing
- footwear
- body wraps
- sleeping layer / bedding
- personal eating bowl/cup if available
- personal keepsake later
- body-bound medicine/hygiene items later

These should usually not be freely shuffled unless there is crisis.

## 5.4 Personal issued tools
These are durable work items normally assigned to one NPC but still camp-reclaimable:
- knife
- scraper
- awl
- carrying sling
- basket
- digging stick
- fire kit
- waterskin
- seed bag
- hide-working stone set
- harvesting knife later

This category is ideal for:
- role fit
- maintenance accountability
- wear tracking
- morale/status effects

## 5.5 Household / bedspace goods
Once more than one NPC exists, some things belong neither strictly to one person nor to the entire camp:
- shelter bedding bundle
- hearth-side cooking set
- wash container
- shared food bowl
- shelter water pot
- family/bedspace clothing cache later

This becomes more important in permanent camp and hamlet stages.

## 5.6 Worksite inventory
Goods tied to a work area:
- cook hearth pot
- hide yard scraping beam
- clay pit digging tools
- seed sorting mats
- drying rack inventory
- smoking frame hooks/poles
- wood processing zone fuel stack
- sanitation tools

These are not meaningfully personal and should be difficult to appropriate privately.

## 5.7 Communal stock
Core shared stock:
- most staple foods
- bulk fuelwood
- common fiber stock
- clay stock
- repair materials
- communal containers
- building materials
- spare basic tools
- most preserved food
- most haulable water stock once settlement size increases

## 5.8 Strategic reserve stock
Stock intentionally protected from ordinary use:
- storm reserve firewood
- winter reserve food
- drought reserve water
- emergency medical/clean cloth stock later
- reserve containers
- tool repair reserve materials
- travel/emergency pack reserve

## 5.9 Reproductive reserve stock
Stock that must not be casually consumed because it reproduces future capacity:
- seed stock
- seed tubers
- breeding animals later
- young livestock later
- tool molds/patterns later
- rare propagating plant stock

This category is one of the most important realism systems in the game.

## 5.10 Care reserve stock
Stock reserved for people in special need:
- easily prepared food for the sick/injured
- extra bedding and insulating layers
- clean water priority stock
- medicinal herbs / wound dressings later
- postpartum/child-care support stock later

Even if the first playable mostly features adults, the system should support this category from the start.

## 5.11 Waste / salvage stock
Not useless, but not in prime circulation:
- cracked pot shards
- dull broken stone edges
- short cordage lengths
- damaged basket material
- bone scraps
- ash
- charcoal fines
- spoiled food not safe for human consumption
- scrap hide pieces

This matters because realistic camps re-use and down-cycle materials.

---

# 6. Default ownership stance by category

## 6.1 Food

### Usually communal
- gathered staple plants
- bulk meat
- bulk fish
- smoked/dried food
- cooked batch meals
- grain/seed for meals once separated from seed reserve

### Usually personal-in-use but not necessarily owned
- individual carried meal portion
- packed field ration
- one person's drinking vessel contents

### Never ordinary-consumption stock
- seed reserve
- trial planting reserve
- emergency reserve unless ration state permits release

## 6.2 Water

### Usually communal at stock level
- stored clean water
- boiled water in camp containers
- emergency reserve water

### Personal at point of carriage/use
- filled cup
- carried pot/skin on a task
- personal field water issue

Water should rarely become "private property" in a viable settlement.

## 6.3 Clothing and bedding

### Usually personal
- wraps
- footwear
- sleeping insulation
- body layers
- weather layers

### Reassignable in emergency
- spare cloak
- reserve bedding
- guest bedding
- recovered clothing from dead/absent NPCs

## 6.4 Tools

### Usually issued, not absolutely private
A tool should generally have:
- a primary assignee
- a current custodian
- a camp-level owner
- a reclaim condition

This prevents unrealistic hoarding while preserving role identity.

## 6.5 Containers

### Depends on use
- personal carry basket → often issued
- cook pot → communal/worksite
- shelter water pot → household
- seed jars/pots → protected reserve inventory
- refuse baskets → worksite / sanitation category

## 6.6 Shelter and sleep space

### Not owned like inventory
Sleep space should be treated as:
- assigned
- claimable
- revocable
- privacy-sensitive
- comfort-relevant

A person can have an assigned shelter spot without "owning" the building.

## 6.7 Land and plots

In the early slice, land is best treated as:
- **camp-controlled use rights**
- not market property

Examples:
- garden plot assignment
- workyard access
- sanitation exclusion zones
- path rights
- water-fetch zone protection
- clay extraction zone rules

---

# 7. Early-stage resource governance by settlement stage

## 7.1 State 0 — Lone Survivor

There is no social ownership problem yet.

Default rule:
- everything is effectively under one-person control
- but the design should still distinguish:
  - immediate-use stock
  - reserve stock
  - reproductive stock
  - work-in-progress stock

Even one person should already face the classic mistake:
> eating tomorrow's seed / burning tomorrow's shelter material / using the only pot for the wrong task

Important early reserve distinctions:
- edible now vs seed later
- dry fuel vs green brush
- potable water vs dirty water waiting treatment
- fresh hide vs hide already committed to clothing
- structure wood vs burnable scrap

## 7.2 State 1 — Primitive Camp

The second person or first recurring visitor introduces social governance.

Default rule:
- high-importance goods trend communal
- intimate goods remain personal
- tools become assigned but reclaimable
- food and water become more centrally visible

This is the stage where the game should introduce:
- named stockpiles
- reserve flags
- issue records
- basic ration state

## 7.3 State 2 — Permanent Camp

Default rule:
- communal stores become the norm for critical goods
- household or shelter-level issue begins
- reserve categories become formal
- access rights matter more
- stock accounting becomes part of leadership legitimacy

At this stage, the camp should clearly distinguish:
- today's working stock
- meal stock
- reserve stock
- seed stock
- fuel reserve
- issue stock
- salvage stock

## 7.4 State 3 — Tiny Hamlet

Default rule:
- full mixed regime
- personal items, issued tools, household goods, worksite inventory, communal stores, and protected reserves all coexist

This is the first stage where a realistic hamlet should need:
- a designated stock manager, cook, or storekeeper role
- explicit issue rules
- return rules for tools and containers
- ration policies visible to the player
- dispute handling over hoarding, unfair access, or misuse

---

# 8. Reserve doctrine

## 8.1 Why reserve doctrine matters

A camp without reserves may survive a normal day and still collapse from:
- two rainy days
- one illness cluster
- one failed hunt
- one broken pot
- one spoiled food batch
- one cold snap
- one missed planting window

So reserve doctrine is one of the most important parts of realistic progression.

## 8.2 Reserve classes

### A. Working stock
What can be used freely for ordinary current tasks.

### B. Daily meal stock
What can be consumed in the current meal cycle without special approval.

### C. Short-term buffer
What protects the next few days of operations.

### D. Strategic reserve
What should not be touched unless threshold rules allow it.

### E. Reproductive reserve
Seed / breeding / propagation stock.

### F. Care reserve
Protected stock for injury, illness, weakness, exposure, or vulnerable bodies.

### G. Ceremony / morale reserve later
Not a priority yet, but realistic later for festivals, gifts, hospitality, or mourning.

## 8.3 Seed reserve is sacred by default

The design should strongly bias against casual seed consumption.

Rules:
- seed stock is physically separated
- seed stock is visually labeled
- only designated handlers can issue it
- seed stock has viability and cleanliness scores
- seed stock should not enter meal logic unless the settlement is crossing into genuine desperation

Even then, eating seed should feel like trading away future security.

## 8.4 Fuel reserve is nearly as important as food reserve

In a temperate environment, fuel is a survival reserve because it affects:
- warmth
- water safety
- cooking
- drying
- smoking
- hide work
- morale
- night safety

The camp should maintain:
- active burn pile
- dry reserve
- storm reserve if possible

## 8.5 Clean water reserve

The camp should distinguish:
- untreated water
- questionable water
- boiled/safer water
- emergency clean reserve

Using clean water for low-priority dirty tasks should be treated as a real allocation mistake.

---

# 9. Rationing philosophy

## 9.1 What rationing means in this design

Rationing is not just:
- "everyone gets less food"

It includes:
- who receives first access
- how much can be consumed
- which stock classes may be opened
- whether tools/containers can leave their stations
- whether fuel use is restricted
- whether work output expectations are lowered
- whether reserve release is permitted
- whether outsiders/guests are fed from normal stores or relief stores

## 9.2 Rationing should be forecast-based, not purely reactive

A believable system looks ahead at:
- days until next reliable harvest/gathering opportunity
- current edible stock by perishability
- current potable water by safety class
- fuel reserve versus weather forecast if simulated
- seed commitment versus planting window
- number of active mouths
- number of impaired workers
- spoilage risk
- known incoming stock

The system should ration before total collapse, not after.

## 9.3 Default ration states

### State A — Open / normal
- normal meal planning
- full tool issue
- routine washing allowed
- reserve remains closed unless flagged otherwise

### State B — Cautious conservation
- reduce waste
- open fewer meal options
- protect premium foods
- review fuel use
- prioritize repair over replacement
- limit nonessential travel with containers/tools

### State C — Controlled rationing
- explicit meal shares
- task-based food scheduling
- higher scrutiny on fuel and water
- reserve release only by rule
- outsiders fed from controlled guest policy
- high-risk low-yield tasks paused

### State D — Emergency rationing
- emergency reserve may open
- seed reserve still protected unless famine threshold crossed
- hygiene water reduced to minimum safe level
- labor assignments shift toward survival and supply only
- morale and trust pressure rise sharply

### State E — Desperation / collapse prevention
- reproductive reserves may be considered for release
- nonessential NPCs may depart, travel, or be denied entry
- mortality/exit risk becomes real
- long-term recovery cost becomes severe

---

# 10. Domain-specific allocation rules

# 10.1 Food allocation

## A. Normal food logic
Food should usually be distributed through:
- batch cooking
- issued portions
- carry rations for field work
- special supplements for people in poor condition

The food system should track:
- calories/energy
- satiety
- spoilage risk
- cooking requirements
- water/fuel cost
- digestibility
- morale/food quality effects
- contamination risk

## B. Baseline share
A planning baseline may use average daily energy needs, but the game should not assume every NPC needs the same exact intake. Humanitarian planning commonly uses roughly 2,100 kcal/person/day as an average benchmark, not a universal exact rule. [R1]

So in simulation, food need should vary with:
- body size
- activity level
- temperature stress
- illness/injury
- pregnancy/lactation later
- age later
- recovery from deprivation

## C. Distribution order during scarcity
Default priority order:
1. those at acute physical risk
2. those whose survival tasks are indispensable today
3. those whose condition is deteriorating fastest
4. general adult population
5. guests/outsiders beyond minimum duty of care
6. luxury or morale foods

This should still be explainable and visible.

## D. Task-linked supplements
In a realism-first system, someone hauling heavy wood in cold rain should not necessarily receive the same ration as someone doing lighter sheltered work all day.

Possible modifiers:
- very heavy labor supplement
- cold-weather supplement
- illness recovery supplement
- pregnancy/lactation supplement later
- child supplement later
- morale food allotment in hard periods

## E. Seed and staple separation
Bulk staple grain should be split into:
- meal grain
- seed grain
- emergency reserve grain

Never pool these invisibly.

## F. Hospitality and guests
The camp should have a policy for:
- emergency feeding of travelers
- probationary guest rations
- reciprocal labor-for-meal arrangements
- refusal thresholds when stores are truly insufficient

This interacts strongly with recruitment and reputation.

# 10.2 Water allocation

## A. Water use categories
Water should be classified into:
- drinking
- cooking
- medicinal/cleaning wounds later
- washing body
- washing utensils
- process water (clay, hide, cleaning dirty zones)
- firefighting/safety
- irrigation later

## B. Drinking-first rule
In scarcity, drinking and essential food preparation outrank:
- body washing
- laundry
- routine cleaning
- process use
- watering nonessential plants

## C. Quality-aware allocation
Not all water is equal.

Possible water classes:
- class 1: safer drinking water
- class 2: boiled but stored less well
- class 3: untreated but relatively clear
- class 4: dirty/process-only
- class 5: contaminated / discard unless retreated

Allocation should choose the lowest adequate quality for the job.

## D. Reserve doctrine
The camp should maintain:
- current-use potable stock
- next-cycle potable reserve
- dirty/process water separately
- transport containers reserved for water when required

## E. Water discipline during rationing
Restrictions may include:
- no casual washing
- no use of potable water for hide soaking or clay work
- fewer trips using fragile containers
- filled containers stored in shade/cover
- issue of personal field water before long tasks

## F. Vulnerability-aware water priority
People with:
- heat stress
- diarrhea/illness
- fever
- severe dehydration
should receive priority attention.

# 10.3 Fuel allocation

## A. Fuel use categories
- water boiling
- cooking
- warming/survival heat
- drying food
- smoking food
- hide processing
- pottery firing
- light
- morale/comfort

## B. Scarcity rule
Fuel should usually go first to:
1. potable water and survival cooking
2. hypothermia/exposure prevention
3. preservation of perishable critical food
4. critical craft that unlocks survival infrastructure
5. comfort/light
6. prestige/nonessential use

## C. Dry fuel is premium
Dry, reliable, high-ignition fuel should be protected more carefully than:
- damp brush
- green wood
- low-grade scrap

## D. Pottery and firing control
Once firing exists, kilns/pit-firings can consume large fuel loads. Those jobs should require explicit allocation, not happen opportunistically.

# 10.4 Tool allocation

## A. Tool issue principle
The best early-game rule is:
- critical tools are camp-owned
- primary assignees are tracked
- responsibility for maintenance follows assignment
- reallocation requires clear reason

## B. Why assignment matters
Tool assignment improves:
- accountability
- speed (NPC knows where their kit is)
- skill development
- maintenance discipline
- morale/status
- conflict reduction

## C. Reclaim triggers
A tool may be reclaimed when:
- the assignee is absent, incapacitated, or dead
- the task priority has shifted sharply
- the camp has too few equivalent tools
- the tool is being misused, hoarded, or neglected
- a survival emergency overrides normal role boundaries

## D. Personal misuse categories
- leaving tool in weather
- using fine edge for rough prying
- taking worksite-only tool out of camp
- hoarding multiple equivalent tools
- failing to return borrowed container

## E. Spare vs primary tools
The camp should distinguish:
- primary issued tools
- shared backup tools
- damaged tools awaiting repair
- reserve tools not for routine use

# 10.5 Clothing, bedding, and thermal goods

## A. Default rule
These are usually personal because:
- fit matters
- comfort matters
- hygiene matters
- exposure risk is body-specific
- social dignity matters

## B. Emergency override
In severe cold or wet exposure, the camp may reallocate:
- dry cloak
- spare blanket
- fur/hide wrap
- shelter bedspace

That should be socially sensitive and possibly morale-costly if handled badly.

## C. Replacement priority
When clothing is scarce, replacement priority should usually go to:
1. exposed/sick NPCs
2. those with no dry sleep layer
3. those doing heavy outdoor work in bad weather
4. general upgrades
5. aesthetic/status preferences

# 10.6 Containers

## A. Containers are force multipliers
They should be governed more strictly than trivial decoration because they control:
- water hauling
- grain storage
- seed viability
- cooking capacity
- sanitation separation
- protection from pests/moisture

## B. Category rules
- water containers: high-control, clean-use rules
- cooking pots: worksite/household issue
- seed containers: reserve-only
- refuse containers: dirty-use only
- carry baskets: issued/shared depending abundance

## C. Cross-contamination rule
A container used for dirty tasks should not instantly become safe for drinking water or seed without cleaning and drying.

# 10.7 Shelter, bedspace, and interior allocation

## A. Bedspace is a real allocation domain
Not everyone should get the same shelter quality automatically.

Important factors:
- dryness
- insulation
- crowding
- smoke exposure
- privacy
- proximity to hearth
- safety from leaks/drips
- vulnerability status

## B. Priority order during scarcity
1. severely exposed or sick
2. weakest or least insulated
3. indispensable workers in recovery
4. established residents by assignment
5. guests / temporary arrivals

## C. Crowding tradeoff
Overcrowding may save people from weather but worsen:
- sleep quality
- infection risk
- smoke load
- conflict
- morale

# 10.8 Seed, planting stock, and future capacity

## A. Protected access
Seed should have:
- special owner class
- special storage rules
- issue permissions
- viability tracking
- contamination tracking
- separate accounting from food

## B. Release policy
Seed may be released for eating only if:
- a formal desperation threshold is crossed
- the player confirms or a severe policy permits
- the simulation records future cost clearly

## C. Trial plot vs staple plot issue
Not all seed is equal:
- staple reserve
- trial/experimental reserve
- local wild transplant stock
- replant stock after losses

---

# 11. Fairness, legitimacy, and enforcement

## 11.1 Why fairness matters mechanically

The game should assume:
- fair and explainable allocation increases compliance
- unfair or opaque allocation increases hoarding, resentment, and refusal
- respectful treatment reduces conflict
- explanation matters even when outcomes are painful

This is strongly supported by trust/fairness literature and fits the existing social-recruitment logic. [R5][R6]

## 11.2 Fairness has two parts

### Outcome fairness
Did the person receive a reasonable share?

### Process fairness
Were they:
- heard
- informed
- treated with dignity
- given a reason
- judged by known rules
- treated similarly to others in similar conditions?

In very small groups, process fairness may matter even more than perfect equality.

## 11.3 Equal shares are not always realistic

A realism-first system should avoid the simplistic rule:
> everyone always gets exactly the same ration

That can be unfair in practice if:
- one NPC is severely dehydrated
- one is injured
- one is hauling all day in winter
- one is pregnant later
- one is ill and needs easy food
- one already consumed more privately

So the system should favor:
- **equal dignity**
- **transparent principles**
- **needs-aware distribution**
rather than blind sameness.

## 11.4 Enforcement modes

### Soft compliance
- reminders
- UI warnings
- social disapproval
- reduced trust

### Structured control
- storage locks/permissions
- issue-only stock
- reserve flags
- designated storekeeper rights

### Crisis enforcement
- emergency reclaim of tools
- closing stockpiles
- controlled meal issue
- suspension of guest feeding
- hard prohibition on seed use

## 11.5 Bad enforcement can also damage trust

A camp can protect stock and still lose cohesion if it:
- humiliates NPCs
- ignores vulnerability
- hides information
- favors insiders unfairly
- punishes without explanation
- changes rules unpredictably

So the player should be encouraged to use:
- clear policies
- visible thresholds
- consistent application
- timely explanations

---

# 12. Conflict, hoarding, and misuse

## 12.1 Misuse categories
- unauthorized eating/drinking from reserve stock
- taking tools without return
- privately hiding food
- trading away camp goods
- using clean water for dirty work
- burning strategic fuel for comfort
- sleeping in unauthorized space
- contaminating shared containers
- carelessly damaging assigned items

## 12.2 Why NPCs might do this
Not always malice.

Possible causes:
- hunger/desperation
- fear of future scarcity
- mistrust
- fatigue/impaired judgment
- poor explanation of rules
- emotional attachment
- misunderstanding of stock class
- self-preservation override

## 12.3 Response ladder
A realistic response ladder should be:
1. detect
2. identify cause
3. restore immediate safety
4. explain/correct
5. repair loss if possible
6. adjust assignment/rules
7. escalate only if repeated or dangerous

This fits the existing social/recruitment emphasis on trust, mentoring, and belonging rather than instantly punitive systems.

## 12.4 Hoarding as signal
Hoarding should often be treated as a symptom that the camp has failed at one or more of:
- trust
- predictability
- reserve visibility
- fairness
- explanation
- care for vulnerable members

---

# 13. Player-facing policy layer

The player should not micromanage every bowl every hour.  
Instead, the player should define policies and exceptions.

## 13.1 Suggested policy categories

### Food policy
- normal communal meals
- task-adjusted meal supplements
- protect preserved food
- open reserve only below threshold
- guest feeding allowed / restricted / emergency only

### Water policy
- potable water only for drinking/cooking
- process water separation required
- reserve water trigger
- personal field-water issue required for long tasks

### Fuel policy
- conserve dry fuel
- reserve storm fuel
- firing jobs require approval
- evening comfort fires allowed / restricted

### Tool policy
- personal issue where possible
- return-to-rack required
- worksite tools locked to area
- emergency reclaim allowed

### Clothing/bedding policy
- dry sleep layer priority
- exposure emergency reallocation allowed
- guests get reserve bedding only

### Seed policy
- no seed consumption
- emergency seed release allowed only at crisis state
- only designated handlers can access seed stock

## 13.2 Policy visibility
To preserve trust, the UI should show:
- current ration state
- reserve levels
- reason for current restrictions
- who has priority and why
- what stock is protected
- what will happen if reserves keep falling

---

# 14. First-playable ruleset recommendation

To keep the first implementation manageable, the earliest working version should include only a subset.

## 14.1 Ownership classes to implement first
- personal intimate goods
- issued tools
- communal stock
- strategic reserve
- seed reserve
- worksite inventory

## 14.2 Domains to implement first
- food
- water
- fuel
- tools
- bedding/clothing
- seed

## 14.3 Ration states to implement first
- normal
- cautious conservation
- controlled rationing
- emergency

## 14.4 First-playable decision rules
1. Food, water, seed, and fuel are never a single undifferentiated pool.
2. Seed is protected by default.
3. Potable water is prioritized over all dirty/process water use.
4. Critical tools are issued, not privately owned.
5. Clothing and bedding are personal unless exposure crisis forces reallocation.
6. Reserve release should always produce morale/trust consequences if handled badly.
7. The player should see who is under-supplied and why.
8. Fair explanation reduces social damage from restrictions.

---

# 15. Data model recommendation

## 15.1 Stock record
Each stockpile or lot should eventually track fields like:

- stock_id
- item_id
- quantity
- quality
- contamination_state
- perishability_state
- reserve_class
- ownership_class
- current_custodian_id
- assigned_to_npc_id
- assigned_to_household_id
- assigned_to_worksite_id
- issue_permissions
- consume_permissions
- can_be_reassigned
- location_id
- intended_use
- current_policy_lock
- spoilage_risk
- morale_value
- trade_allowed
- notes/tags

## 15.2 Allocation rule record
- rule_id
- domain (food/water/tool/etc.)
- settlement_stage_min
- trigger_condition
- priority_order
- exception_groups
- reserve_release_rules
- explanation_text
- trust_modifier_if_applied_fairly
- trust_modifier_if_applied_unfairly

## 15.3 NPC supply state
Per NPC:
- recent_calorie_intake
- hydration_state
- issued_tool_ids
- bedding_quality
- clothing_coverage
- special_need_flags
- ration_priority_score
- compliance_tendency
- perceived_fairness_score
- hoarding_risk
- dependency_on_camp_supply

---

# 16. Example early-game scenarios

## 16.1 One person, first winter rain
Situation:
- little dry fuel
- some damp brush
- one clean water pot
- some gathered food
- one hide being dried

Correct governance logic:
- preserve dry fuel for boiling and sleep warmth
- do not waste pot time on nonessential clay work
- do not burn hide supports for comfort
- protect bedding from dampness
- reduce optional fire use

## 16.2 Two-person primitive camp, poor hunt
Situation:
- one tired hunter
- one healthier gatherer
- low meat stock
- some roots/nuts
- seed basket reserved for first garden plot

Correct governance logic:
- seed basket remains closed
- meal shares may differ slightly by condition and next-day task needs
- reserve food warning appears
- player explanation and visible rule reduce trust loss

## 16.3 Permanent camp before planting
Situation:
- stored grain low
- planting window near
- newcomer guest asks to stay
- one NPC wants to eat from seed lot

Correct governance logic:
- seed remains protected unless collapse threshold crossed
- guest receives controlled probation ration if policy allows
- player may trade labor-for-meals
- attempted seed consumption causes strong trust/process event, not just subtraction of items

## 16.4 Tiny hamlet, illness cluster
Situation:
- two NPCs sick
- clean water limited
- work output falling
- tool repair pending
- fuel moderate

Correct governance logic:
- clean water shifts toward drinking/care
- heavy work expectations reduce
- easy-to-digest food receives priority
- nonessential firing/craft jobs pause
- fair explanation matters because healthy workers may receive less than expected

---

# 17. Rules of thumb for future documents

Going forward, the project should assume:

- **Mission-critical goods trend communal or tightly issued.**
- **Intimate body-use goods trend personal.**
- **Seed and future-capacity stock are not ordinary food.**
- **Reserve logic should be visible, not hidden.**
- **Rationing is a spectrum, not an on/off starvation switch.**
- **Fair explanation is part of enforcement.**
- **Needs-aware distribution is more realistic than blind equality.**
- **A camp that allocates badly can fail socially even before it fails materially.**

---

# 18. Recommended next companion document

The strongest next companion document after this one is:

## Health / Injury / Care Spec v0.1

Because allocation and rationing are now defined, the next missing piece is:
- what conditions create special needs
- how wounds, infection, exposure, diarrhea, exhaustion, and recovery change supply priority
- how care labor interacts with work labor
- what minimum care obligations a stable camp must meet

That would plug directly into:
- ration priority
- care reserve use
- task reassignment
- social trust
- recruitment viability
- settlement progression

---

# References

## Design-stack references
- Existing project documents produced in this conversation, especially:
  - the main design draft
  - early-game bible
  - NPC simulation and data docs
  - task evaluation spec
  - item/material bible
  - process bible
  - building/structure bible
  - settlement progression spec
  - knowledge/discovery spec
  - social/recruitment spec

## External grounding references
- [R1] World Food Programme, *What is a food basket?*  
  Notes the commonly used humanitarian planning benchmark of about 2,100 kcal/person/day and adds specialized nutritious foods for pregnant/breastfeeding women and children under 5 where needed.

- [R2] Sphere Standards, *Friendly Sphere Handbook*  
  Notes a total basic water requirement of roughly 7.5–15 liters/person/day and emphasizes safe household storage.

- [R3] FAO, *Seeds in Emergencies: a technical handbook*  
  Treats seeds as fragile living organisms rather than ordinary stock.

- [R4] FAO, *Seeds in Emergencies: a technical handbook*  
  Notes that temperature/relative humidity are critical in seed storage and that reducing seed moisture content materially improves storage life.

- [R5] OECD, *Trust and Public Policy*  
  Describes fairness in process and outcome as a critical dimension of trust, with fair treatment improving acceptance, compliance, and co-operative behaviour.

- [R6] CDC, *Social Connection*  
  Frames supportive social connection, belonging, and care as important to physical and mental health and to coping with stressful life challenges.

- [R7] CDC/NIOSH, *Fatigue and Work*  
  Notes that fatigue reduces reaction time, attention/concentration, short-term memory, and judgment.

- [R8] FAO, *Collaborative management / common property regimes*  
  Notes that common-property regimes can emerge to regulate use by individual members, exclude outsiders, and protect stressed resources.
