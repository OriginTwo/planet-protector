class_name HealthComponent
extends Node

signal depleted()

@export var hurtbox: HurtboxComponent
@export var max_health: int = 1

var health := max_health :
	set(value):
		health = clamp(value, 0, max_health)
		if health == 0:
			depleted.emit()

func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt)

func _on_hurtbox_hurt(hitbox: HitboxComponent) -> void:
	health -= hitbox.damage
