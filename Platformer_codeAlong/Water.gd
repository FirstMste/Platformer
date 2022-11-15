extends Area2D


func _on_Water_body_entered(body):
	if body is Player:
		if !body.blue:
			get_parent().get_parent().Respawn()
