extends KinematicBody2D

class_name Player

var velocity = Vector2.ZERO

export(int) var JUMP_FORCE = -130
export(int) var JUMPBOOST = -2
export(int) var MAX_JUMPBOOST = -350
export(int) var JUMP_RELEASE_FORCE = -5
export(int) var WALL_JUMP = 100
export(int) var MAX_SPEED = 50
export(int) var SprintBoost = 2 
export(int) var MAXSPRINTSPEED = 100
export(int) var ACCELERATION = 10
export(int) var FRICTION = 10
export(int) var GRAVITY = 4
export(int) var FALL_GRAVITY = 4
export(int) var MAX_WALL_JUMPS = 3


onready var sprite = $AnimatedSprite
onready var coinsLab = $CanvasLayer/coins
onready var animator = $AnimationPlayer
onready var Stars = $Stars
onready var PauseMENU = $PauseMenu

#Default Values
var newSkin
var changed = false
var coins = 0
var startingSkin
var starting_skin_on = true
var speedreset
var JumpForceReset
var JUMPPOWERUP = false
var Reset_Max_Wall_Jumps
var resetGravity
var resetFALLGRAVITY
var is_paused = false

#Player States
var blue = false
var green = true
var state = SHOWLEVEL
var Changing = false

enum {
	MOVE
	
	CHANGE
	
	SHOWLEVEL
}

func _ready():
	resetFALLGRAVITY = FALL_GRAVITY
	resetGravity = GRAVITY
	speedreset = MAX_SPEED
	JumpForceReset = JUMP_FORCE
	startingSkin = sprite.frames
	Reset_Max_Wall_Jumps = MAX_WALL_JUMPS


func _physics_process(_delta):
	
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left","ui_right")
	
	coinsLab.text = str(coins)
	
	match state:
		MOVE: Move(input)
		CHANGE: change()
		SHOWLEVEL: _SHOWLEVEL()
		
func Apply_friction():
	velocity.x = move_toward(velocity.x,0, FRICTION)

func Apply_accel(amount):
	velocity.x = move_toward(velocity.x,MAX_SPEED * amount, ACCELERATION)

func apply_gravity():
	velocity.y += GRAVITY


func Move(input):
	if Changing  == true:
		state = CHANGE
	if input.x == 0:
		Apply_friction()
		sprite.animation = "Idle"
	else:
		MAX_SPEED = clamp(MAX_SPEED,0, MAXSPRINTSPEED)
		JUMP_FORCE = clamp(JUMP_FORCE,MAX_JUMPBOOST,JumpForceReset)
		sprite.animation = "Run"
		Apply_accel(input.x)
		sprite.flip_h = input.x > 0
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		sprite.animation = "Jump"
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE and not JUMP_FORCE < JumpForceReset:
			velocity.y = JUMP_RELEASE_FORCE
		
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY
			velocity.y = min(velocity.y, 300)
		
	
	if is_on_wall() and not is_on_floor():
		if Input.is_action_just_pressed("ui_up") and MAX_WALL_JUMPS > 0:
			velocity.x = input.x * -1 * WALL_JUMP
			velocity.y = JUMP_FORCE 
			MAX_WALL_JUMPS -= 1
	
	
	if JUMPPOWERUP and Input.is_action_pressed("Sprint"):
		if input.x != 0 and not is_on_floor() or not is_on_wall():
			MAX_SPEED += SprintBoost
			JUMP_FORCE += JUMPBOOST
	else:
		MAX_SPEED = speedreset
		JUMP_FORCE = JumpForceReset
	
	
	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity,Vector2.UP)
	var just_laned = is_on_floor() and was_in_air
	if just_laned:
		MAX_WALL_JUMPS = Reset_Max_Wall_Jumps
		sprite.animation = "Run"
		sprite.frame = 1

func change():
	if is_on_floor():
		sprite.animation = "Idle"
	else:
		sprite.animation = "Jump"
	Apply_friction()
	apply_gravity()
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Change":
		sprite.frames = newSkin
		animator.play("visible")
	if anim_name == "visible":
		state = MOVE
		Changing = false
	if anim_name == "CameraSpeed":
		$Camera2D.smoothing_speed = 4.5
		state = MOVE
func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Change":
		Changing = true

func _SHOWLEVEL():
	apply_gravity()
	velocity = move_and_slide(velocity,Vector2.UP)
