extends RefCounted
class_name WorldState

var world_id: String = ""
var fixture_id: String = ""
var map_preset_id: String = ""
var worldgen_profile_id: String = ""
var primary_terrain_profile_id: String = ""
var seed: int = 0

var world_width_cells: int = 0
var world_height_cells: int = 0
var cell_size_pixels: int = 32

var debug_focus_entries: Array = []

var _cells_by_key: Dictionary = {}
var _chunks_by_id: Dictionary = {}
var _patches_by_id: Dictionary = {}

static func build_cell_key(cell_index: Vector2i) -> String:
	return "%s:%s" % [cell_index.x, cell_index.y]

func add_cell(cell_state: WorldCellState) -> void:
	if cell_state == null:
		return

	_cells_by_key[cell_state.cell_key] = cell_state

func add_chunk(chunk_state: WorldChunkState) -> void:
	if chunk_state == null:
		return

	_chunks_by_id[chunk_state.chunk_id] = chunk_state

func add_patch(patch_state: WorldPatchState) -> void:
	if patch_state == null:
		return

	_patches_by_id[patch_state.patch_id] = patch_state

func get_cell(cell_index: Vector2i) -> WorldCellState:
	return get_cell_by_key(build_cell_key(cell_index))

func get_cell_by_key(cell_key: String) -> WorldCellState:
	return _cells_by_key.get(cell_key, null) as WorldCellState

func get_chunk(chunk_id: String) -> WorldChunkState:
	return _chunks_by_id.get(chunk_id, null) as WorldChunkState

func get_patch(patch_id: String) -> WorldPatchState:
	return _patches_by_id.get(patch_id, null) as WorldPatchState

func get_cell_count() -> int:
	return _cells_by_key.size()

func get_chunk_count() -> int:
	return _chunks_by_id.size()

func get_patch_count() -> int:
	return _patches_by_id.size()

func get_all_cell_keys() -> PackedStringArray:
	var keys: PackedStringArray = PackedStringArray()

	for key_variant: Variant in _cells_by_key.keys():
		keys.append(str(key_variant))

	return keys

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

func is_world_position_in_bounds(world_position: Vector2) -> bool:
	if cell_size_pixels <= 0:
		return false

	var world_width_pixels: float = float(world_width_cells * cell_size_pixels)
	var world_height_pixels: float = float(world_height_cells * cell_size_pixels)

	if world_position.x < 0.0:
		return false
	if world_position.y < 0.0:
		return false
	if world_position.x >= world_width_pixels:
		return false
	if world_position.y >= world_height_pixels:
		return false

	return true

func world_position_to_cell_index(world_position: Vector2) -> Vector2i:
	if not is_world_position_in_bounds(world_position):
		return Vector2i(-1, -1)

	var cell_x: int = int(floor(world_position.x / float(cell_size_pixels)))
	var cell_y: int = int(floor(world_position.y / float(cell_size_pixels)))
	var cell_index: Vector2i = Vector2i(cell_x, cell_y)

	if not is_cell_index_in_bounds(cell_index):
		return Vector2i(-1, -1)

	return cell_index

func cell_index_to_world_position(cell_index: Vector2i) -> Vector2:
	return Vector2(
		float(cell_index.x * cell_size_pixels),
		float(cell_index.y * cell_size_pixels)
	)

func cell_index_to_world_rect(cell_index: Vector2i) -> Rect2:
	return Rect2(
		cell_index_to_world_position(cell_index),
		Vector2(float(cell_size_pixels), float(cell_size_pixels))
	)

func get_cell_debug_snapshot(cell_index: Vector2i) -> Dictionary:
	var cell_state: WorldCellState = get_cell(cell_index)
	if cell_state == null:
		return {}

	return cell_state.to_debug_dictionary()

func get_cell_debug_snapshot_at_world_position(world_position: Vector2) -> Dictionary:
	var cell_index: Vector2i = world_position_to_cell_index(world_position)
	if not is_cell_index_in_bounds(cell_index):
		return {}

	return get_cell_debug_snapshot(cell_index)
	
func get_patches_for_cell(cell_index: Vector2i) -> Array[WorldPatchState]:
	var patch_states: Array[WorldPatchState] = []

	var cell_state: WorldCellState = get_cell(cell_index)
	if cell_state == null:
		return patch_states

	for patch_id: String in cell_state.patch_ids:
		var patch_state: WorldPatchState = get_patch(patch_id)
		if patch_state == null:
			continue

		patch_states.append(patch_state)

	return patch_states

func get_patch_debug_snapshots_for_cell(cell_index: Vector2i) -> Array:
	var patch_snapshots: Array = []

	var patch_states: Array[WorldPatchState] = get_patches_for_cell(cell_index)
	for patch_state: WorldPatchState in patch_states:
		patch_snapshots.append(patch_state.to_debug_dictionary())

	return patch_snapshots

func get_patch_debug_snapshots_at_world_position(world_position: Vector2) -> Array:
	var cell_index: Vector2i = world_position_to_cell_index(world_position)
	if not is_cell_index_in_bounds(cell_index):
		return []

	return get_patch_debug_snapshots_for_cell(cell_index)

func set_debug_focus_entries(new_entries: Array) -> void:
	debug_focus_entries.clear()

	for entry_variant: Variant in new_entries:
		if entry_variant is Dictionary:
			debug_focus_entries.append((entry_variant as Dictionary).duplicate(true))

func get_debug_snapshot() -> Dictionary:
	var focus_cells: Array = []

	for entry_variant: Variant in debug_focus_entries:
		var entry: Dictionary = entry_variant as Dictionary
		var label: String = str(entry.get("label", "focus"))
		var cell_index_variant: Variant = entry.get("cell_index", Vector2i.ZERO)

		if not (cell_index_variant is Vector2i):
			continue

		var cell_index: Vector2i = cell_index_variant as Vector2i
		var cell_state: WorldCellState = get_cell(cell_index)

		if cell_state == null:
			continue

		focus_cells.append({
			"label": label,
			"cell": cell_state.to_debug_dictionary(),
		})

	if focus_cells.is_empty():
		var center_cell: Vector2i = Vector2i(
			int(world_width_cells / 2),
			int(world_height_cells / 2)
		)
		var center_state: WorldCellState = get_cell(center_cell)
		if center_state != null:
			focus_cells.append({
				"label": "center",
				"cell": center_state.to_debug_dictionary(),
			})

	return {
		"is_loaded": true,
		"world_id": world_id,
		"fixture_id": fixture_id,
		"map_preset_id": map_preset_id,
		"worldgen_profile_id": worldgen_profile_id,
		"primary_terrain_profile_id": primary_terrain_profile_id,
		"seed": seed,
		"world_width_cells": world_width_cells,
		"world_height_cells": world_height_cells,
		"cell_size_pixels": cell_size_pixels,
		"cell_count": get_cell_count(),
		"chunk_count": get_chunk_count(),
		"patch_count": get_patch_count(),
		"focus_cells": focus_cells,
	}
