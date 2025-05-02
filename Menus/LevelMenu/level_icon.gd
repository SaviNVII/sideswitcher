extends Node2D

var levelId: int = 0
var baseId: int = 0

func resetLevel():
	while levelId < 0:
		levelId += Global.levels.size()
	while levelId >= Global.levels.size():
		levelId -= Global.levels.size()
	var newLevel = Global.levels[levelId]
	$Label.text = newLevel.name
