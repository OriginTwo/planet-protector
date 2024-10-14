extends Node

const ASTEROID_SCENE := preload("res://scene_prototype/asteroid.tscn")

@onready var asteroid_spawn_timer: Timer = $AsteroidSpawnTimer

func _ready() -> void:
	asteroid_spawn_timer.timeout.connect(_on_spawn_asteroid)

func _on_spawn_asteroid() -> void:
	var asteroid := ASTEROID_SCENE.instantiate()
	var angle := randf_range(0, 2*PI)
	asteroid.global_position = Vector2.from_angle(angle)*200
	add_child(asteroid)
