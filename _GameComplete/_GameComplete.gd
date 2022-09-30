extends Node2D


func _on_main_menu_button_pressed():
	AppEvents.main_menu.emit()
