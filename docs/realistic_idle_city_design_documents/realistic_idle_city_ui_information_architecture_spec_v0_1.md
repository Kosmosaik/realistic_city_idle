---
title: "Realistic Idle City - UI / Information Architecture Spec"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet"
author: "OpenAI / ChatGPT"
date: "2026-04-08"
---

# 1. Purpose of this document

This document defines the **user interface and information architecture** for the early playable slice of the project.

It answers these questions:

- what the player must always be able to see
- what the player can inspect on demand
- how information should be grouped
- how orders, policies, priorities, and restrictions are issued
- how warnings and emergencies should be surfaced
- how a minimal top-down presentation can still support a dense, realistic simulation

This is not a visual art style document.  
It is a **functional interface spec** for a realism-first colony simulation with extremely minimal world graphics.

The UI must support a game where:

- the world view is top-down and visually spare
- NPCs may be only a few pixels or dots
- objects can be tiny colored marks, footprints, or simple shapes
- most meaning comes from state, overlays, labels, and inspectors rather than detailed sprites
- the player acts more as a leader/planner than a puppeteer
- the simulation is information-heavy from the beginning

---

# 2. Scope and alignment with the current design stack

This spec is written for the same early slice already established elsewhere in the project:

- one starter NPC
- first-day survival
- primitive camp
- permanent camp
- first extra NPCs
- tiny hamlet with role assignment

The UI therefore focuses on the simulation layers that already matter in that slice:

- body state and survival risk
- tasks and priorities
- hauling and storage locations
- shelters, hearths, and work areas
- food, water, fuel, and reserve stocks
- ownership, access, and rationing rules
- hazards, sanitation, and care
- knowledge/discovery progress
- legitimacy, trust, and social friction

Late-game interfaces for cities, factories, utilities, markets, and mass logistics should be treated as future extensions of this architecture, not solved in full here.

---

# 3. Core UI principles

## 3.1 The player should be able to read the colony at a glance

A good dashboard is a single-page view that shows regularly updated information people must monitor and act on quickly. That is exactly what this game needs for its core screen.

Implication for this project:

- the main screen must function as a **living colony dashboard**
- the player should not need to open 5 windows just to know whether the camp is safe tonight
- the most urgent bottlenecks should be recognizable in a few seconds

## 3.2 The world view should stay visually quiet

Because the world is minimal, the screen should avoid unnecessary decoration.

That means:

- no ornamental UI clutter
- no oversized chrome
- no heavy gradients or fake texture unless it improves readability
- no giant opaque panels covering the map by default
- the map remains the main anchor

The world itself can stay tiny and abstract, but the UI must make the abstraction understandable.

## 3.3 The interface should present **state first, detail second**

The player needs two different reading modes:

1. **scan mode**
   - what is wrong right now?
   - who is in danger?
   - what is blocked?
   - what reserves are threatened?

2. **inspection mode**
   - why is this happening?
   - what inputs are missing?
   - who is assigned here?
   - what policy is causing this?

The default screen should support scan mode.  
Context panels, inspectors, tables, and history views should support inspection mode.

## 3.4 The UI must prefer comparison-friendly layouts

When the player compares many NPCs, stockpiles, or tasks, tables are often more space-efficient than cards and are better for finding, comparing, and acting on rows of data.

Implication:

- summary lists for NPCs, tasks, alerts, structures, and stockpiles should default to table-like or row-like layouts
- cards should be reserved for singular, richer inspection targets or tutorial panels

## 3.5 Color should help, not carry the entire meaning

Color is extremely useful in a dense simulation, but important information should never depend on color alone.

Use color together with:

- icons
- shapes
- labels
- text tags
- patterns or border styles
- ordering and placement

## 3.6 Small UI is good; small click targets are not

The game may use a compact interface, but actionable controls still need enough target size or spacing to remain usable.

Dense information is desirable.  
Dense misclicks are not.

## 3.7 Text must stay readable under scaling

The interface should be designed so users can enlarge text and still retain functionality.

This matters because your game is likely to be played on:

- different monitor sizes
- different resolutions
- different viewing distances
- different eyesight conditions

## 3.8 Interruptions must be tiered

Not every issue deserves a blocking popup.

The UI should clearly separate:

- passive status information
- actionable warnings
- urgent alerts
- true emergencies
- irreversible decisions

