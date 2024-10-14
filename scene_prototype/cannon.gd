extends Node2D

const PLANET_RADIUS: float = 35
const SPEED: float = PI/2

@onready var projectile_spawner: SpawnerComponent = $ProjectileSpawnerComponent

var angle: float = PI/2

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		angle += SPEED*delta
	if Input.is_action_pressed("ui_right"):
		angle -= SPEED*delta
	
	global_position = Vector2.from_angle(-angle)*(PLANET_RADIUS + 5)
	global_rotation = -angle
	
	if Input.is_action_just_pressed("ui_accept"):
		var projectile := projectile_spawner.spawn()
		projectile.direction = Vector2.from_angle(-angle)
