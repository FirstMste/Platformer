extends KinematicBody2D


onready var sprite = $AnimatedSprite
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO



func _physics_process(_delta):
	
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1
	
	sprite.flip_h = direction.x > 0
	velocity = direction * 25
	
	velocity = move_and_slide(velocity,Vector2.UP)
