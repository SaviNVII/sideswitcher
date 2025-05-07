extends Node

var levels: Array = []

func _ready() -> void:
	var dir = DirAccess.open("res://Levels")
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if dir.current_is_dir():
				loadSong("res://Levels/"+fileName)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	print(levels)
func loadSong(dir):
	var file = dir + "/data.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		levels.push_front(json_as_dict)
