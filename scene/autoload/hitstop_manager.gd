extends Node2D

func hitstop(duration: float = 0.05) -> void:
	get_tree().paused = true
	await get_tree().create_timer(duration, true, false, true).timeout
	get_tree().paused = false

func shake_camera(strength: float = 1) -> void:
	get_tree().get_first_node_in_group("shaky_camera").shake(strength)
