extends Node3D

@export var in_stack := true

var turn_left_symbol = preload("res://cards/assets/turn_left_icon.svg")
var turn_right_symbol = preload("res://cards/assets/turn_right_icon.svg")


var type: Card.Types:
	set(type_in):
		type = type_in
		match type:
			Card.Types.TURN_LEFT:
				ability.texture = turn_left_symbol
			Card.Types.TURN_RIGHT:
				ability.texture = turn_right_symbol
			_:
				ability.texture = null

const ANIM_SPEED := 12.0

signal play_card(card)

@onready var card_name := $CardMesh/CardName
@onready var card_power := $CardMesh/CardPower
@onready var card_toughness := $CardMesh/CardToughness
@onready var cost := $CardMesh/BerryCost
@onready var stomp := $CardMesh/StompCost
@onready var ability := $CardMesh/Ability
@onready var outline := $CardMesh/Outline
@onready var target_transform := global_transform
@onready var mesh := $CardMesh

var camera_position: Vector2
var camera_depth: float

#var one_berry := preload("res://EssentialGames/CardGame/Cards/Runes/1-berry-2.png")
#var two_berry := preload("res://EssentialGames/CardGame/Cards/Runes/2-berry-2.png")
#var three_berry := preload("res://EssentialGames/CardGame/Cards/Runes/3-berry-2.png")
#
#var berry_cost = 1:
#	set(cost_in):
#		berry_cost = cost_in
#		match berry_cost:
#			1:
#				cost.texture = one_berry
#			2:
#				cost.texture = two_berry
#			3:
#				cost.texture = three_berry
#			_:
#				cost.texture = null
#				stomp.position = cost.position

func _process(delta: float) -> void:
	if is_in_hand() and outline.visible:
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
	if is_in_hand():
		scale = Vector3.ONE * 1.1


func _on_area_3d_mouse_exited() -> void:
	outline.visible = false
	scale = Vector3.ONE


#var stomp_cost = true:
#	set(cost_in):
#		stomp_cost = cost_in
#		stomp.visible = cost_in


var target_rotation := 0.0
var sleepy := false

func is_in_hand() -> bool:
#	return get_parent() is Hand
	return true

func setup_card(card_resource: Resource) -> void:
	if not is_inside_tree():
		await ready
	
	type = card_resource.type
	
	match type:
		Card.Types.TURN_LEFT:
			card_name.text = "Turn Left"
		Card.Types.TURN_RIGHT:
			card_name.text = "Turn Right"
		Card.Types.SHEILD:
			card_name.text =  "Shield"
#	berry_cost = card_resource.berry_cost
#	stomp_cost = card_resource.stomp
#	card_name.text = card_resource.card_name
#	card_power.text = str(card_resource.card_power)
#	card_toughness.text = str(card_resource.card_toughness)
#	card_ability = card_resource.ability	
