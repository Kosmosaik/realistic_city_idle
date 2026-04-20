extends Node2D
class_name WorldCellInspectorProbe

const SIM_ROOT_LOCATOR_SCRIPT: Script = preload("res://scripts/presentation/sim_root_locator.gd")

func _ready() -> void:
	set_process(true)
	set_process_unhandled_input(true)

func _process(_delta: float) -> void:
	var sim_root: Node = _sim_root()
	if sim_root == null:
		return

	if not sim_root.has_method("set_debug_hovered_cell_from_world_position"):
		return

	var world_mouse_position: Vector2 = get_global_mouse_position()
	sim_root.call("set_debug_hovered_cell_from_world_position", world_mouse_position)

func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton):
		return

	var mouse_button_event: InputEventMouseButton = event as InputEventMouseButton
	if mouse_button_event == null:
		return

	if not mouse_button_event.pressed:
		return

	var sim_root: Node = _sim_root()
	if sim_root == null:
		return

	var world_mouse_position: Vector2 = get_global_mouse_position()

	if mouse_button_event.button_index == MOUSE_BUTTON_LEFT:
		if sim_root.has_method("set_debug_selected_cell_from_world_position"):
			sim_root.call("set_debug_selected_cell_from_world_position", world_mouse_position)
			get_viewport().set_input_as_handled()
		return

	if mouse_button_event.button_index == MOUSE_BUTTON_RIGHT:
		if sim_root.has_method("clear_debug_selected_cell"):
			sim_root.call("clear_debug_selected_cell")
			get_viewport().set_input_as_handled()

func _sim_root() -> Node:
	return SIM_ROOT_LOCATOR_SCRIPT.get_sim_root(self)
