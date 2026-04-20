extends RefCounted
class_name TimeCommandQueue

# Internal storage/helper for deterministic queued commands.
# TimeService still owns validation, signals, debug metrics, and logging.

var _queued_command_records: Array = []
var _next_command_enqueue_serial: int = 1


func enqueue_command(
	command_type_id: String,
	payload: Dictionary,
	source_id: String,
	debug_label: String,
	created_tick: int
) -> SimCommandRecord:
	var record: SimCommandRecord = SimCommandRecord.new()
	record.enqueue_serial = _next_command_enqueue_serial
	record.command_id = _build_command_id(_next_command_enqueue_serial)
	record.command_type_id = command_type_id
	record.created_tick = created_tick
	record.source_id = source_id
	record.debug_label = debug_label
	record.payload = payload.duplicate(true)

	_next_command_enqueue_serial += 1
	_queued_command_records.append(record)
	return record


func cancel_command(command_id: String) -> void:
	var trimmed_command_id: String = command_id.strip_edges()
	if trimmed_command_id.is_empty():
		return

	var filtered_records: Array = []

	for record_variant: Variant in _queued_command_records:
		var record: SimCommandRecord = record_variant as SimCommandRecord
		if record == null:
			continue

		if record.command_id != trimmed_command_id:
			filtered_records.append(record)

	_queued_command_records = filtered_records


func get_count() -> int:
	return _queued_command_records.size()


func build_queue_preview(limit: int = 4) -> Array[Dictionary]:
	var preview: Array[Dictionary] = []
	var safe_limit: int = maxi(limit, 0)
	var index: int = 0

	while index < _queued_command_records.size() and index < safe_limit:
		var record: SimCommandRecord = _queued_command_records[index] as SimCommandRecord
		if record != null:
			preview.append(record.to_snapshot())
		index += 1

	return preview


func drain_all() -> Array:
	var drained_records: Array = []

	for record_variant: Variant in _queued_command_records:
		var record: SimCommandRecord = record_variant as SimCommandRecord
		if record != null:
			drained_records.append(record)

	_queued_command_records.clear()
	return drained_records


func clear() -> void:
	_queued_command_records.clear()
	_next_command_enqueue_serial = 1


func _build_command_id(enqueue_serial: int) -> String:
	return "command.%010d" % enqueue_serial
