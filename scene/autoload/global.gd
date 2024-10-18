extends Node

signal score_changed(new_value: int)
signal money_changed(new_value: int)
signal planet_health_changed(new_value: int)
signal upgrade_bought(upgrade: UpgradeData)

const PLANET_RADIUS: float = 35
const FORCE_FIELD_RADIUS: float = PLANET_RADIUS + 5
