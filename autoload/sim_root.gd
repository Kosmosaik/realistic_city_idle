extends Node

const BOOT_DEFAULTS_SCRIPT: Script = preload("res://scripts/core/boot_defaults.gd")
const AUTHORED_MAP_LOADER_SCRIPT: Script = preload("res://scripts/runtime/world/authored_map_loader.gd")
const WORLD_VISIBILITY_SERVICE_SCRIPT: Script = preload("res://scripts/runtime/world/world_visibility_service.gd")

const TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT: Script = preload(
	"res://scripts/presentation/world/terrain_debug_visual_config.gd"
)
var _terrain_debug_visual_config: TerrainDebugVisualConfig = TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT.new()

const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

var scenario_id: String = BOOT_DEFAULTS_SCRIPT.get_default_scenario_id()
var stage_id: String = BOOT_DEFAULTS_SCRIPT.get_default_stage_id()
var map_preset_id: String = BOOT_DEFAULTS_SCRIPT.get_default_map_preset_id()
var worldgen_profile_id: String = BOOT_DEFAULTS_SCRIPT.get_default_worldgen_profile_id()
var season_profile_id: String = BOOT_DEFAULTS_SCRIPT.get_default_season_profile_id()
var seed: int = BOOT_DEFAULTS_SCRIPT.get_default_seed()
var seed_is_overridden: bool = false

var world_root: Node = null
var _world_visibility_service: WorldVisibilityService = null
var world_state: WorldState = null

var last_bootstrap_error: String = ""
var last_world_load_error: String = ""

var debug_hovered_cell_index: Vector2i = INVALID_CELL_INDEX
var debug_selected_cell_index: Vector2i = INVALID_CELL_INDEX
var debug_overlay_mode_id: String = "off"
var debug_terrain_inspector_visible: bool = true
var debug_site_hints_visible: bool = false
var debug_force_full_visibility: bool = false


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
	clear_world_state()

	# Try to resolve immediately only if definitions are already loaded.
	# If they are not loaded yet, BootScene will do the authoritative resolve pass.
	if _definitions_are_loaded():
		resolve_bootstrap_context_from_definitions()

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "bootstrap_context_updated", get_boot_context())


func resolve_bootstrap_context_from_definitions() -> bool:
	_clear_bootstrap_error()
	_clear_world_load_error()
	clear_world_state()

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


func build_world_state_from_active_definitions() -> bool:
	_clear_world_load_error()

	var definition_registry: Node = _definition_registry()
	if definition_registry == null:
		return _fail_world_load("DefinitionRegistry missing.")

	if not definition_registry.has_method("get_definition"):
		return _fail_world_load("DefinitionRegistry missing get_definition().")

	var scenario_def: ScenarioDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_SCENARIO,
		scenario_id
	) as ScenarioDef
	if scenario_def == null:
		return _fail_world_load("Scenario definition not found: %s" % scenario_id)

	var stage_def: StageDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_STAGE,
		stage_id
	) as StageDef
	if stage_def == null:
		return _fail_world_load("Stage definition not found: %s" % stage_id)

	var map_preset_def: MapPresetDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_MAP_PRESET,
		map_preset_id
	) as MapPresetDef
	if map_preset_def == null:
		return _fail_world_load("Map preset definition not found: %s" % map_preset_id)

	var worldgen_profile_def: WorldgenProfileDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_WORLDGEN_PROFILE,
		worldgen_profile_id
	) as WorldgenProfileDef
	if worldgen_profile_def == null:
		return _fail_world_load("Worldgen profile definition not found: %s" % worldgen_profile_id)

	var season_profile_def: SeasonProfileDef = definition_registry.call(
		"get_definition",
		DefinitionTypes.TYPE_SEASON_PROFILE,
		season_profile_id
	) as SeasonProfileDef
	if season_profile_def == null:
		return _fail_world_load("Season profile definition not found: %s" % season_profile_id)

	if not worldgen_profile_def.map_preset_ids.has(map_preset_id):
		return _fail_world_load(
			"Map preset '%s' is not allowed by worldgen profile '%s'." % [
				map_preset_id,
				worldgen_profile_id,
			]
		)

	if map_preset_def.fixture_id.strip_edges().is_empty():
		return _fail_world_load(
			"Map preset '%s' is missing fixture_id." % map_preset_def.get_definition_id()
		)

	var authored_map_loader: AuthoredMapLoader = AUTHORED_MAP_LOADER_SCRIPT.new() as AuthoredMapLoader
	if authored_map_loader == null:
		return _fail_world_load("Failed to create AuthoredMapLoader.")

	var built_world_state: WorldState = authored_map_loader.load_world_state_from_fixture(
		map_preset_def,
		worldgen_profile_def,
		_time_service()
	)
	if built_world_state == null:
		return _fail_world_load(
			"Failed to build world state from fixture_id: %s" % map_preset_def.fixture_id
		)

	built_world_state.seed = seed
	if built_world_state.fixture_id.strip_edges().is_empty():
		built_world_state.fixture_id = map_preset_def.fixture_id

	built_world_state.world_id = "%s:%d" % [
		built_world_state.fixture_id,
		seed
	]
	built_world_state.primary_terrain_profile_id = worldgen_profile_def.get_primary_terrain_profile_id()

	world_state = built_world_state
	debug_hovered_cell_index = INVALID_CELL_INDEX
	debug_selected_cell_index = INVALID_CELL_INDEX

	_bind_world_services(world_state)

	return true


