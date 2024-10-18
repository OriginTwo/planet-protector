class_name Shake
extends Node

signal finished()

@export var node: Node2D
@export var max_offset: float = 2.0
@export var decay: float = 2

var original_position: Vector2
var current_strength: float
var just_shake: bool

func _ready() -> void:
	set_deferred("original_position", node.position)

func _process(delta: float) -> void:
	if current_strength > 0:
		node.position = original_position + Vector2(
			randf_range(-max_offset, max_offset),
			randf_range(-max_offset, max_offset)
		)*current_strength
	current_strength = max(current_strength - decay*delta, 0)
	if just_shake && current_strength == 0:
		just_shake = false
		finished.emit()

func shake(strength: float = 1) -> void:
	current_strength = clamp(current_strength + strength, 0, 1)
	just_shake = true
