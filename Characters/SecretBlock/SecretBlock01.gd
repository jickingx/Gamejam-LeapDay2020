extends Node2D

var hitCount : int = 0

#func _ready():
#	if Global.hasUnlockedSecret01:
#		print_debug('unlocked secret block')
#	else:
#		print_debug('locked secret block')
#		$Sprite.visible = false
#		$KinematicBody2D/CollisionShape2D.disabled = true
#
#func _on_Area2D_body_entered(body):
#	if body.is_in_group("player"):
#		print_debug('play hit sound')
#		hitCount = hitCount + 1
#
#		if hitCount > 2 :
#			$Sprite.visible = true
#			#$Area2D/CollisionShape2D.disabled = true
#			$KinematicBody2D/CollisionShape2D.disabled = false
#			print_debug('locked secret block')
