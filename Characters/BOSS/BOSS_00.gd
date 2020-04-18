extends Area2D

var speed : int = 100
var sprite_width : int = 2

export (bool) var is_active : bool = false
export (bool) var is_facing_right = true
export (int) var MAX_DISTANCE : int = 320

func _ready():
	sprite_width = 32 #$AnimatedSprite.frames.get_frame("idle",0).get_size().x / 2

func _process(delta):
	if is_active :
		#print_debug(position.x)
		
		if (position.x >= MAX_DISTANCE - sprite_width):
			is_active = false
		if (position.x < 0):
			is_active = false
			
		#SET MOVE FACE AND ANIM
		if is_facing_right:
			move_local_x(speed * delta)
		else:
			move_local_x(- speed * delta)
		

func start_moving() :
	is_active = true
