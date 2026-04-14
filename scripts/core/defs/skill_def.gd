extends BaseDef
class_name SkillDef

@export var skill_id: String = ""
@export var category_tags: PackedStringArray = PackedStringArray()
@export var is_hidden: bool = false

func get_definition_id() -> String:
	return skill_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_SKILL

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if skill_id.strip_edges().is_empty():
		errors.append("SkillDef is missing skill_id.")

	return errors
