extends Node2D

onready var Amin = $AnimationPlayer
onready var label = $Label

var showing = false
export var Text = ("")
export(int) var X_Distance = 50
export(int) var Y_Distance = 50
export(bool) var v_align_Middle = false
export(bool) var Wrap = false

var player 

func _ready():
	player = get_parent().get_parent().get_node("Player")
	label.text = Text

func _process(_delta):
	
	
	if Wrap:
		label.autowrap = true
	else:
		label.autowrap = false
	
	if v_align_Middle:
		label.align = Label.ALIGN_CENTER
		label.valign = Label.VALIGN_CENTER
	else:
		label.align = Label.ALIGN_LEFT
		label.valign = Label.VALIGN_TOP
	
	
	if  abs(global_position.x - player.global_position.x) < X_Distance and abs(global_position.y - player.global_position.y) < Y_Distance:
		if showing == false:
			Amin.play("Show")
	else:
		Amin.play("Hide")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Show":
		showing = true
	else:
		showing = false
