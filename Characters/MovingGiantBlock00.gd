extends KinematicBody2D

#THIS BLOCK MOVES DOWN

export (int) var SPEED : int = 20
export (bool) var IS_ENABLED : bool = false

var velocity : Vector2 = Vector2()
var has_hit_floor:bool = false

func _physics_process(delta):
	if IS_ENABLED and not is_on_floor():
		velocity.y += 1
		velocity = velocity.normalized() * SPEED
		move_and_slide(velocity, Vector2.UP)
	
	if IS_ENABLED and is_on_floor() and not has_hit_floor:
		has_hit_floor = true
		shake()

func shake():
	Global.shakeScreen()
	$AudioStreamPlayer2D.play()

func _on_Timer_timeout():
	IS_ENABLED = true
	shake()


func _on_VisibilityNotifier2D_screen_entered():
	$Timer.start()
