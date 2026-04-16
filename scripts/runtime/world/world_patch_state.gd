extends RefCounted
class_name WorldPatchState

var patch_id: String = ""
var patch_type: String = "authored_rect"
var source_stamp_id: String = ""

var rect_position: Vector2i = Vector2i.ZERO
var rect_size: Vector2i = Vector2i.ZERO

var cell_keys: PackedStringArray = PackedStringArray()
var cell_indices: Array[Vector2i] = []
var point_of_interest_tags: PackedStringArray = PackedStringArray()

# Raw summary fields already used by current authored content.
var landform_type: String = ""
var surface_water_type: String = ""
var drainage_class: String = ""
var wetness_tendency: String = ""
var vegetation_cover_class: String = ""
var is_buildable: bool = false

# More future-proof patch-level summary fields.
var centroid_world: Vector2 = Vector2.ZERO
var area_cell_count: int = 0
var dominant_landform_type: String = ""
var dominant_vegetation_cover_class: String = ""
var dominant_drainage_class: String = ""
var site_score: float = 0.0
var has_authored_site_score: bool = false
var resource_summary: Dictionary = {}
var hazard_summary: Dictionary = {}
var reveal_state: String = "unknown"

func add_cell_key(cell_key: String) -> void:
	var trimmed_cell_key: String = cell_key.strip_edges()
	if trimmed_cell_key.is_empty():
		return

	if not cell_keys.has(trimmed_cell_key):
		cell_keys.append(trimmed_cell_key)

func add_cell_index(cell_index: Vector2i) -> void:
	if cell_indices.has(cell_index):
		return

	cell_indices.append(cell_index)

func set_point_of_interest_tags(tags: PackedStringArray) -> void:
	point_of_interest_tags = PackedStringArray()

	for tag: String in tags:
		var trimmed_tag: String = tag.strip_edges()
		if trimmed_tag.is_empty():
			continue

		if not point_of_interest_tags.has(trimmed_tag):
			point_of_interest_tags.append(trimmed_tag)

