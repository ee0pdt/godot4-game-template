class_name Level
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
var loop_index: int = 1
@export var idle_wait_time: float = 5
@export var action_wait_time: float = 10


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


func _updateHud() -> void:
	%Countdown.text = str(ceil(countdown))
	%State.text = %StateMachine.state.name
	%Action.text = Actions.keys()[current_action]


func get_loop_time() -> float:
	var time = %MusicLoop.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	
	return time
