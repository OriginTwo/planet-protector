extends Node2D

const TWEEN_TIME: float = 10.0

var lifetime: float

func _ready() -> void:
	lifetime = randf_range(5.0, 20.0)
	
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, TWEEN_TIME)
	tween.tween_interval(lifetime)
	tween.tween_property(self, "modulate:a", 0.0, TWEEN_TIME)
	tween.tween_callback(queue_free)
