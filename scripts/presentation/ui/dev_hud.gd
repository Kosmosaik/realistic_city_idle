extends CanvasLayer
class_name DevHud

const TOGGLE_KEY: Key = KEY_F3
const DEFAULT_PROJECT_NAME: String = "Realistic City Idle"
const DEFAULT_BUILD_VERSION: String = "0.0.0-dev"
const PANEL_WIDTH: float = 660.0
const PANEL_OUTER_MARGIN: float = 8.0
const PANEL_INNER_MARGIN: float = 6.0
const PANEL_MIN_HEIGHT: float = 220.0

var _panel_root: Control
var _scroll_container: ScrollContainer
var _label: Label

func _ready() -> void:
	layer = 10
	_build_ui()
	_update_panel_layout()
	_refresh_text()

func _process(_delta: float) -> void:
	_update_panel_layout()

	if _panel_root != null and _panel_root.visible:
		_refresh_text()

func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey):
		return

	var key_event: InputEventKey = event as InputEventKey
	if key_event == null:
		return

	if key_event.pressed and not key_event.echo and key_event.physical_keycode == TOGGLE_KEY:
		_toggle_panel()
		get_viewport().set_input_as_handled()

func _build_ui() -> void:
	var outer_margin: MarginContainer = MarginContainer.new()
	outer_margin.set_anchors_preset(Control.PRESET_TOP_LEFT)
	outer_margin.offset_left = PANEL_OUTER_MARGIN
	outer_margin.offset_top = PANEL_OUTER_MARGIN
	outer_margin.mouse_filter = Control.MOUSE_FILTER_PASS
	add_child(outer_margin)
	_panel_root = outer_margin

	var panel: PanelContainer = PanelContainer.new()
	panel.custom_minimum_size = Vector2(PANEL_WIDTH, 0.0)
	panel.mouse_filter = Control.MOUSE_FILTER_PASS
	outer_margin.add_child(panel)

	var scroll_container: ScrollContainer = ScrollContainer.new()
	scroll_container.mouse_filter = Control.MOUSE_FILTER_STOP
	scroll_container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll_container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	scroll_container.custom_minimum_size = Vector2(PANEL_WIDTH - (PANEL_INNER_MARGIN * 2.0), PANEL_MIN_HEIGHT)
	panel.add_child(scroll_container)
	_scroll_container = scroll_container

	var inner_margin: MarginContainer = MarginContainer.new()
	inner_margin.add_theme_constant_override("margin_left", int(PANEL_INNER_MARGIN))
	inner_margin.add_theme_constant_override("margin_top", 5)
	inner_margin.add_theme_constant_override("margin_right", int(PANEL_INNER_MARGIN))
	inner_margin.add_theme_constant_override("margin_bottom", 5)
	inner_margin.mouse_filter = Control.MOUSE_FILTER_PASS
	scroll_container.add_child(inner_margin)

	_label = Label.new()
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	_label.add_theme_font_size_override("font_size", 11)
	_label.text = ""
	inner_margin.add_child(_label)

func _update_panel_layout() -> void:
	if _scroll_container == null:
		return

	var visible_rect: Rect2 = get_viewport().get_visible_rect()
	var max_panel_height: float = maxf(PANEL_MIN_HEIGHT, visible_rect.size.y - (PANEL_OUTER_MARGIN * 2.0))
	_scroll_container.custom_minimum_size = Vector2(
		PANEL_WIDTH - (PANEL_INNER_MARGIN * 2.0),
		max_panel_height
	)

func _toggle_panel() -> void:
	if _panel_root == null:
		return

	_panel_root.visible = not _panel_root.visible

