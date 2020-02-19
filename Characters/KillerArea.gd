extends Area2D

export(String, FILE) var next_scene_when_player_is_killed

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print_debug("BODY hit")
	if body.is_in_group("player"):
		print_debug("player hit")
		Global.kill_player_then_restart_scene('', next_scene_when_player_is_killed)
		print_debug("player dead")
