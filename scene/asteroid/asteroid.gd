extends Node2D

@onready var game_manager: GameManager = get_tree().get_first_node_in_group("game_manager")

@onready var visual: ColorRect = $Visual/ColorRect
@onready var health: Health = $Health
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox
@onready var shake: Shake = $Shake
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var destroyed_sound: AudioStreamPlayer = $DestroyedSound

var data: AsteroidSizeData

func _ready() -> void:
	health.depleted.connect(_on_destroyed)
	hurtbox.hurt.connect(_on_hurt)
	hitbox.hit.connect(_on_hit)
	
	call_deferred("setup")

func _process(delta: float) -> void:
	global_position += (-global_position).normalized()*data.linear_speed*delta
	global_rotation += data.angular_speed*delta

func _on_hurt(_hitbox: Hitbox) -> void:
	shake.shake()
	hurt_sound.play()
	$HurtParticle.emitting = true
	visual.material.set_shader_parameter("flash", true)
	await shake.finished
	visual.material.set_shader_parameter("flash", false)

func _on_destroyed() -> void:
	HitstopManager.shake_camera()
	game_manager.increase_score(data.score_amount)
	game_manager.increase_money(data.money_amount)
	destroyed_sound.play()
	visual.hide()
	hitbox.set_enabled(false)
	hurtbox.set_enabled(false)
	await destroyed_sound.finished
	queue_free()

func _on_hit() -> void:
	queue_free()

func setup() -> void:
	health.max_health = data.health
	
	hitbox.damage = data.damage
	$Hurtbox/CollisionShape2D.shape.radius = data.radius
	$Hitbox/CollisionShape2D.shape.radius = data.radius
	
	visual.size = Vector2(data.radius*2, data.radius*2)
	visual.position = Vector2(-data.radius, -data.radius)
	visual.material.set_shader_parameter("mask", data.mask_textures.pick_random())
	visual.material.set_shader_parameter("pixels", data.radius*2)
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
