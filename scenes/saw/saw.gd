extends Area2D
class_name Saw


func _on_body_entered(_body: Node2D) -> void:
	HealthManager.death.emit()
