extends PanelContainer

@onready var score_label: Label = %ScoreLabel
@onready var money_label: Label = %MoneyLabel
@onready var planet_hit_point_label: Label = %PlanetHitPointLabel

@onready var force_field_upgrade_button: Button = %ForceFieldUpgradeButton
@onready var force_field_price_label: Label = %ForceFieldPriceLabel
@onready var force_field_limit_label: Label = %ForceFieldLimitLabel

@onready var cannon_accel_upgrade_button: Button = %CannonAccelUpgradeButton
@onready var cannon_accel_price_label: Label = %CannonAccelPriceLabel
@onready var cannon_accel_limit_label: Label = %CannonAccelLimitLabel

@onready var cannon_brake_upgrade_button: Button = %CannonBrakeUpgradeButton
@onready var cannon_brake_price_label: Label = %CannonBrakePriceLabel
@onready var cannon_brake_limit_label: Label = %CannonBrakeLimitLabel

@onready var cannon_rocket_upgrade_button: Button = %CannonRocketUpgradeButton
@onready var cannon_rocket_price_label: Label = %CannonRocketPriceLabel
@onready var cannon_rocket_limit_label: Label = %CannonRocketLimitLabel

@onready var cannon_fire_rate_upgrade_button: Button = %CannonFireRateUpgradeButton
@onready var cannon_fire_rate_price_label: Label = %CannonFireRatePriceLabel
@onready var cannon_fire_rate_limit_label: Label = %CannonFireRateLimitLabel

@onready var increase_income_upgrade_button: Button = %IncreaseIncomeUpgradeButton
@onready var increase_income_price_label: Label = %IncreaseIncomePriceLabel
@onready var increase_income_limit_label: Label = %IncreaseIncomeLimitLabel

func _ready() -> void:
	pass # Replace with function body.

#TODO: upgrade data resource
#TODO: save upgrade panel to separate scene and use upgrade data resource to differentiate
#		when the upgrade button is pressed, emit signal with upgrade data as parameter
#		then game manager respond to signal
#TODO: maybe the game manager should also keep track of score
#		so when the asteroids are destroyed, they emit score_increase signal which the
#		game manager will respond to

"""
on_score_changed:
	update_score_label()

on_money_changed:
	update_money_label()
	for button in upgrade_buttons:
		if current_money >= price:
			button.enable()

on_planet_hit_point_changed:
	update_planet_hit_point_label()


@onready var force_field_upgrade_button: Button = %ForceFieldUpgradeButton
@onready var force_field_price_label: Label = %ForceFieldPriceLabel
@onready var force_field_limit_label: Label = %ForceFieldLimitLabel

@onready var cannon_accel_upgrade_button: Button = %CannonAccelUpgradeButton
@onready var cannon_accel_price_label: Label = %CannonAccelPriceLabel
@onready var cannon_accel_limit_label: Label = %CannonAccelLimitLabel

@onready var cannon_brake_upgrade_button: Button = %CannonBrakeUpgradeButton
@onready var cannon_brake_price_label: Label = %CannonBrakePriceLabel
@onready var cannon_brake_limit_label: Label = %CannonBrakeLimitLabel

@onready var cannon_rocket_upgrade_button: Button = %CannonRocketUpgradeButton
@onready var cannon_rocket_price_label: Label = %CannonRocketPriceLabel
@onready var cannon_rocket_limit_label: Label = %CannonRocketLimitLabel

@onready var cannon_fire_rate_upgrade_button: Button = %CannonFireRateUpgradeButton
@onready var cannon_fire_rate_price_label: Label = %CannonFireRatePriceLabel
@onready var cannon_fire_rate_limit_label: Label = %CannonFireRateLimitLabel

@onready var increase_income_upgrade_button: Button = %IncreaseIncomeUpgradeButton
@onready var increase_income_price_label: Label = %IncreaseIncomePriceLabel
@onready var increase_income_limit_label: Label = %IncreaseIncomeLimitLabel

"""
