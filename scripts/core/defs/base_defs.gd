extends Resource
class_name BaseDef

@export var display_name: String = ""
@export_multiline var description: String = ""
@export var sort_index: int = 0
@export var tags: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return ""

func get_definition_type() -> String:
	return ""

func get_debug_label() -> String:
	var definition_id: String = get_definition_id().strip_edges()
	if not definition_id.is_empty():
		return definition_id

	return "%s:<unassigned>" % get_definition_type()

func validate_definition() -> Array[String]:
	var errors: Array[String] = []

	if display_name.strip_edges().is_empty():
		errors.append("%s is missing display_name." % get_debug_label())

	return errors
