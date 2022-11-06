extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}


const CARD_SCENE := preload("res://cards/card_3d.tscn")

@export var starting_hand: Array[Card]

@onready var hand: Hand = %Hand
@onready var player := %Player


func _ready() -> void:
	_register_events()
	_initialise_hand()


func _register_events():
	GameEvents.play_card.connect(_handle_play_card)


func _initialise_hand():
	for type in starting_hand:
		_add_card(type)
		await get_tree().create_timer(0.3).timeout


func _add_card(card_resource: Card):
	var card = CARD_SCENE.instantiate()
	card.setup_card(card_resource)
	hand.add_new_card(card)


func _handle_play_card(card: Card3D):
	print("Card played: ", card.type)
	
	match card.type:
		Card.Types.TURN_LEFT:
			player.rotate_left()
		Card.Types.TURN_RIGHT:
			player.rotate_right()
		_:
			pass
	
	hand.play_card(card)
