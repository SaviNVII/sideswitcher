extends Node2D

var x1
var y1

var x2
var y2

var x3
var y3

var x4
var y4

var distance
var shape_sides # sides of the shape the obstacle is around
var shape_height
var current_side

var trapezoid = Polygon2D.new()

func _process(delta: float) -> void:
	update_shape(5)

func create_obstacle(side, sides, height, dist):
	distance = dist
	shape_sides = sides
	shape_height = height
	current_side = side
	
	update_shape(0)
	
	add_child(trapezoid)

func calc_points():
	var theta_one = (360/shape_sides) * current_side
	var theta_two = (360/shape_sides) * (current_side + 1)
	
	while(theta_two >= 360):
		theta_two -= 360
	
	var side_distance = shape_height/(cos(deg_to_rad(180/shape_sides)))
	
	x1 = (distance + side_distance) * (cos(deg_to_rad(theta_two))) + Global.screen_center_x
	y1 = (distance + side_distance) * (sin(deg_to_rad(theta_two))) + Global.screen_center_y
	
	x2 = (distance + side_distance) * (cos(deg_to_rad(theta_one))) + Global.screen_center_x
	y2 = (distance + side_distance) * (sin(deg_to_rad(theta_one))) + Global.screen_center_y
	
	x3 = (distance) * (cos(deg_to_rad(theta_one))) + Global.screen_center_x
	y3 = (distance) * (sin(deg_to_rad(theta_one))) + Global.screen_center_y
	
	x4 = (distance) * (cos(deg_to_rad(theta_two))) + Global.screen_center_x
	y4 = (distance) * (sin(deg_to_rad(theta_two))) + Global.screen_center_y

func update_shape(modifier):
	distance -= modifier
	if(distance <= 0):
		self.queue_free()
	
	calc_points()
	
	var points = PackedVector2Array()
	points.append(Vector2(x1, y1))
	points.append(Vector2(x2, y2))
	points.append(Vector2(x3, y3))
	points.append(Vector2(x4, y4))
	
	trapezoid.set_polygon(points)
