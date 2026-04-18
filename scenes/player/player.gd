extends CharacterBody2D
class_name Player

var gravity := 20.0
var max_jump := 500.0
var init_jump := 300.0
var jump := 300.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bullet_particles: GPUParticles2D = $BulletParticles

@export var spark_particles: GPUParticles2D

func _ready() -> void:
	bullet_particles.sub_emitter = spark_particles.get_path()

func _physics_process(delta: float) -> void:
	# jump
	var is_jumping := Input.is_action_pressed("jump")
	if is_jumping:
		velocity.y = -jump
		jump = move_toward(jump, max_jump, delta * 300)
	else:
		jump = init_jump
	print(jump)
	bullet_particles.emitting = is_jumping
	
	# gravity
	velocity.y += gravity
	
	# walking
	if is_on_floor():
		animation_player.play("run")
	else:
		animation_player.play("RESET")
	
	move_and_slide()
