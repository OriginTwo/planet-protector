class_name HitboxComponent
extends Area2D

signal hit(hurtbox: HurtboxComponent)

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent) -> void:
	hit.emit(hurtbox)
	hurtbox.hurt.emit(self)
