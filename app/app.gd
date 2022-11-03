extends Node


@export_file("*.tscn") var main_menu
@export_file("*.tscn") var game
@export_file("*.tscn") var settings


func _ready():
	_register_events()


func _register_events():
	var errors: Array[Dictionary] = []
	errors.append({"name": "MainMenu", "result": AppEvents.main_menu.connect(self._handle_main_menu)})
	errors.append({"name": "StartGame", "result": AppEvents.start_game.connect(self._handle_start_game)})
	errors.append({"name": "Quit", "result": AppEvents.quit.connect(self._handle_quit)})
	errors.append({"name": "Result", "result": AppEvents.settings.connect(self._handle_settings)})
	
	for item in errors:
		if item.result != 0:
			print("ERROR: ", item.name, item.result)


func _handle_main_menu():
	get_tree().change_scene_to_file(main_menu)


func _handle_start_game():
	get_tree().change_scene_to_file(game)


func _handle_quit():
	get_tree().quit()


func _handle_settings():
	get_tree().paused = true
	get_tree().change_scene_to_file(settings)
	
