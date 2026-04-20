extends RefCounted
class_name AuthoredMapFixtureValidator

const TERRAIN_CELL_VALUE_KEYS = [
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
]

const VISIBILITY_BOOTSTRAP_KEYS = [
	"fog_state",
	"is_revealed",
	"is_currently_visible",
	"first_revealed_tick",
	"last_seen_tick",
	"survey_quality_class",
	"terrain_confidence_class",
]

const STAMP_METADATA_KEYS = [
	"stamp_id",
	"display_label",
	"source_tags",
	"rect",
	"cells",
	"poi_tags",
	"point_of_interest_tags",
	"site_score",
]

const REVEAL_SOURCE_ALLOWED_KEYS = [
	"source_id",
	"source_type",
	"display_label",
	"cell",
	"center_cell",
	"visible_radius_cells",
	"remembered_radius_cells",
	"survey_quality_visible_class",
	"survey_quality_remembered_class",
	"terrain_confidence_visible_class",
	"terrain_confidence_remembered_class",
	"is_enabled",
]

const TERRAIN_OBJECT_ALLOWED_KEYS = [
	"object_id",
	"object_type",
	"display_label",
	"placement_family",
	"cell",
	"source_stamp_id",
	"tags",
]

const DEBUG_FOCUS_ALLOWED_KEYS = [
	"label",
	"cell",
]

const SUPPORTED_TERRAIN_OBJECT_PLACEMENT_FAMILIES = [
	"tree",
	"wet_margin_plant",
	"rocky_marker",
]

static func get_supported_stamp_cell_value_keys() -> Array[String]:
	return _to_string_array(TERRAIN_CELL_VALUE_KEYS)

static func validate_root(root: Dictionary) -> Array[String]:
	var errors: Array[String] = []

	if not root.has("fixture_id"):
		errors.append("Missing fixture_id.")
	elif str(root.get("fixture_id", "")).strip_edges().is_empty():
		errors.append("fixture_id must not be empty.")

	if not root.has("world_width_cells"):
		errors.append("Missing world_width_cells.")
	if not root.has("world_height_cells"):
		errors.append("Missing world_height_cells.")
	if not root.has("cell_size_pixels"):
		errors.append("Missing cell_size_pixels.")
	if not root.has("default_cell"):
		errors.append("Missing default_cell.")

	var world_width_cells: int = int(root.get("world_width_cells", 0))
	var world_height_cells: int = int(root.get("world_height_cells", 0))
	var cell_size_pixels: int = int(root.get("cell_size_pixels", 0))
	var chunk_size_cells: int = int(root.get("chunk_size_cells", 16))

	if world_width_cells <= 0:
		errors.append("world_width_cells must be > 0.")
	if world_height_cells <= 0:
		errors.append("world_height_cells must be > 0.")
	if cell_size_pixels <= 0:
		errors.append("cell_size_pixels must be > 0.")
	if chunk_size_cells <= 0:
		errors.append("chunk_size_cells must be > 0 when present.")

	var default_cell_variant: Variant = root.get("default_cell", {})
	if not (default_cell_variant is Dictionary):
		errors.append("default_cell must be a dictionary.")
	else:
		_validate_default_cell(default_cell_variant as Dictionary, errors)

	var stamp_ids: Dictionary = {}

	if root.has("stamps"):
		var stamps_variant: Variant = root.get("stamps", [])
		if not (stamps_variant is Array):
			errors.append("'stamps' must be an array when present.")
		else:
			_validate_stamps(
				stamps_variant as Array,
				errors,
				world_width_cells,
				world_height_cells,
				stamp_ids
			)

	if root.has("reveal_sources"):
		var reveal_sources_variant: Variant = root.get("reveal_sources", [])
		if not (reveal_sources_variant is Array):
			errors.append("'reveal_sources' must be an array when present.")
		else:
			_validate_reveal_sources(
				reveal_sources_variant as Array,
				errors,
				world_width_cells,
				world_height_cells
			)

	if root.has("terrain_objects"):
		var terrain_objects_variant: Variant = root.get("terrain_objects", [])
		if not (terrain_objects_variant is Array):
			errors.append("'terrain_objects' must be an array when present.")
		else:
			_validate_terrain_objects(
				terrain_objects_variant as Array,
				errors,
				world_width_cells,
				world_height_cells,
				stamp_ids
			)

	if root.has("debug_focus_cells"):
		var debug_focus_variant: Variant = root.get("debug_focus_cells", [])
		if not (debug_focus_variant is Array):
			errors.append("'debug_focus_cells' must be an array when present.")
		else:
			_validate_debug_focus_cells(
				debug_focus_variant as Array,
				errors,
				world_width_cells,
				world_height_cells
			)

	return errors

