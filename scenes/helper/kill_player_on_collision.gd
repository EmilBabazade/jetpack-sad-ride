extends Node2D

@export var collision_area: Area2D

func _ready() -> void:
	collision_area.body_entered.connect(on_body_entered)

func on_body_entered(_body: Node2D) -> void:
	HealthManager.death.emit()
