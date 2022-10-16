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

const LOOP_LENGTH = 1.99

var current_action: Actions
var current_state: States = States.BEFORE
var countdown: float
var loop_index: int = 1
var previous_time: float = 0
@export var idle_wait_time: float = 5
@export var action_wait_time: float = 10


func _process(delta):
	_updateHud()


func _updateHud() -> void:
	%Countdown.text = str(ceil(countdown))
	%State.text = %StateMachine.state.name
	%Action.text = Actions.keys()[current_action]


func get_loop_time() -> float:
	var time = %MusicLoop.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	
	if time > previous_time or time < 0.5 and previous_time > 1.5:
		previous_time = time
	
	return previous_time
