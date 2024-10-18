extends Node2D

const STAR_SCENE := preload("res://scene/background/star.tscn")
const STAR_TEXTURES := [
	preload("res://asset/background/star_1.png"),
	preload("res://asset/background/star_2.png"),
	preload("res://asset/background/star_3.png"),
	preload("res://asset/background/star_4.png"),
	preload("res://asset/background/star_5.png"),
	preload("res://asset/background/star_6.png"),
]

@export var max_star: int = 20
@export var star_spawn_padding: float = 4.0

@onready var space: ColorRect = $Space

var shader_time: float
var star_palette: Array[Color]

func _ready() -> void:
	setup_space()
	
	var seed_colors := Palette.generate(16, randf_range(0.9, 1.0), randf_range(0.9, 1.0))
	for i in seed_colors.size():
		var new_col := seed_colors[i].lightened(0.7)
		star_palette.append(new_col*0.7)
	for i in max_star:
		spawn_star(true)

func _process(delta: float) -> void:
	shader_time += delta
	space.material.set_shader_parameter("time", shader_time)

func setup_space() -> void:
	space.size = get_viewport_rect().size + Vector2(16, 16) # padding for camera shake
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

func spawn_star(is_initial: bool = false) -> void:
	var viewport_size := get_viewport_rect().size
	var star := STAR_SCENE.instantiate()
	call_deferred("add_child", star)
	star.global_position = Vector2(
		randf_range(star_spawn_padding, viewport_size.x - star_spawn_padding),
		randf_range(star_spawn_padding, viewport_size.y - star_spawn_padding)
	) - viewport_size/2
	star.texture = STAR_TEXTURES.pick_random()
	star.modulate = star_palette[randi()%star_palette.size()]
	star.modulate.a = 1.0 if is_initial else 0.0
	if is_initial:
		star.lifetime = randf_range(0.0, 10.0)
	star.faded.connect(spawn_star)
