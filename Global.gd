extends Node

#scenes
var current_scene = null

#scene transition
var screen_overlay = null

#dialogue
const DIALOGUEBOX_NAME = "DialogueBox"
var json_path = "res://simple-dialogue-box-data.json"
var data = {}
var player = null
var dialoguebox = null

#player states
const PLAYER_NAME = "Player"
var hasUnlockedLevel00 : bool = false
var block00_position = null

var hasUnlockedSecret01 : bool = false #death on specific location
var hasUnlockedSecret02 : bool = false #hit invisible box 7x


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print_debug("current scene: " + current_scene.name)
	#set up 
	load_json_data()
	setup_simple_dialogue()
	setup_fade_transition()

#CALL THIS WHEN SCENE SWITCHING
func goto_scene(path):
	#fade_out_transition()
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	load_json_data()
	setup_simple_dialogue()
	setup_fade_transition()
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	
	# Instance the new scene.
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	#get_tree().set_current_scene(current_scene)
	#add dialogue to scene
	setup_simple_dialogue()
	#add fade transition to scene
	setup_fade_transition()

func setup_fade_transition():
	#INTANTIATE 
	var screen_overlay_path = load("res://UI/SCREEN_OVERLAY.tscn")
	var so = screen_overlay_path.instance()
	so.set_name("screen_overlay")
	current_scene.add_child(so)
	screen_overlay = so

func fade_out_transition() -> void:
	if screen_overlay != null :
		screen_overlay.fade_out()

func setup_simple_dialogue() -> void:
	#Check if player in scene then add dialogue manager
	#todo: refactor to get player based on group
	#todo: refactor move to player setup method
	if current_scene.get_node(PLAYER_NAME) == null:
		print_debug("No player")
		player = null
		dialoguebox = null
		return
	
	print_debug("Has player")
	player = current_scene.get_node(PLAYER_NAME)
	player.connect("dead", self, "_on_Player_dead")
	
	
	#INTANTIATE DIALOGUEBOX
	var dbox_path = load("res://UI/DialogueBox/DialogueBox.tscn")
	var dbox = dbox_path.instance()
	dbox.hide()
	dbox.set_name(DIALOGUEBOX_NAME)
	current_scene.add_child(dbox)
	
	dialoguebox = current_scene.get_node(DIALOGUEBOX_NAME)

	#ATTACH SIGNALS
	dialoguebox.connect("closed", self, "_on_DialogueBox_closed")

func _on_Player_dead():
	print_debug('killed player')
	goto_scene("res://Scenes/Level00.tscn")

#CALLED BY NPCs
func show_simple_dialogue(npc_name):
	if player.has_method("disable"):
		player.disable()
	
	var text = data[npc_name]
	dialoguebox.dialogue_text = text
	dialoguebox._ready()
	dialoguebox.show()

func _on_DialogueBox_closed():
	if player.has_method("enable"):
		player.enable()


func load_json_data():
	#READ JSON
	var data_file = File.new()
	if data_file.open(json_path, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	#print_debug(data["1"].name) #FOR JSON FORMAT WITH {"key":{"id":"value"}}
	#print_debug(data["NpcNameHere"])
	data = data_parse.result

#mutate player state
func kill_player_then_restart_scene(killer_name: String, path):
	print_debug('kill player')
	
	if player == null:
		return
	
	if player.has_method("die") :
		player.die()
	
	print_debug('killed player')
	goto_scene(path)

func shakeScreen():
	if player == null :
		return
	if !player.has_node("Camera2D") :
		return
	if !player.get_node("Camera2D").has_method("shake"):
		return
	player.get_node("Camera2D").shake()
	print_debug("shake shake")

