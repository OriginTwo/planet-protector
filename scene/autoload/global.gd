extends Node

signal game_over()

signal score_changed(new_value: int)
signal money_changed(new_value: int)
signal planet_health_changed(new_value: int)
signal upgrade_bought(upgrade: UpgradeData)

const PLANET_RADIUS: float = 35
const FORCE_FIELD_RADIUS: float = PLANET_RADIUS + 5

var score: int = 0
var high_score: int = 0

func _ready() -> void:
	load_data()

func save_data() -> void:
	var save_file := FileAccess.open_encrypted_with_pass("user://data.save", FileAccess.WRITE, "asdfqwerty")
	save_file.store_line(JSON.stringify({
		"score": score,
		"high_score": high_score,
	}))

func load_data() -> void:
	if !FileAccess.file_exists("user://data.save"):
		return
	
	var save_file := FileAccess.open_encrypted_with_pass("user://data.save", FileAccess.READ, "asdfqwerty")
	var json_string := save_file.get_line()
	var json := JSON.new()
	json.parse(json_string)
	score = json.data["score"]
	high_score = json.data["high_score"]
