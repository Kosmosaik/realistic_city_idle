extends RefCounted
class_name WorldState

var world_id: String = ""
var fixture_id: String = ""
var seed: int = 0
var world_width_cells: int = 0
var world_height_cells: int = 0
var cell_size_pixels: int = 0
var chunk_size_cells: int = 0
var primary_terrain_profile_id: String = ""

var visibility_revision: int = 0
var _cached_visibility_counts_revision: int = -1
var _cached_visibility_counts: Dictionary = {}

var _cells_by_key: Dictionary = {}
var _cell_order: PackedStringArray = PackedStringArray()

var _chunks_by_id: Dictionary = {}
var _chunk_order: PackedStringArray = PackedStringArray()

var _patches_by_id: Dictionary = {}
var _patch_order: PackedStringArray = PackedStringArray()

var _reveal_sources_by_id: Dictionary = {}
var _reveal_source_order: PackedStringArray = PackedStringArray()

var _authored_terrain_objects_by_id: Dictionary = {}
var _authored_terrain_object_order: PackedStringArray = PackedStringArray()
var _generation_warnings: PackedStringArray = PackedStringArray()

var _debug_focus_entries: Array[Dictionary] = []


func configure_dimensions(width_cells: int, height_cells: int, cell_size: int, chunk_size: int) -> void:
	world_width_cells = width_cells
	world_height_cells = height_cells
	cell_size_pixels = cell_size
	chunk_size_cells = chunk_size


func add_cell(cell_state: WorldCellState) -> void:
	if cell_state == null:
		return

	var cell_key: String = _build_cell_key(cell_state.cell_index)
	if not _cells_by_key.has(cell_key):
		_cell_order.append(cell_key)

	_cells_by_key[cell_key] = cell_state
	_invalidate_visibility_counts_cache()

func get_cell(cell_index: Vector2i) -> WorldCellState:
	return get_cell_by_key(_build_cell_key(cell_index))


func get_cell_by_key(cell_key: String) -> WorldCellState:
	if not _cells_by_key.has(cell_key):
		return null

	return _cells_by_key.get(cell_key, null) as WorldCellState


func get_all_cell_keys() -> PackedStringArray:
	return _cell_order


func get_all_cells() -> Array[WorldCellState]:
	var result: Array[WorldCellState] = []

	for cell_key: String in _cell_order:
		var cell_state: WorldCellState = get_cell_by_key(cell_key)
		if cell_state != null:
			result.append(cell_state)

	return result


func get_cell_count() -> int:
	return _cell_order.size()


func add_chunk(chunk_state: WorldChunkState) -> void:
	if chunk_state == null:
		return

	var chunk_id: String = chunk_state.chunk_id
	if chunk_id.is_empty():
		return

	if not _chunks_by_id.has(chunk_id):
		_chunk_order.append(chunk_id)

	_chunks_by_id[chunk_id] = chunk_state


func get_chunk(chunk_id: String) -> WorldChunkState:
	if not _chunks_by_id.has(chunk_id):
		return null

	return _chunks_by_id.get(chunk_id, null) as WorldChunkState


func get_all_chunk_ids() -> PackedStringArray:
	return _chunk_order


func get_chunk_count() -> int:
	return _chunk_order.size()


func add_patch(patch_state: WorldPatchState) -> void:
	if patch_state == null:
		return

	var patch_id: String = patch_state.patch_id
	if patch_id.is_empty():
		return

	if not _patches_by_id.has(patch_id):
		_patch_order.append(patch_id)

	_patches_by_id[patch_id] = patch_state


func get_patch(patch_id: String) -> WorldPatchState:
	if not _patches_by_id.has(patch_id):
		return null

	return _patches_by_id.get(patch_id, null) as WorldPatchState


func get_all_patch_ids() -> PackedStringArray:
	return _patch_order


func get_all_patches() -> Array[WorldPatchState]:
	var patch_states: Array[WorldPatchState] = []

	for patch_id: String in _patch_order:
		var patch_state: WorldPatchState = get_patch(patch_id)
		if patch_state == null:
			continue

		patch_states.append(patch_state)

	return patch_states


func get_patch_count() -> int:
	return _patch_order.size()


func add_reveal_source(reveal_source_state: WorldRevealSourceState) -> void:
	if reveal_source_state == null:
		return

	var source_id: String = reveal_source_state.source_id.strip_edges()
	if source_id.is_empty():
		return

	if not _reveal_sources_by_id.has(source_id):
		_reveal_source_order.append(source_id)

	_reveal_sources_by_id[source_id] = reveal_source_state


func get_reveal_source(source_id: String) -> WorldRevealSourceState:
	if not _reveal_sources_by_id.has(source_id):
		return null

	return _reveal_sources_by_id.get(source_id, null) as WorldRevealSourceState


func get_all_reveal_source_ids() -> PackedStringArray:
	return _reveal_source_order


