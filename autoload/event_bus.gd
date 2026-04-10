extends Node

signal scene_requested(scene_path: String)
signal scene_changed(scene_path: String)
signal world_registered(world_root: Node)
signal world_unregistered()
signal dev_log_emitted(channel: String, event_id: String, payload: Dictionary)

func emit_dev_log(channel: String, event_id: String, payload: Dictionary = {}) -> void:
	dev_log_emitted.emit(channel, event_id, payload)
