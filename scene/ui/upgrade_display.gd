extends PanelContainer

@export var upgrade_data: UpgradeData

@onready var upgrade_button: Button = %UpgradeButton
@onready var price_label: Label = %PriceLabel
@onready var limit_label: Label = %LimitLabel
@onready var description_label: Label = %DescriptionLabel

var amount_bought: int = 0

func _ready() -> void:
	Global.money_changed.connect(_on_money_changed)
	upgrade_button.pressed.connect(_on_upgrade_button_pressed)
	
	upgrade_button.text = upgrade_data.name
	price_label.text = "%d" % [upgrade_data.price]
	update_limit_label()
	description_label.tooltip_text = upgrade_data.description

func _on_money_changed(new_value: int) -> void:
	upgrade_button.disabled = new_value < upgrade_data.price || should_disable_button()

func _on_upgrade_button_pressed() -> void:
	Global.upgrade_bought.emit(upgrade_data)
	upgrade_data.price = int(float(upgrade_data.price)*upgrade_data.price_multiplier)
	amount_bought += 1
	price_label.text = "%d" % [upgrade_data.price]
	update_limit_label()

func should_disable_button() -> bool:
	return upgrade_data.limit > 0 && amount_bought >= upgrade_data.limit

func update_limit_label() -> void:
	if upgrade_data.limit <= 0:
		limit_label.text = "-"
		return
	limit_label.text = "%d/%d" % [amount_bought, upgrade_data.limit]
