extends Node

signal sim_paused_changed(is_paused: bool)
signal sim_speed_changed(speed_index: int, speed_multiplier: int)
signal sim_tick_started(tick_index: int)
signal sim_phase_started(tick_index: int, phase_id: String)
signal sim_tick_completed(snapshot: Dictionary)
signal scheduled_trigger_resolved(trigger_snapshot: Dictionary, phase_context: Dictionary)
signal command_enqueued(command_snapshot: Dictionary)
signal queued_command_processed(command_snapshot: Dictionary, phase_context: Dictionary)

const DEFAULT_TICK_INDEX: int = 0
const DEFAULT_DAY_INDEX: int = 1
const DEFAULT_YEAR_INDEX: int = 0
const DEFAULT_SEASON_ID: String = CalendarIds.SEASON_SPRING
const DEFAULT_PART_OF_DAY_ID: String = CalendarIds.PART_OF_DAY_DAWN
const DEFAULT_SCENARIO_SEED: int = 0

const DEFAULT_SPEED_INDEX: int = 0
const DEFAULT_BASE_TICKS_PER_SECOND: float = 2.0
const MAX_TICKS_PER_FRAME: int = 8
const DEFAULT_PHASE_LISTENER_PRIORITY: int = 100
const DEBUG_RECENT_PHASE_ENTRY_LIMIT: int = 10
const DEBUG_RECENT_TRIGGER_ENTRY_LIMIT: int = 8
const DEBUG_TRIGGER_QUEUE_PREVIEW_LIMIT: int = 4
const DEBUG_RECENT_COMMAND_ENTRY_LIMIT: int = 8
const DEBUG_DETERMINISM_HASH_SEED: int = 2166136261
const DEBUG_DETERMINISM_HASH_MULTIPLIER: int = 16777619

const DEBUG_TOGGLE_PAUSE_KEY: Key = KEY_SPACE
const DEBUG_STEP_KEY: Key = KEY_PERIOD
const DEBUG_SPEED_DOWN_KEY: Key = KEY_BRACKETLEFT
const DEBUG_SPEED_UP_KEY: Key = KEY_BRACKETRIGHT

const SPEED_MULTIPLIERS: Array[int] = [1, 2, 4, 8]

# Internal Branch 02 trigger vocabulary.
# These are runtime implementation triggers, not content definitions.
const INTERNAL_TRIGGER_ID_NEXT_DAY_START: String = "internal.next_day_start"
const INTERNAL_TRIGGER_TYPE_DAY_START: String = "trigger.calendar.day_start"

var tick_index: int = DEFAULT_TICK_INDEX
var day_index: int = DEFAULT_DAY_INDEX
var year_index: int = DEFAULT_YEAR_INDEX
var season_id: String = DEFAULT_SEASON_ID
var part_of_day_id: String = DEFAULT_PART_OF_DAY_ID
var season_profile_id: String = ""
var ticks_per_part_of_day: int = 1
var scenario_seed: int = DEFAULT_SCENARIO_SEED

var is_paused: bool = true
var speed_index: int = DEFAULT_SPEED_INDEX
var base_ticks_per_second: float = DEFAULT_BASE_TICKS_PER_SECOND
var active_phase_id: String = ""
var last_completed_phase_id: String = ""

# These are debug-facing latched values.
# They make the run loop visible even when individual phases finish too fast for the HUD to catch live.
var debug_visible_phase_id: String = ""
var debug_visible_phase_tick_index: int = DEFAULT_TICK_INDEX
var debug_visible_phase_transition_serial: int = 0
var debug_last_completed_tick_index: int = DEFAULT_TICK_INDEX
var debug_last_tick_total_duration_usec: int = 0
var debug_last_phase_duration_usec_by_phase: Dictionary = {}
var debug_recent_phase_entries: Array[String] = []

# Scheduled-trigger debug visibility.
var debug_last_resolved_trigger_id: String = ""
var debug_last_resolved_trigger_type_id: String = ""
var debug_last_resolved_trigger_tick: int = -1
var debug_resolved_trigger_count_total: int = 0
var debug_recent_resolved_trigger_entries: Array[String] = []

# Queued-command debug visibility.
var debug_last_processed_command_id: String = ""
var debug_last_processed_command_type_id: String = ""
var debug_last_processed_command_tick: int = -1
var debug_processed_command_count_total: int = 0
var debug_recent_processed_command_entries: Array[String] = []

# Determinism debug visibility.
# This is a dev-facing rolling signature of important run-loop events.
var debug_determinism_signature: int = DEBUG_DETERMINISM_HASH_SEED
var debug_determinism_event_count: int = 0
var debug_determinism_last_event: String = ""

var _queued_command_records: Array = []
var _next_command_enqueue_serial: int = 1

var _part_of_day_ids: PackedStringArray = PackedStringArray([
	CalendarIds.PART_OF_DAY_DAWN,
	CalendarIds.PART_OF_DAY_DAY,
	CalendarIds.PART_OF_DAY_DUSK,
	CalendarIds.PART_OF_DAY_NIGHT,
])
var _supported_season_ids: PackedStringArray = PackedStringArray([
	CalendarIds.SEASON_SPRING,
	CalendarIds.SEASON_SUMMER,
	CalendarIds.SEASON_AUTUMN,
	CalendarIds.SEASON_WINTER,
])

var _tick_progress_within_part: int = 0
var _accumulated_sim_seconds: float = 0.0
var _phase_listener_records_by_phase: Dictionary = {}
var _next_phase_listener_registration_id: int = 1
var _rng_streams: Dictionary = {}

