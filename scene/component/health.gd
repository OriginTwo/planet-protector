class_name Health
extends Node

signal changed()
signal depleted()

@export var hurtbox: Hurtbox
@export var max_health: int = 1 :
	set(value):
		var old_value := max_health
		max_health = value
		health += (max_health - old_value)

@onready var health := max_health :
	set(value):
		health = clamp(value, 0, max_health)
		changed.emit()
		if health == 0:
			depleted.emit()

func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt)

func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	health -= hitbox.damage
