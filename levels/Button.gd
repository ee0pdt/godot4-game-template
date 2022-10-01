extends Node3D


func _unhandled_key_input(event):
	if Input.is_action_just_pressed("interact"):
		GameEvents.button_pressed.emit()
