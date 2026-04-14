extends BaseDef
class_name SeasonProfileDef

# Minimal season/calendar bundle for Sprint 1 compatibility.
@export var season_profile_id: String = ""
@export var supported_season_ids: PackedStringArray = PackedStringArray([
	CalendarIds.SEASON_SPRING,
	CalendarIds.SEASON_SUMMER,
	CalendarIds.SEASON_AUTUMN,
	CalendarIds.SEASON_WINTER,
])
@export var default_start_season_id: String = CalendarIds.SEASON_SPRING
@export var part_of_day_ids: PackedStringArray = PackedStringArray([
	CalendarIds.PART_OF_DAY_DAWN,
	CalendarIds.PART_OF_DAY_DAY,
	CalendarIds.PART_OF_DAY_DUSK,
	CalendarIds.PART_OF_DAY_NIGHT,
])
@export var ticks_per_part_of_day: int = 1

func get_definition_id() -> String:
	return season_profile_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_SEASON_PROFILE

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if season_profile_id.strip_edges().is_empty():
		errors.append("SeasonProfileDef is missing season_profile_id.")

	if supported_season_ids.is_empty():
		errors.append("%s has no supported_season_ids." % get_debug_label())

	var supported_season_id: String = ""
	for season_value: String in supported_season_ids:
		supported_season_id = season_value.strip_edges()

		if not CalendarIds.is_valid_season_id(supported_season_id):
			errors.append("%s uses unknown supported season '%s'." % [get_debug_label(), supported_season_id])

	if not CalendarIds.is_valid_season_id(default_start_season_id):
		errors.append("%s uses invalid default_start_season_id '%s'." % [get_debug_label(), default_start_season_id])

	if part_of_day_ids.is_empty():
		errors.append("%s has no part_of_day_ids." % get_debug_label())

	var part_of_day_id: String = ""
	for part_of_day_value: String in part_of_day_ids:
		part_of_day_id = part_of_day_value.strip_edges()

		if not CalendarIds.is_valid_part_of_day_id(part_of_day_id):
			errors.append("%s uses unknown part_of_day_id '%s'." % [get_debug_label(), part_of_day_id])

	if ticks_per_part_of_day < 1:
		errors.append("%s has ticks_per_part_of_day < 1." % get_debug_label())

	return errors
