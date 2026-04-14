extends RefCounted
class_name PolicyBundleIds

# Sprint 1 placeholder policy bundle IDs.
# These let scenarios point at a stable vocabulary before policy systems exist.
const BUNDLE_STARTER_SURVIVAL: String = "pol_bundle_starter_survival"
const BUNDLE_STARTER_FOOD_WATER: String = "pol_bundle_starter_food_water"
const BUNDLE_STARTER_STORAGE: String = "pol_bundle_starter_storage"
const BUNDLE_STARTER_SANITATION: String = "pol_bundle_starter_sanitation"

const ALL_POLICY_BUNDLE_IDS := [
	BUNDLE_STARTER_SURVIVAL,
	BUNDLE_STARTER_FOOD_WATER,
	BUNDLE_STARTER_STORAGE,
	BUNDLE_STARTER_SANITATION,
]

static func is_valid_policy_bundle_id(policy_bundle_id: String) -> bool:
	var trimmed_policy_bundle_id: String = policy_bundle_id.strip_edges()
	return ALL_POLICY_BUNDLE_IDS.has(trimmed_policy_bundle_id)

static func get_all_policy_bundle_ids() -> Array:
	return ALL_POLICY_BUNDLE_IDS.duplicate()