static func _validate_default_cell(default_cell: Dictionary, errors: Array[String]) -> void:
	var allowed_keys: Array[String] = get_supported_stamp_cell_value_keys()
	for visibility_key: String in _to_string_array(VISIBILITY_BOOTSTRAP_KEYS):
		allowed_keys.append(visibility_key)

	_validate_supported_keys(default_cell, allowed_keys, "default_cell", errors)
	_validate_cell_semantics(default_cell, "default_cell", errors, true)

static func _validate_stamps(
	stamps: Array,
	errors: Array[String],
	world_width_cells: int,
	world_height_cells: int,
	stamp_ids: Dictionary
) -> void:
	var allowed_keys: Array[String] = _to_string_array(STAMP_METADATA_KEYS)
	for cell_key: String in get_supported_stamp_cell_value_keys():
		allowed_keys.append(cell_key)

	for stamp_variant: Variant in stamps:
		if not (stamp_variant is Dictionary):
			errors.append("Each stamp must be a dictionary.")
			continue

		var stamp_data: Dictionary = stamp_variant as Dictionary
		var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
		var stamp_label: String = "stamp"

		if stamp_id.is_empty():
			errors.append("Each stamp needs a non-empty stamp_id.")
		else:
			stamp_label = "stamp '%s'" % stamp_id
			if stamp_ids.has(stamp_id):
				errors.append("Duplicate stamp_id '%s'." % stamp_id)
			else:
				stamp_ids[stamp_id] = true

		_validate_supported_keys(stamp_data, allowed_keys, stamp_label, errors)
		_validate_cell_semantics(stamp_data, stamp_label, errors, false)

		if not _stamp_has_supported_footprint(stamp_data):
			errors.append(
				"%s needs either rect [x, y, w, h] or a non-empty cells [[x, y], ...] footprint." %
				stamp_label
			)
			continue

		if stamp_data.has("rect"):
			var rect_variant: Variant = stamp_data.get("rect", [])
			if not (rect_variant is Array):
				errors.append("%s rect must be an array." % stamp_label)
			else:
				var rect_values: Array = rect_variant as Array
				if rect_values.size() != 4:
					errors.append("%s rect must have exactly 4 values." % stamp_label)
				else:
					var rect_width: int = int(rect_values[2])
					var rect_height: int = int(rect_values[3])
					if rect_width <= 0 or rect_height <= 0:
						errors.append("%s rect width/height must be > 0." % stamp_label)

		if stamp_data.has("cells"):
			var cells_variant: Variant = stamp_data.get("cells", [])
			if not (cells_variant is Array):
				errors.append("%s cells must be an array." % stamp_label)
			else:
				var seen_cell_keys: Dictionary = {}
				var cells: Array = cells_variant as Array
				if cells.is_empty():
					errors.append("%s cells must not be empty." % stamp_label)

				for cell_variant: Variant in cells:
					if not _is_valid_cell_pair(cell_variant):
						errors.append("%s cells entries must be [x, y] arrays." % stamp_label)
						break

					var cell_values: Array = cell_variant as Array
					var cell_index: Vector2i = Vector2i(
						int(cell_values[0]),
						int(cell_values[1])
					)
					var cell_key: String = "%d,%d" % [cell_index.x, cell_index.y]

					if seen_cell_keys.has(cell_key):
						errors.append("%s contains duplicate cell %s." % [stamp_label, str(cell_index)])
						break

					seen_cell_keys[cell_key] = true

		if stamp_data.has("source_tags"):
			_validate_string_array(
				stamp_data.get("source_tags", []),
				"%s source_tags" % stamp_label,
				errors
			)

		if stamp_data.has("poi_tags"):
			_validate_string_array(
				stamp_data.get("poi_tags", []),
				"%s poi_tags" % stamp_label,
				errors
			)

		if stamp_data.has("point_of_interest_tags"):
			_validate_string_array(
				stamp_data.get("point_of_interest_tags", []),
				"%s point_of_interest_tags" % stamp_label,
				errors
			)

		if stamp_data.has("site_score"):
			var site_score: float = float(stamp_data.get("site_score", 0.0))
			if site_score < 0.0 or site_score > 100.0:
				errors.append("%s site_score must stay within 0..100." % stamp_label)

		_validate_stamp_bounds(
			stamp_data,
			stamp_label,
			errors,
			world_width_cells,
			world_height_cells
		)

