class_name Hitbox
extends Area2D

signal hit()

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	hit.emit()
	hurtbox.hurt.emit(self)
