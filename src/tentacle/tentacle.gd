extends Node2D

const NUM_OF_POINTS := 16
const SEGMENT_LENGTH := 5
const SEGMENT_WIDTH := 1

var segments := []
var lines := []

func _ready() -> void:
	# create a list of segments (a list of points)
	for i in NUM_OF_POINTS:
		segments.append((Vector2(0, SEGMENT_LENGTH) * i) + 
		(Vector2.UP * SEGMENT_LENGTH * (NUM_OF_POINTS - 1)))
	
	# create lines to visually display the segments
	for i in segments.size() - 1:
		var line := Line2D.new()
		line.add_point(segments[i])
		line.add_point(segments[i+1])
		line.width = SEGMENT_WIDTH + (i / 2)
		line.default_color = Color8(134 + int(rand_range(-25, 25)), 85 + int(rand_range(-25, 25)), 250)
		add_child(line)
		
		# store lines in a list as to update their positions later
		lines.append(line)
