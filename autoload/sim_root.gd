extends Node

const DEFAULT_SCENARIO_ID: String = "scenario.dev.temperate_valley"
const DEFAULT_STAGE_ID: String = "stage.lone_survivor"
const DEFAULT_SEED: int = 100001

var scenario_id: String = DEFAULT_SCENARIO_ID
var stage_id: String = DEFAULT_STAGE_ID
var seed: int = DEFAULT_SEED
var world_root: Node = null

func _ready() -> void:
	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "sim_root_ready", get_boot_context())

func set_bootstrap_context(new_scenario_id: String, new_seed: int) -> void:
	if new_scenario_id.strip_edges().is_empty():
		push_error("SimRoot: scenario_id must not be empty.")
		return

	scenario_id = new_scenario_id
	seed = new_seed

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "sim", "bootstrap_context_updated", get_boot_context())

func get_boot_context() -> Dictionary:
	var calendar: Dictionary = {}
	var time_service: Node = _time_service()

	if time_service != null and time_service.has_method("get_calendar_snapshot"):
		calendar = time_service.call("get_calendar_snapshot")

	return {
		"scenario_id": scenario_id,
		"stage_id": stage_id,
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

func _event_bus() -> Node:
	return get_node_or_null("/root/EventBus")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")

func _time_service() -> Node:
	return get_node_or_null("/root/TimeService")
