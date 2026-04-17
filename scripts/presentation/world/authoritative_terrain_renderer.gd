extends Node2D
class_name AuthoritativeTerrainRenderer

const COLOR_OPEN_GROUND: Color = Color8(86, 97, 75)
const COLOR_OPEN_GROUND_LIGHT: Color = Color8(101, 113, 88)
const COLOR_DRY_GROUND: Color = Color8(112, 104, 83)
const COLOR_WET_GROUND: Color = Color8(71, 92, 82)
const COLOR_MARSH_GROUND: Color = Color8(62, 87, 82)
const COLOR_STONY_GROUND: Color = Color8(116, 108, 95)

const COLOR_WATER_EDGE: Color = Color8(94, 129, 145)
const COLOR_WATER_FILL: Color = Color8(70, 102, 124)
const COLOR_WATER_DEEP: Color = Color8(52, 79, 101)

const COLOR_CANOPY_WOODLAND: Color = Color8(49, 69, 49)
const COLOR_CANOPY_WOODLAND_DARK: Color = Color8(38, 54, 38)
const COLOR_CANOPY_BRUSH: Color = Color8(67, 87, 59)
const COLOR_CANOPY_BRUSH_DARK: Color = Color8(53, 71, 48)

const COLOR_FEATURE_TREE: Color = Color8(63, 84, 56)
const COLOR_FEATURE_TREE_DARK: Color = Color8(45, 60, 40)
const COLOR_FEATURE_REED: Color = Color8(132, 136, 89)
const COLOR_FEATURE_REED_DARK: Color = Color8(96, 101, 65)
const COLOR_FEATURE_STONE: Color = Color8(126, 118, 108)
const COLOR_FEATURE_STONE_DARK: Color = Color8(95, 89, 82)
const COLOR_FEATURE_INVALID: Color = Color8(196, 92, 78)
const COLOR_FEATURE_INVALID_DARK: Color = Color8(132, 58, 48)

const COLOR_SITE_HINT: Color = Color8(201, 182, 129)
const COLOR_BORDER: Color = Color(0.0, 0.0, 0.0, 0.42)

const SITE_HINT_RADIUS_OUTER: float = 18.0
const SITE_HINT_RADIUS_INNER: float = 5.0
const SITE_HINT_LINE_HALF_LENGTH: float = 8.0

const WATER_INSET_PIXELS: float = 4.0
const CELL_SURFACE_VARIATION_ALPHA: float = 0.035
const CELL_WET_FRINGE_ALPHA: float = 0.12
const HILLSHADE_MAX_ALPHA: float = 0.10

var _last_render_signature: String = ""

func _ready() -> void:
	set_process(true)
	set_process_unhandled_input(true)
	queue_redraw()

func _process(_delta: float) -> void:
	var next_signature: String = _build_render_signature()
	if next_signature == _last_render_signature:
		return

	_last_render_signature = next_signature
	queue_redraw()
	
func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey):
		return

	var key_event: InputEventKey = event as InputEventKey
	if key_event == null:
		return

	if not key_event.pressed or key_event.echo:
		return

	if key_event.keycode != KEY_F5:
		return

	var sim_root: Node = _sim_root()
	if sim_root != null and sim_root.has_method("toggle_debug_site_hints_visible"):
		sim_root.call("toggle_debug_site_hints_visible")
		get_viewport().set_input_as_handled()

func _draw() -> void:
	var world_state: WorldState = _get_world_state()
	if world_state == null:
		return

	_draw_ground_pass(world_state)
	_draw_surface_variation_pass(world_state)
	_draw_water_pass(world_state)
	_draw_canopy_pass(world_state)
	_draw_authored_feature_pass(world_state)
	_draw_hillshade_pass(world_state)

	if _is_site_hint_debug_visible():
		_draw_site_hint_pass(world_state)

	_draw_world_border(world_state)

