extends RefCounted
class_name TerrainObjectPlacementValidator

const SUPPORTED_PLACEMENT_FAMILIES = [
	"tree",
	"wet_margin_plant",
	"rocky_marker",
]

static func validate_placement(
	placement_family: String,
	cell_state: WorldCellState
) -> Array[String]:
	var validation_messages: Array[String] = []

	match placement_family:
		"tree":
			if cell_state.surface_water_type != "none":
				validation_messages.append(
					"trees cannot be placed inside open-water or channel cells"
				)

			if cell_state.wetness_tendency == "saturated":
				validation_messages.append(
					"trees require non-saturated ground"
				)

			if cell_state.drainage_class == "very_poor" or cell_state.drainage_class == "poor":
				validation_messages.append(
					"trees require better-than-poor drainage"
				)

			if cell_state.vegetation_cover_class == "wetland":
				validation_messages.append(
					"trees do not validate inside wetland vegetation cells"
				)

		"wet_margin_plant":
			if cell_state.surface_water_type != "none":
				validation_messages.append(
					"wet-margin plants should be placed on the bank, not inside open water"
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

static func _cell_supports_wet_margin_plants(cell_state: WorldCellState) -> bool:
	if cell_state.wetness_tendency == "wet":
		return true

	if cell_state.wetness_tendency == "saturated":
		return true

	if cell_state.drainage_class == "very_poor":
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

static func _cell_supports_rocky_markers(cell_state: WorldCellState) -> bool:
	if cell_state.landform_type == "ridge":
		return true

	if cell_state.landform_type == "slope":
		return true

	return false
