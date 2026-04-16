extends RefCounted
class_name WorldCellState

var cell_index: Vector2i = Vector2i.ZERO
var world_position: Vector2 = Vector2.ZERO
var chunk_id: String = ""
var patch_ids: PackedStringArray = PackedStringArray()

var elevation_step: int = 0
var slope_class: String = "flat"
var landform_type: String = "plain"
var surface_water_type: String = "none"
var drainage_class: String = "good"
var wetness_tendency: String = "balanced"
var ground_firmness_class: String = "firm"
var vegetation_cover_class: String = "grass_sparse"

var movement_cost: float = 1.0
var haul_cost_multiplier: float = 1.0
var is_buildable: bool = true
var point_of_interest_tags: PackedStringArray = PackedStringArray()
var zone_stamp_id: String = ""

# Authoritative visibility runtime state.
var fog_state: String = "unknown"
var is_revealed: bool = false
var is_currently_visible: bool = false
var first_revealed_tick: int = -1
var last_seen_tick: int = -1
var survey_quality_class: String = "none"
var terrain_confidence_class: String = "none"

func apply_values(cell_values: Dictionary) -> void:
	if cell_values.has("cell_index"):
		cell_index = cell_values.get("cell_index", Vector2i.ZERO)

	if cell_values.has("world_position"):
		world_position = cell_values.get("world_position", Vector2.ZERO)

	if cell_values.has("chunk_id"):
		chunk_id = str(cell_values.get("chunk_id", ""))

	if cell_values.has("patch_ids"):
		patch_ids = _variant_to_packed_string_array(cell_values.get("patch_ids", []))

	if cell_values.has("elevation_step"):
		elevation_step = int(cell_values.get("elevation_step", 0))

	if cell_values.has("slope_class"):
		slope_class = str(cell_values.get("slope_class", slope_class))

	if cell_values.has("landform_type"):
		landform_type = str(cell_values.get("landform_type", landform_type))

	if cell_values.has("surface_water_type"):
		surface_water_type = str(cell_values.get("surface_water_type", surface_water_type))

	if cell_values.has("drainage_class"):
		drainage_class = str(cell_values.get("drainage_class", drainage_class))

	if cell_values.has("wetness_tendency"):
		wetness_tendency = str(cell_values.get("wetness_tendency", wetness_tendency))

	if cell_values.has("ground_firmness_class"):
		ground_firmness_class = str(cell_values.get("ground_firmness_class", ground_firmness_class))

	if cell_values.has("vegetation_cover_class"):
		vegetation_cover_class = str(cell_values.get("vegetation_cover_class", vegetation_cover_class))

	if cell_values.has("movement_cost"):
		movement_cost = float(cell_values.get("movement_cost", movement_cost))

	if cell_values.has("haul_cost_multiplier"):
		haul_cost_multiplier = float(cell_values.get("haul_cost_multiplier", haul_cost_multiplier))

	if cell_values.has("is_buildable"):
		is_buildable = bool(cell_values.get("is_buildable", is_buildable))

	if cell_values.has("point_of_interest_tags"):
		point_of_interest_tags = _variant_to_packed_string_array(cell_values.get("point_of_interest_tags", []))

	if cell_values.has("zone_stamp_id"):
		zone_stamp_id = str(cell_values.get("zone_stamp_id", zone_stamp_id))

	if cell_values.has("fog_state"):
		fog_state = str(cell_values.get("fog_state", fog_state))

	if cell_values.has("is_revealed"):
		is_revealed = bool(cell_values.get("is_revealed", is_revealed))

	if cell_values.has("is_currently_visible"):
		is_currently_visible = bool(cell_values.get("is_currently_visible", is_currently_visible))

	if cell_values.has("first_revealed_tick"):
		first_revealed_tick = int(cell_values.get("first_revealed_tick", first_revealed_tick))

	if cell_values.has("last_seen_tick"):
		last_seen_tick = int(cell_values.get("last_seen_tick", last_seen_tick))

	if cell_values.has("survey_quality_class"):
		survey_quality_class = str(cell_values.get("survey_quality_class", survey_quality_class))

	if cell_values.has("terrain_confidence_class"):
		terrain_confidence_class = str(cell_values.get("terrain_confidence_class", terrain_confidence_class))

func to_debug_dictionary() -> Dictionary:
	return {
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
		"point_of_interest_tags": point_of_interest_tags,
		"zone_stamp_id": zone_stamp_id,
		"fog_state": fog_state,
		"is_revealed": is_revealed,
		"is_currently_visible": is_currently_visible,
		"first_revealed_tick": first_revealed_tick,
		"last_seen_tick": last_seen_tick,
		"survey_quality_class": survey_quality_class,
		"terrain_confidence_class": terrain_confidence_class,
	}

func _variant_to_packed_string_array(value: Variant) -> PackedStringArray:
	var result: PackedStringArray = PackedStringArray()

	if value is PackedStringArray:
		return value

	if value is Array:
		for entry: Variant in value:
			result.append(str(entry))

	return result