static func _validate_reveal_sources(
	reveal_sources: Array,
	errors: Array[String],
	world_width_cells: int,
	world_height_cells: int
) -> void:
	var seen_source_ids: Dictionary = {}

	for reveal_source_variant: Variant in reveal_sources:
		if not (reveal_source_variant is Dictionary):
			errors.append("Each reveal source must be a dictionary.")
			continue

		var reveal_source_data: Dictionary = reveal_source_variant as Dictionary
		var source_id: String = str(reveal_source_data.get("source_id", "")).strip_edges()
		var source_label: String = "reveal source"

		if source_id.is_empty():
			errors.append("Each reveal source needs a non-empty source_id.")
		else:
			source_label = "reveal source '%s'" % source_id
			if seen_source_ids.has(source_id):
				errors.append("Duplicate reveal source id '%s'." % source_id)
			else:
				seen_source_ids[source_id] = true

		_validate_supported_keys(
			reveal_source_data,
			_to_string_array(REVEAL_SOURCE_ALLOWED_KEYS),
			source_label,
			errors
		)

		var source_type: String = str(reveal_source_data.get("source_type", "")).strip_edges()
		if source_type.is_empty():
			errors.append("%s requires a non-empty source_type." % source_label)

		var has_cell: bool = reveal_source_data.has("cell")
		var has_center_cell: bool = reveal_source_data.has("center_cell")
		if not has_cell and not has_center_cell:
			errors.append("%s requires cell [x, y] or center_cell [x, y]." % source_label)
		elif has_cell and has_center_cell:
			errors.append("%s should use either cell or center_cell, not both." % source_label)

		var source_cell_value: Variant = reveal_source_data.get("cell", reveal_source_data.get("center_cell", []))
		if not _is_valid_cell_pair(source_cell_value):
			errors.append("%s requires cell [x, y]." % source_label)
		else:
			var source_cell: Array = source_cell_value as Array
			var source_cell_index: Vector2i = Vector2i(int(source_cell[0]), int(source_cell[1]))
			if not _is_cell_in_bounds(source_cell_index, world_width_cells, world_height_cells):
				errors.append("%s uses out-of-bounds cell %s." % [source_label, str(source_cell_index)])

		var visible_radius_cells: int = int(reveal_source_data.get("visible_radius_cells", -1))
		if visible_radius_cells < 0:
			errors.append("%s visible_radius_cells must be >= 0." % source_label)

		var remembered_radius_cells: int = int(
			reveal_source_data.get("remembered_radius_cells", visible_radius_cells)
		)
		if remembered_radius_cells < visible_radius_cells:
			errors.append(
				"%s remembered_radius_cells must be >= visible_radius_cells." % source_label
			)

		_validate_enum_value(
			reveal_source_data,
			"survey_quality_visible_class",
			SharedEnums.SURVEY_QUALITY_CLASSES,
			source_label,
			errors
		)
		_validate_enum_value(
			reveal_source_data,
			"survey_quality_remembered_class",
			SharedEnums.SURVEY_QUALITY_CLASSES,
			source_label,
			errors
		)
		_validate_enum_value(
			reveal_source_data,
			"terrain_confidence_visible_class",
			SharedEnums.TERRAIN_CONFIDENCE_CLASSES,
			source_label,
			errors
		)
		_validate_enum_value(
			reveal_source_data,
			"terrain_confidence_remembered_class",
			SharedEnums.TERRAIN_CONFIDENCE_CLASSES,
			source_label,
			errors
		)

