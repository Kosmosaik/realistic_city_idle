extends BaseDef
class_name ItemDef

@export var item_def_id: String = ""
@export var stack_limit: int = 1
@export var is_liquid: bool = false
@export var function_tags: PackedStringArray = PackedStringArray()
@export var storage_tags: PackedStringArray = PackedStringArray()
@export var need_tags: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return item_def_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_ITEM

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if item_def_id.strip_edges().is_empty():
		errors.append("ItemDef is missing item_def_id.")

	if stack_limit < 1:
		errors.append("%s has stack_limit < 1." % get_debug_label())

	return errors
