extends BaseDef
class_name TerrainProfileDef

# Minimal terrain profile placeholder for authored maps and later procgen hooks.
@export var terrain_profile_id: String = ""
@export var landform_type: String = ""
@export var slope_class: String = ""
@export var drainage_class: String = ""
@export var vegetation_cover_class: String = ""
@export var water_source_types: PackedStringArray = PackedStringArray()
@export var suitability_tags: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return terrain_profile_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_TERRAIN_PROFILE

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if terrain_profile_id.strip_edges().is_empty():
		errors.append("TerrainProfileDef is missing terrain_profile_id.")

	if not SharedEnums.contains_value(SharedEnums.LANDFORM_TYPES, landform_type):
		errors.append("%s uses unknown landform_type '%s'." % [get_debug_label(), landform_type])

	if not SharedEnums.contains_value(SharedEnums.SLOPE_CLASSES, slope_class):
		errors.append("%s uses unknown slope_class '%s'." % [get_debug_label(), slope_class])

	if not SharedEnums.contains_value(SharedEnums.DRAINAGE_CLASSES, drainage_class):
		errors.append("%s uses unknown drainage_class '%s'." % [get_debug_label(), drainage_class])

	if not SharedEnums.contains_value(SharedEnums.VEGETATION_COVER_CLASSES, vegetation_cover_class):
		errors.append("%s uses unknown vegetation_cover_class '%s'." % [get_debug_label(), vegetation_cover_class])

	var water_source_type: String = ""
	for water_source_value: String in water_source_types:
		water_source_type = water_source_value.strip_edges()

		if water_source_type.is_empty():
			continue

		if not SharedEnums.contains_value(SharedEnums.WATER_SOURCE_TYPES, water_source_type):
			errors.append("%s uses unknown water_source_type '%s'." % [get_debug_label(), water_source_type])

	return errors
