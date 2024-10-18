class_name GameManager
extends Node

const FORCE_FIELD_SCENE := preload("res://scene/upgrade/force_field.tscn")

var score: int :
	set(value):
		score = value
		Global.score_changed.emit(score)
var money: int :
	set(value):
		money = value
		Global.money_changed.emit(money)

var income_multiplier: float = 1

var force_field_count: int = 0

func increase_score(amount: int) -> void:
	score += amount

func increase_money(amount: int) -> void:
	money += int(roundf(float(amount)*income_multiplier))

func _ready() -> void:
	add_to_group("game_manager")
	
	Global.upgrade_bought.connect(_on_upgrade_bought)
	
	set_deferred("score", 0)
	set_deferred("money", 100000)

func _on_upgrade_bought(upgrade: UpgradeData) -> void:
	var cannon := get_tree().get_first_node_in_group("cannon")
	
	money -= upgrade.price
	match upgrade.name:
		"Planet Force Field":
			if force_field_count == 0:
				spawn_force_field()
			force_field_count += 1
		"Cannon Speed":
			cannon.max_speed_multiplier += 0.05
		"Cannon Acceleration":
			cannon.acceleration_multiplier += 0.5
		"Cannon Brake":
			cannon.friction_multiplier += 0.5
		"Cannon Rocket":
			cannon.damage_multiplier += 2
		"Cannon Fire Rate":
			cannon.shoot_cooldown_timer.wait_time -= 0.03
		"Increase Income":
			income_multiplier += 0.45

func _on_force_field_destroyed() -> void:
	force_field_count -= 1
	if force_field_count > 0:
		spawn_force_field()

func spawn_force_field() -> void:
	var force_field := FORCE_FIELD_SCENE.instantiate()
	get_parent().add_child(force_field)
	force_field.tree_exited.connect(_on_force_field_destroyed)
