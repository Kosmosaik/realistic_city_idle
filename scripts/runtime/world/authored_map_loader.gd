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

	var validation_error: String = _validate_root(root)
	if not validation_error.is_empty():
		push_error("AuthoredMapLoader: %s" % validation_error)
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


func _validate_root(root: Dictionary) -> String:
	if str(root.get("fixture_id", "")).strip_edges().is_empty():
		return "Fixture is missing fixture_id."

	var world_width_cells: int = int(root.get("world_width_cells", 0))
	var world_height_cells: int = int(root.get("world_height_cells", 0))
	var cell_size_pixels: int = int(root.get("cell_size_pixels", DEFAULT_CELL_SIZE_PIXELS))
	var chunk_size_cells: int = int(root.get("chunk_size_cells", DEFAULT_CHUNK_SIZE_CELLS))

	if world_width_cells <= 0:
		return "Fixture world_width_cells must be > 0."

	if world_height_cells <= 0:
		return "Fixture world_height_cells must be > 0."

	if cell_size_pixels <= 0:
		return "Fixture cell_size_pixels must be > 0."

	if chunk_size_cells <= 0:
		return "Fixture chunk_size_cells must be > 0."

	if not (root.get("default_cell", {}) is Dictionary):
		return "Fixture default_cell must be a Dictionary."

	if not (root.get("stamps", []) is Array):
		return "Fixture stamps must be an Array."

	var stamps: Array = root.get("stamps", [])
	for stamp_index: int in range(stamps.size()):
		var stamp_variant: Variant = stamps[stamp_index]
		if not (stamp_variant is Dictionary):
			return "Fixture stamp at index %d was not a Dictionary." % stamp_index

		var stamp_data: Dictionary = stamp_variant as Dictionary
		var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
		if stamp_id.is_empty():
			return "Fixture stamp at index %d is missing stamp_id." % stamp_index

		var rect_values: Array = stamp_data.get("rect", [])
		if rect_values.size() != 4:
			return "Fixture stamp '%s' must have rect = [x, y, width, height]." % stamp_id

	if root.has("reveal_sources") and not (root.get("reveal_sources", []) is Array):
		return "Fixture reveal_sources must be an Array."

	var reveal_sources: Array = root.get("reveal_sources", [])
	for reveal_source_index: int in range(reveal_sources.size()):
		var reveal_source_variant: Variant = reveal_sources[reveal_source_index]
		if not (reveal_source_variant is Dictionary):
			return "Fixture reveal_source at index %d was not a Dictionary." % reveal_source_index

		var reveal_source_data: Dictionary = reveal_source_variant as Dictionary
		var source_id: String = str(reveal_source_data.get("source_id", "")).strip_edges()
		if source_id.is_empty():
			return "Fixture reveal_source at index %d is missing source_id." % reveal_source_index

		var source_cell_values: Variant = reveal_source_data.get(
			"cell",
			reveal_source_data.get("center_cell", [])
		)
		if not (source_cell_values is Array):
			return "Fixture reveal_source '%s' must define cell = [x, y]." % source_id

		var source_cell_array: Array = source_cell_values as Array
		if source_cell_array.size() != 2:
			return "Fixture reveal_source '%s' must define cell = [x, y]." % source_id

	if root.has("terrain_objects") and not (root.get("terrain_objects", []) is Array):
		return "Fixture terrain_objects must be an Array."

	var terrain_objects: Array = root.get("terrain_objects", [])
	for terrain_object_index: int in range(terrain_objects.size()):
		var terrain_object_variant: Variant = terrain_objects[terrain_object_index]
		if not (terrain_object_variant is Dictionary):
			return "Fixture terrain_object at index %d was not a Dictionary." % terrain_object_index

		var terrain_object_data: Dictionary = terrain_object_variant as Dictionary
		var object_id: String = str(terrain_object_data.get("object_id", "")).strip_edges()
		if object_id.is_empty():
			return "Fixture terrain_object at index %d is missing object_id." % terrain_object_index

		var object_type: String = str(terrain_object_data.get("object_type", "")).strip_edges()
		if object_type.is_empty():
			return "Fixture terrain_object '%s' is missing object_type." % object_id

		var placement_family: String = str(
			terrain_object_data.get("placement_family", "")
		).strip_edges()
		if placement_family.is_empty():
			return "Fixture terrain_object '%s' is missing placement_family." % object_id

		var object_cell_values: Variant = terrain_object_data.get("cell", [])
		if not (object_cell_values is Array):
			return "Fixture terrain_object '%s' must define cell = [x, y]." % object_id

		var object_cell_array: Array = object_cell_values as Array
		if object_cell_array.size() != 2:
			return "Fixture terrain_object '%s' must define cell = [x, y]." % object_id

	return ""


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
	for stamp_index: int in range(stamps.size()):
		var stamp_variant: Variant = stamps[stamp_index]
		if not (stamp_variant is Dictionary):
			continue

		var stamp_data: Dictionary = stamp_variant as Dictionary
		var stamp_id: String = str(stamp_data.get("stamp_id", "")).strip_edges()
		var stamp_rect: Rect2i = _variant_to_rect2i(stamp_data.get("rect", []))
		if stamp_rect.size.x <= 0 or stamp_rect.size.y <= 0:
			push_error("AuthoredMapLoader: Stamp '%s' had invalid rect." % stamp_id)
			return false

		_record_visibility_paint_warning_if_needed(world_state, stamp_id, stamp_data)

		var stamp_tags: PackedStringArray = _variant_to_packed_string_array(
			stamp_data.get("point_of_interest_tags", [])
		)

		var create_patch: bool = bool(stamp_data.get("create_patch", true))
		var patch_state: WorldPatchState = null
		if create_patch:
			patch_state = _build_patch_state_from_stamp(stamp_id, stamp_data, stamp_rect, stamp_tags)
			world_state.add_patch(patch_state)

		var cell_apply_values: Dictionary = _build_cell_apply_values(stamp_data)
		var stamp_zone_id: String = str(stamp_data.get("zone_stamp_id", "")).strip_edges()

		var x_start: int = max(stamp_rect.position.x, 0)
		var y_start: int = max(stamp_rect.position.y, 0)
		var x_end: int = min(stamp_rect.position.x + stamp_rect.size.x, world_state.world_width_cells)
		var y_end: int = min(stamp_rect.position.y + stamp_rect.size.y, world_state.world_height_cells)

		for y: int in range(y_start, y_end):
			for x: int in range(x_start, x_end):
				var cell_index: Vector2i = Vector2i(x, y)
				var cell_state: WorldCellState = world_state.get_cell(cell_index)
				if cell_state == null:
					continue

				cell_state.apply_values(cell_apply_values)

				if not stamp_zone_id.is_empty():
					cell_state.zone_stamp_id = stamp_zone_id

				if not stamp_tags.is_empty():
					cell_state.point_of_interest_tags = _merge_string_arrays(
						cell_state.point_of_interest_tags,
						stamp_tags
					)

				if patch_state != null:
					cell_state.patch_ids = _merge_string_arrays(
						cell_state.patch_ids,
						PackedStringArray([patch_state.patch_id])
					)

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

	return cell_apply_values


