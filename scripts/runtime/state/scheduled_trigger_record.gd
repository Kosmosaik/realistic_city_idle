extends RefCounted
class_name ScheduledTriggerRecord

# Minimal deterministic scheduled-trigger record for Branch 02.
# This is intentionally generic so later systems can reuse it.

var schedule_serial: int = 0
var trigger_id: String = ""
var trigger_type_id: String = ""
var scheduled_tick: int = 0
var created_tick: int = 0
var source_phase_id: String = ""
var debug_label: String = ""
var payload: Dictionary = {}

func to_snapshot() -> Dictionary:
	return {
		"schedule_serial": schedule_serial,
		"trigger_id": trigger_id,
		"trigger_type_id": trigger_type_id,
		"scheduled_tick": scheduled_tick,
		"created_tick": created_tick,
		"source_phase_id": source_phase_id,
		"debug_label": debug_label,
		"payload": payload.duplicate(true),
	}

func get_debug_summary() -> String:
	var label_text: String = debug_label.strip_edges()
	if label_text.is_empty():
		label_text = trigger_type_id

	return "t%s:%s" % [scheduled_tick, label_text]
