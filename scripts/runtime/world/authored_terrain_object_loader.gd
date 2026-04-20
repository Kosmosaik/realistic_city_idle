extends RefCounted
class_name AuthoredTerrainObjectLoader

const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

func apply_authored_terrain_objects(world_state: WorldState, terrain_objects: Array) -> bool:
	if world_state == null:
		push_error("AuthoredTerrainObjectLoader: world_state was null.")
		return false

	for terrain_object_variant: Variant in terrain_objects:
		if not (terrain_object_variant is Dictionary):
			continue

		var terrain_object_data: Dictionary = terrain_object_variant as Dictionary
		var object_id: String = str(terrain_object_data.get("object_id", "")).strip_edges()
		if object_id.is_empty():
			push_error("AuthoredTerrainObjectLoader: terrain_object was missing object_id.")
			return false

		var cell_index: Vector2i = _variant_to_cell_index(terrain_object_data.get("cell", []))
		if not world_state.is_cell_index_in_bounds(cell_index):
			var out_of_bounds_message: String = (
				"Authored terrain object '%s' had out-of-bounds cell index %s." %
				[object_id, str(cell_index)]
			)
			world_state.add_generation_warning(out_of_bounds_message)
			push_warning("AuthoredTerrainObjectLoader: %s" % out_of_bounds_message)
			continue

		var cell_state: WorldCellState = world_state.get_cell(cell_index)
		if cell_state == null:
			var missing_cell_message: String = (
				"Authored terrain object '%s' could not resolve its target cell." % object_id
			)
			world_state.add_generation_warning(missing_cell_message)
			push_warning("AuthoredTerrainObjectLoader: %s" % missing_cell_message)
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
			push_warning("AuthoredTerrainObjectLoader: %s" % full_warning_text)

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

	var validation_messages: Array[String] = TerrainObjectPlacementValidator.validate_placement(
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


func _variant_to_cell_index(value: Variant) -> Vector2i:
	if not (value is Array):
		return INVALID_CELL_INDEX

	var cell_values: Array = value as Array
	if cell_values.size() != 2:
		return INVALID_CELL_INDEX

	return Vector2i(int(cell_values[0]), int(cell_values[1]))


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
