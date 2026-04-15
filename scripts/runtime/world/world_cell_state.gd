extends RefCounted
class_name WorldCellState

var cell_key: String = ""
var cell_index: Vector2i = Vector2i.ZERO
var world_position: Vector2 = Vector2.ZERO
var chunk_id: String = ""
var patch_ids: PackedStringArray = PackedStringArray()

# Static terrain truth.
var elevation_step: int = 0
var slope_class: String = "flat"
var landform_type: String = "flat"
var surface_water_type: String = "none"
var drainage_class: String = "moderate"
var wetness_tendency: String = "balanced"
var ground_firmness_class: String = "firm"
var vegetation_cover_class: String = "grass"

# Derived or convenience values.
var movement_cost: float = 1.0
var haul_cost_multiplier: float = 1.0
var is_buildable: bool = true

# Mutable runtime state.
var fog_state: String = "unknown"
var is_revealed: bool = false
var is_currently_visible: bool = false
var point_of_interest_tags: PackedStringArray = PackedStringArray()
var zone_stamp_id: String = ""

func apply_values(data: Dictionary) -> void:
	if data.has("elevation_step"):
		elevation_step = int(data.get("elevation_step", elevation_step))

	if data.has("slope_class"):
		slope_class = str(data.get("slope_class", slope_class))

	if data.has("landform_type"):
		landform_type = str(data.get("landform_type", landform_type))

	if data.has("surface_water_type"):
		surface_water_type = str(data.get("surface_water_type", surface_water_type))

	if data.has("drainage_class"):
		drainage_class = str(data.get("drainage_class", drainage_class))

	if data.has("wetness_tendency"):
		wetness_tendency = str(data.get("wetness_tendency", wetness_tendency))

	if data.has("ground_firmness_class"):
		ground_firmness_class = str(data.get("ground_firmness_class", ground_firmness_class))

	if data.has("vegetation_cover_class"):
		vegetation_cover_class = str(data.get("vegetation_cover_class", vegetation_cover_class))

	if data.has("movement_cost"):
		movement_cost = float(data.get("movement_cost", movement_cost))

	if data.has("haul_cost_multiplier"):
		haul_cost_multiplier = float(data.get("haul_cost_multiplier", haul_cost_multiplier))

	if data.has("is_buildable"):
		is_buildable = bool(data.get("is_buildable", is_buildable))

	if data.has("fog_state"):
		fog_state = str(data.get("fog_state", fog_state))

	if data.has("is_revealed"):
		is_revealed = bool(data.get("is_revealed", is_revealed))

	if data.has("is_currently_visible"):
		is_currently_visible = bool(data.get("is_currently_visible", is_currently_visible))

	if data.has("zone_stamp_id"):
		zone_stamp_id = str(data.get("zone_stamp_id", zone_stamp_id))

func add_patch_id(new_patch_id: String) -> void:
	var trimmed_patch_id: String = new_patch_id.strip_edges()
	if trimmed_patch_id.is_empty():
		return

	if not patch_ids.has(trimmed_patch_id):
		patch_ids.append(trimmed_patch_id)

func merge_point_of_interest_tags(new_tags: PackedStringArray) -> void:
	for tag: String in new_tags:
		var trimmed_tag: String = tag.strip_edges()
		if trimmed_tag.is_empty():
			continue

		if not point_of_interest_tags.has(trimmed_tag):
			point_of_interest_tags.append(trimmed_tag)

func to_debug_dictionary() -> Dictionary:
	return {
		"cell_key": cell_key,
		"cell_index": cell_index,
		"world_position": world_position,
		"chunk_id": chunk_id,
		"patch_ids": patch_ids,
		"elevation_step": elevation_step,
		"slope_class": slope_class,
		"landform_type": landform_type,
		"surface_water_type": surface_water_type,
		"drainage_class": drainage_class,
		"wetness_tendency": wetness_tendency,
		"ground_firmness_class": ground_firmness_class,
		"vegetation_cover_class": vegetation_cover_class,
		"movement_cost": movement_cost,
		"haul_cost_multiplier": haul_cost_multiplier,
		"is_buildable": is_buildable,
		"fog_state": fog_state,
		"is_revealed": is_revealed,
		"is_currently_visible": is_currently_visible,
		"point_of_interest_tags": point_of_interest_tags,
		"zone_stamp_id": zone_stamp_id,
	}
