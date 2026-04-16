extends CanvasLayer
class_name DevHud

const TOGGLE_KEY: Key = KEY_F3
const DEFAULT_PROJECT_NAME: String = "Realistic City Idle"
const DEFAULT_BUILD_VERSION: String = "0.0.0-dev"
const PANEL_WIDTH: float = 660.0
const PANEL_OUTER_MARGIN: float = 8.0
const PANEL_INNER_MARGIN: float = 6.0
const PANEL_MIN_HEIGHT: float = 220.0
const HUD_REFRESH_INTERVAL_SECONDS: float = 0.25

var _panel_root: Control
var _scroll_container: ScrollContainer
var _label: Label
var _hud_refresh_cooldown_seconds: float = 0.0

func _ready() -> void:
	layer = 10
	_build_ui()
	_update_panel_layout()
	_refresh_text()

func _process(delta: float) -> void:
	_update_panel_layout()

	if _panel_root == null:
		return

	if not _panel_root.visible:
		return

	_hud_refresh_cooldown_seconds -= delta
	if _hud_refresh_cooldown_seconds > 0.0:
		return

	_hud_refresh_cooldown_seconds = HUD_REFRESH_INTERVAL_SECONDS
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
	_hud_refresh_cooldown_seconds = 0.0

	if _panel_root.visible:
		_refresh_text()

