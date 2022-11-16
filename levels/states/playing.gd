extends State


var level: Level
var original_card_position
var time := 0.0
const PULSE_SCALE = 0.5
const PULSE_SPEED = 10
const PULSE_MIN = 0.9
const PULSE_MAX = 1.1

var pulse_range = PULSE_MAX - PULSE_MIN

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float) -> void:
	time += delta
	var pulse = sin(time * PULSE_SPEED) + 1.0
	var scale_factor = PULSE_MIN + (pulse * pulse_range)
	
	level.current_card.scale = Vector3.ONE * scale_factor
	
	match level.current_card.type:
		Card.Types.FORWARD:
			level.player.forward(delta)
		Card.Types.TURN_LEFT:
			level.player.rotate_left(delta)
		Card.Types.TURN_RIGHT:
			level.player.rotate_right(delta)
		_:
			pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	level = owner
	original_card_position = level.current_card.position
	print("Pressing")
	var _result = GameEvents.release_card.connect(_handle_release_card)


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	GameEvents.release_card.disconnect(_handle_release_card)


func _handle_release_card(card: Card3D) -> void:
	level.player.stop()
	level.hand.play_card(card)
	
	state_machine.transition_to(Level.States.keys()[Level.States.IDLE])


