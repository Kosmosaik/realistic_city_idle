extends CanvasLayer
class_name TerrainInspectorPanel

const SIM_ROOT_LOCATOR_SCRIPT: Script = preload("res://scripts/presentation/sim_root_locator.gd")

const PANEL_WIDTH: float = 430.0
const PANEL_MARGIN: float = 16.0

var _panel_container: PanelContainer
var _title_label: Label
var _body_text_edit: TextEdit
var _last_body_text: String = ""
var _last_visible_state: bool = true
var _last_overlay_mode_id: String = ""
var _last_world_id: String = ""
var _last_hovered_cell_index: Vector2i = Vector2i(-1, -1)
var _last_selected_cell_index: Vector2i = Vector2i(-1, -1)

func _ready() -> void:
	layer = 2
	_build_ui()
	set_process(true)
	set_process_unhandled_input(true)

func _process(_delta: float) -> void:
	var inspector_visible: bool = _is_inspector_visible()
	if inspector_visible != _last_visible_state:
		visible = inspector_visible
		_last_visible_state = inspector_visible

	if not inspector_visible:
		return

	var sim_root: Node = _sim_root()
	var next_overlay_mode_id: String = _get_overlay_mode_id(sim_root)
	var next_world_id: String = _get_world_id(sim_root)

	# Freeze hovered-cell driven updates while the pointer is inside the panel.
	# This lets the player scroll and read without the panel resetting on every mouse move.
	var next_hovered_cell_index: Vector2i = _last_hovered_cell_index
	if not _is_pointer_inside_panel():
		next_hovered_cell_index = _get_hovered_cell_index(sim_root)

	var next_selected_cell_index: Vector2i = _get_selected_cell_index(sim_root)

	if next_overlay_mode_id == _last_overlay_mode_id \
	and next_world_id == _last_world_id \
	and next_hovered_cell_index == _last_hovered_cell_index \
	and next_selected_cell_index == _last_selected_cell_index:
		return

	_last_overlay_mode_id = next_overlay_mode_id
	_last_world_id = next_world_id
	_last_hovered_cell_index = next_hovered_cell_index
	_last_selected_cell_index = next_selected_cell_index

	var next_body_text: String = _build_panel_text(
		sim_root,
		next_world_id,
		next_overlay_mode_id,
		next_hovered_cell_index,
		next_selected_cell_index
	)

	if next_body_text == _last_body_text:
		return

	_last_body_text = next_body_text
	if _body_text_edit != null:
		_body_text_edit.text = next_body_text

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

	if key_event.keycode != KEY_F4:
		return

	var sim_root: Node = _sim_root()
	if sim_root == null:
		return

	if sim_root.has_method("toggle_debug_terrain_inspector_visible"):
		sim_root.call("toggle_debug_terrain_inspector_visible")
		get_viewport().set_input_as_handled()

func _build_ui() -> void:
	_panel_container = PanelContainer.new()
	_panel_container.name = "TerrainInspectorPanelContainer"
	_panel_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	_panel_container.anchor_left = 1.0
	_panel_container.anchor_right = 1.0
	_panel_container.anchor_top = 0.0
	_panel_container.anchor_bottom = 1.0
	_panel_container.offset_left = -PANEL_WIDTH - PANEL_MARGIN
	_panel_container.offset_right = -PANEL_MARGIN
	_panel_container.offset_top = PANEL_MARGIN
	_panel_container.offset_bottom = -PANEL_MARGIN
	add_child(_panel_container)

	var margin_container: MarginContainer = MarginContainer.new()
	margin_container.add_theme_constant_override("margin_left", 12)
	margin_container.add_theme_constant_override("margin_right", 12)
	margin_container.add_theme_constant_override("margin_top", 12)
	margin_container.add_theme_constant_override("margin_bottom", 12)
	_panel_container.add_child(margin_container)

	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin_container.add_child(vbox)

	_title_label = Label.new()
	_title_label.text = "Terrain Inspector"
	_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	vbox.add_child(_title_label)

	_body_text_edit = TextEdit.new()
	_body_text_edit.editable = false
	_body_text_edit.context_menu_enabled = false
	_body_text_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_body_text_edit.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_body_text_edit.text = ""
	vbox.add_child(_body_text_edit)