func _draw_ground_pass(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
			var ground_color: Color = _resolve_ground_color(cell_state)
			draw_rect(cell_rect, ground_color, true)

func _draw_surface_variation_pass(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			if cell_state.surface_water_type != "none":
				continue

			var variation_value: float = _hash_01(cell_index, 17) - 0.5
			var variation_alpha: float = absf(variation_value) * CELL_SURFACE_VARIATION_ALPHA

			var variation_color: Color
			if variation_value >= 0.0:
				variation_color = Color(1.0, 1.0, 1.0, variation_alpha)
			else:
				variation_color = Color(0.0, 0.0, 0.0, variation_alpha)

			var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
			draw_rect(cell_rect, variation_color, true)

func _draw_water_pass(world_state: WorldState) -> void:
	var fixed_zoom_band_id: String = "mid"
	var cell_keys: PackedStringArray = world_state.get_all_cell_keys()

	for cell_key: String in cell_keys:
		var cell_state: WorldCellState = world_state.get_cell_by_key(cell_key)
		if cell_state == null:
			continue

		var cell_index: Vector2i = cell_state.cell_index

		if cell_state.surface_water_type != "none":
			_draw_surface_water_cell(world_state, cell_index, cell_state, fixed_zoom_band_id)
			continue

		_draw_moisture_fringe_for_land_cell(world_state, cell_index, cell_state, fixed_zoom_band_id)
		
func _draw_surface_water_cell(
	world_state: WorldState,
	cell_index: Vector2i,
	cell_state: WorldCellState,
	zoom_band_id: String
) -> void:
	var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)

	var exposed_left: bool = not _is_surface_water_cell(world_state, cell_index + Vector2i(-1, 0))
	var exposed_right: bool = not _is_surface_water_cell(world_state, cell_index + Vector2i(1, 0))
	var exposed_top: bool = not _is_surface_water_cell(world_state, cell_index + Vector2i(0, -1))
	var exposed_bottom: bool = not _is_surface_water_cell(world_state, cell_index + Vector2i(0, 1))

	var fill_color: Color = _resolve_water_fill_color(cell_state.surface_water_type, zoom_band_id)
	draw_rect(cell_rect, fill_color, true)

	var core_inset_pixels: float = _resolve_water_core_inset_pixels(cell_state.surface_water_type, zoom_band_id)
	var core_rect: Rect2 = _build_directional_inset_rect(
		cell_rect,
		core_inset_pixels if exposed_left else 0.0,
		core_inset_pixels if exposed_top else 0.0,
		core_inset_pixels if exposed_right else 0.0,
		core_inset_pixels if exposed_bottom else 0.0
	)

	if core_rect.size.x > 0.0 and core_rect.size.y > 0.0:
		var core_color: Color = _resolve_water_core_color(cell_state.surface_water_type, zoom_band_id)
		draw_rect(core_rect, core_color, true)

		if _is_linear_surface_water_type(cell_state.surface_water_type):
			var stripe_rect: Rect2 = core_rect
			var stripe_thickness: float = 4.0

			match zoom_band_id:
				"far":
					stripe_thickness = 8.0
				"mid":
					stripe_thickness = 5.0
				"close":
					stripe_thickness = 4.0

			var flow_axis: String = _resolve_linear_water_axis(world_state, cell_index)

			if flow_axis == "horizontal":
				stripe_rect.position.y = core_rect.get_center().y - (stripe_thickness * 0.5)
				stripe_rect.size.y = minf(core_rect.size.y, stripe_thickness)
			else:
				stripe_rect.position.x = core_rect.get_center().x - (stripe_thickness * 0.5)
				stripe_rect.size.x = minf(core_rect.size.x, stripe_thickness)

			if stripe_rect.size.x > 0.0 and stripe_rect.size.y > 0.0:
				draw_rect(
					stripe_rect,
					Color(COLOR_WATER_DEEP.r, COLOR_WATER_DEEP.g, COLOR_WATER_DEEP.b, 0.30),
					true
				)

	var shore_thickness_pixels: float = _resolve_shoreline_thickness_pixels(zoom_band_id)
	var shore_color: Color = Color(COLOR_WATER_EDGE.r, COLOR_WATER_EDGE.g, COLOR_WATER_EDGE.b, 0.50)

	if exposed_left:
		draw_rect(
			Rect2(cell_rect.position, Vector2(shore_thickness_pixels, cell_rect.size.y)),
			shore_color,
			true
		)

	if exposed_right:
		draw_rect(
			Rect2(
				Vector2(cell_rect.end.x - shore_thickness_pixels, cell_rect.position.y),
				Vector2(shore_thickness_pixels, cell_rect.size.y)
			),
			shore_color,
			true
		)

	if exposed_top:
		draw_rect(
			Rect2(cell_rect.position, Vector2(cell_rect.size.x, shore_thickness_pixels)),
			shore_color,
			true
		)

	if exposed_bottom:
		draw_rect(
			Rect2(
				Vector2(cell_rect.position.x, cell_rect.end.y - shore_thickness_pixels),
				Vector2(cell_rect.size.x, shore_thickness_pixels)
			),
			shore_color,
			true
		)

func _draw_moisture_fringe_for_land_cell(
	world_state: WorldState,
	cell_index: Vector2i,
	cell_state: WorldCellState,
	zoom_band_id: String
) -> void:
	var adjacent_water_count: int = _count_adjacent_surface_water_cells(world_state, cell_index)
	var fringe_alpha: float = 0.0

	if adjacent_water_count > 0:
		fringe_alpha += float(adjacent_water_count) * 0.035

	match cell_state.wetness_tendency:
		"damp":
			fringe_alpha += 0.035
		"wet":
			fringe_alpha += 0.080
		_:
			pass

	if cell_state.vegetation_cover_class == "wetland":
		fringe_alpha += 0.060

	match zoom_band_id:
		"far":
			fringe_alpha *= 1.18
		"close":
			fringe_alpha *= 0.92
		_:
			pass

	fringe_alpha = clampf(fringe_alpha, 0.0, 0.22)

	if fringe_alpha <= 0.0:
		return

	var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
	var fringe_color: Color = Color(COLOR_WATER_EDGE.r, COLOR_WATER_EDGE.g, COLOR_WATER_EDGE.b, fringe_alpha)
	draw_rect(cell_rect, fringe_color, true)

func _resolve_water_fill_color(surface_water_type: String, zoom_band_id: String) -> Color:
	var fill_color: Color = COLOR_WATER_FILL

	match surface_water_type:
		"pond", "lake":
			fill_color = COLOR_WATER_FILL.lerp(COLOR_WATER_DEEP, 0.22)
		"river":
			fill_color = COLOR_WATER_FILL.lerp(COLOR_WATER_DEEP, 0.28)
		"spring", "seep":
			fill_color = COLOR_WATER_EDGE.lerp(COLOR_WATER_FILL, 0.35)
		_:
			fill_color = COLOR_WATER_FILL

	match zoom_band_id:
		"far":
			fill_color = fill_color.lerp(COLOR_WATER_EDGE, 0.16)
		"close":
			fill_color = fill_color.lerp(COLOR_WATER_DEEP, 0.08)
		_:
			pass

	return fill_color

func _resolve_water_core_color(surface_water_type: String, zoom_band_id: String) -> Color:
	var core_color: Color = COLOR_WATER_DEEP
	var alpha_value: float = 0.42

	match surface_water_type:
		"spring", "seep":
			core_color = COLOR_WATER_FILL.lerp(COLOR_WATER_DEEP, 0.30)
		"pond", "lake":
			core_color = COLOR_WATER_DEEP
		"river":
			core_color = COLOR_WATER_DEEP.lerp(Color.BLACK, 0.06)
		_:
			core_color = COLOR_WATER_DEEP

	match zoom_band_id:
		"far":
			alpha_value = 0.34
		"mid":
			alpha_value = 0.42
		"close":
			alpha_value = 0.48

	return Color(core_color.r, core_color.g, core_color.b, alpha_value)

func _resolve_water_core_inset_pixels(surface_water_type: String, zoom_band_id: String) -> float:
	var inset_pixels: float = 5.0

	match surface_water_type:
		"pond", "lake":
			inset_pixels = 4.0
		"spring", "seep":
			inset_pixels = 7.0
		_:
			inset_pixels = 5.0

	match zoom_band_id:
		"far":
			inset_pixels += 2.0
		"close":
			inset_pixels -= 1.0
		_:
			pass

	return maxf(inset_pixels, 2.0)

func _resolve_shoreline_thickness_pixels(zoom_band_id: String) -> float:
	match zoom_band_id:
		"far":
			return 3.0
		"mid":
			return 2.0
		"close":
			return 2.0
		_:
			return 2.0

func _build_directional_inset_rect(
	source_rect: Rect2,
	left_inset: float,
	top_inset: float,
	right_inset: float,
	bottom_inset: float
) -> Rect2:
	var inset_position: Vector2 = source_rect.position + Vector2(left_inset, top_inset)
	var inset_size: Vector2 = source_rect.size - Vector2(
		left_inset + right_inset,
		top_inset + bottom_inset
	)

	if inset_size.x <= 0.0 or inset_size.y <= 0.0:
		return Rect2(inset_position, Vector2.ZERO)

	return Rect2(inset_position, inset_size)

func _count_adjacent_surface_water_cells(world_state: WorldState, cell_index: Vector2i) -> int:
	var adjacent_count: int = 0

	if _is_surface_water_cell(world_state, cell_index + Vector2i(-1, 0)):
		adjacent_count += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(1, 0)):
		adjacent_count += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(0, -1)):
		adjacent_count += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(0, 1)):
		adjacent_count += 1

	return adjacent_count

