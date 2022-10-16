extends Node3D

enum Actions {
	WAVE,
	RAISE,
	DIP,
	BLESS
}

enum States {
	BEFORE,
	IDLE,
	INSTRUCTING,
	ACTION,
	OVER
}

var current_action: Actions
var current_state: States = States.BEFORE
var countdown: float
@export var idle_wait_time: float = 5
@export var action_wait_time: float = 3


func _process(delta):
	_updateHud()
#	match current_state:
#		States.BEFORE:
#			countdown = idle_wait_time
#			current_state = States.IDLE
#		States.IDLE:
#			countdown -= delta
#			if countdown <= 0:
#				current_state = States.INSTRUCTING
#		States.INSTRUCTING:
#			current_action = Actions.values()[randi_range(0, Actions.size())]
#			countdown = action_wait_time
#			current_state = States.ACTION
#		States.ACTION:
#			countdown -= delta
#			if countdown <= 0:
#				current_state = States.OVER
#		States.OVER:
#			pass


func _updateHud():
	%Countdown.text = str(ceil(countdown))
	%State.text = %StateMachine.state.name
