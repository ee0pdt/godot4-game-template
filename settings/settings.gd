extends Node2D


@export var game: PackedScene


func _on_done_button_pressed() -> void:
	AppEvents.main_menu.emit()
	get_tree().paused = false
