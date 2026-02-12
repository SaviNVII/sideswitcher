extends Node2D

func _draw() -> void:
	draw_circle(Vector2(0, 0), 10, Color.WHITE)

func _ready() -> void:
	queue_redraw()
	
func die():
	get_tree().change_scene_to_file("res://Menus/LevelMenu/LevelSelect.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	call_deferred("die")