This is especially important in a simulation where something is always changing.

---

# 4. Primary UI goals for the early game

The early UI must let the player answer these questions quickly.

## 4.1 Survival questions

- does the starter NPC have water today?
- does the camp have safe shelter tonight?
- is there enough fuel for warmth and boiling?
- is food edible, reachable, and assigned properly?
- is the NPC overworked, sick, injured, or exposed?

## 4.2 Labor questions

- what is each NPC doing right now?
- why did they choose that task?
- what tasks are blocked?
- what tasks are urgent but unclaimed?
- what tasks are forbidden or disallowed by policy?

## 4.3 Material questions

- where are the important items physically located?
- how much potable water exists?
- how much food is raw vs edible vs preserved?
- how much fuel is dry and usable?
- what reserves are protected?
- what is spoiled, contaminated, or at risk?

## 4.4 Settlement questions

- where is sleeping, fire, storage, sanitation, work, and water handling located?
- is the camp layout safe?
- what is too far away?
- what structures are damaged, wet, or missing support materials?

## 4.5 Social/governance questions

- do NPCs agree with current priorities?
- is someone being overburdened?
- are rationing rules causing anger?
- is leadership legitimacy dropping?
- is a newcomer accepted, tolerated, or distrusted?

## 4.6 Knowledge questions

- what has been discovered?
- what is only suspected?
- what is still unreliable?
- which process failures are caused by missing know-how rather than missing materials?

---

# 5. Information architecture: the screen model

The main screen should be built around a **map-centered shell** with compact anchored regions.

## 5.1 Default shell

Recommended default layout:

- **top status bar** = global colony state
- **left navigation / mode rail** = major information domains
- **center map canvas** = world, overlays, selection frames, route lines
- **right inspector panel** = context details for the current selection
- **bottom event / task / alert strip** = live changes, queue surfacing, recent events

This can be implemented with collapsible side regions so the world remains primary.

## 5.2 Relative space allocation

Recommended starting allocation on desktop:

- map canvas: **55%–70%** of screen width
- right inspector: **20%–28%**
- left rail or narrow sidebar: **6%–12%**
- top bar: **4%–7%** of screen height
- bottom strip: **8%–15%** of screen height when expanded

The exact values can vary by aspect ratio.

## 5.3 Persistent vs transient regions

### Persistent
Always available:

- top status bar
- map canvas
- left mode rail
- selection inspector trigger
- alert summary strip

### Expandable / collapsible
Shown when needed:

- deep inspectors
- table views
- job queue lists
- policy editors
- history panels
- compare views

### Modal / blocking
Used rarely:

- irreversible decision confirmation
- major emergency pause prompts if enabled
- initial tutorial explanations

---

# 6. Major information domains

The game should be navigable by stable domains rather than by a huge number of disconnected windows.

## 6.1 Overview

Purpose: fast at-a-glance reading of colony viability.

Should show:

- current day / season / time block
- weather and hazard summary
- NPC count and current active/inactive state
- potable water reserve
- edible calories reserve
- dry fuel reserve
- sleeping capacity
- urgent alerts
- blocked tasks count
- injured / sick / exhausted count
- current settlement stage

This is the default landing state when nothing is selected.

## 6.2 NPCs

Purpose: compare people and inspect embodied state.

Should support:

- row view of all NPCs
- sort by urgency, role, health, morale, current task, distance from camp, trust, newcomer status
- inspect body state, interests, aptitudes, skills, carried items, recent tasks, complaints, and current needs
- pin one or more NPCs for comparison

## 6.3 Tasks

Purpose: understand labor and decision-making.

Should support:

- open tasks
- reserved tasks
- blocked tasks
- forbidden tasks
- urgent survival tasks
- selected NPC task score breakdown
- why a job is not being done
- task source: player order, auto-generated need, policy trigger, emergency override, follow-up subtask

## 6.4 Inventory / materials

Purpose: see what exists, where it is, and what condition it is in.

Should support:

- by-item totals
- by-location totals
- by-state totals (raw, boiled, edible, spoiled, wet, dry, contaminated, reserved, personal, communal)
- filters for survival-critical categories such as water, food, fuel, tools, bedding, medicine/care items, seeds

## 6.5 Structures / spaces

Purpose: inspect the built environment.

Should support:

