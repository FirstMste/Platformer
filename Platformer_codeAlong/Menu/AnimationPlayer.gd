extends AnimationPlayer

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		playback_speed = 4
