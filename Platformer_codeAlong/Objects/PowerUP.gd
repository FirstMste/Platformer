extends Area2D

var player

onready var timout = $Timer
onready var timeLAB = $Time

export(bool) var Should_Respawn = false
export(float) var time_respawn_time = float(7.0)

func _ready():
	player = get_parent().get_parent().get_node("Player")
	timout.wait_time = time_respawn_time
	timeLAB.text = str(time_respawn_time)

func _on_PowerUp_body_entered(body):
	if body is Player:
		$CollisionShape2D.set_deferred("disabled",true)
		player.JUMPPOWERUP = true
		timout.start()
		hide()


func _on_Timer_timeout():
	if Should_Respawn:
		$CollisionShape2D.set_deferred("disabled",false)
		show()
	else:
		queue_free()
	player.JUMPPOWERUP = false
