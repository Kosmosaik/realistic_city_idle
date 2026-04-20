extends RefCounted
class_name BootDefaults

const DEFAULT_SCENARIO_ID: String = "scenario.dev.temperate_valley"
const DEFAULT_STAGE_ID: String = "stage.lone_survivor"
const DEFAULT_MAP_PRESET_ID: String = "starter_map_balanced"
const DEFAULT_WORLDGEN_PROFILE_ID: String = "authored_starter_temperate_valley"
const DEFAULT_SEASON_PROFILE_ID: String = "temperate_four_season_basic"
const DEFAULT_SEED: int = 100001


static func get_default_scenario_id() -> String:
	return DEFAULT_SCENARIO_ID


static func get_default_stage_id() -> String:
	return DEFAULT_STAGE_ID


static func get_default_map_preset_id() -> String:
	return DEFAULT_MAP_PRESET_ID


static func get_default_worldgen_profile_id() -> String:
	return DEFAULT_WORLDGEN_PROFILE_ID


static func get_default_season_profile_id() -> String:
	return DEFAULT_SEASON_PROFILE_ID


static func get_default_seed() -> int:
	return DEFAULT_SEED


static func build_default_calendar_snapshot() -> Dictionary:
	return {
		"tick_index": 0,
		"year_index": 0,
		"day_index": 1,
		"season_id": "season.spring",
		"part_of_day_id": "part_of_day.dawn",
		"season_profile_id": DEFAULT_SEASON_PROFILE_ID,
		"ticks_per_part_of_day": 1,
		"tick_progress_within_part": 0,
		"is_paused": true,
		"speed_index": 0,
		"speed_multiplier": 1,
		"active_phase_id": "",
		"last_completed_phase_id": "",
		"base_ticks_per_second": 1.0,
		"effective_ticks_per_second": 1.0,
		"scheduled_trigger_count": 0,
		"next_scheduled_trigger_tick": -1,
		"queued_command_count": 0,
		"phase_listener_count_total": 0,
		"rng_stream_count": 0,
		"scenario_seed": DEFAULT_SEED,
		"debug_visible_phase_id": "",
		"debug_visible_phase_tick_index": 0,
		"debug_visible_phase_transition_serial": 0,
		"debug_last_completed_tick_index": 0,
		"debug_last_tick_total_duration_usec": 0,
		"debug_last_tick_phase_durations_usec": {},
		"debug_recent_phase_entries": [],
		"debug_last_resolved_trigger_id": "",
	}


static func build_default_boot_context() -> Dictionary:
	return {
		"scenario_id": DEFAULT_SCENARIO_ID,
		"stage_id": DEFAULT_STAGE_ID,
		"map_preset_id": DEFAULT_MAP_PRESET_ID,
		"worldgen_profile_id": DEFAULT_WORLDGEN_PROFILE_ID,
		"season_profile_id": DEFAULT_SEASON_PROFILE_ID,
		"seed": DEFAULT_SEED,
		"calendar": build_default_calendar_snapshot(),
	}
