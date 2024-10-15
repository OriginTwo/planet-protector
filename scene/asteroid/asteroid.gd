extends Node2D

@onready var visual: ColorRect = $Visual
@onready var health: Health = $Health
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox
@onready var shake: Shake = $Shake
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var destroyed_sound: AudioStreamPlayer = $DestroyedSound

var linear_speed: float
var angular_speed: float
var score_amount: int

func _ready() -> void:
	health.depleted.connect(_on_destroyed)
	hurtbox.hurt.connect(_on_hurt)
	hitbox.hit.connect(_on_hit)

func _process(delta: float) -> void:
	global_position += (-global_position).normalized()*linear_speed*delta
	global_rotation += angular_speed*delta

func _on_hurt(_hitbox: Hitbox) -> void:
	shake.shake()
	hurt_sound.play()
	visual.material.set_shader_parameter("flash", true)
	await shake.finished
	visual.material.set_shader_parameter("flash", false)

func _on_destroyed() -> void:
	Global.score += score_amount
	destroyed_sound.play()
	visual.hide()
	hitbox.set_deferred("monitoring", false)
	$Hurtbox.set_deferred("monitorable", false)
	await destroyed_sound.finished
	queue_free()

func _on_hit() -> void:
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
