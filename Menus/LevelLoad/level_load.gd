extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")

func load(levelName, shapeSides):
	print(levelName)
	print(shapeSides)
