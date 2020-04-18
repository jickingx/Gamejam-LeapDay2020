extends Camera2D

var hasActivated: bool = false
var boss = null

func _ready():
	#print_debug(get_tree().get_current_scene().get_tree())
	var bosses = get_tree().get_current_scene().get_tree().get_nodes_in_group("boss")
	if bosses.size() > -1 :
		boss = bosses[0]

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && body.has_method("camera_off") && not hasActivated:
		hasActivated = true
		body.camera_off()
		current = true
		print_debug("cameraboss fight activated")
		#enable boss
		if boss != null && boss.has_method("start_moving") :
			$Timer.start()


func _on_Timer_timeout():
	boss.start_moving()
