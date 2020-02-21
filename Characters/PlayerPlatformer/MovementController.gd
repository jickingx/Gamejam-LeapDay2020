extends Node2D

# BASED ON GODOT PLATFORMER
# WILL CONTROL KINEMATIC BODY FROM HERE.

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 480
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2

var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false
var shoot_time=99999 #time since last shot

var anim=""

var player_body : KinematicBody2D = null  


func _ready():
	var parent = get_parent()
	
	# GUARD CODE
	if not parent is KinematicBody2D :
		player_body = get_parent()
	
	# SET VARs
	player_body = parent
	
