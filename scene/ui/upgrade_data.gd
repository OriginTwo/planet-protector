class_name UpgradeData
extends Resource

@export var name: String
@export_multiline var description: String
@export_range(0, 9) var limit: int
@export var price: int
@export var price_multiplier: float = 1.5
