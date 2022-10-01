extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_main_menu_button_pressed():
	AppEvents.main_menu.emit()
