extends Node2D
class_name ObstacleSpawner

@export var saw_scene: PackedScene
@export var spawn_points: Array[Marker2D]
@export var min_spawn_count := 1
@export var max_spawn_count := 4

func _on_timer_timeout() -> void:
	var spawns_clone := spawn_points.duplicate()
	var max := randi_range(min_spawn_count, max_spawn_count)
	for i in range(min_spawn_count, max + 1):
		var saw := saw_scene.instantiate() as Saw
		var spawn: Marker2D = spawns_clone.pick_random()
		saw.global_position = spawn.global_position
		spawns_clone.erase(spawn)
		add_child(saw)
