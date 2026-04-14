extends BaseDef
class_name StageDef

@export var stage_id: String = ""
@export var stage_rank: int = 0
@export var progression_tags: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return stage_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_STAGE

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if stage_id.strip_edges().is_empty():
		errors.append("StageDef is missing stage_id.")

	if stage_rank < 0:
		errors.append("%s has stage_rank < 0." % get_debug_label())

	return errors
