extends Node3D


var player_in_range: bool = false


func _unhandled_key_input(event):
	if player_in_range and Input.is_action_just_pressed("interact"):
		GameEvents.button_pressed.emit()


func _on_area_3d_body_entered(body):
	print("body entered: ", body.name)
	if body.name == "Player":
		player_in_range = true


func _on_area_3d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
