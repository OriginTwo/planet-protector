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

func _ready() -> void:
	add_to_group("game_manager")
	
	Global.upgrade_bought.connect(_on_upgrade_bought)
	
	set_deferred("score", 0)
	set_deferred("money", 0)

func _on_upgrade_bought(upgrade: UpgradeData) -> void:
	money -= upgrade.price
	print("upgrade_bought: ", upgrade.name)
