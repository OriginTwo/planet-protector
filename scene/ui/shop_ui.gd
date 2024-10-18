extends PanelContainer

@onready var score_label: Label = %ScoreLabel
@onready var money_label: Label = %MoneyLabel
@onready var planet_hit_point_label: Label = %PlanetHitPointLabel

func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)
	Global.money_changed.connect(_on_money_changed)
	Global.planet_health_changed.connect(_on_planet_health_changed)

func _on_score_changed(new_value: int) -> void:
	score_label.text = "  Score: %d" % [new_value]

func _on_money_changed(new_value: int) -> void:
	money_label.text = "  Money: %d" % [new_value]

func _on_planet_health_changed(new_value: int) -> void:
	planet_hit_point_label.text = "  Planet Hit Point: %d" % [new_value]
