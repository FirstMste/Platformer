extends Area2D


func _on_HitBox_body_entered(body):
	if body is Player:
		get_parent().get_parent().get_parent().Respawn()
