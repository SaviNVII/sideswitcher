extends Node2D

func create_obstacle(x1, x2, x3, x4, y1, y2):
	var trapezoid = Polygon2D.new()
	var points = [
		Vector2(x1, y1), # Top left
		Vector2(x2, y1), # Top right
		Vector2(x4, y2), # Bottom right
		Vector2(x3, y2) # Bottom left
	]
	
	print("Creating Obstacle x1, %s x2, %s x3, %s x4, %s y1, %s y2, %s" %[x1, x2, x3, x4, y1, y2])
	
	trapezoid.polygon = points
	trapezoid.color = Color(1, 1, 1)
	trapezoid.position = Vector2(0, 0)
	
	add_child(trapezoid)
