extends Area2D

export(PackedScene) var NEXTLEVEL 




func _on_GOAL_body_entered(body):
	if body is Player:
		print("hit")
		get_parent().Change_Level(NEXTLEVEL)
