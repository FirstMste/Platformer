extends Area2D

var Blue = preload("res://SKINS/blueSkin.tres")


func _on_ChangeSkinBlue_body_entered(body):
	if body is Player:
		if body.starting_skin_on:
			body.animator.play("Change")
			body.starting_skin_on = false
			body.blue = true
			body.green = false
		
		body.newSkin = Blue
