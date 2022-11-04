extends Node3D


enum States {
	BEFORE,
	PLAYING,
	OVER
}


const CARD := preload("res://cards/card_3d.tscn")

@onready var hand: Hand = %Hand


func _ready() -> void:
	add_n_cards(5)
	
	for card in hand.get_children():
		var hand_ratio = 0.5
		
		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)


func add_n_cards(total: int):
	for _x in 5:
		var card = CARD.instantiate()
		hand.add_new_card(card)
