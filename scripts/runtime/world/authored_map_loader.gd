extends RefCounted
class_name AuthoredMapLoader

const WORLD_STATE_SCRIPT: Script = preload("res://scripts/runtime/world/world_state.gd")
const WORLD_CELL_STATE_SCRIPT: Script = preload("res://scripts/runtime/world/world_cell_state.gd")
const WORLD_CHUNK_STATE_SCRIPT: Script = preload("res://scripts/runtime/world/world_chunk_state.gd")
const WORLD_PATCH_STATE_SCRIPT: Script = preload("res://scripts/runtime/world/world_patch_state.gd")

const FIXTURE_PATH_TEMPLATE: String = "res://data/world/authored_maps/%s.json"
const ROOT_CHUNK_ID: String = "chunk.0_0"

func build_world_state(
	map_preset_def: MapPresetDef,
	worldgen_profile_def: WorldgenProfileDef,
	seed: int
) -> Dictionary:
	if map_preset_def == null:
		return _error("AuthoredMapLoader: map_preset_def was null.")

	if worldgen_profile_def == null:
		return _error("AuthoredMapLoader: worldgen_profile_def was null.")

	var fixture_id: String = map_preset_def.fixture_id.strip_edges()
	if fixture_id.is_empty():
		return _error("AuthoredMapLoader: map preset '%s' has no fixture_id." % map_preset_def.map_preset_id)

	var fixture_path: String = FIXTURE_PATH_TEMPLATE % fixture_id
	if not FileAccess.file_exists(fixture_path):
		return _error("AuthoredMapLoader: fixture file is missing: %s" % fixture_path)

	var file_text: String = FileAccess.get_file_as_string(fixture_path)
	var parser: JSON = JSON.new()
	var parse_error: Error = parser.parse(file_text)
	if parse_error != OK:
		return _error(
			"AuthoredMapLoader: failed to parse %s at line %s: %s" % [
				fixture_path,
				parser.get_error_line(),
				parser.get_error_message(),
			]
		)

	if not (parser.data is Dictionary):
		return _error("AuthoredMapLoader: root JSON value must be a dictionary: %s" % fixture_path)

	var root: Dictionary = parser.data as Dictionary
	var root_validation_error: String = _validate_root(root, map_preset_def)
	if not root_validation_error.is_empty():
		return _error(root_validation_error)

	var default_cell_data: Dictionary = root.get("default_cell", {}) as Dictionary
	var default_validation_error: String = _validate_cell_value_block("default_cell", default_cell_data)
	if not default_validation_error.is_empty():
		return _error(default_validation_error)

	var world_state: WorldState = WORLD_STATE_SCRIPT.new() as WorldState
	world_state.world_id = "%s:%s" % [map_preset_def.map_preset_id, seed]
	world_state.fixture_id = fixture_id
	world_state.map_preset_id = map_preset_def.map_preset_id
	world_state.worldgen_profile_id = worldgen_profile_def.worldgen_profile_id
	world_state.primary_terrain_profile_id = _get_primary_terrain_profile_id(worldgen_profile_def)
	world_state.seed = seed
	world_state.world_width_cells = int(root.get("world_width_cells", 0))
	world_state.world_height_cells = int(root.get("world_height_cells", 0))
	world_state.cell_size_pixels = int(root.get("cell_size_pixels", 32))

	_populate_default_cells(world_state, default_cell_data)

	var stamp_apply_result: Dictionary = _apply_stamps(world_state, root.get("stamps", []))
	if not bool(stamp_apply_result.get("ok", false)):
		return stamp_apply_result

	_create_root_chunk(world_state)
	_apply_debug_focus_entries(world_state, root.get("debug_focus_cells", []))

	return {
		"ok": true,
		"world_state": world_state,
	}

