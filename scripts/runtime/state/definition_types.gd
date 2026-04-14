extends RefCounted
class_name DefinitionTypes

const TYPE_STAGE: String = "stage"
const TYPE_SKILL: String = "skill"
const TYPE_ITEM: String = "item"
const TYPE_PROCESS: String = "process"
const TYPE_STRUCTURE: String = "structure"
const TYPE_SCENARIO: String = "scenario"
const TYPE_MAP_PRESET: String = "map_preset"

# Compatibility placeholder families for later world/system branches.
const TYPE_SPECIES: String = "species"
const TYPE_TERRAIN_PROFILE: String = "terrain_profile"
const TYPE_WORLDGEN_PROFILE: String = "worldgen_profile"
const TYPE_SEASON_PROFILE: String = "season_profile"

# Final Branch 01 placeholder families for alerts/incidents/UI metadata.
const TYPE_INCIDENT: String = "incident"
const TYPE_UI_PANEL: String = "ui_panel"

const ALL_TYPES: Array = [
	TYPE_STAGE,
	TYPE_SKILL,
	TYPE_ITEM,
	TYPE_PROCESS,
	TYPE_STRUCTURE,
	TYPE_SCENARIO,
	TYPE_MAP_PRESET,
	TYPE_SPECIES,
	TYPE_TERRAIN_PROFILE,
	TYPE_WORLDGEN_PROFILE,
	TYPE_SEASON_PROFILE,
	TYPE_INCIDENT,
	TYPE_UI_PANEL,
]

const DIRECTORY_BY_TYPE: Dictionary = {
	TYPE_STAGE: "res://data/defs/stages",
	TYPE_SKILL: "res://data/defs/skills",
	TYPE_ITEM: "res://data/defs/items",
	TYPE_PROCESS: "res://data/defs/processes",
	TYPE_STRUCTURE: "res://data/defs/structures",
	TYPE_SCENARIO: "res://data/defs/scenarios",
	TYPE_MAP_PRESET: "res://data/defs/map_presets",
	TYPE_SPECIES: "res://data/defs/species",
	TYPE_TERRAIN_PROFILE: "res://data/defs/terrain_profiles",
	TYPE_WORLDGEN_PROFILE: "res://data/defs/worldgen_profiles",
	TYPE_SEASON_PROFILE: "res://data/defs/season_profiles",
	TYPE_INCIDENT: "res://data/defs/incidents",
	TYPE_UI_PANEL: "res://data/defs/ui_panels",
}

static func is_supported_type(definition_type: String) -> bool:
	return ALL_TYPES.has(definition_type)

static func get_directory_for_type(definition_type: String) -> String:
	if not DIRECTORY_BY_TYPE.has(definition_type):
		return ""

	return str(DIRECTORY_BY_TYPE[definition_type])

static func get_all_types() -> Array:
	return ALL_TYPES.duplicate()
