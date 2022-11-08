extends State


var level: Level


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	level = owner
	print("Idle")
	GameEvents.press_card.connect(_handle_press_card)


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	GameEvents.press_card.disconnect(_handle_press_card)


func _handle_press_card(card: Card3D) -> void:	
	level.current_card = card
	state_machine.transition_to(Level.States.keys()[Level.States.PRESSING])