func _is_surface_water_cell(world_state: WorldState, cell_index: Vector2i) -> bool:
	if not world_state.is_cell_index_in_bounds(cell_index):
		return false

	var neighbor_cell: WorldCellState = world_state.get_cell(cell_index)
	if neighbor_cell == null:
		return false

	return neighbor_cell.surface_water_type != "none"

func _resolve_linear_water_axis(world_state: WorldState, cell_index: Vector2i) -> String:
	var horizontal_connections: int = 0
	var vertical_connections: int = 0

	if _is_surface_water_cell(world_state, cell_index + Vector2i(-1, 0)):
		horizontal_connections += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(1, 0)):
		horizontal_connections += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(0, -1)):
		vertical_connections += 1
	if _is_surface_water_cell(world_state, cell_index + Vector2i(0, 1)):
		vertical_connections += 1

	if horizontal_connections > vertical_connections:
		return "horizontal"

	if vertical_connections > horizontal_connections:
		return "vertical"

	if horizontal_connections > 0:
		return "horizontal"

	return "vertical"

func _is_linear_surface_water_type(surface_water_type: String) -> bool:
	match surface_water_type:
		"channel", "stream", "river", "spring", "seep":
			return true
		_:
			return false

func _is_site_hint_debug_visible() -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return false

	if sim_root.has_method("is_debug_site_hints_visible"):
		return bool(sim_root.call("is_debug_site_hints_visible"))

	return false
	
