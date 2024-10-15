extends Node2D

@onready var visual: ColorRect = $Visual
@onready var health: Health = $Health
@onready var hitbox: Hitbox = $Hitbox

var linear_speed: float
var angular_speed: float
var score_amount: int

func _ready() -> void:
	health.depleted.connect(_on_destroyed)
	hitbox.hit.connect(_on_hitbox_hit)

func _process(delta: float) -> void:
	global_position += (-global_position).normalized()*linear_speed*delta
	global_rotation += angular_speed*delta

func _on_destroyed() -> void:
	queue_free()
	Global.score += score_amount

func _on_hitbox_hit() -> void:
	queue_free()

func setup(radius: float, mask: Texture2D) -> void:
	$Hurtbox/CollisionShape2D.shape.radius = radius
	$Hitbox/CollisionShape2D.shape.radius = radius
	
	visual.size = Vector2(radius*2, radius*2)
	visual.position = Vector2(-radius, -radius)
	visual.material.set_shader_parameter("mask", mask)
	visual.material.set_shader_parameter("pixels", radius*2)
	visual.material.set_shader_parameter("light_origin", Vector2(0, 0))
	visual.material.set_shader_parameter("size", randf_range(1.5, 1.7))
	visual.material.set_shader_parameter("octaves", 20)
	visual.material.set_shader_parameter("seed", randf_range(0, 10))
	
	# randomize color
	var seed_colors := Palette.generate(randi()%2 + 3, randf_range(0.3, 0.6), 0.3)
	var colors: Array[Color]
	for i in 3:
		var new_col := seed_colors[0].darkened(i/3.0)
		colors.append(new_col.lightened((1.0 - (i/3.0))*0.2))
	visual.material.set_shader_parameter("colors", colors)
