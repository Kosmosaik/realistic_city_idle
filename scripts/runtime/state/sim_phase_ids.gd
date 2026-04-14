extends RefCounted
class_name SimPhaseIds

# Branch 02 uses a stable phase vocabulary so later systems can attach
# without inventing parallel update orders in random places.

const PHASE_COMMAND_INTAKE: String = "phase.command_intake"
const PHASE_TIME_STEP_START: String = "phase.time_step_start"
const PHASE_WORLD_PRE_UPDATE: String = "phase.world_pre_update"
const PHASE_SIMULATION_UPDATE: String = "phase.simulation_update"
const PHASE_VISIBILITY_REFRESH: String = "phase.visibility_refresh"
const PHASE_DEBUG_SNAPSHOT: String = "phase.debug_snapshot"
const PHASE_END_OF_TICK_BOOKKEEPING: String = "phase.end_of_tick_bookkeeping"

const ORDERED_PHASE_IDS: Array[String] = [
	PHASE_COMMAND_INTAKE,
	PHASE_TIME_STEP_START,
	PHASE_WORLD_PRE_UPDATE,
	PHASE_SIMULATION_UPDATE,
	PHASE_VISIBILITY_REFRESH,
	PHASE_DEBUG_SNAPSHOT,
	PHASE_END_OF_TICK_BOOKKEEPING,
]

static func get_all_phase_ids() -> Array[String]:
	return ORDERED_PHASE_IDS.duplicate()

static func is_valid_phase_id(phase_id: String) -> bool:
	var trimmed_phase_id: String = phase_id.strip_edges()
	return ORDERED_PHASE_IDS.has(trimmed_phase_id)

static func get_phase_index(phase_id: String) -> int:
	return ORDERED_PHASE_IDS.find(phase_id)
