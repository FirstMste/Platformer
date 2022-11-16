extends CanvasLayer


var is_paused = false


func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		if is_paused == true:
			is_paused = false
			get_tree().paused = false
			hide()
		else:
			is_paused = true
			get_tree().paused = true
			show()
			


func _on_ToMenu_pressed():
	var _Current
	_Current = get_tree().change_scene("res://Menu/MaineMenu.tscn")


func _on_RESUME_pressed():
	is_paused = false
	get_tree().paused = false
	hide()
