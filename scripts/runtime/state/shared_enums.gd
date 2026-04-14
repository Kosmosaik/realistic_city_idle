extends RefCounted
class_name SharedEnums

const ALERT_SEVERITIES := [
	"info",
	"warning",
	"urgent",
	"critical",
]

const ALERT_DOMAINS := [
	"water",
	"food",
	"fire",
	"shelter",
	"sleep",
	"storage",
	"reserve",
	"sanitation",
	"health",
	"weather",
	"social",
	"task_flow",
]

const FOG_STATES := [
	"unknown",
	"remembered",
	"visible",
]

const LANDFORM_TYPES := [
	"ridge",
	"slope",
	"bench",
	"flat",
	"depression",
	"channel",
]

const SLOPE_CLASSES := [
	"flat",
	"gentle",
	"moderate",
	"steep",
]

const DRAINAGE_CLASSES := [
	"very_poor",
	"poor",
	"moderate",
	"good",
	"excessive",
]

const VEGETATION_COVER_CLASSES := [
	"bare",
	"sparse",
	"grass",
	"brush",
	"woodland",
	"forest",
	"wetland",
]

const WATER_SOURCE_TYPES := [
	"river",
	"stream",
	"spring",
	"pond",
	"lake",
	"seep",
]

const ZONE_FAMILIES := [
	"life_support",
	"work",
	"storage",
	"sanitation",
	"care",
	"social",
	"perimeter",
]

const POLICY_FAMILIES := [
	"survival_policy",
	"water_policy",
	"food_policy",
	"reserve_policy",
	"ration_policy",
	"work_policy",
	"role_policy",
	"training_policy",
	"hazard_policy",
	"social_policy",
	"layout_policy",
]

const POLICY_EFFECT_VERBS := [
	"allow",
	"forbid",
	"prefer",
	"discourage",
	"reserve",
	"release",
	"prioritize",
	"deprioritize",
	"assign",
	"protect",
	"route_to",
	"lock",
	"unlock",
]

const RESERVE_BUCKET_IDS := [
	"reserve_drinking_water",
	"reserve_fuel",
	"reserve_immediate_food",
	"reserve_dry_food",
	"reserve_emergency_food",
	"reserve_seed",
	"reserve_bedding_clothing",
	"reserve_repair_materials",
	"reserve_clean_containers",
]

const STOCKPOINT_ROLES := [
	"general",
	"water",
	"food",
	"fuel",
	"materials",
	"tools",
	"seed",
	"waste",
]

const STORAGE_ROLES := [
	"dry",
	"covered",
	"potable",
	"dirty",
	"seed_protected",
	"fuel_dry",
	"waste",
]

const ORDER_TYPE_IDS := [
	"order_build",
	"order_gather",
	"order_haul",
	"order_designate_zone",
	"order_set_policy",
]

static func contains_value(values: Array, value: String) -> bool:
	return values.has(value)
