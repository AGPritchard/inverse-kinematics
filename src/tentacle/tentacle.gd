class_name Tentacle
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
	
	# set initial sucker area position to end of tentacle
	$SuckerArea.position = segments[0]

func _process(_delta: float) -> void:
	# set base position
	var base: Vector2 = segments[-1]
	
	# set target
	var target := get_global_mouse_position()
	
	# perform reach in forward direction
	for i in NUM_OF_POINTS - 1:
		var reach := _reach(segments[i], segments[i+1], target)
		
		segments[i] = reach[0]
		target = reach[1]
	segments[-1] = target
	
	# perform reach in reverse
	target = base
	for i in range(NUM_OF_POINTS - 1, 0, -1):
		var reach := _reach(segments[i], segments[i-1], target)
		segments[i] = reach[0]
		target = reach[1]
	segments[0] = target
	
	# update line points
	for i in segments.size() - 1:
		lines[i].points[0] = segments[i]
		lines[i].points[1] = segments[i + 1]
	
	# update sucker area position
	$SuckerArea.position = segments[0]

# Given a segment (head, tail) and a target position,
# calculate a new head and tail position as to set the head to be at the target
func _reach(head: Vector2, tail: Vector2, target: Vector2) -> Array:
	var c_dx := tail.x - head.x
	var c_dy := tail.y - head.y
	var c_dist := tail.distance_to(head)
	
	var s_dx := tail.x - target.x
	var s_dy := tail.y - target.y
	var s_dist := tail.distance_to(target)
	
	var line_scale := c_dist / s_dist
	
	return([
		target,
		Vector2(target.x + s_dx * line_scale, target.y + s_dy * line_scale)
	])
