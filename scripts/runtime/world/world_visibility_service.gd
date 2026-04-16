extends RefCounted
class_name WorldVisibilityService

var _world_state: WorldState = null

func bind_world_state(world_state: WorldState) -> void:
	_world_state = world_state

func unbind_world_state() -> void:
	_world_state = null

func refresh_now(tick_index: int = -1) -> bool:
	var phase_context: Dictionary = {
		"tick_index": tick_index,
	}
	return _apply_visibility_refresh(phase_context)

func _on_visibility_refresh_phase(phase_context: Dictionary) -> void:
	_apply_visibility_refresh(phase_context)

func _apply_visibility_refresh(phase_context: Dictionary) -> bool:
	if _world_state == null:
		return false

	var tick_index: int = int(phase_context.get("tick_index", -1))
	var any_changed: bool = false
	var all_cell_keys: PackedStringArray = _world_state.get_all_cell_keys()

	# Step 1: clear transient "currently visible" state from the previous refresh.
	for cell_key: String in all_cell_keys:
		var cell_state: WorldCellState = _world_state.get_cell_by_key(cell_key)
		if cell_state == null:
			continue

		if cell_state.is_currently_visible:
			cell_state.is_currently_visible = false
			any_changed = true

		if cell_state.fog_state == "visible" and cell_state.is_revealed:
			cell_state.fog_state = "remembered"
			any_changed = true

	# Step 2: apply all active reveal sources.
	var reveal_sources: Array[WorldRevealSourceState] = _world_state.get_all_reveal_sources()
	for reveal_source_state: WorldRevealSourceState in reveal_sources:
		if reveal_source_state == null:
			continue

		if not reveal_source_state.is_active:
			continue

		var source_changed: bool = _apply_reveal_source(reveal_source_state, tick_index)
		if source_changed:
			any_changed = true

	# Step 3: normalize final fog state.
	for cell_key: String in all_cell_keys:
		var cell_state: WorldCellState = _world_state.get_cell_by_key(cell_key)
		if cell_state == null:
			continue

		if cell_state.is_currently_visible:
			if cell_state.fog_state != "visible":
				cell_state.fog_state = "visible"
				any_changed = true
			continue

		if cell_state.is_revealed:
			if cell_state.fog_state != "remembered":
				cell_state.fog_state = "remembered"
				any_changed = true
		else:
			if cell_state.fog_state != "unknown":
				cell_state.fog_state = "unknown"
				any_changed = true

	if any_changed:
		_world_state.bump_visibility_revision()

	return any_changed

func _apply_reveal_source(reveal_source_state: WorldRevealSourceState, tick_index: int) -> bool:
	var any_changed: bool = false
	var center_cell_index: Vector2i = reveal_source_state.center_cell_index
	var visible_radius_cells: int = maxi(reveal_source_state.visible_radius_cells, 0)
	var remembered_radius_cells: int = maxi(reveal_source_state.remembered_radius_cells, visible_radius_cells)

	var min_x: int = maxi(center_cell_index.x - remembered_radius_cells, 0)
	var max_x: int = mini(center_cell_index.x + remembered_radius_cells, _world_state.world_width_cells - 1)
	var min_y: int = maxi(center_cell_index.y - remembered_radius_cells, 0)
	var max_y: int = mini(center_cell_index.y + remembered_radius_cells, _world_state.world_height_cells - 1)

	var visible_radius_squared: int = visible_radius_cells * visible_radius_cells
	var remembered_radius_squared: int = remembered_radius_cells * remembered_radius_cells

	for cell_y: int in range(min_y, max_y + 1):
		for cell_x: int in range(min_x, max_x + 1):
			var cell_index: Vector2i = Vector2i(cell_x, cell_y)
			var delta_x: int = cell_x - center_cell_index.x
			var delta_y: int = cell_y - center_cell_index.y
			var distance_squared: int = (delta_x * delta_x) + (delta_y * delta_y)

			if distance_squared > remembered_radius_squared:
				continue

			var cell_state: WorldCellState = _world_state.get_cell(cell_index)
			if cell_state == null:
				continue

			if distance_squared <= visible_radius_squared:
				var visible_changed: bool = _apply_visible_state(cell_state, reveal_source_state, tick_index)
				if visible_changed:
					any_changed = true
			else:
				var remembered_changed: bool = _apply_remembered_state(cell_state, reveal_source_state, tick_index)
				if remembered_changed:
					any_changed = true

	return any_changed

