extends Node2D
class_name MapPlaceholder

const WORLD_SIZE: Vector2 = Vector2(2048.0, 1536.0)
const DEFAULT_SIM_SEED: int = 100001

const COLOR_GROUND: Color = Color8(83, 96, 74)
const COLOR_MEADOW: Color = Color8(97, 112, 84)
const COLOR_RIDGE: Color = Color8(116, 106, 86)
const COLOR_WET: Color = Color8(72, 93, 84)
const COLOR_WATER: Color = Color8(74, 111, 132)
const COLOR_WATER_EDGE: Color = Color8(91, 132, 151)
const COLOR_TREE: Color = Color8(52, 71, 51)
const COLOR_TREE_DARK: Color = Color8(40, 56, 39)
const COLOR_SITE: Color = Color8(201, 182, 129)
const COLOR_GRID: Color = Color(1.0, 1.0, 1.0, 0.05)
const COLOR_BORDER: Color = Color(0.0, 0.0, 0.0, 0.45)

const TREE_COUNT: int = 24
const TREE_ATTEMPT_LIMIT: int = 400
const TREE_MARGIN: float = 24.0
const TREE_SPACING_BUFFER: float = 10.0
const SITE_CLEARANCE_RADIUS: float = 165.0
const WATER_EXCLUSION_BUFFER: float = 8.0

const RIVER_OUTER_WIDTH: float = 56.0
const RIVER_INNER_WIDTH: float = 40.0
const POND_OUTER_RADIUS: float = 88.0
const POND_INNER_RADIUS: float = 64.0

const SITE_CENTER: Vector2 = Vector2(960.0, 760.0)
const POND_CENTER: Vector2 = Vector2(1110.0, 1160.0)

const RIVER_POINTS: Array[Vector2] = [
	Vector2(180, 120),
	Vector2(350, 210),
	Vector2(520, 330),
	Vector2(690, 470),
	Vector2(820, 650),
	Vector2(900, 840),
	Vector2(940, 1040),
	Vector2(1020, 1310),
]

var _tree_instances: Array[Dictionary] = []

func _ready() -> void:
	_rebuild_tree_instances()
	queue_redraw()

func _draw() -> void:
	var world_rect: Rect2 = Rect2(Vector2.ZERO, WORLD_SIZE)

	draw_rect(world_rect, COLOR_GROUND, true)

	_draw_grid()
	_draw_landform_patches()
	_draw_water_corridor()
	_draw_tree_clusters()
	_draw_site_hint()
	_draw_border(world_rect)

func _draw_grid() -> void:
	var step: float = 128.0

	var x: float = 0.0
	while x <= WORLD_SIZE.x:
		draw_line(Vector2(x, 0.0), Vector2(x, WORLD_SIZE.y), COLOR_GRID, 1.0)
		x += step

	var y: float = 0.0
	while y <= WORLD_SIZE.y:
		draw_line(Vector2(0.0, y), Vector2(WORLD_SIZE.x, y), COLOR_GRID, 1.0)
		y += step

func _draw_landform_patches() -> void:
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, 0),
		Vector2(780, 0),
		Vector2(640, 360),
		Vector2(200, 420),
		Vector2(0, 260),
	]), COLOR_MEADOW)

	draw_colored_polygon(PackedVector2Array([
		Vector2(1180, 120),
		Vector2(1840, 80),
		Vector2(2048, 260),
		Vector2(2048, 680),
		Vector2(1700, 620),
		Vector2(1320, 420),
	]), COLOR_RIDGE)

	draw_colored_polygon(PackedVector2Array([
		Vector2(220, 930),
		Vector2(720, 860),
		Vector2(860, 1080),
		Vector2(770, 1380),
		Vector2(350, 1536),
		Vector2(0, 1536),
		Vector2(0, 1140),
	]), COLOR_WET)

	draw_colored_polygon(PackedVector2Array([
		Vector2(1030, 760),
		Vector2(1460, 730),
		Vector2(1710, 910),
		Vector2(1570, 1210),
		Vector2(1130, 1180),
		Vector2(980, 990),
	]), COLOR_MEADOW)

func _draw_water_corridor() -> void:
	var river_polyline: PackedVector2Array = PackedVector2Array(RIVER_POINTS)

	draw_polyline(river_polyline, COLOR_WATER_EDGE, RIVER_OUTER_WIDTH, true)
	draw_polyline(river_polyline, COLOR_WATER, RIVER_INNER_WIDTH, true)

	draw_circle(POND_CENTER, POND_OUTER_RADIUS, COLOR_WATER_EDGE)
	draw_circle(POND_CENTER, POND_INNER_RADIUS, COLOR_WATER)

