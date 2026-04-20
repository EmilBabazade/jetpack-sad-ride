extends Node2D

var speed := 250.0

func _ready() -> void:
	LevelManager.level_up.connect(on_level_up)

func on_level_up(_level: int) -> void:
	speed += speed * 0.1