static func _validate_terrain_objects(
	terrain_objects: Array,
	errors: Array[String],
	world_width_cells: int,
	world_height_cells: int,
	stamp_ids: Dictionary
) -> void:
	var seen_object_ids: Dictionary = {}

	for terrain_object_variant: Variant in terrain_objects:
		if not (terrain_object_variant is Dictionary):
			errors.append("Each terrain object must be a dictionary.")
			continue

		var terrain_object_data: Dictionary = terrain_object_variant as Dictionary
		var object_id: String = str(terrain_object_data.get("object_id", "")).strip_edges()
		var object_label: String = "terrain object"

		if object_id.is_empty():
			errors.append("Each terrain object needs a non-empty object_id.")
		else:
			object_label = "terrain object '%s'" % object_id
			if seen_object_ids.has(object_id):
				errors.append("Duplicate terrain object id '%s'." % object_id)
			else:
				seen_object_ids[object_id] = true

		_validate_supported_keys(
			terrain_object_data,
			_to_string_array(TERRAIN_OBJECT_ALLOWED_KEYS),
			object_label,
			errors
		)

		var object_type: String = str(terrain_object_data.get("object_type", "")).strip_edges()
		if object_type.is_empty():
			errors.append("%s requires a non-empty object_type." % object_label)

		var placement_family: String = str(
			terrain_object_data.get("placement_family", "")
		).strip_edges()
		if not _array_has_string(SUPPORTED_TERRAIN_OBJECT_PLACEMENT_FAMILIES, placement_family):
			errors.append(
				"%s uses unsupported placement_family '%s'." % [object_label, placement_family]
			)

		var source_stamp_id: String = str(
			terrain_object_data.get("source_stamp_id", "")
		).strip_edges()
		if not source_stamp_id.is_empty() and not stamp_ids.has(source_stamp_id):
			errors.append(
				"%s references missing source_stamp_id '%s'." % [object_label, source_stamp_id]
			)

		if not _is_valid_cell_pair(terrain_object_data.get("cell", [])):
			errors.append("%s requires cell [x, y]." % object_label)
		else:
			var object_cell_value: Variant = terrain_object_data.get("cell", [])
			var object_cell: Array = object_cell_value as Array
			var object_cell_index: Vector2i = Vector2i(int(object_cell[0]), int(object_cell[1]))
			if not _is_cell_in_bounds(object_cell_index, world_width_cells, world_height_cells):
				errors.append("%s uses out-of-bounds cell %s." % [object_label, str(object_cell_index)])

		if terrain_object_data.has("tags"):
			_validate_string_array(terrain_object_data.get("tags", []), "%s tags" % object_label, errors)