- structure list
- map selection
- quality, condition, weatherproofing, warmth, hygiene, storage suitability, staffing, and supported processes
- structure-linked inventories
- structure-linked hazards or deficiencies

## 6.6 Policies / orders

Purpose: let the player steer without puppeteering every action.

Should support:

- global policies
- local policies by zone or structure
- direct task tickets
- reserve locks
- food/water rationing
- task permissions and prohibitions
- build priorities
- emergency mode rules

## 6.7 Knowledge

Purpose: show what the colony knows and how reliable that knowledge is.

Should support:

- discoveries
- practical procedures
- confidence level
- known failure causes
- who knows it personally
- whether it is community-known, documented, or only held by individuals

## 6.8 Health / care / safety

Purpose: unify risk, treatment, and prevention.

Should support:

- injury and illness list
- contamination warnings
- sanitation failures
- care burden
- hazard exposure map
- care item shortage warnings

## 6.9 Logistics

Purpose: reveal movement bottlenecks.

Should support:

- carry distances
- storage saturation
- stranded or misplaced goods
- contested reservations
- water hauling burden
- route inefficiency
- time lost to walking/carrying

## 6.10 Events / history

Purpose: explain why the colony state changed.

Should support:

- recent alerts and incident log
- filtered history by NPC, item, structure, or hazard
- “what changed in the last day/week”
- causal breadcrumbs for deaths, spoilage, conflicts, failed processes, or discovery events

---

# 7. Top status bar

The top bar is the colony heartbeat.

It should always remain visible and remain compact.

## 7.1 Required top-bar information

Recommended fields:

- day / season / year / time block
- weather summary
- hazard summary icon group
- population count
- urgent alert count
- potable water reserve indicator
- edible food reserve indicator
- dry fuel reserve indicator
- available sleeping spots indicator
- current command mode / pause / speed state

## 7.2 Top-bar behavior

Rules:

- values should be glanceable, not verbose
- use icons + small text + status colors together
- critical shortages should pulse or gain outline/badge, not fill the whole bar with noise
- opening one metric should jump directly into the relevant inspector/filter state

Example:

- click water badge → opens inventory filtered to potable/unsafe water + relevant structures + water route overlay
- click hazard badge → opens hazard panel + map overlay + recent incidents

---

# 8. Left navigation rail

The left edge should provide stable orientation.

## 8.1 Recommended left-rail entries

- Overview
- NPCs
- Tasks
- Inventory
- Structures
- Policies
- Knowledge
- Health
- Logistics
- History

## 8.2 Behavior

- icons should be persistent and memorable
- labels should appear on hover or in expanded mode
- current mode should be obvious with a shape/border/indicator, not just a color change
- badge counts may show alerts, blocked jobs, or new discoveries

## 8.3 Why a rail works well here

A left rail preserves vertical space for dense tables and inspectors and leaves the top bar free for global status.

On narrower screens it can collapse into:

- icon-only rail
- or a compact hamburger/section drawer if absolutely necessary

---

# 9. Right-side inspector architecture

The right inspector is the most important deep-reading panel.

## 9.1 Inspector rules

- only one primary selection at a time
- support pinning and side-by-side compare as an explicit mode, not by accident
- content should change based on selected entity type
- preserve consistent section order within each entity type
- always answer: **what is this, what state is it in, what matters next**

## 9.2 Entity types that need inspector variants

- NPC
- task
- item stack
- stockpile / container
- structure
- work area / zone
- knowledge entry
- hazard source
- event / incident

## 9.3 Standard section order

For most inspectors:

1. identity header
2. urgent state summary
3. main metrics / condition
4. dependencies / inputs / outputs
5. linked people / linked places
6. restrictions / permissions / ownership
7. recent history
8. actions

## 9.4 Header rules

Each inspector header should include:

- name
- type
- state chips
- current importance level
- context actions

Examples:

### NPC header
- Tova
- Adult / founder / primary gatherer
- thirsty / tired / trusted / carrying 3 items

### Structure header
- Hearth 01
- Hearth / communal / lit
- low fuel / smoke burden high / boiling enabled

### Stockpile header
- Dry Fuel Cache
- stockpile / communal / sheltered
- damp risk low / 18 units dry / 6 units wet

---

# 10. World map view

The world is top-down and minimal, so the map layer must carry meaning through smart overlays and selection feedback.

