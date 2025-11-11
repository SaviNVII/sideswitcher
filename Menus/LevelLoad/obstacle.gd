extends Node2D

func create_obstacle(x1, x2, x3, x4, y1, y2, y3, y4):
	var trapezoid = Polygon2D.new()
	
	var points = PackedVector2Array()
	points.append(Vector2(x1, y1))
	points.append(Vector2(x2, y2))
	points.append(Vector2(x3, y3))
	points.append(Vector2(x4, y4))
	
	trapezoid.set_polygon(points)
	trapezoid.color = Color(1, 1,1)
	trapezoid.position = Vector2(0, 0)
	
	add_child(trapezoid)
