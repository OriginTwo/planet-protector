extends Node2D

const PROJECTILE_SCENE := preload("res://scene/cannon/projectile.tscn")
const SPEED: float = PI/2

@onready var projectiles := get_tree().get_first_node_in_group("projectiles")
@onready var muzzle: Marker2D = $Muzzle

var angle: float = PI/2

func _process(delta: float) -> void:
	angle += Input.get_axis("ui_right", "ui_left")*SPEED*delta
	
	global_position = Vector2.from_angle(-angle)*(Global.PLANET_RADIUS + 5)
	global_rotation = -angle
	
	if Input.is_action_just_pressed("ui_accept"):
		var projectile := PROJECTILE_SCENE.instantiate()
		projectiles.add_child(projectile)
		projectile.global_position = muzzle.global_position
		projectile.direction = Vector2.from_angle(-angle)
