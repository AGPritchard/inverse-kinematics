extends KinematicBody2D

const FEELER_LENGTH := 50.0

export(float) var speed := 200.0

var velocity := Vector2.ZERO

func _ready() -> void:
	# set feeler length
	for feeler in $Feelers.get_children():
		feeler.cast_to *= FEELER_LENGTH

func _process(_delta: float) -> void:
	_set_tentacle_end_point($Tentacles/Tentacle, $Feelers/Feeler)
	_set_tentacle_end_point($Tentacles/Tentacle2, $Feelers/Feeler2)
	_set_tentacle_end_point($Tentacles/Tentacle3, $Feelers/Feeler3)
	_set_tentacle_end_point($Tentacles/Tentacle4, $Feelers/Feeler4)

func _physics_process(_delta: float) -> void:
	# reset velocity
	velocity = Vector2.ZERO
	
	# get input and set velocity direction
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1.0
	if Input.is_action_pressed("move_down"):
		velocity.y += 1.0
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("move_right"):
		velocity.x += 1.0
	
	# calculate velocity and move
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)

# given a tentacle and a feeler,
# find the collision point and interpolate the tentacles target to the collision point
func _set_tentacle_end_point(tentacle: Tentacle, feeler: RayCast2D) -> void:
	if feeler.is_colliding():
		var collision_point := feeler.get_collision_point()
		tentacle.end_point = tentacle.end_point.linear_interpolate(collision_point, 0.2)
