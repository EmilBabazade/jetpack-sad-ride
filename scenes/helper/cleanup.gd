extends Node2D

@onready var timer: Timer = $Timer
@export var life_time := 10.0
@export var to_delete: Node

func _ready() -> void:
	timer.wait_time = life_time
	timer.start()


func _on_timer_timeout() -> void:
	to_delete.queue_free.call_deferred()