func _populate_default_cells(world_state: WorldState, default_cell_data: Dictionary) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_state: WorldCellState = WORLD_CELL_STATE_SCRIPT.new() as WorldCellState
			cell_state.cell_index = Vector2i(x, y)
			cell_state.cell_key = WorldState.build_cell_key(cell_state.cell_index)
			cell_state.chunk_id = ROOT_CHUNK_ID
			cell_state.world_position = Vector2(
				(float(x) + 0.5) * float(world_state.cell_size_pixels),
				(float(y) + 0.5) * float(world_state.cell_size_pixels)
			)
			cell_state.apply_values(default_cell_data)
			world_state.add_cell(cell_state)

func _apply_stamps(world_state: WorldState, stamps_variant: Variant) -> Dictionary:
	if not (stamps_variant is Array):
		return _error("AuthoredMapLoader: stamps must be an array.")

	var stamps: Array = stamps_variant as Array

	for stamp_variant: Variant in stamps:
		if not (stamp_variant is Dictionary):
			return _error("AuthoredMapLoader: each stamp must be a dictionary.")

		var stamp_data: Dictionary = stamp_variant as Dictionary
		var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
		if stamp_id.is_empty():
			return _error("AuthoredMapLoader: encountered a stamp with no stamp_id.")

		var validation_error: String = _validate_cell_value_block("stamp '%s'" % stamp_id, stamp_data)
		if not validation_error.is_empty():
			return _error(validation_error)

		var rect_result: Dictionary = _read_rect(stamp_data, stamp_id)
		if not bool(rect_result.get("ok", false)):
			return rect_result

		var stamp_rect: Rect2i = rect_result.get("rect", Rect2i()) as Rect2i
		var stamp_tags: PackedStringArray = _variant_to_packed_string_array(
			stamp_data.get("point_of_interest_tags", [])
		)

		var create_patch: bool = true
		if stamp_data.has("create_patch"):
			create_patch = bool(stamp_data.get("create_patch", true))

		var patch_state: WorldPatchState = null
		if create_patch:
			patch_state = _build_patch_state_from_stamp(stamp_id, stamp_data, stamp_rect, stamp_tags)

		for y: int in range(stamp_rect.position.y, stamp_rect.end.y):
			for x: int in range(stamp_rect.position.x, stamp_rect.end.x):
				var cell_index: Vector2i = Vector2i(x, y)
				var cell_state: WorldCellState = world_state.get_cell(cell_index)

				if cell_state == null:
					return _error(
						"AuthoredMapLoader: missing cell during stamp apply for '%s' at %s." % [
							stamp_id,
							cell_index,
						]
					)

				cell_state.apply_values(stamp_data)
				cell_state.merge_point_of_interest_tags(stamp_tags)

				if patch_state != null:
					cell_state.add_patch_id(patch_state.patch_id)
					patch_state.add_cell_key(cell_state.cell_key)
					patch_state.add_cell_index(cell_state.cell_index)

		if patch_state != null:
			patch_state.finalize_from_world_state(world_state)
			world_state.add_patch(patch_state)

	return {
		"ok": true,
	}
	
