extends Node2D

func _ready() -> void:
	var name = Global.levels[Global.selected].name
	var bpm = Global.levels[Global.selected].bpm
	var events = Global.levels[Global.selected].events
	var sides = int(events[0].extraData.sides)
	
	create_shape(sides)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
		
func create_shape(vertices_amount):
	var radius = 100
	var vertices = PackedVector2Array()
	for i in range(vertices_amount):
		var angle = (i * 2 * PI) / vertices_amount
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		vertices.append(Vector2(x, y))
		
	var poly = Polygon2D.new()
	poly.set_polygon(vertices)
	poly.color = Color(1, 1, 1)
	poly.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	add_child(poly)