func _is_debug_force_full_visibility_enabled() -> bool:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return false

	if sim_root.has_method("is_debug_force_full_visibility_enabled"):
		return bool(sim_root.call("is_debug_force_full_visibility_enabled"))

	return false
		
func _draw_canopy_pass(world_state: WorldState) -> void:
	var patch_states: Array[WorldPatchState] = world_state.get_all_patches()

	for patch_state: WorldPatchState in patch_states:
		if not _should_draw_canopy_for_patch(patch_state):
			continue

		var patch_footprint_cell_indices: Array[Vector2i] = _resolve_patch_footprint_cell_indices(
			world_state,
			patch_state
		)
		if patch_footprint_cell_indices.is_empty():
			continue

		var canopy_count: int = _resolve_canopy_count_for_patch(patch_state)
		if canopy_count <= 0:
			continue

		for canopy_index: int in range(canopy_count):
			var canopy_center: Vector2 = _resolve_patch_canopy_center(
				world_state,
				patch_state,
				patch_footprint_cell_indices,
				canopy_index,
				canopy_count
			)
			var canopy_radius: float = _resolve_patch_canopy_radius(
				patch_state,
				canopy_index
			)
			var canopy_color: Color = _resolve_patch_canopy_color(
				patch_state,
				canopy_index
			)

			draw_circle(canopy_center, canopy_radius, canopy_color)

func _draw_authored_feature_pass(world_state: WorldState) -> void:
	var zoom_band_id: String = _get_zoom_band_id()
	var terrain_objects: Array[Dictionary] = world_state.get_all_authored_terrain_objects()
	var force_full_visibility_enabled: bool = _is_debug_force_full_visibility_enabled()

	for object_entry: Dictionary in terrain_objects:
		var cell_index_variant: Variant = object_entry.get("cell_index", null)
		if not (cell_index_variant is Vector2i):
			continue

		var cell_index: Vector2i = cell_index_variant
		var cell_state: WorldCellState = world_state.get_cell(cell_index)
		if cell_state == null:
			continue

		# Normal mode respects reveal state.
		# Debug full-visibility mode lets us inspect all authored placements.
		if not force_full_visibility_enabled and not cell_state.is_revealed:
			continue

		var cell_rect: Rect2 = world_state.get_cell_rect_world(cell_index)
		var visibility_alpha: float = _resolve_feature_visibility_alpha(cell_state)
		var placement_family: String = str(object_entry.get("placement_family", "")).strip_edges()

		match placement_family:
			"tree":
				_draw_tree_feature_object(cell_rect, object_entry, zoom_band_id, visibility_alpha)
			"wet_margin_plant":
				_draw_reed_feature_object(cell_rect, object_entry, zoom_band_id, visibility_alpha)
			"rocky_marker":
				_draw_stone_feature_object(cell_rect, object_entry, zoom_band_id, visibility_alpha)
			_:
				_draw_generic_feature_object(cell_rect, object_entry, visibility_alpha)

