extends Node2D

@onready var land: ColorRect = $Visual/Land
@onready var cloud: ColorRect = $Visual/Cloud
@onready var health: Health = $Health

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
	
	land.size = Vector2(Global.PLANET_RADIUS*2, Global.PLANET_RADIUS*2)
	land.position = Vector2(-Global.PLANET_RADIUS, -Global.PLANET_RADIUS)
	land.material.set_shader_parameter("pixels", Global.PLANET_RADIUS*2)
	land.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	land.material.set_shader_parameter("time_speed", randf_range(0.15, 0.2))
	land.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	land.material.set_shader_parameter("octaves", 20)
	land.material.set_shader_parameter("seed", seed)
	
	cloud.size = Vector2((Global.PLANET_RADIUS + 2)*2, (Global.PLANET_RADIUS + 2)*2)
	cloud.position = Vector2(-Global.PLANET_RADIUS - 2, -Global.PLANET_RADIUS - 2)
	cloud.material.set_shader_parameter("pixels", (Global.PLANET_RADIUS + 2)*2)
	cloud.material.set_shader_parameter("cloud_cover", 0.5)
	cloud.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	cloud.material.set_shader_parameter("time_speed", randf_range(0.15, 0.2))
	cloud.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	cloud.material.set_shader_parameter("octaves", 20)
	cloud.material.set_shader_parameter("seed", seed)
	
	# randomize color
	var seed_colors := Palette.generate(randi()%2 + 3, randf_range(0.7, 1.0), randf_range(0.45, 0.55))
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
