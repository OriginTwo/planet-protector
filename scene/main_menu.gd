extends Control

const GAME_SCENE := preload("res://scene/game.tscn")

@onready var background: Node2D = $Background
@onready var high_score_label: Label = %HighScoreLabel
@onready var play_button: Button = %PlayButton
@onready var credit_button: Button = %CreditButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	background.position = get_viewport_rect().size/2
	
	high_score_label.text = "High Score: %d" % [Global.high_score]
	play_button.pressed.connect(_on_play_button_pressed)
	credit_button.pressed.connect(_on_credit_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME_SCENE)

func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/credit.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