func _build_panel_text(
	sim_root: Node,
	world_id: String,
	overlay_mode_id: String,
	hovered_cell_index: Vector2i,
	selected_cell_index: Vector2i
) -> String:
	var hovered_entry: Dictionary = _build_inspector_entry(sim_root, "hovered", hovered_cell_index)
	var selected_entry: Dictionary = _build_inspector_entry(sim_root, "selected", selected_cell_index)

	var lines: Array[String] = []
	lines.append("Branch 04B / Slice 01")
	lines.append("Inspector Visible: %s" % _bool_to_on_off(_is_inspector_visible()))
	lines.append("Overlay Mode: %s" % _display_or_dash(overlay_mode_id))
	lines.append("World ID: %s" % _display_or_dash(world_id))
	lines.append("")

	lines.append_array(_build_cell_section_lines("Hovered Cell", hovered_entry))
	lines.append("")
	lines.append_array(_build_patch_section_lines("Hovered Patches", hovered_entry))
	lines.append("")
	lines.append_array(_build_cell_section_lines("Selected Cell", selected_entry))
	lines.append("")
	lines.append_array(_build_patch_section_lines("Selected Patches", selected_entry))

	return "\n".join(lines)

func _build_cell_section_lines(title: String, inspector_entry: Dictionary) -> Array[String]:
	var lines: Array[String] = []
	lines.append(title)

	if inspector_entry.is_empty():
		lines.append("  - none")
		return lines

	var cell: Dictionary = inspector_entry.get("cell", {}) as Dictionary
	if cell.is_empty():
		lines.append("  - none")
		return lines

	lines.append("  Coordinate: %s" % _format_vector2i(cell.get("cell_index", Vector2i(-1, -1))))
	lines.append("  World Position: %s" % _format_vector2(cell.get("world_position", Vector2.ZERO)))
	lines.append("  Chunk ID: %s" % _display_or_dash(str(cell.get("chunk_id", ""))))
	lines.append("  Patch IDs: %s" % _format_string_array(cell.get("patch_ids", [])))
	lines.append("  Elevation Step: %s" % str(cell.get("elevation_step", 0)))
	lines.append("  Slope Class: %s" % _display_or_dash(str(cell.get("slope_class", ""))))
	lines.append("  Landform Type: %s" % _display_or_dash(str(cell.get("landform_type", ""))))
	lines.append("  Surface Water: %s" % _display_or_dash(str(cell.get("surface_water_type", ""))))
	lines.append("  Drainage Class: %s" % _display_or_dash(str(cell.get("drainage_class", ""))))
	lines.append("  Wetness Tendency: %s" % _display_or_dash(str(cell.get("wetness_tendency", ""))))
	lines.append("  Ground Firmness: %s" % _display_or_dash(str(cell.get("ground_firmness_class", ""))))
	lines.append("  Vegetation Community: %s" % _display_or_dash(str(cell.get("vegetation_cover_class", ""))))
	lines.append("  Movement Cost: %s" % _format_float(cell.get("movement_cost", 0.0), 2))
	lines.append("  Haul Cost Multiplier: %s" % _format_float(cell.get("haul_cost_multiplier", 0.0), 2))
	lines.append("  Buildable: %s" % _bool_to_yes_no(bool(cell.get("is_buildable", false))))
	lines.append("  Reveal State: %s" % _display_or_dash(str(cell.get("fog_state", ""))))
	lines.append("  Revealed: %s" % _bool_to_yes_no(bool(cell.get("is_revealed", false))))
	lines.append("  Currently Visible: %s" % _bool_to_yes_no(bool(cell.get("is_currently_visible", false))))
	lines.append("  Site Candidate Score: n/a")
	lines.append("  POI Tags: %s" % _format_string_array(cell.get("point_of_interest_tags", [])))
	lines.append("  Zone Stamp ID: %s" % _display_or_dash(str(cell.get("zone_stamp_id", ""))))

	var authored_terrain_objects: Array = cell.get("authored_terrain_objects", [])
	lines.append("  Authored Terrain Objects: %s" % str(authored_terrain_objects.size()))

	for object_index: int in range(authored_terrain_objects.size()):
		var object_entry: Dictionary = authored_terrain_objects[object_index] as Dictionary
		if object_entry.is_empty():
			continue

		lines.append("    [%s] %s (%s)" % [
			str(object_index + 1),
			_display_or_dash(str(object_entry.get("display_label", ""))),
			_display_or_dash(str(object_entry.get("object_type", ""))),
		])
		lines.append("      Placement Family: %s" % _display_or_dash(str(object_entry.get("placement_family", ""))))
		lines.append("      Validation Status: %s" % _display_or_dash(str(object_entry.get("validation_status", ""))))
		lines.append("      Validation Messages: %s" % _format_string_array(object_entry.get("validation_messages", [])))
		lines.append("      Tags: %s" % _format_string_array(object_entry.get("tags", [])))
		lines.append("      Source Stamp ID: %s" % _display_or_dash(str(object_entry.get("source_stamp_id", ""))))

	return lines