func finalize_from_world_state(world_state: WorldState) -> void:
	if world_state == null:
		return

	area_cell_count = cell_indices.size()

	if area_cell_count <= 0:
		centroid_world = Vector2.ZERO
		if reveal_state.strip_edges().is_empty():
			reveal_state = "unknown"
		return

	var landform_counts: Dictionary = {}
	var vegetation_counts: Dictionary = {}
	var drainage_counts: Dictionary = {}
	var ground_firmness_counts: Dictionary = {}

	var sum_world_position: Vector2 = Vector2.ZERO
	var visible_cell_count: int = 0
	var revealed_cell_count: int = 0
	var buildable_cell_count: int = 0
	var surface_water_cell_count: int = 0
	var wet_ground_cell_count: int = 0
	var poor_drainage_cell_count: int = 0
	var non_buildable_cell_count: int = 0
	var soft_ground_cell_count: int = 0

	for cell_index: Vector2i in cell_indices:
		var cell_state: WorldCellState = world_state.get_cell(cell_index)
		if cell_state == null:
			continue

		sum_world_position += cell_state.world_position

		_increment_string_count(landform_counts, cell_state.landform_type)
		_increment_string_count(vegetation_counts, cell_state.vegetation_cover_class)
		_increment_string_count(drainage_counts, cell_state.drainage_class)
		_increment_string_count(ground_firmness_counts, cell_state.ground_firmness_class)

		if cell_state.is_currently_visible:
			visible_cell_count += 1

		if cell_state.is_revealed:
			revealed_cell_count += 1

		if cell_state.is_buildable:
			buildable_cell_count += 1
		else:
			non_buildable_cell_count += 1

		if cell_state.surface_water_type != "none":
			surface_water_cell_count += 1

		if cell_state.wetness_tendency == "wet" or cell_state.wetness_tendency == "saturated":
			wet_ground_cell_count += 1

		if cell_state.drainage_class == "poor":
			poor_drainage_cell_count += 1

		if cell_state.ground_firmness_class == "soft":
			soft_ground_cell_count += 1

	centroid_world = sum_world_position / float(max(area_cell_count, 1))

	if dominant_landform_type.strip_edges().is_empty():
		dominant_landform_type = _get_most_common_string(landform_counts)

	if dominant_vegetation_cover_class.strip_edges().is_empty():
		dominant_vegetation_cover_class = _get_most_common_string(vegetation_counts)

	if dominant_drainage_class.strip_edges().is_empty():
		dominant_drainage_class = _get_most_common_string(drainage_counts)

	# Keep current simple fields aligned for backward compatibility.
	if landform_type.strip_edges().is_empty():
		landform_type = dominant_landform_type

	if vegetation_cover_class.strip_edges().is_empty():
		vegetation_cover_class = dominant_vegetation_cover_class

	if drainage_class.strip_edges().is_empty():
		drainage_class = dominant_drainage_class

	var buildable_ratio: float = _safe_ratio(buildable_cell_count, area_cell_count)
	var surface_water_ratio: float = _safe_ratio(surface_water_cell_count, area_cell_count)
	var wet_ground_ratio: float = _safe_ratio(wet_ground_cell_count, area_cell_count)
	var poor_drainage_ratio: float = _safe_ratio(poor_drainage_cell_count, area_cell_count)
	var non_buildable_ratio: float = _safe_ratio(non_buildable_cell_count, area_cell_count)
	var soft_ground_ratio: float = _safe_ratio(soft_ground_cell_count, area_cell_count)

	var next_resource_summary: Dictionary = resource_summary.duplicate(true)
	next_resource_summary["buildable_cell_count"] = buildable_cell_count
	next_resource_summary["surface_water_cell_count"] = surface_water_cell_count
	next_resource_summary["area_cell_count"] = area_cell_count
	next_resource_summary["buildable_ratio"] = buildable_ratio
	next_resource_summary["surface_water_ratio"] = surface_water_ratio
	next_resource_summary["point_of_interest_tags"] = point_of_interest_tags
	resource_summary = next_resource_summary

	var next_hazard_summary: Dictionary = hazard_summary.duplicate(true)
	next_hazard_summary["wet_ground_cell_count"] = wet_ground_cell_count
	next_hazard_summary["poor_drainage_cell_count"] = poor_drainage_cell_count
	next_hazard_summary["non_buildable_cell_count"] = non_buildable_cell_count
	next_hazard_summary["soft_ground_cell_count"] = soft_ground_cell_count
	next_hazard_summary["wet_ground_ratio"] = wet_ground_ratio
	next_hazard_summary["poor_drainage_ratio"] = poor_drainage_ratio
	next_hazard_summary["non_buildable_ratio"] = non_buildable_ratio
	next_hazard_summary["soft_ground_ratio"] = soft_ground_ratio
	hazard_summary = next_hazard_summary

	if not has_authored_site_score:
		site_score = _calculate_site_score(
			buildable_ratio,
			surface_water_ratio,
			wet_ground_ratio,
			poor_drainage_ratio,
			soft_ground_ratio,
			dominant_vegetation_cover_class,
			dominant_drainage_class,
			_get_most_common_string(ground_firmness_counts),
			area_cell_count
		)

	if reveal_state == "unknown" or reveal_state.strip_edges().is_empty():
		reveal_state = _resolve_reveal_state(visible_cell_count, revealed_cell_count, area_cell_count)

func to_debug_dictionary() -> Dictionary:
	return {
		"patch_id": patch_id,
		"patch_type": patch_type,
		"source_stamp_id": source_stamp_id,
		"rect_position": rect_position,
		"rect_size": rect_size,
		"cell_count": cell_keys.size(),
		"area_cell_count": area_cell_count,
		"centroid_world": centroid_world,
		"point_of_interest_tags": point_of_interest_tags,
		"landform_type": landform_type,
		"surface_water_type": surface_water_type,
		"drainage_class": drainage_class,
		"wetness_tendency": wetness_tendency,
		"vegetation_cover_class": vegetation_cover_class,
		"is_buildable": is_buildable,
		"dominant_landform_type": dominant_landform_type,
		"dominant_vegetation_cover_class": dominant_vegetation_cover_class,
		"dominant_vegetation_community": dominant_vegetation_cover_class,
		"dominant_drainage_class": dominant_drainage_class,
		"site_score": site_score,
		"has_authored_site_score": has_authored_site_score,
		"resource_summary": resource_summary.duplicate(true),
		"hazard_summary": hazard_summary.duplicate(true),
		"reveal_state": reveal_state,
	}

