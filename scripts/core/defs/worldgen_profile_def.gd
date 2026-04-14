extends BaseDef
class_name WorldgenProfileDef

# Minimal worldgen/authored-world compatibility bundle for later branches.
@export var worldgen_profile_id: String = ""
@export var map_preset_ids: PackedStringArray = PackedStringArray()
@export var terrain_profile_ids: PackedStringArray = PackedStringArray()
@export var season_profile_id: String = ""
@export var starter_species_ids: PackedStringArray = PackedStringArray()
@export var authored_only: bool = true

func get_definition_id() -> String:
	return worldgen_profile_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_WORLDGEN_PROFILE

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if worldgen_profile_id.strip_edges().is_empty():
		errors.append("WorldgenProfileDef is missing worldgen_profile_id.")

	if map_preset_ids.is_empty():
		errors.append("%s has no map_preset_ids." % get_debug_label())

	if terrain_profile_ids.is_empty():
		errors.append("%s has no terrain_profile_ids." % get_debug_label())

	if season_profile_id.strip_edges().is_empty():
		errors.append("%s is missing season_profile_id." % get_debug_label())

	return errors