func _build_patch_section_lines(title: String, inspector_entry: Dictionary) -> Array[String]:
	var lines: Array[String] = []
	lines.append(title)

	if inspector_entry.is_empty():
		lines.append("  - none")
		return lines

	var patches: Array = inspector_entry.get("patches", [])
	if patches.is_empty():
		lines.append("  - none")
		return lines

	for patch_index: int in range(patches.size()):
		var patch: Dictionary = patches[patch_index] as Dictionary
		if patch.is_empty():
			continue

		lines.append("  [%s] %s (%s)" % [
			str(patch_index + 1),
			_display_or_dash(str(patch.get("patch_id", ""))),
			_display_or_dash(str(patch.get("patch_type", ""))),
		])
		lines.append("    Source Stamp: %s" % _display_or_dash(str(patch.get("source_stamp_id", ""))))
		lines.append("    Source Tags: %s" % _format_string_array(patch.get("source_tags", [])))
		lines.append("    Rect Position: %s" % _format_vector2i(patch.get("rect_position", Vector2i.ZERO)))
		lines.append("    Rect Size: %s" % _format_vector2i(patch.get("rect_size", Vector2i.ZERO)))
		lines.append("    Area Cell Count: %s" % str(patch.get("area_cell_count", 0)))
		lines.append("    Centroid World: %s" % _format_vector2(patch.get("centroid_world", Vector2.ZERO)))
		lines.append("    Dominant Landform: %s" % _display_or_dash(str(patch.get("dominant_landform_type", ""))))
		lines.append("    Dominant Vegetation: %s" % _display_or_dash(str(patch.get("dominant_vegetation_community", ""))))
		lines.append("    Dominant Drainage: %s" % _display_or_dash(str(patch.get("dominant_drainage_class", ""))))
		lines.append("    Surface Water: %s" % _display_or_dash(str(patch.get("surface_water_type", ""))))
		lines.append("    Wetness Tendency: %s" % _display_or_dash(str(patch.get("wetness_tendency", ""))))
		lines.append("    Buildable: %s" % _bool_to_yes_no(bool(patch.get("is_buildable", false))))
		lines.append("    Site Score: %s" % _format_float(patch.get("site_score", 0.0), 2))
		lines.append("    Reveal State: %s" % _display_or_dash(str(patch.get("reveal_state", ""))))
		lines.append("    Resource Summary: %s" % _format_summary_dictionary(patch.get("resource_summary", {})))
		lines.append("    Hazard Summary: %s" % _format_summary_dictionary(patch.get("hazard_summary", {})))
		lines.append("    POI Tags: %s" % _format_string_array(patch.get("point_of_interest_tags", [])))

	return lines

func _format_summary_dictionary(summary_variant: Variant) -> String:
	var summary: Dictionary = summary_variant as Dictionary
	if summary.is_empty():
		return "-"

	var parts: Array[String] = []

	for key_variant: Variant in summary.keys():
		var key: String = str(key_variant)
		var value: Variant = summary.get(key_variant)
		parts.append("%s=%s" % [key, _format_variant(value)])

	parts.sort()
	return ", ".join(parts)

