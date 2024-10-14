extends Node2D

const PLANET_RADIUS: float = 35

@onready var land: ColorRect = $Visual/Land
@onready var cloud: ColorRect = $Visual/Cloud
@onready var health: HealthComponent = $HealthComponent

var shader_time: float

func _ready() -> void:
	randomize_visual()
	
	health.depleted.connect(_on_health_depleted)

func _process(delta: float) -> void:
	shader_time += delta
	land.material.set_shader_parameter("time", shader_time)
	cloud.material.set_shader_parameter("time", shader_time)

func _on_health_depleted() -> void:
	get_tree().quit()

func randomize_visual() -> void:
	var seed := randf_range(0, 10)
	
	land.size = Vector2(PLANET_RADIUS*2, PLANET_RADIUS*2)
	land.position = Vector2(-PLANET_RADIUS, -PLANET_RADIUS)
	land.material.set_shader_parameter("seed", seed)
	land.material.set_shader_parameter("pixels", PLANET_RADIUS*2)
	land.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	land.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	
	cloud.size = Vector2((PLANET_RADIUS + 2)*2, (PLANET_RADIUS + 2)*2)
	cloud.position = Vector2(-PLANET_RADIUS - 2, -PLANET_RADIUS - 2)
	cloud.material.set_shader_parameter("seed", seed)
	cloud.material.set_shader_parameter("pixels", (PLANET_RADIUS + 2)*2)
	cloud.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	cloud.material.set_shader_parameter("cloud_cover", randf_range(0.35, 0.5))
	cloud.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	
	# randomize color
	var seed_colors := _generate_new_colorscheme(randi()%2 + 3, randf_range(0.7, 1.0), randf_range(0.45, 0.55))
	var colors: Array[Color]
	
	# land colors
	for i in 4:
		var new_col := seed_colors[0].darkened(i/4.0)
		colors.append(Color.from_hsv(new_col.h + (0.2*(i/4.0)), new_col.s, new_col.v))
	# water colors
	for i in 2:
		var new_col := seed_colors[1].darkened(i/2.0)
		colors.append(Color.from_hsv(new_col.h + (0.2*(i/2.0)), new_col.s, new_col.v))
	# cloud colors
	for i in 4:
		var new_col := seed_colors[2].lightened((1.0 - (i/4.0))*0.8)
		colors.append(Color.from_hsv(new_col.h + (0.2*(i/4.0)), new_col.s, new_col.v))
	
	land.material.set_shader_parameter("colors", colors.slice(0, 6))
	cloud.material.set_shader_parameter("colors", colors.slice(6, 10))

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
