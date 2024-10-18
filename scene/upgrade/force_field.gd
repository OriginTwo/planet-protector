extends Node2D

@onready var visual: ColorRect = $Visual/ColorRect
@onready var health: Health = $Health
@onready var shake: Shake = $Shake
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var spawn_sound: AudioStreamPlayer = $SpawnSound
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var destroyed_sound: AudioStreamPlayer = $DestroyedSound

var shader_time: float

func _ready() -> void:
	health.depleted.connect(_on_destroyed)
	hurtbox.hurt.connect(_on_hurt)
	
	$Hurtbox/CollisionShape2D.shape.radius = Global.FORCE_FIELD_RADIUS
	visual.size = Vector2(Global.FORCE_FIELD_RADIUS*2, Global.FORCE_FIELD_RADIUS*2)
	visual.position = -visual.size/2
	
	spawn_sound.play()

func _process(delta: float) -> void:
	shader_time += delta
	visual.material.set_shader_parameter("time", shader_time)

func _on_destroyed() -> void:
	HitstopManager.hitstop()
	HitstopManager.shake_camera()
	destroyed_sound.play()
	visual.hide()
	hurtbox.set_enabled(false)
	await destroyed_sound.finished
	queue_free()

func _on_hurt(_hitbox: Hitbox) -> void:
	shake.shake()
	hurt_sound.play()
	visual.material.set_shader_parameter("flash", true)
	await shake.finished
	visual.material.set_shader_parameter("flash", false)
