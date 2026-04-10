---
title: "Realistic Incremental/Idle Colony-to-City Game - Item & Material Bible"
version: "v0.1"
scope:
  - "Lone survivor"
  - "Primitive camp"
  - "Permanent camp"
  - "Tiny hamlet (3-8 NPCs)"
assumptions:
  - "Earth-like setting"
  - "Temperate starting biome"
  - "Top-down minimal visuals"
  - "Player gives priorities/orders; NPCs execute based on body state, skills, interests, and task evaluation"
  - "Explicit object simulation from the beginning"
notes:
  - "This is a foundation document, not a final exhaustive database."
  - "This document avoids fantasy shortcuts and tries to stay close to realistic material provenance."
---

# Realistic Incremental/Idle Colony-to-City Game - Item & Material Bible

## Purpose

This document defines the **early item and material layer** for the project.

It is based on the previously established design direction:
- one starter NPC
- realistic survival and camp formation
- no magical crafting
- every item should come from believable materials, labor, tools, and knowledge
- the first playable span is **lone survivor -> primitive camp -> permanent camp -> tiny hamlet**

This bible is not just a list of loot. It is meant to define:
- what exists physically in the early game
- what state each thing can be in
- what storage/decay rules apply
- what realistic transformations are possible
- what should be treated as raw material, intermediate, finished good, fuel, consumable, or waste
- what should exist as a distinct game object instead of being hand-waved away

---

# 1. Ground rules for the item layer

## 1.1 Nothing appears from nowhere
Every item should have a believable origin.
Examples:
- **cordage** comes from strips of bark, bast fiber, leaf fiber, sinew, hair, or hide, not from a generic “rope” recipe
- **cleaner water** comes from source choice plus settling/filtering/boiling plus clean storage, not from a magic purifier
- **hide clothing** comes from hunting or carcass access, then skinning, scraping, drying, softening, smoking, and cutting
- **pottery** comes from clay, temper, drying, and firing, with real breakage risk

## 1.2 Early game items should be concrete and physical
Because the project begins with one exposed person, the first items should feel tangible.
Examples:
- a branch matters
- one basket matters
- one bedroll matters
- one sharpened digging stick matters
- one intact cooking pot matters
- one full skin of safe water matters

## 1.3 Storage is part of the item design
An item is not fully defined unless we know:
- whether it spoils
- whether it rots when wet
- whether it attracts pests
- whether it must be covered
- whether it must be kept dry
- whether it can be cached outdoors
- whether it can be carried by hand, sling, basket, drag, or litter

## 1.4 Realism means state changes
Most early materials are not static. They pass through states.
Examples:
- green wood -> seasoned wood -> rotten wood -> ash/char
- raw hide -> fleshed hide -> scraped hide -> dried hide -> softened hide -> smoked hide
- cloudy water -> settled water -> filtered water -> boiled water -> stored potable water -> contaminated stored water
- raw clay -> cleaned clay -> tempered clay -> greenware -> fired earthenware -> cracked sherds/grog
- gathered seed heads -> cleaned seed -> dried seed -> edible grain or planting seed

## 1.5 Small objects can still be visually abstract
The world can render items as tiny colored marks or dots, but the simulation still treats them as distinct things with realistic properties.

---

# 2. Scope of this document

This bible covers the material world needed for:
- first-day survival
- first-week camp stabilization
- first-season storage and preservation
- first winter preparation
- first plant tending / proto-agriculture
- first extra NPC arrivals
- first specialized early roles
- the threshold into a small hamlet economy

This document does **not** yet fully cover:
- full textile production chains beyond the beginnings of thread and simple woven goods
- metalworking beyond naturally useful stone, bone, wood, clay, hide, and very early traded scrap if ever used
- animal traction
- formal trade goods economy
- advanced masonry
- machinery

---

# 3. Recommended item record schema

For implementation and future database work, each item should eventually have the following fields.

## 3.1 Core identity
- **item_id**
- **display_name**
- **category**
- **subcategory**
- **era_min**
- **material_family**
- **state_type**

## 3.2 Physical form
- **countable / measurable**
- **unit** (piece, bundle, skin, basket-load, kg-equivalent, liter-equivalent)
- **relative mass class**
- **relative bulk class**
- **stack behavior**
- **carry method** (hand, bundle, sling, basket, drag, litter, shoulder pole)
- **wetness sensitivity**
- **heat sensitivity**
- **fragility**

## 3.3 Condition and safety
- **durability / integrity**
- **freshness state**
- **contamination risk**
- **pest attraction**
- **rot risk**
- **mold risk**
- **disease/vector risk**

## 3.4 Storage and decay
- **preferred storage type**
- **forbidden storage conditions**
- **shelf-life category**
- **seasonal modifiers**
- **decay outputs**

## 3.5 Production and use
- **obtained_by**
- **input_items**
- **tool_requirements**
- **station_requirements**
- **knowledge_requirements**
- **skill_requirements**
- **byproducts**
- **waste_outputs**
- **repair_uses**
- **maintenance_uses**
- **downstream_uses**

## 3.6 Social / simulation relevance
- **ownership tendency** (personal, communal, workplace, cached)
- **priority class** (life-critical, daily essential, useful, luxury)
- **who competes for it**
- **task relevance tags**

---

# 4. Canonical item categories for the early game

## 4.1 Water and other liquids
- raw untreated water
- settled water
- filtered water
- boiled water
- potable stored water
- non-potable utility water
- rendered fat / grease
- broth / thin stew

## 4.2 Stone, earth, and mineral materials
- stones for pounding
- knappable stone
- flakes
- cores
- hammerstones
- abrasive stone
- clay
- sand
- gravel
- silt/mud
- ash
- charcoal later in this scope

## 4.3 Wood and plant structural materials
- twigs
- brush
- poles
- branches
- saplings
- logs
- bark sheets
- roots
- leafy boughs
- grass/reeds/straw
- leafy litter

## 4.4 Fibers, cordage, and flexible plant materials
- bast strips
- bast fiber
- leaf fiber
- bark strips
- grass bundles
- reed bundles
- vine lengths
- cordage
- twine
- lashings
- rough thread

## 4.5 Animal materials
- raw meat
- organs
- fat
- bones
- antler/horn where biome allows
- sinew
- tendon strips
- raw hide/skin
- scraped hide
- dried hide
- softened/smoked hide
- fur pelt
- feathers
- eggshells

## 4.6 Food materials
- edible greens
- roots/tubers
- berries/fruits
- nuts
- mushrooms only if identified safely
- shellfish/fish/small game
- dried foods
- smoked foods
- seeds/grain-like harvests
- planting seed

## 4.7 Fuel materials
- tinder
- kindling
- dry fuelwood
- damp wood
- resinous kindling where available
- dung fuel only later if animals exist
- charcoal near late early-game

## 4.8 Containers and carrying goods
- hand bundle
- carrying sling
- basket
- lined basket
- hide bag
- skin water bag
- clay bowl
- clay jar
- cooking pot
- storage pot
- pit cache lining materials

## 4.9 Clothing, shelter, bedding materials
- fiber wraps
- hide wraps
- capes/cloaks
- foot wrappings
- bedding grass
- fur bedding
- mats
- hide sheets

