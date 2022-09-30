extends Node2D


func _on_main_menu_button_pressed():
	app_events.main_menu.emit()
