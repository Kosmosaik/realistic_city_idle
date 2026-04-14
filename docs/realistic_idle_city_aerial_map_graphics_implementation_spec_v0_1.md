# Realistic Idle City — Aerial Map Graphics Implementation Spec v0.1

## Purpose

This document turns the current synthetic-aerial / topographic map direction into a **graphics-focused implementation spec**.

It is not the source of truth for world logic or site scoring.
It assumes those come from the existing world-generation, terrain, hydrology, exploration, and UI documents.

This spec defines:
- how the map should **look** at different zoom levels
- how simulation data should be translated into an **aerial-photo-like read**
- how to structure the rendering stack in Godot without breaking the simulation-first architecture
- what should be hand-authored versus generated
- what belongs in MVP, what can be simplified, and what should wait

The target is:
- readable from far zoom
- grounded and natural at mid zoom
- still minimal enough to implement early
- rich enough to make the land feel like a real place rather than colored debug tiles

---

# 1. Core stance

## 1.1 Simulation truth stays separate from graphics truth

The map renderer must **interpret** world data, not replace it.

Simulation truth remains:
- elevation
- slope
- drainage
- landform
- wetness
- vegetation density / cover type
- buildability
- traversability
- hazards
- exploration / memory state

Graphics truth is only the **presentation layer** that helps the player read those conditions quickly.

## 1.2 The target look is “synthetic aerial”

The correct target is not literal satellite-photo realism.
The correct target is a **convincing aerial-photo-like map** built from simulation data and stylized rendering rules.

That means:
- believable terrain patterning
- recognizable woodland, meadow, ridge, wetland, and water shapes
- tonal richness and surface breakup
- subtle height cues
- clear human footprint when activity begins
- no dependence on large traditional sprite sheets

## 1.3 Readability beats cleverness

Every graphics choice must help answer practical questions:
- where is water
- where is dry ground
- where is dense cover
- where is open movement space
- where is likely good camp land
- where has the settlement changed the land
- what is known, remembered, or unseen

If a visual trick is beautiful but confuses terrain reading, it should be removed.

---

# 2. Visual design goals

## 2.1 First impression goals

At a glance, the player should perceive:
- low ground vs raised ground
- open ground vs covered ground
- wet zones vs dry zones
- watercourse shape and reachability
- clearings and likely travel corridors
- settlement disturbance over time

## 2.2 Aerial-photo cues to emulate

The renderer should imitate these aerial cues:
- large irregular land-cover masses rather than repeated tiles
- subtle brightness shifts across ground types
- soft edge blending at terrain transitions
- darker, denser canopy masses in woodland blocks
- stream-edge darkening and damp margins
- local texture variation inside the same terrain class
- faint hillshade and contour support where useful

## 2.3 What not to emulate

Avoid:
- literal photographic texture collages
- hyper-sharp repeating tile seams
- giant fake cliff sidewalls
- oversaturated colors
- noisy microdetail that destroys zoom readability
- world art that hides gameplay-relevant differences

---

# 3. Visual truth layers

The map should be built in these visual layers.

## 3.1 Base chroma layer

A broad-toned color foundation derived from landform, drainage, and surface class.

Examples:
- dry meadow: muted yellow-green / olive
- damp ground: darker cool green-brown
- ridge / exposed ground: dusty brown-gray
- open water: deeper cool blue-green
- shallow edge / saturated bank: desaturated teal-brown transition

This is the first “read” at far zoom.

## 3.2 Surface breakup layer

Large soft variation inside each terrain class so the land does not look flat or tiled.

This includes:
- mottled soil value shifts
- thin discoloration bands
- sparse bare-earth freckles in drier open ground
- faint moisture staining in low areas

This should be subtle.
It is there to make the terrain feel natural, not noisy.

## 3.3 Land-cover impression layer

This layer gives shape to vegetation communities.

Examples:
- meadow roughness
- brush pockets
- woodland canopy masses
- riparian fringe
- reed bands around wet zones

This should read as **surface cover from above**, not side-view objects.

## 3.4 Hydrology / wetness layer

This layer communicates:
- open water
- shore / margin condition
- damp low areas
- channel direction
- sometimes flood-prone bands

