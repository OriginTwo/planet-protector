extends Node2D

const SPEED: float = 80

@onready var hitbox: HitboxComponent = $HitboxComponent

var direction: Vector2

func _ready() -> void:
	hitbox.hit.connect(_on_hitbox_hit)

func _process(delta: float) -> void:
	global_position += direction*SPEED*delta

func _draw() -> void:
	draw_circle(Vector2.ZERO, 2, Color.ORANGE)

func _on_hitbox_hit(_hurtbox: HurtboxComponent) -> void:
	queue_free()
