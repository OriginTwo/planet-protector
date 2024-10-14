class_name Health
extends Node

signal depleted()

@export var hurtbox: Hurtbox
@export var max_health: int = 1

@onready var health := max_health :
	set(value):
		health = clamp(value, 0, max_health)
		if health == 0:
			depleted.emit()

func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt)

func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	health -= hitbox.damage
