extends Node
class_name Game


@export var levels: Array[PackedScene]
@export_file("*.tscn") var game_complete

var game_complete_scene: PackedScene


var current_level_scene: Node
var current_level = 0


const PLAYER_NAME := "Player"


func _ready() -> void:
	game_complete_scene = load(game_complete)
	_register_events()
	current_level_scene = levels[0].instantiate()
	add_child(current_level_scene)
	$SoundMusic.play()


func _register_events() -> void:
	GameEvents.next_level.connect(self._handle_level_changed)


func _handle_level_changed() -> void:
	current_level += 1
	
	var next_scene: PackedScene

	if current_level >= levels.size():
		next_scene = game_complete_scene
	else:
		next_scene = levels[current_level]
	
	var next_scene_instance = next_scene.instantiate()
	
	add_child(next_scene_instance)
	current_level_scene.queue_free()
	current_level_scene = next_scene_instance
