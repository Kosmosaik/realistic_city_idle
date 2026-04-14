extends Node
class_name DebugScheduledTriggerProbe

# Dev-only external consumer for Branch 02.
# This proves the scheduled-trigger API is reusable outside TimeService.
# It also proves that external systems can enqueue commands for the next tick.

const PROBE_TRIGGER_ID: String = "debug.external_probe.heartbeat"
const PROBE_TRIGGER_TYPE_ID: String = "trigger.debug.external_probe_heartbeat"
const PROBE_SOURCE_PHASE_ID: String = "debug.external_probe"
const PROBE_COMMAND_TYPE_ID: String = "command.debug.external_probe_ping"
const PROBE_INTERVAL_TICKS: int = 6

var resolved_fire_count: int = 0
var issued_command_count: int = 0
var last_resolved_tick: int = -1
var last_resolved_phase_id: String = ""
var is_probe_connected: bool = false

func _ready() -> void:
	var time_service: Node = _time_service()
	if time_service == null:
		push_error("DebugScheduledTriggerProbe: TimeService autoload is missing.")
		return

	var resolved_callable: Callable = Callable(self, "_on_scheduled_trigger_resolved")
	if not time_service.scheduled_trigger_resolved.is_connected(resolved_callable):
		time_service.scheduled_trigger_resolved.connect(resolved_callable)

	is_probe_connected = true
	_schedule_next_probe_trigger()

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "debug_probe", "external_probe_ready", {
			"trigger_id": PROBE_TRIGGER_ID,
			"trigger_type_id": PROBE_TRIGGER_TYPE_ID,
			"command_type_id": PROBE_COMMAND_TYPE_ID,
			"interval_ticks": PROBE_INTERVAL_TICKS,
		})

func _exit_tree() -> void:
	var time_service: Node = _time_service()
	if time_service == null:
		return

	var resolved_callable: Callable = Callable(self, "_on_scheduled_trigger_resolved")
	if time_service.scheduled_trigger_resolved.is_connected(resolved_callable):
		time_service.scheduled_trigger_resolved.disconnect(resolved_callable)

	is_probe_connected = false

func get_debug_snapshot() -> Dictionary:
	return {
		"resolved_fire_count": resolved_fire_count,
		"issued_command_count": issued_command_count,
		"last_resolved_tick": last_resolved_tick,
		"last_resolved_phase_id": last_resolved_phase_id,
		"is_probe_connected": is_probe_connected,
		"probe_trigger_id": PROBE_TRIGGER_ID,
		"probe_trigger_type_id": PROBE_TRIGGER_TYPE_ID,
		"probe_command_type_id": PROBE_COMMAND_TYPE_ID,
		"probe_interval_ticks": PROBE_INTERVAL_TICKS,
	}

func _schedule_next_probe_trigger() -> void:
	var time_service: Node = _time_service()
	if time_service == null:
		return

	var next_fire_index: int = resolved_fire_count + 1
	var scheduled_ok: bool = bool(time_service.call(
		"schedule_trigger_in_ticks",
		PROBE_TRIGGER_ID,
		PROBE_TRIGGER_TYPE_ID,
		PROBE_INTERVAL_TICKS,
		{
			"expected_fire_index": next_fire_index,
		},
		"external_probe:%s" % next_fire_index,
		PROBE_SOURCE_PHASE_ID
	))

	if not scheduled_ok:
		push_error("DebugScheduledTriggerProbe: failed to schedule next probe trigger.")

func _enqueue_probe_command() -> void:
	var time_service: Node = _time_service()
	if time_service == null:
		return

	issued_command_count += 1

	var command_id: String = str(time_service.call(
		"enqueue_command",
		PROBE_COMMAND_TYPE_ID,
		{
			"resolved_fire_count": resolved_fire_count,
			"issued_command_count": issued_command_count,
		},
		PROBE_SOURCE_PHASE_ID,
		"probe_ping:%s" % issued_command_count
	))

	if command_id.is_empty():
		push_error("DebugScheduledTriggerProbe: failed to enqueue probe command.")

func _on_scheduled_trigger_resolved(trigger_snapshot: Dictionary, phase_context: Dictionary) -> void:
	var trigger_id: String = str(trigger_snapshot.get("trigger_id", ""))
	if trigger_id != PROBE_TRIGGER_ID:
		return

	resolved_fire_count += 1
	last_resolved_tick = int(phase_context.get("tick_index", -1))
	last_resolved_phase_id = str(phase_context.get("phase_id", ""))

	var telemetry_service: Node = _telemetry_service()
	if telemetry_service != null:
		telemetry_service.call("log", "debug_probe", "external_probe_trigger_resolved", {
			"resolved_fire_count": resolved_fire_count,
			"resolved_tick": last_resolved_tick,
			"resolved_phase_id": last_resolved_phase_id,
			"trigger_snapshot": trigger_snapshot,
		})

	# This enqueues a command after command-intake has already passed for this tick.
	# The command will therefore be processed on the next tick, which is what we want.
	_enqueue_probe_command()
	_schedule_next_probe_trigger()

func _time_service() -> Node:
	return get_node_or_null("/root/TimeService")

func _telemetry_service() -> Node:
	return get_node_or_null("/root/TelemetryService")
