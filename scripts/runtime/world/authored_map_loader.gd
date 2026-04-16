extends RefCounted
class_name AuthoredMapLoader

const DEFAULT_CELL_SIZE_PIXELS: int = 32
const DEFAULT_CHUNK_SIZE_CELLS: int = 16
const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

func load_world_state_from_fixture(
	map_preset_def: MapPresetDef,
	worldgen_profile_def: WorldgenProfileDef,
	time_service: Node
) -> WorldState:
	if map_preset_def == null:
		push_error("AuthoredMapLoader: map_preset_def was null.")
		return null

	var map_preset_definition_id: String = map_preset_def.get_definition_id()
	var fixture_id: String = map_preset_def.fixture_id.strip_edges()
	if fixture_id.is_empty():
		push_error(
			"AuthoredMapLoader: Map preset '%s' has no fixture_id." % map_preset_definition_id
		)
		return null

	var fixture_path: String = "res://data/world/authored_maps/%s.json" % fixture_id
	var root: Dictionary = _read_fixture_root(fixture_path)
	if root.is_empty():
		return null

	var validation_errors: Array[String] = _validate_root(root)
	if not validation_errors.is_empty():
		push_error(
			"AuthoredMapLoader:\n- %s" % "\n- ".join(validation_errors)
		)
		return null

	var world_width_cells: int = int(root.get("world_width_cells", 0))
	var world_height_cells: int = int(root.get("world_height_cells", 0))
	var cell_size_pixels: int = int(root.get("cell_size_pixels", DEFAULT_CELL_SIZE_PIXELS))
	var chunk_size_cells: int = int(root.get("chunk_size_cells", DEFAULT_CHUNK_SIZE_CELLS))

	var world_state: WorldState = WorldState.new()
	if world_state == null:
		push_error("AuthoredMapLoader: Failed to create WorldState.")
		return null

	world_state.configure_dimensions(
		world_width_cells,
		world_height_cells,
		cell_size_pixels,
		chunk_size_cells
	)

	world_state.fixture_id = str(root.get("fixture_id", fixture_id)).strip_edges()
	world_state.world_id = world_state.fixture_id
	world_state.primary_terrain_profile_id = ""
	if worldgen_profile_def != null:
		world_state.primary_terrain_profile_id = worldgen_profile_def.get_definition_id()

	if time_service != null:
		world_state.seed = int(time_service.get("scenario_seed"))

	var default_cell_values: Dictionary = root.get("default_cell", {}) as Dictionary
	_create_default_cells(world_state, default_cell_values)

	var stamps: Array = root.get("stamps", [])
	if not _apply_stamps(world_state, stamps):
		return null

	_build_chunks(world_state)

	var debug_focus_cells: Array = root.get("debug_focus_cells", [])
	_apply_debug_focus_cells(world_state, debug_focus_cells)

	var reveal_sources: Array = root.get("reveal_sources", [])
	if not _apply_reveal_sources(world_state, reveal_sources):
		return null

	var terrain_objects: Array = root.get("terrain_objects", [])
	if not _apply_authored_terrain_objects(world_state, terrain_objects):
		return null

	return world_state

func _read_fixture_root(fixture_path: String) -> Dictionary:
	if not FileAccess.file_exists(fixture_path):
		push_error("AuthoredMapLoader: Fixture file does not exist: %s" % fixture_path)
		return {}

	var file_text: String = FileAccess.get_file_as_string(fixture_path)
	if file_text.strip_edges().is_empty():
		push_error("AuthoredMapLoader: Fixture file was empty: %s" % fixture_path)
		return {}

	var parsed_variant: Variant = JSON.parse_string(file_text)
	if not (parsed_variant is Dictionary):
		push_error("AuthoredMapLoader: Fixture root was not a Dictionary: %s" % fixture_path)
		return {}

	return parsed_variant as Dictionary


