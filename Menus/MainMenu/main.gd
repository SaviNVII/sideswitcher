extends Node2D

var selection: int = 0
var children: Array

func _ready():
	children = get_children()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Up") and selection > 0:
		selection -= 1
	if Input.is_action_just_pressed("Down") and selection < children.size() - 1:
		selection += 1
	for child in children:
		if child == children[selection]: 
			if Input.is_action_just_pressed("Select"):
				child.trigger()
			child.scale.x = 2
		else: child.scale.x = 1
	children[selection].scale.x = 2
