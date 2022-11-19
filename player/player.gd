extends CharacterBody3D

class_name Player


@export var speed: float = 0.0
@export var MAX_SPEED: float = 2.0
@export var ROTATION_SPEED: float = 120.0
@export var ACCELERATION: float = 0.05

const JUMP_VELOCITY: float  = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var moving := false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	var direction := (transform.basis * Vector3(0, 0, 1)).normalized()
	
	if moving:
		speed = MAX_SPEED
		%RightExhaustCone.show()
		%LeftExhaustCone.show()
		%ExhaustLight.show()
	else:
		%RightExhaustCone.hide()
		%LeftExhaustCone.hide()
		%ExhaustLight.hide()
		speed = move_toward(speed, 0, 0.01)
	
	velocity.x = move_toward(velocity.x, direction.x * speed, ACCELERATION)
	velocity.z = move_toward(velocity.z, direction.z * speed, ACCELERATION)

	var _result = move_and_slide()


func forward(delta: float):
	moving = true


func stop():
	moving = false


func rotate_left(delta: float):
	rotation.y += deg_to_rad(delta * ROTATION_SPEED)


func rotate_right(delta: float):
	rotation.y -= deg_to_rad(delta * ROTATION_SPEED)
