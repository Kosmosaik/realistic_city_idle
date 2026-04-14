extends RefCounted
class_name IdRules

static func validate_definition_id(definition_type: String, definition_id: String) -> Dictionary:
	match definition_type:
		DefinitionTypes.TYPE_STAGE:
			return _validate_dot_namespace_id(definition_id, "stage.")
		DefinitionTypes.TYPE_SCENARIO:
			return _validate_dot_namespace_id(definition_id, "scenario.")
		DefinitionTypes.TYPE_SKILL:
			return _validate_simple_snake_id(definition_id, "skill_id")
		DefinitionTypes.TYPE_MAP_PRESET:
			return _validate_simple_snake_id(definition_id, "map_preset_id")
		DefinitionTypes.TYPE_SPECIES:
			return _validate_simple_snake_id(definition_id, "species_id")
		DefinitionTypes.TYPE_TERRAIN_PROFILE:
			return _validate_simple_snake_id(definition_id, "terrain_profile_id")
		DefinitionTypes.TYPE_WORLDGEN_PROFILE:
			return _validate_simple_snake_id(definition_id, "worldgen_profile_id")
		DefinitionTypes.TYPE_SEASON_PROFILE:
			return _validate_simple_snake_id(definition_id, "season_profile_id")
		DefinitionTypes.TYPE_UI_PANEL:
			return _validate_simple_snake_id(definition_id, "ui_panel_id")
		DefinitionTypes.TYPE_ITEM:
			return _validate_prefixed_id(definition_id, "itm_", "item_def_id")
		DefinitionTypes.TYPE_PROCESS:
			return _validate_prefixed_id(definition_id, "pro_", "process_def_id")
		DefinitionTypes.TYPE_STRUCTURE:
			return _validate_prefixed_id(definition_id, "str_", "structure_def_id")
		DefinitionTypes.TYPE_INCIDENT:
			return _validate_prefixed_id(definition_id, "inc_", "incident_id")
		_:
			return {
				"ok": false,
				"message": "Unknown definition type '%s'." % definition_type,
			}

static func _validate_simple_snake_id(value: String, label: String) -> Dictionary:
	var trimmed_value: String = value.strip_edges()

	if trimmed_value.is_empty():
		return {
			"ok": false,
			"message": "%s must not be empty." % label,
		}

	if not _is_lower_snake_text(trimmed_value):
		return {
			"ok": false,
			"message": "%s must use lowercase snake_case only: '%s'." % [label, trimmed_value],
		}

	return {
		"ok": true,
		"message": "",
	}

static func _validate_prefixed_id(value: String, required_prefix: String, label: String) -> Dictionary:
	var trimmed_value: String = value.strip_edges()

	if trimmed_value.is_empty():
		return {
			"ok": false,
			"message": "%s must not be empty." % label,
		}

	if not trimmed_value.begins_with(required_prefix):
		return {
			"ok": false,
			"message": "%s must start with '%s': '%s'." % [label, required_prefix, trimmed_value],
		}

	var suffix: String = trimmed_value.trim_prefix(required_prefix)
	if not _is_lower_snake_text(suffix):
		return {
			"ok": false,
			"message": "%s suffix must use lowercase snake_case only: '%s'." % [label, trimmed_value],
		}

	return {
		"ok": true,
		"message": "",
	}

static func _validate_dot_namespace_id(value: String, required_prefix: String) -> Dictionary:
	var trimmed_value: String = value.strip_edges()

	if trimmed_value.is_empty():
		return {
			"ok": false,
			"message": "ID must not be empty.",
		}

	if not trimmed_value.begins_with(required_prefix):
		return {
			"ok": false,
			"message": "ID must start with '%s': '%s'." % [required_prefix, trimmed_value],
		}

	var tail: String = trimmed_value.trim_prefix(required_prefix)
	if tail.is_empty():
		return {
			"ok": false,
			"message": "ID must have a namespace tail after '%s'." % required_prefix,
		}

	var segments: PackedStringArray = tail.split(".")
	var segment: String = ""
	for segment_value: String in segments:
		segment = segment_value.strip_edges()

		if not _is_lower_snake_text(segment):
			return {
				"ok": false,
				"message": "Dot-namespace segment must use lowercase snake_case only: '%s'." % trimmed_value,
			}

	return {
		"ok": true,
		"message": "",
	}

static func _is_lower_snake_text(value: String) -> bool:
	if value.is_empty():
		return false

	var length: int = value.length()
	var previous_was_underscore: bool = false
	var index: int = 0

	while index < length:
		var character: String = value.substr(index, 1)
		var is_lower_letter: bool = character >= "a" and character <= "z"
		var is_digit: bool = character >= "0" and character <= "9"

		if character == "_":
			if index == 0 or index == length - 1:
				return false

			if previous_was_underscore:
				return false

			previous_was_underscore = true
			index += 1
			continue

		if not is_lower_letter and not is_digit:
			return false

		previous_was_underscore = false
		index += 1

	return true