func clear_world_state() -> void:
	_unbind_world_services()
	world_state = null
	debug_hovered_cell_index = INVALID_CELL_INDEX
	debug_selected_cell_index = INVALID_CELL_INDEX
	_clear_world_load_error()


func _bind_world_services(bound_world_state: WorldState) -> void:
	_unbind_world_services()

	if bound_world_state == null:
		return

	var time_service: Node = _time_service()
	_world_visibility_service = WORLD_VISIBILITY_SERVICE_SCRIPT.new() as WorldVisibilityService
	if _world_visibility_service == null:
		return

	_world_visibility_service.bind_world_state(bound_world_state)

	if time_service != null and time_service.has_method("register_phase_listener"):
		time_service.call(
			"register_phase_listener",
			"phase.visibility_refresh",
			_world_visibility_service,
			"_on_visibility_refresh_phase"
		)

	var initial_tick_index: int = 0
	if time_service != null:
		initial_tick_index = int(time_service.get("tick_index"))

	_world_visibility_service.refresh_now(initial_tick_index)


func _unbind_world_services() -> void:
	var time_service: Node = _time_service()

	if _world_visibility_service != null and time_service != null and time_service.has_method("unregister_phase_listener"):
		time_service.call(
			"unregister_phase_listener",
			"phase.visibility_refresh",
			_world_visibility_service,
			"_on_visibility_refresh_phase"
		)

	if _world_visibility_service != null:
		_world_visibility_service.unbind_world_state()

	_world_visibility_service = null


func has_world_state() -> bool:
	return world_state != null


func get_world_state() -> WorldState:
	return world_state


func get_world_cell_index_at_world_position(world_position: Vector2) -> Vector2i:
	if world_state == null:
		return INVALID_CELL_INDEX

	return world_state.world_position_to_cell_index(world_position)


func get_world_cell_debug_snapshot(cell_index: Vector2i) -> Dictionary:
	if world_state == null:
		return {}

	if not world_state.is_cell_index_in_bounds(cell_index):
		return {}

	return world_state.get_cell_debug_snapshot(cell_index)


func get_world_cell_debug_snapshot_at_world_position(world_position: Vector2) -> Dictionary:
	if world_state == null:
		return {}

	return world_state.get_cell_debug_snapshot_at_world_position(world_position)


func get_world_patch_debug_snapshots_for_cell(cell_index: Vector2i) -> Array:
	if world_state == null:
		return []

	if not world_state.is_cell_index_in_bounds(cell_index):
		return []

	return world_state.get_patch_debug_snapshots_for_cell(cell_index)


func get_world_patch_debug_snapshots_at_world_position(world_position: Vector2) -> Array:
	if world_state == null:
		return []

	return world_state.get_patch_debug_snapshots_at_world_position(world_position)


func set_debug_hovered_cell_from_world_position(world_position: Vector2) -> void:
	debug_hovered_cell_index = get_world_cell_index_at_world_position(world_position)


func set_debug_selected_cell_from_world_position(world_position: Vector2) -> void:
	debug_selected_cell_index = get_world_cell_index_at_world_position(world_position)


func clear_debug_selected_cell() -> void:
	debug_selected_cell_index = INVALID_CELL_INDEX


func get_debug_hovered_cell_index() -> Vector2i:
	return debug_hovered_cell_index


func get_debug_selected_cell_index() -> Vector2i:
	return debug_selected_cell_index


func get_debug_overlay_mode_id() -> String:
	return debug_overlay_mode_id


func get_debug_overlay_mode_ids() -> Array[String]:
	return _terrain_debug_visual_config.get_overlay_mode_ids()


func set_debug_overlay_mode_id(new_overlay_mode_id: String) -> void:
	var trimmed_overlay_mode_id: String = new_overlay_mode_id.strip_edges()
	if trimmed_overlay_mode_id.is_empty():
		return

	if not _terrain_debug_visual_config.is_valid_overlay_mode_id(trimmed_overlay_mode_id):
		return

	debug_overlay_mode_id = trimmed_overlay_mode_id


