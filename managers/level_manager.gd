extends Node

var _level := 1

signal level_up(level: int)

func next_level() -> void:
	_level += 1
	level_up.emit(_level)
