extends CharacterBody2D
class_name Player

var gravity := 10.0
var jump := 300.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bullet_particles: GPUParticles2D = $BulletParticles

func _physics_process(delta: float) -> void:
	# jump
	var is_jumping := Input.is_action_pressed("jump")
	if is_jumping:
		velocity.y = -jump
	bullet_particles.emitting = is_jumping
	
	# gravity
	velocity.y += gravity
	
	# walking
	if is_on_floor():
		animation_player.play("run")
	else:
		animation_player.play("RESET")
	
	move_and_slide()
