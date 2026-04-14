extends Node

const RESOURCE_EXTENSIONS: Array = [
	".tres",
	".res",
]

var _definitions_by_type: Dictionary = {}
var _definitions_by_id: Dictionary = {}
var _resource_path_by_id: Dictionary = {}
var _validation_errors: Array[String] = []
var _validation_warnings: Array[String] = []
var _loaded_resource_paths: Array[String] = []

func reload_registry() -> void:
	_reset_state()

	var definition_type: String = ""
	for type_value: String in DefinitionTypes.get_all_types():
		definition_type = type_value
		_definitions_by_type[definition_type] = {}

		var directory_path: String = DefinitionTypes.get_directory_for_type(definition_type)
		_scan_definition_directory(definition_type, directory_path)

	_run_reference_validation()
	_emit_validation_summary()

func has_fatal_errors() -> bool:
	return not _validation_errors.is_empty()

func has_definition(definition_type: String, definition_id: String) -> bool:
	var definitions_for_type: Dictionary = _definitions_by_type.get(definition_type, {})
	return definitions_for_type.has(definition_id)

func get_definition(definition_type: String, definition_id: String) -> BaseDef:
	var definitions_for_type: Dictionary = _definitions_by_type.get(definition_type, {})
	return definitions_for_type.get(definition_id, null) as BaseDef

func get_definition_ids(definition_type: String) -> Array[String]:
	var definition_ids: Array[String] = []
	var definitions_for_type: Dictionary = _definitions_by_type.get(definition_type, {})

	var key_value: Variant = null
	for dictionary_key: Variant in definitions_for_type.keys():
		key_value = dictionary_key
		definition_ids.append(str(key_value))

	definition_ids.sort()
	return definition_ids

func get_validation_errors() -> Array[String]:
	return _validation_errors.duplicate()

func get_validation_warnings() -> Array[String]:
	return _validation_warnings.duplicate()

func get_validation_report() -> Dictionary:
	var loaded_count_by_type: Dictionary = {}

	var definition_type: String = ""
	for type_value: String in DefinitionTypes.get_all_types():
		definition_type = type_value
		var definitions_for_type: Dictionary = _definitions_by_type.get(definition_type, {})
		loaded_count_by_type[definition_type] = definitions_for_type.size()

	return {
		"is_valid": not has_fatal_errors(),
		"loaded_count_total": _loaded_resource_paths.size(),
		"loaded_count_by_type": loaded_count_by_type,
		"warning_count": _validation_warnings.size(),
		"error_count": _validation_errors.size(),
		"warnings": _validation_warnings.duplicate(),
		"errors": _validation_errors.duplicate(),
	}

func _reset_state() -> void:
	_definitions_by_type.clear()
	_definitions_by_id.clear()
	_resource_path_by_id.clear()
	_validation_errors.clear()
	_validation_warnings.clear()
	_loaded_resource_paths.clear()

func _scan_definition_directory(definition_type: String, directory_path: String) -> void:
	var file_paths: Array[String] = []
	_collect_definition_files_recursive(directory_path, file_paths)
	file_paths.sort()

	var file_path: String = ""
	for path_value: String in file_paths:
		file_path = path_value
		_load_definition_resource(definition_type, file_path)

func _collect_definition_files_recursive(directory_path: String, file_paths: Array[String]) -> void:
	var dir: DirAccess = DirAccess.open(directory_path)
	if dir == null:
		_validation_warnings.append("Missing definition directory: %s" % directory_path)
		return

	dir.list_dir_begin()
	var entry_name: String = dir.get_next()

	while not entry_name.is_empty():
		if entry_name.begins_with("."):
			entry_name = dir.get_next()
			continue

		var child_path: String = "%s/%s" % [directory_path, entry_name]

		if dir.current_is_dir():
			_collect_definition_files_recursive(child_path, file_paths)
		elif _is_definition_file(entry_name):
			file_paths.append(child_path)

		entry_name = dir.get_next()

	dir.list_dir_end()

func _is_definition_file(file_name: String) -> bool:
	var extension: String = ""
	for extension_value: String in RESOURCE_EXTENSIONS:
		extension = extension_value

		if file_name.ends_with(extension):
			return true

	return false

func _load_definition_resource(expected_type: String, file_path: String) -> void:
	var loaded_resource: Resource = load(file_path)
	if loaded_resource == null:
		_validation_errors.append("Failed to load definition resource: %s" % file_path)
		return

	var definition: BaseDef = loaded_resource as BaseDef
	if definition == null:
		_validation_errors.append("Resource is not a BaseDef: %s" % file_path)
		return

	var actual_type: String = definition.get_definition_type()
	if actual_type != expected_type:
		_validation_errors.append(
			"Definition type mismatch in %s. Expected '%s', got '%s'." % [file_path, expected_type, actual_type]
		)
		return

	var definition_id: String = definition.get_definition_id().strip_edges()
	var id_validation: Dictionary = IdRules.validate_definition_id(actual_type, definition_id)
	if not bool(id_validation.get("ok", false)):
		_validation_errors.append("%s -> %s" % [file_path, str(id_validation.get("message", "Invalid ID."))])
		return

	var definition_errors: Array[String] = definition.validate_definition()
	var definition_error: String = ""
	for error_value: String in definition_errors:
		definition_error = error_value
		_validation_errors.append("%s -> %s" % [file_path, definition_error])

	if not definition_errors.is_empty():
		return

	var definitions_for_type: Dictionary = _definitions_by_type.get(actual_type, {})
	if definitions_for_type.has(definition_id):
		var first_path: String = str(_resource_path_by_id.get(definition_id, "<unknown>"))
		_validation_errors.append(
			"Duplicate definition ID '%s' in %s and %s." % [definition_id, first_path, file_path]
		)
		return

	definitions_for_type[definition_id] = definition
	_definitions_by_type[actual_type] = definitions_for_type
	_definitions_by_id[definition_id] = definition
	_resource_path_by_id[definition_id] = file_path
	_loaded_resource_paths.append(file_path)

