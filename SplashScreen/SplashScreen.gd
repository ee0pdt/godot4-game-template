extends Node2D


@export var main_menu: PackedScene
@export var splash_time: float = 1.5


func _ready():
	await get_tree().create_timer(splash_time).timeout
	get_tree().change_scene_to_packed(main_menu)
