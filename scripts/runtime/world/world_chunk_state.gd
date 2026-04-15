extends RefCounted
class_name WorldChunkState

var chunk_id: String = ""
var origin_cell: Vector2i = Vector2i.ZERO
var size_cells: Vector2i = Vector2i.ZERO
var cell_keys: PackedStringArray = PackedStringArray()

func add_cell_key(cell_key: String) -> void:
	var trimmed_cell_key: String = cell_key.strip_edges()
	if trimmed_cell_key.is_empty():
		return

	if not cell_keys.has(trimmed_cell_key):
		cell_keys.append(trimmed_cell_key)

func to_debug_dictionary() -> Dictionary:
	return {
		"chunk_id": chunk_id,
		"origin_cell": origin_cell,
		"size_cells": size_cells,
		"cell_count": cell_keys.size(),
	}