Water must feel carved into the land rather than stamped on top.

## 3.5 Elevation support layer

This is where hillshade and contour lines live.

They should support the aerial view, not dominate it.

## 3.6 Human footprint layer

This is one of the most important late-read layers.

As the player/NPCs act, the map should gradually show:
- worn paths
- trampled camp ground
- cut clearings
- stored material areas
- hearth/ash disturbance
- drying racks / fenced plots / worked soil later

The land should visibly remember occupation.

## 3.7 Fog / knowledge layer

This stays above terrain and features.
It should dim, obscure, and simplify according to knowledge state without deleting the terrain model itself.

---

# 4. Zoom-band strategy

The graphics system must behave differently by zoom band.

## 4.1 Far zoom

Purpose:
- map reading
- site comparison
- exploration planning
- terrain understanding

Priorities:
- strong big-shape readability
- simplified canopy masses
- strong water readability
- simplified object clutter
- contour / hillshade slightly more visible

Suppress at far zoom:
- small decorative variation
- tiny object silhouettes
- busy edge noise

## 4.2 Mid zoom

Purpose:
- local decision making
- camp siting
- route reading
- work area understanding

Priorities:
- clearer terrain transitions
- clearer canopy breakup
- visible wet margins
- visible first human footprint
- visible structures / stockpiles / work zones as simple marks

## 4.3 Close zoom

Purpose:
- action readability
- small task area inspection
- object placement feedback

Priorities:
- individual object marks can matter more
- ground disturbance becomes more noticeable
- path wear and trampled zones matter
- terrain texture can sharpen slightly

But even here, the map should stay top-down and restrained.
No side-view terrain spectacle.

---

# 5. Godot-facing rendering architecture

## 5.1 Recommended node model

Keep the current simulation-first structure.
The rendering stack should be rooted under the world presentation branch and should not become an alternate truth store.

Recommended world presentation subtree:

```text
WorldRoot
  TerrainVisualRoot
    GroundLayer
    SurfaceVariationLayer
    WetnessLayer
    WaterLayer
    CanopyLayer
    HillshadeLayer
    ContourLayer
    HumanFootprintLayer
    FeatureOverlayLayer
    FogOfWarLayer
  WorldObjectsRoot
  NPCPresentationRoot
  DebugOverlayRoot
  WorldCamera
```

## 5.2 Rendering strategy choice

Do not force the whole map into one technique.
Use a mixed strategy:
- tiles where the grid and editing workflow help
- procedural drawing where soft variation is better
- batched sprites / multimesh-style instancing where repeated canopy/details become numerous
- shaders only where they clearly simplify layering or improve performance

## 5.3 Recommended division of labor

### TileMapLayer-friendly
Use for:
- coarse terrain classification
- contour masks if tile-driven
- some overlay masks
- simple water/shore transitions if tile-authored

### Procedural draw / generated texture friendly
Use for:
- mottled surface breakup
- hillshade texture
- wetness tint masks
- subtle land-cover breakup

### Batched-instance friendly
Use for:
- repeated canopy stamps
- brush patch marks
- scattered rocks/logs if large counts become common

### Scene/node objects
Use for:
- important interactable structures
- stockpiles
- NPCs
- world markers that need selection/inspection

---

# 6. Asset strategy

## 6.1 Prefer small reusable visual primitives

The renderer should be built from a small family of reusable parts:
- tonal palettes
- soft noise fields
- canopy stamps
- shoreline masks
- path wear masks
- contour stroke styles
- simple feature decals

This is better than trying to author giant unique full-map textures.

## 6.2 Ground texture philosophy

Ground should not be one texture per biome tile.
Instead, use:
- a coarse terrain class
- one or two subtle tiling textures or generated fills
- large-scale noise modulation
- localized stains / breakup / directional gradients

This avoids obvious repetition while keeping the system data-driven.

## 6.3 Canopy / cover philosophy

Trees in aerial view should mostly read as:
- clustered crowns
- variable edge density
- darker interior masses
- lighter transition edge toward open space

For MVP, do not attempt realistic individual species crowns everywhere.
Start with cover-family marks that imply density and type.

