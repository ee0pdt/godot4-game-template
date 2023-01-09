extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}


func _ready() -> void:
	TranslationServer.set_locale("el")
