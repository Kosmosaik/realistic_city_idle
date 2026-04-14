extends BaseDef
class_name IncidentDef

# Minimal trigger categories for static incident metadata.
const ALLOWED_TRIGGER_KINDS: Array = [
	"state_threshold",
	"storage_failure",
	"process_failure",
	"environmental_hazard",
]

@export var incident_id: String = ""
@export var severity: String = ""
@export var primary_domain: String = ""
@export var trigger_kind: String = ""
@export var default_ui_panel_id: String = ""
@export var related_task_def_ids: PackedStringArray = PackedStringArray()
@export var related_process_def_ids: PackedStringArray = PackedStringArray()
@export var related_structure_def_ids: PackedStringArray = PackedStringArray()
@export var related_item_def_ids: PackedStringArray = PackedStringArray()
@export var is_player_notifiable: bool = true

func get_definition_id() -> String:
	return incident_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_INCIDENT

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if incident_id.strip_edges().is_empty():
		errors.append("IncidentDef is missing incident_id.")

	var trimmed_severity: String = severity.strip_edges()
	if trimmed_severity.is_empty():
		errors.append("%s is missing severity." % get_debug_label())
	elif not SharedEnums.contains_value(SharedEnums.ALERT_SEVERITIES, trimmed_severity):
		errors.append("%s uses unknown severity '%s'." % [get_debug_label(), trimmed_severity])

	var trimmed_primary_domain: String = primary_domain.strip_edges()
	if trimmed_primary_domain.is_empty():
		errors.append("%s is missing primary_domain." % get_debug_label())
	elif not SharedEnums.contains_value(SharedEnums.ALERT_DOMAINS, trimmed_primary_domain):
		errors.append("%s uses unknown primary_domain '%s'." % [get_debug_label(), trimmed_primary_domain])

	var trimmed_trigger_kind: String = trigger_kind.strip_edges()
	if trimmed_trigger_kind.is_empty():
		errors.append("%s is missing trigger_kind." % get_debug_label())
	elif not ALLOWED_TRIGGER_KINDS.has(trimmed_trigger_kind):
		errors.append("%s uses unknown trigger_kind '%s'." % [get_debug_label(), trimmed_trigger_kind])

	if default_ui_panel_id.strip_edges().is_empty():
		errors.append("%s is missing default_ui_panel_id." % get_debug_label())

	var task_def_id: String = ""
	for task_def_id_value: String in related_task_def_ids:
		task_def_id = task_def_id_value.strip_edges()

		if task_def_id.is_empty():
			continue

		if not TaskDefIds.is_valid_task_def_id(task_def_id):
			errors.append("%s uses unknown related_task_def_id '%s'." % [get_debug_label(), task_def_id])

	return errors
