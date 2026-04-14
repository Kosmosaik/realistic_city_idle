extends RefCounted
class_name ZoneTypes

const ALL_ZONE_TYPE_IDS := [
	"zone_type_water_fetch",
	"zone_type_clean_water_storage",
	"zone_type_wash_area",
	"zone_type_clean_food_prep",
	"zone_type_dirty_processing",
	"zone_type_sleep_area",
	"zone_type_hearth",
	"zone_type_drying",
	"zone_type_latrine",
	"zone_type_waste",
	"zone_type_seed_storage",
	"zone_type_garden",
	"zone_type_common_area",
	"zone_type_care_area",
	"zone_type_outer_cache",
]

static func is_valid_zone_type_id(zone_type_id: String) -> bool:
	return ALL_ZONE_TYPE_IDS.has(zone_type_id)
