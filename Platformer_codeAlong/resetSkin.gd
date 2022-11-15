extends Area2D

var reset = preload("res://SKINS/GreenSkin.tres")


func _on_resetSkin_body_entered(body):
	if body is Player:
		if body.starting_skin_on == false:
			body.starting_skin_on = true
			body.animator.play("Change")
			body.newSkin = reset
			body.blue = false
			body.green = true
