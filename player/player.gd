extends CharacterBody3D

class_name Player


@export var speed := 0.0
@export var MAX_SPEED := 2.0
@export var ROTATION_SPEED := 45.0
@export var ACCELERATION := 1.0

const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	var direction := (transform.basis * Vector3(0, 0, 1)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func forward(delta: float):
	speed = clamp(speed + (delta * ACCELERATION), 0, MAX_SPEED)


func rotate_left(delta: float):
	rotation.y += deg_to_rad(delta * ROTATION_SPEED)


func rotate_right(delta: float):
	rotation.y -= deg_to_rad(delta * ROTATION_SPEED)
