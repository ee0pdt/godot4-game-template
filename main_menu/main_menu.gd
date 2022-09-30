extends Node2D


@export var game: PackedScene


func _on_start_game_pressed():
	AppEvents.start_game.emit()
