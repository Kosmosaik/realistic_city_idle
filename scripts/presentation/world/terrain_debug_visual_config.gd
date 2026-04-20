extends RefCounted
class_name TerrainDebugVisualConfig

const OVERLAY_MODE_IDS: Array[String] = [
	"off",
	"elevation",
	"drainage",
	"wetness",
	"vegetation",
	"buildability",
	"site_score",
	"patch_boundaries",
	"fog_memory",
]

const HOVER_OUTLINE_COLOR: Color = Color(1.0, 0.88, 0.20, 0.98)
const SELECTED_OUTLINE_COLOR: Color = Color(0.25, 0.95, 1.0, 0.98)

const TRANSPARENT_COLOR: Color = Color(0.0, 0.0, 0.0, 0.0)
const DEFAULT_PATCH_BOUNDARY_COLOR: Color = Color(1.0, 1.0, 1.0, 0.75)
const DEFAULT_PATCH_BOUNDARY_LINE_WIDTH_WORLD: float = 1.0


func get_overlay_mode_ids() -> Array[String]:
	var result: Array[String] = []

	for overlay_mode_id: String in OVERLAY_MODE_IDS:
		result.append(overlay_mode_id)

	return result


func get_default_overlay_mode_id() -> String:
	if OVERLAY_MODE_IDS.is_empty():
		return "off"

	return OVERLAY_MODE_IDS[0]


func is_valid_overlay_mode_id(overlay_mode_id: String) -> bool:
	return OVERLAY_MODE_IDS.has(overlay_mode_id)


func build_cell_highlight_style(
	highlight_kind_id: String,
	zoom_band_id: String,
	zoom_scalar: float
) -> Dictionary:
	var safe_zoom_scalar: float = maxf(zoom_scalar, 0.001)

	var outline_color: Color = HOVER_OUTLINE_COLOR
	var fill_color: Color = TRANSPARENT_COLOR
	var desired_screen_outline_width_pixels: float = 2.0

	match highlight_kind_id:
		"selected":
			outline_color = SELECTED_OUTLINE_COLOR

			match zoom_band_id:
				"close":
					desired_screen_outline_width_pixels = 1.0
					fill_color = TRANSPARENT_COLOR
				"mid":
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(0.25, 0.95, 1.0, 0.08)
				"far":
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(0.25, 0.95, 1.0, 0.16)
				_:
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(0.25, 0.95, 1.0, 0.08)

		_:
			outline_color = HOVER_OUTLINE_COLOR

			match zoom_band_id:
				"close":
					desired_screen_outline_width_pixels = 1.0
					fill_color = TRANSPARENT_COLOR
				"mid":
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(1.0, 0.88, 0.20, 0.06)
				"far":
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(1.0, 0.88, 0.20, 0.14)
				_:
					desired_screen_outline_width_pixels = 1.0
					fill_color = Color(1.0, 0.88, 0.20, 0.06)

	return {
		"outline_color": outline_color,
		"fill_color": fill_color,
		"draw_fill": fill_color.a > 0.0,
		"outline_width_world": desired_screen_outline_width_pixels / safe_zoom_scalar,
	}


func get_elevation_overlay_gradient() -> Dictionary:
	return {
		"low_color": Color(0.10, 0.20, 0.32, 0.32),
		"high_color": Color(0.78, 0.60, 0.30, 0.55),
	}


func resolve_drainage_overlay_color(drainage_class: String) -> Color:
	match drainage_class:
		"poor":
			return Color(0.95, 0.35, 0.20, 0.45)
		"moderate":
			return Color(0.92, 0.75, 0.20, 0.38)
		"good":
			return Color(0.20, 0.78, 0.52, 0.34)
		_:
			return Color(0.50, 0.50, 0.50, 0.18)


func resolve_wetness_overlay_color(wetness_tendency: String) -> Color:
	match wetness_tendency:
		"dry":
			return Color(0.90, 0.78, 0.42, 0.30)
		"damp":
			return Color(0.38, 0.74, 0.58, 0.30)
		"wet":
			return Color(0.22, 0.55, 0.95, 0.42)
		_:
			return Color(0.55, 0.55, 0.55, 0.16)