func _refresh_text() -> void:
	if _label == null:
		return

	var build_info: Dictionary = _get_build_info()
	var boot_context: Dictionary = _get_boot_context()
	var calendar: Dictionary = boot_context.get("calendar", {})
	var definition_report: Dictionary = _get_definition_report()

	var recent_phase_entries: Array = calendar.get("debug_recent_phase_entries", [])
	var phase_duration_map: Dictionary = calendar.get("debug_last_phase_duration_usec_by_phase", {})
	var recent_trigger_entries: Array = calendar.get("debug_recent_resolved_trigger_entries", [])
	var trigger_queue_preview: Array = calendar.get("scheduled_trigger_queue_preview", [])
	var recent_command_entries: Array = calendar.get("debug_recent_processed_command_entries", [])
	var command_queue_preview: Array = calendar.get("queued_command_queue_preview", [])

	var definition_status: String = "OK" if bool(definition_report.get("is_valid", false)) else "INVALID"
	var pause_text: String = "Paused" if bool(calendar.get("is_paused", true)) else "Running"
	var recent_phase_text: String = _build_recent_phase_text(recent_phase_entries)
	var phase_duration_text: String = _build_phase_duration_text(phase_duration_map)
	var recent_trigger_text: String = _build_recent_trigger_text(recent_trigger_entries)
	var trigger_queue_preview_text: String = _build_trigger_queue_preview_text(trigger_queue_preview)
	var recent_command_text: String = _build_recent_command_text(recent_command_entries)
	var command_queue_preview_text: String = _build_command_queue_preview_text(command_queue_preview)
	var determinism_signature_text: String = _build_hex_signature_text(int(calendar.get("debug_determinism_signature", 0)))

	_label.text = "\n".join([
		"RCI — Branch 02",
		"Build: %s" % build_info.get("build_version", DEFAULT_BUILD_VERSION),
		"Engine: %s" % build_info.get("engine_version", "n/a"),
		"Scene: %s" % build_info.get("current_scene_path", "n/a"),
		"",
		"Scenario: %s" % boot_context.get("scenario_id", "n/a"),
		"Stage: %s" % boot_context.get("stage_id", "n/a"),
		"Map Preset: %s" % boot_context.get("map_preset_id", "n/a"),
		"Worldgen: %s" % boot_context.get("worldgen_profile_id", "n/a"),
		"Season Profile: %s" % boot_context.get("season_profile_id", "n/a"),
		"Seed: %s" % str(boot_context.get("seed", 0)),
		"",
		"Run State: %s" % pause_text,
		"Tick: %s" % str(calendar.get("tick_index", 0)),
		"Year: %s" % str(calendar.get("year_index", 0)),
		"Day: %s" % str(calendar.get("day_index", 1)),
		"Season: %s" % str(calendar.get("season_id", "n/a")),
		"Part: %s" % str(calendar.get("part_of_day_id", "n/a")),
		"Tick In Part: %s / %s" % [
			str(int(calendar.get("tick_progress_within_part", 0)) + 1),
			str(calendar.get("ticks_per_part_of_day", 1)),
		],
		"",
		"Live Active Phase: %s" % _display_or_dash(str(calendar.get("active_phase_id", ""))),
		"Visible Phase: %s" % _display_or_dash(str(calendar.get("debug_visible_phase_id", ""))),
		"Visible Phase Tick: %s" % str(calendar.get("debug_visible_phase_tick_index", 0)),
		"Phase Transition #: %s" % str(calendar.get("debug_visible_phase_transition_serial", 0)),
		"Last Completed Phase: %s" % _display_or_dash(str(calendar.get("last_completed_phase_id", ""))),
		"Last Completed Tick: %s" % str(calendar.get("debug_last_completed_tick_index", 0)),
		"Last Tick Duration: %s us" % str(calendar.get("debug_last_tick_total_duration_usec", 0)),
		"Recent Phases: %s" % recent_phase_text,
		"Phase Durations: %s" % phase_duration_text,
		"",
		"Scheduled Triggers: %s" % str(calendar.get("scheduled_trigger_count", 0)),
		"Next Trigger Tick: %s" % _display_int_or_dash(int(calendar.get("next_scheduled_trigger_tick", -1))),
		"Last Resolved Trigger ID: %s" % _display_or_dash(str(calendar.get("debug_last_resolved_trigger_id", ""))),
		"Last Resolved Trigger Type: %s" % _display_or_dash(str(calendar.get("debug_last_resolved_trigger_type_id", ""))),
		"Last Resolved Trigger Tick: %s" % _display_int_or_dash(int(calendar.get("debug_last_resolved_trigger_tick", -1))),
		"Resolved Trigger Count: %s" % str(calendar.get("debug_resolved_trigger_count_total", 0)),
		"Recent Resolved Triggers: %s" % recent_trigger_text,
		"Trigger Queue Preview: %s" % trigger_queue_preview_text,
		"",
		"Queued Commands: %s" % str(calendar.get("queued_command_count", 0)),
		"Last Processed Command ID: %s" % _display_or_dash(str(calendar.get("debug_last_processed_command_id", ""))),
		"Last Processed Command Type: %s" % _display_or_dash(str(calendar.get("debug_last_processed_command_type_id", ""))),
		"Last Processed Command Tick: %s" % _display_int_or_dash(int(calendar.get("debug_last_processed_command_tick", -1))),
		"Processed Command Count: %s" % str(calendar.get("debug_processed_command_count_total", 0)),
		"Recent Processed Commands: %s" % recent_command_text,
		"Command Queue Preview: %s" % command_queue_preview_text,
		"",
		"Determinism Events: %s" % str(calendar.get("debug_determinism_event_count", 0)),
		"Determinism Signature: %s" % determinism_signature_text,
		"Determinism Last Event: %s" % _display_or_dash(str(calendar.get("debug_determinism_last_event", ""))),
		"",
		"Speed: x%s" % str(calendar.get("speed_multiplier", 1)),
		"Base TPS: %s" % str(calendar.get("base_ticks_per_second", 0.0)),
		"Effective TPS: %s" % str(calendar.get("effective_ticks_per_second", 0.0)),
		"",
		"Phase Listeners: %s" % str(calendar.get("phase_listener_count_total", 0)),
		"RNG Streams: %s" % str(calendar.get("rng_stream_count", 0)),
		"Run Seed: %s" % str(calendar.get("scenario_seed", 0)),
		"",
		"Defs: %s loaded" % str(definition_report.get("loaded_count_total", 0)),
		"Def Status: %s" % definition_status,
		"Def Warnings: %s" % str(definition_report.get("warning_count", 0)),
		"Def Errors: %s" % str(definition_report.get("error_count", 0)),
		"",
		"F3: toggle HUD",
		"Mouse wheel: scroll HUD",
		"Space: pause/resume",
		". : single-step",
		"[ / ] : speed down/up",
	])

