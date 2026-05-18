extends Node2D

var is_alive: bool = true

func _draw() -> void:
	draw_circle(Vector2(0, 0), 10, Color.WHITE)

func _ready() -> void:
	queue_redraw()
	
func die():
	is_alive = false

func _on_area_2d_area_entered(_area: Area2D) -> void:
	call_deferred("die")
