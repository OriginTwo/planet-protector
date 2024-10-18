extends Node2D

@onready var land: ColorRect = $Visual/Land
@onready var cloud: ColorRect = $Visual/Cloud
@onready var health: Health = $Health
@onready var shake: Shake = $Shake
@onready var hurtbox: Hurtbox = $Hurtbox

var shader_time: float

func _ready() -> void:
	randomize_visual()
	
	health.changed.connect(func(new_value: int) -> void: Global.planet_health_changed.emit(new_value))
	health.depleted.connect(_on_health_depleted)
	hurtbox.hurt.connect(_on_hurt)
	
	health.set_deferred("health", health.max_health)

func _process(delta: float) -> void:
	shader_time += delta
	land.material.set_shader_parameter("time", shader_time)
	cloud.material.set_shader_parameter("time", shader_time)

func _on_health_depleted() -> void:
	$DestroyedSound.play()
	$DestroyedParticle.emitting = true
	hurtbox.set_enabled(false)
	Engine.set_time_scale(0.2)
	await $DestroyedSound.finished
	land.hide()
	cloud.hide()
	Global.game_over.emit()
	Engine.set_time_scale(1)

func _on_hurt(_hitbox: Hitbox) -> void:
	HitstopManager.shake_camera(0.6)
	shake.shake()
	$HurtSound.play()
	land.material.set_shader_parameter("flash", true)
	cloud.material.set_shader_parameter("flash", true)
	await shake.finished
	land.material.set_shader_parameter("flash", false)
	cloud.material.set_shader_parameter("flash", false)

func randomize_visual() -> void:
	var sd := randf_range(0, 10)
	
	land.size = Vector2(Global.PLANET_RADIUS*2, Global.PLANET_RADIUS*2)
	land.position = Vector2(-Global.PLANET_RADIUS, -Global.PLANET_RADIUS)
	land.material.set_shader_parameter("pixels", Global.PLANET_RADIUS*2)
	land.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	land.material.set_shader_parameter("time_speed", randf_range(0.15, 0.2))
	land.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	land.material.set_shader_parameter("octaves", 20)
	land.material.set_shader_parameter("seed", sd)
	
	cloud.size = Vector2((Global.PLANET_RADIUS + 2)*2, (Global.PLANET_RADIUS + 2)*2)
	cloud.position = Vector2(-Global.PLANET_RADIUS - 2, -Global.PLANET_RADIUS - 2)
	cloud.material.set_shader_parameter("pixels", (Global.PLANET_RADIUS + 2)*2)
	cloud.material.set_shader_parameter("cloud_cover", 0.5)
	cloud.material.set_shader_parameter("light_origin", Vector2(0.5, 0.5))
	cloud.material.set_shader_parameter("time_speed", randf_range(0.15, 0.2))
	cloud.material.set_shader_parameter("size", randf_range(4.5, 5.4))
	cloud.material.set_shader_parameter("octaves", 20)
	cloud.material.set_shader_parameter("seed", sd)
	
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