func _refresh_text() -> void:
	if _label == null:
		return

	var build_info: Dictionary = _get_build_info()
	var boot_context: Dictionary = _get_boot_context()
	var definition_report: Dictionary = _get_definition_report()
	var calendar: Dictionary = boot_context.get("calendar", {})
	var world_snapshot: Dictionary = _get_world_debug_snapshot()
	var performance_snapshot: Dictionary = _get_performance_snapshot()

	var camera_snapshot: Dictionary = world_snapshot.get("camera", {}) as Dictionary
	var site_hints_state_text: String = "On" if bool(world_snapshot.get("debug_site_hints_visible", false)) else "Off"
	var camera_center_cell_text: String = _build_cell_index_text(camera_snapshot.get("center_cell_index", Vector2i(-1, -1)))

	var recent_phase_entries: Array = calendar.get("debug_recent_phase_entries", [])
	var phase_duration_map: Dictionary = calendar.get("debug_last_tick_phase_durations_usec", {})
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
	var world_focus_text: String = _build_world_focus_text(world_snapshot)

	var hovered_entry: Dictionary = world_snapshot.get("hovered_cell", {}) as Dictionary
	var selected_entry: Dictionary = world_snapshot.get("selected_cell", {}) as Dictionary

	var hovered_cell_text: String = _build_inspector_cell_text(hovered_entry)
	var selected_cell_text: String = _build_inspector_cell_text(selected_entry)
	var hovered_patch_text: String = _build_inspector_patch_text(hovered_entry)
	var selected_patch_text: String = _build_inspector_patch_text(selected_entry)

	var overlay_mode_id: String = str(world_snapshot.get("debug_overlay_mode_id", "off"))
	var overlay_legend_text: String = _build_overlay_legend_text(overlay_mode_id)
	var terrain_inspector_state_text: String = "On"
	if not bool(world_snapshot.get("debug_terrain_inspector_visible", true)):
		terrain_inspector_state_text = "Off"

	_label.text = "\n".join([
		"RCI — Branch 04B / Slice 01",
		"Build: %s" % build_info.get("build_version", DEFAULT_BUILD_VERSION),
		"Engine: %s" % build_info.get("engine_version", "n/a"),
		"Scene: %s" % build_info.get("current_scene_path", "n/a"),
		"",
		"FPS: %s" % str(performance_snapshot.get("fps", 0)),
		"Frame Time: %s" % _format_milliseconds(float(performance_snapshot.get("process_time_msec", 0.0))),
		"Physics Time: %s" % _format_milliseconds(float(performance_snapshot.get("physics_time_msec", 0.0))),
		"Static Mem: %s" % _format_memory_mebibytes(int(performance_snapshot.get("static_memory_bytes", 0))),
		"Objects: %s" % str(performance_snapshot.get("object_count", 0)),
		"Nodes: %s" % str(performance_snapshot.get("node_count", 0)),
		"Render Objects: %s" % str(performance_snapshot.get("render_object_count", 0)),
		"Draw Calls: %s" % str(performance_snapshot.get("render_draw_calls", 0)),
		"",
		"Scenario: %s" % boot_context.get("scenario_id", "n/a"),
		"Stage: %s" % boot_context.get("stage_id", "n/a"),
		"Map Preset: %s" % boot_context.get("map_preset_id", "n/a"),
		"Worldgen: %s" % boot_context.get("worldgen_profile_id", "n/a"),
		"Season Profile: %s" % boot_context.get("season_profile_id", "n/a"),
		"Seed: %s" % str(boot_context.get("seed", 0)),
		"",
		"World Loaded: %s" % ("Yes" if bool(world_snapshot.get("is_loaded", false)) else "No"),
		"World ID: %s" % _display_or_dash(str(world_snapshot.get("world_id", ""))),
		"Fixture: %s" % _display_or_dash(str(world_snapshot.get("fixture_id", ""))),
		"Terrain Profile: %s" % _display_or_dash(str(world_snapshot.get("primary_terrain_profile_id", ""))),
		"World Size: %s x %s cells @ %spx" % [
			str(world_snapshot.get("world_width_cells", 0)),
			str(world_snapshot.get("world_height_cells", 0)),
			str(world_snapshot.get("cell_size_pixels", 0)),
		],
		"World Cells: %s" % str(world_snapshot.get("cell_count", 0)),
		"World Chunks: %s" % str(world_snapshot.get("chunk_count", 0)),
		"World Patches: %s" % str(world_snapshot.get("patch_count", 0)),
		"Reveal Sources: %s" % str(world_snapshot.get("reveal_source_count", 0)),
		"Terrain Objects: %s" % str(world_snapshot.get("authored_terrain_object_count", 0)),
		"Generation Warnings: %s" % str(world_snapshot.get("generation_warning_count", 0)),
		"Overlay Mode: %s" % _display_or_dash(overlay_mode_id),
		"Overlay Legend:",
		overlay_legend_text,
		"Terrain Inspector: %s" % terrain_inspector_state_text,
		"Site Hints: %s" % site_hints_state_text,
		"Camera Zoom: %.2f" % float(camera_snapshot.get("zoom_scalar", 1.0)),
		"Camera Band: %s" % _display_or_dash(str(camera_snapshot.get("zoom_band_id", ""))),
		"Camera Cell: %s" % camera_center_cell_text,
		"Focus Cells:",
		world_focus_text,
		"",
		"Hovered Cell:",
		hovered_cell_text,
		"Hovered Patches:",
		hovered_patch_text,
		"",
		"Selected Cell:",
		selected_cell_text,
		"Selected Patches:",
		selected_patch_text,
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
		"F4: toggle terrain inspector",
		"F5: toggle site hints",
		"Mouse wheel: zoom camera or scroll HUD",
		"Middle mouse drag / WASD / arrows: pan camera",
		"Left click: select cell",
		"Right click: clear selected cell",
		"O / Shift+O: next/previous overlay",
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
	
func _get_world_debug_snapshot() -> Dictionary:
	var sim_root: Node = get_node_or_null("/root/SimRoot")
	if sim_root != null and sim_root.has_method("get_world_debug_snapshot"):
		return sim_root.call("get_world_debug_snapshot")

	return {
		"is_loaded": false,
	}
	
func _get_performance_snapshot() -> Dictionary:
	return {
		"fps": int(Performance.get_monitor(Performance.TIME_FPS)),
		"process_time_msec": float(Performance.get_monitor(Performance.TIME_PROCESS)) * 1000.0,
		"physics_time_msec": float(Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS)) * 1000.0,
		"static_memory_bytes": int(Performance.get_monitor(Performance.MEMORY_STATIC)),
		"object_count": int(Performance.get_monitor(Performance.OBJECT_COUNT)),
		"node_count": int(Performance.get_monitor(Performance.OBJECT_NODE_COUNT)),
		"render_object_count": int(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)),
		"render_draw_calls": int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)),
	}

func _build_world_focus_text(world_snapshot: Dictionary) -> String:
	var focus_cells: Array = world_snapshot.get("focus_cells", [])
	if focus_cells.is_empty():
		return "  - -"

	var lines: Array[String] = []

	for entry_variant: Variant in focus_cells:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		lines.append("  - %s" % _build_focus_cell_line(entry))

	if lines.is_empty():
		return "  - -"

	return "\n".join(lines)

