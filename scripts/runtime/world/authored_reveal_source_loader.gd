extends RefCounted
class_name AuthoredRevealSourceLoader

const INVALID_CELL_INDEX: Vector2i = Vector2i(-1, -1)

func apply_reveal_sources(world_state: WorldState, reveal_sources: Array) -> bool:
	if world_state == null:
		push_error("AuthoredRevealSourceLoader: world_state was null.")
		return false

	for reveal_source_variant: Variant in reveal_sources:
		if not (reveal_source_variant is Dictionary):
			continue

		var reveal_source_data: Dictionary = reveal_source_variant as Dictionary
		var source_id: String = str(reveal_source_data.get("source_id", "")).strip_edges()
		if source_id.is_empty():
			push_error("AuthoredRevealSourceLoader: Reveal source was missing source_id.")
			return false

		var source_cell_index: Vector2i = _build_reveal_source_cell_index(reveal_source_data)
		if not world_state.is_cell_index_in_bounds(source_cell_index):
			push_error(
				"AuthoredRevealSourceLoader: Reveal source '%s' had out-of-bounds cell index %s." %
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
		reveal_source_state.visible_radius_cells = int(
			reveal_source_data.get("visible_radius_cells", 0)
		)
		reveal_source_state.remembered_radius_cells = int(
			reveal_source_data.get(
				"remembered_radius_cells",
				reveal_source_state.visible_radius_cells
			)
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


func _build_reveal_source_cell_index(reveal_source_data: Dictionary) -> Vector2i:
	if reveal_source_data.has("cell"):
		return _variant_to_cell_index(reveal_source_data.get("cell", []))

	if reveal_source_data.has("center_cell"):
		return _variant_to_cell_index(reveal_source_data.get("center_cell", []))

	return INVALID_CELL_INDEX


func _variant_to_cell_index(value: Variant) -> Vector2i:
	if not (value is Array):
		return INVALID_CELL_INDEX

	var cell_values: Array = value as Array
	if cell_values.size() != 2:
		return INVALID_CELL_INDEX

	return Vector2i(int(cell_values[0]), int(cell_values[1]))
