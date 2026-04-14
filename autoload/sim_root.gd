extends Node

const DEFAULT_SCENARIO_ID: String = "scenario.dev.temperate_valley"
const DEFAULT_STAGE_ID: String = "stage.lone_survivor"
const DEFAULT_MAP_PRESET_ID: String = "starter_map_balanced"
const DEFAULT_WORLDGEN_PROFILE_ID: String = "authored_starter_temperate_valley"
const DEFAULT_SEASON_PROFILE_ID: String = "temperate_four_season_basic"
const DEFAULT_SEED: int = 100001

var scenario_id: String = DEFAULT_SCENARIO_ID
var stage_id: String = DEFAULT_STAGE_ID
var map_preset_id: String = DEFAULT_MAP_PRESET_ID
var worldgen_profile_id: String = DEFAULT_WORLDGEN_PROFILE_ID
var season_profile_id: String = DEFAULT_SEASON_PROFILE_ID
var seed: int = DEFAULT_SEED
var seed_is_overridden: bool = false
var world_root: Node = null
var last_bootstrap_error: String = ""

func _ready() -> void:
	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "sim_root_ready", get_boot_context())

func set_bootstrap_context(new_scenario_id: String, new_seed: int) -> void:
	if new_scenario_id.strip_edges().is_empty():
		push_error("SimRoot: scenario_id must not be empty.")
		return

	if new_seed < 0:
		push_error("SimRoot: seed must not be negative.")
		return

	scenario_id = new_scenario_id
	seed = new_seed
	seed_is_overridden = true

	# Try to resolve immediately only if definitions are already loaded.
	# If they are not loaded yet, BootScene will do the authoritative resolve pass.
	if _definitions_are_loaded():
		resolve_bootstrap_context_from_definitions()

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "bootstrap_context_updated", get_boot_context())

func resolve_bootstrap_context_from_definitions() -> bool:
	_clear_bootstrap_error()

	var definition_registry: Node = _definition_registry()
	if definition_registry == null:
		return _fail_bootstrap("DefinitionRegistry autoload is missing.")

	var scenario_base_def: BaseDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_SCENARIO,
		scenario_id
	) as BaseDef
	var scenario_def: ScenarioDef = scenario_base_def as ScenarioDef
	if scenario_def == null:
		return _fail_bootstrap("Scenario definition could not be resolved: %s" % scenario_id)

	var resolved_stage_id: String = scenario_def.starting_stage_id.strip_edges()
	var resolved_map_preset_id: String = scenario_def.default_map_preset_id.strip_edges()
	var resolved_worldgen_profile_id: String = scenario_def.worldgen_profile_id.strip_edges()

	if resolved_stage_id.is_empty():
		return _fail_bootstrap("Scenario is missing starting_stage_id: %s" % scenario_id)

	if resolved_map_preset_id.is_empty():
		return _fail_bootstrap("Scenario is missing default_map_preset_id: %s" % scenario_id)

	if resolved_worldgen_profile_id.is_empty():
		return _fail_bootstrap("Scenario is missing worldgen_profile_id: %s" % scenario_id)

	var map_preset_base_def: BaseDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_MAP_PRESET,
		resolved_map_preset_id
	) as BaseDef
	var map_preset_def: MapPresetDef = map_preset_base_def as MapPresetDef
	if map_preset_def == null:
		return _fail_bootstrap("Map preset definition could not be resolved: %s" % resolved_map_preset_id)

	var worldgen_profile_base_def: BaseDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_WORLDGEN_PROFILE,
		resolved_worldgen_profile_id
	) as BaseDef
	var worldgen_profile_def: WorldgenProfileDef = worldgen_profile_base_def as WorldgenProfileDef
	if worldgen_profile_def == null:
		return _fail_bootstrap("Worldgen profile definition could not be resolved: %s" % resolved_worldgen_profile_id)

	if not worldgen_profile_def.map_preset_ids.has(resolved_map_preset_id):
		return _fail_bootstrap(
			"Scenario map preset '%s' is not allowed by worldgen profile '%s'." % [
				resolved_map_preset_id,
				resolved_worldgen_profile_id,
			]
		)

	var resolved_season_profile_id: String = worldgen_profile_def.season_profile_id.strip_edges()
	if resolved_season_profile_id.is_empty():
		return _fail_bootstrap(
			"Worldgen profile is missing season_profile_id: %s" % resolved_worldgen_profile_id
		)

	var season_profile_base_def: BaseDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_SEASON_PROFILE,
		resolved_season_profile_id
	) as BaseDef
	var season_profile_def: SeasonProfileDef = season_profile_base_def as SeasonProfileDef
	if season_profile_def == null:
		return _fail_bootstrap("Season profile definition could not be resolved: %s" % resolved_season_profile_id)

	scenario_id = scenario_def.scenario_id
	stage_id = resolved_stage_id
	map_preset_id = map_preset_def.map_preset_id
	worldgen_profile_id = worldgen_profile_def.worldgen_profile_id
	season_profile_id = season_profile_def.season_profile_id

	# If no explicit seed override was provided, adopt the scenario default seed.
	if not seed_is_overridden:
		seed = scenario_def.default_seed

	var time_service: Node = _time_service()
	if time_service != null and time_service.has_method("apply_season_profile_bootstrap"):
		time_service.call("apply_season_profile_bootstrap", season_profile_def)

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "bootstrap_context_resolved", get_boot_context())

	return true

func get_last_bootstrap_error() -> String:
	return last_bootstrap_error

func get_boot_context() -> Dictionary:
	var calendar: Dictionary = {}
	var time_service: Node = _time_service()

	if time_service != null and time_service.has_method("get_calendar_snapshot"):
		calendar = time_service.call("get_calendar_snapshot")

	return {
		"scenario_id": scenario_id,
		"stage_id": stage_id,
		"map_preset_id": map_preset_id,
		"worldgen_profile_id": worldgen_profile_id,
		"season_profile_id": season_profile_id,
		"seed": seed,
		"calendar": calendar,
	}

func register_world_root(node: Node) -> void:
	world_root = node

	var event_bus: Node = _event_bus()
	if event_bus != null:
		event_bus.emit_signal("world_registered", node)

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "world", "world_registered", {
			"scene_file_path": node.scene_file_path,
		})

func unregister_world_root(node: Node) -> void:
	if world_root != node:
		return

	world_root = null

	var event_bus: Node = _event_bus()
	if event_bus != null:
		event_bus.emit_signal("world_unregistered")

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "world", "world_unregistered", {
			"scene_file_path": node.scene_file_path,
		})

func _definitions_are_loaded() -> bool:
	var definition_registry: Node = _definition_registry()
	if definition_registry == null:
		return false

	if not definition_registry.has_method("get_validation_report"):
		return false

	var validation_report: Dictionary = definition_registry.call("get_validation_report")
	var loaded_count_total: int = int(validation_report.get("loaded_count_total", 0))
	return loaded_count_total > 0

func _fail_bootstrap(message: String) -> bool:
	last_bootstrap_error = message
	push_error("SimRoot: %s" % message)
	return false

func _clear_bootstrap_error() -> void:
	last_bootstrap_error = ""

func _definition_registry() -> Node:
	return get_node_or_null("/root/DefinitionRegistry")

func _event_bus() -> Node:
	return get_node_or_null("/root/EventBus")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")

func _time_service() -> Node:
	return get_node_or_null("/root/TimeService")
