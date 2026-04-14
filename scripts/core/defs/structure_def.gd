extends BaseDef
class_name StructureDef

@export var structure_def_id: String = ""
@export var footprint_cells: Vector2i = Vector2i.ONE
@export var function_tags: PackedStringArray = PackedStringArray()
@export var allowed_zone_type_ids: PackedStringArray = PackedStringArray()
@export var storage_role: String = ""
@export var build_process_def_id: String = ""

func get_definition_id() -> String:
	return structure_def_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_STRUCTURE

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if structure_def_id.strip_edges().is_empty():
		errors.append("StructureDef is missing structure_def_id.")

	if footprint_cells.x <= 0 or footprint_cells.y <= 0:
		errors.append("%s has invalid footprint_cells." % get_debug_label())

	var zone_type_id: String = ""
	for zone_type_value: String in allowed_zone_type_ids:
		zone_type_id = zone_type_value.strip_edges()

		if zone_type_id.is_empty():
			continue

		if not ZoneTypes.is_valid_zone_type_id(zone_type_id):
			errors.append("%s uses unknown allowed_zone_type_id '%s'." % [get_debug_label(), zone_type_id])

	if not storage_role.strip_edges().is_empty():
		if not SharedEnums.contains_value(SharedEnums.STORAGE_ROLES, storage_role):
			errors.append("%s uses unknown storage_role '%s'." % [get_debug_label(), storage_role])

	return errors
