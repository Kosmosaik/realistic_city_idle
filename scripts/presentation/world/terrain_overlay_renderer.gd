extends Node2D
class_name TerrainOverlayRenderer

const PATCH_BOUNDARY_COLOR: Color = Color(1.0, 1.0, 1.0, 0.75)
const OUTLINE_WIDTH: float = 2.0

var _last_world_id: String = ""
var _last_overlay_mode_id: String = "off"
var _last_force_full_visibility_enabled: bool = false

var _cached_elevation_bounds_world_id: String = ""
var _cached_elevation_bounds: Dictionary = {}

func _ready() -> void:
	set_process(true)
	set_process_unhandled_input(true)
	queue_redraw()

func _process(_delta: float) -> void:
	var current_world_id: String = _get_current_world_id()
	var current_overlay_mode_id: String = _get_current_overlay_mode_id()
	var current_force_full_visibility_enabled: bool = _is_debug_force_full_visibility_enabled()

	var needs_redraw: bool = false

	if current_world_id != _last_world_id:
		_last_world_id = current_world_id
		_clear_overlay_caches()
		needs_redraw = true

	if current_overlay_mode_id != _last_overlay_mode_id:
		_last_overlay_mode_id = current_overlay_mode_id
		needs_redraw = true

	if current_force_full_visibility_enabled != _last_force_full_visibility_enabled:
		_last_force_full_visibility_enabled = current_force_full_visibility_enabled
		needs_redraw = true

	if needs_redraw:
		queue_redraw()

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

	var sim_root: Node = _sim_root()
	if sim_root == null:
		return

	if key_event.keycode == KEY_O:
		var direction: int = 1
		if key_event.shift_pressed:
			direction = -1

		if sim_root.has_method("cycle_debug_overlay_mode"):
			sim_root.call("cycle_debug_overlay_mode", direction)
			queue_redraw()
			get_viewport().set_input_as_handled()
		return

	if key_event.keycode == KEY_F6:
		if sim_root.has_method("toggle_debug_force_full_visibility_enabled"):
			sim_root.call("toggle_debug_force_full_visibility_enabled")
			queue_redraw()
			get_viewport().set_input_as_handled()
		return

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

	var overlay_mode_id: String = _get_current_overlay_mode_id()
	if overlay_mode_id == "off":
		return

	match overlay_mode_id:
		"elevation":
			_draw_elevation_overlay(world_state)
		"drainage":
			_draw_drainage_overlay(world_state)
		"wetness":
			_draw_wetness_overlay(world_state)
		"vegetation":
			_draw_vegetation_overlay(world_state)
		"buildability":
			_draw_buildability_overlay(world_state)
		"site_score":
			_draw_site_score_overlay(world_state)
		"patch_boundaries":
			_draw_patch_boundary_overlay(world_state)
		"fog_memory":
			_draw_fog_memory_overlay(world_state)
		_:
			pass