func _draw_tree_clusters() -> void:
	for tree_instance: Dictionary in _tree_instances:
		var center: Vector2 = tree_instance["center"]
		var radius: float = tree_instance["radius"]
		var color: Color = tree_instance["color"]
		draw_circle(center, radius, color)

func _draw_site_hint() -> void:
	draw_circle(
		SITE_CENTER,
		54.0,
		Color(COLOR_SITE.r, COLOR_SITE.g, COLOR_SITE.b, 0.16)
	)
	draw_circle(SITE_CENTER, 18.0, COLOR_SITE)

	draw_line(
		SITE_CENTER + Vector2(-28.0, 0.0),
		SITE_CENTER + Vector2(28.0, 0.0),
		COLOR_SITE,
		3.0
	)

	draw_line(
		SITE_CENTER + Vector2(0.0, -28.0),
		SITE_CENTER + Vector2(0.0, 28.0),
		COLOR_SITE,
		3.0
	)

func _draw_border(world_rect: Rect2) -> void:
	draw_rect(world_rect, COLOR_BORDER, false, 4.0)

func _rebuild_tree_instances() -> void:
	_tree_instances.clear()

	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = _get_sim_seed()

	var attempts: int = 0
	while _tree_instances.size() < TREE_COUNT and attempts < TREE_ATTEMPT_LIMIT:
		attempts += 1

		var radius: float = rng.randf_range(18.0, 36.0)
		var center: Vector2 = Vector2(
			rng.randf_range(160.0, 1780.0),
			rng.randf_range(140.0, 1360.0)
		)

		if not _is_valid_tree_instance(center, radius):
			continue

		var use_dark: bool = _tree_instances.size() % 2 == 0
		var color: Color = COLOR_TREE_DARK if use_dark else COLOR_TREE

		_tree_instances.append({
			"center": center,
			"radius": radius,
			"color": color,
		})

func _is_valid_tree_instance(center: Vector2, radius: float) -> bool:
	if center.x < radius + TREE_MARGIN:
		return false
	if center.x > WORLD_SIZE.x - radius - TREE_MARGIN:
		return false
	if center.y < radius + TREE_MARGIN:
		return false
	if center.y > WORLD_SIZE.y - radius - TREE_MARGIN:
		return false

	if center.distance_to(SITE_CENTER) < SITE_CLEARANCE_RADIUS + radius:
		return false

	if _is_point_in_open_water(center, radius + WATER_EXCLUSION_BUFFER):
		return false

	if _is_too_close_to_other_trees(center, radius):
		return false

	return true

func _is_point_in_open_water(point: Vector2, clearance: float) -> bool:
	var river_half_width: float = RIVER_INNER_WIDTH * 0.5
	if _distance_to_polyline(point, RIVER_POINTS) <= river_half_width + clearance:
		return true

	if point.distance_to(POND_CENTER) <= POND_INNER_RADIUS + clearance:
		return true

	return false

func _is_too_close_to_other_trees(center: Vector2, radius: float) -> bool:
	for tree_instance: Dictionary in _tree_instances:
		var other_center: Vector2 = tree_instance["center"]
		var other_radius: float = tree_instance["radius"]

		if center.distance_to(other_center) < radius + other_radius + TREE_SPACING_BUFFER:
			return true

	return false

func _distance_to_polyline(point: Vector2, polyline: Array[Vector2]) -> float:
	var min_distance: float = INF

	for i: int in range(polyline.size() - 1):
		var segment_start: Vector2 = polyline[i]
		var segment_end: Vector2 = polyline[i + 1]
		var distance: float = _distance_to_segment(point, segment_start, segment_end)

		if distance < min_distance:
			min_distance = distance

	return min_distance

func _distance_to_segment(point: Vector2, segment_start: Vector2, segment_end: Vector2) -> float:
	var segment: Vector2 = segment_end - segment_start
	var length_squared: float = segment.length_squared()

	if is_zero_approx(length_squared):
		return point.distance_to(segment_start)

	var t: float = clamp(
		(point - segment_start).dot(segment) / length_squared,
		0.0,
		1.0
	)

	var projection: Vector2 = segment_start + segment * t
	return point.distance_to(projection)

func _get_sim_seed() -> int:
	var sim_root: Node = get_node_or_null("/root/SimRoot")
	if sim_root == null:
		return DEFAULT_SIM_SEED

	return int(sim_root.get("seed"))
