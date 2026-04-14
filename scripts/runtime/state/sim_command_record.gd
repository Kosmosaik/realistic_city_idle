extends RefCounted
class_name SimCommandRecord

# Minimal deterministic command record for Branch 02.
# This is generic on purpose so later systems can reuse it.

var enqueue_serial: int = 0
var command_id: String = ""
var command_type_id: String = ""
var created_tick: int = 0
var source_id: String = ""
var debug_label: String = ""
var payload: Dictionary = {}

func to_snapshot() -> Dictionary:
	return {
		"enqueue_serial": enqueue_serial,
		"command_id": command_id,
		"command_type_id": command_type_id,
		"created_tick": created_tick,
		"source_id": source_id,
		"debug_label": debug_label,
		"payload": payload.duplicate(true),
	}

func get_debug_summary() -> String:
	var label_text: String = debug_label.strip_edges()
	if label_text.is_empty():
		label_text = command_type_id

	return "%s:%s" % [command_id, label_text]