## 4.10 Agriculture and camp-maintenance inputs
- seed stock
- planting tubers
- compostable organic waste
- ash for cleaning or soil effect
- brush fencing material
- stakes
- woven panels
- simple mulch material

## 4.11 Waste, scrap, and byproducts
- spoiled food
- bones after marrow extraction
- cracked pottery sherds
- ash
- charcoal fines
- rotten fiber
- hide scraps
- wood offcuts
- dung later
- sweepings/refuse

---

# 5. Early-game storage and perishability taxonomy

## 5.1 Shelf-life classes

### Class A — hours
Examples:
- fresh meat in warm weather
- fish
- opened organs
- cooked leftovers left exposed
- fresh blood-rich scraps

### Class B — 1–3 days
Examples:
- many gathered greens
- mushrooms
- soft fruit
- untreated stored water in dirty containers
- fresh hide in warm weather before proper processing

### Class C — several days to weeks with good handling
Examples:
- roots/tubers kept cool and dry
- nuts in shell
- dry tinder bundles
- cleaned tools kept dry
- dried but not fully protected food

### Class D — weeks to months with good storage
Examples:
- dried plant foods
- properly dried seeds
- dry cordage
- seasoned wood
- smoked and dried hides
- dry pottery

### Class E — months to years if kept intact and dry
Examples:
- stone tools
- fired pottery
- bone tools kept dry
- charcoal kept dry
- well-kept seed stock with low moisture and low pest access

## 5.2 Main spoilage drivers
- moisture
- heat
- insects
- rodents
- mold
- direct sun damage for some goods
- repeated wet-dry cycles
- contamination by dirty hands/containers
- proximity to latrines, carcasses, or waste

## 5.3 Core storage rules

### Food
- keep covered
- separate raw animal food from ready-to-eat food
- keep off the ground where possible
- protect from insects, rodents, dust, and dogs/other scavengers
- dry products thoroughly before long storage

### Water
- safest source first
- treat if risky
- store in clean covered vessels
- distinguish drinking water from utility water
- dirty container = lower water quality even if the source was better

### Seed
- keep dry
- protect from insects and rodents
- separate planting seed from edible stores
- do not expose to repeated wetting
- avoid overheating

### Fibers and hides
- dry thoroughly
- keep away from prolonged ground moisture
- protect from mold and pests
- protect soft finished hides from repeated soak/dry cycling unless appropriately smoked or treated

### Fuel
- separate tinder, kindling, and larger wood
- keep the driest small fuel under cover
- green wood is still useful for construction, less useful for fast ignition

---

# 6. Key realism notes that affect item design

## 6.1 Water
CDC guidance treats boiling as the best general method for killing germs in suspect drinking water, and recommends first letting cloudy water settle or filtering it before boiling, then storing it in clean, sanitized, covered containers. This supports treating water as a chain of source quality + treatment + storage quality rather than a binary item. [S1][S2]

## 6.2 Pottery
Pottery and earthenware matter because firing changes clay so it no longer collapses back into plastic mud when exposed to water, and firing/drying also affects porosity, strength, and suitability for liquid storage. Unglazed earthenware remains porous, so it is not equally good for every liquid-storage use. [S3][S4][S5]

## 6.3 Basketry and cordage
Basketry and cordage are major early technologies, not decorative extras. Baskets realistically support gathering, winnowing, transport, storage, traps, and work organization. Cordage comes from many possible plant and animal fibers; bast and leaf fibers are especially important for early rope/twine use. [S6][S7][S8][S9]

## 6.4 Hide processing
Raw hides are highly perishable. Drying alone can preserve a hide in a crude way, but tanning/softening/smoking produce a more durable, more useful material. Brain/oil/smoke-based methods belong in the early game; later plant tanning can appear once bark/tannin knowledge is formalized. [S10][S11][S12]

## 6.5 Drying vs smoking food
Drying is one of the oldest preservation methods because lowering moisture reduces bacterial and fungal growth. Smoking can help preserve and flavor food, but in practical realism terms it should usually be modeled as a support to drying/curing, not as a magical preservation buff by itself. [S13][S14][S15]

## 6.6 Seed and grain storage
For grains and many seeds, dryness is critical. FAO guidance for small-scale storage emphasizes drying, moisture control, hygiene, and protection from insects and rodents. In game terms this means “seed stock” should be a fragile strategic item, not a generic crop token. [S16][S17][S18]

## 6.7 Camp sanitation and contamination distance
Basic backcountry sanitation guidance consistently places human waste well away from water and camps, with catholes commonly 6–8 inches deep and roughly 100–200 feet from water/camps/trails depending on source and terrain. For the game, this strongly supports separate latrine and waste zones rather than treating filth as invisible. [S19][S20][S21]

---

# 7. Material-state families

These are the most important state chains to model explicitly in the early game.

## 7.1 Water state family
1. **dirty surface water**
2. **settled water**
3. **cloth-filtered water**
4. **boiled water**
5. **stored potable water**
6. **recontaminated stored water**
7. **non-potable utility water**

## 7.2 Wood state family
1. **fresh twig / brush**
2. **green branch / sapling**
3. **dry branch**
4. **dry fuelwood**
5. **seasoned pole / stave**
6. **punky wood / rotten wood**
7. **charred wood**
8. **charcoal**
9. **ash**

## 7.3 Stone state family
1. **fieldstone / cobble**
2. **hammerstone**
3. **knapping core**
4. **flake blank**
5. **sharp flake tool**
6. **scraper blank**
7. **ground edge tool later**
8. **dull/broken tool fragment**

## 7.4 Hide state family
1. **raw skin/hide**
2. **fleshed hide**
3. **scraped/dehaired hide**
4. **air-dried rawhide**
5. **softened hide**
6. **smoked hide / primitive buckskin-like material**
7. **cut leather-like straps/pieces**
8. **hide scrap**

## 7.5 Fiber state family
1. **raw plant strip / bark strip**
2. **separated fiber**
3. **cleaned fiber bundle**
4. **twisted cord**
5. **2-ply cordage**
6. **rope/lashing**
7. **rough thread**
8. **woven strip / mat later**

## 7.6 Clay state family
1. **raw dug clay**
2. **cleaned clay**
3. **tempered clay**
4. **wet formed vessel**
5. **leather-hard vessel**
6. **greenware**
7. **fired earthenware**
8. **cracked sherds/grog**

## 7.7 Food state family (animal)
1. **fresh carcass**
2. **unbutchered cuts / organs**
3. **fresh meat portions**
4. **cooked meat**
5. **dried meat**
6. **smoke-dried meat**
7. **spoiled meat**
8. **inedible waste / compostable remains**

## 7.8 Food state family (seed/plant)
1. **freshly gathered edible plant**
2. **cleaned edible plant**
3. **cut/drying plant**
4. **dried edible plant**
5. **seed-bearing harvest**
6. **cleaned seed**
7. **dried seed stock**
8. **damaged seed / low-viability seed**

---

# 8. The item catalogue

The entries below are written as **canonical definitions** for early content. They are not yet final balance data.