## 10.1 Base map representation

Recommended base map elements:

- terrain colors kept restrained
- water tiles/areas readable but not oversaturated
- trees, brush, stones, resource patches represented by tiny colored forms
- NPCs as tiny moving dots or short glyphs
- structures as compact footprints / outlines / color blocks
- selected entities get clear outlines and anchor labels

## 10.2 Map readability rules

- avoid too many unrelated moving effects
- prioritize silhouette and contrast over decorative detail
- use clean outlines for selection, danger, and ownership states
- when zoomed out, show category aggregates and state hints rather than tiny unreadable labels
- when zoomed in, reveal local labels, route lines, and state glyphs

## 10.3 Selection feedback

Selecting a map object should immediately show:

- outline or bracket
- name label near object or cursor
- path line if relevant
- related items/people highlight on demand
- inspector sync on the right

## 10.4 Tooltip policy

Hover tooltips are useful but should be restrained.

Use them for:

- one-line identity
- condition summary
- blocked reason
- current owner/reservation

Do not hide essential gameplay behind hover alone.

---

# 11. Overlay system

Overlays are the main way to turn a minimal world into a legible simulation.

## 11.1 Overlay principles

- one primary overlay at a time by default
- optional secondary micro-highlights allowed
- overlay legend must always be visible
- overlays should simplify, not clutter
- every overlay must answer a specific player question

## 11.2 Core early-game overlays

### A. Needs / distress overlay
Shows:
- starving / dehydrated / exhausted / cold / sick / injured NPCs
- severity gradients
- who is self-preserving vs available for work

### B. Water / sanitation overlay
Shows:
- water sources
- treated vs untreated storage
- washing area
- latrines / waste pits
- contamination risk radius
- dangerous proximity between waste and water handling

### C. Shelter / warmth overlay
Shows:
- sleeping places
- weatherproof quality
- wind protection
- warmth support
- exposed sleeping risk

### D. Food safety overlay
Shows:
- edible food
- raw perishable food
- drying/smoking areas
- contaminated or spoiled stock
- pest exposure risk

### E. Logistics overlay
Shows:
- haul paths
- active carriers
- distances
- contested reservations
- misplaced survival-critical goods
- storage saturation

### F. Ownership / reserve overlay
Shows:
- communal goods
- personal goods
- locked reserve goods
- seed reserve
- medical reserve
- currently claimed items

### G. Work / task overlay
Shows:
- active jobs
- blocked jobs
- urgent jobs
- labor concentration
- job source (policy, direct order, emergency, auto survival)

### H. Hazard overlay
Shows:
- flood-prone areas
- smoke burden
- lightning/fire risk zones
- pest/mosquito/tick heavy zones
- dangerous terrain

### I. Knowledge overlay
Shows:
- experimentally used sites/processes
- unreliable procedures
- unverified resource patches
- known good locations

## 11.3 Overlay controls

Recommended controls:

- hotkeys for primary overlays
- overlay wheel or small overlay menu
- last-used overlay memory
- hold-key for temporary overlay peek

---

# 12. Lists, tables, and row views

Dense simulation needs dense but readable tables.

## 12.1 Where table-style layouts should be default

- NPC roster
- task queue
- event log
- structure list
- stockpile list
- item inventory summaries
- knowledge list

## 12.2 Required row behaviors

Each row should support:

- sort
- filter
- quick action
- jump to map
- pin
- open inspector

## 12.3 Recommended common columns

### NPC table
- name
- role
- current task
- health
- fatigue
- hydration
- morale
- location
- trust/standing

### Task table
- task name
- source
- urgency
- blocked reason
- assigned NPC
- target location
- required inputs
- deadline or pressure window if applicable

### Inventory table
- item
- total quantity
- edible/useable quantity
- reserve quantity
- contaminated/spoiled quantity
- main location
- trend

### Structure table
- name
- type
- condition
- occupants/staff
- linked storage
- active process support
- risk/warning state

## 12.4 Filter architecture

Filters matter more than tabs alone.

Every dense table should support:

- free text search
- category chips
- severity filters
- map-area filter
- ownership filter
- reserve filter
- policy/zone filter
- NPC role filter where relevant

## 12.5 Empty-state behavior

When filtered results are empty, the table should explain why.

Good examples:

