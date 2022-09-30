extends Node2D


@export var splash_time: float = 1.5


func _ready():
	await get_tree().create_timer(splash_time).timeout
	AppEvents.main_menu.emit()
