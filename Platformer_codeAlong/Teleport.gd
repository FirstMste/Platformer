extends Area2D

export(Vector2) var Teleport_Position


func _on_Teleport_body_entered(body):
	if body is Player:
		body.global_position = Teleport_Position
