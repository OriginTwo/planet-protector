extends Node2D

const SPEED: float = 200

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var hitbox: Hitbox = $Hitbox

var direction: Vector2

func _ready() -> void:
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	hitbox.hit.connect(_on_hitbox_hit)

func _draw() -> void:
	draw_circle(Vector2.ZERO, 2, Color.ORANGE)

func _process(delta: float) -> void:
	global_position += direction*SPEED*delta

func _on_lifetime_timeout() -> void:
	queue_free()

func _on_hitbox_hit() -> void:
	queue_free()
