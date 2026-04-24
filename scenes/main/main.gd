extends Node2D

@onready var player: Player = $Player
@onready var time_label: Label = $UI/CanvasLayer/Time
@onready var level_timer: Timer = $LevelTimer
@onready var parallax: Parallax2D = $background/Parallax2D
@onready var theme_music: AudioStreamPlayer2D = $ThemeMusic

func _ready() -> void:
	HealthManager.death.connect(on_death)
	theme_music.finished.connect(on_theme_music_finish)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	time_label.text = str(level_timer.time_left)

func on_death() -> void:
	await player.die()

func _on_level_timer_timeout() -> void:
	LevelManager.next_level()
	parallax.autoscroll.x += parallax.autoscroll.x * 0.1
	theme_music.pitch_scale += 0.01

func on_theme_music_finish() -> void:
	theme_music.play()
