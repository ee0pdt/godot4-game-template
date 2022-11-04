extends Node3D

class_name Hand


#signal decked_damage()
signal inspect_card(card_resource)

@export var is_player := true
#@export_node_path var deck_path
#@onready var deck := get_node(deck_path)

@export_node_path var camera_path
@onready var camera := get_node(camera_path)

@export var spread_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve

@export var width_array: Array[float]


@onready var rest_position = position
var tuck_position := Vector3(0, 0.5, 1.8)


func add_new_card(card) -> void:
	var cache_transform = card.transform
#	card.get_parent().remove_child(card)
	add_child(card)
	card.transform = cache_transform
	sort_hand()
#	card.draw_sound()
#	card.inspect.connect(inspection)


func sort_hand() -> void:
	var max_width 
	if get_child_count() >= width_array.size():
		max_width = width_array.back()
	else:
		max_width = width_array[get_child_count()]
	
	for card in get_children():
		var destination := global_transform
		
		var hand_ratio = 0.5
		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(get_child_count() - 1)
			
		if is_player:
			destination.basis = camera.global_transform.basis
			destination.origin.x += spread_curve.sample(hand_ratio) * max_width
			card.target_rotation = rotation_curve.sample(hand_ratio) * 0.3
			destination.origin += camera.basis * Vector3.UP * height_curve.sample(hand_ratio) * 0.5
			destination.origin += camera.basis * Vector3.BACK * hand_ratio * 0.1

		else:
			# enemy hand orientation
			destination.basis = global_transform.basis
			destination.origin.x += spread_curve.sample(hand_ratio) * max_width
			destination.origin += global_transform.basis * Vector3.UP * height_curve.sample(hand_ratio) * 0.5

		card.target_transform.origin = destination.origin
		card.target_transform.basis = destination.basis
