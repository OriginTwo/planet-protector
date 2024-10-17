class_name ShakyCamera
extends Camera2D

@export var max_offset: float = 5
#NOTE: duration (second) = 1/decay
@export var decay: float = 4

var current_strength: float

func _process(delta: float) -> void:
	if current_strength > 0:
		offset = Vector2(randf_range(-max_offset, max_offset), randf_range(-max_offset, max_offset))*current_strength
	current_strength = max(current_strength - decay*delta, 0)

func shake(strength: float = 1.0) -> void:
	current_strength = clamp(current_strength + strength, 0, 1)