func _validate_root(root: Dictionary) -> Array[String]:
	var errors: Array[String] = []

	if not root.has("world_width_cells"):
		errors.append("Missing world_width_cells.")
	if not root.has("world_height_cells"):
		errors.append("Missing world_height_cells.")
	if not root.has("cell_size_pixels"):
		errors.append("Missing cell_size_pixels.")
	if not root.has("default_cell"):
		errors.append("Missing default_cell.")

	if root.has("stamps"):
		var stamps_variant: Variant = root.get("stamps", [])
		if typeof(stamps_variant) != TYPE_ARRAY:
			errors.append("'stamps' must be an array when present.")
		else:
			var stamps: Array = stamps_variant as Array
			for stamp_variant: Variant in stamps:
				if typeof(stamp_variant) != TYPE_DICTIONARY:
					errors.append("Each stamp must be a dictionary.")
					continue

				var stamp_data: Dictionary = stamp_variant as Dictionary
				var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
				if stamp_id.is_empty():
					errors.append("Each stamp needs a non-empty stamp_id.")

				if not _stamp_has_supported_footprint(stamp_data):
					errors.append(
						"Stamp '%s' needs either rect [x, y, w, h] or a non-empty cells [[x, y], ...] footprint."
						% stamp_id
					)

				if stamp_data.has("rect"):
					var rect_variant: Variant = stamp_data.get("rect", [])
					if typeof(rect_variant) != TYPE_ARRAY:
						errors.append("Stamp '%s' rect must be an array." % stamp_id)
					else:
						var rect_array: Array = rect_variant as Array
						if rect_array.size() != 4:
							errors.append("Stamp '%s' rect must have 4 integers." % stamp_id)

				if stamp_data.has("cells"):
					var cells_variant: Variant = stamp_data.get("cells", [])
					if typeof(cells_variant) != TYPE_ARRAY:
						errors.append("Stamp '%s' cells must be an array." % stamp_id)
					else:
						var cells_array: Array = cells_variant as Array
						if cells_array.is_empty():
							errors.append("Stamp '%s' cells must not be empty." % stamp_id)
						for cell_variant: Variant in cells_array:
							if typeof(cell_variant) != TYPE_ARRAY:
								errors.append("Stamp '%s' cells entries must be [x, y] arrays." % stamp_id)
								break
							var cell_array: Array = cell_variant as Array
							if cell_array.size() != 2:
								errors.append("Stamp '%s' cells entries must have exactly 2 values." % stamp_id)
								break

	if root.has("reveal_sources"):
		var reveal_sources_variant: Variant = root.get("reveal_sources", [])
		if typeof(reveal_sources_variant) != TYPE_ARRAY:
			errors.append("'reveal_sources' must be an array when present.")
		else:
			var reveal_sources: Array = reveal_sources_variant as Array
			for source_variant: Variant in reveal_sources:
				if typeof(source_variant) != TYPE_DICTIONARY:
					errors.append("Each reveal source must be a dictionary.")
					continue
				var source_data: Dictionary = source_variant as Dictionary
				var source_id: String = str(source_data.get("source_id", "")).strip_edges()
				if source_id.is_empty():
					errors.append("Each reveal source needs a non-empty source_id.")
				var cell_variant: Variant = source_data.get("cell", [])
				if typeof(cell_variant) != TYPE_ARRAY or (cell_variant as Array).size() != 2:
					errors.append("Reveal source '%s' requires cell [x, y]." % source_id)

	if root.has("terrain_objects"):
		var terrain_objects_variant: Variant = root.get("terrain_objects", [])
		if typeof(terrain_objects_variant) != TYPE_ARRAY:
			errors.append("'terrain_objects' must be an array when present.")
		else:
			var terrain_objects: Array = terrain_objects_variant as Array
			for object_variant: Variant in terrain_objects:
				if typeof(object_variant) != TYPE_DICTIONARY:
					errors.append("Each terrain object must be a dictionary.")
					continue
				var object_data: Dictionary = object_variant as Dictionary
				var object_id: String = str(object_data.get("object_id", "")).strip_edges()
				if object_id.is_empty():
					errors.append("Each terrain object needs a non-empty object_id.")
				var cell_variant: Variant = object_data.get("cell", [])
				if typeof(cell_variant) != TYPE_ARRAY or (cell_variant as Array).size() != 2:
					errors.append("Terrain object '%s' requires cell [x, y]." % object_id)

	return errors