func _build_recent_phase_text(recent_phase_entries: Array) -> String:
	if recent_phase_entries.is_empty():
		return "-"

	var entry_strings: Array[String] = []
	for entry: Variant in recent_phase_entries:
		entry_strings.append(str(entry))

	return " | ".join(entry_strings)

func _build_phase_duration_text(phase_duration_map: Dictionary) -> String:
	if phase_duration_map.is_empty():
		return "-"

	var ordered_phase_ids: Array[String] = SimPhaseIds.get_all_phase_ids()
	var parts: Array[String] = []

	for phase_id: String in ordered_phase_ids:
		var duration_usec: int = int(phase_duration_map.get(phase_id, 0))
		parts.append("%s=%sus" % [phase_id, duration_usec])

	return ", ".join(parts)

func _build_recent_trigger_text(recent_trigger_entries: Array) -> String:
	if recent_trigger_entries.is_empty():
		return "-"

	var entry_strings: Array[String] = []
	for entry: Variant in recent_trigger_entries:
		entry_strings.append(str(entry))

	return " | ".join(entry_strings)

func _build_trigger_queue_preview_text(trigger_queue_preview: Array) -> String:
	if trigger_queue_preview.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in trigger_queue_preview:
		var entry: Dictionary = entry_variant as Dictionary
		var scheduled_tick: int = int(entry.get("scheduled_tick", -1))
		var debug_label: String = str(entry.get("debug_label", ""))
		var trigger_type_id: String = str(entry.get("trigger_type_id", ""))

		var label_text: String = debug_label.strip_edges()
		if label_text.is_empty():
			label_text = trigger_type_id

		parts.append("t%s:%s" % [scheduled_tick, label_text])

	return " | ".join(parts)

func _build_recent_command_text(recent_command_entries: Array) -> String:
	if recent_command_entries.is_empty():
		return "-"

	var entry_strings: Array[String] = []
	for entry: Variant in recent_command_entries:
		entry_strings.append(str(entry))

	return " | ".join(entry_strings)

