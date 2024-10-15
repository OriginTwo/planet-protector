extends Node2D

@onready var space: ColorRect = $Space

var shader_time: float

func _ready() -> void:
	space.size = get_viewport_rect().size
	space.position = -space.size/2
	space.material.set_shader_parameter("time_scale", randf_range(0.015, 0.025))
	space.material.set_shader_parameter("stripe_angle", randf_range(-PI/3, PI/3))
	space.material.set_shader_parameter("stripe_impact", randf_range(0.06, 0.09))
	space.material.set_shader_parameter("stripe_frequency", randf_range(35.0, 55.0))
	
	# randomize color
	var seed_colors := Palette.generate(randi()%2 + 3, randf_range(0.7, 0.9), 0.2)
	var colors : Array[Color]
	for i in 4:
		var new_col := seed_colors[0].darkened(i/3.0)
		colors.append(new_col*0.4)
	space.material.set_shader_parameter("colors", colors)

func _process(delta: float) -> void:
	shader_time += delta
	space.material.set_shader_parameter("time", shader_time)
