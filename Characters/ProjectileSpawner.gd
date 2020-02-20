extends Node2D

export(String, FILE) var projectilePath

func spawn_Projectile():
	print_debug("fire bullet SHOOOT")	
	var s = ResourceLoader.load(projectilePath)
	var newProjectile = s.instance()
	newProjectile.position = position
	get_tree().get_root().add_child(newProjectile)


func _on_Timer_timeout():
	print_debug("fire bullet timer")
	spawn_Projectile()
	
	
	


func _on_VisibilityNotifier2D_screen_entered():
	$Timer.start()
	$TimerCameraShake.start()

func _on_VisibilityNotifier2D_screen_exited():
	$Timer.stop()
	$TimerCameraShake.stop()


func _on_TimerCameraShake_timeout():
	$AudioStreamPlayer2D.play()
	Global.shakeScreen()
