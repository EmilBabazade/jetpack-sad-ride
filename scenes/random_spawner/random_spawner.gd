extends Node2D
class_name RandomSpawner

@export var obstacle_scenes: Array[PackedScene]
@onready var timer: Timer = $Timer
@export var spawn: Marker2D

func _ready() -> void:
	LevelManager.level_up.connect(on_level_up)

func _on_timer_timeout() -> void:
	# spawn random so half the time i guess
	if randi() % 2 == 0:
		return
	var obstacle_scene: PackedScene = obstacle_scenes.pick_random()
	var obstacle := obstacle_scene.instantiate() as Node2D
	obstacle.global_position = spawn.global_position
	add_child(obstacle)

func on_level_up(level: int) -> void:
	if timer.wait_time > 0.5:
		timer.wait_time = timer.wait_time - timer.wait_time * 0.1
