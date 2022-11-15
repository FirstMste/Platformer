extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO


enum Walk_Direction{RIGHT,LEFT}


export(int) var speed = 25
export(int) var KillJump = -75
export(bool) var CanDie = false
export(Walk_Direction) var walk_direction




var Killable = preload("res://SKINS/KillableEnemy.tres")
var Dogdeable = preload("res://SKINS/DodgeEnemy.tres")

onready var edgeCheckRight = $EgdeCheckRight
onready var edgeCheckLeft = $EgdeCheckLeft
onready var sprite = $AnimatedSprite
onready var RightKillCheck = $RightKillCheck
onready var mRightKillCheck = $MRightKillCheck
onready var LeftKillCheck = $LeftKillCheck
onready var mLeftKillCheck = $MLeftKillCheck
onready var hitBox = $HitBox/CollisionShape2D


var player
var spawned = false



func _ready():
	player = get_parent().get_parent().get_node("Player")
	match walk_direction:
		Walk_Direction.RIGHT: direction = Vector2.RIGHT
		Walk_Direction.LEFT: direction = Vector2.LEFT

func _physics_process(_delta):
	
	
	if !spawned:
		if CanDie:
			spawned = true
			sprite.frames = Killable
			RightKillCheck.enabled = true
			LeftKillCheck.enabled = true
			mRightKillCheck.enabled = true
			mLeftKillCheck.enabled = true
		else:
			spawned = true
			sprite.frames = Dogdeable
			sprite.animation = "WALK"
	
	if CanDie:
		if hitBox.disabled == true:
				sprite.animation = "Death"
		else:
				sprite.animation = "Walk"
	
	var found_wall = is_on_wall()
	var founc_edge = not edgeCheckRight.is_colliding() or not edgeCheckLeft.is_colliding()
	if found_wall or founc_edge:
		direction *= -1
	
	#Check to see if anything collides above enemy
	var Top_Hit = RightKillCheck.is_colliding() or mRightKillCheck.is_colliding() or LeftKillCheck.is_colliding() or mLeftKillCheck.is_colliding()
	if Top_Hit:
		sprite.animation = "Bounce"
		direction = Vector2.ZERO
		player.velocity.y = KillJump
		player.move_and_slide(velocity, Vector2.UP)
		hitBox.disabled = true
		
	
	
	sprite.flip_h = direction.x > 0
	velocity = direction * speed
	
	velocity = move_and_slide(velocity,Vector2.UP)

