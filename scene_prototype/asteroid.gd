extends Node2D

@onready var visual: ColorRect = $Visual
@onready var health: HealthComponent = $HealthComponent
@onready var hitbox: HitboxComponent = $HitboxComponent

func _ready() -> void:
	randomize_visual()
	
	health.depleted.connect(_on_health_depleted)
	hitbox.hit.connect(_on_hitbox_hit)

func _process(delta: float) -> void:
	global_position += (-global_position).normalized()*15*delta
	global_rotation += PI/4*delta

func _on_health_depleted() -> void:
	queue_free()

func _on_hitbox_hit(_hurtbox: HurtboxComponent) -> void:
	queue_free()

func randomize_visual() -> void:
	var seed := randf_range(0, 10)
	
	visual.size = Vector2(32, 32)
	visual.position = Vector2(-16, -16)
	visual.material.set_shader_parameter("seed", seed)
	visual.material.set_shader_parameter("pixels", 32)
	visual.material.set_shader_parameter("light_origin", Vector2(0, 0))
	visual.material.set_shader_parameter("size", randf_range(1.5, 1.7))
	
	# randomize color
	var seed_colors := _generate_new_colorscheme(randi()%2 + 3, randf_range(0.3, 0.6), 0.3)
	var colors: Array[Color]
	for i in 3:
		var new_col := seed_colors[0].darkened(i/3.0)
		colors.append(new_col.lightened((1.0 - (i/3.0))*0.2))
	visual.material.set_shader_parameter("colors", colors.slice(0, 6))

# taken from: https://github.com/Deep-Fold/PixelPlanets/blob/8ec6ee305527946ae415f4e7875587c974add273/Planets/Planet.gd#L52
func _generate_new_colorscheme(color_amount: int, hue_diff: float, saturation: float) -> PackedColorArray:
	var a := Vector3(0.5, 0.5, 0.5)
	var b := Vector3(0.5, 0.5, 0.5)*saturation
	var c := Vector3(randf_range(0.5, 1.5), randf_range(0.5, 1.5), randf_range(0.5, 1.5))*hue_diff
	var d := Vector3(randf_range(0.0, 1.0), randf_range(0.0, 1.0), randf_range(0.0, 1.0))*randf_range(1.0, 3.0)
	
	var colors: PackedColorArray
	var n = max(1, float(color_amount - 1))
	for i in range(0, color_amount, 1):
		var v: Vector3
		v.x = (a.x + b.x*cos(TAU*(c.x*float(i/n) + d.x)))
		v.y = (a.y + b.y*cos(TAU*(c.y*float(i/n) + d.y)))
		v.z = (a.z + b.z*cos(TAU*(c.z*float(i/n) + d.z)))
		colors.append(Color(v.x, v.y, v.z))
	
	return colors