func resolve_vegetation_overlay_color(vegetation_cover_class: String) -> Color:
	match vegetation_cover_class:
		"none":
			return Color(0.65, 0.60, 0.48, 0.16)
		"sparse":
			return Color(0.62, 0.76, 0.42, 0.22)
		"grass":
			return Color(0.42, 0.82, 0.32, 0.28)
		"brush":
			return Color(0.24, 0.60, 0.24, 0.34)
		"woodland":
			return Color(0.14, 0.42, 0.18, 0.40)
		_:
			return Color(0.30, 0.70, 0.30, 0.22)


func resolve_buildability_overlay_color(is_buildable: bool) -> Color:
	if is_buildable:
		return Color(0.18, 0.78, 0.32, 0.28)

	return Color(0.85, 0.20, 0.20, 0.30)


func resolve_site_score_fill_color(normalized_site_score: float) -> Color:
	var clamped_score: float = clampf(normalized_site_score, 0.0, 1.0)

	var low_color: Color = Color(0.84, 0.30, 0.20, 0.26)
	var mid_color: Color = Color(0.95, 0.74, 0.24, 0.24)
	var high_color: Color = Color(0.24, 0.78, 0.40, 0.24)

	if clamped_score <= 0.5:
		return _lerp_color(low_color, mid_color, clamped_score / 0.5)

	return _lerp_color(mid_color, high_color, (clamped_score - 0.5) / 0.5)


func resolve_site_score_outline_color(normalized_site_score: float) -> Color:
	var clamped_score: float = clampf(normalized_site_score, 0.0, 1.0)

	var low_color: Color = Color(0.92, 0.32, 0.24, 0.60)
	var mid_color: Color = Color(1.0, 0.82, 0.28, 0.58)
	var high_color: Color = Color(0.32, 0.92, 0.48, 0.60)

	if clamped_score <= 0.5:
		return _lerp_color(low_color, mid_color, clamped_score / 0.5)

	return _lerp_color(mid_color, high_color, (clamped_score - 0.5) / 0.5)


func resolve_patch_outline_color(surface_water_type: String, is_buildable: bool) -> Color:
	if surface_water_type != "none":
		return Color(0.28, 0.68, 1.0, 0.85)

	if is_buildable:
		return Color(0.40, 1.0, 0.55, 0.85)

	return DEFAULT_PATCH_BOUNDARY_COLOR


func get_patch_boundary_line_width_world() -> float:
	return DEFAULT_PATCH_BOUNDARY_LINE_WIDTH_WORLD


func resolve_fog_memory_overlay_color(
	is_currently_visible: bool,
	is_revealed: bool
) -> Color:
	if is_currently_visible:
		return Color(0.85, 1.0, 0.90, 0.06)

	if is_revealed:
		return Color(0.40, 0.52, 0.78, 0.24)

	return Color(0.03, 0.04, 0.06, 0.56)


func build_overlay_legend_lines(overlay_mode_id: String) -> Array[String]:
	match overlay_mode_id:
		"off":
			return [
				"  - overlay disabled",
			]
		"elevation":
			return [
				"  - low ground = cool dark tint",
				"  - high ground = warm tan tint",
			]
		"drainage":
			return [
				"  - poor drainage = red/orange",
				"  - moderate drainage = amber",
				"  - good drainage = green",
			]
		"wetness":
			return [
				"  - dry = tan",
				"  - damp = teal-green",
				"  - wet = blue",
			]
		"vegetation":
			return [
				"  - none = bare muted tint",
				"  - sparse / grass / brush / woodland = increasingly denser green tint",
			]
		"buildability":
			return [
				"  - buildable = green",
				"  - not buildable = red",
			]
		"site_score":
			return [
				"  - red = weak site",
				"  - amber = mixed / usable site",
				"  - green = strong site",
			]
		"patch_boundaries":
			return [
				"  - blue outline = water patch",
				"  - green outline = buildable patch",
				"  - white outline = other patch",
			]
		"fog_memory":
			return [
				"  - visible = nearly clear",
				"  - remembered = muted blue tint",
				"  - hidden = dark obscuring tint",
			]
		_:
			return [
				"  - no legend available",
			]


func _lerp_color(color_a: Color, color_b: Color, weight: float) -> Color:
	return Color(
		lerpf(color_a.r, color_b.r, weight),
		lerpf(color_a.g, color_b.g, weight),
		lerpf(color_a.b, color_b.b, weight),
		lerpf(color_a.a, color_b.a, weight)
	)