func _run_reference_validation() -> void:
	_validate_scenario_references()
	_validate_process_references()
	_validate_structure_references()
	_validate_species_references()
	_validate_worldgen_profile_references()
	_validate_incident_references()

func _validate_scenario_references() -> void:
	var scenario_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_SCENARIO, {})
	var scenario_key: Variant = null

	for key_value: Variant in scenario_defs.keys():
		scenario_key = key_value
		var scenario_def: ScenarioDef = scenario_defs.get(str(scenario_key), null) as ScenarioDef
		if scenario_def == null:
			continue

		if not has_definition(DefinitionTypes.TYPE_STAGE, scenario_def.starting_stage_id):
			_validation_errors.append(
				"%s references missing stage '%s'." % [scenario_def.get_debug_label(), scenario_def.starting_stage_id]
			)

		if not has_definition(DefinitionTypes.TYPE_MAP_PRESET, scenario_def.default_map_preset_id):
			_validation_errors.append(
				"%s references missing map preset '%s'." % [
					scenario_def.get_debug_label(),
					scenario_def.default_map_preset_id,
				]
			)

		if not has_definition(DefinitionTypes.TYPE_WORLDGEN_PROFILE, scenario_def.worldgen_profile_id):
			_validation_errors.append(
				"%s references missing worldgen profile '%s'." % [
					scenario_def.get_debug_label(),
					scenario_def.worldgen_profile_id,
				]
			)
		else:
			var worldgen_profile_base_def: BaseDef = _definitions_by_type[DefinitionTypes.TYPE_WORLDGEN_PROFILE].get(
				scenario_def.worldgen_profile_id,
				null
			) as BaseDef
			var worldgen_profile_def: WorldgenProfileDef = worldgen_profile_base_def as WorldgenProfileDef

			if worldgen_profile_def != null:
				if not worldgen_profile_def.map_preset_ids.has(scenario_def.default_map_preset_id):
					_validation_errors.append(
						"%s uses map preset '%s' that is not listed in worldgen profile '%s'." % [
							scenario_def.get_debug_label(),
							scenario_def.default_map_preset_id,
							worldgen_profile_def.worldgen_profile_id,
						]
					)

		_validate_reference_array(
			scenario_def.get_debug_label(),
			"starting_item_def_ids",
			scenario_def.starting_item_def_ids,
			DefinitionTypes.TYPE_ITEM
		)

func _validate_process_references() -> void:
	var process_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_PROCESS, {})
	var process_key: Variant = null

	for key_value: Variant in process_defs.keys():
		process_key = key_value
		var process_def: ProcessDef = process_defs.get(str(process_key), null) as ProcessDef
		if process_def == null:
			continue

		_validate_reference_array(
			process_def.get_debug_label(),
			"input_item_def_ids",
			process_def.input_item_def_ids,
			DefinitionTypes.TYPE_ITEM
		)

		_validate_reference_array(
			process_def.get_debug_label(),
			"output_item_def_ids",
			process_def.output_item_def_ids,
			DefinitionTypes.TYPE_ITEM
		)

		_validate_reference_array(
			process_def.get_debug_label(),
			"required_structure_def_ids",
			process_def.required_structure_def_ids,
			DefinitionTypes.TYPE_STRUCTURE
		)

		_validate_reference_array(
			process_def.get_debug_label(),
			"required_skill_ids",
			process_def.required_skill_ids,
			DefinitionTypes.TYPE_SKILL
		)

func _validate_structure_references() -> void:
	var structure_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_STRUCTURE, {})
	var structure_key: Variant = null

	for key_value: Variant in structure_defs.keys():
		structure_key = key_value
		var structure_def: StructureDef = structure_defs.get(str(structure_key), null) as StructureDef
		if structure_def == null:
			continue

		var build_process_def_id: String = structure_def.build_process_def_id.strip_edges()
		if build_process_def_id.is_empty():
			continue

		if not has_definition(DefinitionTypes.TYPE_PROCESS, build_process_def_id):
			_validation_errors.append(
				"%s references missing process '%s' in build_process_def_id." % [
					structure_def.get_debug_label(),
					build_process_def_id,
				]
			)

