extends BaseDef
class_name UiPanelDef

# Minimal static panel metadata for later HUD/panel systems.
const ALLOWED_PANEL_GROUPS: Array = [
	"summary",
	"alerts",
	"progression",
	"selection",
	"debug",
]

@export var ui_panel_id: String = ""
@export var panel_group: String = ""
@export var supported_alert_domains: PackedStringArray = PackedStringArray()
@export var default_visible: bool = true
@export var starts_collapsed: bool = false
@export var is_debug_only: bool = false

func get_definition_id() -> String:
	return ui_panel_id

func get_definition_type() -> String:
	return DefinitionTypes.TYPE_UI_PANEL

func validate_definition() -> Array[String]:
	var errors: Array[String] = super.validate_definition()

	if ui_panel_id.strip_edges().is_empty():
		errors.append("UiPanelDef is missing ui_panel_id.")

	var trimmed_panel_group: String = panel_group.strip_edges()
	if trimmed_panel_group.is_empty():
		errors.append("%s is missing panel_group." % get_debug_label())
	elif not ALLOWED_PANEL_GROUPS.has(trimmed_panel_group):
		errors.append("%s uses unknown panel_group '%s'." % [get_debug_label(), trimmed_panel_group])

	var alert_domain: String = ""
	for alert_domain_value: String in supported_alert_domains:
		alert_domain = alert_domain_value.strip_edges()

		if alert_domain.is_empty():
			continue

		if not SharedEnums.contains_value(SharedEnums.ALERT_DOMAINS, alert_domain):
			errors.append("%s uses unknown supported_alert_domain '%s'." % [get_debug_label(), alert_domain])

	return errors