var _scheduled_trigger_records: Array = []
var _next_scheduled_trigger_serial: int = 1

func _ready() -> void:
	_initialize_phase_listener_registry()
	_initialize_debug_phase_metrics()
	_initialize_debug_trigger_metrics()
	_initialize_debug_command_metrics()
	_initialize_debug_determinism_metrics()
	_refresh_run_seed_from_sim_root()
	_validate_calendar_tokens()
	set_process(true)
	set_process_unhandled_input(true)

func _process(delta: float) -> void:
	_refresh_run_seed_from_sim_root()

	if is_paused:
		return

	if base_ticks_per_second <= 0.0:
		return

	var speed_multiplier: int = get_speed_multiplier()
	var effective_ticks_per_second: float = base_ticks_per_second * float(speed_multiplier)
	if effective_ticks_per_second <= 0.0:
		return

	var seconds_per_tick: float = 1.0 / effective_ticks_per_second
	_accumulated_sim_seconds += delta

	var ticks_processed_this_frame: int = 0
	while _accumulated_sim_seconds >= seconds_per_tick and ticks_processed_this_frame < MAX_TICKS_PER_FRAME:
		_accumulated_sim_seconds -= seconds_per_tick
		_run_one_tick()
		ticks_processed_this_frame += 1

func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey):
		return

	var key_event: InputEventKey = event as InputEventKey
	if key_event == null:
		return

	if not key_event.pressed:
		return

	if key_event.echo:
		return

	if key_event.physical_keycode == DEBUG_TOGGLE_PAUSE_KEY:
		toggle_paused()
		get_viewport().set_input_as_handled()
		return

	if key_event.physical_keycode == DEBUG_STEP_KEY:
		step_once()
		get_viewport().set_input_as_handled()
		return

	if key_event.physical_keycode == DEBUG_SPEED_DOWN_KEY:
		decrease_speed()
		get_viewport().set_input_as_handled()
		return

	if key_event.physical_keycode == DEBUG_SPEED_UP_KEY:
		increase_speed()
		get_viewport().set_input_as_handled()
		return

func apply_season_profile_bootstrap(season_profile_def: SeasonProfileDef) -> void:
	# Branch 01 stays authoritative for bootstrap defaults.
	# Branch 02 layers deterministic run-loop state and scheduled-trigger handling on top.
	if season_profile_def == null:
		push_error("TimeService: apply_season_profile_bootstrap received null season profile.")
		return

	season_profile_id = season_profile_def.season_profile_id
	season_id = season_profile_def.default_start_season_id
	ticks_per_part_of_day = max(season_profile_def.ticks_per_part_of_day, 1)

	if season_profile_def.part_of_day_ids.is_empty():
		_part_of_day_ids = PackedStringArray([
			CalendarIds.PART_OF_DAY_DAWN,
			CalendarIds.PART_OF_DAY_DAY,
			CalendarIds.PART_OF_DAY_DUSK,
			CalendarIds.PART_OF_DAY_NIGHT,
		])
	else:
		_part_of_day_ids = season_profile_def.part_of_day_ids.duplicate()

	if season_profile_def.supported_season_ids.is_empty():
		_supported_season_ids = PackedStringArray([
			CalendarIds.SEASON_SPRING,
			CalendarIds.SEASON_SUMMER,
			CalendarIds.SEASON_AUTUMN,
			CalendarIds.SEASON_WINTER,
		])
	else:
		_supported_season_ids = season_profile_def.supported_season_ids.duplicate()

	part_of_day_id = str(_part_of_day_ids[0])

	tick_index = DEFAULT_TICK_INDEX
	day_index = DEFAULT_DAY_INDEX
	year_index = DEFAULT_YEAR_INDEX
	_tick_progress_within_part = 0
	_accumulated_sim_seconds = 0.0
	active_phase_id = ""
	last_completed_phase_id = ""

	_initialize_debug_phase_metrics()
	_initialize_debug_trigger_metrics()
	_initialize_debug_command_metrics()
	_initialize_debug_determinism_metrics()
	_refresh_run_seed_from_sim_root()
	_reset_rng_streams()
	_clear_scheduled_triggers()
	_clear_queued_commands()
	_record_bootstrap_determinism_inputs()
	_schedule_internal_next_day_start_trigger()
	_validate_calendar_tokens()

func set_paused(new_is_paused: bool) -> void:
	if is_paused == new_is_paused:
		return

	is_paused = new_is_paused
	sim_paused_changed.emit(is_paused)
	_log_run_loop_event("pause_changed", {
		"is_paused": is_paused,
	})

func toggle_paused() -> void:
	set_paused(not is_paused)

func set_speed_index(new_speed_index: int) -> void:
	var clamped_speed_index: int = clampi(new_speed_index, 0, SPEED_MULTIPLIERS.size() - 1)
	if speed_index == clamped_speed_index:
		return

	speed_index = clamped_speed_index
	sim_speed_changed.emit(speed_index, get_speed_multiplier())
	_log_run_loop_event("speed_changed", {
		"speed_index": speed_index,
		"speed_multiplier": get_speed_multiplier(),
	})

func increase_speed() -> void:
	set_speed_index(speed_index + 1)

func decrease_speed() -> void:
	set_speed_index(speed_index - 1)

func get_speed_multiplier() -> int:
	return int(SPEED_MULTIPLIERS[speed_index])

func step_once() -> void:
	_refresh_run_seed_from_sim_root()
	_run_one_tick()

