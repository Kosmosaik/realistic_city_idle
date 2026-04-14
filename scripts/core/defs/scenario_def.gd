extends BaseDef
class_name ScenarioDef

# ScenarioDef owns the top-level authored bootstrap choice for a run.
# It should point at stage, map, and world/profile definitions,
# but it still remains a static definition resource.
@export var scenario_id: String = ""
@export var starting_stage_id: String = ""
@export var default_map_preset_id: String = ""
@export var worldgen_profile_id: String = ""
@export var default_seed: int = 100001
@export var starting_item_def_ids: PackedStringArray = PackedStringArray()
@export var policy_bundle_ids: PackedStringArray = PackedStringArray()

func get_definition_id() -> String:
	return scenario_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_SCENARIO

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if scenario_id.strip_edges().is_empty():
		errors.append("ScenarioDef is missing scenario_id.")

	if starting_stage_id.strip_edges().is_empty():
		errors.append("%s is missing starting_stage_id." % get_debug_label())

	if default_map_preset_id.strip_edges().is_empty():
		errors.append("%s is missing default_map_preset_id." % get_debug_label())

	if worldgen_profile_id.strip_edges().is_empty():
		errors.append("%s is missing worldgen_profile_id." % get_debug_label())

	if default_seed < 0:
		errors.append("%s has default_seed < 0." % get_debug_label())

	var policy_bundle_id: String = ""
	for policy_bundle_value: String in policy_bundle_ids:
		policy_bundle_id = policy_bundle_value.strip_edges()

		if policy_bundle_id.is_empty():
			continue

		if not PolicyBundleIds.is_valid_policy_bundle_id(policy_bundle_id):
			errors.append("%s uses unknown policy_bundle_id '%s'." % [get_debug_label(), policy_bundle_id])

	return errors
