extends Camera2D
class_name WorldCameraController

# These zoom levels are chosen so a 32 px cell stays on clean sizes:
# 1.50	-> 48 px
# 1.25  -> 40 px
# 1.00  -> 32 px
# 0.875 -> 28 px
# 0.75  -> 24 px
# 0.625 -> 20 px
# 0.50  -> 16 px
# 0.375	-> 12 px
# 0.250 -> 8 px
# 0.125 -> 4 px

const ZOOM_LEVELS: Array[float] = [1.50, 1.25, 1.0, 0.875, 0.75, 0.625, 0.5, 0.375, 0.25, 0.125]
const DEFAULT_ZOOM_LEVEL_INDEX: int = 4

const KEYBOARD_PAN_SPEED_PIXELS_PER_SECOND: float = 1200.0

var _is_drag_panning: bool = false
var _did_auto_center_on_world: bool = false
var _current_zoom_level_index: int = DEFAULT_ZOOM_LEVEL_INDEX

func _ready() -> void:
	enabled = true
	position_smoothing_enabled = false
	_apply_zoom_level_from_index(DEFAULT_ZOOM_LEVEL_INDEX)
	make_current()
	set_process(true)
	set_process_unhandled_input(true)

func _process(delta: float) -> void:
	if not _did_auto_center_on_world:
		var world_rect: Rect2 = _get_world_rect()
		if world_rect.size.x > 0.0 and world_rect.size.y > 0.0:
			_snap_to_world_center()
			_did_auto_center_on_world = true

	_process_keyboard_pan(delta)
	_clamp_position_to_world_bounds()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_button_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_button_event == null:
			return

		if mouse_button_event.button_index == MOUSE_BUTTON_MIDDLE:
			_is_drag_panning = mouse_button_event.pressed
			get_viewport().set_input_as_handled()
			return

		if not mouse_button_event.pressed:
			return

		# Inverted wheel:
		# wheel up = zoom out
		# wheel down = zoom in
		if mouse_button_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_apply_zoom_step(false)
			get_viewport().set_input_as_handled()
			return

		if mouse_button_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_apply_zoom_step(true)
			get_viewport().set_input_as_handled()
			return

	if event is InputEventMouseMotion:
		if not _is_drag_panning:
			return

		var mouse_motion_event: InputEventMouseMotion = event as InputEventMouseMotion
		if mouse_motion_event == null:
			return

		var zoom_scalar: float = _get_zoom_scalar()
		position -= mouse_motion_event.relative * zoom_scalar
		_clamp_position_to_world_bounds()
		get_viewport().set_input_as_handled()

func get_zoom_band_id() -> String:
	if _current_zoom_level_index <= 1:
		return "close"

	if _current_zoom_level_index <= 3:
		return "mid"

	return "far"

func get_camera_debug_snapshot() -> Dictionary:
	var center_cell_index: Vector2i = Vector2i(-1, -1)
	var sim_root: Node = _sim_root()

	if sim_root != null and sim_root.has_method("get_world_cell_index_at_world_position"):
		center_cell_index = sim_root.call("get_world_cell_index_at_world_position", position)

	return {
		"zoom_scalar": _get_zoom_scalar(),
		"zoom_band_id": get_zoom_band_id(),
		"zoom_level_index": _current_zoom_level_index,
		"center_world_position": position,
		"center_cell_index": center_cell_index,
		"is_drag_panning": _is_drag_panning,
	}

func _process_keyboard_pan(delta: float) -> void:
	var input_vector: Vector2 = Vector2.ZERO

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		input_vector.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		input_vector.x += 1.0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		input_vector.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		input_vector.y += 1.0

	if input_vector == Vector2.ZERO:
		return

	var normalized_input: Vector2 = input_vector.normalized()
	var zoom_scalar: float = _get_zoom_scalar()
	position += normalized_input * KEYBOARD_PAN_SPEED_PIXELS_PER_SECOND * zoom_scalar * delta
	_clamp_position_to_world_bounds()

func _apply_zoom_step(zoom_in: bool) -> void:
	var next_zoom_level_index: int = _current_zoom_level_index

	if zoom_in:
		next_zoom_level_index = mini(_current_zoom_level_index + 1, ZOOM_LEVELS.size() - 1)
	else:
		next_zoom_level_index = maxi(_current_zoom_level_index - 1, 0)

	if next_zoom_level_index == _current_zoom_level_index:
		return

	_apply_zoom_level_from_index(next_zoom_level_index)

func _apply_zoom_level_from_index(zoom_level_index: int) -> void:
	_current_zoom_level_index = clampi(zoom_level_index, 0, ZOOM_LEVELS.size() - 1)

	var zoom_scalar: float = ZOOM_LEVELS[_current_zoom_level_index]
	zoom = Vector2(zoom_scalar, zoom_scalar)
	_clamp_position_to_world_bounds()

func _snap_to_world_center() -> void:
	var world_rect: Rect2 = _get_world_rect()
	if world_rect.size.x <= 0.0 or world_rect.size.y <= 0.0:
		return

	position = world_rect.get_center().round()
	_clamp_position_to_world_bounds()

func _clamp_position_to_world_bounds() -> void:
	var world_rect: Rect2 = _get_world_rect()
	if world_rect.size.x <= 0.0 or world_rect.size.y <= 0.0:
		return

	var viewport_rect: Rect2 = get_viewport().get_visible_rect()
	if viewport_rect.size.x <= 0.0 or viewport_rect.size.y <= 0.0:
		return

	var visible_world_size: Vector2 = viewport_rect.size * _get_zoom_scalar()
	var half_visible_world_size: Vector2 = visible_world_size * 0.5
	var clamped_position: Vector2 = position

	if visible_world_size.x >= world_rect.size.x:
		clamped_position.x = world_rect.get_center().x
	else:
		clamped_position.x = clampf(
			position.x,
			world_rect.position.x + half_visible_world_size.x,
			world_rect.end.x - half_visible_world_size.x
		)

	if visible_world_size.y >= world_rect.size.y:
		clamped_position.y = world_rect.get_center().y
	else:
		clamped_position.y = clampf(
			position.y,
			world_rect.position.y + half_visible_world_size.y,
			world_rect.end.y - half_visible_world_size.y
		)

	# Snap camera position to whole pixels to avoid soft subpixel presentation.
	position = clamped_position.round()

func _get_zoom_scalar() -> float:
	return maxf(zoom.x, 0.001)

func _get_world_rect() -> Rect2:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return Rect2()

	if not sim_root.has_method("get_world_state"):
		return Rect2()

	var world_state: WorldState = sim_root.call("get_world_state") as WorldState
	if world_state == null:
		return Rect2()

	var world_width_pixels: float = float(world_state.world_width_cells * world_state.cell_size_pixels)
	var world_height_pixels: float = float(world_state.world_height_cells * world_state.cell_size_pixels)

	return Rect2(
		Vector2.ZERO,
		Vector2(world_width_pixels, world_height_pixels)
	)

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")
