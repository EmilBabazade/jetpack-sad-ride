extends Camera2D
class_name Camera

@export var shake_stregth := 2.0
var game_over := false

func _ready() -> void:
	HealthManager.death.connect(on_death)

func _process(delta: float) -> void:
	if Input.is_action_pressed("jump") and not game_over:
		offset.x = randf_range(-shake_stregth, shake_stregth)
		offset.y = randf_range(-shake_stregth, shake_stregth)
	else:
		offset = Vector2(0, 0)

func shake_down(strength: float = 2.0) -> void:
	var shake_tween := create_tween()
	var rnd_offset := Vector2(randf_range(-strength, strength), strength)
	shake_tween.tween_property(self, "offset", rnd_offset, 0.1)
	rnd_offset = Vector2(randf_range(-strength, strength), -strength)
	shake_tween.tween_property(self, "offset", rnd_offset, 0.1)
	shake_tween.tween_property(self, "offset", Vector2.ZERO, 0.1)

func on_death() -> void:
	game_over = true