func register_phase_listener(
	phase_id: String,
	listener_owner: Object,
	callback_method: String,
	priority: int = DEFAULT_PHASE_LISTENER_PRIORITY
) -> bool:
	if not SimPhaseIds.is_valid_phase_id(phase_id):
		push_error("TimeService: cannot register listener for invalid phase '%s'." % phase_id)
		return false

	if listener_owner == null:
		push_error("TimeService: cannot register phase listener with null owner.")
		return false

	if callback_method.strip_edges().is_empty():
		push_error("TimeService: callback method must not be empty.")
		return false

	if not listener_owner.has_method(callback_method):
		push_error("TimeService: listener owner does not implement method '%s'." % callback_method)
		return false

	var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
	var listener_record: Dictionary = {
		"owner_ref": weakref(listener_owner),
		"callback_method": callback_method,
		"priority": priority,
		"registration_id": _next_phase_listener_registration_id,
	}

	_next_phase_listener_registration_id += 1
	listener_records.append(listener_record)
	_phase_listener_records_by_phase[phase_id] = listener_records

	_log_run_loop_event("phase_listener_registered", {
		"phase_id": phase_id,
		"callback_method": callback_method,
		"priority": priority,
		"phase_listener_count_total": get_phase_listener_count_total(),
	})

	return true

func unregister_phase_listener(
	phase_id: String,
	listener_owner: Object,
	callback_method: String = ""
) -> void:
	if not SimPhaseIds.is_valid_phase_id(phase_id):
		return

	if listener_owner == null:
		return

	var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
	var filtered_listener_records: Array = []

	for listener_record: Dictionary in listener_records:
		var owner_ref: WeakRef = listener_record.get("owner_ref")
		var owner: Object = owner_ref.get_ref()
		var registered_callback_method: String = str(listener_record.get("callback_method", ""))

		if owner == null:
			continue

		if owner != listener_owner:
			filtered_listener_records.append(listener_record)
			continue

		if callback_method != "" and registered_callback_method != callback_method:
			filtered_listener_records.append(listener_record)

	_phase_listener_records_by_phase[phase_id] = filtered_listener_records

func enqueue_command(
	command_type_id: String,
	payload: Dictionary = {},
	source_id: String = "",
	debug_label: String = ""
) -> String:
	var trimmed_command_type_id: String = command_type_id.strip_edges()
	var trimmed_source_id: String = source_id.strip_edges()

	if trimmed_command_type_id.is_empty():
		push_error("TimeService: command_type_id must not be empty.")
		return ""

	var record: SimCommandRecord = SimCommandRecord.new()
	record.enqueue_serial = _next_command_enqueue_serial
	record.command_id = _build_command_id(_next_command_enqueue_serial)
	record.command_type_id = trimmed_command_type_id
	record.created_tick = tick_index
	record.source_id = trimmed_source_id
	record.debug_label = debug_label
	record.payload = payload.duplicate(true)

	_next_command_enqueue_serial += 1
	_queued_command_records.append(record)

	var command_snapshot: Dictionary = record.to_snapshot()
	command_enqueued.emit(command_snapshot)

	_log_run_loop_event("command_enqueued", command_snapshot)
	return record.command_id

func cancel_queued_command(command_id: String) -> void:
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

func get_queued_command_count() -> int:
	return _queued_command_records.size()

func get_queued_command_queue_preview(limit: int = 4) -> Array[Dictionary]:
	var preview: Array[Dictionary] = []
	var safe_limit: int = maxi(limit, 0)
	var index: int = 0

	while index < _queued_command_records.size() and index < safe_limit:
		var record: SimCommandRecord = _queued_command_records[index] as SimCommandRecord
		if record != null:
			preview.append(record.to_snapshot())
		index += 1

	return preview

func get_phase_listener_count_total() -> int:
	var total_count: int = 0

	for phase_id: String in SimPhaseIds.ORDERED_PHASE_IDS:
		_prune_stale_phase_listeners(phase_id)
		var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
		total_count += listener_records.size()

	return total_count

func get_phase_listener_counts_by_phase() -> Dictionary:
	var counts_by_phase: Dictionary = {}

	for phase_id: String in SimPhaseIds.ORDERED_PHASE_IDS:
		_prune_stale_phase_listeners(phase_id)
		var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
		counts_by_phase[phase_id] = listener_records.size()

	return counts_by_phase

func schedule_trigger_at_tick(
	trigger_id: String,
	trigger_type_id: String,
	scheduled_tick: int,
	payload: Dictionary = {},
	debug_label: String = "",
	source_phase_id: String = ""
) -> bool:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	var trimmed_trigger_type_id: String = trigger_type_id.strip_edges()
	var trimmed_source_phase_id: String = source_phase_id.strip_edges()

	if trimmed_trigger_id.is_empty():
		push_error("TimeService: trigger_id must not be empty.")
		return false

	if trimmed_trigger_type_id.is_empty():
		push_error("TimeService: trigger_type_id must not be empty.")
		return false

	if scheduled_tick < tick_index:
		push_error(
			"TimeService: cannot schedule trigger '%s' in the past. scheduled_tick=%s tick_index=%s" % [
				trimmed_trigger_id,
				scheduled_tick,
				tick_index,
			]
		)
		return false

	_remove_scheduled_trigger_by_id(trimmed_trigger_id)

	var record: ScheduledTriggerRecord = ScheduledTriggerRecord.new()
	record.schedule_serial = _next_scheduled_trigger_serial
	record.trigger_id = trimmed_trigger_id
	record.trigger_type_id = trimmed_trigger_type_id
	record.scheduled_tick = scheduled_tick
	record.created_tick = tick_index
	record.source_phase_id = trimmed_source_phase_id
	record.debug_label = debug_label
	record.payload = payload.duplicate(true)

	_next_scheduled_trigger_serial += 1
	_scheduled_trigger_records.append(record)
	_scheduled_trigger_records.sort_custom(_sort_scheduled_trigger_records)

	_log_run_loop_event("trigger_scheduled", record.to_snapshot())
	return true

