extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}


const CARD := preload("res://cards/card_3d.tscn")
@export var starting_hand: Array[Card]


@onready var hand: Hand = %Hand


func _ready() -> void:
	for type in starting_hand:
		add_card(type)
		await get_tree().create_timer(0.3).timeout
	
	for card in hand.get_children():
		var hand_ratio = 0.5
		
		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)


func add_card(card_resource: Card):
	var card = CARD.instantiate()
#	var card_resource = Card.new()
	card.setup_card(card_resource)
	hand.add_new_card(card)
