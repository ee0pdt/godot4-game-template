extends Node2D


@export var game: PackedScene


func _on_start_game_pressed():
	get_tree().change_scene_to_packed(game)