static func _validate_debug_focus_cells(
	debug_focus_cells: Array,
	errors: Array[String],
	world_width_cells: int,
	world_height_cells: int
) -> void:
	for focus_variant: Variant in debug_focus_cells:
		if not (focus_variant is Dictionary):
			errors.append("Each debug focus cell entry must be a dictionary.")
			continue

		var focus_data: Dictionary = focus_variant as Dictionary
		var label: String = str(focus_data.get("label", "")).strip_edges()
		var focus_label: String = "debug focus entry"

		if label.is_empty():
			errors.append("Each debug focus cell entry needs a non-empty label.")
		else:
			focus_label = "debug focus '%s'" % label

		_validate_supported_keys(
			focus_data,
			_to_string_array(DEBUG_FOCUS_ALLOWED_KEYS),
			focus_label,
			errors
		)

		if not _is_valid_cell_pair(focus_data.get("cell", [])):
			errors.append("%s requires cell [x, y]." % focus_label)
		else:
			var focus_cell_value: Variant = focus_data.get("cell", [])
			var focus_cell: Array = focus_cell_value as Array
			var focus_cell_index: Vector2i = Vector2i(int(focus_cell[0]), int(focus_cell[1]))
			if not _is_cell_in_bounds(focus_cell_index, world_width_cells, world_height_cells):
				errors.append("%s uses out-of-bounds cell %s." % [focus_label, str(focus_cell_index)])

static func _validate_stamp_bounds(
	stamp_data: Dictionary,
	stamp_label: String,
	errors: Array[String],
	world_width_cells: int,
	world_height_cells: int
) -> void:
	if world_width_cells <= 0 or world_height_cells <= 0:
		return

	if stamp_data.has("rect"):
		var rect_values: Array = stamp_data.get("rect", []) as Array
		if rect_values.size() == 4:
			var rect_position: Vector2i = Vector2i(int(rect_values[0]), int(rect_values[1]))
			var rect_size: Vector2i = Vector2i(int(rect_values[2]), int(rect_values[3]))
			var rect_end: Vector2i = rect_position + rect_size
			if rect_position.x < 0 or rect_position.y < 0:
				errors.append("%s rect starts out of bounds." % stamp_label)
			if rect_end.x > world_width_cells or rect_end.y > world_height_cells:
				errors.append("%s rect extends beyond world bounds." % stamp_label)

	if stamp_data.has("cells"):
		var cells: Array = stamp_data.get("cells", []) as Array
		for cell_variant: Variant in cells:
			if not _is_valid_cell_pair(cell_variant):
				continue

			var cell_values: Array = cell_variant as Array
			var cell_index: Vector2i = Vector2i(int(cell_values[0]), int(cell_values[1]))
			if not _is_cell_in_bounds(cell_index, world_width_cells, world_height_cells):
				errors.append("%s contains out-of-bounds cell %s." % [stamp_label, str(cell_index)])
				break

static func _validate_cell_semantics(
	cell_data: Dictionary,
	label: String,
	errors: Array[String],
	allow_visibility_keys: bool
) -> void:
	_validate_enum_value(cell_data, "slope_class", SharedEnums.SLOPE_CLASSES, label, errors)
	_validate_enum_value(cell_data, "landform_type", SharedEnums.LANDFORM_TYPES, label, errors)
	_validate_enum_value(cell_data, "surface_water_type", SharedEnums.SURFACE_WATER_TYPES, label, errors)
	_validate_enum_value(cell_data, "drainage_class", SharedEnums.DRAINAGE_CLASSES, label, errors)
	_validate_enum_value(cell_data, "wetness_tendency", SharedEnums.WETNESS_TENDENCIES, label, errors)
	_validate_enum_value(cell_data, "ground_firmness_class", SharedEnums.GROUND_FIRMNESS_CLASSES, label, errors)
	_validate_enum_value(cell_data, "vegetation_cover_class", SharedEnums.VEGETATION_COVER_CLASSES, label, errors)

	if cell_data.has("movement_cost"):
		var movement_cost: float = float(cell_data.get("movement_cost", 0.0))
		if movement_cost <= 0.0:
			errors.append("%s movement_cost must be > 0." % label)

	if cell_data.has("haul_cost_multiplier"):
		var haul_cost_multiplier: float = float(cell_data.get("haul_cost_multiplier", 0.0))
		if haul_cost_multiplier <= 0.0:
			errors.append("%s haul_cost_multiplier must be > 0." % label)

	if cell_data.has("is_buildable") and typeof(cell_data.get("is_buildable")) != TYPE_BOOL:
		errors.append("%s is_buildable must be a boolean." % label)

	if allow_visibility_keys:
		_validate_enum_value(cell_data, "fog_state", SharedEnums.FOG_STATE_IDS, label, errors)
		_validate_enum_value(cell_data, "survey_quality_class", SharedEnums.SURVEY_QUALITY_CLASSES, label, errors)
		_validate_enum_value(cell_data, "terrain_confidence_class", SharedEnums.TERRAIN_CONFIDENCE_CLASSES, label, errors)

		if cell_data.has("is_revealed") and typeof(cell_data.get("is_revealed")) != TYPE_BOOL:
			errors.append("%s is_revealed must be a boolean." % label)

		if cell_data.has("is_currently_visible") and typeof(cell_data.get("is_currently_visible")) != TYPE_BOOL:
			errors.append("%s is_currently_visible must be a boolean." % label)
	else:
		for visibility_key: String in _to_string_array(VISIBILITY_BOOTSTRAP_KEYS):
			if cell_data.has(visibility_key):
				errors.append(
					"%s must not set visibility field '%s'. Use reveal_sources instead." %
					[label, visibility_key]
				)