---

# 8A. Water and liquid items

## A1. Dirty Surface Water
- **Category:** Water / Raw
- **Typical sources:** stream edge, pond margin, puddle, runoff, shallow dip, poorly stored vessel
- **Properties:** high contamination uncertainty; easy to gather; not equally dangerous in all sources
- **Storage:** any container that can hold liquid or semi-liquid; unsafe storage worsens quality
- **Uses:** emergency drinking, cooking after treatment, washing, clay working, hide work, extinguishing fire, soaking fibers
- **Downstream:** settled water, filtered water, boiled water, utility water
- **Game note:** quality should depend on source, season, nearby waste, animal traffic, and container cleanliness

## A2. Settled Water
- **Category:** Water / Treated intermediate
- **Created by:** letting turbid water sit so solids drop out
- **Properties:** visually cleaner; not reliably safe by itself
- **Storage:** broad vessel, pot, skin, lined pit, large shell, bark container, earthenware once available
- **Uses:** better precursor for filtering/boiling; utility water
- **Downstream:** cloth-filtered water, boiled water

## A3. Cloth-Filtered Water / Coarse-Filtered Water
- **Category:** Water / Treated intermediate
- **Created by:** pouring through cloth, fiber pad, sand/charcoal stack in later variants
- **Properties:** reduced particulates; still not guaranteed safe
- **Uses:** precursor for boiling, less muddy cooking, cleaner hide/fiber work
- **Game note:** simple field filtration reduces turbidity, not all pathogen risk

## A4. Boiled Water
- **Category:** Water / Potable intermediate
- **Created by:** heating clear or clarified water to a boil
- **Properties:** safer to drink; depends on maintaining container and handling hygiene
- **Requirements:** fire + heat-safe vessel + time + fuel
- **Storage:** best in clean covered containers
- **Uses:** drinking, cooking, feeding vulnerable NPCs, basic care for the sick

## A5. Stored Potable Water
- **Category:** Water / Consumable essential
- **Created by:** safely treated water stored in clean, covered container
- **Properties:** high priority life-support item; vulnerable to recontamination
- **Storage:** covered pot, well-maintained skin bag, clean gourd, tight basket + lining only in some cases
- **Uses:** drinking reserve, travel reserve, emergency reserve
- **Game note:** should degrade faster if containers are dirty, open, or shared with utility water

## A6. Utility Water
- **Category:** Water / Utility consumable
- **Uses:** washing, clay mixing, extinguishing embers, hide soaking, cleaning blood from work surfaces, mud/plaster work
- **Game note:** should not consume potable reserve unless player policy allows it

## A7. Rendered Fat / Grease
- **Category:** Animal byproduct / Processed basic
- **Created by:** heating fatty tissue and separating grease
- **Properties:** calorie dense; semi-stable if kept cool and covered; useful beyond food
- **Uses:** cooking, hide treatment, primitive waterproofing aid, lamp/fuel experiments later, skin conditioning
- **Risks:** rancidity, pest attraction

## A8. Thin Broth / Stew
- **Category:** Prepared food / Liquid
- **Created by:** boiling meat, bones, roots, greens in water
- **Properties:** short shelf life, good hydration-calorie compromise, easier on weak NPCs
- **Uses:** immediate nutrition, morale, convalescence
- **Game note:** should spoil quickly unless reheated and consumed soon

---

# 8B. Stone, earth, and mineral items

## B1. Fieldstone / Cobble
- **Category:** Mineral / Raw gathered
- **Properties:** common; variable size; useful as hammer, weight, boundary marker, hearth ring
- **Uses:** hammerstone candidate, hearth construction, stake weight, crack bones, crush seed/nuts

## B2. Knappable Stone Nodule
- **Category:** Mineral / Raw gathered
- **Examples:** flint, chert, obsidian where available, suitable fine-grained stone
- **Properties:** valuable because it can be turned into sharp flakes
- **Uses:** flake production, scraper production, cutting tools
- **Game note:** quality should vary by deposit/source, not all “stone” is equal

## B3. Hammerstone
- **Category:** Tool material / Raw-functional
- **Created by:** selecting dense, comfortable cobble
- **Uses:** knapping, cracking bone, cracking nuts, pounding stakes, crushing pigments later
- **Wear:** chips, hand injury risk if poor shape

## B4. Sharp Flake
- **Category:** Tool blank / Primitive tool
- **Created by:** striking a suitable core
- **Uses:** cutting meat, plant processing, light scraping, shaving wood, emergency surgery/care tasks in dire contexts
- **Risks:** fragile edge, hand injury, low lifespan

## B5. Scraper Stone
- **Category:** Primitive tool
- **Created by:** retouching flake or selecting naturally suitable edge
- **Uses:** hide scraping, bark cleaning, shaping wood, smoothing shafts
- **Importance:** one of the major early hide-processing tools

## B6. Grinding / Abrasive Stone
- **Category:** Tool material
- **Uses:** smoothing bone/wood, crushing dry foods, pigment prep later, seed grinding later
- **Game note:** separate from hammerstone because wear profile and use are different

## B7. Sand
- **Category:** Mineral / Raw bulk
- **Uses:** temper for clay, abrasive cleaning, drainage improvement, lining around fire or pit features
- **Storage:** dry pile or sack/basket

## B8. Gravel
- **Category:** Mineral / Raw bulk
- **Uses:** drainage, hearth base, path stabilization, pit lining, post support fill
- **Game note:** useful for camp engineering even before masonry

## B9. Silt / Mud
- **Category:** Earth / Raw bulk
- **Uses:** daub, pit sealing, temporary plaster, shaping around hearth, primitive waterproofing attempts
- **Limits:** poor durability by itself when repeatedly wetted

## B10. Raw Clay
- **Category:** Earth / Raw craft material
- **Uses:** vessel making, sealing, hearth repair, figurative experimentation, thermal mass additions
- **Storage:** wrapped or covered to prevent drying if not processed immediately
- **Downstream:** cleaned clay, tempered clay

## B11. Cleaned Clay
- **Category:** Earth / Processed basic
- **Created by:** removing roots, stones, unwanted debris, sometimes slaking and settling
- **Uses:** better pottery, smoother plugs/stoppers, improved seals

## B12. Temper
- **Category:** Mineral/organic additive / Processed basic
- **Examples:** sand, crushed shell, grog, plant fiber in some cases
- **Uses:** mixed with clay to reduce shrinkage/cracking and alter working/firing behavior
- **Game note:** should exist as its own item or tag in pottery processes

## B13. Hearth Ash
- **Category:** Byproduct / Fine mineral-organic residue
- **Uses:** cleaning aid, drying surface aid, odor reduction in waste pits, soil amendment in limited contexts, soap path much later
- **Risks:** windblown contamination, eye irritation

## B14. Charred Wood Fragment
- **Category:** Byproduct / Fuel-adjacent
- **Uses:** relighting, pigment/drawing, filter layer experiments, later charcoal production pathway

## B15. Pottery Sherd / Grog
- **Category:** Waste / Reusable byproduct
- **Created by:** broken fired vessel
- **Uses:** temper, drainage, cutting edges in crude cases, hearth packing
- **Importance:** breakage should not be total waste