func _validate_species_references() -> void:
	var species_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_SPECIES, {})
	var species_key: Variant = null

	for key_value: Variant in species_defs.keys():
		species_key = key_value
		var species_def: SpeciesDef = species_defs.get(str(species_key), null) as SpeciesDef
		if species_def == null:
			continue

		_validate_reference_array(
			species_def.get_debug_label(),
			"associated_item_def_ids",
			species_def.associated_item_def_ids,
			DefinitionTypes.TYPE_ITEM
		)

func _validate_worldgen_profile_references() -> void:
	var worldgen_profile_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_WORLDGEN_PROFILE, {})
	var worldgen_profile_key: Variant = null

	for key_value: Variant in worldgen_profile_defs.keys():
		worldgen_profile_key = key_value
		var worldgen_profile_def: WorldgenProfileDef = worldgen_profile_defs.get(str(worldgen_profile_key), null) as WorldgenProfileDef
		if worldgen_profile_def == null:
			continue

		_validate_reference_array(
			worldgen_profile_def.get_debug_label(),
			"map_preset_ids",
			worldgen_profile_def.map_preset_ids,
			DefinitionTypes.TYPE_MAP_PRESET
		)

		_validate_reference_array(
			worldgen_profile_def.get_debug_label(),
			"terrain_profile_ids",
			worldgen_profile_def.terrain_profile_ids,
			DefinitionTypes.TYPE_TERRAIN_PROFILE
		)

		_validate_reference_array(
			worldgen_profile_def.get_debug_label(),
			"starter_species_ids",
			worldgen_profile_def.starter_species_ids,
			DefinitionTypes.TYPE_SPECIES
		)

		var season_profile_id: String = worldgen_profile_def.season_profile_id.strip_edges()
		if season_profile_id.is_empty():
			continue

		if not has_definition(DefinitionTypes.TYPE_SEASON_PROFILE, season_profile_id):
			_validation_errors.append(
				"%s references missing season profile '%s'." % [
					worldgen_profile_def.get_debug_label(),
					season_profile_id,
				]
			)

func _validate_incident_references() -> void:
	var incident_defs: Dictionary = _definitions_by_type.get(DefinitionTypes.TYPE_INCIDENT, {})
	var incident_key: Variant = null

	for key_value: Variant in incident_defs.keys():
		incident_key = key_value
		var incident_def: IncidentDef = incident_defs.get(str(incident_key), null) as IncidentDef
		if incident_def == null:
			continue

		var default_ui_panel_id: String = incident_def.default_ui_panel_id.strip_edges()
		if not default_ui_panel_id.is_empty():
			if not has_definition(DefinitionTypes.TYPE_UI_PANEL, default_ui_panel_id):
				_validation_errors.append(
					"%s references missing ui panel '%s'." % [
						incident_def.get_debug_label(),
						default_ui_panel_id,
					]
				)

		_validate_reference_array(
			incident_def.get_debug_label(),
			"related_process_def_ids",
			incident_def.related_process_def_ids,
			DefinitionTypes.TYPE_PROCESS
		)

		_validate_reference_array(
			incident_def.get_debug_label(),
			"related_structure_def_ids",
			incident_def.related_structure_def_ids,
			DefinitionTypes.TYPE_STRUCTURE
		)

		_validate_reference_array(
			incident_def.get_debug_label(),
			"related_item_def_ids",
			incident_def.related_item_def_ids,
			DefinitionTypes.TYPE_ITEM
		)

func _validate_reference_array(
	owner_label: String,
	field_name: String,
	definition_ids: PackedStringArray,
	expected_definition_type: String
) -> void:
	var definition_id: String = ""

	for definition_id_value: String in definition_ids:
		definition_id = definition_id_value.strip_edges()

		if definition_id.is_empty():
			continue

		if not has_definition(expected_definition_type, definition_id):
			_validation_errors.append(
				"%s references missing %s '%s' in %s." % [
					owner_label,
					expected_definition_type,
					definition_id,
					field_name,
				]
			)

func _emit_validation_summary() -> void:
	var report: Dictionary = get_validation_report()

	var warning_message: String = ""
	for warning_value: String in _validation_warnings:
		warning_message = warning_value
		push_warning("DefinitionRegistry: %s" % warning_message)
		print("DefinitionRegistry WARNING: %s" % warning_message)

	var error_message: String = ""
	for error_value: String in _validation_errors:
		error_message = error_value
		push_error("DefinitionRegistry: %s" % error_message)
		print("DefinitionRegistry ERROR: %s" % error_message)

	var telemetry_service: Node = get_node_or_null("/root/TelemetryService")
	if telemetry_service != null and telemetry_service.has_method("log"):
		telemetry_service.call("log", "defs", "definition_registry_validated", report)

	if has_fatal_errors():
		print("DefinitionRegistry: INVALID. Loaded=%s Warnings=%s Errors=%s" % [
			report.get("loaded_count_total", 0),
			report.get("warning_count", 0),
			report.get("error_count", 0),
		])
	else:
		print("DefinitionRegistry: OK. Loaded=%s Warnings=%s Errors=%s" % [
			report.get("loaded_count_total", 0),
			report.get("warning_count", 0),
			report.get("error_count", 0),
		])
