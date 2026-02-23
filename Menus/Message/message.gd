extends Node2D

func _ready() -> void:
	$Node2D.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	
	$Node2D2.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	
	var message = Global.current_message
	$Node2D2/Label.text = message

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
