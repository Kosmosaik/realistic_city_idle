extends RefCounted
class_name SimRootLocator

const SIM_ROOT_NODE_PATH: NodePath = NodePath("/root/SimRoot")


static func get_sim_root(from_node: Node) -> Node:
	if from_node == null:
		return null

	return from_node.get_node_or_null(SIM_ROOT_NODE_PATH)