---

# 8C. Wood, brush, bark, and plant structural items

## C1. Twig Bundle
- **Category:** Plant material / Raw
- **Uses:** tinder support, small weaving, trap triggers, light lash reinforcement, marker stakes

## C2. Brush Bundle
- **Category:** Plant material / Raw bulk
- **Uses:** windbreaks, debris shelter fill, bedding base, pit cover, crude camouflage, dead-hedge fencing

## C3. Dry Kindling Bundle
- **Category:** Fuel / Essential
- **Uses:** fire starting and quick relighting
- **Game note:** should be materially different from “wood” because ignition performance matters

## C4. Fuelwood Bundle
- **Category:** Fuel / Essential
- **Properties:** best when dry; larger pieces burn longer
- **Uses:** cooking, boiling water, warmth, hide smoking, pottery firing support later
- **Storage:** covered, off ground if possible

## C5. Green Branch
- **Category:** Structural plant material
- **Uses:** shelter frame, stake, simple club, spit, bow-drill components depending species and later knowledge
- **Limits:** poor as immediate fuel; may warp on drying

## C6. Straight Sapling
- **Category:** Structural plant material / High-value early construction input
- **Uses:** shelter poles, drag frame, drying rack, carrying pole, fence posts, future loom/simple frame parts
- **Game note:** should take time and tool wear to cut and trim

## C7. Pole / Stave
- **Category:** Structural intermediate
- **Created by:** trimming straight sapling/branch
- **Uses:** spear shaft, digging stick blank, shelter member, litter frame, drying rack, hanging rack

## C8. Log Section
- **Category:** Structural heavy material
- **Uses:** seating, hearth surround, wall base, retaining edge, crude bench, later splitting
- **Transport:** high burden; encourages drag/litter use

## C9. Bark Sheet
- **Category:** Plant material / Flexible structural sheet
- **Uses:** roof shingles, container lining, food wrapping, temporary plate, tinder source depending species, writing surface much later
- **Limits:** species dependent; cracks if mishandled

## C10. Inner Bark Strip / Bast Strip
- **Category:** Plant material / Fiber precursor
- **Uses:** cordage, ties, mats, basketry, rough wrapping
- **Importance:** a foundational early material class

## C11. Reed Bundle
- **Category:** Plant material / Flexible stalk bulk
- **Uses:** mats, baskets, screens, roof thatch, arrows/floats later, bedding layer, wattle-like panels

## C12. Grass Bundle / Straw Bundle
- **Category:** Plant material / Light bulk
- **Uses:** bedding, thatch, mulch, insulation, basket filler, pit cover, smokehouse seals
- **Risks:** mold if stored damp

## C13. Leafy Bough Bundle
- **Category:** Plant material / Short-lived comfort material
- **Uses:** insulation layer, bedding freshness, camouflage, rain-shedding shelter cover for short periods
- **Limits:** fast wilting/decay

## C14. Root Length / Flexible Root
- **Category:** Plant material / Fiber-structural hybrid
- **Uses:** binding, sewing, basketry, trap making, stitching bark/hide panels

## C15. Vine Length
- **Category:** Plant material / Natural lashing
- **Uses:** quick lash, binding, trap making, temporary structural ties
- **Limits:** unreliable strength depending species and age

---

# 8D. Fiber, cordage, and flexible craft items

## D1. Raw Fiber Bundle
- **Category:** Fiber / Raw
- **Sources:** bast fiber plants, leaf fibers, grass fiber, nettle-like fiber, bark strips, animal hair, sinew later
- **Uses:** input to cordage, stuffing, rough wrap material

## D2. Cleaned Fiber Bundle
- **Category:** Fiber / Processed basic
- **Created by:** stripping, drying, beating, separating, combing as appropriate
- **Uses:** stronger, more reliable cordage and thread

## D3. Rough Cord
- **Category:** Fiber / Processed basic
- **Created by:** twisting fibers or strips together
- **Uses:** tying bundles, simple traps, hanging food, repairing clothing, pegging shelter pieces

## D4. Two-Ply Cordage
- **Category:** Fiber / Processed intermediate
- **Properties:** stronger and more reliable than a casual twist
- **Uses:** basket construction, tool lashing, spear bindings, carrying slings, clothing ties
- **Game note:** should be one of the most important “small” crafted items in the whole early game

## D5. Lashing Bundle
- **Category:** Fiber / Task-oriented consumable
- **Uses:** shelter assembly, rack assembly, repairs, handle attachment
- **Implementation note:** may be either a separate item or a use-state of cordage

## D6. Rough Thread
- **Category:** Fiber / Fine processed item
- **Uses:** sewing hides, stitching mats, attaching pouches, later woven goods
- **Sources:** fine fiber, sinew fibers, hair blends in some cases

## D7. Woven Mat Strip
- **Category:** Fiber craft / Intermediate
- **Uses:** sleeping mat, wind screen, basket lid, wall panel, tray, drying surface

## D8. Basket Frame Elements
- **Category:** Basketry intermediate
- **Uses:** stiffeners/ribs for baskets, fish traps, winnowing trays, carrying frames

## D9. Basket Weave Stock
- **Category:** Basketry intermediate
- **Uses:** pliable strips or reeds ready for weaving
- **Game note:** species, soak state, and freshness can matter for workability

---

# 8E. Animal-derived items

## E1. Fresh Carcass (Small Game)
- **Category:** Animal / Raw whole-body resource
- **Uses:** meat, organs, hide, bones, sinew, fat, feathers/fur depending species
- **Risks:** fast spoilage, attracting predators/scavengers, contamination at camp
- **Game note:** location of butchering should matter for sanitation

## E2. Fresh Carcass (Medium Game)
- **Category:** Animal / Raw whole-body resource
- **Properties:** large labor spike, more outputs, higher risk if left unprocessed
- **Uses:** major protein and hide source, larger bone supply, more fat, more carrying challenge

## E3. Fresh Meat Portion
- **Category:** Food / Raw perishable
- **Uses:** cooking, drying, smoking, broth, bait
- **Storage:** cool/shaded/covered only buys time, not safety forever

## E4. Organ Meat Bundle
- **Category:** Food / Raw high-priority perishable
- **Uses:** immediate food, broth, fat extraction from some tissues
- **Game note:** should spoil faster than many dry goods and often faster than dried muscle meat potential

## E5. Bone Bundle
- **Category:** Animal material / Raw craft input
- **Uses:** marrow extraction, awl blanks, needle-like points later, fish hooks later, grease/broth, tool handles in some cases

## E6. Cracked Marrow Bone
- **Category:** Animal material / Processed food-craft byproduct
- **Uses:** food extraction complete or partial, later broth stock, craft fragments

## E7. Bone Shard / Bone Blank
- **Category:** Craft intermediate
- **Uses:** awl, needle-like point, scraper, decorative marker much later

## E8. Sinew Bundle
- **Category:** Animal material / High-value fine fiber
- **Uses:** strong binding, thread, bow backing later, tool lashings, sewing
- **Limits:** requires processing and drying; vulnerable to moisture

