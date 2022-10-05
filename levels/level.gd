extends Node3D


func _on_next_level_pressed():
	GameEvents.next_level.emit()
