extends Node2D
class_name TerrainOverlayOutlineRenderer

const SIM_ROOT_LOCATOR_SCRIPT: Script = preload("res://scripts/presentation/sim_root_locator.gd")

const TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT: Script = preload(
	"res://scripts/presentation/world/terrain_debug_visual_config.gd"
)

const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

var _terrain_debug_visual_config: TerrainDebugVisualConfig = TERRAIN_DEBUG_VISUAL_CONFIG_SCRIPT.new()

var _last_world_id: String = ""
var _last_hovered_cell_index: Vector2i = Vector2i(-9999, -9999)
var _last_selected_cell_index: Vector2i = Vector2i(-9999, -9999)
var _last_zoom_band_id: String = ""
var _last_zoom_scalar: float = -1.0


func _ready() -> void:
	set_process(true)
	queue_redraw()


func _process(_delta: float) -> void:
	var current_world_id: String = _get_current_world_id()
	var hovered_cell_index: Vector2i = _get_hovered_cell_index()
	var selected_cell_index: Vector2i = _get_selected_cell_index()
	var zoom_band_id: String = _get_zoom_band_id()
	var zoom_scalar: float = _get_zoom_scalar()

	var needs_redraw: bool = false

	if current_world_id != _last_world_id:
		_last_world_id = current_world_id
		needs_redraw = true

	if hovered_cell_index != _last_hovered_cell_index:
		_last_hovered_cell_index = hovered_cell_index
		needs_redraw = true

	if selected_cell_index != _last_selected_cell_index:
		_last_selected_cell_index = selected_cell_index
		needs_redraw = true

	if zoom_band_id != _last_zoom_band_id:
		_last_zoom_band_id = zoom_band_id
		needs_redraw = true

	if not is_equal_approx(zoom_scalar, _last_zoom_scalar):
		_last_zoom_scalar = zoom_scalar
		needs_redraw = true

	if needs_redraw:
		queue_redraw()


func _draw() -> void:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return

	if not sim_root.has_method("get_world_state"):
		return

	var world_state_variant: Variant = sim_root.call("get_world_state")
	var world_state: WorldState = world_state_variant as WorldState
	if world_state == null:
		return

	var zoom_band_id: String = _get_zoom_band_id()
	var zoom_scalar: float = _get_zoom_scalar()

	var hovered_cell_index: Vector2i = _get_hovered_cell_index()
	if world_state.is_cell_index_in_bounds(hovered_cell_index):
		_draw_cell_highlight(
			world_state,
			hovered_cell_index,
			"hover",
			zoom_band_id,
			zoom_scalar
		)

	var selected_cell_index: Vector2i = _get_selected_cell_index()
	if world_state.is_cell_index_in_bounds(selected_cell_index):
		_draw_cell_highlight(
			world_state,
			selected_cell_index,
			"selected",
			zoom_band_id,
			zoom_scalar
		)


func _draw_cell_highlight(
	world_state: WorldState,
	cell_index: Vector2i,
	highlight_kind_id: String,
	zoom_band_id: String,
	zoom_scalar: float
) -> void:
	var style: Dictionary = _terrain_debug_visual_config.build_cell_highlight_style(
		highlight_kind_id,
		zoom_band_id,
		zoom_scalar
	)

	var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
	var fill_color: Color = style.get("fill_color", Color(0.0, 0.0, 0.0, 0.0)) as Color
	var outline_color: Color = style.get("outline_color", Color(1.0, 1.0, 1.0, 1.0)) as Color
	var outline_width_world: float = float(style.get("outline_width_world", 1.0))
	var draw_fill: bool = bool(style.get("draw_fill", false))

	if draw_fill:
		draw_rect(cell_rect, fill_color, true)

	draw_rect(cell_rect, outline_color, false, outline_width_world)


func _get_current_world_id() -> String:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return ""

	if not sim_root.has_method("get_world_state"):
		return ""

	var world_state_variant: Variant = sim_root.call("get_world_state")
	var current_world_state: WorldState = world_state_variant as WorldState
	if current_world_state == null:
		return ""

	return current_world_state.world_id


func _get_hovered_cell_index() -> Vector2i:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return INVALID_CELL_INDEX

	if not sim_root.has_method("get_debug_hovered_cell_index"):
		return INVALID_CELL_INDEX

	var hovered_cell_index_variant: Variant = sim_root.call("get_debug_hovered_cell_index")
	if hovered_cell_index_variant is Vector2i:
		return hovered_cell_index_variant

	return INVALID_CELL_INDEX


func _get_selected_cell_index() -> Vector2i:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return INVALID_CELL_INDEX

	if not sim_root.has_method("get_debug_selected_cell_index"):
		return INVALID_CELL_INDEX

	var selected_cell_index_variant: Variant = sim_root.call("get_debug_selected_cell_index")
	if selected_cell_index_variant is Vector2i:
		return selected_cell_index_variant

	return INVALID_CELL_INDEX


func _get_zoom_band_id() -> String:
	var active_camera: Camera2D = get_viewport().get_camera_2d()
	if active_camera != null and active_camera.has_method("get_zoom_band_id"):
		return str(active_camera.call("get_zoom_band_id"))

	return "mid"


func _get_zoom_scalar() -> float:
	var active_camera: Camera2D = get_viewport().get_camera_2d()
	if active_camera == null:
		return 1.0

	return maxf(active_camera.zoom.x, 0.001)


func _sim_root() -> Node:
	return SIM_ROOT_LOCATOR_SCRIPT.get_sim_root(self)