func _calculate_site_score(
	buildable_ratio: float,
	surface_water_ratio: float,
	wet_ground_ratio: float,
	poor_drainage_ratio: float,
	soft_ground_ratio: float,
	dominant_vegetation_class: String,
	dominant_drainage_value: String,
	dominant_ground_firmness_class: String,
	patch_area_cell_count: int
) -> float:
	var score: float = 0.0

	# Buildable ground is the strongest positive signal for first-pass camp suitability.
	score += buildable_ratio * 42.0

	# Some nearby freshwater is useful, but water-dominated patches should not score highly.
	score += _resolve_water_access_score(surface_water_ratio, buildable_ratio) * 18.0

	# Vegetation acts as a rough proxy for nearby biomass / early usable materials.
	score += _resolve_vegetation_usefulness_score(dominant_vegetation_class) * 14.0

	# Drainage and firmness help separate dependable dry camp ground from troublesome spots.
	score += _resolve_drainage_score(dominant_drainage_value) * 10.0
	score += _resolve_ground_firmness_score(dominant_ground_firmness_class) * 6.0

	# Larger patches are easier to work with early on, up to a reasonable cap.
	score += clamp(float(patch_area_cell_count) / 24.0, 0.0, 1.0) * 10.0

	# Wetness and poor drainage are direct penalties.
	var wetness_penalty: float = clamp((wet_ground_ratio * 0.7) + (poor_drainage_ratio * 0.3), 0.0, 1.0)
	score -= wetness_penalty * 18.0

	# Soft ground is a smaller but still relevant penalty.
	score -= soft_ground_ratio * 6.0

	return clamp(score, 0.0, 100.0)

func _resolve_water_access_score(surface_water_ratio: float, buildable_ratio: float) -> float:
	if surface_water_ratio <= 0.0:
		return 0.0

	var ideal_water_ratio: float = 0.12
	var ratio_distance: float = abs(surface_water_ratio - ideal_water_ratio)
	var raw_access_score: float = 1.0 - min(ratio_distance / ideal_water_ratio, 1.0)

	# Water only helps if the patch still has usable land around it.
	return raw_access_score * buildable_ratio

func _resolve_vegetation_usefulness_score(vegetation_class: String) -> float:
	match vegetation_class:
		"woodland":
			return 1.0
		"brush":
			return 0.75
		"grass":
			return 0.55
		"sparse":
			return 0.20
		"wetland":
			return 0.10
		_:
			return 0.35

func _resolve_drainage_score(drainage_value: String) -> float:
	match drainage_value:
		"good":
			return 1.0
		"moderate":
			return 0.60
		"poor":
			return 0.20
		_:
			return 0.40

func _resolve_ground_firmness_score(ground_firmness_class: String) -> float:
	match ground_firmness_class:
		"hard":
			return 1.0
		"firm":
			return 0.80
		"soft":
			return 0.25
		_:
			return 0.50

func _safe_ratio(numerator: int, denominator: int) -> float:
	if denominator <= 0:
		return 0.0

	return float(numerator) / float(denominator)

func _increment_string_count(counter: Dictionary, value: String) -> void:
	var trimmed_value: String = value.strip_edges()
	if trimmed_value.is_empty():
		return

	var next_count: int = int(counter.get(trimmed_value, 0)) + 1
	counter[trimmed_value] = next_count

func _get_most_common_string(counter: Dictionary) -> String:
	var best_value: String = ""
	var best_count: int = -1

	for key_variant: Variant in counter.keys():
		var key: String = str(key_variant)
		var count: int = int(counter.get(key, 0))

		if count > best_count:
			best_value = key
			best_count = count

	return best_value

func _resolve_reveal_state(visible_cell_count: int, revealed_cell_count: int, total_cell_count: int) -> String:
	if total_cell_count <= 0:
		return "unknown"

	if visible_cell_count >= total_cell_count:
		return "visible"

	if visible_cell_count > 0:
		return "partially_visible"

	if revealed_cell_count > 0:
		return "remembered"

	return "hidden"
