extends CanvasLayer
class_name DevHud

const DEV_HUD_TEXT_FORMATTER_SCRIPT: Script = preload("res://scripts/presentation/ui/dev_hud_text_formatter.gd")

const TOGGLE_KEY: Key = KEY_F3
const DEFAULT_PROJECT_NAME: String = "Realistic City Idle"
const DEFAULT_BUILD_VERSION: String = "0.0.0-dev"
const PANEL_WIDTH: float = 660.0
const PANEL_OUTER_MARGIN: float = 8.0
const PANEL_INNER_MARGIN: float = 6.0
const PANEL_MIN_HEIGHT: float = 220.0
const HUD_REFRESH_INTERVAL_SECONDS: float = 0.25

const APP_ROOT_NODE_PATH: NodePath = NodePath("/root/AppRoot")
const SIM_ROOT_LOCATOR_SCRIPT: Script = preload("res://scripts/presentation/sim_root_locator.gd")
const BOOT_DEFAULTS_SCRIPT: Script = preload("res://scripts/core/boot_defaults.gd")
const DEFINITION_REGISTRY_NODE_PATH: NodePath = NodePath("/root/DefinitionRegistry")

var _panel_root: Control
var _scroll_container: ScrollContainer
var _label: Label
var _hud_refresh_cooldown_seconds: float = 0.0
var _text_formatter: DevHudTextFormatter = DEV_HUD_TEXT_FORMATTER_SCRIPT.new() as DevHudTextFormatter


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
	scroll_container.custom_minimum_size = Vector2(
		PANEL_WIDTH - (PANEL_INNER_MARGIN * 2.0),
		PANEL_MIN_HEIGHT
	)
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
	var max_panel_height: float = maxf(
		PANEL_MIN_HEIGHT,
		visible_rect.size.y - (PANEL_OUTER_MARGIN * 2.0)
	)
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
	var world_snapshot: Dictionary = _get_world_debug_snapshot()
	var performance_snapshot: Dictionary = _get_performance_snapshot()

	_label.text = _text_formatter.build_panel_text(
		build_info,
		boot_context,
		definition_report,
		world_snapshot,
		performance_snapshot
	)


func _get_build_info() -> Dictionary:
	var app_root: Node = get_node_or_null(APP_ROOT_NODE_PATH)
	if app_root != null and app_root.has_method("get_build_info"):
		return app_root.call("get_build_info")

	return {
		"project_name": DEFAULT_PROJECT_NAME,
		"build_version": DEFAULT_BUILD_VERSION,
		"engine_version": "",
		"current_scene_path": "",
	}

func _sim_root() -> Node:
	return SIM_ROOT_LOCATOR_SCRIPT.get_sim_root(self)

func _get_boot_context() -> Dictionary:
	var sim_root: Node = _sim_root()
	if sim_root != null and sim_root.has_method("get_boot_context"):
		return sim_root.call("get_boot_context")

	return BOOT_DEFAULTS_SCRIPT.build_default_boot_context()

func _get_definition_report() -> Dictionary:
	var definition_registry: Node = get_node_or_null(DEFINITION_REGISTRY_NODE_PATH)
	if definition_registry != null and definition_registry.has_method("get_validation_report"):
		return definition_registry.call("get_validation_report")

	return {
		"is_valid": false,
		"loaded_count_total": 0,
		"warning_count": 0,
		"error_count": 1,
	}

func _get_world_debug_snapshot() -> Dictionary:
	var sim_root: Node = _sim_root()
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
