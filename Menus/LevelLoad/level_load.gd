extends Node2D

func _ready() -> void:
	print("In LevelLoad")
	print(Global.selected)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")
