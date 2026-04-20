extends RefCounted
class_name TimeTriggerQueue

# Internal storage/helper for deterministic scheduled triggers.
# TimeService still owns validation, signals, debug metrics, and trigger effects.

var _scheduled_trigger_records: Array = []
var _next_scheduled_trigger_serial: int = 1


func schedule_trigger_at_tick(
	trigger_id: String,
	trigger_type_id: String,
	scheduled_tick: int,
	payload: Dictionary,
	debug_label: String,
	source_phase_id: String,
	created_tick: int
) -> ScheduledTriggerRecord:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	var trimmed_trigger_type_id: String = trigger_type_id.strip_edges()
	var trimmed_source_phase_id: String = source_phase_id.strip_edges()

	_remove_trigger_by_id(trimmed_trigger_id)

	var record: ScheduledTriggerRecord = ScheduledTriggerRecord.new()
	record.schedule_serial = _next_scheduled_trigger_serial
	record.trigger_id = trimmed_trigger_id
	record.trigger_type_id = trimmed_trigger_type_id
	record.scheduled_tick = scheduled_tick
	record.created_tick = created_tick
	record.source_phase_id = trimmed_source_phase_id
	record.debug_label = debug_label
	record.payload = payload.duplicate(true)

	_next_scheduled_trigger_serial += 1
	_scheduled_trigger_records.append(record)
	_scheduled_trigger_records.sort_custom(_sort_scheduled_trigger_records)

	return record


func cancel_trigger(trigger_id: String) -> void:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	if trimmed_trigger_id.is_empty():
		return

	_remove_trigger_by_id(trimmed_trigger_id)


func has_trigger(trigger_id: String) -> bool:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	if trimmed_trigger_id.is_empty():
		return false

	for record_variant: Variant in _scheduled_trigger_records:
		var record: ScheduledTriggerRecord = record_variant as ScheduledTriggerRecord
		if record != null and record.trigger_id == trimmed_trigger_id:
			return true

	return false


func get_count() -> int:
	return _scheduled_trigger_records.size()


func get_next_scheduled_tick() -> int:
	if _scheduled_trigger_records.is_empty():
		return -1

	var first_record: ScheduledTriggerRecord = _scheduled_trigger_records[0] as ScheduledTriggerRecord
	if first_record == null:
		return -1

	return first_record.scheduled_tick


func build_queue_preview(limit: int = 4) -> Array[Dictionary]:
	var preview: Array[Dictionary] = []
	var safe_limit: int = maxi(limit, 0)
	var index: int = 0

	while index < _scheduled_trigger_records.size() and index < safe_limit:
		var record: ScheduledTriggerRecord = _scheduled_trigger_records[index] as ScheduledTriggerRecord
		if record != null:
			preview.append(record.to_snapshot())
		index += 1

	return preview


func pop_due_records(current_tick: int) -> Array:
	var due_records: Array = []

	_scheduled_trigger_records.sort_custom(_sort_scheduled_trigger_records)

	while not _scheduled_trigger_records.is_empty():
		var first_record: ScheduledTriggerRecord = _scheduled_trigger_records[0] as ScheduledTriggerRecord
		if first_record == null:
			_scheduled_trigger_records.pop_front()
			continue

		if first_record.scheduled_tick > current_tick:
			break

		_scheduled_trigger_records.pop_front()
		due_records.append(first_record)

	return due_records


func clear() -> void:
	_scheduled_trigger_records.clear()
	_next_scheduled_trigger_serial = 1


func _remove_trigger_by_id(trigger_id: String) -> void:
	var filtered_records: Array = []

	for record_variant: Variant in _scheduled_trigger_records:
		var record: ScheduledTriggerRecord = record_variant as ScheduledTriggerRecord
		if record == null:
			continue

		if record.trigger_id != trigger_id:
			filtered_records.append(record)

	_scheduled_trigger_records = filtered_records


func _sort_scheduled_trigger_records(left_value: Variant, right_value: Variant) -> bool:
	var left_record: ScheduledTriggerRecord = left_value as ScheduledTriggerRecord
	var right_record: ScheduledTriggerRecord = right_value as ScheduledTriggerRecord

	if left_record == null and right_record == null:
		return false

	if left_record == null:
		return false

	if right_record == null:
		return true

	if left_record.scheduled_tick != right_record.scheduled_tick:
		return left_record.scheduled_tick < right_record.scheduled_tick

	return left_record.schedule_serial < right_record.schedule_serial