func _draw_tree_feature_object(
	cell_rect: Rect2,
	object_entry: Dictionary,
	zoom_band_id: String,
	visibility_alpha: float
) -> void:
	var base_color: Color = _resolve_feature_base_color(object_entry, COLOR_FEATURE_TREE)
	var dark_color: Color = _resolve_feature_dark_color(object_entry, COLOR_FEATURE_TREE_DARK)

	base_color = _with_multiplied_alpha(base_color, visibility_alpha)
	dark_color = _with_multiplied_alpha(dark_color, visibility_alpha)

	var center: Vector2 = cell_rect.get_center().round()
	var cell_size: float = minf(cell_rect.size.x, cell_rect.size.y)

	match zoom_band_id:
		"far":
			draw_circle(center, cell_size * 0.12, dark_color)
		"mid":
			draw_circle(center + Vector2(-3.0, -2.0), cell_size * 0.14, dark_color)
			draw_circle(center + Vector2(2.0, -1.0), cell_size * 0.16, base_color)
			draw_line(
				center + Vector2(0.0, 3.0),
				center + Vector2(0.0, cell_size * 0.22),
				dark_color,
				2.0,
				false
			)
		_:
			draw_circle(center + Vector2(-4.0, -3.0), cell_size * 0.14, dark_color)
			draw_circle(center + Vector2(0.0, -5.0), cell_size * 0.16, base_color)
			draw_circle(center + Vector2(4.0, -2.0), cell_size * 0.13, dark_color)
			draw_line(
				center + Vector2(0.0, 2.0),
				center + Vector2(0.0, cell_size * 0.26),
				dark_color,
				2.0,
				false
			)

	_draw_invalid_feature_marker_if_needed(cell_rect, object_entry, visibility_alpha)

func _draw_reed_feature_object(
	cell_rect: Rect2,
	object_entry: Dictionary,
	zoom_band_id: String,
	visibility_alpha: float
) -> void:
	var base_color: Color = _resolve_feature_base_color(object_entry, COLOR_FEATURE_REED)
	var dark_color: Color = _resolve_feature_dark_color(object_entry, COLOR_FEATURE_REED_DARK)

	base_color = _with_multiplied_alpha(base_color, visibility_alpha)
	dark_color = _with_multiplied_alpha(dark_color, visibility_alpha)

	var center: Vector2 = cell_rect.get_center().round()
	var base_position: Vector2 = center + Vector2(0.0, 5.0)

	match zoom_band_id:
		"far":
			draw_circle(center, 2.0, dark_color)
		"mid":
			draw_line(base_position, base_position + Vector2(-2.0, -8.0), base_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(0.0, -10.0), dark_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(2.0, -8.0), base_color, 2.0, false)
		_:
			draw_line(base_position, base_position + Vector2(-4.0, -10.0), base_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(-2.0, -12.0), dark_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(0.0, -13.0), base_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(2.0, -11.0), dark_color, 2.0, false)
			draw_line(base_position, base_position + Vector2(4.0, -9.0), base_color, 2.0, false)
			draw_rect(
				Rect2(base_position + Vector2(-4.0, -1.0), Vector2(8.0, 3.0)),
				_with_multiplied_alpha(dark_color, 0.75),
				true
			)

	_draw_invalid_feature_marker_if_needed(cell_rect, object_entry, visibility_alpha)

func _draw_stone_feature_object(
	cell_rect: Rect2,
	object_entry: Dictionary,
	zoom_band_id: String,
	visibility_alpha: float
) -> void:
	var base_color: Color = _resolve_feature_base_color(object_entry, COLOR_FEATURE_STONE)
	var dark_color: Color = _resolve_feature_dark_color(object_entry, COLOR_FEATURE_STONE_DARK)

	base_color = _with_multiplied_alpha(base_color, visibility_alpha)
	dark_color = _with_multiplied_alpha(dark_color, visibility_alpha)

	var center: Vector2 = cell_rect.get_center().round()

	match zoom_band_id:
		"far":
			draw_rect(Rect2(center + Vector2(-2.0, -2.0), Vector2(4.0, 4.0)), dark_color, true)
		"mid":
			draw_rect(Rect2(center + Vector2(-5.0, -1.0), Vector2(5.0, 4.0)), dark_color, true)
			draw_rect(Rect2(center + Vector2(0.0, -4.0), Vector2(5.0, 6.0)), base_color, true)
		_:
			draw_rect(Rect2(center + Vector2(-6.0, -1.0), Vector2(5.0, 4.0)), dark_color, true)
			draw_rect(Rect2(center + Vector2(-1.0, -5.0), Vector2(5.0, 6.0)), base_color, true)
			draw_rect(Rect2(center + Vector2(3.0, -1.0), Vector2(4.0, 4.0)), dark_color, true)

	_draw_invalid_feature_marker_if_needed(cell_rect, object_entry, visibility_alpha)

func _draw_generic_feature_object(
	cell_rect: Rect2,
	object_entry: Dictionary,
	visibility_alpha: float
) -> void:
	var base_color: Color = _resolve_feature_base_color(object_entry, COLOR_FEATURE_STONE)
	base_color = _with_multiplied_alpha(base_color, visibility_alpha)

	var center: Vector2 = cell_rect.get_center().round()
	draw_circle(center, 3.0, base_color)

	_draw_invalid_feature_marker_if_needed(cell_rect, object_entry, visibility_alpha)