func _build_command_queue_preview_text(command_queue_preview: Array) -> String:
	if command_queue_preview.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in command_queue_preview:
		var entry: Dictionary = entry_variant as Dictionary
		var command_id: String = str(entry.get("command_id", ""))
		var debug_label: String = str(entry.get("debug_label", ""))
		var command_type_id: String = str(entry.get("command_type_id", ""))

		var label_text: String = debug_label.strip_edges()
		if label_text.is_empty():
			label_text = command_type_id

		parts.append("%s:%s" % [command_id, label_text])

	return " | ".join(parts)

func _build_hex_signature_text(value: int) -> String:
	return "0x%08X" % value

func _display_or_dash(value: String) -> String:
	if value.strip_edges().is_empty():
		return "-"

	return value

func _display_int_or_dash(value: int) -> String:
	if value < 0:
		return "-"

	return str(value)

func _get_build_info() -> Dictionary:
	var app_root: Node = get_node_or_null("/root/AppRoot")
	if app_root != null and app_root.has_method("get_build_info"):
		return app_root.call("get_build_info")

	return {
		"project_name": DEFAULT_PROJECT_NAME,
		"build_version": DEFAULT_BUILD_VERSION,
		"engine_version": "",
		"current_scene_path": "",
	}

func _get_boot_context() -> Dictionary:
	var sim_root: Node = get_node_or_null("/root/SimRoot")
	if sim_root != null and sim_root.has_method("get_boot_context"):
		return sim_root.call("get_boot_context")

	return {
		"scenario_id": "scenario.dev.temperate_valley",
		"stage_id": "stage.lone_survivor",
		"map_preset_id": "starter_map_balanced",
		"worldgen_profile_id": "authored_starter_temperate_valley",
		"season_profile_id": "temperate_four_season_basic",
		"seed": 100001,
		"calendar": {
			"tick_index": 0,
			"year_index": 0,
			"day_index": 1,
			"season_id": "season.spring",
			"part_of_day_id": "part_of_day.dawn",
			"season_profile_id": "temperate_four_season_basic",
			"ticks_per_part_of_day": 1,
			"tick_progress_within_part": 0,
			"is_paused": true,
			"speed_index": 0,
			"speed_multiplier": 1,
			"active_phase_id": "",
			"last_completed_phase_id": "",
			"base_ticks_per_second": 2.0,
			"effective_ticks_per_second": 2.0,
			"scenario_seed": 100001,
			"phase_listener_count_total": 0,
			"rng_stream_count": 0,
			"debug_visible_phase_id": "",
			"debug_visible_phase_tick_index": 0,
			"debug_visible_phase_transition_serial": 0,
			"debug_last_completed_tick_index": 0,
			"debug_last_tick_total_duration_usec": 0,
			"debug_last_phase_duration_usec_by_phase": {},
			"debug_recent_phase_entries": [],
			"scheduled_trigger_count": 0,
			"next_scheduled_trigger_tick": -1,
			"scheduled_trigger_queue_preview": [],
			"debug_last_resolved_trigger_id": "",
			"debug_last_resolved_trigger_type_id": "",
			"debug_last_resolved_trigger_tick": -1,
			"debug_resolved_trigger_count_total": 0,
			"debug_recent_resolved_trigger_entries": [],
			"queued_command_count": 0,
			"queued_command_queue_preview": [],
			"debug_last_processed_command_id": "",
			"debug_last_processed_command_type_id": "",
			"debug_last_processed_command_tick": -1,
			"debug_processed_command_count_total": 0,
			"debug_recent_processed_command_entries": [],
			"debug_determinism_signature": 0,
			"debug_determinism_event_count": 0,
			"debug_determinism_last_event": "",
		},
	}

func _get_definition_report() -> Dictionary:
	var definition_registry: Node = get_node_or_null("/root/DefinitionRegistry")
	if definition_registry != null and definition_registry.has_method("get_validation_report"):
		return definition_registry.call("get_validation_report")

	return {
		"is_valid": false,
		"loaded_count_total": 0,
		"warning_count": 0,
		"error_count": 1,
	}
