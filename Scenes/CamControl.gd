extends SpringArm3D

var MOUSE_SENS := 0.05

@onready var cam = $Camera3D

var first_person = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if(event is InputEventMouseMotion):
		rotation.y += (-event.relative.x * MOUSE_SENS)
		rotation.x += (-event.relative.y * MOUSE_SENS)
		rotation.x = clampf(global_rotation.x,-PI/4,PI/4)
		get_parent().fRotation = rotation.y
