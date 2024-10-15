extends Node2D

const PROJECTILE_SCENE := preload("res://scene/cannon/projectile.tscn")
const MAX_SPEED: float = PI/2
const ACCELERATION: float = MAX_SPEED*2
const FRICTION: float = MAX_SPEED

@onready var projectiles := get_tree().get_first_node_in_group("projectiles")
@onready var muzzle: Marker2D = $Muzzle
@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer

var speed: float = 0
var angle: float = PI/2

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		speed = move_toward(speed, MAX_SPEED, ACCELERATION*delta)
	elif Input.is_action_pressed("ui_right"):
		speed = move_toward(speed, -MAX_SPEED, ACCELERATION*delta)
	else:
		speed = move_toward(speed, 0, FRICTION*delta)
	
	angle += speed*delta
	
	global_position = Vector2.from_angle(-angle)*(Global.PLANET_RADIUS + 5)
	global_rotation = -angle
	
	if Input.is_action_just_pressed("ui_accept") && shoot_cooldown_timer.is_stopped():
		var projectile := PROJECTILE_SCENE.instantiate()
		projectiles.add_child(projectile)
		projectile.global_position = muzzle.global_position
		projectile.direction = Vector2.from_angle(-angle)
		shoot_cooldown_timer.start()
