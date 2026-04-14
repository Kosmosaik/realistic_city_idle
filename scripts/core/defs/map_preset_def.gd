extends BaseDef
class_name MapPresetDef

@export var map_preset_id: String = ""
@export var fixture_id: String = ""
@export var world_width_cells: int = 64
@export var world_height_cells: int = 48
@export var point_of_interest_tags: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return map_preset_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_MAP_PRESET

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if map_preset_id.strip_edges().is_empty():
		errors.append("MapPresetDef is missing map_preset_id.")

	if fixture_id.strip_edges().is_empty():
		errors.append("%s is missing fixture_id." % get_debug_label())

	if world_width_cells <= 0 or world_height_cells <= 0:
		errors.append("%s has invalid world cell dimensions." % get_debug_label())

	return errors