func _draw_invalid_feature_marker_if_needed(
	cell_rect: Rect2,
	object_entry: Dictionary,
	visibility_alpha: float
) -> void:
	if bool(object_entry.get("is_valid_placement", true)):
		return

	var cross_color: Color = _with_multiplied_alpha(COLOR_FEATURE_INVALID, visibility_alpha)
	var inset: float = 6.0
	var top_left: Vector2 = cell_rect.position + Vector2(inset, inset)
	var top_right: Vector2 = Vector2(cell_rect.end.x - inset, cell_rect.position.y + inset)
	var bottom_left: Vector2 = Vector2(cell_rect.position.x + inset, cell_rect.end.y - inset)
	var bottom_right: Vector2 = cell_rect.end - Vector2(inset, inset)

	draw_line(top_left, bottom_right, cross_color, 2.0, false)
	draw_line(top_right, bottom_left, cross_color, 2.0, false)

func _resolve_feature_visibility_alpha(cell_state: WorldCellState) -> float:
	if _is_debug_force_full_visibility_enabled():
		return 1.0

	if cell_state.is_currently_visible:
		return 1.0

	if cell_state.is_revealed:
		return 0.55

	return 0.0

func _resolve_feature_base_color(object_entry: Dictionary, fallback_color: Color) -> Color:
	if bool(object_entry.get("is_valid_placement", true)):
		return fallback_color

	return COLOR_FEATURE_INVALID

func _resolve_feature_dark_color(object_entry: Dictionary, fallback_color: Color) -> Color:
	if bool(object_entry.get("is_valid_placement", true)):
		return fallback_color

	return COLOR_FEATURE_INVALID_DARK

func _with_multiplied_alpha(color: Color, alpha_multiplier: float) -> Color:
	return Color(
		color.r,
		color.g,
		color.b,
		color.a * alpha_multiplier
	)
			
func _draw_hillshade_pass(world_state: WorldState) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var cell_state: WorldCellState = world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			var hillshade_color: Color = _resolve_hillshade_color(world_state, cell_index, cell_state)
			if hillshade_color.a <= 0.0:
				continue

			var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
			draw_rect(cell_rect, hillshade_color, true)

func _draw_site_hint_pass(world_state: WorldState) -> void:
	var focus_entries: Array[Dictionary] = world_state.get_debug_focus_entries()

	for focus_entry: Dictionary in focus_entries:
		var cell_index: Vector2i = focus_entry.get("cell_index", Vector2i(-1, -1)) as Vector2i
		if not world_state.is_cell_index_in_bounds(cell_index):
			continue

		var cell_rect: Rect2 = world_state.cell_index_to_world_rect(cell_index)
		var center: Vector2 = cell_rect.get_center()

		draw_circle(
			center,
			SITE_HINT_RADIUS_OUTER,
			Color(COLOR_SITE_HINT.r, COLOR_SITE_HINT.g, COLOR_SITE_HINT.b, 0.14)
		)
		draw_circle(center, SITE_HINT_RADIUS_INNER, COLOR_SITE_HINT)

		draw_line(
			center + Vector2(-SITE_HINT_LINE_HALF_LENGTH, 0.0),
			center + Vector2(SITE_HINT_LINE_HALF_LENGTH, 0.0),
			COLOR_SITE_HINT,
			2.0
		)
		draw_line(
			center + Vector2(0.0, -SITE_HINT_LINE_HALF_LENGTH),
			center + Vector2(0.0, SITE_HINT_LINE_HALF_LENGTH),
			COLOR_SITE_HINT,
			2.0
		)

func _draw_world_border(world_state: WorldState) -> void:
	var world_rect: Rect2 = Rect2(
		Vector2.ZERO,
		Vector2(
			float(world_state.world_width_cells * world_state.cell_size_pixels),
			float(world_state.world_height_cells * world_state.cell_size_pixels)
		)
	)
	draw_rect(world_rect, COLOR_BORDER, false, 3.0)

func _resolve_ground_color(cell_state: WorldCellState) -> Color:
	var ground_color: Color = COLOR_OPEN_GROUND

	match cell_state.landform_type:
		"ridge":
			ground_color = COLOR_STONY_GROUND
		"bench":
			ground_color = COLOR_OPEN_GROUND_LIGHT
		"depression":
			ground_color = COLOR_WET_GROUND
		"channel":
			ground_color = COLOR_MARSH_GROUND
		_:
			ground_color = COLOR_OPEN_GROUND

	match cell_state.wetness_tendency:
		"dry":
			ground_color = ground_color.lerp(COLOR_DRY_GROUND, 0.28)
		"damp":
			ground_color = ground_color.lerp(COLOR_WET_GROUND, 0.22)
		"wet":
			ground_color = ground_color.lerp(COLOR_MARSH_GROUND, 0.34)
		_:
			pass

	match cell_state.vegetation_cover_class:
		"grass":
			ground_color = ground_color.lerp(COLOR_OPEN_GROUND_LIGHT, 0.16)
		"sparse":
			ground_color = ground_color.lerp(COLOR_STONY_GROUND, 0.12)
		"brush":
			ground_color = ground_color.lerp(COLOR_WET_GROUND, 0.12)
		"woodland":
			ground_color = ground_color.lerp(COLOR_WET_GROUND, 0.20)
		"wetland":
			ground_color = ground_color.lerp(COLOR_MARSH_GROUND, 0.28)
		_:
			pass

	var elevation_factor: float = clampf(float(cell_state.elevation_step) / 12.0, 0.0, 1.0)
	ground_color = ground_color.lerp(COLOR_DRY_GROUND, elevation_factor * 0.18)

	return ground_color

