extends Node2D


func _ready() -> void:
	_register_events()


func _register_events() -> void:
	var result = GameEvents.subtitle.connect(self._show_subtitle)
	if result != 0:
		print("ERROR: ", result)
	
	result = GameEvents.hide_subtitle.connect(self._hide_subtitle)
	if result != 0:
		print("ERROR: ", result)


func _show_subtitle(msg: String) -> void:
	%Subtitle.text = msg
	%Subtitle.show()


func _hide_subtitle(msg: String) -> void:
	if %Subtitle.text == msg:
		%Subtitle.hide()
