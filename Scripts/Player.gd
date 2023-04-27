extends CharacterBody3D


var SPEED := 5.0
var JUMP_VELOCITY := 4.5
var TURN_SPEED := 0.02

var fRotation = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration and turning
	var input_dir = Input.get_vector("Turn_Left", "Turn_Right", "Walk_Forward", "Walk_Backward")

	#rotate player
	rotate_y(input_dir.x * -TURN_SPEED)
	
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
