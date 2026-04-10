extends Node
class_name BootScene

const DEV_WORLD_SCENE_PATH: String = "res://scenes/world/test_world_scene.tscn"

func _ready() -> void:
	var telemetry_service: Node = _telemetry_service()
	var sim_root: Node = _sim_root()

	if telemetry_service != null and sim_root != null:
		telemetry_service.call("log", "boot", "boot_scene_ready", {
			"scenario_id": str(sim_root.get("scenario_id")),
			"seed": int(sim_root.get("seed")),
			"stage_id": str(sim_root.get("stage_id")),
		})

	call_deferred("_go_to_dev_world")

func _go_to_dev_world() -> void:
	var app_root: Node = _app_root()
	if app_root == null:
		push_error("BootScene: AppRoot autoload is missing.")
		return

	app_root.call("goto_scene", DEV_WORLD_SCENE_PATH)

func _app_root() -> Node:
	return get_node_or_null("/root/AppRoot")

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")
