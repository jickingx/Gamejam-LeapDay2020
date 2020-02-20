extends Area2D

export(String, FILE) var next_scene

func _on_Door01_body_entered(body):
	if body.is_in_group("player"):
		Global.shakeScreen()
		$Timer.start()


func _on_Timer_timeout():
	Global.goto_scene(next_scene)
