class_name ShakyCamera
extends Camera2D

@export var offset_max: float = 5
@export var duration: float = 0.3

var current_shake: float

func _process(_delta: float) -> void:
	if current_shake > 0:
		offset = Vector2(randf_range(-offset_max, offset_max), randf_range(-offset_max, offset_max))*current_shake

func shake() -> void:
	create_tween().tween_property(self, "current_shake", 0.0, duration).from(1.0)