func _apply_visible_state(
	cell_state: WorldCellState,
	reveal_source_state: WorldRevealSourceState,
	tick_index: int
) -> bool:
	var any_changed: bool = false

	if not cell_state.is_revealed:
		cell_state.is_revealed = true
		any_changed = true

	if not cell_state.is_currently_visible:
		cell_state.is_currently_visible = true
		any_changed = true

	if cell_state.fog_state != "visible":
		cell_state.fog_state = "visible"
		any_changed = true

	if cell_state.first_revealed_tick < 0 and tick_index >= 0:
		cell_state.first_revealed_tick = tick_index
		any_changed = true

	if tick_index >= 0 and cell_state.last_seen_tick != tick_index:
		cell_state.last_seen_tick = tick_index
		any_changed = true

	var upgraded_survey_quality: String = _upgrade_ranked_value(
		cell_state.survey_quality_class,
		reveal_source_state.survey_quality_visible_class,
		SharedEnums.SURVEY_QUALITY_CLASSES
	)
	if upgraded_survey_quality != cell_state.survey_quality_class:
		cell_state.survey_quality_class = upgraded_survey_quality
		any_changed = true

	var upgraded_terrain_confidence: String = _upgrade_ranked_value(
		cell_state.terrain_confidence_class,
		reveal_source_state.terrain_confidence_visible_class,
		SharedEnums.TERRAIN_CONFIDENCE_CLASSES
	)
	if upgraded_terrain_confidence != cell_state.terrain_confidence_class:
		cell_state.terrain_confidence_class = upgraded_terrain_confidence
		any_changed = true

	return any_changed

func _apply_remembered_state(
	cell_state: WorldCellState,
	reveal_source_state: WorldRevealSourceState,
	tick_index: int
) -> bool:
	var any_changed: bool = false

	if cell_state.is_currently_visible:
		return false

	if not cell_state.is_revealed:
		cell_state.is_revealed = true
		any_changed = true

	if cell_state.fog_state != "remembered":
		cell_state.fog_state = "remembered"
		any_changed = true

	if cell_state.first_revealed_tick < 0 and tick_index >= 0:
		cell_state.first_revealed_tick = tick_index
		any_changed = true

	var upgraded_survey_quality: String = _upgrade_ranked_value(
		cell_state.survey_quality_class,
		reveal_source_state.survey_quality_remembered_class,
		SharedEnums.SURVEY_QUALITY_CLASSES
	)
	if upgraded_survey_quality != cell_state.survey_quality_class:
		cell_state.survey_quality_class = upgraded_survey_quality
		any_changed = true

	var upgraded_terrain_confidence: String = _upgrade_ranked_value(
		cell_state.terrain_confidence_class,
		reveal_source_state.terrain_confidence_remembered_class,
		SharedEnums.TERRAIN_CONFIDENCE_CLASSES
	)
	if upgraded_terrain_confidence != cell_state.terrain_confidence_class:
		cell_state.terrain_confidence_class = upgraded_terrain_confidence
		any_changed = true

	return any_changed

func _upgrade_ranked_value(current_value: String, candidate_value: String, ordered_values: Array[String]) -> String:
	if candidate_value.is_empty():
		return current_value

	var current_index: int = ordered_values.find(current_value)
	var candidate_index: int = ordered_values.find(candidate_value)

	if candidate_index < 0:
		return current_value

	if current_index < 0:
		return candidate_value

	if candidate_index > current_index:
		return candidate_value

	return current_value