func schedule_trigger_in_ticks(
	trigger_id: String,
	trigger_type_id: String,
	ticks_from_now: int,
	payload: Dictionary = {},
	debug_label: String = "",
	source_phase_id: String = ""
) -> bool:
	var safe_ticks_from_now: int = maxi(ticks_from_now, 0)
	var resolved_scheduled_tick: int = tick_index + safe_ticks_from_now

	return schedule_trigger_at_tick(
		trigger_id,
		trigger_type_id,
		resolved_scheduled_tick,
		payload,
		debug_label,
		source_phase_id
	)

func cancel_scheduled_trigger(trigger_id: String) -> void:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	if trimmed_trigger_id.is_empty():
		return

	_remove_scheduled_trigger_by_id(trimmed_trigger_id)

func has_scheduled_trigger(trigger_id: String) -> bool:
	var trimmed_trigger_id: String = trigger_id.strip_edges()
	if trimmed_trigger_id.is_empty():
		return false

	for record_variant: Variant in _scheduled_trigger_records:
		var record: ScheduledTriggerRecord = record_variant as ScheduledTriggerRecord
		if record != null and record.trigger_id == trimmed_trigger_id:
			return true

	return false

func get_scheduled_trigger_count() -> int:
	return _scheduled_trigger_records.size()

func get_next_scheduled_trigger_tick() -> int:
	if _scheduled_trigger_records.is_empty():
		return -1

	var first_record: ScheduledTriggerRecord = _scheduled_trigger_records[0] as ScheduledTriggerRecord
	if first_record == null:
		return -1

	return first_record.scheduled_tick

func get_scheduled_trigger_queue_preview(limit: int = DEBUG_TRIGGER_QUEUE_PREVIEW_LIMIT) -> Array[Dictionary]:
	var preview: Array[Dictionary] = []
	var safe_limit: int = maxi(limit, 0)
	var index: int = 0

	while index < _scheduled_trigger_records.size() and index < safe_limit:
		var record: ScheduledTriggerRecord = _scheduled_trigger_records[index] as ScheduledTriggerRecord
		if record != null:
			preview.append(record.to_snapshot())
		index += 1

	return preview

func ensure_rng_stream(stream_id: String) -> void:
	var trimmed_stream_id: String = stream_id.strip_edges()
	if trimmed_stream_id.is_empty():
		push_error("TimeService: RNG stream_id must not be empty.")
		return

	if _rng_streams.has(trimmed_stream_id):
		return

	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var stream_seed: int = _build_stream_seed(scenario_seed, trimmed_stream_id)
	rng.seed = stream_seed

	_rng_streams[trimmed_stream_id] = {
		"rng": rng,
		"initial_seed": stream_seed,
		"draw_count": 0,
	}

	_log_run_loop_event("rng_stream_created", {
		"stream_id": trimmed_stream_id,
		"initial_seed": stream_seed,
		"rng_stream_count": _rng_streams.size(),
	})

func randf_stream(stream_id: String) -> float:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return 0.0

	var value: float = rng.randf()
	_increment_rng_stream_draw_count(stream_id)
	return value

func randi_stream(stream_id: String) -> int:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return 0

	var value: int = rng.randi()
	_increment_rng_stream_draw_count(stream_id)
	return value

func randi_range_stream(stream_id: String, from_value: int, to_value: int) -> int:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return from_value

	var value: int = rng.randi_range(from_value, to_value)
	_increment_rng_stream_draw_count(stream_id)
	return value

func shuffle_array_with_stream(values: Array, stream_id: String) -> Array:
	var shuffled_values: Array = values.duplicate(true)
	var last_index: int = shuffled_values.size() - 1

	while last_index > 0:
		var swap_index: int = randi_range_stream(stream_id, 0, last_index)
		var temp_value: Variant = shuffled_values[last_index]
		shuffled_values[last_index] = shuffled_values[swap_index]
		shuffled_values[swap_index] = temp_value
		last_index -= 1

	return shuffled_values

func get_rng_state_snapshot() -> Dictionary:
	var snapshot: Dictionary = {}

	for stream_id: String in _rng_streams.keys():
		var stream_record: Dictionary = _rng_streams.get(stream_id, {})
		var rng: RandomNumberGenerator = stream_record.get("rng")
		if rng == null:
			continue

		snapshot[stream_id] = {
			"initial_seed": int(stream_record.get("initial_seed", 0)),
			"draw_count": int(stream_record.get("draw_count", 0)),
			"state": int(rng.state),
		}

	return snapshot

