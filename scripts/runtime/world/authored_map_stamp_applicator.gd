extends RefCounted
class_name AuthoredMapStampApplicator

func apply_default_cells(world_state: WorldState, default_cell_values: Dictionary) -> void:
	if world_state == null:
		push_error("AuthoredMapStampApplicator: world_state was null.")
		return

	for y: int in range(world_state.world_height_cells):
		for x: int in range(world_state.world_width_cells):
			var cell_index: Vector2i = Vector2i(x, y)
			var world_position: Vector2 = _build_cell_world_position(world_state, cell_index)

			var cell_state: WorldCellState = WorldCellState.new()
			cell_state.cell_index = cell_index
			cell_state.world_position = world_position
			cell_state.apply_values(default_cell_values)

			world_state.add_cell(cell_state)


func apply_stamps(world_state: WorldState, stamps: Array) -> bool:
	if world_state == null:
		push_error("AuthoredMapStampApplicator: world_state was null.")
		return false

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
				"Stamp '%s' included out-of-bounds cells; only in-bounds cells were applied." %
				stamp_id
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

		# Finalize patch summaries after the authored cell values have been written.
		patch_state.finalize_from_world_state(world_state)
		world_state.add_patch(patch_state)

	return true


func _resolve_stamp_cell_indices(stamp_data: Dictionary) -> Array[Vector2i]:
	if stamp_data.has("cells"):
		var parsed_cells: Array[Vector2i] = _parse_cell_index_list_from_stamp(stamp_data)
		if not parsed_cells.is_empty():
			return parsed_cells

	if stamp_data.has("rect"):
		var rect_array: Array = stamp_data.get("rect", []) as Array
		if rect_array.size() == 4:
			var stamp_rect: Rect2i = Rect2i(
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

		var cell_index: Vector2i = Vector2i(int(cell_array[0]), int(cell_array[1]))
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


func _build_cell_apply_values(stamp_data: Dictionary) -> Dictionary:
	var cell_apply_values: Dictionary = {}
	var supported_keys: Array[String] = (
		AuthoredMapFixtureValidator.get_supported_stamp_cell_value_keys()
	)

	for key: String in supported_keys:
		if stamp_data.has(key):
			cell_apply_values[key] = stamp_data.get(key)

	if stamp_data.has("poi_tags"):
		cell_apply_values["point_of_interest_tags"] = stamp_data.get("poi_tags", [])

	if stamp_data.has("point_of_interest_tags"):
		cell_apply_values["point_of_interest_tags"] = (
			stamp_data.get("point_of_interest_tags", [])
		)

	return cell_apply_values


func _build_patch_state_from_stamp(
	stamp_id: String,
	stamp_data: Dictionary,
	cell_indices: Array[Vector2i],
	stamp_tags: PackedStringArray
) -> WorldPatchState:
	var patch_state: WorldPatchState = WorldPatchState.new()
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

	# Keep current authored summary fields populated for compatibility.
	patch_state.landform_type = str(stamp_data.get("landform_type", "")).strip_edges()
	patch_state.surface_water_type = str(
		stamp_data.get("surface_water_type", "none")
	).strip_edges()
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


func _build_cell_world_position(world_state: WorldState, cell_index: Vector2i) -> Vector2:
	var cell_size_pixels: float = float(world_state.cell_size_pixels)
	return Vector2(
		(float(cell_index.x) + 0.5) * cell_size_pixels,
		(float(cell_index.y) + 0.5) * cell_size_pixels
	)


func _build_cell_key(cell_index: Vector2i) -> String:
	return "%s,%s" % [str(cell_index.x), str(cell_index.y)]


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
