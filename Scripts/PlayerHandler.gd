extends Node3D

@export var SPEED := 5.0
@export var JUMP_VELOCITY := 4.5
@export var TURN_SPEED := 0.02
@export var MOUSE_SENS := 0.01


var fRotation = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.SPEED = SPEED
	$Player.JUMP_VELOCITY = JUMP_VELOCITY
	$Player.TURN_SPEED = TURN_SPEED
	$CamControl.MOUSE_SENS = MOUSE_SENS

