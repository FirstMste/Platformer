extends Node2D

onready var Anim = $AnimationPlayer

func _ready():
	get_tree().paused = false
	VisualServer.set_default_clear_color(Color("#00FFFF"))




func _on_Button_pressed():
	var _Current
	_Current = get_tree().change_scene("res://World.tscn")


func _on_Quit_pressed():
	get_tree().quit()