func _build_focus_cell_line(entry: Dictionary) -> String:
	var label: String = str(entry.get("label", "focus"))
	var cell: Dictionary = entry.get("cell", {}) as Dictionary

	var cell_index_variant: Variant = cell.get("cell_index", Vector2i.ZERO)
	var cell_index: Vector2i = Vector2i.ZERO
	if cell_index_variant is Vector2i:
		cell_index = cell_index_variant as Vector2i

	var poi_text: String = _build_string_list_text(cell.get("point_of_interest_tags", []))

	return "%s @ (%s,%s) | landform=%s | slope=%s | drainage=%s | wetness=%s | water=%s | veg=%s | buildable=%s | poi=%s" % [
		label,
		cell_index.x,
		cell_index.y,
		str(cell.get("landform_type", "")),
		str(cell.get("slope_class", "")),
		str(cell.get("drainage_class", "")),
		str(cell.get("wetness_tendency", "")),
		str(cell.get("surface_water_type", "")),
		str(cell.get("vegetation_cover_class", "")),
		str(cell.get("is_buildable", false)),
		poi_text,
	]

func _build_cell_index_text(cell_index_variant: Variant) -> String:
	if not (cell_index_variant is Vector2i):
		return "-"

	var cell_index: Vector2i = cell_index_variant as Vector2i
	if cell_index.x < 0 or cell_index.y < 0:
		return "-"

	return "(%s,%s)" % [cell_index.x, cell_index.y]

func _build_string_list_text(values_variant: Variant) -> String:
	var parts: Array[String] = []

	if values_variant is PackedStringArray:
		for value: String in values_variant:
			parts.append(value)
	elif values_variant is Array:
		for value_variant: Variant in values_variant:
			parts.append(str(value_variant))

	if parts.is_empty():
		return "-"

	return ",".join(parts)
	
func _build_inspector_cell_text(entry_variant: Variant) -> String:
	if not (entry_variant is Dictionary):
		return "  - -"

	var entry: Dictionary = entry_variant as Dictionary
	var cell: Dictionary = entry.get("cell", {}) as Dictionary
	if cell.is_empty():
		return "  - -"

	var label: String = str(entry.get("label", "cell"))
	var cell_index_variant: Variant = cell.get("cell_index", Vector2i.ZERO)
	var cell_index: Vector2i = Vector2i.ZERO
	if cell_index_variant is Vector2i:
		cell_index = cell_index_variant as Vector2i

	var patch_text: String = _build_string_list_text(cell.get("patch_ids", []))
	var poi_text: String = _build_string_list_text(cell.get("point_of_interest_tags", []))
	var zone_stamp_id: String = _display_or_dash(str(cell.get("zone_stamp_id", "")))

	return "\n".join([
		"  - %s @ (%s,%s) | key=%s | chunk=%s | patches=%s" % [
			label,
			cell_index.x,
			cell_index.y,
			str(cell.get("cell_key", "")),
			_display_or_dash(str(cell.get("chunk_id", ""))),
			patch_text,
		],
		"    elev=%s | landform=%s | slope=%s | water=%s | drainage=%s | wetness=%s | firmness=%s | veg=%s" % [
			str(cell.get("elevation_step", 0)),
			str(cell.get("landform_type", "")),
			str(cell.get("slope_class", "")),
			str(cell.get("surface_water_type", "")),
			str(cell.get("drainage_class", "")),
			str(cell.get("wetness_tendency", "")),
			str(cell.get("ground_firmness_class", "")),
			str(cell.get("vegetation_cover_class", "")),
		],
		"    move=%s | haul=%s | buildable=%s | fog=%s | revealed=%s | visible=%s | zone=%s | poi=%s" % [
			_format_float_text(float(cell.get("movement_cost", 0.0))),
			_format_float_text(float(cell.get("haul_cost_multiplier", 0.0))),
			str(cell.get("is_buildable", false)),
			str(cell.get("fog_state", "")),
			str(cell.get("is_revealed", false)),
			str(cell.get("is_currently_visible", false)),
			zone_stamp_id,
			poi_text,
		],
	])

func _format_float_text(value: float) -> String:
	return "%.2f" % value
	