- “No unreserved dry fuel found in reachable stockpiles.”
- “No edible food remains in communal storage.”
- “No urgent tasks are unassigned; 3 blocked tasks remain.”

---

# 13. Notification and alert hierarchy

This game needs a disciplined notification model or the player will drown in noise.

## 13.1 Four notification tiers

### Tier 0 — passive status
Examples:
- fuel slightly lower than yesterday
- one new discovery note
- a basket finished drying

Presentation:
- tiny badges
- quiet log entries
- no interruption

### Tier 1 — actionable notice
Examples:
- one stockpile almost full
- water pot empty soon
- shelter repair recommended
- one newcomer requests assignment

Presentation:
- side notifications
- top-bar badge increment
- optional snackbar/toast
- no forced pause

### Tier 2 — warning
Examples:
- no potable water reserve after tonight
- seed storage moisture rising
- raw meat left exposed
- NPC fatigue unsafe
- sanitation conflict near water area

Presentation:
- persistent banner or warning panel entry
- map pulse/highlight on relevant targets
- opens relevant domain on click
- may auto-pause if the player enables that option

### Tier 3 — emergency
Examples:
- active fire spread
- collapse of shelter in storm
- severe bleeding
- multiple NPCs without safe sleep in freezing conditions
- contaminated only water supply

Presentation:
- strong banner + map highlight + audible cue if enabled
- optionally pause on emergency
- emergency action shortcuts visible immediately

### Tier 4 — blocking / irreversible decision
Examples:
- expel outsider?
- consume seed reserve?
- dismantle only safe shelter?
- accept hazardous emergency override with likely injury risk?

Presentation:
- blocking dialog
- explicit consequences
- confirm/cancel

## 13.2 Alert design rules

- combine color with icon + label + severity rank
- repeated alerts should collapse into grouped summaries
- one root problem should not produce 30 separate popups
- alerts should expire, downgrade, or merge when the cause changes
- clicking an alert should always take the player to the relevant context

## 13.3 Alert grouping model

Group alerts by cause when possible:

- Water safety
- Food safety
- Heat/cold exposure
- Fatigue/exhaustion
- Injury/illness
- Fire/smoke
- Storage saturation
- Reserve breach
- Social conflict
- Work blockage

---

# 14. Command surfaces and player actions

The game should offer command without constant micromanagement.

## 14.1 Primary player action types

- set policy
- set priority
- allow/disallow
- reserve/unreserve
- assign role
- create zone
- place structure plan
- issue direct job ticket
- inspect cause
- reorder queue
- respond to emergency

## 14.2 Context actions

Every major inspector should expose a small consistent action row.

Examples:

### NPC actions
- prioritize self-care
- assign role
- forbid dangerous work
- pin
- follow on map
- compare

### Structure actions
- repair
- relink storage
- restrict usage
- mark communal/personal
- set process permission
- deconstruct

### Stockpile actions
- change accepted items
- set reserve lock
- set quality rules
- relocate goods by policy
- restrict ownership access

### Task actions
- prioritize now
- forbid
- assign manually
- duplicate order
- inspect prerequisites
- jump to blocker

## 14.3 Bulk action surfaces

The interface should support bulk editing of:

- priorities
- reserve rules
- ownership modes
- allowed item categories
- zone permissions
- NPC work preferences

These bulk actions are better placed in tables or policy panels than repeated in single inspectors.

---

# 15. The policy screen

The policy screen is where the player behaves like a leader.

## 15.1 Policy screen sections

Recommended sections:

- survival defaults
- food and water rules
- reserve protection
- labor priorities
- risk tolerance
- sleep / wake / watch rules
- newcomer / outsider policy
- sanitation rules
- care escalation
- emergency automation

## 15.2 Policy screen design

Rules:

- use grouped sections with strong headings
- keep advanced options collapsed by default
- provide a short explanation under each rule
- show current consequence preview when possible

Example:

**Water Policy**
- Use untreated water only in emergency: Off
- Reserve boiled water for children/injured/sick: On
- Auto-prioritize boiling when potable reserve < 1 day: On

## 15.3 Policy consequence previews

Where possible, show direct effects:

- “Estimated 2 NPCs will stop washing if this rule is enabled.”
- “This reserve lock will leave only 1 communal edible meal.”
- “With this policy, unsafe water becomes eligible only for severe dehydration emergencies.”

