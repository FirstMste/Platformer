extends Area2D

export(PackedScene) var NEXTLEVEL 



func _on_GOAL_body_entered(body):
	if body is Player:
		if NEXTLEVEL == null:
			var MAINMENU = load("res://Menu/MaineMenu.tscn")
			get_parent().Change_Level(MAINMENU)
		else:
			get_parent().Change_Level(NEXTLEVEL)