func _stamp_has_supported_footprint(stamp_data: Dictionary) -> bool:
	if stamp_data.has("cells"):
		var cells_variant: Variant = stamp_data.get("cells", [])
		if typeof(cells_variant) == TYPE_ARRAY and not (cells_variant as Array).is_empty():
			return true

	if stamp_data.has("rect"):
		var rect_variant: Variant = stamp_data.get("rect", [])
		if typeof(rect_variant) == TYPE_ARRAY and (rect_variant as Array).size() == 4:
			return true

	return false


func _resolve_stamp_cell_indices(stamp_data: Dictionary) -> Array[Vector2i]:
	if stamp_data.has("cells"):
		var parsed_cells: Array[Vector2i] = _parse_cell_index_list_from_stamp(stamp_data)
		if not parsed_cells.is_empty():
			return parsed_cells

	if stamp_data.has("rect"):
		var rect_array: Array = stamp_data.get("rect", []) as Array
		if rect_array.size() == 4:
			var stamp_rect := Rect2i(
				Vector2i(int(rect_array[0]), int(rect_array[1])),
				Vector2i(int(rect_array[2]), int(rect_array[3]))
			)
			return _collect_rect_stamp_cells(stamp_rect)

	return []


func _collect_rect_stamp_cells(stamp_rect: Rect2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var end_x: int = stamp_rect.position.x + stamp_rect.size.x
	var end_y: int = stamp_rect.position.y + stamp_rect.size.y

	for y: int in range(stamp_rect.position.y, end_y):
		for x: int in range(stamp_rect.position.x, end_x):
			result.append(Vector2i(x, y))

	return result


func _parse_cell_index_list_from_stamp(stamp_data: Dictionary) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var seen_keys: Dictionary = {}

	var cells_variant: Variant = stamp_data.get("cells", [])
	if typeof(cells_variant) != TYPE_ARRAY:
		return result

	var cells_array: Array = cells_variant as Array
	for cell_variant: Variant in cells_array:
		if typeof(cell_variant) != TYPE_ARRAY:
			continue

		var cell_array: Array = cell_variant as Array
		if cell_array.size() != 2:
			continue

		var cell_index := Vector2i(int(cell_array[0]), int(cell_array[1]))
		var cell_key: String = "%s,%s" % [cell_index.x, cell_index.y]
		if seen_keys.has(cell_key):
			continue

		seen_keys[cell_key] = true
		result.append(cell_index)

	return result


func _build_patch_bounds_from_cells(cell_indices: Array[Vector2i]) -> Rect2i:
	if cell_indices.is_empty():
		return Rect2i()

	var min_x: int = cell_indices[0].x
	var min_y: int = cell_indices[0].y
	var max_x: int = cell_indices[0].x
	var max_y: int = cell_indices[0].y

	for cell_index: Vector2i in cell_indices:
		min_x = mini(min_x, cell_index.x)
		min_y = mini(min_y, cell_index.y)
		max_x = maxi(max_x, cell_index.x)
		max_y = maxi(max_y, cell_index.y)

	return Rect2i(
		Vector2i(min_x, min_y),
		Vector2i(max_x - min_x + 1, max_y - min_y + 1)
	)

func _create_default_cells(world_state: WorldState, default_cell_values: Dictionary) -> void:
	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var world_position: Vector2 = _build_cell_world_position(world_state, cell_index)

			var cell_state: WorldCellState = WorldCellState.new()
			cell_state.cell_index = cell_index
			cell_state.world_position = world_position
			cell_state.apply_values(default_cell_values)

			world_state.add_cell(cell_state)


func _apply_stamps(world_state: WorldState, stamps: Array) -> bool:
	for stamp_variant: Variant in stamps:
		if not (stamp_variant is Dictionary):
			continue

		var stamp_data: Dictionary = stamp_variant as Dictionary
		var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
		var stamp_tags: PackedStringArray = _variant_to_packed_string_array(
			stamp_data.get("source_tags", [])
		)

		var resolved_cell_indices: Array[Vector2i] = _resolve_stamp_cell_indices(stamp_data)
		var applied_cell_indices: Array[Vector2i] = []

		for stamp_cell_index: Vector2i in resolved_cell_indices:
			if not world_state.is_cell_index_in_bounds(stamp_cell_index):
				continue
			applied_cell_indices.append(stamp_cell_index)

		if applied_cell_indices.is_empty():
			world_state.add_generation_warning(
				"Stamp '%s' resolved to no in-bounds cells and was skipped." % stamp_id
			)
			continue

		if applied_cell_indices.size() != resolved_cell_indices.size():
			world_state.add_generation_warning(
				"Stamp '%s' included out-of-bounds cells; only in-bounds cells were applied." % stamp_id
			)

		var patch_state: WorldPatchState = _build_patch_state_from_stamp(
			stamp_id,
			stamp_data,
			applied_cell_indices,
			stamp_tags
		)

		var cell_apply_values: Dictionary = _build_cell_apply_values(stamp_data)

		for stamp_cell_index: Vector2i in applied_cell_indices:
			var cell_state: WorldCellState = world_state.get_cell(stamp_cell_index)
			if cell_state == null:
				continue

			cell_state.apply_values(cell_apply_values)
			cell_state.zone_stamp_id = stamp_id

			if not patch_state.patch_id.is_empty():
				var updated_patch_ids: PackedStringArray = cell_state.patch_ids
				if updated_patch_ids.find(patch_state.patch_id) == -1:
					updated_patch_ids.append(patch_state.patch_id)
					cell_state.patch_ids = updated_patch_ids

		_record_visibility_paint_warning_if_needed(world_state, stamp_id, stamp_data)
		patch_state.finalize_from_world_state(world_state)
		world_state.add_patch(patch_state)

	return true

func _build_cell_apply_values(stamp_data: Dictionary) -> Dictionary:
	var cell_apply_values: Dictionary = {}

	var passthrough_keys: Array[String] = [
		"elevation_step",
		"slope_class",
		"landform_type",
		"surface_water_type",
		"drainage_class",
		"wetness_tendency",
		"ground_firmness_class",
		"vegetation_cover_class",
		"movement_cost",
		"haul_cost_multiplier",
		"is_buildable",
		"fog_state",
		"is_revealed",
		"is_currently_visible",
		"first_revealed_tick",
		"last_seen_tick",
		"survey_quality_class",
		"terrain_confidence_class",
	]

	for key: String in passthrough_keys:
		if stamp_data.has(key):
			cell_apply_values[key] = stamp_data.get(key)

	# Map authored stamp POI tags into the cell field name used by WorldCellState.
	if stamp_data.has("poi_tags"):
		cell_apply_values["point_of_interest_tags"] = stamp_data.get("poi_tags", [])
	elif stamp_data.has("point_of_interest_tags"):
		cell_apply_values["point_of_interest_tags"] = stamp_data.get("point_of_interest_tags", [])

	return cell_apply_values

func _build_patch_state_from_stamp(
	stamp_id: String,
	stamp_data: Dictionary,
	cell_indices: Array[Vector2i],
	stamp_tags: PackedStringArray
) -> WorldPatchState:
	var patch_state := WorldPatchState.new()
	var patch_bounds: Rect2i = _build_patch_bounds_from_cells(cell_indices)

	patch_state.patch_id = stamp_id
	patch_state.patch_type = "authored_cells" if stamp_data.has("cells") else "authored_rect"
	patch_state.source_stamp_id = stamp_id
	patch_state.set_source_tags(stamp_tags)
	patch_state.rect_position = patch_bounds.position
	patch_state.rect_size = patch_bounds.size

	for cell_index: Vector2i in cell_indices:
		patch_state.add_cell_index(cell_index)
		patch_state.add_cell_key(_build_cell_key(cell_index))

	var point_of_interest_tags: PackedStringArray = _variant_to_packed_string_array(
		stamp_data.get("poi_tags", [])
	)
	if point_of_interest_tags.is_empty() and stamp_data.has("point_of_interest_tags"):
		point_of_interest_tags = _variant_to_packed_string_array(
			stamp_data.get("point_of_interest_tags", [])
		)
	patch_state.set_point_of_interest_tags(point_of_interest_tags)

	# Keep the simple patch summary fields populated from authored content.
	patch_state.landform_type = str(stamp_data.get("landform_type", "")).strip_edges()
	patch_state.surface_water_type = str(stamp_data.get("surface_water_type", "none")).strip_edges()
	patch_state.drainage_class = str(stamp_data.get("drainage_class", "")).strip_edges()
	patch_state.wetness_tendency = str(stamp_data.get("wetness_tendency", "")).strip_edges()
	patch_state.vegetation_cover_class = str(
		stamp_data.get("vegetation_cover_class", "")
	).strip_edges()
	patch_state.is_buildable = bool(stamp_data.get("is_buildable", false))

	if stamp_data.has("site_score"):
		patch_state.site_score = float(stamp_data.get("site_score", 0.0))
		patch_state.has_authored_site_score = true

	return patch_state

func _build_chunks(world_state: WorldState) -> void:
	var chunk_size_cells: int = max(world_state.chunk_size_cells, 1)
	var chunk_count_x: int = int(ceil(float(world_state.world_width_cells) / float(chunk_size_cells)))
	var chunk_count_y: int = int(ceil(float(world_state.world_height_cells) / float(chunk_size_cells)))

	for chunk_y: int in range(chunk_count_y):
		for chunk_x: int in range(chunk_count_x):
			var chunk_state: WorldChunkState = WorldChunkState.new()
			chunk_state.chunk_id = "chunk_%d_%d" % [chunk_x, chunk_y]

			var origin_cell: Vector2i = Vector2i(
				chunk_x * chunk_size_cells,
				chunk_y * chunk_size_cells
			)
			var size_cells: Vector2i = Vector2i(
				min(chunk_size_cells, world_state.world_width_cells - origin_cell.x),
				min(chunk_size_cells, world_state.world_height_cells - origin_cell.y)
			)

			chunk_state.origin_cell = origin_cell
			chunk_state.size_cells = size_cells

			for local_y: int in range(size_cells.y):
				for local_x: int in range(size_cells.x):
					var cell_index: Vector2i = Vector2i(
						origin_cell.x + local_x,
						origin_cell.y + local_y
					)
					var cell_key: String = _build_cell_key(cell_index)
					chunk_state.add_cell_key(cell_key)

					var cell_state: WorldCellState = world_state.get_cell(cell_index)
					if cell_state != null:
						cell_state.chunk_id = chunk_state.chunk_id

			world_state.add_chunk(chunk_state)


func _apply_debug_focus_cells(world_state: WorldState, debug_focus_cells: Array) -> void:
	var focus_entries: Array[Dictionary] = []

	for focus_variant: Variant in debug_focus_cells:
		if not (focus_variant is Dictionary):
			continue

		var focus_data: Dictionary = focus_variant as Dictionary
		var label: String = str(focus_data.get("label", "")).strip_edges()
		var cell_index: Vector2i = _variant_to_cell_index(focus_data.get("cell", []))
		if not world_state.is_cell_index_in_bounds(cell_index):
			continue

		var cell_state: WorldCellState = world_state.get_cell(cell_index)
		if cell_state == null:
			continue

		var focus_entry: Dictionary = {
			"focus_id": label,
			"label": label,
			"cell_index": cell_index,
			"landform_type": cell_state.landform_type,
			"slope_class": cell_state.slope_class,
			"drainage_class": cell_state.drainage_class,
			"wetness_tendency": cell_state.wetness_tendency,
			"surface_water_type": cell_state.surface_water_type,
			"vegetation_cover_class": cell_state.vegetation_cover_class,
			"is_buildable": cell_state.is_buildable,
			"point_of_interest_tags": cell_state.point_of_interest_tags,
		}

		focus_entries.append(focus_entry)

	world_state.set_debug_focus_entries(focus_entries)


func _apply_reveal_sources(world_state: WorldState, reveal_sources: Array) -> bool:
	for reveal_source_variant: Variant in reveal_sources:
		if not (reveal_source_variant is Dictionary):
			continue

		var reveal_source_data: Dictionary = reveal_source_variant as Dictionary
		var source_id: String = str(reveal_source_data.get("source_id", "")).strip_edges()
		if source_id.is_empty():
			push_error("AuthoredMapLoader: Reveal source was missing source_id.")
			return false

		var source_cell_index: Vector2i = _build_reveal_source_cell_index(reveal_source_data)
		if not world_state.is_cell_index_in_bounds(source_cell_index):
			push_error(
				"AuthoredMapLoader: Reveal source '%s' had out-of-bounds cell index %s." %
				[source_id, str(source_cell_index)]
			)
			return false

		var reveal_source_state: WorldRevealSourceState = WorldRevealSourceState.new()
		reveal_source_state.source_id = source_id
		reveal_source_state.source_type = str(
			reveal_source_data.get("source_type", "generic")
		).strip_edges()
		reveal_source_state.display_label = str(
			reveal_source_data.get("display_label", source_id)
		).strip_edges()
		reveal_source_state.center_cell_index = source_cell_index
		reveal_source_state.visible_radius_cells = int(reveal_source_data.get("visible_radius_cells", 0))
		reveal_source_state.remembered_radius_cells = int(
			reveal_source_data.get("remembered_radius_cells", reveal_source_state.visible_radius_cells)
		)
		reveal_source_state.is_active = bool(reveal_source_data.get("is_enabled", true))
		reveal_source_state.survey_quality_visible_class = str(
			reveal_source_data.get("survey_quality_visible_class", "walked")
		).strip_edges()
		reveal_source_state.survey_quality_remembered_class = str(
			reveal_source_data.get("survey_quality_remembered_class", "glanced")
		).strip_edges()
		reveal_source_state.terrain_confidence_visible_class = str(
			reveal_source_data.get("terrain_confidence_visible_class", "good")
		).strip_edges()
		reveal_source_state.terrain_confidence_remembered_class = str(
			reveal_source_data.get("terrain_confidence_remembered_class", "rough")
		).strip_edges()

		world_state.add_reveal_source(reveal_source_state)

	return true


func _apply_authored_terrain_objects(world_state: WorldState, terrain_objects: Array) -> bool:
	for terrain_object_variant: Variant in terrain_objects:
		if not (terrain_object_variant is Dictionary):
			continue

		var terrain_object_data: Dictionary = terrain_object_variant as Dictionary
		var object_id: String = str(terrain_object_data.get("object_id", "")).strip_edges()
		if object_id.is_empty():
			push_error("AuthoredMapLoader: terrain_object was missing object_id.")
			return false

		var cell_index: Vector2i = _variant_to_cell_index(terrain_object_data.get("cell", []))
		if not world_state.is_cell_index_in_bounds(cell_index):
			var out_of_bounds_message: String = (
				"Authored terrain object '%s' had out-of-bounds cell index %s." %
				[object_id, str(cell_index)]
			)
			world_state.add_generation_warning(out_of_bounds_message)
			push_warning("AuthoredMapLoader: %s" % out_of_bounds_message)
			continue

		var cell_state: WorldCellState = world_state.get_cell(cell_index)
		if cell_state == null:
			var missing_cell_message: String = (
				"Authored terrain object '%s' could not resolve its target cell." % object_id
			)
			world_state.add_generation_warning(missing_cell_message)
			push_warning("AuthoredMapLoader: %s" % missing_cell_message)
			continue

		var object_record: Dictionary = _build_authored_terrain_object_record(
			terrain_object_data,
			cell_state
		)
		world_state.add_authored_terrain_object(object_record)

		var is_valid_placement: bool = bool(object_record.get("is_valid_placement", false))
		if is_valid_placement:
			continue

		var validation_messages_variant: Variant = object_record.get("validation_messages", [])
		if not (validation_messages_variant is Array):
			continue

		var validation_messages: Array = validation_messages_variant as Array
		for validation_message_variant: Variant in validation_messages:
			var validation_message: String = str(validation_message_variant).strip_edges()
			if validation_message.is_empty():
				continue

			var full_warning_text: String = "Authored terrain object '%s': %s" % [
				object_id,
				validation_message,
			]
			world_state.add_generation_warning(full_warning_text)
			push_warning("AuthoredMapLoader: %s" % full_warning_text)

	return true


func _build_authored_terrain_object_record(
	terrain_object_data: Dictionary,
	cell_state: WorldCellState
) -> Dictionary:
	var object_id: String = str(terrain_object_data.get("object_id", "")).strip_edges()
	var object_type: String = str(terrain_object_data.get("object_type", "")).strip_edges()
	var placement_family: String = str(
		terrain_object_data.get("placement_family", "")
	).strip_edges()
	var display_label: String = str(
		terrain_object_data.get("display_label", object_type)
	).strip_edges()
	var source_stamp_id: String = str(
		terrain_object_data.get("source_stamp_id", "")
	).strip_edges()

	var validation_messages: Array[String] = _validate_authored_terrain_object_placement(
		placement_family,
		cell_state
	)
	var tags: Array[String] = _variant_to_string_array(terrain_object_data.get("tags", []))

	return {
		"object_id": object_id,
		"object_type": object_type,
		"placement_family": placement_family,
		"display_label": display_label,
		"source_stamp_id": source_stamp_id,
		"cell_index": cell_state.cell_index,
		"cell_world_position": cell_state.world_position,
		"is_valid_placement": validation_messages.is_empty(),
		"validation_status": "valid" if validation_messages.is_empty() else "invalid",
		"validation_messages": validation_messages,
		"tags": tags,
	}


func _validate_authored_terrain_object_placement(
	placement_family: String,
	cell_state: WorldCellState
) -> Array[String]:
	var validation_messages: Array[String] = []

	match placement_family:
		"tree":
			if cell_state.surface_water_type != "none":
				validation_messages.append(
					"trees cannot be authored inside open-water or channel cells"
				)

			if cell_state.wetness_tendency == "saturated":
				validation_messages.append(
					"trees currently require non-saturated ground in Branch 04"
				)

			if cell_state.drainage_class == "poor":
				validation_messages.append(
					"trees currently require better-than-poor drainage in Branch 04"
				)

			if cell_state.vegetation_cover_class == "wetland":
				validation_messages.append(
					"trees currently do not validate inside wetland vegetation cells"
				)

		"wet_margin_plant":
			if cell_state.surface_water_type != "none":
				validation_messages.append(
					"wet-margin plants should be authored on the bank, not inside open water"
				)
			elif not _cell_supports_wet_margin_plants(cell_state):
				validation_messages.append(
					"wet-margin plants require wet/saturated, poorly drained, depression, channel-adjacent, or wetland cells"
				)

		"rocky_marker":
			if not _cell_supports_rocky_markers(cell_state):
				validation_messages.append(
					"rocky markers currently validate on ridge or slope cells"
				)

		_:
			validation_messages.append(
				"unknown placement_family '%s'" % placement_family
			)

	return validation_messages


func _cell_supports_wet_margin_plants(cell_state: WorldCellState) -> bool:
	if cell_state.wetness_tendency == "wet":
		return true

	if cell_state.wetness_tendency == "saturated":
		return true

	if cell_state.drainage_class == "poor":
		return true

	if cell_state.landform_type == "depression":
		return true

	if cell_state.landform_type == "channel":
		return true

	if cell_state.vegetation_cover_class == "wetland":
		return true

	return false


func _cell_supports_rocky_markers(cell_state: WorldCellState) -> bool:
	if cell_state.landform_type == "ridge":
		return true

	if cell_state.landform_type == "slope":
		return true

	return false


func _record_visibility_paint_warning_if_needed(
	world_state: WorldState,
	stamp_id: String,
	stamp_data: Dictionary
) -> void:
	var forbidden_visibility_keys: Array[String] = [
		"fog_state",
		"is_revealed",
		"is_currently_visible",
		"first_revealed_tick",
		"last_seen_tick",
		"survey_quality_class",
		"terrain_confidence_class",
	]

	var found_visibility_key: String = ""
	for visibility_key: String in forbidden_visibility_keys:
		if not stamp_data.has(visibility_key):
			continue

		found_visibility_key = visibility_key
		break

	if found_visibility_key.is_empty():
		return

	var warning_text: String = (
		"Stamp '%s' still paints visibility field '%s'. Use reveal_sources for authored visibility instead." %
		[stamp_id, found_visibility_key]
	)

	world_state.add_generation_warning(warning_text)
	push_warning("AuthoredMapLoader: %s" % warning_text)


func _build_reveal_source_cell_index(reveal_source_data: Dictionary) -> Vector2i:
	if reveal_source_data.has("cell"):
		return _variant_to_cell_index(reveal_source_data.get("cell", []))

	if reveal_source_data.has("center_cell"):
		return _variant_to_cell_index(reveal_source_data.get("center_cell", []))

	return INVALID_CELL_INDEX


func _build_cell_world_position(world_state: WorldState, cell_index: Vector2i) -> Vector2:
	var cell_size_pixels: float = float(world_state.cell_size_pixels)
	return Vector2(
		(float(cell_index.x) + 0.5) * cell_size_pixels,
		(float(cell_index.y) + 0.5) * cell_size_pixels
	)


func _build_cell_key(cell_index: Vector2i) -> String:
	return "%s,%s" % [str(cell_index.x), str(cell_index.y)]


func _variant_to_rect2i(value: Variant) -> Rect2i:
	if not (value is Array):
		return Rect2i()

	var rect_values: Array = value as Array
	if rect_values.size() != 4:
		return Rect2i()

	return Rect2i(
		Vector2i(int(rect_values[0]), int(rect_values[1])),
		Vector2i(int(rect_values[2]), int(rect_values[3]))
	)


func _variant_to_cell_index(value: Variant) -> Vector2i:
	if not (value is Array):
		return INVALID_CELL_INDEX

	var cell_values: Array = value as Array
	if cell_values.size() != 2:
		return INVALID_CELL_INDEX

	return Vector2i(int(cell_values[0]), int(cell_values[1]))


func _variant_to_packed_string_array(value: Variant) -> PackedStringArray:
	var result: PackedStringArray = PackedStringArray()

	if not (value is Array):
		return result

	var values: Array = value as Array
	for entry_variant: Variant in values:
		var entry_text: String = str(entry_variant).strip_edges()
		if entry_text.is_empty():
			continue

		if not result.has(entry_text):
			result.append(entry_text)

	return result


func _variant_to_string_array(value: Variant) -> Array[String]:
	var result: Array[String] = []

	if not (value is Array):
		return result

	var values: Array = value as Array
	for entry_variant: Variant in values:
		var entry_text: String = str(entry_variant).strip_edges()
		if entry_text.is_empty():
			continue

		if result.has(entry_text):
			continue

		result.append(entry_text)

	return result


func _merge_string_arrays(
	base_values: PackedStringArray,
	added_values: PackedStringArray
) -> PackedStringArray:
	var merged_values: PackedStringArray = PackedStringArray()

	for value_text: String in base_values:
		if not merged_values.has(value_text):
			merged_values.append(value_text)

	for value_text: String in added_values:
		if not merged_values.has(value_text):
			merged_values.append(value_text)

	return merged_values
