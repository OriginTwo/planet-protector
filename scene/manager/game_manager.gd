class_name GameManager
extends Node

var score: int :
	set(value):
		score = value
		Global.score_changed.emit(score)
var money: int :
	set(value):
		money = value
		Global.money_changed.emit(money)

var income_multiplier: float = 1

func increase_score(amount: int) -> void:
	score += amount

func increase_money(amount: int) -> void:
	money += int(roundf(float(amount)*income_multiplier))

func _ready() -> void:
	add_to_group("game_manager")
	
	Global.upgrade_bought.connect(_on_upgrade_bought)
	
	set_deferred("score", 0)
	set_deferred("money", 0)

func _on_upgrade_bought(upgrade: UpgradeData) -> void:
	money -= upgrade.price
	match upgrade.name:
		"Planet Force Field":
			print("spawn force_field")
		"Cannon Acceleration":
			print("increase cannon_accel")
		"Cannon Brake":
			print("increase cannon_brake")
		"Cannon Rocket":
			print("increase cannon_damage")
		"Cannon Fire Rate":
			print("increase cannon_fire_rate")
		"Increase Income":
			income_multiplier += 0.45
