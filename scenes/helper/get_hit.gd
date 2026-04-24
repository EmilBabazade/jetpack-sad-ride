extends Node2D
class_name GetHit

@export var sprite: CanvasItem
@export var to_delete: Node2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var stream: AudioStream = null
@export var wait_for_audio := false

func _ready() -> void:
	if stream != null:
		audio.stream = stream

func get_hit(duration: float = 0.5) -> void:
	var material: ShaderMaterial = sprite.material
	material.set_shader_parameter("on", true)
	var tween := create_tween()
	tween.tween_method(
		func(v: float) -> void: material.set_shader_parameter("current_frame", v),
		0,
		60,
		duration
	)
	if not audio.playing:
		audio.play()
	await tween.finished
	if audio.playing and wait_for_audio:
		await audio.finished
	to_delete.queue_free.call_deferred()