## 6.4 Water philosophy

Water should show:
- readable center channel
- softer shallow or wet fringe around it
- slight value and hue variation
- width continuity through the landscape

The river should feel like it occupies the terrain rather than simply crossing it.

---

# 7. Hillshade and topographic support

## 7.1 Hillshade role

Hillshade exists to make relief legible without leaving the top-down aesthetic.

It should:
- be subtle in hybrid mode
- be stronger in topographic mode
- use a fixed virtual sun direction for consistency
- respect the discrete elevation model from the world spec

## 7.2 Contours role

Contours are support graphics, not the default main style.

Use contours to:
- help read subtle elevation changes
- compare possible camp sites
- understand drainage basins
- support the topo and hybrid views

## 7.3 Recommended default

Default view should be **hybrid**:
- aerial terrain look underneath
- subtle hillshade
- faint contours only when helpful

Topographic-only mode should remain optional.

---

# 8. Fog of war visual treatment

## 8.1 `unseen`

Should show:
- little or no meaningful terrain detail
- a darkened / muted veil
- maybe only extremely broad silhouette hints if the design allows it

Should not show:
- detailed features
- exact land cover
- water access specifics beyond what the design intends

## 8.2 `explored` / remembered

Should show:
- known terrain forms
- remembered water and cover shapes
- reduced saturation / contrast compared to currently visible land
- simplified object detail

## 8.3 `visible`

Should show the full current render stack for that zoom level.

## 8.4 Performance note

Fog should be a visual mask layer and knowledge-state filter, not a terrain-regeneration pass.

---

# 9. Human-footprint graphics plan

This is crucial for realism.
The map should feel increasingly “used” as humans occupy it.

## 9.1 Early changes

Early game should visually support:
- trampled camp center
- path wear to water source
- fire/hearth discoloration
- brush/wood clearing near camp
- stockpile ground disturbance

## 9.2 Mid changes

Later in the early slice, add:
- clearer path branching
- consistent camp clearing shape
- latrine/waste area discoloration in debug or overlay form where appropriate
- worked soil / first garden plots
- fence or boundary hints when those systems exist

## 9.3 Why this matters

This is where the map stops being a backdrop and becomes a lived-in landscape.
It also helps players read logistics, habits, and settlement maturity without needing big sprites.

---

# 10. Recommended implementation approach by phase

## Phase A — Stable visual contract

Goal:
Define exactly what inputs the graphics system may consume.

Need:
- terrain class fields
- elevation / slope / drainage fields
- vegetation density / cover type fields
- water feature geometry
- fog state fields
- disturbance / path wear / clearing fields

Output:
- one renderer input contract document or schema note

## Phase B — Minimal hybrid renderer

Goal:
Replace the current placeholder look with a true first-pass aerial hybrid.

Build:
- base ground tones
- water/wetness treatment
- canopy clusters that respect water/terrain exclusion rules
- subtle hillshade
- smaller site hint debug marker retained temporarily
- compact HUD remains separate

This is the first branch where the map should begin to feel like an aerial simulation view.

## Phase C — Zoom-aware richness

Goal:
Different detail by zoom band.

Add:
- zoom band thresholds
- canopy simplification/expansion rules
- stronger readability at far zoom
- more detail at mid/close zoom

## Phase D — Human footprint

Goal:
Make occupation visibly alter the land.

Add:
- path wear overlays
- camp ground disturbance
- cut/cleared vegetation marks

## Phase E — Optional render-target hardening

Only if needed later.

Possible additions:
- render some layers into cached textures / subviewports
- cache hillshade / contour composites
- use batched detail rendering where counts become large

This should not be the first solution.

---

# 11. Concrete MVP visual stack

If implemented in the near term, the first real aerial map graphics version should contain exactly this:

1. **Ground tone pass**
   - broad terrain chroma by terrain/wetness/elevation families

2. **Surface variation pass**
   - low-frequency noise modulation
   - very subtle secondary stains

3. **Water pass**
   - channel fill
   - edge fringe
   - pond fill

4. **Canopy pass**
   - clustered circular/elliptical canopy marks
   - respect exclusion rules
   - support density and color variation

