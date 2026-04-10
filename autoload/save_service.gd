extends Node

const SAVE_ROOT: String = "user://saves"

func get_save_root_path() -> String:
	return SAVE_ROOT

func get_slot_path(slot_name: String) -> String:
	return "%s/%s.json" % [SAVE_ROOT, _sanitize_slot_name(slot_name)]

func _sanitize_slot_name(slot_name: String) -> String:
	return slot_name.strip_edges().to_lower().replace(" ", "_")
