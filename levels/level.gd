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
	OVER,
	WIN
}

const LOOP_LENGTH = 1.97

var current_action: Actions
var current_state: States = States.BEFORE
var points: int = 0
var loop_index: int = 1
var previous_time: float = 0
var has_hammer: bool = false
@export var idle_wait_time: float = 5
@export var action_wait_time: float = 10
@export var points_target: int = 5


func _process(delta):
	_updateHud()


func _updateHud() -> void:
	%State.text = %StateMachine.state.name
	%Action.text = Actions.keys()[current_action]


func get_loop_time() -> float:
	var time = %MusicLoop.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	
	if time > previous_time or time < 0.5 and previous_time > 1.5:
		previous_time = time
	
	return previous_time


func _on_hammer_area_body_entered(body):
	%HammerArea.hide()
	%Player.show_hammer()
	has_hammer = true