5. **Hillshade pass**
   - subtle, fixed-light direction

6. **Site hint debug pass**
   - retained temporarily as explicit debug/prototype aid

7. **Fog-of-war pass**
   - unseen / explored / visible treatment

This is enough to move beyond placeholder art without overbuilding.

---

# 12. Suggested Godot implementation detail

## 12.1 Ground and coarse masks

Use `TileMapLayer` where a grid-aligned layer is useful.
Examples:
- coarse terrain family map
- overlay masks that benefit from grid editing
- some debug visualizations

But do not force soft aerial richness into tile edges alone.

## 12.2 Generated textures or draw passes

Use script-generated drawing or cached image/texture generation for:
- mottled surface variation
- hillshade
- wetness shading
- contour composites if they become more comfortable to generate than tile

## 12.3 Canopy and repeated detail

Start simple:
- draw clustered canopy marks directly or via lightweight sprites

Upgrade later if needed:
- move large repeated marks into a batched instancing path

## 12.4 Fog layer

Keep this as a separate presentation layer fed by exploration/knowledge state.
Do not bake fog into the terrain textures.

## 12.5 Camera handling

The map renderer must be tested explicitly at far, mid, and close zoom.
A beautiful close view that falls apart when zoomed out is not acceptable.

---

# 13. Performance rules

## 13.1 Do not optimize blindly

The first aerial renderer should favor clarity and clean data flow.
Profile before adding complexity.

## 13.2 When to optimize

Optimize when one of these becomes true:
- many repeated canopy/detail marks cause measurable draw overhead
- hillshade/contour regeneration is too expensive during view updates
- fog updates cause visible stalls
- zoom changes trigger too much rework

## 13.3 Optimization order

Preferred order:
1. cache derived textures/masks
2. reduce update frequency for non-critical layers
3. batch repeated detail
4. split large map layers into chunks only when needed
5. move more work into shaders only if the logic stays understandable

---

# 14. Risks and failure modes

## 14.1 “Pretty noise soup”

Risk:
The map gets lots of variation but no readable terrain meaning.

Prevention:
Every layer must reinforce terrain interpretation.

## 14.2 Overly tile-like look

Risk:
The map reads as a board game grid instead of land.

Prevention:
Use low-frequency variation and soft large-shape breakup on top of coarse grid data.

## 14.3 Too much dependence on shaders too early

Risk:
Fast initial visuals, hard later maintenance.

Prevention:
Keep shader use focused and optional in MVP.

## 14.4 Over-detail at close zoom only

Risk:
The map looks good up close but useless from strategic zoom.

Prevention:
Design zoom bands intentionally from the start.

## 14.5 Human footprint missing too long

Risk:
The world never feels inhabited.

Prevention:
Add trample/path/clearing visuals earlier than decorative polish.

---

# 15. Acceptance criteria

A first real aerial graphics implementation is successful when:

- the player can tell water, wet ground, open ground, cover, and rough height differences at a glance
- the map feels more like land viewed from above than debug geometry
- fog-of-war states remain readable and do not corrupt terrain meaning
- zooming out improves strategic readability instead of destroying it
- zooming in reveals enough local richness without switching visual language
- trees and cover placement clearly obey terrain rules
- first human footprint changes are visible once those systems are hooked up
- the renderer still respects the simulation-first architecture

---

# 16. Recommended next implementation order

1. Lock the renderer input contract
2. Replace the placeholder ground with broad terrain chroma
3. Replace the current water pass with a more layered channel/fringe treatment
4. Replace current tree drawing with clustered canopy masses derived from cover density
5. Add subtle hillshade
6. Keep site hint as temporary debug-only marker
7. Add zoom-band tuning
8. Add first human-footprint overlays
9. Harden fog rendering and caching only as needed

---

# 17. Final recommendation

Yes, the aerial-map direction is very viable for this project.

But it should be built as:
- **simulation-derived**
- **zoom-aware**
- **minimal but rich**
- **terrain-readable first**
- **human-footprint responsive**

The right short-term goal is not “photo realism.”
The right short-term goal is:

**a believable hybrid aerial map that makes terrain, water, cover, and occupation legible from the first playable build onward.**
