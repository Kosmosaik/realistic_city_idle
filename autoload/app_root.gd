extends Node

var build_version: String = "0.0.0-dev"
var engine_version_string: String = ""
var current_scene_path: String = ""

func _ready() -> void:
	build_version = str(ProjectSettings.get_setting("application/config/version", "0.0.0-dev"))
	engine_version_string = _build_engine_version_string()

func goto_scene(scene_path: String) -> void:
	if not ResourceLoader.exists(scene_path):
		push_error("AppRoot: scene does not exist: %s" % scene_path)
		return

	var event_bus: Node = _event_bus()
	if event_bus != null:
		event_bus.emit_signal("scene_requested", scene_path)

	current_scene_path = scene_path

	var error: Error = get_tree().change_scene_to_file(scene_path)
	if error != OK:
		push_error("AppRoot: failed to change scene to %s (error %s)" % [scene_path, error])
		return

	call_deferred("_emit_scene_changed", scene_path)

func get_build_info() -> Dictionary:
	return {
		"project_name": str(ProjectSettings.get_setting("application/config/name", "Realistic City Idle")),
		"build_version": build_version,
		"engine_version": engine_version_string,
		"current_scene_path": current_scene_path,
	}

func _emit_scene_changed(scene_path: String) -> void:
	var event_bus: Node = _event_bus()
	if event_bus != null:
		event_bus.emit_signal("scene_changed", scene_path)

func _build_engine_version_string() -> String:
	var info: Dictionary = Engine.get_version_info()
	var major: int = int(info.get("major", 0))
	var minor: int = int(info.get("minor", 0))
	var patch: int = int(info.get("patch", 0))
	var status: String = str(info.get("status", ""))

	var version: String = "%d.%d.%d" % [major, minor, patch]
	if status != "":
		version += ".%s" % status

	return version

func _event_bus() -> Node:
	return get_node_or_null("/root/EventBus")