func get_all_reveal_sources() -> Array[WorldRevealSourceState]:
	var result: Array[WorldRevealSourceState] = []

	for source_id: String in _reveal_source_order:
		var reveal_source_state: WorldRevealSourceState = get_reveal_source(source_id)
		if reveal_source_state != null:
			result.append(reveal_source_state)

	return result


func get_reveal_source_count() -> int:
	return _reveal_source_order.size()
	
func add_authored_terrain_object(object_entry: Dictionary) -> void:
	if object_entry.is_empty():
		return

	var object_id: String = str(object_entry.get("object_id", "")).strip_edges()
	if object_id.is_empty():
		return

	var stored_entry: Dictionary = object_entry.duplicate(true)

	if not _authored_terrain_objects_by_id.has(object_id):
		_authored_terrain_object_order.append(object_id)

	_authored_terrain_objects_by_id[object_id] = stored_entry


func get_authored_terrain_object_count() -> int:
	return _authored_terrain_object_order.size()


func get_all_authored_terrain_objects() -> Array[Dictionary]:
	var result: Array[Dictionary] = []

	for object_id: String in _authored_terrain_object_order:
		var object_entry_variant: Variant = _authored_terrain_objects_by_id.get(object_id, {})
		if not (object_entry_variant is Dictionary):
			continue

		var object_entry: Dictionary = object_entry_variant as Dictionary
		result.append(object_entry.duplicate(true))

	return result


func get_authored_terrain_objects_for_cell(cell_index: Vector2i) -> Array[Dictionary]:
	var result: Array[Dictionary] = []

	for object_id: String in _authored_terrain_object_order:
		var object_entry_variant: Variant = _authored_terrain_objects_by_id.get(object_id, {})
		if not (object_entry_variant is Dictionary):
			continue

		var object_entry: Dictionary = object_entry_variant as Dictionary
		var object_cell_index_variant: Variant = object_entry.get("cell_index", Vector2i(-1, -1))
		if not (object_cell_index_variant is Vector2i):
			continue

		var object_cell_index: Vector2i = object_cell_index_variant as Vector2i
		if object_cell_index != cell_index:
			continue

		result.append(object_entry.duplicate(true))

	return result


func add_generation_warning(warning_text: String) -> void:
	var normalized_warning_text: String = warning_text.strip_edges()
	if normalized_warning_text.is_empty():
		return

	if _generation_warnings.has(normalized_warning_text):
		return

	_generation_warnings.append(normalized_warning_text)


func get_generation_warning_count() -> int:
	return _generation_warnings.size()


func get_generation_warnings() -> PackedStringArray:
	var result: PackedStringArray = PackedStringArray()

	for warning_text: String in _generation_warnings:
		result.append(warning_text)

	return result


func bump_visibility_revision() -> void:
	visibility_revision += 1
	_invalidate_visibility_counts_cache()

func is_cell_index_in_bounds(cell_index: Vector2i) -> bool:
	if cell_index.x < 0:
		return false

	if cell_index.y < 0:
		return false

	if cell_index.x >= world_width_cells:
		return false

	if cell_index.y >= world_height_cells:
		return false

	return true


func get_cell_rect_world(cell_index: Vector2i) -> Rect2:
	var origin: Vector2 = Vector2(
		float(cell_index.x * cell_size_pixels),
		float(cell_index.y * cell_size_pixels)
	)

	return Rect2(origin, Vector2(cell_size_pixels, cell_size_pixels))


func cell_index_to_world_rect(cell_index: Vector2i) -> Rect2:
	return get_cell_rect_world(cell_index)


func world_position_to_cell_index(world_position: Vector2) -> Vector2i:
	if cell_size_pixels <= 0:
		return Vector2i(-1, -1)

	if world_position.x < 0.0:
		return Vector2i(-1, -1)

	if world_position.y < 0.0:
		return Vector2i(-1, -1)

	var cell_index: Vector2i = Vector2i(
		floori(world_position.x / float(cell_size_pixels)),
		floori(world_position.y / float(cell_size_pixels))
	)

	if not is_cell_index_in_bounds(cell_index):
		return Vector2i(-1, -1)

	return cell_index


func get_cell_debug_snapshot(cell_index: Vector2i) -> Dictionary:
	if not is_cell_index_in_bounds(cell_index):
		return {}

	var cell_state: WorldCellState = get_cell(cell_index)
	if cell_state == null:
		return {}

	var debug_dictionary: Dictionary = cell_state.to_debug_dictionary()
	var authored_terrain_objects: Array[Dictionary] = get_authored_terrain_objects_for_cell(cell_index)

	debug_dictionary["authored_terrain_objects"] = authored_terrain_objects
	debug_dictionary["authored_terrain_object_count"] = authored_terrain_objects.size()

	return debug_dictionary


func get_cell_debug_snapshot_at_world_position(world_position: Vector2) -> Dictionary:
	var cell_index: Vector2i = world_position_to_cell_index(world_position)
	return get_cell_debug_snapshot(cell_index)


