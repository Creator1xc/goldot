#--------------------------------------------------
# Copyright Strims Studio 2022 ©
#
# Purpuse : Pause menu stuff for the Game.
#--------------------------------------------------
extends Control

var map = "startmap"
onready var rollover_sound = $rollover
onready var pressed_sound = $pressed
var is_paused = false setget set_is_paused


func play_rollover_sound(): # Why...

	rollover_sound.play()

func play_pressed_sound(): # This is useless...

	pressed_sound.play()

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		self.is_paused = !is_paused
		if is_paused == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
			
			

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_resume_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	play_pressed_sound()



func _on_save_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#var packed_scene = PackedScene.new()
	#ResourceSaver.get_recognized_extensions(packed_scene)
	#packed_scene.pack(get_tree().get_current_scene())
	#ResourceSaver.save("user://save/save_scene.tscn", packed_scene)
	SaveSystem.save() #Save the File...
	
	print(OS.get_user_data_dir()) # Replace with function body.


func _on_load_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#get_tree().change_scene_to(load("res://bin/save_scene.tscn"))
		#current_scene = loaded_map.instance()
	#root.add_child(current_scene)
	#Loading.load_map("save")
	SaveSystem.load_file() #Load the File...


func _on_quit_game_pressed():
	get_tree().quit() # Replace with function body.


func _on_new_game_pressed():
	#get_tree().change_scene_to(load(map)) # Replace with function body.
	Loading.load_map(map) #Load the Map

# Adding Sound Effects...
func _on_resume_focus_entered():
	play_rollover_sound()


func _on_load_focus_entered():
	play_rollover_sound()


func _on_save_focus_entered():
	play_rollover_sound()