func _draw_elevation_overlay(world_state: WorldState) -> void:
	var elevation_bounds: Dictionary = _get_elevation_bounds(world_state)
	var min_elevation_step: int = int(elevation_bounds.get("min_elevation_step", 0))
	var max_elevation_step: int = int(elevation_bounds.get("max_elevation_step", 0))

	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var normalized_value: float = _normalize_scalar(
				float(cell_state.elevation_step),
				float(min_elevation_step),
				float(max_elevation_step)
			)

			var overlay_color: Color = _lerp_color(
				Color(0.10, 0.20, 0.32, 0.32),
				Color(0.78, 0.60, 0.30, 0.55),
				normalized_value
			)

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _draw_drainage_overlay(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var drainage_class: String = cell_state.drainage_class
			var overlay_color: Color = Color(0.40, 0.40, 0.40, 0.18)

			match drainage_class:
				"poor":
					overlay_color = Color(0.95, 0.35, 0.20, 0.45)
				"moderate":
					overlay_color = Color(0.92, 0.75, 0.20, 0.38)
				"good":
					overlay_color = Color(0.20, 0.78, 0.52, 0.34)
				_:
					overlay_color = Color(0.50, 0.50, 0.50, 0.18)

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _draw_wetness_overlay(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var wetness_tendency: String = cell_state.wetness_tendency
			var overlay_color: Color = Color(0.45, 0.45, 0.45, 0.16)

			match wetness_tendency:
				"dry":
					overlay_color = Color(0.90, 0.78, 0.42, 0.30)
				"damp":
					overlay_color = Color(0.38, 0.74, 0.58, 0.30)
				"wet":
					overlay_color = Color(0.22, 0.55, 0.95, 0.42)
				_:
					overlay_color = Color(0.55, 0.55, 0.55, 0.16)

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _draw_vegetation_overlay(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var vegetation_cover_class: String = cell_state.vegetation_cover_class
			var overlay_color: Color = Color(0.40, 0.60, 0.40, 0.18)

			match vegetation_cover_class:
				"none":
					overlay_color = Color(0.65, 0.60, 0.48, 0.16)
				"sparse":
					overlay_color = Color(0.62, 0.76, 0.42, 0.22)
				"grass":
					overlay_color = Color(0.42, 0.82, 0.32, 0.28)
				"brush":
					overlay_color = Color(0.24, 0.60, 0.24, 0.34)
				"woodland":
					overlay_color = Color(0.14, 0.42, 0.18, 0.40)
				_:
					overlay_color = Color(0.30, 0.70, 0.30, 0.22)

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _draw_buildability_overlay(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var overlay_color: Color = Color(0.85, 0.20, 0.20, 0.30)
			if cell_state.is_buildable:
				overlay_color = Color(0.18, 0.78, 0.32, 0.28)

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _draw_site_score_overlay(world_state: WorldState) -> void:
	for patch_state: WorldPatchState in world_state.get_all_patches():
		if patch_state.site_score <= 0.0:
			continue

		var normalized_site_score: float = _normalize_site_score(patch_state.site_score)
		var overlay_color: Color = _resolve_site_score_fill_color(normalized_site_score)
		var patch_cell_indices: Array[Vector2i] = _get_patch_overlay_cell_indices(
			world_state,
			patch_state
		)

		for cell_index: Vector2i in patch_cell_indices:
			var cell_rect: Rect2 = world_state.get_cell_rect_world(cell_index)
			draw_rect(cell_rect, overlay_color, true)

func _draw_patch_boundary_overlay(world_state: WorldState) -> void:
	for patch_state: WorldPatchState in world_state.get_all_patches():
		var normalized_site_score: float = _normalize_site_score(patch_state.site_score)
		var boundary_color: Color = _resolve_site_score_outline_color(normalized_site_score)

		if patch_state.site_score <= 0.0:
			boundary_color = _resolve_patch_outline_color(patch_state)

		_draw_patch_footprint_outline(world_state, patch_state, boundary_color)

func _draw_fog_memory_overlay(world_state: WorldState) -> void:
	if _is_debug_force_full_visibility_enabled():
		return

	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var overlay_color: Color = _resolve_fog_memory_overlay_color(cell_state)
			if overlay_color.a <= 0.0:
				continue

			draw_rect(world_state.cell_index_to_world_rect(cell_index), overlay_color, true)

func _get_elevation_bounds(world_state: WorldState) -> Dictionary:
	if _cached_elevation_bounds_world_id == world_state.world_id and not _cached_elevation_bounds.is_empty():
		return _cached_elevation_bounds

	var bounds: Dictionary = _find_elevation_bounds(world_state)
	_cached_elevation_bounds_world_id = world_state.world_id
	_cached_elevation_bounds = bounds
	return bounds

func _find_elevation_bounds(world_state: WorldState) -> Dictionary:
	var has_value: bool = false
	var min_elevation_step: int = 0
	var max_elevation_step: int = 0

	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			if not has_value:
				min_elevation_step = cell_state.elevation_step
				max_elevation_step = cell_state.elevation_step
				has_value = true
				continue

			min_elevation_step = mini(min_elevation_step, cell_state.elevation_step)
			max_elevation_step = maxi(max_elevation_step, cell_state.elevation_step)

	return {
		"min_elevation_step": min_elevation_step,
		"max_elevation_step": max_elevation_step,
	}

func _get_patch_overlay_cell_indices(
	world_state: WorldState,
	patch_state: WorldPatchState
) -> Array[Vector2i]:
	var patch_cell_indices: Array[Vector2i] = []

	if not patch_state.cell_indices.is_empty():
		for cell_index: Vector2i in patch_state.cell_indices:
			if world_state.is_cell_index_in_bounds(cell_index):
				patch_cell_indices.append(cell_index)

		if not patch_cell_indices.is_empty():
			return patch_cell_indices

	var start_x: int = patch_state.rect_position.x
	var start_y: int = patch_state.rect_position.y
	var end_x: int = patch_state.rect_position.x + patch_state.rect_size.x
	var end_y: int = patch_state.rect_position.y + patch_state.rect_size.y

	for y: int in range(start_y, end_y):
		for x: int in range(start_x, end_x):
			var cell_index := Vector2i(x, y)
			if world_state.is_cell_index_in_bounds(cell_index):
				patch_cell_indices.append(cell_index)

	return patch_cell_indices


func _draw_patch_footprint_outline(
	world_state: WorldState,
	patch_state: WorldPatchState,
	boundary_color: Color
) -> void:
	var patch_cell_indices: Array[Vector2i] = _get_patch_overlay_cell_indices(world_state, patch_state)
	if patch_cell_indices.is_empty():
		return

	var cell_lookup: Dictionary = {}
	for cell_index: Vector2i in patch_cell_indices:
		cell_lookup[_build_patch_cell_lookup_key(cell_index)] = true

	for cell_index: Vector2i in patch_cell_indices:
		var cell_rect: Rect2 = world_state.get_cell_rect_world(cell_index)
		var top_left: Vector2 = cell_rect.position
		var top_right: Vector2 = Vector2(cell_rect.position.x + cell_rect.size.x, cell_rect.position.y)
		var bottom_left: Vector2 = Vector2(cell_rect.position.x, cell_rect.position.y + cell_rect.size.y)
		var bottom_right: Vector2 = cell_rect.position + cell_rect.size

		var north_key: String = _build_patch_cell_lookup_key(cell_index + Vector2i(0, -1))
		var south_key: String = _build_patch_cell_lookup_key(cell_index + Vector2i(0, 1))
		var west_key: String = _build_patch_cell_lookup_key(cell_index + Vector2i(-1, 0))
		var east_key: String = _build_patch_cell_lookup_key(cell_index + Vector2i(1, 0))

		if not cell_lookup.has(north_key):
			draw_line(top_left, top_right, boundary_color, 1.0)
		if not cell_lookup.has(south_key):
			draw_line(bottom_left, bottom_right, boundary_color, 1.0)
		if not cell_lookup.has(west_key):
			draw_line(top_left, bottom_left, boundary_color, 1.0)
		if not cell_lookup.has(east_key):
			draw_line(top_right, bottom_right, boundary_color, 1.0)


func _build_patch_cell_lookup_key(cell_index: Vector2i) -> String:
	return "%s,%s" % [cell_index.x, cell_index.y]

func _normalize_site_score(site_score: float) -> float:
	if site_score <= 0.0:
		return 0.0

	# Older/debug values may already be normalized.
	if site_score <= 1.0:
		return clamp(site_score, 0.0, 1.0)

	# Current patch scoring uses a 0..100 scale.
	return clamp(site_score / 100.0, 0.0, 1.0)

func _resolve_site_score_fill_color(normalized_site_score: float) -> Color:
	var clamped_score: float = clamp(normalized_site_score, 0.0, 1.0)

	var low_color: Color = Color(0.84, 0.30, 0.20, 0.26)
	var mid_color: Color = Color(0.95, 0.74, 0.24, 0.24)
	var high_color: Color = Color(0.24, 0.78, 0.40, 0.24)

	if clamped_score <= 0.5:
		return _lerp_color(low_color, mid_color, clamped_score / 0.5)

	return _lerp_color(mid_color, high_color, (clamped_score - 0.5) / 0.5)

func _resolve_site_score_outline_color(normalized_site_score: float) -> Color:
	var clamped_score: float = clamp(normalized_site_score, 0.0, 1.0)

	var low_color: Color = Color(0.92, 0.32, 0.24, 0.60)
	var mid_color: Color = Color(1.0, 0.82, 0.28, 0.58)
	var high_color: Color = Color(0.32, 0.92, 0.48, 0.60)

	if clamped_score <= 0.5:
		return _lerp_color(low_color, mid_color, clamped_score / 0.5)

	return _lerp_color(mid_color, high_color, (clamped_score - 0.5) / 0.5)

func _resolve_patch_outline_color(patch_state: WorldPatchState) -> Color:
	if patch_state.surface_water_type != "none":
		return Color(0.28, 0.68, 1.0, 0.85)

	if patch_state.is_buildable:
		return Color(0.40, 1.0, 0.55, 0.85)

	return PATCH_BOUNDARY_COLOR

func _resolve_fog_memory_overlay_color(cell_state: WorldCellState) -> Color:
	# Visible cells stay almost clear so terrain remains readable.
	if cell_state.is_currently_visible:
		return Color(0.85, 1.0, 0.90, 0.06)

	# Remembered but not currently visible cells get a muted cool tint.
	if cell_state.is_revealed:
		return Color(0.40, 0.52, 0.78, 0.24)

	# Fully hidden cells get a darker obscuring tint.
	return Color(0.03, 0.04, 0.06, 0.56)

func _normalize_scalar(value: float, min_value: float, max_value: float) -> float:
	if max_value <= min_value:
		return 0.0

	return clamp((value - min_value) / (max_value - min_value), 0.0, 1.0)

func _lerp_color(color_a: Color, color_b: Color, weight: float) -> Color:
	return Color(
		lerpf(color_a.r, color_b.r, weight),
		lerpf(color_a.g, color_b.g, weight),
		lerpf(color_a.b, color_b.b, weight),
		lerpf(color_a.a, color_b.a, weight)
	)

func _clear_overlay_caches() -> void:
	_cached_elevation_bounds_world_id = ""
	_cached_elevation_bounds = {}

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

func _get_current_overlay_mode_id() -> String:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return "off"

	if not sim_root.has_method("get_debug_overlay_mode_id"):
		return "off"

	return str(sim_root.call("get_debug_overlay_mode_id"))
	
func _is_debug_force_full_visibility_enabled() -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return false

	if not sim_root.has_method("is_debug_force_full_visibility_enabled"):
		return false

	return bool(sim_root.call("is_debug_force_full_visibility_enabled"))

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")
