extends CharacterBody3D


enum PlayerStates{
	IDLE,
	WALKING,
	JUMPING,
	IN_AIR,
}

@export var ACCELERATION: float = 2.0
@export var MAX_SPEED: float = 8
@export var JUMP_VELOCITY: float  = 6.5
@export var DOUBLE_JUMP_SCALE: float  = 0.8
@export var JUMP_BUFFER_TIME: float  = 0.1
@export var COYOTE_TIME: float  = 0.01
@export var FRICTION: float  = 1.5
@export var GRAVITY_MULTIPLIER = 2.5
@export var JUMP_THRUST_TIME = 0.1
@export var HANG_TIME_MOVE_RATE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var jump_buffer_timer: float = 0
var jump_thrust_timer: float = 0
var coyote_timer: float = 0
var double_jump: int = 1
var current_state = PlayerStates.IDLE


func _ready():
	$SoundEnter.play()


func _process(delta: float) ->  void:
	match current_state:
		PlayerStates.IN_AIR:
			jump_thrust_timer += delta
	
	jump_buffer_timer -= delta
	coyote_timer -= delta
	return null
	

func _zero_jump_timers() -> void:
	jump_thrust_timer = 0
	coyote_timer = 0
	jump_buffer_timer = 0
	return null


#func _shake() -> void:
#	var orig_rotation = $Camera3d.rotation
#
#	$Camera3d.rotation.y += randf_range(-0.01, 0.01)
#	await get_tree().create_timer(0.1).timeout
#
#	$Camera3d.rotation.y += randf_range(-0.01, 0.01)
#	await get_tree().create_timer(0.1).timeout
#
#	$Camera3d.rotation = orig_rotation


#func fall() -> void:
#	Events.player_fall.emit()
#
#
#func collect_item(_item) -> void:
#	Events.coin_collected.emit()


func _physics_process(delta):
	var gravity_multipler = 1
	var jump_velocity = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	# Add the gravity.
	if not is_on_floor():
		if current_state != PlayerStates.JUMPING:
			current_state = PlayerStates.IN_AIR
	# Handle Jump.
	else:
		# We're on floor so make sure we reset double jump
		double_jump = 1
		
		# Jump!
		if jump_buffer_timer > 0 or Input.is_action_just_pressed("jump"):
			current_state = PlayerStates.JUMPING
		elif direction:
			current_state = PlayerStates.WALKING
		else:
			current_state = PlayerStates.IDLE
	
	# "Animate" the player mesh
	if velocity.x < 0:
		$MeshInstance3d.rotation.z = deg_to_rad(5)
	elif direction.x > 0:
		$MeshInstance3d.rotation.z = -deg_to_rad(5)
	else:
		$MeshInstance3d.rotation.z = move_toward($MeshInstance3d.rotation.z, 0, deg_to_rad(0.5))
	
	match current_state:
		PlayerStates.IN_AIR:
			# Handle Coyote Jump.
			if coyote_timer > 0 and Input.is_action_just_pressed("jump"):
				current_state = PlayerStates.JUMPING
			# Handle Double Jump
			elif double_jump and Input.is_action_just_pressed("jump"):
				double_jump = 0
				current_state = PlayerStates.JUMPING
			else:
				# Allow for change direction in mid-air
				if abs(direction.x) > 0 and sign(velocity.x) != sign(direction.x):
					velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED * HANG_TIME_MOVE_RATE, MAX_SPEED)
				
				# Increase gravity if already falling
				if velocity.y < 0:
					gravity_multipler = GRAVITY_MULTIPLIER
				
				if jump_thrust_timer > JUMP_THRUST_TIME:
					# Apply gravity to player
					velocity.y -= gravity * delta * gravity_multipler
		PlayerStates.WALKING:
			velocity.x = move_toward(velocity.x, sign(direction.x) * MAX_SPEED , ACCELERATION)
		PlayerStates.IDLE:
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		PlayerStates.JUMPING:
			# If this is a double jump with reduce the velocity
			if double_jump == 0:
				$SoundDoubleJump.play()
				jump_velocity = JUMP_VELOCITY * DOUBLE_JUMP_SCALE
			else:
				$SoundJump.play()
			
			# Apply jump velocity
			velocity.y = jump_velocity
			
			# Reset jump timers
			_zero_jump_timers()
			# Exit the jump state
			current_state = PlayerStates.IN_AIR
	
	velocity.z = 0
	
	var collided = move_and_slide()
	
#	if collided:
#		var collision: KinematicCollision3D = get_last_slide_collision()
#		var collider = collision.get_collider()
#
#		if collider.has_method("pushable"):
#			var collision_impulse: Vector3 = collision.get_collider_velocity()
#			var normal = collision.get_normal()
#
#			if abs(normal.y) < 0.1:
#				var impulse = Vector3(sign(collision_impulse.x) * 0.5, 0, 0)
#				var body: RigidBody3D = collider
#				body.apply_impulse(impulse)
#				body.make_noise()
