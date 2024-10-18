extends Control

const GAME_SCENE := preload("res://scene/game.tscn")

@onready var background: Node2D = $Background
@onready var score_label: Label = %ScoreLabel
@onready var high_score_label: Label = %HighScoreLabel
@onready var retry_button: Button = %RetryButton
@onready var main_menu_button: Button = %MainMenuButton

func _ready() -> void:
	background.position = get_viewport_rect().size/2
	
	score_label.text = "Score: %d" % [Global.score]
	high_score_label.text = "High Score: %d" % [Global.high_score]
	retry_button.pressed.connect(_on_retry_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	Global.save_data()

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME_SCENE)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
