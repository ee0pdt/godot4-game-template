extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}


func _ready() -> void:
	pass
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drop_bomb"):
		%Bomb.freeze = false
