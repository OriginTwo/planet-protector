extends Control

@onready var background: Node2D = $Background
@onready var back_button: Button = %BackButton

func _ready() -> void:
	background.position = get_viewport_rect().size/2
	
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
