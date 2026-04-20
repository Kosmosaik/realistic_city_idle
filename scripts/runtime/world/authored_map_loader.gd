extends RefCounted
class_name AuthoredMapLoader

const AUTHORED_REVEAL_SOURCE_LOADER_SCRIPT: Script = preload(
	"res://scripts/runtime/world/authored_reveal_source_loader.gd"
)
const AUTHORED_TERRAIN_OBJECT_LOADER_SCRIPT: Script = preload(
	"res://scripts/runtime/world/authored_terrain_object_loader.gd"
)
const AUTHORED_MAP_STAMP_APPLICATOR_SCRIPT: Script = preload(
	"res://scripts/runtime/world/authored_map_stamp_applicator.gd"
)

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

	var validation_errors: Array[String] = _validate_root(root)
	if not validation_errors.is_empty():
		push_error(
			"AuthoredMapLoader:\n- %s" % "\n- ".join(validation_errors)
		)
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
		world_state.primary_terrain_profile_id = worldgen_profile_def.get_primary_terrain_profile_id()

	if time_service != null:
		world_state.seed = int(time_service.get("scenario_seed"))

	if not _apply_authored_surface_content(world_state, root):
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


func _validate_root(root: Dictionary) -> Array[String]:
	return AuthoredMapFixtureValidator.validate_root(root)
	
func _apply_authored_surface_content(world_state: WorldState, root: Dictionary) -> bool:
	var stamp_applicator: AuthoredMapStampApplicator = (
		AUTHORED_MAP_STAMP_APPLICATOR_SCRIPT.new() as AuthoredMapStampApplicator
	)
	if stamp_applicator == null:
		push_error("AuthoredMapLoader: Failed to create AuthoredMapStampApplicator.")
		return false

	var default_cell_values: Dictionary = root.get("default_cell", {}) as Dictionary
	stamp_applicator.apply_default_cells(world_state, default_cell_values)

	var stamps: Array = root.get("stamps", [])
	return stamp_applicator.apply_stamps(world_state, stamps)

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
	var reveal_source_loader: AuthoredRevealSourceLoader = (
		AUTHORED_REVEAL_SOURCE_LOADER_SCRIPT.new() as AuthoredRevealSourceLoader
	)
	if reveal_source_loader == null:
		push_error("AuthoredMapLoader: Failed to create AuthoredRevealSourceLoader.")
		return false

	return reveal_source_loader.apply_reveal_sources(world_state, reveal_sources)

func _apply_authored_terrain_objects(world_state: WorldState, terrain_objects: Array) -> bool:
	var terrain_object_loader: AuthoredTerrainObjectLoader = (
		AUTHORED_TERRAIN_OBJECT_LOADER_SCRIPT.new() as AuthoredTerrainObjectLoader
	)
	if terrain_object_loader == null:
		push_error("AuthoredMapLoader: Failed to create AuthoredTerrainObjectLoader.")
		return false

	return terrain_object_loader.apply_authored_terrain_objects(world_state, terrain_objects)

func _build_cell_key(cell_index: Vector2i) -> String:
	return "%s,%s" % [str(cell_index.x), str(cell_index.y)]

func _variant_to_cell_index(value: Variant) -> Vector2i:
	if not (value is Array):
		return INVALID_CELL_INDEX

	var cell_values: Array = value as Array
	if cell_values.size() != 2:
		return INVALID_CELL_INDEX

	return Vector2i(int(cell_values[0]), int(cell_values[1]))