func get_calendar_snapshot() -> Dictionary:
	return {
		"tick_index": tick_index,
		"day_index": day_index,
		"year_index": year_index,
		"season_id": season_id,
		"part_of_day_id": part_of_day_id,
		"season_profile_id": season_profile_id,
		"ticks_per_part_of_day": ticks_per_part_of_day,
		"tick_progress_within_part": _tick_progress_within_part,
		"is_paused": is_paused,
		"speed_index": speed_index,
		"speed_multiplier": get_speed_multiplier(),
		"active_phase_id": active_phase_id,
		"last_completed_phase_id": last_completed_phase_id,
		"base_ticks_per_second": base_ticks_per_second,
		"effective_ticks_per_second": base_ticks_per_second * float(get_speed_multiplier()),
		"scenario_seed": scenario_seed,
		"phase_listener_count_total": get_phase_listener_count_total(),
		"phase_listener_counts_by_phase": get_phase_listener_counts_by_phase(),
		"rng_stream_count": _rng_streams.size(),
		"debug_visible_phase_id": debug_visible_phase_id,
		"debug_visible_phase_tick_index": debug_visible_phase_tick_index,
		"debug_visible_phase_transition_serial": debug_visible_phase_transition_serial,
		"debug_last_completed_tick_index": debug_last_completed_tick_index,
		"debug_last_tick_total_duration_usec": debug_last_tick_total_duration_usec,
		"debug_last_phase_duration_usec_by_phase": debug_last_phase_duration_usec_by_phase.duplicate(true),
		"debug_recent_phase_entries": debug_recent_phase_entries.duplicate(),
		"scheduled_trigger_count": get_scheduled_trigger_count(),
		"next_scheduled_trigger_tick": get_next_scheduled_trigger_tick(),
		"scheduled_trigger_queue_preview": get_scheduled_trigger_queue_preview(),
		"debug_last_resolved_trigger_id": debug_last_resolved_trigger_id,
		"debug_last_resolved_trigger_type_id": debug_last_resolved_trigger_type_id,
		"debug_last_resolved_trigger_tick": debug_last_resolved_trigger_tick,
		"debug_resolved_trigger_count_total": debug_resolved_trigger_count_total,
		"debug_recent_resolved_trigger_entries": debug_recent_resolved_trigger_entries.duplicate(),
		"queued_command_count": get_queued_command_count(),
		"queued_command_queue_preview": get_queued_command_queue_preview(),
		"debug_last_processed_command_id": debug_last_processed_command_id,
		"debug_last_processed_command_type_id": debug_last_processed_command_type_id,
		"debug_last_processed_command_tick": debug_last_processed_command_tick,
		"debug_processed_command_count_total": debug_processed_command_count_total,
		"debug_recent_processed_command_entries": debug_recent_processed_command_entries.duplicate(),
		"debug_determinism_signature": debug_determinism_signature,
		"debug_determinism_event_count": debug_determinism_event_count,
		"debug_determinism_last_event": debug_determinism_last_event,
	}
	
func _run_one_tick() -> void:
	var tick_start_usec: int = Time.get_ticks_usec()
	sim_tick_started.emit(tick_index)

	for phase_id: String in SimPhaseIds.ORDERED_PHASE_IDS:
		active_phase_id = phase_id
		sim_phase_started.emit(tick_index, phase_id)

		_record_phase_entry_for_debug(phase_id)

		var phase_context: Dictionary = _build_phase_context(phase_id)
		var phase_start_usec: int = Time.get_ticks_usec()

		_run_internal_phase_logic(phase_id, phase_context)
		_dispatch_phase_listeners(phase_id, phase_context)

		var phase_duration_usec: int = Time.get_ticks_usec() - phase_start_usec
		debug_last_phase_duration_usec_by_phase[phase_id] = phase_duration_usec

		last_completed_phase_id = phase_id

	tick_index += 1
	active_phase_id = ""
	debug_last_completed_tick_index = tick_index - 1
	debug_last_tick_total_duration_usec = Time.get_ticks_usec() - tick_start_usec

	_advance_calendar_after_tick()

	var snapshot: Dictionary = get_calendar_snapshot()
	sim_tick_completed.emit(snapshot)
	_log_run_loop_event("tick_completed", snapshot)

func _run_internal_phase_logic(phase_id: String, phase_context: Dictionary) -> void:
	match phase_id:
		SimPhaseIds.PHASE_COMMAND_INTAKE:
			_run_command_intake_phase(phase_context)
		SimPhaseIds.PHASE_TIME_STEP_START:
			_run_time_step_start_phase(phase_context)
		SimPhaseIds.PHASE_WORLD_PRE_UPDATE:
			_run_world_pre_update_phase(phase_context)
		SimPhaseIds.PHASE_SIMULATION_UPDATE:
			_run_simulation_update_phase(phase_context)
		SimPhaseIds.PHASE_VISIBILITY_REFRESH:
			_run_visibility_refresh_phase(phase_context)
		SimPhaseIds.PHASE_DEBUG_SNAPSHOT:
			_run_debug_snapshot_phase(phase_context)
		SimPhaseIds.PHASE_END_OF_TICK_BOOKKEEPING:
			_run_end_of_tick_bookkeeping_phase(phase_context)

func _run_command_intake_phase(phase_context: Dictionary) -> void:
	# Only process the commands that existed when this phase began.
	# Commands enqueued later in the same tick wait until the next tick.
	if _queued_command_records.is_empty():
		return

	var queued_commands_to_process: Array = _queued_command_records.duplicate()
	_queued_command_records.clear()

	for record_variant: Variant in queued_commands_to_process:
		var record: SimCommandRecord = record_variant as SimCommandRecord
		if record == null:
			continue

		_apply_command_record(record, phase_context)

func _run_time_step_start_phase(phase_context: Dictionary) -> void:
	# Branch 02 uses this as the current deterministic place to resolve
	# due scheduled time triggers before later systems read time state.
	_resolve_due_scheduled_triggers(phase_context)

func _run_world_pre_update_phase(_phase_context: Dictionary) -> void:
	# Reserved for future world-side passive updates.
	pass

func _run_simulation_update_phase(_phase_context: Dictionary) -> void:
	# Branch 02 still stops short of full gameplay/system runtime.
	pass

func _run_visibility_refresh_phase(_phase_context: Dictionary) -> void:
	# Reserved for future map/fog/debug overlay binding.
	pass

