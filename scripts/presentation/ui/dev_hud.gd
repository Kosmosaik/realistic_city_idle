extends CanvasLayer
class_name DevHud

const TOGGLE_KEY: Key = KEY_F3
const DEFAULT_PROJECT_NAME: String = "Realistic City Idle"
const DEFAULT_BUILD_VERSION: String = "0.0.0-dev"

var _panel_root: Control
var _label: Label

func _ready() -> void:
	layer = 10
	_build_ui()
	_refresh_text()

func _process(_delta: float) -> void:
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
	outer_margin.offset_left = 8.0
	outer_margin.offset_top = 8.0
	outer_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(outer_margin)
	_panel_root = outer_margin

	var panel: PanelContainer = PanelContainer.new()
	panel.custom_minimum_size = Vector2(275.0, 0.0)
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	outer_margin.add_child(panel)

	var inner_margin: MarginContainer = MarginContainer.new()
	inner_margin.add_theme_constant_override("margin_left", 6)
	inner_margin.add_theme_constant_override("margin_top", 5)
	inner_margin.add_theme_constant_override("margin_right", 6)
	inner_margin.add_theme_constant_override("margin_bottom", 5)
	inner_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(inner_margin)

	_label = Label.new()
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	_label.add_theme_font_size_override("font_size", 11)
	_label.text = ""
	inner_margin.add_child(_label)

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

	_label.text = "\n".join([
		"RCI — Branch 00",
		"Build: %s" % build_info.get("build_version", DEFAULT_BUILD_VERSION),
		"Scene: %s" % build_info.get("current_scene_path", "n/a"),
		"",
		"Scenario: %s" % boot_context.get("scenario_id", "n/a"),
		"Seed: %s" % str(boot_context.get("seed", 0)),
		"Stage: %s" % boot_context.get("stage_id", "n/a"),
		"",
		"Year: %s" % str(calendar.get("year_index", 0)),
		"Day: %s" % str(calendar.get("day_index", 1)),
		"Season: %s" % str(calendar.get("season_id", "n/a")),
		"Part: %s" % str(calendar.get("part_of_day_id", "n/a")),
		"",
		"F3: toggle HUD",
	])

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
		"seed": 100001,
		"calendar": {
			"year_index": 0,
			"day_index": 1,
			"season_id": "season.spring",
			"part_of_day_id": "part_of_day.dawn",
		},
	}