func _build_patch_state_from_stamp(
	stamp_id: String,
	stamp_data: Dictionary,
	stamp_rect: Rect2i,
	stamp_tags: PackedStringArray
) -> WorldPatchState:
	var patch_state: WorldPatchState = WORLD_PATCH_STATE_SCRIPT.new() as WorldPatchState

	var patch_type: String = str(stamp_data.get("patch_type", "authored_rect")).strip_edges()
	if patch_type.is_empty():
		patch_type = "authored_rect"

	patch_state.patch_id = "patch.%s" % stamp_id
	patch_state.patch_type = patch_type
	patch_state.source_stamp_id = stamp_id
	patch_state.rect_position = stamp_rect.position
	patch_state.rect_size = stamp_rect.size
	patch_state.set_point_of_interest_tags(stamp_tags)

	patch_state.landform_type = str(stamp_data.get("landform_type", ""))
	patch_state.surface_water_type = str(stamp_data.get("surface_water_type", ""))
	patch_state.drainage_class = str(stamp_data.get("drainage_class", ""))
	patch_state.wetness_tendency = str(stamp_data.get("wetness_tendency", ""))
	patch_state.vegetation_cover_class = str(stamp_data.get("vegetation_cover_class", ""))
	patch_state.is_buildable = bool(stamp_data.get("is_buildable", false))

	patch_state.dominant_landform_type = patch_state.landform_type
	patch_state.dominant_vegetation_cover_class = patch_state.vegetation_cover_class
	patch_state.dominant_drainage_class = patch_state.drainage_class

	if stamp_data.has("site_score"):
		patch_state.site_score = float(stamp_data.get("site_score", 0.0))

	var resource_summary_variant: Variant = stamp_data.get("resource_summary", {})
	if resource_summary_variant is Dictionary:
		patch_state.resource_summary = (resource_summary_variant as Dictionary).duplicate(true)

	var hazard_summary_variant: Variant = stamp_data.get("hazard_summary", {})
	if hazard_summary_variant is Dictionary:
		patch_state.hazard_summary = (hazard_summary_variant as Dictionary).duplicate(true)

	var reveal_state: String = str(stamp_data.get("reveal_state", "")).strip_edges()
	if not reveal_state.is_empty():
		patch_state.reveal_state = reveal_state

	return patch_state

func _create_root_chunk(world_state: WorldState) -> void:
	var chunk_state: WorldChunkState = WORLD_CHUNK_STATE_SCRIPT.new() as WorldChunkState
	chunk_state.chunk_id = ROOT_CHUNK_ID
	chunk_state.origin_cell = Vector2i.ZERO
	chunk_state.size_cells = Vector2i(
		world_state.world_width_cells,
		world_state.world_height_cells
	)

	for cell_key: String in world_state.get_all_cell_keys():
		chunk_state.add_cell_key(cell_key)

	world_state.add_chunk(chunk_state)

func _apply_debug_focus_entries(world_state: WorldState, focus_variant: Variant) -> void:
	var entries: Array = []

	if not (focus_variant is Array):
		world_state.set_debug_focus_entries(entries)
		return

	var focus_array: Array = focus_variant as Array
	for focus_entry_variant: Variant in focus_array:
		if not (focus_entry_variant is Dictionary):
			continue

		var focus_entry: Dictionary = focus_entry_variant as Dictionary
		var label: String = str(focus_entry.get("label", "focus")).strip_edges()
		if label.is_empty():
			label = "focus"

		var cell_variant: Variant = focus_entry.get("cell", [])
		if not (cell_variant is Array):
			continue

		var cell_array: Array = cell_variant as Array
		if cell_array.size() != 2:
			continue

		var cell_index: Vector2i = Vector2i(
			int(cell_array[0]),
			int(cell_array[1])
		)

		if cell_index.x < 0 or cell_index.y < 0:
			continue

		if cell_index.x >= world_state.world_width_cells:
			continue

		if cell_index.y >= world_state.world_height_cells:
			continue

		entries.append({
			"label": label,
			"cell_index": cell_index,
		})

	world_state.set_debug_focus_entries(entries)

func _validate_root(root: Dictionary, map_preset_def: MapPresetDef) -> String:
	var fixture_id: String = str(root.get("fixture_id", "")).strip_edges()
	if fixture_id.is_empty():
		return "AuthoredMapLoader: fixture JSON is missing fixture_id."

	if fixture_id != map_preset_def.fixture_id:
		return (
			"AuthoredMapLoader: fixture_id mismatch. JSON='%s', MapPresetDef='%s'." % [
				fixture_id,
				map_preset_def.fixture_id,
			]
		)

	var world_width_cells: int = int(root.get("world_width_cells", 0))
	var world_height_cells: int = int(root.get("world_height_cells", 0))
	if world_width_cells != map_preset_def.world_width_cells:
		return (
			"AuthoredMapLoader: world_width_cells mismatch. JSON=%s, MapPresetDef=%s." % [
				world_width_cells,
				map_preset_def.world_width_cells,
			]
		)

	if world_height_cells != map_preset_def.world_height_cells:
		return (
			"AuthoredMapLoader: world_height_cells mismatch. JSON=%s, MapPresetDef=%s." % [
				world_height_cells,
				map_preset_def.world_height_cells,
			]
		)

	if not root.has("default_cell"):
		return "AuthoredMapLoader: fixture JSON is missing default_cell."

	if not (root.get("default_cell", null) is Dictionary):
		return "AuthoredMapLoader: default_cell must be a dictionary."

	if not root.has("stamps"):
		return "AuthoredMapLoader: fixture JSON is missing stamps."

	if not (root.get("stamps", null) is Array):
		return "AuthoredMapLoader: stamps must be an array."

	return ""

