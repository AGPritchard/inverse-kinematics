extends KinematicBody2D

export(float) var speed := 200.0

var velocity := Vector2.ZERO

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