## E9. Raw Hide / Skin
- **Category:** Animal material / Raw high-value perishable
- **Uses:** potential clothing, straps, water container, shelter patch, bedding layer
- **Risks:** rots quickly if neglected

## E10. Fleshed Hide
- **Category:** Animal material / Processed basic
- **Created by:** removing attached flesh/fat/membrane
- **Uses:** next stage toward rawhide or softened hide

## E11. Scraped / Dehaired Hide
- **Category:** Animal material / Processed intermediate
- **Created by:** scraping hair or flesh side as needed for intended finish
- **Uses:** rawhide path, soft hide path, straps, container material

## E12. Air-Dried Rawhide
- **Category:** Animal material / Hard dried sheet
- **Properties:** hard, strong, shrinks while drying, not soft clothing material
- **Uses:** lashings, drumhead later, hard container parts, reinforcing bands, shields much later
- **Game note:** rawhide and soft smoked hide should be separate materials

## E13. Softened Hide
- **Category:** Animal material / Soft intermediate
- **Created by:** working fats/oils/brains and physically softening while drying
- **Uses:** clothing, wraps, pouch material, bedding, straps

## E14. Smoked Hide / Primitive Buckskin-Like Material
- **Category:** Animal material / Finished early clothing material
- **Properties:** softer, more durable in repeated use, better for garments than rawhide
- **Uses:** tunics, leggings, pouches, moccasin-like footwear, blankets, coverings

## E15. Fur Pelt
- **Category:** Animal material / Thermal material
- **Uses:** insulation, bedding, winter wraps, prestige/comfort, trade later
- **Storage:** dry, pest-protected

## E16. Renderable Fat Tissue
- **Category:** Food/craft intermediate
- **Uses:** food, rendered grease, hide treatment, lamp/fuel experiments later

## E17. Feather Bundle
- **Category:** Animal material / Light craft input
- **Uses:** bedding fill, fletching later, insulation, marker/ornament later

## E18. Egg / Egg Bundle
- **Category:** Food / Raw fragile
- **Uses:** immediate food, baking later, binding in some later crafts, high-value gathered nutrition
- **Risks:** breakage, fast spoilage in warmth

---

# 8F. Food plant and gathered food items

## F1. Edible Greens Bundle
- **Category:** Food / Gathered perishable
- **Uses:** immediate nutrition, stew, drying only for some species
- **Risks:** identification error, spoilage, wilting

## F2. Root / Tuber Bundle
- **Category:** Food / Gathered moderate shelf-life
- **Uses:** immediate food, roasting, stew, planting stock for some species
- **Storage:** cool, dry, protected from rodents; some species store much better than leafy foods

## F3. Berry / Soft Fruit Bundle
- **Category:** Food / Gathered perishable
- **Uses:** immediate eating, drying, mash, flavoring, morale boost
- **Risks:** bruising, fermentation, pests

## F4. Nut / Hard Seed Bundle
- **Category:** Food / Gathered storable
- **Uses:** direct eating, crushing, oil/fat contribution, planting depending species, winter reserve
- **Storage:** dry, pest-protected

## F5. Seed Head Bundle
- **Category:** Food/agriculture / Raw harvest
- **Uses:** cleaning, drying, threshing/rubbing, saving as seed or eating later
- **Game note:** should not instantly become generic grain

## F6. Cleaned Seed / Grain-Like Food
- **Category:** Food/agriculture / Processed basic
- **Uses:** eating, parching, grinding later, seed reserve if viability preserved
- **Risks:** moisture, insects, rodents

## F7. Planting Seed Stock
- **Category:** Agriculture / Strategic input
- **Uses:** planting, experimentation, crop continuity
- **Priority:** should be protected from automatic consumption except in desperation or player override
- **Game note:** one of the most important strategic items in the early settlement phase

## F8. Dried Plant Food Bundle
- **Category:** Food / Preserved
- **Examples:** dried berries, sliced dried roots, dried herbs, dried greens where applicable
- **Uses:** winter reserve, travel food, soups and stews

## F9. Parched Seed / Roasted Seed
- **Category:** Food / Processed ready-to-eat
- **Uses:** travel ration, lower spoilage than wet cooked mash, morale-neutral staple

## F10. Mushroom Bundle (Identified Safe)
- **Category:** Food / Gathered highly knowledge-dependent
- **Uses:** immediate food, drying for some species
- **Game note:** should be strongly gated by knowledge and caution traits

## F11. Insect Protein Bundle
- **Category:** Food / Gathered opportunistic
- **Uses:** emergency protein, bait, poultry feed later
- **Game note:** biome and culture-dependent; should not be treated as universally desirable but as realistic option

## F12. Shellfish / Small Aquatic Gather Bundle
- **Category:** Food / Gathered perishable
- **Uses:** immediate cooking, bait, protein source near water
- **Risks:** contamination, fast spoilage, source-dependent safety

---

# 8G. Fuel and fire-management items

## G1. Tinder Bundle
- **Category:** Fuel / Ignition aid
- **Examples:** dry grass, bark fiber, punkwood dust, dry inner bark, seed fluff, bird nest material
- **Uses:** starting ember/flame
- **Storage:** must stay dry; extremely low mass, high utility

## G2. Ember Carrier / Ember Nest
- **Category:** Fire-management / Utility item
- **Uses:** preserving fire between tasks or short movements
- **Game note:** can reduce repeated full fire-start attempts

## G3. Kindling Bundle
- **Category:** Fuel / Ignition-stage
- **Uses:** bridging between tinder and sustained fuelwood

## G4. Dry Fuelwood Bundle
- **Category:** Fuel / Core fire input
- **Uses:** cooking, boiling, warmth, smoke production
- **Game note:** should differ in burn duration from kindling and logs

## G5. Long-Burn Firewood Section
- **Category:** Fuel / Sustained heat input
- **Uses:** overnight heat, long boiling, hide smoking, firing support
- **Transport:** relatively costly

## G6. Damp Wood Bundle
- **Category:** Fuel / Poor-quality input
- **Uses:** emergency heat, smoke-heavy fires, slower drying racks, smokehouse effects
- **Game note:** useful but frustrating

## G7. Resinous Tinder / Fatwood-Like Material
- **Category:** Fuel / High-quality ignition aid
- **Uses:** easier fire starts, wet-weather help
- **Biome dependence:** not always available

## G8. Charcoal Bundle
- **Category:** Fuel / Processed high-value heat source
- **Era in scope:** late edge of current scope
- **Uses:** hotter cleaner fires, pottery help, future metallurgy bridge
- **Requirements:** controlled burning / pit burn knowledge

## G9. Ash Bucket / Ash Pile
- **Category:** Byproduct / Maintenance output
- **Uses:** cleaning, waste cover, soil amendment in small controlled amounts, lye path much later

---

# 8H. Containers, carrying gear, and storage goods

## H1. Carrying Bundle
- **Category:** Temporary transport state
- **Created by:** tying or folding materials together for hand carry
- **Uses:** emergency hauling of brush, sticks, reeds, food, hides
- **Limits:** poor organization, often occupies both hands