func _build_inspector_patch_text(entry_variant: Variant) -> String:
	if not (entry_variant is Dictionary):
		return "  - -"

	var entry: Dictionary = entry_variant as Dictionary
	var patches_variant: Variant = entry.get("patches", [])
	if not (patches_variant is Array):
		return "  - -"

	var patches: Array = patches_variant as Array
	if patches.is_empty():
		return "  - -"

	var lines: Array[String] = []

	for patch_variant: Variant in patches:
		if not (patch_variant is Dictionary):
			continue

		var patch: Dictionary = patch_variant as Dictionary
		var poi_text: String = _build_string_list_text(patch.get("point_of_interest_tags", []))
		var source_tag_text: String = _build_string_list_text(patch.get("source_tags", []))
		var resource_text: String = _build_summary_dict_text(patch.get("resource_summary", {}))
		var hazard_text: String = _build_summary_dict_text(patch.get("hazard_summary", {}))

		lines.append(
			"  - %s | type=%s | area=%s | reveal=%s | site=%s" % [
				_display_or_dash(str(patch.get("patch_id", ""))),
				_display_or_dash(str(patch.get("patch_type", ""))),
				str(patch.get("area_cell_count", 0)),
				_display_or_dash(str(patch.get("reveal_state", ""))),
				_format_float_text(float(patch.get("site_score", 0.0))),
			]
		)

		lines.append(
			"    source=%s | tags=%s" % [
				_display_or_dash(str(patch.get("source_stamp_id", ""))),
				source_tag_text,
			]
		)

		lines.append(
			"    terrain=%s | vegetation=%s | drainage=%s | water=%s | buildable=%s | poi=%s" % [
				_display_or_dash(str(patch.get("dominant_landform_type", patch.get("landform_type", "")))),
				_display_or_dash(str(patch.get("dominant_vegetation_cover_class", patch.get("vegetation_cover_class", "")))),
				_display_or_dash(str(patch.get("dominant_drainage_class", patch.get("drainage_class", "")))),
				_display_or_dash(str(patch.get("surface_water_type", ""))),
				str(patch.get("is_buildable", false)),
				poi_text,
			]
		)

		lines.append(
			"    resources=%s | hazards=%s" % [
				resource_text,
				hazard_text,
			]
		)

	if lines.is_empty():
		return "  - -"

	return "\n".join(lines)

func _build_summary_dict_text(summary_variant: Variant) -> String:
	if not (summary_variant is Dictionary):
		return "-"

	var summary: Dictionary = summary_variant as Dictionary
	if summary.is_empty():
		return "-"

	var keys: Array[String] = []
	for key_variant: Variant in summary.keys():
		keys.append(str(key_variant))

	keys.sort()

	var parts: Array[String] = []

	for key: String in keys:
		var value: Variant = summary.get(key, null)

		if value is PackedStringArray or value is Array:
			parts.append("%s=%s" % [key, _build_string_list_text(value)])
			continue

		parts.append("%s=%s" % [key, str(value)])

	return ", ".join(parts)

func _format_milliseconds(value_msec: float) -> String:
	return "%.2f ms" % value_msec

func _format_memory_mebibytes(memory_bytes: int) -> String:
	var memory_mebibytes: float = float(memory_bytes) / (1024.0 * 1024.0)
	return "%.2f MiB" % memory_mebibytes
	
func _build_overlay_legend_text(overlay_mode_id: String) -> String:
	var legend_lines: Array[String] = _build_overlay_legend_lines(overlay_mode_id)
	if legend_lines.is_empty():
		return "  - -"

	return "\n".join(legend_lines)

func _build_overlay_legend_lines(overlay_mode_id: String) -> Array[String]:
	match overlay_mode_id:
		"off":
			return [
				"  - overlay disabled",
			]
		"elevation":
			return [
				"  - low ground = cool dark tint",
				"  - high ground = warm tan tint",
			]
		"drainage":
			return [
				"  - poor drainage = red/orange",
				"  - moderate drainage = amber",
				"  - good drainage = green",
			]
		"wetness":
			return [
				"  - dry = tan",
				"  - damp = teal-green",
				"  - wet = blue",
			]
		"vegetation":
			return [
				"  - none = bare muted tint",
				"  - sparse / grass / brush / woodland = increasingly denser green tint",
			]
		"buildability":
			return [
				"  - buildable = green",
				"  - not buildable = red",
			]
		"site_score":
			return [
				"  - red = weak site",
				"  - amber = mixed / usable site",
				"  - green = strong site",
			]
		"patch_boundaries":
			return [
				"  - blue outline = water patch",
				"  - green outline = buildable patch",
				"  - white outline = other patch",
			]
		"fog_memory":
			return [
				"  - visible = nearly clear",
				"  - remembered = muted blue tint",
				"  - hidden = dark obscuring tint",
			]
		_:
			return [
				"  - no legend available",
			]
