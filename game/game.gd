extends Node


@export var levels: Array[PackedScene]
@export_file("*.tscn") var game_complete


var current_level_scene: Node
var current_level = 0


func _ready() -> void:
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
		next_scene = load(game_complete)
	else:
		next_scene = levels[current_level]
	
	var next_scene_instance = next_scene.instantiate()
	
	add_child(next_scene_instance)
	current_level_scene.queue_free()
	current_level_scene = next_scene_instance