---

# 16. NPC presentation model

Since NPCs are physically tiny on the map, the UI must do extra work to make them feel like people.

## 16.1 Always-visible NPC signals on the map

At close or medium zoom, NPCs should be able to show compact state signals such as:

- tiny status ring or outline
- selected role color accent
- emergency glyph
- carrying indicator
- sleep/rest state indicator

Do not attempt to show too many indicators at once.

## 16.2 Inspector depth for NPCs

The NPC inspector should make each person feel authored and embodied.

Suggested sections:

1. identity
2. body state
3. mood / morale
4. current task and why
5. interests / aptitudes / strongest skills
6. carried items and equipment
7. social notes
8. recent complaints / successes
9. allowed / forbidden work
10. direct actions

## 16.3 Comparison view

The player should be able to compare 2–4 NPCs side by side by:

- key body metrics
- task suitability
- social state
- skills/interests
- current burdens

This is important for realistic role assignment.

---

# 17. Inventory and stockpile presentation

The inventory UI must reflect that goods are physical, local, and condition-sensitive.

## 17.1 The UI should avoid one giant magical inventory fiction

Instead, it should distinguish clearly between:

- global known totals
- reachable totals from current selected map area
- communal accessible totals
- personal totals
- reserve-protected totals
- visible but contaminated/spoiled totals

## 17.2 Item detail view

Each item or item family page should support:

- description and category
- state variants
- main uses
- current total by condition
- locations
- ownership split
- process links
- current risks
- history trend

## 17.3 Stockpile map presentation

Stockpiles and containers should surface:

- accepted categories
- quality rules
- shelter/cover state
- contamination exposure
- fullness
- linked work areas
- average hauling burden

---

# 18. Structure and zone presentation

## 18.1 Structures

Each structure view should answer:

- what is it for?
- is it usable right now?
- what condition is it in?
- what processes does it support?
- what risks does it have?
- who uses it?
- what is stored here?

## 18.2 Zones

Zones are one of the most powerful early-game clarity tools.

Recommended early zones:

- sleeping area
- hearth area
- clean water handling area
- dirty work area
- butchery area
- drying/smoking area
- latrine/waste area
- seed/garden area
- communal storage area

The UI should let players see zone boundaries clearly and adjust them quickly.

## 18.3 Zone editing UX

Zone editing should be fast and reversible:

- drag paint or click-to-place cells
- rename and recolor zone
- assign permissions/policies
- set preferred storage/process categories
- highlight conflicts immediately

---

# 19. Knowledge presentation

A realism-first knowledge model can become confusing unless the UI distinguishes known from guessed.

## 19.1 Knowledge states that should be visible

- unknown
- observed once
- suspected useful
- repeatably successful
- documented/community-known
- disputed / contradicted / unreliable

## 19.2 Knowledge entry layout

Each knowledge entry should show:

- title
- type (discovery, procedure, tool method, rule, institutional practice)
- confidence
- who knows it
- how it was learned
- what it unlocks
- what still causes failure
- whether it is transferable

## 19.3 Player-facing language

Avoid pure tech-tree phrasing.

Prefer language like:

- “The colony has learned a workable way to dry meat in this weather.”
- “Only Tova knows how to shape this pot reliably.”
- “Boiling cloudy water without settling first still leads to poor taste and waste.”

---

# 20. Health and safety presentation

Health must be legible without turning the screen into a hospital monitor.

## 20.1 Body-state presentation model

Use compact chips/bars for:

- hydration
- calories/energy
- fatigue
- warmth/cold stress
- injury severity
- illness burden
- pain burden
- contamination exposure
- morale/stability

## 20.2 Care queue view

The care screen should support:

- who needs help
- how urgent it is
- what kind of care is required
- whether self-care is enough
- whether assisted care is available
- what care items are missing

## 20.3 Safety summary

A good safety summary should include:

- open fire risk
- smoke burden
- unsafe water handling
- contaminated food exposure
- latrine conflict
- exposed sleepers
- hazardous work allowed/disallowed

---

# 21. Logistics presentation

If movement matters, the UI must make movement visible.

## 21.1 Logistics screen key views

- carried items by NPC
- reserved pickups/dropoffs
- haul routes
- average trip distances
- blocked paths
- stranded items
- misplaced reserves
- overloaded stockpiles

