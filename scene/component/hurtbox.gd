class_name Hurtbox
extends Area2D

signal hurt(hitbox: Hitbox)

func set_enabled(value: bool) -> void:
	set_deferred("monitorable", value)
