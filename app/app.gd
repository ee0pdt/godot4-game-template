extends Node


@export_file("*.tscn") var main_menu
@export_file("*.tscn") var game
@export_file("*.tscn") var settings


func _ready():
	_register_events()


func _register_events():
	AppEvents.main_menu.connect(self._handle_main_menu)
	AppEvents.start_game.connect(self._handle_start_game)
	AppEvents.quit.connect(self._handle_quit)
	AppEvents.settings.connect(self._handle_settings)


func _handle_main_menu():
	get_tree().change_scene_to_file(main_menu)


func _handle_start_game():
	get_tree().change_scene_to_file(game)


func _handle_quit():
	get_tree().quit()


func _handle_settings():
	print("settings")
	get_tree().paused = true
	
