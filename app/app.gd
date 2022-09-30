extends Node


@export var main_menu: PackedScene
@export var game: PackedScene


func _ready():
	_register_events()


func _register_events():
	AppEvents.main_menu.connect(self._handle_main_menu)
	AppEvents.start_game.connect(self._handle_start_game)


func _handle_main_menu():
	get_tree().change_scene_to_packed(main_menu)


func _handle_start_game():
	get_tree().change_scene_to_packed(game)