func _validate_cell_value_block(context_label: String, data: Dictionary) -> String:
	var checks: Array = [
		{"field": "slope_class", "allowed": SharedEnums.SLOPE_CLASSES},
		{"field": "landform_type", "allowed": SharedEnums.LANDFORM_TYPES},
		{"field": "surface_water_type", "allowed": SharedEnums.SURFACE_WATER_TYPES},
		{"field": "drainage_class", "allowed": SharedEnums.DRAINAGE_CLASSES},
		{"field": "wetness_tendency", "allowed": SharedEnums.WETNESS_TENDENCIES},
		{"field": "ground_firmness_class", "allowed": SharedEnums.GROUND_FIRMNESS_CLASSES},
		{"field": "vegetation_cover_class", "allowed": SharedEnums.VEGETATION_COVER_CLASSES},
		{"field": "fog_state", "allowed": SharedEnums.FOG_STATE_IDS},
	]

	for check_variant: Variant in checks:
		var check: Dictionary = check_variant as Dictionary
		var field_name: String = str(check.get("field", ""))

		if not data.has(field_name):
			continue

		var value: String = str(data.get(field_name, ""))
		var allowed_values: Array = check.get("allowed", []) as Array

		if not SharedEnums.contains_value(allowed_values, value):
			return (
				"AuthoredMapLoader: %s has invalid %s '%s'." % [
					context_label,
					field_name,
					value,
				]
			)

	return ""

func _read_rect(stamp_data: Dictionary, stamp_id: String) -> Dictionary:
	if not stamp_data.has("rect"):
		return _error("AuthoredMapLoader: stamp '%s' is missing rect." % stamp_id)

	var rect_variant: Variant = stamp_data.get("rect", [])
	if not (rect_variant is Array):
		return _error("AuthoredMapLoader: stamp '%s' rect must be an array." % stamp_id)

	var rect_array: Array = rect_variant as Array
	if rect_array.size() != 4:
		return _error("AuthoredMapLoader: stamp '%s' rect must contain 4 integers." % stamp_id)

	var rect_position: Vector2i = Vector2i(
		int(rect_array[0]),
		int(rect_array[1])
	)
	var rect_size: Vector2i = Vector2i(
		int(rect_array[2]),
		int(rect_array[3])
	)

	if rect_size.x <= 0 or rect_size.y <= 0:
		return _error("AuthoredMapLoader: stamp '%s' rect size must be positive." % stamp_id)

	return {
		"ok": true,
		"rect": Rect2i(rect_position, rect_size),
	}

func _get_primary_terrain_profile_id(worldgen_profile_def: WorldgenProfileDef) -> String:
	if worldgen_profile_def.terrain_profile_ids.is_empty():
		return ""

	return str(worldgen_profile_def.terrain_profile_ids[0])

func _variant_to_packed_string_array(value: Variant) -> PackedStringArray:
	var result: PackedStringArray = PackedStringArray()

	if value is PackedStringArray:
		for tag: String in value:
			result.append(tag)
		return result

	if not (value is Array):
		return result

	var values: Array = value as Array
	for value_variant: Variant in values:
		result.append(str(value_variant))

	return result

func _error(message: String) -> Dictionary:
	return {
		"ok": false,
		"error": message,
	}
