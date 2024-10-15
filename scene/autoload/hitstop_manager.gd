extends Node2D

func hitstop() -> void:
	get_tree().paused = true
	await get_tree().create_timer(0.05, true, false, true).timeout
	get_tree().paused = false

func shake_camera() -> void:
	get_tree().get_first_node_in_group("shaky_camera").shake()
