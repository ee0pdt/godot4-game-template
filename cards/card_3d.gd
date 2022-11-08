extends Node3D

class_name Card3D


@onready var card_name := $CardMesh/CardName
@onready var ability := $CardMesh/Ability
@onready var outline := $CardMesh/Outline
@onready var target_transform := global_transform
@onready var mesh := $CardMesh

var forward_icon = preload("res://cards/assets/forward_icon.svg")
var turn_left_icon = preload("res://cards/assets/turn_left_icon.svg")
var turn_right_icon = preload("res://cards/assets/turn_right_icon.svg")


var type: Card.Types:
	set(type_in):
		type = type_in
		match type:
			Card.Types.FORWARD:
				ability.texture = forward_icon
			Card.Types.TURN_LEFT:
				ability.texture = turn_left_icon
			Card.Types.TURN_RIGHT:
				ability.texture = turn_right_icon
			_:
				ability.texture = null

const ANIM_SPEED := 12.0

var camera_position: Vector2
var camera_depth: float
var target_rotation := 0.0


func _process(delta: float) -> void:
	if outline.visible:
		# card hovered
		rotation.z = lerp(rotation.z, 0.0, ANIM_SPEED * delta)
		var view_spot = target_transform
#		view_spot.origin = find_camera_pos()
		transform = transform.interpolate_with(view_spot, ANIM_SPEED * delta)
	else:
		transform = transform.interpolate_with(target_transform, ANIM_SPEED * delta)
		rotation.z = lerp(rotation.z, target_rotation, ANIM_SPEED * delta)


func find_camera_pos() -> Vector3:
	var camera = get_viewport().get_camera_3d()
	var unprojected = camera.unproject_position(target_transform.origin)
	# I fiddled with the y coordinate and distance here so the full card is visible
	return camera.project_position(Vector2(unprojected.x, 750), 2.0)


func _on_area_3d_mouse_entered() -> void:	
	outline.visible = true
	scale = Vector3.ONE * 1.1


func _on_area_3d_mouse_exited() -> void:
	outline.visible = false
	scale = Vector3.ONE


func setup_card(card_resource: Resource) -> void:
	if not is_inside_tree():
		await ready
	
	type = card_resource.type
	card_name.text = card_resource.get_type_as_string()


func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_pressed():
		GameEvents.play_card.emit(self)
