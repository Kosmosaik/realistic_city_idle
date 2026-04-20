extends RefCounted
class_name DevHudTextFormatter

const DEFAULT_PROJECT_NAME: String = "Realistic City Idle"
const DEFAULT_BUILD_VERSION: String = "0.0.0-dev"
const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

const TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT: Script = preload(
	"res://scripts/presentation/world/terrain_debug_visual_config.gd"
)

var _terrain_debug_visual_config: TerrainDebugVisualConfig = TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT.new()


func build_panel_text(
	build_info: Dictionary,
	boot_context: Dictionary,
	definition_report: Dictionary,
	world_snapshot: Dictionary,
	performance_snapshot: Dictionary
) -> String:
	var calendar: Dictionary = boot_context.get("calendar", {}) as Dictionary
	var camera_snapshot: Dictionary = world_snapshot.get("camera", {}) as Dictionary

	var project_name: String = str(build_info.get("project_name", DEFAULT_PROJECT_NAME)).strip_edges()
	if project_name.is_empty():
		project_name = DEFAULT_PROJECT_NAME

	var site_hints_state_text: String = "On" if bool(world_snapshot.get("debug_site_hints_visible", false)) else "Off"
	var full_visibility_state_text: String = "On" if bool(world_snapshot.get("debug_force_full_visibility", false)) else "Off"
	var camera_center_cell_text: String = _build_cell_index_text(
		camera_snapshot.get("center_cell_index", INVALID_CELL_INDEX)
	)

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
	var determinism_signature_text: String = _build_hex_signature_text(
		int(calendar.get("debug_determinism_signature", 0))
	)
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

	return "\n".join([
		"%s — Dev HUD" % project_name,
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
		"Site Hints: %s" % site_hints_state_text,
		"Full Visibility: %s" % full_visibility_state_text,
		"",
		"F3: toggle HUD",
		"F4: toggle terrain inspector",
		"F5: toggle site hints",
		"F6: toggle full visibility",
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

	var parts: Array[String] = []

	for entry_variant: Variant in recent_phase_entries:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		parts.append(
			"%s@%s" % [
				str(entry.get("phase_id", "")),
				str(entry.get("tick_index", 0)),
			]
		)

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_phase_duration_text(phase_duration_map: Dictionary) -> String:
	if phase_duration_map.is_empty():
		return "-"

	var phase_ids: Array[String] = []
	for phase_id_variant: Variant in phase_duration_map.keys():
		phase_ids.append(str(phase_id_variant))

	phase_ids.sort()

	var parts: Array[String] = []
	for phase_id: String in phase_ids:
		parts.append("%s=%sus" % [phase_id, str(phase_duration_map.get(phase_id, 0))])

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_recent_trigger_text(recent_trigger_entries: Array) -> String:
	if recent_trigger_entries.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in recent_trigger_entries:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		parts.append(
			"%s[%s]@%s" % [
				str(entry.get("trigger_id", "")),
				str(entry.get("trigger_type_id", "")),
				str(entry.get("resolved_tick", 0)),
			]
		)

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_trigger_queue_preview_text(trigger_queue_preview: Array) -> String:
	if trigger_queue_preview.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in trigger_queue_preview:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		parts.append(
			"%s[%s]@%s" % [
				str(entry.get("trigger_id", "")),
				str(entry.get("trigger_type_id", "")),
				str(entry.get("scheduled_tick", 0)),
			]
		)

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_recent_command_text(recent_command_entries: Array) -> String:
	if recent_command_entries.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in recent_command_entries:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		parts.append(
			"%s[%s]@%s" % [
				str(entry.get("command_id", "")),
				str(entry.get("command_type_id", "")),
				str(entry.get("processed_tick", 0)),
			]
		)

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_command_queue_preview_text(command_queue_preview: Array) -> String:
	if command_queue_preview.is_empty():
		return "-"

	var parts: Array[String] = []

	for entry_variant: Variant in command_queue_preview:
		if not (entry_variant is Dictionary):
			continue

		var entry: Dictionary = entry_variant as Dictionary
		parts.append(
			"%s[%s]@%s" % [
				str(entry.get("command_id", "")),
				str(entry.get("command_type_id", "")),
				str(entry.get("created_tick", 0)),
			]
		)

	if parts.is_empty():
		return "-"

	return ", ".join(parts)


func _build_hex_signature_text(value: int) -> String:
	return "0x%016x" % value


func _display_or_dash(value: String) -> String:
	var trimmed_value: String = value.strip_edges()
	if trimmed_value.is_empty():
		return "-"

	return trimmed_value


func _display_int_or_dash(value: int) -> String:
	if value < 0:
		return "-"

	return str(value)


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
	return _terrain_debug_visual_config.build_overlay_legend_lines(overlay_mode_id)
