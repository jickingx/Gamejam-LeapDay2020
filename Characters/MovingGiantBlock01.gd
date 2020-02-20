extends StaticBody2D

# THIS BLOCK MOVES UP
# NOTE: CANT MOVE THIS UP VIA PHYSICS COZ MOVE_AND_SLIDE()
# WILL STOP WHEN PLAYER IS ON TOP
# SO WILL USE POSITION MUTATION INSTEAD (SIMPLEST)
# MOVE PATHS WILL ALSO DO

export (int) var SPEED : int = 20
export (bool) var IS_ENABLED : bool = false

func _process(delta):
	if IS_ENABLED :
		move_local_y(- SPEED * delta)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		# NOTE OF THIS FIX, REQUIRES SETTING TO DEFFERED 
		# WHEN ENABLE/DISABLE COLLISION
		$CollisionShape2DBlocker.set_deferred("disabled", false)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		call_deferred("shake")
		set_deferred("IS_ENABLED", true)


func shake():
	Global.shakeScreen()
	$AudioStreamPlayer2D.play()
