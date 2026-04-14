extends BaseDef
class_name SpeciesDef

# Minimal metadata placeholder for plant/animal/resource species.
const ALLOWED_SPECIES_KINDS: Array = [
	"plant",
	"animal",
	"resource",
]

@export var species_id: String = ""
@export var species_kind: String = ""
@export var biome_tags: PackedStringArray = PackedStringArray()
@export var opportunity_tags: PackedStringArray = PackedStringArray()
@export var associated_item_def_ids: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return species_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_SPECIES

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if species_id.strip_edges().is_empty():
		errors.append("SpeciesDef is missing species_id.")

	var trimmed_species_kind: String = species_kind.strip_edges()
	if trimmed_species_kind.is_empty():
		errors.append("%s is missing species_kind." % get_debug_label())
	elif not ALLOWED_SPECIES_KINDS.has(trimmed_species_kind):
		errors.append("%s uses unknown species_kind '%s'." % [get_debug_label(), trimmed_species_kind])

	return errors
