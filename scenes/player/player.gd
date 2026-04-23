extends CharacterBody2D
class_name Player

var gravity := 20.0
var max_jump := 500.0
var init_jump := 300.0
var jump := 300.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bullet_particles: GPUParticles2D = $BulletParticles
@export var camera: Camera
@onready var ray_cast: RayCast2D = $GroundDetector
var last_dist_ground := 0.0

@onready var enemy_detector: RayCast2D = $EnemyDetector

@onready var gt: GetHit = $GetHit
var died := false

func _physics_process(delta: float) -> void:
	if died:
		return
	
	# jump
	var is_jumping := Input.is_action_pressed("jump")
	if is_jumping:
		velocity.y = -jump
		jump = move_toward(jump, max_jump, delta * 300)
	else:
		jump = init_jump
	bullet_particles.emitting = is_jumping
	
	# use distance to ground to shake screen when player falls
	if Input.is_action_just_released("jump"):
		var point := ray_cast.get_collision_point()
		last_dist_ground = global_position.y - point.y
	
	# gravity
	velocity.y += gravity
	
	# walking
	if is_on_floor():
		animation_player.play("run")
	else:
		animation_player.play("RESET")
	
	move_and_slide()
	
	# shoot enemy
	if Input.is_action_pressed("jump") and enemy_detector.is_colliding():
		var crab: Node2D = enemy_detector.get_collider()
		var gt: GetHit = crab.get_node("GetHit")
		await gt.get_hit()


func _on_player_fall_detector_body_entered(body: Node2D) -> void:
	print(last_dist_ground)
	camera.shake_down(last_dist_ground / 100)

func die() -> void:
	died = true
	get_tree().paused = true
	await gt.get_hit(2.0)
	get_tree().paused = false
