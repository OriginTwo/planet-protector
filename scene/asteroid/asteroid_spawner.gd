extends Node

const ASTEROID_SCENE := preload("res://scene/asteroid/asteroid.tscn")
const ASTEROID_SIZE_DATAS := [
	preload("res://scene/asteroid/big_asteroid_data.tres"),
	preload("res://scene/asteroid/medium_asteroid_data.tres"),
	preload("res://scene/asteroid/small_asteroid_data.tres"),
]

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn)

func _on_spawn() -> void:
	var asteroid := ASTEROID_SCENE.instantiate()
	add_child(asteroid)
	var angle := randf_range(0, TAU)
	var size_data: AsteroidSizeData = ASTEROID_SIZE_DATAS.pick_random()
	asteroid.global_position = Vector2.from_angle(angle)*250
	asteroid.health.max_health = size_data.health
	asteroid.linear_speed = size_data.linear_speed
	asteroid.angular_speed = size_data.angular_speed
	asteroid.score_amount = size_data.score_amount
	asteroid.setup(size_data.radius, size_data.mask_textures.pick_random())
