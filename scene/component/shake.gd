class_name Shake
extends Node

signal finished()

@export var node: Node2D
@export var shake_amount: float = 2.0
@export var shake_duration: float = 0.4

var original_position: Vector2
var current_shake: float

func shake() -> void:
	current_shake = shake_amount
	var tween := create_tween()
	tween.tween_property(self, "current_shake", 0.0, shake_duration).from_current()
	tween.tween_callback(finished.emit)

func _ready() -> void:
	await get_tree().process_frame
	original_position = node.position

func _process(_delta: float) -> void:
	node.position = original_position + Vector2(
		randf_range(-current_shake, current_shake),
		randf_range(-current_shake, current_shake)
	)
