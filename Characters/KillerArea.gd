extends Area2D

export(String, FILE) var next_scene_when_player_is_killed

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print_debug("BODY hit : " + body.get_class())
	if body.is_in_group("player") && body.has_method("die"):
		body.die()
