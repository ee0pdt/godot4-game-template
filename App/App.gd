extends Node


@export var main_menu: PackedScene


func _ready():
	_register_events()


func _register_events():
	AppEvents.main_menu.connect(self._handle_main_menu)


func _handle_main_menu():
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
