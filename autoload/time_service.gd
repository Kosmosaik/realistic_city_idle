extends Node

const DEFAULT_TICK_INDEX: int = 0
const DEFAULT_DAY_INDEX: int = 1
const DEFAULT_YEAR_INDEX: int = 0
const DEFAULT_SEASON_ID: String = "season.spring"
const DEFAULT_PART_OF_DAY_ID: String = "part_of_day.dawn"

var tick_index: int = DEFAULT_TICK_INDEX
var day_index: int = DEFAULT_DAY_INDEX
var year_index: int = DEFAULT_YEAR_INDEX
var season_id: String = DEFAULT_SEASON_ID
var part_of_day_id: String = DEFAULT_PART_OF_DAY_ID

func get_calendar_snapshot() -> Dictionary:
	return {
		"tick_index": tick_index,
		"day_index": day_index,
		"year_index": year_index,
		"season_id": season_id,
		"part_of_day_id": part_of_day_id,
	}