func get_patch_debug_snapshots_for_cell(cell_index: Vector2i) -> Array:
	if not is_cell_index_in_bounds(cell_index):
		return []

	var cell_state: WorldCellState = get_cell(cell_index)
	if cell_state == null:
		return []

	return _build_patch_debug_snapshots_for_cell_state(cell_state)


func get_patch_debug_snapshots_at_world_position(world_position: Vector2) -> Array:
	var cell_index: Vector2i = world_position_to_cell_index(world_position)
	return get_patch_debug_snapshots_for_cell(cell_index)


func get_world_rect_pixels() -> Rect2:
	return Rect2(
		Vector2.ZERO,
		Vector2(
			float(world_width_cells * cell_size_pixels),
			float(world_height_cells * cell_size_pixels)
		)
	)


func set_debug_focus_entries(focus_entries: Array[Dictionary]) -> void:
	_debug_focus_entries = focus_entries.duplicate(true)


func get_debug_focus_entries() -> Array[Dictionary]:
	return _debug_focus_entries.duplicate(true)


func build_focus_summary_lines() -> PackedStringArray:
	var lines: PackedStringArray = PackedStringArray()

	for focus_entry_variant: Variant in _debug_focus_entries:
		var focus_entry: Dictionary = focus_entry_variant as Dictionary
		if focus_entry.is_empty():
			continue

		var cell_index: Vector2i = focus_entry.get("cell_index", Vector2i(-1, -1))
		var point_of_interest_tags: PackedStringArray = focus_entry.get(
			"point_of_interest_tags",
			PackedStringArray()
		)

		var summary_line: String = "%s @ (%s,%s) | landform=%s | slope=%s | drainage=%s | wetness=%s | water=%s | veg=%s | buildable=%s | poi=%s" % [
			str(focus_entry.get("focus_id", "focus")),
			str(cell_index.x),
			str(cell_index.y),
			str(focus_entry.get("landform_type", "n/a")),
			str(focus_entry.get("slope_class", "n/a")),
			str(focus_entry.get("drainage_class", "n/a")),
			str(focus_entry.get("wetness_tendency", "n/a")),
			str(focus_entry.get("surface_water_type", "n/a")),
			str(focus_entry.get("vegetation_cover_class", "n/a")),
			str(focus_entry.get("is_buildable", false)),
			",".join(point_of_interest_tags),
		]
		lines.append(summary_line)

	return lines


func get_visibility_counts() -> Dictionary:
	if _cached_visibility_counts_revision == visibility_revision and not _cached_visibility_counts.is_empty():
		return _cached_visibility_counts.duplicate(true)

	var counts: Dictionary = {
		"unknown": 0,
		"remembered": 0,
		"visible": 0,
	}

	for cell_key: String in _cell_order:
		var cell_state: WorldCellState = get_cell_by_key(cell_key)
		if cell_state == null:
			continue

		var fog_state_id: String = str(cell_state.fog_state)
		if not counts.has(fog_state_id):
			fog_state_id = "unknown"

		counts[fog_state_id] = int(counts.get(fog_state_id, 0)) + 1

	_cached_visibility_counts = counts.duplicate(true)
	_cached_visibility_counts_revision = visibility_revision
	return counts.duplicate(true)

func get_world_debug_snapshot() -> Dictionary:
	return {
		"is_loaded": true,
		"world_id": world_id,
		"fixture_id": fixture_id,
		"seed": seed,
		"world_width_cells": world_width_cells,
		"world_height_cells": world_height_cells,
		"cell_size_pixels": cell_size_pixels,
		"chunk_size_cells": chunk_size_cells,
		"primary_terrain_profile_id": primary_terrain_profile_id,
		"cell_count": get_cell_count(),
		"chunk_count": get_chunk_count(),
		"patch_count": get_patch_count(),
		"reveal_source_count": get_reveal_source_count(),
		"authored_terrain_object_count": get_authored_terrain_object_count(),
		"generation_warning_count": get_generation_warning_count(),
		"visibility_revision": visibility_revision,
		"visibility_counts": get_visibility_counts(),
		"debug_focus_entries": get_debug_focus_entries(),
		"debug_focus_summary_lines": build_focus_summary_lines(),
	}

func build_hovered_cell_debug_snapshot(cell_index: Vector2i) -> Dictionary:
	return get_cell_debug_snapshot(cell_index)


func build_selected_cell_debug_snapshot(cell_index: Vector2i) -> Dictionary:
	return get_cell_debug_snapshot(cell_index)

func _invalidate_visibility_counts_cache() -> void:
	_cached_visibility_counts_revision = -1
	_cached_visibility_counts = {}

func _build_patch_debug_snapshots_for_cell_state(cell_state: WorldCellState) -> Array:
	var patch_entries: Array[Dictionary] = []

	for patch_id: String in cell_state.patch_ids:
		var patch_state: WorldPatchState = get_patch(patch_id)
		if patch_state == null:
			continue

		patch_entries.append(patch_state.to_debug_dictionary())

	return patch_entries


func _build_cell_key(cell_index: Vector2i) -> String:
	return "%s,%s" % [str(cell_index.x), str(cell_index.y)]