func _build_patch_state_from_stamp(
	stamp_id: String,
	stamp_data: Dictionary,
	stamp_rect: Rect2i,
	stamp_tags: PackedStringArray
) -> WorldPatchState:
	var patch_state: WorldPatchState = WorldPatchState.new()

	var patch_type: String = str(stamp_data.get("patch_type", "authored_rect")).strip_edges()
	if patch_type.is_empty():
		patch_type = "authored_rect"

	patch_state.patch_id = "patch.%s" % stamp_id
	patch_state.patch_type = patch_type
	patch_state.source_stamp_id = stamp_id
	patch_state.rect_position = stamp_rect.position
	patch_state.rect_size = stamp_rect.size
	patch_state.set_point_of_interest_tags(stamp_tags)

	patch_state.landform_type = str(stamp_data.get("landform_type", ""))
	patch_state.surface_water_type = str(stamp_data.get("surface_water_type", ""))
	patch_state.drainage_class = str(stamp_data.get("drainage_class", ""))
	patch_state.wetness_tendency = str(stamp_data.get("wetness_tendency", ""))
	patch_state.vegetation_cover_class = str(stamp_data.get("vegetation_cover_class", ""))
	patch_state.is_buildable = bool(stamp_data.get("is_buildable", false))

	patch_state.dominant_landform_type = patch_state.landform_type
	patch_state.dominant_vegetation_cover_class = patch_state.vegetation_cover_class
	patch_state.dominant_drainage_class = patch_state.drainage_class

	if stamp_data.has("site_score"):
		patch_state.site_score = float(stamp_data.get("site_score", 0.0))
		patch_state.has_authored_site_score = true

	var resource_summary_variant: Variant = stamp_data.get("resource_summary", {})
	if resource_summary_variant is Dictionary:
		patch_state.resource_summary = (resource_summary_variant as Dictionary).duplicate(true)

	var hazard_summary_variant: Variant = stamp_data.get("hazard_summary", {})
	if hazard_summary_variant is Dictionary:
		patch_state.hazard_summary = (hazard_summary_variant as Dictionary).duplicate(true)

	var reveal_state: String = str(stamp_data.get("reveal_state", "")).strip_edges()
	if not reveal_state.is_empty():
		patch_state.reveal_state = reveal_state

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
