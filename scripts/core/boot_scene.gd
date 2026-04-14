extends Node
class_name BootScene

const DEV_WORLD_SCENE_PATH: String = "res://scenes/world/test_world_scene.tscn"

func _ready() -> void:
	var definition_registry: Node = _definition_registry()
	if definition_registry == null:
		push_error("BootScene: DefinitionRegistry autoload is missing.")
		_show_boot_failure("Boot failed: DefinitionRegistry autoload is missing.")
		return

	if definition_registry.has_method("reload_registry"):
		definition_registry.call("reload_registry")

	if definition_registry.has_method("has_fatal_errors"):
		var has_fatal_errors: bool = bool(definition_registry.call("has_fatal_errors"))
		if has_fatal_errors:
			var error_lines: Array[String] = []
			if definition_registry.has_method("get_validation_errors"):
				error_lines = definition_registry.call("get_validation_errors")

			print("BootScene: definition validation failed.")
			for error_line: String in error_lines:
				print("BootScene ERROR: %s" % error_line)

			_show_boot_failure(_build_boot_failure_text(error_lines))
			return

	if not _resolve_sim_bootstrap_context():
		return

	if not _validate_boot_context(definition_registry):
		return

	var telemetry_service: Node = _telemetry_service()
	var sim_root: Node = _sim_root()

	if telemetry_service != null and sim_root != null:
		var definition_report: Dictionary = {}
		if definition_registry.has_method("get_validation_report"):
			definition_report = definition_registry.call("get_validation_report")

		telemetry_service.call("log", "boot", "boot_scene_ready", {
			"scenario_id": str(sim_root.get("scenario_id")),
			"seed": int(sim_root.get("seed")),
			"stage_id": str(sim_root.get("stage_id")),
			"map_preset_id": str(sim_root.get("map_preset_id")),
			"worldgen_profile_id": str(sim_root.get("worldgen_profile_id")),
			"season_profile_id": str(sim_root.get("season_profile_id")),
			"definition_report": definition_report,
		})

	call_deferred("_go_to_dev_world")

func _go_to_dev_world() -> void:
	var app_root: Node = _app_root()
	if app_root == null:
		push_error("BootScene: AppRoot autoload is missing.")
		_show_boot_failure("Boot failed: AppRoot autoload is missing.")
		return

	app_root.call("goto_scene", DEV_WORLD_SCENE_PATH)

func _resolve_sim_bootstrap_context() -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		push_error("BootScene: SimRoot autoload is missing.")
		_show_boot_failure("Boot failed: SimRoot autoload is missing.")
		return false

	if not sim_root.has_method("resolve_bootstrap_context_from_definitions"):
		push_error("BootScene: SimRoot is missing resolve_bootstrap_context_from_definitions().")
		_show_boot_failure("Boot failed: SimRoot bootstrap resolver is missing.")
		return false

	var resolved_ok: bool = bool(sim_root.call("resolve_bootstrap_context_from_definitions"))
	if resolved_ok:
		return true

	var bootstrap_error_message: String = "Boot failed: scenario bootstrap resolution failed."
	if sim_root.has_method("get_last_bootstrap_error"):
		var detailed_message: String = str(sim_root.call("get_last_bootstrap_error")).strip_edges()
		if not detailed_message.is_empty():
			bootstrap_error_message = "Boot failed: %s" % detailed_message

	_show_boot_failure(bootstrap_error_message)
	return false

func _validate_boot_context(definition_registry: Node) -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		push_error("BootScene: SimRoot autoload is missing.")
		_show_boot_failure("Boot failed: SimRoot autoload is missing.")
		return false

	var scenario_id: String = str(sim_root.get("scenario_id"))
	var stage_id: String = str(sim_root.get("stage_id"))
	var map_preset_id: String = str(sim_root.get("map_preset_id"))
	var worldgen_profile_id: String = str(sim_root.get("worldgen_profile_id"))
	var season_profile_id: String = str(sim_root.get("season_profile_id"))

	var has_scenario: bool = bool(definition_registry.call("has_definition", DefinitionTypes.TYPE_SCENARIO, scenario_id))
	if not has_scenario:
		var scenario_message: String = "Boot failed: active scenario_id is missing from definitions: %s" % scenario_id
		push_error("BootScene: %s" % scenario_message)
		_show_boot_failure(scenario_message)
		return false

	var has_stage: bool = bool(definition_registry.call("has_definition", DefinitionTypes.TYPE_STAGE, stage_id))
	if not has_stage:
		var stage_message: String = "Boot failed: active stage_id is missing from definitions: %s" % stage_id
		push_error("BootScene: %s" % stage_message)
		_show_boot_failure(stage_message)
		return false

	var has_map_preset: bool = bool(definition_registry.call("has_definition", DefinitionTypes.TYPE_MAP_PRESET, map_preset_id))
	if not has_map_preset:
		var map_preset_message: String = "Boot failed: active map_preset_id is missing from definitions: %s" % map_preset_id
		push_error("BootScene: %s" % map_preset_message)
		_show_boot_failure(map_preset_message)
		return false

	var has_worldgen_profile: bool = bool(
		definition_registry.call("has_definition", DefinitionTypes.TYPE_WORLDGEN_PROFILE, worldgen_profile_id)
	)
	if not has_worldgen_profile:
		var worldgen_message: String = "Boot failed: active worldgen_profile_id is missing from definitions: %s" % worldgen_profile_id
		push_error("BootScene: %s" % worldgen_message)
		_show_boot_failure(worldgen_message)
		return false

	var has_season_profile: bool = bool(
		definition_registry.call("has_definition", DefinitionTypes.TYPE_SEASON_PROFILE, season_profile_id)
	)
	if not has_season_profile:
		var season_profile_message: String = "Boot failed: active season_profile_id is missing from definitions: %s" % season_profile_id
		push_error("BootScene: %s" % season_profile_message)
		_show_boot_failure(season_profile_message)
		return false

	return true

func _build_boot_failure_text(error_lines: Array[String]) -> String:
	var lines: Array[String] = [
		"Boot blocked: definition validation failed.",
		"",
	]

	if error_lines.is_empty():
		lines.append("No detailed validation errors were returned.")
	else:
		lines.append("Validation errors:")
		lines.append("")
		for error_line: String in error_lines:
			lines.append("- %s" % error_line)

	lines.append("")
	lines.append("Check the Output panel, fix the broken definition, then run again.")
	return "\n".join(lines)

func _show_boot_failure(message: String) -> void:
	var layer: CanvasLayer = CanvasLayer.new()
	layer.layer = 100
	add_child(layer)

	var background: ColorRect = ColorRect.new()
	background.color = Color(0.10, 0.10, 0.10, 1.0)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(background)

	var panel: PanelContainer = PanelContainer.new()
	panel.set_anchors_preset(Control.PRESET_CENTER)
	panel.custom_minimum_size = Vector2(900.0, 320.0)
	panel.position = Vector2(-450.0, -160.0)
	layer.add_child(panel)

	var margin: MarginContainer = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(margin)

	var label: RichTextLabel = RichTextLabel.new()
	label.fit_content = true
	label.scroll_active = true
	label.bbcode_enabled = false
	label.text = message
	margin.add_child(label)

func _app_root() -> Node:
	return get_node_or_null("/root/AppRoot")

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")

func _definition_registry() -> Node:
	return get_node_or_null("/root/DefinitionRegistry")
