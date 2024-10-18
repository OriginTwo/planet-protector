extends Node2D

const EXPLOSION_SCENE := preload("res://scene/cannon/projectile_explosion.tscn")

const SPEED: float = 200

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var hitbox: Hitbox = $Hitbox
@onready var timeout_sound: AudioStreamPlayer = $TimeoutSound

var direction: Vector2

func _ready() -> void:
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	hitbox.hit.connect(_on_hitbox_hit)

func _process(delta: float) -> void:
	global_position += direction*SPEED*delta
	global_rotation = direction.angle()

func _on_lifetime_timeout() -> void:
	var explosion := EXPLOSION_SCENE.instantiate()
	get_tree().get_first_node_in_group("effects").add_child(explosion)
	explosion.global_position = global_position
	
	$Sprite2D.hide()
	hitbox.set_enabled(false)
	timeout_sound.play()
	await timeout_sound.finished
	queue_free()

func _on_hitbox_hit() -> void:
	queue_free()
	var explosion := EXPLOSION_SCENE.instantiate()
	get_tree().get_first_node_in_group("effects").add_child(explosion)
	explosion.global_position = global_position

func set_damage_multiplier(multiplier: float) -> void:
	hitbox.damage = int(roundf(float(hitbox.damage)*multiplier))