static func _validate_enum_value(
	data: Dictionary,
	key: String,
	allowed_values: Array,
	label: String,
	errors: Array[String]
) -> void:
	if not data.has(key):
		return

	var value_text: String = str(data.get(key, "")).strip_edges()
	if value_text.is_empty():
		errors.append("%s %s must not be empty." % [label, key])
		return

	if not SharedEnums.contains_value(allowed_values, value_text):
		errors.append("%s uses unknown %s '%s'." % [label, key, value_text])

static func _validate_supported_keys(
	data: Dictionary,
	allowed_keys: Array[String],
	label: String,
	errors: Array[String]
) -> void:
	for key_variant: Variant in data.keys():
		var key_text: String = str(key_variant).strip_edges()
		if _array_has_string(allowed_keys, key_text):
			continue

		errors.append("%s uses unsupported key '%s'." % [label, key_text])

static func _validate_string_array(value: Variant, label: String, errors: Array[String]) -> void:
	if not (value is Array):
		errors.append("%s must be an array." % label)
		return

	var seen_entries: Dictionary = {}
	var values: Array = value as Array
	for entry_variant: Variant in values:
		var entry_text: String = str(entry_variant).strip_edges()
		if entry_text.is_empty():
			errors.append("%s must not contain empty strings." % label)
			return

		if seen_entries.has(entry_text):
			errors.append("%s contains duplicate value '%s'." % [label, entry_text])
			return

		seen_entries[entry_text] = true

static func _stamp_has_supported_footprint(stamp_data: Dictionary) -> bool:
	if stamp_data.has("cells"):
		var cells_variant: Variant = stamp_data.get("cells", [])
		if cells_variant is Array and not (cells_variant as Array).is_empty():
			return true

	if stamp_data.has("rect"):
		var rect_variant: Variant = stamp_data.get("rect", [])
		if rect_variant is Array and (rect_variant as Array).size() == 4:
			return true

	return false

static func _is_valid_cell_pair(value: Variant) -> bool:
	return value is Array and (value as Array).size() == 2

static func _is_cell_in_bounds(
	cell_index: Vector2i,
	world_width_cells: int,
	world_height_cells: int
) -> bool:
	if cell_index.x < 0 or cell_index.y < 0:
		return false

	if cell_index.x >= world_width_cells or cell_index.y >= world_height_cells:
		return false

	return true

static func _array_has_string(values: Array, candidate: String) -> bool:
	for value_variant: Variant in values:
		if str(value_variant) == candidate:
			return true

	return false

static func _to_string_array(values: Array) -> Array[String]:
	var result: Array[String] = []

	for value_variant: Variant in values:
		result.append(str(value_variant))

	return result
