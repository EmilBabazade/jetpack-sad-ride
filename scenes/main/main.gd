extends Node2D

@onready var player: Player = $Player
@onready var time_label: Label = $CanvasLayer/Time
@onready var level_timer: Timer = $LevelTimer
@onready var parallax: Parallax2D = $background/Parallax2D

func _ready() -> void:
	HealthManager.death.connect(on_death)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	time_label.text = str(level_timer.time_left)

func on_death() -> void:
	player.queue_free.call_deferred()

func _on_level_timer_timeout() -> void:
	LevelManager.next_level()
	parallax.autoscroll.x += parallax.autoscroll.x * 0.1