func _resolve_hillshade_color(world_state: WorldState, cell_index: Vector2i, cell_state: WorldCellState) -> Color:
	var west_elevation: int = _get_neighbor_elevation(world_state, cell_index + Vector2i(-1, 0), cell_state.elevation_step)
	var east_elevation: int = _get_neighbor_elevation(world_state, cell_index + Vector2i(1, 0), cell_state.elevation_step)
	var north_elevation: int = _get_neighbor_elevation(world_state, cell_index + Vector2i(0, -1), cell_state.elevation_step)
	var south_elevation: int = _get_neighbor_elevation(world_state, cell_index + Vector2i(0, 1), cell_state.elevation_step)

	var slope_x: float = float(east_elevation - west_elevation)
	var slope_y: float = float(south_elevation - north_elevation)

	# Fixed virtual light from upper-left for subtle relief reading.
	var light_value: float = (-slope_x * 0.72) + (-slope_y * 0.38)
	var normalized: float = clampf(light_value / 6.0, -1.0, 1.0)

	if is_zero_approx(normalized):
		return Color(0.0, 0.0, 0.0, 0.0)

	if normalized > 0.0:
		return Color(1.0, 1.0, 1.0, normalized * HILLSHADE_MAX_ALPHA)

	return Color(0.0, 0.0, 0.0, absf(normalized) * HILLSHADE_MAX_ALPHA)

func _should_draw_canopy_for_patch(patch_state: WorldPatchState) -> bool:
	if patch_state.surface_water_type != "none":
		return false

	match patch_state.dominant_vegetation_cover_class:
		"woodland":
			return true
		"brush":
			return true
		_:
			return false

func _resolve_canopy_count_for_patch(patch_state: WorldPatchState) -> int:
	var patch_area_cells: int = patch_state.area_cell_count

	match patch_state.dominant_vegetation_cover_class:
		"woodland":
			return clampi(int(round(float(patch_area_cells) / 18.0)), 2, 10)
		"brush":
			return clampi(int(round(float(patch_area_cells) / 28.0)), 1, 6)
		_:
			return 0

func _resolve_patch_canopy_center(
	world_state: WorldState,
	patch_state: WorldPatchState,
	patch_footprint_cell_indices: Array[Vector2i],
	canopy_index: int,
	canopy_count: int
) -> Vector2:
	if patch_footprint_cell_indices.is_empty():
		var fallback_rect := Rect2(
			Vector2(patch_state.rect_position * world_state.cell_size_pixels),
			Vector2(patch_state.rect_size * world_state.cell_size_pixels)
		)
		return fallback_rect.get_center()

	var footprint_cell_count: int = patch_footprint_cell_indices.size()
	var sample_ratio: float = (float(canopy_index) + 0.5) / float(maxi(canopy_count, 1))
	var sampled_cell_position: int = clampi(
		int(floor(sample_ratio * float(footprint_cell_count))),
		0,
		footprint_cell_count - 1
	)

	var anchor_cell_index: Vector2i = patch_footprint_cell_indices[sampled_cell_position]
	var anchor_cell_rect: Rect2 = world_state.get_cell_rect_world(anchor_cell_index)
	var anchor_center: Vector2 = anchor_cell_rect.get_center()

	var patch_seed: int = patch_state.patch_id.hash()
	var offset_x_ratio: float = _hash_patch_01(patch_seed, canopy_index * 5 + 1) - 0.5
	var offset_y_ratio: float = _hash_patch_01(patch_seed, canopy_index * 5 + 2) - 0.5
	var offset_scale: float = float(world_state.cell_size_pixels) * 0.28

	return anchor_center + Vector2(offset_x_ratio * offset_scale, offset_y_ratio * offset_scale)

