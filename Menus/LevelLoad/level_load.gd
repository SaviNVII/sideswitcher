extends Node2D

func _ready() -> void:
	var name = Global.levels[Global.selected].name
	var bpm = Global.levels[Global.selected].bpm
	var events = Global.levels[Global.selected].events
	
	print("name: %s bpm: %s events: %s" %[name, bpm, events])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
