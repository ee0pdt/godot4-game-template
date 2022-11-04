extends Control

@export var can_hover := true

signal hover(is_hovering)

@export var gather_symbol: Texture
@export var poison_symbol: Texture
@export var one_berry: Texture
@export var two_berry: Texture
@export var three_berry: Texture

var resource_backup

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

@onready var card_name := $PanelContainer/Control/CardName
@onready var card_power := $PanelContainer/Control/BottomBox/cardPower
@onready var card_toughness := $PanelContainer/Control/BottomBox/CardToughness
@onready var cost := $PanelContainer/Control/CostBox/BerryCost
@onready var stomp := $PanelContainer/Control/CostBox/StompCost
@onready var ability := $PanelContainer/Control/BottomBox/Ability
@onready var card_art := $PanelContainer/CardArt

var berry_cost = 1:
	set(cost_in):
		berry_cost = cost_in
		match berry_cost:
			1:
				cost.texture = one_berry
			2:
				cost.texture = two_berry
			3:
				cost.texture = three_berry
			_:
				cost.texture = null
				cost.visible = false
		
var stomp_cost = true:
	set(cost_in):
		stomp_cost = cost_in
		stomp.visible = cost_in
		
var target_rotation := 0.0
var sleepy := false

func setup_card(card_resource: Resource) -> void:
	if not is_inside_tree():
		await ready
	resource_backup = card_resource
	berry_cost = card_resource.berry_cost
	stomp_cost = card_resource.stomp
	card_name.text = card_resource.card_name
	card_power.text = str(card_resource.card_power)
	card_toughness.text = str(card_resource.card_toughness)
#	card_ability = card_resource.ability
	card_art.texture = card_resource.card_art

func _on_simple_card_mouse_entered() -> void:
	if can_hover:
		hover.emit(resource_backup)


func _on_simple_card_mouse_exited() -> void:
	if can_hover:
		hover.emit(null)
