extends RefCounted
class_name TaskDefIds

# Sprint 1 placeholder task IDs.
# These are stable vocabulary anchors, not full task definitions yet.
const TASK_FETCH_WATER: String = "tsk_fetch_water"
const TASK_GATHER_FUEL: String = "tsk_gather_fuel"
const TASK_MAINTAIN_FIRE: String = "tsk_maintain_fire"
const TASK_GET_FOOD: String = "tsk_get_food"
const TASK_COOK_FOOD: String = "tsk_cook_food"
const TASK_REST: String = "tsk_rest"
const TASK_BUILD_SHELTER: String = "tsk_build_shelter"
const TASK_REPAIR_SHELTER: String = "tsk_repair_shelter"
const TASK_PRESERVE_FOOD: String = "tsk_preserve_food"
const TASK_PROTECT_SEED: String = "tsk_protect_seed"
const TASK_SCOUT_NEARBY_AREA: String = "tsk_scout_nearby_area"
const TASK_PREPARE_SLEEP_SITE: String = "tsk_prepare_sleep_site"
const TASK_MAKE_TOOL: String = "tsk_make_tool"
const TASK_IMPROVE_SANITATION: String = "tsk_improve_sanitation"
const TASK_REFILL_CLEAN_WATER_STORE: String = "tsk_refill_clean_water_store"
const TASK_SORT_STORAGE: String = "tsk_sort_storage"
const TASK_INSPECT_DRYING_FOOD: String = "tsk_inspect_drying_food"

# Added now because the remaining Branch 01 minimum content pack needs them.
const TASK_MAKE_CONTAINER: String = "tsk_make_container"
const TASK_TEND_GARDEN: String = "tsk_tend_garden"
const TASK_CLEAN_CAMP: String = "tsk_clean_camp"

const ALL_TASK_DEF_IDS: Array = [
	TASK_FETCH_WATER,
	TASK_GATHER_FUEL,
	TASK_MAINTAIN_FIRE,
	TASK_GET_FOOD,
	TASK_COOK_FOOD,
	TASK_REST,
	TASK_BUILD_SHELTER,
	TASK_REPAIR_SHELTER,
	TASK_PRESERVE_FOOD,
	TASK_PROTECT_SEED,
	TASK_SCOUT_NEARBY_AREA,
	TASK_PREPARE_SLEEP_SITE,
	TASK_MAKE_TOOL,
	TASK_IMPROVE_SANITATION,
	TASK_REFILL_CLEAN_WATER_STORE,
	TASK_SORT_STORAGE,
	TASK_INSPECT_DRYING_FOOD,
	TASK_MAKE_CONTAINER,
	TASK_TEND_GARDEN,
	TASK_CLEAN_CAMP,
]

static func is_valid_task_def_id(task_def_id: String) -> bool:
	var trimmed_task_def_id: String = task_def_id.strip_edges()
	return ALL_TASK_DEF_IDS.has(trimmed_task_def_id)

static func get_all_task_def_ids() -> Array:
	return ALL_TASK_DEF_IDS.duplicate()
