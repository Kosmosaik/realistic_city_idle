extends RefCounted
class_name CalendarIds

# Shared calendar tokens used by the bootstrap shell and future simulation systems.
const SEASON_SPRING: String = "season.spring"
const SEASON_SUMMER: String = "season.summer"
const SEASON_AUTUMN: String = "season.autumn"
const SEASON_WINTER: String = "season.winter"

const PART_OF_DAY_DAWN: String = "part_of_day.dawn"
const PART_OF_DAY_DAY: String = "part_of_day.day"
const PART_OF_DAY_DUSK: String = "part_of_day.dusk"
const PART_OF_DAY_NIGHT: String = "part_of_day.night"

const ALL_SEASON_IDS: Array = [
	SEASON_SPRING,
	SEASON_SUMMER,
	SEASON_AUTUMN,
	SEASON_WINTER,
]

const ALL_PART_OF_DAY_IDS: Array = [
	PART_OF_DAY_DAWN,
	PART_OF_DAY_DAY,
	PART_OF_DAY_DUSK,
	PART_OF_DAY_NIGHT,
]

static func is_valid_season_id(season_id: String) -> bool:
	var trimmed_season_id: String = season_id.strip_edges()
	return ALL_SEASON_IDS.has(trimmed_season_id)

static func is_valid_part_of_day_id(part_of_day_id: String) -> bool:
	var trimmed_part_of_day_id: String = part_of_day_id.strip_edges()
	return ALL_PART_OF_DAY_IDS.has(trimmed_part_of_day_id)

static func get_all_season_ids() -> Array:
	return ALL_SEASON_IDS.duplicate()

static func get_all_part_of_day_ids() -> Array:
	return ALL_PART_OF_DAY_IDS.duplicate()
