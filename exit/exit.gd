extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == Game.PLAYER_NAME:
		GameEvents.player_exited.emit()
