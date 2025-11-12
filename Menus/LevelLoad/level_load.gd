extends Node2D

var shape_radius = 100
var player_x
var player_y

var level_seed = []

var preloaded_player = load("res://Menus/LevelLoad/LevelPlayer.tscn")
var player = preloaded_player.instantiate()

var preloaded_obstacle = load("res://Menus/LevelLoad/Obstacle.tscn")

var song_name = Global.levels[Global.selected].name
var bpm = Global.levels[Global.selected].bpm
var events = Global.levels[Global.selected].events
var sides = int(events[0].extraData.sides)
var player_rotation = 180/sides

var new_obstacle = preloaded_obstacle.instantiate()


func _ready() -> void:
	create_shape(sides)
	add_child(player)
	
	add_child(new_obstacle)
	new_obstacle.create_obstacle(1, sides, 50, 250)

func _process(delta: float) -> void:
	new_obstacle.update_shape(5)
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
		
	player_x = Global.screen_center_x + shape_radius * cos(deg_to_rad(player_rotation))
	player_y = Global.screen_center_y + shape_radius * sin(deg_to_rad(player_rotation))
	player.position = Vector2(player_x, player_y)
	
	if (Input.is_action_just_pressed("Right")):
		player_rotation = player_rotation + (360/sides)
		if (player_rotation >= 360):
			player_rotation -= 360
	else: if (Input.is_action_just_pressed("Left")):
		player_rotation = player_rotation - (360/sides)
		if (player_rotation >= 360):
			player_rotation -= 360
	
func create_shape(vertices_amount):
	var vertices = PackedVector2Array()
	for i in range(vertices_amount):
		var angle = (i * 2 * PI) / vertices_amount
		var x = shape_radius * cos(angle)
		var y = shape_radius * sin(angle)
		vertices.append(Vector2(x, y))
		
	var poly = Polygon2D.new()
	poly.set_polygon(vertices)
	poly.color = Color(1, 1, 1)
	poly.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	add_child(poly)	
