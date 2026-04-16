extends Node2D
class_name TerrainOverlayOutlineRenderer

const HOVER_OUTLINE_COLOR: Color = Color(1.0, 0.88, 0.20, 0.95)
const SELECTED_OUTLINE_COLOR: Color = Color(0.25, 0.95, 1.0, 0.95)
const OUTLINE_WIDTH: float = 2.0
const SELECTED_OUTLINE_WIDTH: float = 3.0

var _last_world_id: String = ""
var _last_hovered_cell_index: Vector2i = Vector2i(-9999, -9999)
var _last_selected_cell_index: Vector2i = Vector2i(-9999, -9999)

func _ready() -> void:
	set_process(true)
	queue_redraw()

func _process(_delta: float) -> void:
	var current_world_id: String = _get_current_world_id()
	var hovered_cell_index: Vector2i = _get_hovered_cell_index()
	var selected_cell_index: Vector2i = _get_selected_cell_index()

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

	var hovered_cell_index: Vector2i = _get_hovered_cell_index()
	if world_state.is_cell_index_in_bounds(hovered_cell_index):
		var hovered_rect: Rect2 = world_state.cell_index_to_world_rect(hovered_cell_index)
		draw_rect(hovered_rect, HOVER_OUTLINE_COLOR, false, OUTLINE_WIDTH)

	var selected_cell_index: Vector2i = _get_selected_cell_index()
	if world_state.is_cell_index_in_bounds(selected_cell_index):
		var selected_rect: Rect2 = world_state.cell_index_to_world_rect(selected_cell_index)
		draw_rect(selected_rect, SELECTED_OUTLINE_COLOR, false, SELECTED_OUTLINE_WIDTH)

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
		return Vector2i(-1, -1)

	if not sim_root.has_method("get_debug_hovered_cell_index"):
		return Vector2i(-1, -1)

	var hovered_cell_index_variant: Variant = sim_root.call("get_debug_hovered_cell_index")
	if hovered_cell_index_variant is Vector2i:
		return hovered_cell_index_variant

	return Vector2i(-1, -1)

func _get_selected_cell_index() -> Vector2i:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return Vector2i(-1, -1)

	if not sim_root.has_method("get_debug_selected_cell_index"):
		return Vector2i(-1, -1)

	var selected_cell_index_variant: Variant = sim_root.call("get_debug_selected_cell_index")
	if selected_cell_index_variant is Vector2i:
		return selected_cell_index_variant

	return Vector2i(-1, -1)

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")
