extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const ZOOM_SPEED = 30

const FOV_MIN = 25
const FOV_MAX = 90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D


func _physics_process(delta: float) -> void:
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("spin_left"):
		rotation.y -= deg_to_rad(1)
	elif Input.is_action_pressed("spin_right"):
		rotation.y += deg_to_rad(1)

	if Input.is_action_pressed("zoom_in"):
		camera.fov = clamp(camera.fov - (ZOOM_SPEED * delta), FOV_MIN, FOV_MAX)
	elif Input.is_action_pressed("zoom_out"):
		camera.fov = clamp(camera.fov + (ZOOM_SPEED * delta), FOV_MIN, FOV_MAX)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, delta * SPEED)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, delta * SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, delta * SPEED)
		velocity.z = move_toward(velocity.z, 0, delta * SPEED)

	move_and_slide()
