extends Node

const MAX_EVENTS: int = 200

var _events: Array[Dictionary] = []

func log(channel: String, event_id: String, payload: Dictionary = {}) -> void:
	var record: Dictionary = {
		"sequence": _events.size(),
		"channel": channel,
		"event_id": event_id,
		"payload": payload.duplicate(true),
		"ticks_msec": Time.get_ticks_msec(),
	}

	_events.append(record)

	if _events.size() > MAX_EVENTS:
		_events.pop_front()

	var event_bus: Node = _event_bus()
	if event_bus != null:
		event_bus.call("emit_dev_log", channel, event_id, payload)

func get_recent_events(limit: int = 20) -> Array[Dictionary]:
	if limit <= 0:
		return []

	var start_index: int = max(_events.size() - limit, 0)
	return _events.slice(start_index, _events.size())

func clear() -> void:
	_events.clear()

func _event_bus() -> Node:
	return get_node_or_null("/root/EventBus")
