extends Node2D


func _on_next_level_pressed():
	game/game_events.next_level.emit()
