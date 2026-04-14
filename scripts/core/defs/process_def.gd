extends BaseDef
class_name ProcessDef

@export var process_def_id: String = ""
@export var input_item_def_ids: PackedStringArray = PackedStringArray()
@export var output_item_def_ids: PackedStringArray = PackedStringArray()
@export var required_structure_def_ids: PackedStringArray = PackedStringArray()
@export var required_skill_ids: PackedStringArray = PackedStringArray()
@export var required_zone_type_ids: PackedStringArray = PackedStringArray()
@export var task_def_id: String = ""
@export var duration_hours: float = 0.0
@export var is_interruptible: bool = true

func get_definition_id() -> String:
	return process_def_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_PROCESS

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if process_def_id.strip_edges().is_empty():
		errors.append("ProcessDef is missing process_def_id.")

	if duration_hours < 0.0:
		errors.append("%s has duration_hours < 0." % get_debug_label())

	var trimmed_task_def_id: String = task_def_id.strip_edges()
	if trimmed_task_def_id.is_empty():
		errors.append("%s is missing task_def_id." % get_debug_label())
	elif not TaskDefIds.is_valid_task_def_id(trimmed_task_def_id):
		errors.append("%s uses unknown task_def_id '%s'." % [get_debug_label(), trimmed_task_def_id])

	var zone_type_id: String = ""
	for zone_type_value: String in required_zone_type_ids:
		zone_type_id = zone_type_value.strip_edges()

		if zone_type_id.is_empty():
			continue

		if not ZoneTypes.is_valid_zone_type_id(zone_type_id):
			errors.append("%s uses unknown required_zone_type_id '%s'." % [get_debug_label(), zone_type_id])

	return errors
