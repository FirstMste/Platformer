extends Node2D

class_name Coin
onready var animate = $AnimationPlayer
var colected = false

func _on_coin_body_entered(body):
	if body is Player and !colected:
		body.coins += 1
		colected = true
		animate.play("collected")
