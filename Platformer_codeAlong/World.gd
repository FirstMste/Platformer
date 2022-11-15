extends Node2D

onready var player = $Player
export(int) var FALLDEATH = 1000
export(int) var SIDEDEATH = -15
export(bool) var PLAYER_MOVING_LEFT = true
var DEFAULTSKIN = preload("res://SKINS/GreenSkin.tres")

enum BackDrop {CLEAR,DAWN,MIDNIGHT}

export(BackDrop) var BackGround
export var PlayerStart = Vector2(0,0)

var startPostion = Vector2(0,0)

func _ready():
	player.global_position = PlayerStart
	player.sprite.frames = DEFAULTSKIN
	startPostion = player.global_position
	
	match BackGround:
		BackDrop.CLEAR: VisualServer.set_default_clear_color(Color("#00FFFF"))
		
		BackDrop.DAWN: VisualServer.set_default_clear_color(Color("#FFA500"))
		
		BackDrop.MIDNIGHT: 
			VisualServer.set_default_clear_color(Color("#000000"))
			player.Stars.emitting = true
	

func _physics_process(_delta):
	
	
	_FALLOFFSAFTEY()

func Respawn():
	player.sprite.frames = DEFAULTSKIN
	player.position = startPostion




func _FALLOFFSAFTEY():
	
	if player.global_position.y > FALLDEATH:
		Respawn()
	
	if PLAYER_MOVING_LEFT:
		if player.global_position.x < SIDEDEATH:
			Respawn()
	else:
		if player.global_position.x > SIDEDEATH:
			Respawn()


func Change_Level(NEXTLEVEL):
	get_tree().change_scene_to(NEXTLEVEL)
