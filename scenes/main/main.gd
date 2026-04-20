extends Node2D

@onready var player: Player = $Player

func _ready() -> void:
	HealthManager.death.connect(on_death)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func on_death() -> void:
	player.queue_free.call_deferred()