func _format_variant(value: Variant) -> String:
	if value is Array:
		return _format_string_array(value)

	if value is Dictionary:
		return _format_summary_dictionary(value)

	if value is Vector2i:
		return _format_vector2i(value)

	if value is Vector2:
		return _format_vector2(value)

	return str(value)

func _format_string_array(values_variant: Variant) -> String:
	var values: Array = values_variant as Array
	if values.is_empty():
		return "-"

	var parts: Array[String] = []
	for value: Variant in values:
		parts.append(str(value))

	return ", ".join(parts)

func _format_vector2i(value_variant: Variant) -> String:
	var value: Vector2i = value_variant as Vector2i
	return "(%s, %s)" % [str(value.x), str(value.y)]

func _format_vector2(value_variant: Variant) -> String:
	var value: Vector2 = value_variant as Vector2
	return "(%.1f, %.1f)" % [value.x, value.y]

func _format_float(value_variant: Variant, decimals: int) -> String:
	var value: float = float(value_variant)
	return "%.*f" % [decimals, value]

func _bool_to_yes_no(value: bool) -> String:
	if value:
		return "Yes"
	return "No"

func _bool_to_on_off(value: bool) -> String:
	if value:
		return "On"
	return "Off"

func _display_or_dash(value: String) -> String:
	var trimmed_value: String = value.strip_edges()
	if trimmed_value.is_empty():
		return "-"

	return trimmed_value

func _is_inspector_visible() -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return true

	if not sim_root.has_method("is_debug_terrain_inspector_visible"):
		return true

	return bool(sim_root.call("is_debug_terrain_inspector_visible"))

func _build_inspector_entry(sim_root: Node, label: String, cell_index: Vector2i) -> Dictionary:
	if sim_root == null:
		return {}

	if cell_index.x < 0 or cell_index.y < 0:
		return {}

	if not sim_root.has_method("get_world_cell_debug_snapshot"):
		return {}

	if not sim_root.has_method("get_world_patch_debug_snapshots_for_cell"):
		return {}

	var cell_snapshot: Dictionary = sim_root.call("get_world_cell_debug_snapshot", cell_index)
	if cell_snapshot.is_empty():
		return {}

	var patch_snapshots: Array = sim_root.call("get_world_patch_debug_snapshots_for_cell", cell_index)
	return {
		"label": label,
		"cell": cell_snapshot,
		"patches": patch_snapshots,
	}

func _get_world_id(sim_root: Node) -> String:
	if sim_root == null:
		return ""

	if not sim_root.has_method("get_world_state"):
		return ""

	var world_state_variant: Variant = sim_root.call("get_world_state")
	var current_world_state: WorldState = world_state_variant as WorldState
	if current_world_state == null:
		return ""

	return current_world_state.world_id

func _get_overlay_mode_id(sim_root: Node) -> String:
	if sim_root == null:
		return "off"

	if not sim_root.has_method("get_debug_overlay_mode_id"):
		return "off"

	return str(sim_root.call("get_debug_overlay_mode_id"))

func _get_hovered_cell_index(sim_root: Node) -> Vector2i:
	if sim_root == null:
		return Vector2i(-1, -1)

	if not sim_root.has_method("get_debug_hovered_cell_index"):
		return Vector2i(-1, -1)

	var hovered_cell_index_variant: Variant = sim_root.call("get_debug_hovered_cell_index")
	if hovered_cell_index_variant is Vector2i:
		return hovered_cell_index_variant

	return Vector2i(-1, -1)

func _get_selected_cell_index(sim_root: Node) -> Vector2i:
	if sim_root == null:
		return Vector2i(-1, -1)

	if not sim_root.has_method("get_debug_selected_cell_index"):
		return Vector2i(-1, -1)

	var selected_cell_index_variant: Variant = sim_root.call("get_debug_selected_cell_index")
	if selected_cell_index_variant is Vector2i:
		return selected_cell_index_variant

	return Vector2i(-1, -1)

func _is_pointer_inside_panel() -> bool:
	if _panel_container == null:
		return false

	if not _panel_container.visible:
		return false

	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	return _panel_container.get_global_rect().has_point(mouse_position)

func _sim_root() -> Node:
	return SIM_ROOT_LOCATOR_SCRIPT.get_sim_root(self)
