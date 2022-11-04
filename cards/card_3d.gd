extends Node3D

@export var in_stack := true

#var gather_symbol = preload("res://EssentialGames/CardGame/gatherer.png")
#var poison_symbol = preload("res://EssentialGames/CardGame/poison.png")
#
#var card_ability: CardGameManager.abilities:
#	set(ability_in):
#		card_ability = ability_in
#		match card_ability:
#			CardGameManager.abilities.GATHERER:
#				ability.texture = gather_symbol
#			CardGameManager.abilities.POISON:
#				ability.texture = poison_symbol
#			_:
#				ability.texture = null

const ANIM_SPEED := 12.0

signal play_card(card)

@onready var card_name := $Cube/CardName
@onready var card_power := $Cube/CardPower
@onready var card_toughness := $Cube/CardToughness
@onready var cost := $Cube/BerryCost
@onready var stomp := $Cube/StompCost
@onready var ability := $Cube/Ability
@onready var outline := $Cube/Outline

@onready var mesh := $Cube

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
		
var stomp_cost = true:
	set(cost_in):
		stomp_cost = cost_in
		stomp.visible = cost_in
		
var target_rotation := 0.0
var sleepy := false

func setup_card(card_resource: Resource) -> void:
	if not is_inside_tree():
		await ready
#	berry_cost = card_resource.berry_cost
#	stomp_cost = card_resource.stomp
#	card_name.text = card_resource.card_name
#	card_power.text = str(card_resource.card_power)
#	card_toughness.text = str(card_resource.card_toughness)
#	card_ability = card_resource.ability

func _on_area_3d_mouse_entered() -> void:
	outline.visible = true
	if in_stack:
		mesh.position = Vector3.RIGHT * 1.4

func _on_area_3d_mouse_exited() -> void:
	outline.visible = false
	if in_stack:
		mesh.position = Vector3.ZERO
	
	
