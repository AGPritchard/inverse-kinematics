extends Node2D

const NUM_OF_POINTS := 16
const SEGMENT_LENGTH := 5

var segments := []

func _ready() -> void:
	# create a list of segments (a list of points)
	for i in NUM_OF_POINTS:
		segments.append((Vector2(0, SEGMENT_LENGTH) * i) + 
		(Vector2.UP * SEGMENT_LENGTH * (NUM_OF_POINTS - 1)))
	
