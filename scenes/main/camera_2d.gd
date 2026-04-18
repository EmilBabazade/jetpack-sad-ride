extends Camera2D

@export var shake_stregth := 2.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		offset.x = randf_range(-shake_stregth, shake_stregth)
		offset.y = randf_range(-shake_stregth, shake_stregth)
	else:
		offset = Vector2(0, 0)
