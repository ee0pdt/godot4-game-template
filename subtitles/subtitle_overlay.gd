extends Node2D


func _ready() -> void:
	_register_events()


func _register_events() -> void:
	var result = GameEvents.subtitle.connect(self._handle_subtitle)
	if result != 0:
		print("ERROR: ", result)


func _handle_subtitle(msg: String) -> void:
	%Subtitle.text = msg
