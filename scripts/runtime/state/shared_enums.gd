extends RefCounted
class_name SharedEnums

const ALERT_SEVERITIES: Array[String] = [
	"info",
	"warning",
	"urgent",
	"critical",
]

const ALERT_DOMAINS: Array[String] = [
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

const ITEM_CATEGORIES: Array[String] = [
	"food",
	"water",
	"fuel",
	"material",
	"tool",
	"medicine",
]

const NEED_IDS: Array[String] = [
	"hydration",
	"nutrition",
	"rest",
	"shelter",
	"sanitation",
	"safety",
]

const NPC_STATUS_IDS: Array[String] = [
	"idle",
	"working",
	"hauling",
	"resting",
	"injured",
]

const STAGE_IDS: Array[String] = [
	"stage.lone_survivor",
]

const BIOME_IDS: Array[String] = [
	"temperate_valley",
]

const LAND_COVER_TYPES: Array[String] = [
	"grassland",
	"woodland",
	"wetland",
	"rocky",
	"clearing",
]

const LAND_USE_TYPES: Array[String] = [
	"wild",
	"camp_core",
	"camp_edge",
	"foraging_zone",
	"water_access",
	"waste_zone",
]

const ZONE_FAMILIES: Array[String] = [
	"life_support",
	"work",
	"storage",
	"sanitation",
	"care",
	"social",
	"perimeter",
	"camp",
	"water",
	"waste",
]

const POLICY_FAMILIES: Array[String] = [
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

const POLICY_EFFECT_VERBS: Array[String] = [
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

const RESERVE_BUCKET_IDS: Array[String] = [
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

const STOCKPOINT_ROLES: Array[String] = [
	"general",
	"water",
	"food",
	"fuel",
	"materials",
	"tools",
	"seed",
	"waste",
]

const STORAGE_ROLES: Array[String] = [
	"dry",
	"covered",
	"potable",
	"dirty",
	"seed_protected",
	"fuel_dry",
	"waste",
]

const ORDER_TYPE_IDS: Array[String] = [
	"order_build",
	"order_gather",
	"order_haul",
	"order_designate_zone",
	"order_set_policy",
]

const SLOPE_CLASSES: Array[String] = [
	"flat",
	"gentle",
	"moderate",
	"steep",
]

const LANDFORM_TYPES: Array[String] = [
	"ridge",
	"slope",
	"bench",
	"flat",
	"depression",
	"channel",
]

const DRAINAGE_CLASSES: Array[String] = [
	"very_poor",
	"poor",
	"moderate",
	"good",
	"excessive",
]

const VEGETATION_COVER_CLASSES: Array[String] = [
	"bare",
	"sparse",
	"grass",
	"brush",
	"woodland",
	"forest",
	"wetland",
]

const WATER_SOURCE_TYPES: Array[String] = [
	"river",
	"stream",
	"spring",
	"pond",
	"lake",
	"seep",
]

# Old compatibility name still kept for safety.
const FOG_STATES: Array[String] = [
	"unknown",
	"remembered",
	"visible",
]

# New explicit name used by the Branch 03 loader.
const FOG_STATE_IDS: Array[String] = [
	"unknown",
	"remembered",
	"visible",
]

const SURFACE_WATER_TYPES: Array[String] = [
	"none",
	"channel",
	"pond",
	"spring",
	"seep",
	"lake",
	"stream",
	"river",
]

const WETNESS_TENDENCIES: Array[String] = [
	"dry",
	"balanced",
	"damp",
	"wet",
	"saturated",
]

const GROUND_FIRMNESS_CLASSES: Array[String] = [
	"soft",
	"firm",
	"hard",
]

static func contains_value(values: Array, value: String) -> bool:
	return values.has(value)
