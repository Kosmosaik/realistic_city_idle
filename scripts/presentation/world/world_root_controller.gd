extends Node2D
class_name WorldRootController

const TERRAIN_RENDERER_SCRIPT: Script = preload("res://scripts/presentation/world/authoritative_terrain_renderer.gd")
const TERRAIN_OVERLAY_RENDERER_SCRIPT: Script = preload("res://scripts/presentation/world/terrain_overlay_renderer.gd")
const TERRAIN_OVERLAY_OUTLINE_RENDERER_SCRIPT: Script = preload("res://scripts/presentation/world/terrain_overlay_outline_renderer.gd")
const TERRAIN_INSPECTOR_PANEL_SCRIPT: Script = preload("res://scripts/presentation/ui/terrain_inspector_panel.gd")
const DEV_HUD_SCRIPT: Script = preload("res://scripts/presentation/ui/dev_hud.gd")
const WORLD_CELL_INSPECTOR_PROBE_SCRIPT: Script = preload("res://scripts/presentation/world/world_cell_inspector_probe.gd")
const WORLD_CAMERA_CONTROLLER_SCRIPT: Script = preload("res://scripts/presentation/world/world_camera_controller.gd")

const TERRAIN_RENDERER_NAME: String = "AuthoritativeTerrainRenderer"
const TERRAIN_OVERLAY_RENDERER_NAME: String = "TerrainOverlayRenderer"
const TERRAIN_OVERLAY_OUTLINE_RENDERER_NAME: String = "TerrainOverlayOutlineRenderer"
const TERRAIN_INSPECTOR_PANEL_NAME: String = "TerrainInspectorPanel"
const DEV_HUD_NAME: String = "DevHud"
const WORLD_CELL_INSPECTOR_PROBE_NAME: String = "WorldCellInspectorProbe"
const CAMERA_NAME: String = "WorldCamera2D"

func _ready() -> void:
	_ensure_camera()
	_ensure_terrain_renderer()
	_ensure_terrain_overlay_renderer()
	_ensure_terrain_overlay_outline_renderer()
	_ensure_terrain_inspector_panel()
	_ensure_dev_hud()
	_ensure_world_cell_inspector_probe()

	var sim_root: Node = get_node_or_null("/root/SimRoot")
	if sim_root != null and sim_root.has_method("register_world_root"):
		sim_root.call("register_world_root", self)

func _ensure_terrain_renderer() -> void:
	var renderer: Node2D = get_node_or_null(TERRAIN_RENDERER_NAME) as Node2D
	if renderer != null:
		return

	renderer = TERRAIN_RENDERER_SCRIPT.new()
	renderer.name = TERRAIN_RENDERER_NAME
	add_child(renderer)

func _ensure_terrain_overlay_renderer() -> void:
	var renderer: Node2D = get_node_or_null(TERRAIN_OVERLAY_RENDERER_NAME) as Node2D
	if renderer != null:
		return

	renderer = TERRAIN_OVERLAY_RENDERER_SCRIPT.new()
	renderer.name = TERRAIN_OVERLAY_RENDERER_NAME
	add_child(renderer)

func _ensure_terrain_overlay_outline_renderer() -> void:
	var renderer: Node2D = get_node_or_null(TERRAIN_OVERLAY_OUTLINE_RENDERER_NAME) as Node2D
	if renderer != null:
		return

	renderer = TERRAIN_OVERLAY_OUTLINE_RENDERER_SCRIPT.new()
	renderer.name = TERRAIN_OVERLAY_OUTLINE_RENDERER_NAME
	add_child(renderer)

func _ensure_camera() -> void:
	var existing_camera: Camera2D = get_node_or_null(CAMERA_NAME) as Camera2D

	if existing_camera != null and existing_camera.get_script() != WORLD_CAMERA_CONTROLLER_SCRIPT:
		remove_child(existing_camera)
		existing_camera.queue_free()
		existing_camera = null

	if existing_camera == null:
		existing_camera = WORLD_CAMERA_CONTROLLER_SCRIPT.new()
		existing_camera.name = CAMERA_NAME
		add_child(existing_camera)

	existing_camera.make_current()

func _ensure_terrain_inspector_panel() -> void:
	var existing_panel: CanvasLayer = get_node_or_null(TERRAIN_INSPECTOR_PANEL_NAME) as CanvasLayer
	if existing_panel != null:
		return

	var terrain_inspector_panel: CanvasLayer = TERRAIN_INSPECTOR_PANEL_SCRIPT.new()
	terrain_inspector_panel.name = TERRAIN_INSPECTOR_PANEL_NAME
	add_child(terrain_inspector_panel)

func _ensure_dev_hud() -> void:
	var existing_hud: CanvasLayer = get_node_or_null(DEV_HUD_NAME) as CanvasLayer
	if existing_hud != null:
		return

	var dev_hud: CanvasLayer = DEV_HUD_SCRIPT.new()
	dev_hud.name = DEV_HUD_NAME
	add_child(dev_hud)

func _ensure_world_cell_inspector_probe() -> void:
	var existing_probe: Node2D = get_node_or_null(WORLD_CELL_INSPECTOR_PROBE_NAME) as Node2D
	if existing_probe != null:
		return

	var world_cell_inspector_probe: Node2D = WORLD_CELL_INSPECTOR_PROBE_SCRIPT.new()
	world_cell_inspector_probe.name = WORLD_CELL_INSPECTOR_PROBE_NAME
	add_child(world_cell_inspector_probe)

func get_camera_debug_snapshot() -> Dictionary:
	var camera: Node = get_node_or_null(CAMERA_NAME)
	if camera != null and camera.has_method("get_camera_debug_snapshot"):
		return camera.call("get_camera_debug_snapshot")

	return {}