func cycle_debug_overlay_mode(direction: int = 1) -> String:
	var overlay_mode_ids: Array[String] = _terrain_debug_visual_config.get_overlay_mode_ids()
	var mode_count: int = overlay_mode_ids.size()

	if mode_count <= 0:
		debug_overlay_mode_id = _terrain_debug_visual_config.get_default_overlay_mode_id()
		return debug_overlay_mode_id

	var current_index: int = overlay_mode_ids.find(debug_overlay_mode_id)
	if current_index < 0:
		current_index = 0

	var direction_step: int = 1
	if direction < 0:
		direction_step = -1

	var next_index: int = posmod(current_index + direction_step, mode_count)
	debug_overlay_mode_id = overlay_mode_ids[next_index]
	return debug_overlay_mode_id

func is_debug_terrain_inspector_visible() -> bool:
	return debug_terrain_inspector_visible


func set_debug_terrain_inspector_visible(is_visible: bool) -> void:
	debug_terrain_inspector_visible = is_visible


func toggle_debug_terrain_inspector_visible() -> bool:
	debug_terrain_inspector_visible = not debug_terrain_inspector_visible
	return debug_terrain_inspector_visible


func is_debug_site_hints_visible() -> bool:
	return debug_site_hints_visible


func set_debug_site_hints_visible(is_visible: bool) -> void:
	debug_site_hints_visible = is_visible


func toggle_debug_site_hints_visible() -> bool:
	debug_site_hints_visible = not debug_site_hints_visible
	return debug_site_hints_visible

func is_debug_force_full_visibility_enabled() -> bool:
	return debug_force_full_visibility


func set_debug_force_full_visibility_enabled(is_enabled: bool) -> void:
	debug_force_full_visibility = is_enabled


func toggle_debug_force_full_visibility_enabled() -> bool:
	debug_force_full_visibility = not debug_force_full_visibility
	return debug_force_full_visibility

func get_world_debug_snapshot() -> Dictionary:
	var camera_snapshot: Dictionary = {}
	var resolved_world_root: Node = world_root

	if resolved_world_root == null:
		var current_scene: Node = get_tree().current_scene
		if current_scene != null:
			resolved_world_root = current_scene.get_node_or_null("WorldRoot")

	if resolved_world_root != null and resolved_world_root.has_method("get_camera_debug_snapshot"):
		camera_snapshot = resolved_world_root.call("get_camera_debug_snapshot")

	if world_state == null:
		return {
			"is_loaded": false,
			"debug_overlay_mode_id": debug_overlay_mode_id,
			"debug_terrain_inspector_visible": debug_terrain_inspector_visible,
			"debug_site_hints_visible": debug_site_hints_visible,
			"debug_force_full_visibility": debug_force_full_visibility,
			"camera": camera_snapshot,
			"focus_cells": [],
			"hovered_cell": {},
			"selected_cell": {},
		}

	var snapshot: Dictionary = world_state.get_world_debug_snapshot()
	snapshot["debug_overlay_mode_id"] = debug_overlay_mode_id
	snapshot["debug_terrain_inspector_visible"] = debug_terrain_inspector_visible
	snapshot["debug_site_hints_visible"] = debug_site_hints_visible
	snapshot["debug_force_full_visibility"] = debug_force_full_visibility
	snapshot["camera"] = camera_snapshot
	snapshot["focus_cells"] = snapshot.get("debug_focus_entries", [])
	snapshot["hovered_cell"] = _build_debug_inspector_entry("hovered", debug_hovered_cell_index)
	snapshot["selected_cell"] = _build_debug_inspector_entry("selected", debug_selected_cell_index)
	return snapshot


func get_last_bootstrap_error() -> String:
	return last_bootstrap_error


func get_last_world_load_error() -> String:
	return last_world_load_error


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
			"world_state_loaded": has_world_state(),
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


func _build_debug_inspector_entry(label: String, cell_index: Vector2i) -> Dictionary:
	if world_state == null:
		return {}

	if not world_state.is_cell_index_in_bounds(cell_index):
		return {}

	var cell_snapshot: Dictionary = world_state.get_cell_debug_snapshot(cell_index)
	if cell_snapshot.is_empty():
		return {}

	var patch_snapshots: Array = world_state.get_patch_debug_snapshots_for_cell(cell_index)

	return {
		"label": label,
		"cell": cell_snapshot,
		"patches": patch_snapshots,
	}


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


func _fail_world_load(message: String) -> bool:
	last_world_load_error = message
	push_error("SimRoot: %s" % message)
	return false


func _clear_world_load_error() -> void:
	last_world_load_error = ""


func _definition_registry() -> Node:
	return get_node_or_null("/root/DefinitionRegistry")


func _event_bus() -> Node:
	return get_node_or_null("/root/EventBus")


func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")


func _time_service() -> Node:
	return get_node_or_null("/root/TimeService")