func _run_debug_snapshot_phase(phase_context: Dictionary) -> void:
	# Stable debug visibility boundary for telemetry and HUD surfaces.
	_log_run_loop_event("debug_snapshot", phase_context)

func _run_end_of_tick_bookkeeping_phase(_phase_context: Dictionary) -> void:
	# Keep this explicit for later end-of-tick / save-safe boundaries.
	pass

func _advance_calendar_after_tick() -> void:
	_tick_progress_within_part += 1

	if _tick_progress_within_part < ticks_per_part_of_day:
		return

	_tick_progress_within_part = 0

	var previous_part_of_day_id: String = part_of_day_id
	var current_part_index: int = _part_of_day_ids.find(part_of_day_id)
	if current_part_index < 0:
		current_part_index = 0

	var next_part_index: int = current_part_index + 1
	var wrapped_day: bool = false

	if next_part_index >= _part_of_day_ids.size():
		next_part_index = 0
		wrapped_day = true

	part_of_day_id = str(_part_of_day_ids[next_part_index])

	_append_determinism_event("calendar.part:t%s:%s->%s" % [
		tick_index,
		previous_part_of_day_id,
		part_of_day_id,
	])

	if wrapped_day:
		day_index += 1
		_append_determinism_event("calendar.day:t%s:%s" % [tick_index, day_index])

	# Still intentionally no season auto-advance here.
	# The canonical current data does not define season length yet.

func _build_phase_context(phase_id: String) -> Dictionary:
	return {
		"tick_index": tick_index,
		"phase_id": phase_id,
		"phase_index": SimPhaseIds.get_phase_index(phase_id),
		"scenario_seed": scenario_seed,
		"day_index": day_index,
		"year_index": year_index,
		"season_id": season_id,
		"part_of_day_id": part_of_day_id,
		"season_profile_id": season_profile_id,
		"ticks_per_part_of_day": ticks_per_part_of_day,
		"tick_progress_within_part": _tick_progress_within_part,
		"is_paused": is_paused,
		"speed_multiplier": get_speed_multiplier(),
	}

func _dispatch_phase_listeners(phase_id: String, phase_context: Dictionary) -> void:
	_prune_stale_phase_listeners(phase_id)

	var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
	listener_records.sort_custom(_sort_listener_records)

	for listener_record: Dictionary in listener_records:
		var owner_ref: WeakRef = listener_record.get("owner_ref")
		var owner: Object = owner_ref.get_ref()
		if owner == null:
			continue

		var callback_method: String = str(listener_record.get("callback_method", ""))
		if callback_method.is_empty():
			continue

		if not owner.has_method(callback_method):
			push_warning(
				"TimeService: phase listener method disappeared for phase '%s': %s" %
				[phase_id, callback_method]
			)
			continue

		owner.call(callback_method, phase_context)

func _sort_listener_records(left_record: Dictionary, right_record: Dictionary) -> bool:
	var left_priority: int = int(left_record.get("priority", DEFAULT_PHASE_LISTENER_PRIORITY))
	var right_priority: int = int(right_record.get("priority", DEFAULT_PHASE_LISTENER_PRIORITY))

	if left_priority != right_priority:
		return left_priority < right_priority

	var left_registration_id: int = int(left_record.get("registration_id", 0))
	var right_registration_id: int = int(right_record.get("registration_id", 0))
	return left_registration_id < right_registration_id

func _prune_stale_phase_listeners(phase_id: String) -> void:
	if not _phase_listener_records_by_phase.has(phase_id):
		return

	var listener_records: Array = _phase_listener_records_by_phase.get(phase_id, [])
	var filtered_listener_records: Array = []

	for listener_record: Dictionary in listener_records:
		var owner_ref: WeakRef = listener_record.get("owner_ref")
		var owner: Object = owner_ref.get_ref()
		if owner != null:
			filtered_listener_records.append(listener_record)

	_phase_listener_records_by_phase[phase_id] = filtered_listener_records

func _initialize_phase_listener_registry() -> void:
	_phase_listener_records_by_phase.clear()

	for phase_id: String in SimPhaseIds.ORDERED_PHASE_IDS:
		_phase_listener_records_by_phase[phase_id] = []

func _initialize_debug_phase_metrics() -> void:
	debug_visible_phase_id = ""
	debug_visible_phase_tick_index = DEFAULT_TICK_INDEX
	debug_visible_phase_transition_serial = 0
	debug_last_completed_tick_index = DEFAULT_TICK_INDEX
	debug_last_tick_total_duration_usec = 0
	debug_last_phase_duration_usec_by_phase.clear()
	debug_recent_phase_entries.clear()

	for phase_id: String in SimPhaseIds.ORDERED_PHASE_IDS:
		debug_last_phase_duration_usec_by_phase[phase_id] = 0

func _initialize_debug_trigger_metrics() -> void:
	debug_last_resolved_trigger_id = ""
	debug_last_resolved_trigger_type_id = ""
	debug_last_resolved_trigger_tick = -1
	debug_resolved_trigger_count_total = 0
	debug_recent_resolved_trigger_entries.clear()
	
func _initialize_debug_determinism_metrics() -> void:
	debug_determinism_signature = DEBUG_DETERMINISM_HASH_SEED
	debug_determinism_event_count = 0
	debug_determinism_last_event = ""

func _record_bootstrap_determinism_inputs() -> void:
	_append_determinism_event("bootstrap.seed:%s" % scenario_seed)
	_append_determinism_event("bootstrap.season_profile:%s" % season_profile_id)
	_append_determinism_event("bootstrap.season:%s" % season_id)
	_append_determinism_event("bootstrap.part_of_day:%s" % part_of_day_id)
	_append_determinism_event("bootstrap.ticks_per_part:%s" % ticks_per_part_of_day)

	for supported_part_of_day_id: String in _part_of_day_ids:
		_append_determinism_event("bootstrap.part_token:%s" % supported_part_of_day_id)

	for supported_season_id: String in _supported_season_ids:
		_append_determinism_event("bootstrap.season_token:%s" % supported_season_id)

