extends RefCounted
class_name WorldRevealSourceState

var source_id: String = ""
var source_type: String = "generic"
var display_label: String = ""
var center_cell_index: Vector2i = Vector2i.ZERO
var visible_radius_cells: int = 0
var remembered_radius_cells: int = 0
var is_active: bool = true

# These let different source types stamp different knowledge quality later.
var survey_quality_visible_class: String = "walked"
var survey_quality_remembered_class: String = "glanced"
var terrain_confidence_visible_class: String = "good"
var terrain_confidence_remembered_class: String = "rough"

func to_debug_dictionary() -> Dictionary:
	return {
		"source_id": source_id,
		"source_type": source_type,
		"display_label": display_label,
		"center_cell_index": center_cell_index,
		"visible_radius_cells": visible_radius_cells,
		"remembered_radius_cells": remembered_radius_cells,
		"is_active": is_active,
		"survey_quality_visible_class": survey_quality_visible_class,
		"survey_quality_remembered_class": survey_quality_remembered_class,
		"terrain_confidence_visible_class": terrain_confidence_visible_class,
		"terrain_confidence_remembered_class": terrain_confidence_remembered_class,
	}