func _resolve_patch_footprint_cell_indices(
	world_state: WorldState,
	patch_state: WorldPatchState
) -> Array[Vector2i]:
	var footprint_cell_indices: Array[Vector2i] = []

	if not patch_state.cell_indices.is_empty():
		for cell_index: Vector2i in patch_state.cell_indices:
			if world_state.is_cell_index_in_bounds(cell_index):
				footprint_cell_indices.append(cell_index)

		if not footprint_cell_indices.is_empty():
			return footprint_cell_indices

	var start_x: int = patch_state.rect_position.x
	var start_y: int = patch_state.rect_position.y
	var end_x: int = patch_state.rect_position.x + patch_state.rect_size.x
	var end_y: int = patch_state.rect_position.y + patch_state.rect_size.y

	for y: int in range(start_y, end_y):
		for x: int in range(start_x, end_x):
			var cell_index := Vector2i(x, y)
			if world_state.is_cell_index_in_bounds(cell_index):
				footprint_cell_indices.append(cell_index)

	return footprint_cell_indices

func _resolve_patch_canopy_radius(patch_state: WorldPatchState, canopy_index: int) -> float:
	var patch_seed: int = patch_state.patch_id.hash()
	var radius_variation: float = _hash_patch_01(patch_seed, canopy_index * 3 + 9)

	match patch_state.dominant_vegetation_cover_class:
		"woodland":
			return lerpf(11.0, 26.0, radius_variation)
		"brush":
			return lerpf(7.0, 15.0, radius_variation)
		_:
			return 8.0

func _resolve_patch_canopy_color(patch_state: WorldPatchState, canopy_index: int) -> Color:
	var patch_seed: int = patch_state.patch_id.hash()
	var tone_value: float = _hash_patch_01(patch_seed, canopy_index * 5 + 4)

	match patch_state.dominant_vegetation_cover_class:
		"woodland":
			if tone_value >= 0.5:
				return COLOR_CANOPY_WOODLAND
			return COLOR_CANOPY_WOODLAND_DARK
		"brush":
			if tone_value >= 0.5:
				return COLOR_CANOPY_BRUSH
			return COLOR_CANOPY_BRUSH_DARK
		_:
			return COLOR_CANOPY_BRUSH

func _build_patch_world_rect(world_state: WorldState, patch_state: WorldPatchState) -> Rect2:
	var patch_position: Vector2 = Vector2(
		float(patch_state.rect_position.x * world_state.cell_size_pixels),
		float(patch_state.rect_position.y * world_state.cell_size_pixels)
	)
	var patch_size: Vector2 = Vector2(
		float(patch_state.rect_size.x * world_state.cell_size_pixels),
		float(patch_state.rect_size.y * world_state.cell_size_pixels)
	)

	return Rect2(patch_position, patch_size)

func _get_neighbor_elevation(world_state: WorldState, cell_index: Vector2i, fallback_elevation: int) -> int:
	if not world_state.is_cell_index_in_bounds(cell_index):
		return fallback_elevation

	var neighbor_cell: WorldCellState = world_state.get_cell(cell_index)
	if neighbor_cell == null:
		return fallback_elevation

	return neighbor_cell.elevation_step

func _build_render_signature() -> String:
	var world_state: WorldState = _get_world_state()
	if world_state == null:
		return "no_world"

	return "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s" % [
		world_state.world_id,
		str(world_state.get_cell_count()),
		str(world_state.get_patch_count()),
		str(world_state.get_all_authored_terrain_objects().size()),
		str(world_state.world_width_cells),
		str(world_state.world_height_cells),
		str(world_state.seed),
		str(world_state.visibility_revision),
		_get_zoom_band_id(),
		str(_is_site_hint_debug_visible()),
		str(_is_debug_force_full_visibility_enabled()),
	]

func _get_world_state() -> WorldState:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return null

	if not sim_root.has_method("get_world_state"):
		return null

	return sim_root.call("get_world_state") as WorldState

func _get_zoom_band_id() -> String:
	var active_camera: Camera2D = get_viewport().get_camera_2d()
	if active_camera != null and active_camera.has_method("get_zoom_band_id"):
		return str(active_camera.call("get_zoom_band_id"))

	return "mid"

func _sim_root() -> Node:
	return get_node_or_null("/root/SimRoot")

func _hash_01(cell_index: Vector2i, salt: int) -> float:
	var sim_root: Node = _sim_root()
	var seed_value: int = 0
	if sim_root != null:
		seed_value = int(sim_root.get("seed"))

	var raw_value: float = sin(float(
		cell_index.x * 127
		+ cell_index.y * 311
		+ salt * 911
		+ seed_value
	)) * 43758.5453

	return raw_value - floor(raw_value)

func _hash_patch_01(patch_seed: int, salt: int) -> float:
	var raw_value: float = sin(float(
		patch_seed
		+ salt * 131
	)) * 24634.6345

	return raw_value - floor(raw_value)
