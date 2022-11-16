extends Area2D

export(bool) var Dropthrough = false

onready var collision = $StaticBody2D/CollisionShape2D

func _ready():
	if Dropthrough:
		collision.set_deferred("disabled", true)


func _on_Water_body_entered(body):
	if body is Player:
		if !body.blue:
			get_parent().get_parent().Respawn()