func _append_determinism_event(event_text: String) -> void:
	var trimmed_event_text: String = event_text.strip_edges()
	if trimmed_event_text.is_empty():
		return

	debug_determinism_last_event = trimmed_event_text
	debug_determinism_event_count += 1

	var event_bytes: PackedByteArray = trimmed_event_text.to_utf8_buffer()

	for event_byte: int in event_bytes:
		debug_determinism_signature = int((debug_determinism_signature ^ event_byte) & 0x7fffffff)
		debug_determinism_signature = int((debug_determinism_signature * DEBUG_DETERMINISM_HASH_MULTIPLIER) & 0x7fffffff)

	# Add a stable separator so adjacent events do not blur together.
	debug_determinism_signature = int((debug_determinism_signature ^ 31) & 0x7fffffff)
	debug_determinism_signature = int((debug_determinism_signature * DEBUG_DETERMINISM_HASH_MULTIPLIER) & 0x7fffffff)

func _record_phase_entry_for_debug(phase_id: String) -> void:
	debug_visible_phase_id = phase_id
	debug_visible_phase_tick_index = tick_index
	debug_visible_phase_transition_serial += 1

	var short_entry: String = "t%s:%s" % [tick_index, phase_id]
	debug_recent_phase_entries.append(short_entry)

	while debug_recent_phase_entries.size() > DEBUG_RECENT_PHASE_ENTRY_LIMIT:
		debug_recent_phase_entries.pop_front()

	_append_determinism_event("phase:t%s:%s" % [tick_index, phase_id])

func _resolve_due_scheduled_triggers(phase_context: Dictionary) -> void:
	_scheduled_trigger_records.sort_custom(_sort_scheduled_trigger_records)

	while not _scheduled_trigger_records.is_empty():
		var first_record: ScheduledTriggerRecord = _scheduled_trigger_records[0] as ScheduledTriggerRecord
		if first_record == null:
			_scheduled_trigger_records.pop_front()
			continue

		if first_record.scheduled_tick > tick_index:
			break

		_scheduled_trigger_records.pop_front()
		_apply_resolved_trigger_record(first_record, phase_context)

func _apply_resolved_trigger_record(record: ScheduledTriggerRecord, phase_context: Dictionary) -> void:
	debug_last_resolved_trigger_id = record.trigger_id
	debug_last_resolved_trigger_type_id = record.trigger_type_id
	debug_last_resolved_trigger_tick = tick_index
	debug_resolved_trigger_count_total += 1

	var resolved_summary: String = "t%s:%s" % [
		tick_index,
		record.debug_label if not record.debug_label.strip_edges().is_empty() else record.trigger_type_id,
	]
	debug_recent_resolved_trigger_entries.append(resolved_summary)

	while debug_recent_resolved_trigger_entries.size() > DEBUG_RECENT_TRIGGER_ENTRY_LIMIT:
		debug_recent_resolved_trigger_entries.pop_front()

	var trigger_snapshot: Dictionary = record.to_snapshot()

	_log_run_loop_event("trigger_resolved", {
		"resolved_tick": tick_index,
		"phase_id": str(phase_context.get("phase_id", "")),
		"trigger": trigger_snapshot,
	})

	_append_determinism_event("trigger:t%s:%s:%s" % [
		tick_index,
		record.trigger_id,
		record.trigger_type_id,
	])

	# Public signal so other systems can react without owning queue internals.
	scheduled_trigger_resolved.emit(trigger_snapshot, phase_context)

	match record.trigger_type_id:
		INTERNAL_TRIGGER_TYPE_DAY_START:
			_handle_internal_day_start_trigger(record)
		_:
			# Other trigger types will be added by later branches/systems.
			pass

func _handle_internal_day_start_trigger(record: ScheduledTriggerRecord) -> void:
	# This is a tiny non-gameplay proof that the queue works deterministically.
	# It tracks day-start boundaries and immediately schedules the next one.
	_schedule_internal_next_day_start_trigger()

	_log_run_loop_event("internal_day_start_trigger_handled", {
		"trigger_id": record.trigger_id,
		"resolved_tick": tick_index,
		"day_index": day_index,
		"part_of_day_id": part_of_day_id,
	})

func _schedule_internal_next_day_start_trigger() -> void:
	var current_part_index: int = _part_of_day_ids.find(part_of_day_id)
	if current_part_index < 0:
		current_part_index = 0

	var remaining_ticks_in_current_part: int = ticks_per_part_of_day - _tick_progress_within_part
	var remaining_full_parts_after_current: int = (_part_of_day_ids.size() - 1) - current_part_index
	var ticks_until_next_day_start: int = remaining_ticks_in_current_part + (remaining_full_parts_after_current * ticks_per_part_of_day)
	var resolved_scheduled_tick: int = tick_index + maxi(ticks_until_next_day_start, 1)
	var target_day_index: int = day_index + 1

	schedule_trigger_at_tick(
		INTERNAL_TRIGGER_ID_NEXT_DAY_START,
		INTERNAL_TRIGGER_TYPE_DAY_START,
		resolved_scheduled_tick,
		{
			"target_day_index": target_day_index,
		},
		"day_start:%s" % target_day_index,
		SimPhaseIds.PHASE_END_OF_TICK_BOOKKEEPING
	)

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

