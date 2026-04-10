# Realistic City Idle

Current implementation status: **Branch 00 — repo bootstrap**

## Source of truth order
1. Latest user instructions in active chat
2. Handoff summary
3. Early-game design docs
4. Base design doc
5. Later-era bridge docs only when compatible with early-game focus

## Current playable target
- lone survivor
- primitive camp
- permanent camp
- tiny hamlet

## Branch 00 scope
- clean Godot boot path
- minimal autoload service layer
- boot scene
- dev world scene
- tiny dev HUD
- visible scenario ID / seed / build version
- no gameplay logic yet

## Current important folders
- `autoload/` cross-scene services only
- `data/` future definitions and balance data
- `scenes/` visible scene composition
- `scripts/presentation/` world and UI presentation scripts
- `scripts/sim/` future simulation scripts
- `assets/` art/audio/shaders/fonts

## Rules
- keep file and folder names in snake_case
- keep node names in PascalCase
- do not hardcode gameplay content into view scripts
- keep simulation truth out of arbitrary scene trees
- prefer data-driven definitions and reusable systems
