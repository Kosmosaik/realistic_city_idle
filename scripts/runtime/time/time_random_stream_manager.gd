extends RefCounted
class_name TimeRandomStreamManager

# Internal deterministic RNG stream manager used by TimeService.
# TimeService keeps the public API, validation surface, and telemetry logging.

var _root_seed: int = 0
var _rng_streams: Dictionary = {}


func set_root_seed(root_seed: int) -> bool:
	if _root_seed == root_seed:
		return false

	_root_seed = root_seed
	clear_streams()
	return true


func ensure_rng_stream(stream_id: String) -> Dictionary:
	var trimmed_stream_id: String = stream_id.strip_edges()
	if trimmed_stream_id.is_empty():
		push_error("TimeRandomStreamManager: stream_id must not be empty.")
		return {}

	if _rng_streams.has(trimmed_stream_id):
		return {}

	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var stream_seed: int = _build_stream_seed(_root_seed, trimmed_stream_id)
	rng.seed = stream_seed

	_rng_streams[trimmed_stream_id] = {
		"rng": rng,
		"initial_seed": stream_seed,
		"draw_count": 0,
	}

	return {
		"stream_id": trimmed_stream_id,
		"initial_seed": stream_seed,
		"rng_stream_count": _rng_streams.size(),
	}


func randf_stream(stream_id: String) -> float:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return 0.0

	var value: float = rng.randf()
	_increment_rng_stream_draw_count(stream_id)
	return value


func randi_stream(stream_id: String) -> int:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return 0

	var value: int = rng.randi()
	_increment_rng_stream_draw_count(stream_id)
	return value


func randi_range_stream(stream_id: String, from_value: int, to_value: int) -> int:
	var rng: RandomNumberGenerator = _require_rng_stream(stream_id)
	if rng == null:
		return from_value

	var value: int = rng.randi_range(from_value, to_value)
	_increment_rng_stream_draw_count(stream_id)
	return value


func shuffle_array_with_stream(values: Array, stream_id: String) -> Array:
	var shuffled_values: Array = values.duplicate(true)
	var last_index: int = shuffled_values.size() - 1

	while last_index > 0:
		var swap_index: int = randi_range_stream(stream_id, 0, last_index)
		var temp_value: Variant = shuffled_values[last_index]
		shuffled_values[last_index] = shuffled_values[swap_index]
		shuffled_values[swap_index] = temp_value
		last_index -= 1

	return shuffled_values


func get_state_snapshot() -> Dictionary:
	var snapshot: Dictionary = {}
	var sorted_stream_ids: Array = _rng_streams.keys()
	sorted_stream_ids.sort()

	for stream_id_variant: Variant in sorted_stream_ids:
		var stream_id: String = str(stream_id_variant)
		var stream_record: Dictionary = _rng_streams.get(stream_id, {})
		var rng: RandomNumberGenerator = stream_record.get("rng")
		if rng == null:
			continue

		snapshot[stream_id] = {
			"initial_seed": int(stream_record.get("initial_seed", 0)),
			"draw_count": int(stream_record.get("draw_count", 0)),
			"state": int(rng.state),
		}

	return snapshot


func get_stream_count() -> int:
	return _rng_streams.size()


func clear_streams() -> void:
	_rng_streams.clear()


func _require_rng_stream(stream_id: String) -> RandomNumberGenerator:
	var trimmed_stream_id: String = stream_id.strip_edges()
	if trimmed_stream_id.is_empty():
		push_error("TimeRandomStreamManager: stream_id must not be empty.")
		return null

	ensure_rng_stream(trimmed_stream_id)

	var stream_record: Dictionary = _rng_streams.get(trimmed_stream_id, {})
	var rng: RandomNumberGenerator = stream_record.get("rng")
	if rng == null:
		push_error(
			"TimeRandomStreamManager: failed to resolve RNG stream '%s'." % trimmed_stream_id
		)
		return null

	return rng


func _increment_rng_stream_draw_count(stream_id: String) -> void:
	var trimmed_stream_id: String = stream_id.strip_edges()
	if trimmed_stream_id.is_empty():
		return

	if not _rng_streams.has(trimmed_stream_id):
		return

	var stream_record: Dictionary = _rng_streams.get(trimmed_stream_id, {})
	var draw_count: int = int(stream_record.get("draw_count", 0))
	stream_record["draw_count"] = draw_count + 1
	_rng_streams[trimmed_stream_id] = stream_record


func _build_stream_seed(root_seed: int, stream_id: String) -> int:
	var stream_hash: int = 2166136261
	var stream_bytes: PackedByteArray = stream_id.to_utf8_buffer()

	for stream_byte: int in stream_bytes:
		stream_hash = int((stream_hash ^ stream_byte) & 0x7fffffff)
		stream_hash = int((stream_hash * 16777619) & 0x7fffffff)

	var mixed_seed: int = int((root_seed ^ stream_hash) & 0x7fffffff)
	if mixed_seed == 0:
		mixed_seed = 1

	return mixed_seed