func _remove_scheduled_trigger_by_id(trigger_id: String) -> void:
	var filtered_records: Array = []

	for record_variant: Variant in _scheduled_trigger_records:
		var record: ScheduledTriggerRecord = record_variant as ScheduledTriggerRecord
		if record == null:
			continue

		if record.trigger_id != trigger_id:
			filtered_records.append(record)

	_scheduled_trigger_records = filtered_records

func _clear_scheduled_triggers() -> void:
	_scheduled_trigger_records.clear()
	_next_scheduled_trigger_serial = 1

func _require_rng_stream(stream_id: String) -> RandomNumberGenerator:
	var trimmed_stream_id: String = stream_id.strip_edges()
	if trimmed_stream_id.is_empty():
		push_error("TimeService: RNG stream_id must not be empty.")
		return null

	ensure_rng_stream(trimmed_stream_id)

	var stream_record: Dictionary = _rng_streams.get(trimmed_stream_id, {})
	var rng: RandomNumberGenerator = stream_record.get("rng")
	if rng == null:
		push_error("TimeService: failed to resolve RNG stream '%s'." % trimmed_stream_id)

	return rng

func _increment_rng_stream_draw_count(stream_id: String) -> void:
	if not _rng_streams.has(stream_id):
		return

	var stream_record: Dictionary = _rng_streams.get(stream_id, {})
	var draw_count: int = int(stream_record.get("draw_count", 0))
	stream_record["draw_count"] = draw_count + 1
	_rng_streams[stream_id] = stream_record

func _reset_rng_streams() -> void:
	_rng_streams.clear()

func _refresh_run_seed_from_sim_root() -> void:
	var sim_root: Node = get_node_or_null("/root/SimRoot")
	if sim_root == null:
		return

	if not sim_root.has_method("get_boot_context"):
		return

	var boot_context: Dictionary = sim_root.call("get_boot_context")
	var resolved_seed: int = int(boot_context.get("seed", DEFAULT_SCENARIO_SEED))
	if scenario_seed == resolved_seed:
		return

	scenario_seed = resolved_seed
	_reset_rng_streams()

	_log_run_loop_event("scenario_seed_changed", {
		"scenario_seed": scenario_seed,
	})

func _build_stream_seed(root_seed: int, stream_id: String) -> int:
	var stream_hash: int = 2166136261
	var stream_bytes: PackedByteArray = stream_id.to_utf8_buffer()

	for stream_byte: int in stream_bytes:
		stream_hash = int((stream_hash ^ stream_byte) & 0x7fffffff)
		stream_hash = int((stream_hash * 16777619) & 0x7fffffff)

	var mixed_seed: int = int((root_seed ^ stream_hash) & 0x7fffffff)
	if mixed_seed == 0:
		mixed_seed = 1

	return mixed_seed

func _validate_calendar_tokens() -> void:
	if not CalendarIds.is_valid_season_id(season_id):
		push_error("TimeService: invalid season_id '%s'." % season_id)

	if not CalendarIds.is_valid_part_of_day_id(part_of_day_id):
		push_error("TimeService: invalid part_of_day_id '%s'." % part_of_day_id)

	for supported_season_id: String in _supported_season_ids:
		if not CalendarIds.is_valid_season_id(supported_season_id):
			push_error("TimeService: invalid supported season token '%s'." % supported_season_id)

	for supported_part_of_day_id: String in _part_of_day_ids:
		if not CalendarIds.is_valid_part_of_day_id(supported_part_of_day_id):
			push_error("TimeService: invalid part_of_day token '%s'." % supported_part_of_day_id)

	if ticks_per_part_of_day < 1:
		push_error("TimeService: ticks_per_part_of_day must be >= 1.")

func _log_run_loop_event(event_id: String, payload: Dictionary) -> void:
	var telemetry_service: Node = get_node_or_null("/root/TelemetryService")
	if telemetry_service != null and telemetry_service.has_method("log"):
		telemetry_service.call("log", "time", event_id, payload)
		
func _initialize_debug_command_metrics() -> void:
	debug_last_processed_command_id = ""
	debug_last_processed_command_type_id = ""
	debug_last_processed_command_tick = -1
	debug_processed_command_count_total = 0
	debug_recent_processed_command_entries.clear()

func _apply_command_record(record: SimCommandRecord, phase_context: Dictionary) -> void:
	debug_last_processed_command_id = record.command_id
	debug_last_processed_command_type_id = record.command_type_id
	debug_last_processed_command_tick = tick_index
	debug_processed_command_count_total += 1

	var processed_summary: String = "t%s:%s" % [
		tick_index,
		record.debug_label if not record.debug_label.strip_edges().is_empty() else record.command_type_id,
	]
	debug_recent_processed_command_entries.append(processed_summary)

	while debug_recent_processed_command_entries.size() > DEBUG_RECENT_COMMAND_ENTRY_LIMIT:
		debug_recent_processed_command_entries.pop_front()

	var command_snapshot: Dictionary = record.to_snapshot()

	_log_run_loop_event("command_processed", {
		"processed_tick": tick_index,
		"phase_id": str(phase_context.get("phase_id", "")),
		"command": command_snapshot,
	})

	_append_determinism_event("command:t%s:%s:%s" % [
		tick_index,
		record.command_id,
		record.command_type_id,
	])

	queued_command_processed.emit(command_snapshot, phase_context)

func _clear_queued_commands() -> void:
	_queued_command_records.clear()
	_next_command_enqueue_serial = 1

func _build_command_id(enqueue_serial: int) -> String:
	return "command.%010d" % enqueue_serial