## 21.2 Map logistics cues

Recommended cues:

- thin route lines
- pickup/dropoff markers
- storage fullness indicators
- item cluster labels at zoomed-out levels
- highlight for repeated travel bottlenecks

## 21.3 Logistics-driven warnings

Examples:

- “Potable water exists but is 180m away and unassigned.”
- “Dry fuel reserve is split across 4 distant piles.”
- “Sleeping mats stored in wet zone.”
- “Food spoilage risk elevated due to delayed hauling.”

---

# 22. Interaction model

## 22.1 Core interaction verbs

The interface should revolve around a small consistent set of verbs:

- select
- inspect
- pin
- compare
- prioritize
- allow
- forbid
- reserve
- assign
- zone
- queue
- confirm

## 22.2 Mouse-first flow

Expected default flow:

- click entity on map → inspector updates
- right-click or action button → context actions
- drag on map → zone, select group, or pan depending mode
- mouse wheel → zoom
- hover on badges/tags → compact explanation

## 22.3 Keyboard support

Even if most players use mouse, keyboard support should exist for:

- pause/speed
- overlay switching
- cycle selections
- open key domains
- search/focus filter bars
- confirm/cancel

Visible focus indication matters for accessibility and fast navigation.

## 22.4 Search model

Search should be globally available and support:

- NPC names
- structure names
- item names
- knowledge entries
- alerts
- policy names

---

# 23. Zoom-dependent information reveal

The interface should reveal the right amount of information at the right zoom level.

## 23.1 Far zoom

Show:

- large terrain forms
- structure footprints
- zone colors
- population dots
- item cluster markers
- alert hotspots

Hide or simplify:

- individual item labels
- tiny status text
- detailed route lines unless overlay active

## 23.2 Medium zoom

Show:

- NPC outlines/glyphs
- main structure names
- route lines on demand
- stockpile tags
- active task markers

## 23.3 Near zoom

Show:

- individual items or small stacks
- local condition glyphs
- micro-labels
- detailed reservations
- interaction affordances

---

# 24. UI hierarchy for alerts, panels, and depth

The UI should follow a clear hierarchy of attention.

## 24.1 Attention order

Recommended priority order:

1. active emergency
2. immediate survival shortage
3. selected entity state
4. top-bar reserves and hazards
5. map overlay hotspots
6. queued notices
7. historical information

## 24.2 Panel depth rules

- first layer: overview/dashboard
- second layer: domain list or table
- third layer: detailed inspector
- fourth layer: edit dialog or advanced configuration

Avoid burying essential survival decisions deeper than layer 2 when possible.

---

# 25. Accessibility baseline for this project

Even though this is a game, the UI should adopt strong accessibility baselines.

## 25.1 Contrast

Target at least:

- **4.5:1** for normal text
- **3:1** for large text
- strong contrast for non-text UI elements and focus indicators where possible

## 25.2 Color meaning

Do not rely on color alone.

Use color together with:

- icon
- label
- shape
- position
- pattern/border

## 25.3 Text scaling

Design so text can scale upward substantially without breaking functionality.

A practical target is to preserve usability under large text or UI scale increases.

## 25.4 Hit target spacing

Compact controls are acceptable only if click targets remain adequately sized or separated.

## 25.5 Readability

- avoid overly stylized fonts
- prefer crisp legible text
- avoid all-caps for dense body information
- use consistent abbreviations if any
- support tooltips or glossary for short labels

## 25.6 Game-specific accessibility

At minimum, support:

- text size setting
- UI scale setting
- colorblind-safe mode or alternate tagging mode
- icon+text option for critical badges
- remappable hotkeys later

---

# 26. Recommended visual language

## 26.1 Status chips

Use compact chips for:

- thirst
- hunger
- fatigue
- cold
- injury
- contamination
- reserve lock
- communal/personal ownership
- forbidden/allowed
- urgent/blocked

## 26.2 Border logic

Borders are useful in a minimal UI.

Examples:

- solid border = selected
- double border = pinned
- dashed border = planned / not yet built
- striped border = restricted / unsafe
- pulsing border = critical

## 26.3 Icon logic

Icons should be few and consistent.

Early critical icons may include:

- water
- food
- fire
- sleep
- health
- hazard
- hauling
- knowledge
- policy
- reserve

## 26.4 Text style hierarchy

