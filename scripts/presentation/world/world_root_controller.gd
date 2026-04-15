extends Node2D
class_name WorldRootController

const MAP_PLACEHOLDER_SCRIPT: Script = preload("res://scripts/presentation/world/map_placeholder.gd")
const DEV_HUD_SCRIPT: Script = preload("res://scripts/presentation/ui/dev_hud.gd")
const DEBUG_SCHEDULED_TRIGGER_PROBE_SCRIPT: Script = preload("res://scripts/runtime/debug/debug_scheduled_trigger_probe.gd")
const WORLD_CELL_INSPECTOR_PROBE_SCRIPT: Script = preload("res://scripts/presentation/world/world_cell_inspector_probe.gd")

const CAMERA_NAME: String = "WorldCamera"
const MAP_NAME: String = "MapPlaceholder"
const HUD_NAME: String = "DevHud"
const DEBUG_SCHEDULED_TRIGGER_PROBE_NAME: String = "DebugScheduledTriggerProbe"
const WORLD_CELL_INSPECTOR_PROBE_NAME: String = "WorldCellInspectorProbe"

func _ready() -> void:
	_ensure_map_placeholder()
	_ensure_camera()
	_ensure_dev_hud()
	_ensure_debug_scheduled_trigger_probe()
	_ensure_world_cell_inspector_probe()

	var sim_root: Node = _sim_root()
	if sim_root != null and sim_root.has_method("register_world_root"):
		sim_root.call("register_world_root", self)

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "world", "world_root_ready", {
			"scene_file_path": scene_file_path,
			"scenario_id": _get_scenario_id(),
			"seed": _get_seed(),
		})

func _exit_tree() -> void:
	var sim_root: Node = _sim_root()
	if sim_root != null and sim_root.has_method("unregister_world_root"):
		sim_root.call("unregister_world_root", self)

func _ensure_map_placeholder() -> void:
	if get_node_or_null(MAP_NAME) != null:
		return

	var map_placeholder: Node2D = MAP_PLACEHOLDER_SCRIPT.new()
	map_placeholder.name = MAP_NAME
	add_child(map_placeholder)

func _ensure_camera() -> void:
	var camera: Camera2D = get_node_or_null(CAMERA_NAME) as Camera2D

	if camera == null:
		camera = Camera2D.new()
		camera.name = CAMERA_NAME
		camera.position = Vector2(1024.0, 768.0)
		camera.zoom = Vector2(0.63, 0.63)
		add_child(camera)

	camera.make_current()

func _ensure_dev_hud() -> void:
	if get_node_or_null(HUD_NAME) != null:
		return

	var dev_hud: CanvasLayer = DEV_HUD_SCRIPT.new()
	dev_hud.name = HUD_NAME
	add_child(dev_hud)

func _ensure_debug_scheduled_trigger_probe() -> void:
	if get_node_or_null(DEBUG_SCHEDULED_TRIGGER_PROBE_NAME) != null:
		return

	var debug_probe: Node = DEBUG_SCHEDULED_TRIGGER_PROBE_SCRIPT.new()
	debug_probe.name = DEBUG_SCHEDULED_TRIGGER_PROBE_NAME
	add_child(debug_probe)

func _ensure_world_cell_inspector_probe() -> void:
	if get_node_or_null(WORLD_CELL_INSPECTOR_PROBE_NAME) != null:
		return

	var inspector_probe: Node2D = WORLD_CELL_INSPECTOR_PROBE_SCRIPT.new()
	inspector_probe.name = WORLD_CELL_INSPECTOR_PROBE_NAME
	add_child(inspector_probe)

func _get_scenario_id() -> String:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return "scenario.dev.temperate_valley"

	return str(sim_root.get("scenario_id"))

func _get_seed() -> int:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return 100001

	return int(sim_root.get("seed"))

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")
