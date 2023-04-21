extends CharacterBody3D


@export var SPEED := 5.0

#path to the current target
var path := PackedVector3Array([])
var pathIndex := 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#currently trying to reach
var target := position

#distance threshold to choose when to go to next point in path
var disThreshold := 0.5

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# get direction to nex path index
	var direction = Vector3.ZERO
	if not path.is_empty():
		if(position.distance_to(path[pathIndex]) < disThreshold):
			pathIndex = clamp(pathIndex + 1, 0, path.size() -1)
		direction = position.direction_to(path[pathIndex])
		
		
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func _gen_path():
	#debug
	target = get_tree().get_nodes_in_group("Player")[0].position
	path = NavigationSingleton.get_navigation_path(position,target)
	if(not path.is_empty()):
		pathIndex = 1
