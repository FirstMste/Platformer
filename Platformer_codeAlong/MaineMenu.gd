extends Node2D

var NewGame = preload("res://World.tscn")
var current_level

func _ready():
	 VisualServer.set_default_clear_color(Color("#00FFFF"))




func _on_Button_pressed():
	current_level = get_tree().change_scene_to(NewGame)


func _on_Quit_pressed():
	get_tree().quit()