## H2. Carrying Sling
- **Category:** Carrying gear / Primitive tool
- **Uses:** shoulder carry for wood, hide bundle, food bundle, stone transport
- **Importance:** large quality-of-life boost for one NPC

## H3. Simple Basket
- **Category:** Container / Carry-storage essential
- **Material basis:** basketry reeds, bark strips, roots, splints, grasses, flexible twigs
- **Uses:** gather plants, carry fuel, hold drying food, store dry goods, sort work materials
- **Limits:** not automatically liquid-proof, can trap moisture if contents are packed damp

## H4. Tightly Woven Basket
- **Category:** Container / Improved dry storage
- **Uses:** grain, seed, nuts, dried foods, fiber stock, small tools
- **Properties:** better pest resistance and less spill loss than rough basket

## H5. Lined Basket
- **Category:** Container / Specialized intermediate
- **Liners:** bark, hide, leaves, pitch later, cloth later
- **Uses:** transport damp clay, hold moist foods briefly, sometimes hold liquids for short periods depending lining quality
- **Game note:** should not replace real pots for boiling/cooking

## H6. Hide Bag / Pouch
- **Category:** Container / Soft storage
- **Uses:** seed, dried foods, tool kit, personal kit, cordage stock
- **Risks:** mold if packed damp, wear at seams, pests

## H7. Water Skin / Skin Bag
- **Category:** Container / Liquid transport
- **Uses:** carrying water away from source once hide-processing is advanced enough
- **Limits:** quality depends heavily on workmanship and hide treatment; may taint water; not ideal forever-storage

## H8. Bark Container / Folded Bark Tray
- **Category:** Container / Primitive short-term
- **Uses:** carrying berries, dry food prep, serving, temporary holding of ingredients

## H9. Clay Bowl
- **Category:** Vessel / Fragile hard container
- **Uses:** eating, ingredient prep, fat rendering support, dry storage, serving

## H10. Clay Jar
- **Category:** Vessel / Medium-term storage
- **Uses:** water storage, dry storage, seed storage, fermentation experiments later
- **Limits:** unglazed pottery remains porous and breakable

## H11. Cooking Pot
- **Category:** Vessel / Core camp infrastructure
- **Uses:** boiling water, stews, rendering fat, softening plant foods, hide soaking in small batches, dyeing later
- **Importance:** a major threshold item

## H12. Covered Storage Pot
- **Category:** Vessel / Improved storage
- **Uses:** seed, dried food, nuts, fat, prepared reserves
- **Importance:** helps separate strategic stores from daily-use food

## H13. Pit Cache Lining Material
- **Category:** Storage support
- **Examples:** bark, dry grass, stones, pottery sherd drainage layer
- **Uses:** protecting cached food and seed from direct soil moisture

## H14. Raised Rack / Hanging Loop Stock
- **Category:** Storage support / Crafted utility
- **Uses:** suspend food or gear away from pests and damp ground

---

# 8I. Clothing, bedding, and personal survival goods

## I1. Brush Bedding
- **Category:** Bedding / Primitive comfort-survival
- **Uses:** first-night insulation, keeps body off wet ground
- **Limits:** fast compression and decay; may harbor insects if neglected

## I2. Grass Bedding Bundle
- **Category:** Bedding / Improved primitive
- **Uses:** sleeping layer, mat fill, winter insulation layer
- **Storage:** dry under cover

## I3. Fur Bedding Layer
- **Category:** Bedding / Thermal
- **Uses:** cold-weather sleep, sick/injured recovery, high morale boost
- **Limits:** pest risk, moisture sensitivity

## I4. Woven Mat
- **Category:** Bedding/furnishing / Intermediate
- **Uses:** sleeping, work surface, drying surface, kneeling pad, wall lining

## I5. Crude Plant Wrap
- **Category:** Clothing / Emergency
- **Uses:** modest warmth, sun protection, skin protection from brush and insects
- **Limits:** low durability, low weather resistance

## I6. Hide Wrap
- **Category:** Clothing / Early essential
- **Uses:** warmth, rain/splash reduction, sleeping cover, hauling aid
- **Importance:** can double as clothing and gear

## I7. Soft Hide Garment Piece
- **Category:** Clothing / Intermediate
- **Examples:** tunic, leggings, simple skirt/wrap, shoulder cape
- **Uses:** cold protection, injury reduction from brush, social decency/morale

## I8. Foot Wraps
- **Category:** Clothing / High-value survival item
- **Uses:** blister reduction, warmth, modest protection from rough ground
- **Materials:** grass, cloth later, hide, fur, bark inner layer depending design

## I9. Simple Soft-Hide Footwear
- **Category:** Clothing / Improved mobility item
- **Uses:** reduced foot injury, better cold-weather travel, role prestige marker later

## I10. Personal Carry Pouch
- **Category:** Personal gear
- **Uses:** tinder, small tools, medicine plants, cordage, seeds, emergency ration
- **Game note:** a strong early-game “efficiency” item for specific NPC roles

---

# 8J. Primitive tool items

## J1. Digging Stick
- **Category:** Tool / Primitive multipurpose
- **Uses:** digging roots, shallow pits, planting holes, probing soil, prying
- **Importance:** foundational before hoes/spades exist

## J2. Sharpened Stick / Simple Spear
- **Category:** Tool/weapon / Primitive
- **Uses:** hunting, defense, fish striking in some conditions, carrying suspended loads, fire poker
- **Variants:** fire-hardened point, stone-tipped point later

## J3. Hafted Stone Knife / Cutter
- **Category:** Tool / Improved primitive
- **Uses:** butchering, hide work, woodworking, cord cutting
- **Requirements:** stone edge + handle + binding

## J4. Stone Scraper
- **Category:** Tool / Primitive hide-work essential
- **Uses:** hide fleshing, bark shaving, wood smoothing

## J5. Bone Awl
- **Category:** Tool / Fine craft primitive
- **Uses:** piercing hide, basket repair, sewing prep, cordage work

## J6. Bone Needle-Like Tool
- **Category:** Tool / Fine craft intermediate
- **Uses:** sewing soft hide and fine fiber, pouch repair, footwear work
- **Note:** may arrive slightly later than awl because eye drilling/slotting is harder

## J7. Mallet / Baton
- **Category:** Tool / Structural utility
- **Uses:** driving stakes, gentle splitting, bark processing, cordage work support

## J8. Fire Drill Set / Fire Kit
- **Category:** Tool set / Specialized utility
- **Uses:** repeatable fire making once knowledge exists
- **Game note:** should be distinct from merely “having fire knowledge”

## J9. Carry Pole
- **Category:** Tool / Logistics
- **Uses:** suspended loads, two-person carry later, hide/wood haul

## J10. Drag Sled / Brush Drag
- **Category:** Tool / Logistics intermediate
- **Uses:** wood haul, hide haul, reed haul, clay haul on suitable ground
- **Importance:** important before carts exist

---

# 8K. Camp, sanitation, and work-support items

## K1. Hearth Stone Set
- **Category:** Camp infrastructure / Placed materials
- **Uses:** contains fire, supports pots, marks cooking zone

