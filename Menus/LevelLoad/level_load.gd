extends Node2D

var shape_radius = 100
var player_x
var player_y

var poly

var map_index = 0

var preloaded_player = load("res://Menus/LevelLoad/LevelPlayer.tscn")
var player = preloaded_player.instantiate()

var preloaded_obstacle = load("res://Menus/LevelLoad/Obstacle.tscn")

var current_offset = 1

var song_name = Global.levels[Global.selected].name
var bpm = Global.levels[Global.selected].bpm
var events = Global.levels[Global.selected].events
var sides = int(events[0].extraData.sides)
var player_rotation = (180/sides) * current_offset
var time = int(events[0].time)

var level_map = events[0].map
var side_map = events[0].sideMap

var delay = 16/bpm
var delay_index = 0

var obstacle_speed = bpm * 2

var time_count: int = 0

var song = load("res://Levels/" + song_name + "/song.ogg")

func _ready() -> void:
	create_shape(sides)
	add_child(player)
	
	$AudioStreamPlayer2D.stream = song
	$AudioStreamPlayer2D.play()
	
	$Timer.wait_time = 1
	$Timer.start()
	
func _process(delta: float) -> void:
	if time_count >= time:
		win()
	
	if(delay_index >= delay):
		update_game()
		delay_index -= delay
	else:
		delay_index += delta
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
		
	set_player()
	
	if (Input.is_action_just_pressed("Right")):
		current_offset += 2
		if (current_offset >= sides * 2):
			current_offset = 1
		player_rotation = (180/sides) * current_offset
	else: if (Input.is_action_just_pressed("Left")):
		current_offset -= 2
		if (current_offset <= 0):
			current_offset = int((sides * 2) - 1)
		player_rotation = (180/sides) * current_offset
	
func change_sides(amount):
	sides = amount
	player_rotation = (180/sides) * current_offset
	if (current_offset >= sides * 2):
			current_offset = 1
	if (current_offset <= 0):
			current_offset = int((sides * 2) - 1)
	poly.queue_free()
	create_shape(sides)
	
func set_player():
	player_x = Global.screen_center_x + shape_radius * cos(deg_to_rad(player_rotation))
	player_y = Global.screen_center_y + shape_radius * sin(deg_to_rad(player_rotation))
	player.position = Vector2(player_x, player_y)

func update_game():
	for i in range(level_map.size()):
		if(map_index < level_map[i].size()):
			if(typeof(level_map[i][map_index]) == TYPE_FLOAT):
				var new_obstacle = preloaded_obstacle.instantiate()
				add_child(new_obstacle)
				new_obstacle.create_obstacle(i, sides, 50, 400, obstacle_speed)
	
	if(map_index < side_map.size() && typeof(side_map[map_index]) == TYPE_FLOAT):
		change_sides(side_map[map_index])
			
	map_index += 1

func create_shape(vertices_amount):
	poly = Polygon2D.new()
	var vertices = PackedVector2Array()
	for i in range(vertices_amount):
		var angle = (i * 2 * PI) / vertices_amount
		var x = shape_radius * cos(angle)
		var y = shape_radius * sin(angle)
		vertices.append(Vector2(x, y))
		
	poly.set_polygon(vertices)
	poly.color = Color(1, 1, 1)
	poly.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	add_child(poly)	

func _on_timer_timeout():
	time_count += 1
	
func win():
	print("win")
	get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