Recommended hierarchy:

- H1: domain header
- H2: inspector section header
- H3: inline subgroup header
- body: values and explanations
- caption: metadata/history notes
- mono or semi-mono numerics for quantities and times if helpful

---

# 27. First-playable UI set

To keep implementation realistic, the first version of the UI does not need every future panel.

## 27.1 Minimum viable early-game interface

Must-have:

- top status bar
- map canvas
- right inspector
- left rail with 5–7 core domains
- alert stack/strip
- one overlay menu
- NPC table
- task table
- inventory summary table
- structure list
- policy mini-panel

## 27.2 First-playable domains

Recommended first-playable domains:

- Overview
- NPCs
- Tasks
- Inventory
- Structures
- Policies
- Health

Knowledge, Logistics, and History can initially appear as simpler subpanels before becoming full domain screens.

## 27.3 First-playable overlays

Recommended initial overlay set:

- Needs / distress
- Water / sanitation
- Shelter / warmth
- Logistics
- Hazard

---

# 28. Suggested data model for UI architecture

This section is conceptual, not code.

## 28.1 Core UI entities

### UIScreenState
- current domain
- current overlay
- selected entity id
- pinned entity ids
- active filters
- active compare mode
- panel collapsed states
- notification settings

### UIEntitySummary
Common summary payload for rows and tooltips:
- id
- type
- label
- state chips
- urgency
- location reference
- quick actions

### UIAlert
- id
- severity tier
- category
- root cause id
- affected entity ids
- created time
- expiry / merge key
- action targets

### UIOverlayDefinition
- id
- label
- legend entries
- visible map layers
- compatible filters
- priority rules

### UIInspectorSection
- section id
- title
- visibility condition
- metrics
- action slots
- expansion state

---

# 29. Open questions for the next UI pass

These should be resolved in a later version:

1. exact monitor/resolution targets
2. whether the game supports gamepad navigation early or later
3. whether there is a dedicated compare workspace
4. whether the bottom strip should be event-focused or task-focused by default
5. exact icon language and color token system
6. how much of the map labels remain visible at each zoom level
7. whether policy editing lives in a full-screen domain or side sheet
8. what the first tutorial/onboarding overlays look like

---

# 30. Recommended next companion document

After this spec, the strongest companion document is:

## Canonical Early Content Pack v0.1

Why:

- the UI architecture now says **where** information belongs
- the simulation stack already says **how** the colony behaves
- the content pack should define **what actual early content exists** to be shown, sorted, filtered, selected, and acted on

That content pack should likely include:

- starter items/materials
- starter processes
- starter tasks
- starter structures
- starter knowledge entries
- starter policies
- starter alerts/incidents

---

# 31. References

These sources were used as grounding for the UI / IA principles in this draft.

- W3C, *Web Content Accessibility Guidelines (WCAG) 2.2*  
  https://www.w3.org/TR/WCAG22/

- W3C WAI, *Designing for Web Accessibility – Tips for Getting Started*  
  https://www.w3.org/WAI/tips/designing/

- W3C WAI, *Understanding SC 2.5.8: Target Size (Minimum)*  
  https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html

- W3C WAI, *Guidance on Applying WCAG 2 to Non-Web ICT (WCAG2ICT)*  
  https://www.w3.org/TR/wcag2ict-22/

- Nielsen Norman Group, *Dashboards: Making Charts and Graphs Easier to Understand*  
  https://www.nngroup.com/articles/dashboards-preattentive/

- Nielsen Norman Group, *Data Tables: Four Major User Tasks*  
  https://www.nngroup.com/articles/data-tables/

- Game Accessibility Guidelines, *Basic*  
  https://gameaccessibilityguidelines.com/basic/

- Game Accessibility Guidelines, *Full list*  
  https://gameaccessibilityguidelines.com/full-list/

- Material Design 3, *Snackbar*  
  https://m3.material.io/components/snackbar/guidelines

- Material Design 3, *Navigation drawer*  
  https://m3.material.io/components/navigation-drawer/overview

- Material Design 3, *Layout*  
  https://m3.material.io/foundations/layout/understanding-layout

- Material Design 3, *Color roles*  
  https://m3.material.io/styles/color/roles

- Material Design 3, *Dialogs*  
  https://m3.material.io/components/dialogs/guidelines
