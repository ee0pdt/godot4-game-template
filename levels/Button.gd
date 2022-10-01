extends Node3D


var player_in_range: bool = false
@onready var player: AnimationPlayer = $AnimationPlayer


func _unhandled_key_input(event):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if not player.is_playing():
			$AnimationPlayer.play("ButtonRise")
			GameEvents.button_pressed.emit()


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_area_3d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
