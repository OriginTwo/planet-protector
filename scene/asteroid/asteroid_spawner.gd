extends Node

const ASTEROID_SCENE := preload("res://scene/asteroid/asteroid.tscn")
const ASTEROID_SIZE_DATAS := [
	preload("res://scene/asteroid/big_asteroid_data.tres"),
	preload("res://scene/asteroid/medium_asteroid_data.tres"),
	preload("res://scene/asteroid/small_asteroid_data.tres"),
]

@onready var spawn_timer: Timer = $SpawnTimer
@onready var increase_health_timer: Timer = $IncreaseHealthTimer
@onready var reduce_spawn_time_timer: Timer = $ReduceSpawnTimeTimer

var health_increase: int = 0

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn)
	increase_health_timer.timeout.connect(_on_increase_health)
	reduce_spawn_time_timer.timeout.connect(_on_reduce_spawn_time)

func _on_spawn() -> void:
	var asteroid := ASTEROID_SCENE.instantiate()
	add_child(asteroid)
	var angle := randf_range(0, TAU)
	var size_data: AsteroidSizeData = ASTEROID_SIZE_DATAS.pick_random()
	asteroid.global_position = Vector2.from_angle(angle)*250
	asteroid.data = size_data

func _on_increase_health() -> void:
	health_increase += 1

func _on_reduce_spawn_time() -> void:
	spawn_timer.wait_time -= 0.2
	if spawn_timer.wait_time <= 1:
		reduce_spawn_time_timer.stop()
