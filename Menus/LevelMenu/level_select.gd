extends Node2D

var levelIcons: Array = []
var levelOffset: int = 0
var levelSelection: int = 0
var canMove : bool = true
var selected: int = 0
var levelLoad = preload("res://Menus/LevelLoad/LevelLoad.tscn").instantiate()

func _ready() -> void:
	var preloadedIcon = load("res://Menus/LevelMenu/LevelIcon.tscn")
	
	for i:float in 7:
		var newIcon = preloadedIcon.instantiate()
		newIcon.position.x = 1152 * ((i - 1)/5) + 110
		newIcon.position.y = 300
		newIcon.levelId = i
		newIcon.baseId = i - 1
		newIcon.resetLevel()
		add_child(newIcon)
		levelIcons.push_back(newIcon)
	changeLevel(0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://Menus/MainMenu/main.tscn")
	
	if canMove:
		if Input.is_action_just_pressed("Left"):
			changeLevel(1)
		if Input.is_action_just_pressed("Right"):
			changeLevel(-1)
	
	if Input.is_action_just_pressed("Select"):
		get_tree().change_scene_to_file("res://Menus/LevelLoad/LevelLoad.tscn")
		levelLoad.load(Global.levels[selected].name, int(Global.levels[selected].events[0].extraData.sides))

## Changes the selected level.
## Moves position of all levels and scales up selected levels.
## Changes selected value.
## Adds or subtracts to selected.
## If selected is less than 0 the value is set to the size of the levels array in global - 1.
## If selected is greater than levels array size - 1 the value is set to 0.
## @param offset: int - used to modify values.
func changeLevel(offset):
	if !(selected > Global.levels.size() - 1) && !(selected < 0):
		selected += offset
	if selected > Global.levels.size() - 1:
		selected = 0
	if selected < 0:
		selected = Global.levels.size() - 1
	
	levelOffset += offset
	for levelIcon in levelIcons:
		levelIcon.levelId = levelIcon.baseId + levelOffset
		levelIcon.resetLevel()
		var spacing = 1152 / 5
		levelIcon.position.x += -offset * spacing
		var tween = get_tree().create_tween()
		canMove = false
		tween.tween_property(levelIcon, "position", Vector2(levelIcon.position.x + offset * spacing, levelIcon.position.y), 0.2)
		tween.tween_property(self,"canMove",true,0.01)
		if levelIcon.levelId == selected:
			levelIcon.scale = Vector2(2, 2)
		else:
			levelIcon.scale = Vector2(1, 1)