## K2. Firewood Reserve
- **Category:** Stockpile / Strategic reserve
- **Uses:** winter survival, storm resilience, continuous boiling/cooking
- **Game note:** should be tracked separately from scattered wood on ground

## K3. Waste Cover Material
- **Category:** Sanitation support
- **Examples:** ash, dry soil, leaves, straw
- **Uses:** covering latrine use, reducing odor/flies, carcass pit cover

## K4. Refuse Bundle
- **Category:** Waste / Contamination risk
- **Composition:** spoiled food, bloody scraps, sweepings, broken plant matter, unneeded bones
- **Uses:** compost much later, bait/scavenger attraction if unmanaged, dog feed later
- **Game note:** location matters

## K5. Carcass Disposal Material
- **Category:** Waste handling support
- **Examples:** soil cover, brush, stones, ash
- **Uses:** burial/pit management of remains not kept for use

## K6. Drying Rack Stock
- **Category:** Structural utility intermediate
- **Uses:** food drying, hide drying, gear drying, cordage drying

## K7. Smoking Rack / Frame Stock
- **Category:** Structural utility intermediate
- **Uses:** smoke-drying fish/meat, hide smoking, insect reduction for some stored goods

## K8. Fence Stakes
- **Category:** Structural consumable
- **Uses:** garden protection, work-yard definition, deterrent line, drying line supports

## K9. Woven Screen / Wattle Panel
- **Category:** Structural intermediate
- **Uses:** windbreak, fence, drying support, wall infill, animal pen starter later

## K10. Covered Food Hanger Set
- **Category:** Storage/sanitation utility
- **Uses:** hanging food out of reach of some pests, airflow drying
- **Limits:** not absolute predator-proofing

---

# 8L. Agriculture and proto-settlement items

## L1. Gathered Seed Reserve
- **Category:** Agriculture / Strategic
- **Uses:** first attempts at deliberate sowing, experimentation, insurance for next season
- **Game note:** different from random edible seed because viability matters

## L2. Planting Tubers / Cuttings
- **Category:** Agriculture / Strategic propagules
- **Uses:** transplantation and vegetative propagation
- **Importance:** realistic for many early crops and useful plants

## L3. Cleared Plant Patch Yield
- **Category:** Agriculture / Transitional field output
- **Meaning:** not yet true field agriculture, but intensified tending of useful plants
- **Outputs:** edible plants, seed, fibers, medicinal herbs, mulch material depending patch

## L4. Garden Plot Debris
- **Category:** Agriculture byproduct
- **Uses:** mulch, compost feedstock later, bedding, kindling, animal feed later

## L5. Brush Fence Material
- **Category:** Agriculture / Protection input
- **Uses:** keep animals out, define growing space, reduce trampling

## L6. Seed Drying Tray / Mat
- **Category:** Agriculture utility item
- **Uses:** drying seed heads, sorting seed, winnowing, protecting seed from direct soil contact

## L7. Winnowing Tray
- **Category:** Agriculture utility / Basketry item
- **Uses:** separating chaff/light debris from heavier seed or grain
- **Importance:** bridges basketry and food processing

## L8. Granary Pot / Seed Pot
- **Category:** Storage / Strategic vessel
- **Uses:** protected seed stock separate from daily food stores

## L9. Mulch Bundle
- **Category:** Agriculture support
- **Uses:** moisture retention, weed suppression, soil cover, erosion reduction in small plots
- **Materials:** straw, leaves, dry grass, light brush

## L10. Compostable Organic Mix
- **Category:** Agriculture / Waste-input precursor
- **Uses:** soil improvement path later; not instantly usable fertilizer
- **Game note:** decomposition takes time and can attract pests if poorly managed

---

# 8M. Hamlet-threshold goods

## M1. Pottery Batch
- **Category:** Craft output / Batch item
- **Composition:** bowls, jars, lids, sherd losses
- **Uses:** scaling containers for a multi-NPC camp
- **Game note:** one batch may yield multiple item outputs plus breakage

## M2. Hideworking Stock
- **Category:** Craft stock / Workplace item
- **Composition:** hides in different states, scrapers, fat, awls, cordage, drying frames
- **Uses:** clothing and pouch production for multiple NPCs

## M3. Basketry Stock
- **Category:** Craft stock / Workplace item
- **Composition:** weave stock, ribs, finished baskets, repair material
- **Uses:** expanding logistics and storage as population rises

## M4. Seed Reserve Lot
- **Category:** Strategic food/agriculture lot
- **Uses:** ensures a hamlet can plant instead of consuming everything over winter
- **Importance:** should be visible in UI as one of the settlement’s most valuable stocks

## M5. Dry Food Reserve Lot
- **Category:** Strategic reserve
- **Composition:** dried meat, dried plant food, nuts, seeds, roots, preserved fats where possible
- **Uses:** winter resilience, support for non-gatherer work time, support for new arrivals

## M6. Clothing Reserve Stock
- **Category:** Settlement support stock
- **Composition:** wraps, spare foot wraps, hide scraps, repair thread, patch pieces
- **Uses:** replacing worn gear, preparing for newcomers, reducing winter mortality/misery

## M7. Maintenance Stock
- **Category:** Settlement support stock
- **Composition:** cordage, stakes, patch bark, clay repair material, spare scrapers, spare pot sherd grog
- **Uses:** keep camp structures functioning rather than always building from zero

---

# 9. Items that should be modeled as separate despite looking similar

These separations matter for realism.

## 9.1 Water distinctions
Do **not** collapse all water into one item.
At minimum separate:
- dirty source water
- treated drinkable water
- utility water

## 9.2 Wood distinctions
Do **not** collapse all wood into one item.
At minimum separate:
- tinder
- kindling
- dry fuelwood
- structural poles/saplings
- brush

## 9.3 Hide distinctions
Do **not** collapse hide into one item.
At minimum separate:
- raw hide
- rawhide
- softened/smoked soft hide
- hide scraps

## 9.4 Seed distinctions
Do **not** collapse all seeds/plants into one item.
At minimum separate:
- edible gathered seeds
- planting seed stock
- damaged/nonviable seed

## 9.5 Clay distinctions
Do **not** collapse clay and pots into one item.
At minimum separate:
- raw clay
- tempered clay
- unfired vessel
- fired vessel
- broken sherds/grog

## 9.6 Fiber distinctions
Do **not** collapse plant fiber and cordage into one item.
At minimum separate:
- raw fiber/strips
- cleaned fiber
- cordage/twine
- sewing thread/fine binding

---

# 10. Suggested early-game priority items

If the database grows too fast, the first implementation pass should still prioritize these.

## 10.1 Day 1 priorities
1. dirty surface water
2. tinder bundle
3. kindling bundle
4. fuelwood bundle
5. hammerstone
6. sharp flake
7. digging stick
8. green branch / pole
9. brush bundle
10. grass bedding bundle
11. edible greens bundle
12. root/tuber bundle
13. fresh small-game carcass
14. carrying bundle
15. carrying sling

## 10.2 First week priorities
16. scraper stone
17. dry food hanger set
18. rough cord
19. two-ply cordage
20. simple basket
21. hide bag
22. raw hide
23. fleshed hide
24. dried rawhide
25. softened hide
26. hide wrap
27. foot wraps
28. boiled water
29. stored potable water
30. refuse bundle
31. waste cover material

