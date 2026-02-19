extends Node2D

func _ready() -> void:
	$Node2D.position = Vector2(Global.screen_center_x, Global.screen_center_y)
	
	$Node2D2.position = Vector2(Global.screen_center_x, Global.screen_center_y)
