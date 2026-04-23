extends Area2D
class_name Crab

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_hit() -> void:
	var material: ShaderMaterial = sprite.material
	material.set_shader_parameter("on", true)
	var tween := create_tween()
	tween.tween_method(
		func(v: float) -> void: material.set_shader_parameter("current_frame", v),
		0,
		60,
		0.5
	)
	await tween.finished
	queue_free.call_deferred()