## 10.3 Permanent-camp priorities
32. cleaned clay
33. temper
34. clay bowl
35. cooking pot
36. covered storage pot
37. drying rack stock
38. smoking frame stock
39. dried meat
40. dried plant food bundle
41. cleaned seed
42. planting seed stock
43. seed drying tray
44. winnowing tray
45. brush fence material
46. woven mat
47. bone awl
48. rough thread

## 10.4 Hamlet-threshold priorities
49. pottery batch
50. basketry stock
51. hideworking stock
52. dry food reserve lot
53. seed reserve lot
54. clothing reserve stock
55. maintenance stock
56. fence stakes
57. woven screen/wattle panel
58. charcoal bundle
59. granary pot / seed pot
60. long-burn firewood reserve

---

# 11. Suggested UI groupings for this item layer

For minimal visuals and dense UI, the inventory should be filterable by practical function rather than only by abstract category.

## 11.1 Survival
- potable water
- immediate food
- bedding
- clothing
- fire supplies
- medical basics later

## 11.2 Building and repair
- poles
- saplings
- brush
- bark
- cordage
- stakes
- clay repair stock

## 11.3 Food processing and preservation
- fresh meat
- drying meat
- dried meat
- fresh plants
- drying plants
- dried foods
- fat
- cooking vessels

## 11.4 Carrying and storage
- baskets
- pots
- pouches
- skins
- racks
- pit cache supplies

## 11.5 Craft materials
- knappable stone
- bone blanks
- fiber bundles
- cleaned fiber
- hides by state
- clay by state
- temper

## 11.6 Agriculture
- edible seed
- planting seed
- cuttings/tubers
- mulch
- fencing materials
- drying trays

## 11.7 Waste and sanitation
- refuse
- spoiled food
- ash
- latrine cover material
- carcass remains

---

# 12. Balance and realism cautions

## 12.1 Do not overvalue finished tools while undervaluing support goods
In this type of game, the “boring” support items are civilization multipliers:
- baskets
- cordage
- dry bedding
- storage pots
- seed pots
- drying racks
- covered water containers

These should often matter as much as obvious headline items like spears or knives.

## 12.2 Do not make smoked food unrealistically immortal
Smoke helps, but moisture control, cleanliness, insects, temperature, and storage still matter.

## 12.3 Do not make raw hides passively stable
Raw hides should rapidly become urgent work unless weather is very cold.

## 12.4 Do not let planting seed behave like generic food
A desperate camp may consume seed stock, but this should be visible as a strategic sacrifice with future cost.

## 12.5 Do not let all containers do the same job
- baskets are good for dry goods and airflow
- skins are good for some transport tasks
- pottery is good for boiling and protected storage but fragile and heavy
- pits are good for cool storage if designed well, terrible if wet/dirty

---

# 13. Best next follow-up after this document

The strongest follow-up document is:

## **Process Bible v0.1**
Because this item layer is only truly useful when paired with explicit transformations such as:
- gather water
- settle/filter/boil/store water
- gather fuel and sort it by fire role
- make cordage
- build basket
- butcher carcass
- flesh and scrape hide
- dry meat
- smoke-dry meat
- dry and soften hide
- collect clay and temper it
- shape and fire pottery
- save and dry seed
- prepare bedding
- build rack / cache / latrine / fence

That process bible should reference these items directly.

---

# 14. Source notes

The following sources were used to sharpen realism in this document.

- **[S1] CDC — How to Make Water Safe in an Emergency**
  https://www.cdc.gov/water-emergency/about/index.html
- **[S2] CDC — Preventing Drinking Water-Related Illnesses**
  https://www.cdc.gov/drinking-water/prevention/index.html
- **[S3] Britannica — Pottery**
  https://www.britannica.com/art/pottery
- **[S4] Britannica — Pottery: Drying, Turning, Firing**
  https://www.britannica.com/art/pottery/Drying-turning-and-firing
- **[S5] Britannica — Traditional Ceramics / Vitrification**
  https://www.britannica.com/technology/traditional-ceramics/Vitrification
- **[S6] Britannica — Basketry: Uses**
  https://www.britannica.com/art/basketry/Uses
- **[S7] Britannica — Basketry: Origins and centres of development**
  https://www.britannica.com/art/basketry/Origins-and-centres-of-development
- **[S8] Britannica — Cordage**
  https://www.britannica.com/technology/cordage
- **[S9] Britannica — Bast fiber / Leaf fiber / Natural fiber**
  https://www.britannica.com/technology/bast-fiber
  https://www.britannica.com/science/leaf-fiber
  https://www.britannica.com/topic/natural-fiber
- **[S10] Britannica — Hide / Tanning**
  https://www.britannica.com/topic/hide-animal-skin
  https://www.britannica.com/technology/tanning
- **[S11] Northern Arizona University — Tanning Deer Hides and Small Fur Skins**
  https://jan.ucc.nau.edu/tct/tanning.pdf
- **[S12] Colorado State University Extension — Tanning Leather Parts I & II**
  https://tra.extension.colostate.edu/wp-content/uploads/sites/9/2017/05/24.TanningLeather1.pdf
  https://tra.extension.colostate.edu/wp-content/uploads/sites/9/2017/05/25.TanningLeather2.pdf
- **[S13] WSU Extension — Food Preservation: Drying and Smoking**
  https://extension.wsu.edu/foodsafety/food-preservation-drying-and-smoking/
- **[S14] National Center for Home Food Preservation — Curing & Smoking**
  https://nchfp.uga.edu/how/cure-smoke
- **[S15] MSU Extension — Smoking as a food cooking method**
  https://www.canr.msu.edu/news/smoking_as_a_food_cooking_method
- **[S16] FAO — Appropriate Seed and Grain Storage Systems for Small-scale Farmers**
  https://openknowledge.fao.org/server/api/core/bitstreams/a0b28a0c-0d9b-431f-9716-c9d78ee9ebfd/content
- **[S17] FAO — Seeds in Emergencies: a technical handbook**
  https://www.fao.org/4/i1816e/i1816e00.pdf
- **[S18] FAO — Grain crop drying, handling and storage**
  https://www.fao.org/4/i2433e/i2433e10.pdf
- **[S19] NPS — Dispose of Waste Properly / Leave No Trace Principle #3**
  https://www.nps.gov/articles/000/idkt_lnt_3.htm
- **[S20] NPS — Grand Teton Backcountry guidance**
  https://www.nps.gov/grte/planyourvisit/back.htm
- **[S21] NPS — Glacier Bay human waste disposal guidance**
  https://www.nps.gov/glba/learn/news/392012.htm

---

# 15. Short conclusion

The early game item layer should make the player feel that civilization is being built out of:
- water that must be made safer and stored well
- materials that weather, rot, mold, crack, and wear
- containers that change what is possible
- fibers, hides, and clay that become more valuable as knowledge improves
- seed and preserved food that create the first real surplus

In this design, a basket, a pot, a dry sleeping mat, and a protected seed reserve are not background clutter.
They are civilization.
