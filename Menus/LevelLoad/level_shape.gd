extends Node2D

func create_shape(vertices_amount):
	var radius = 50
	var vertices = PackedVector2Array()
	for i in range(vertices_amount):
		var angle = (i * 2 * PI) / vertices_amount
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		vertices.append(Vector2(x, y))
		
	var poly = Polygon2D.new()
	poly.set_polygon(vertices)
	poly.color = Color(1, 1, 1)
	poly.position = Vector2(100, 100)
	add_child(poly)
