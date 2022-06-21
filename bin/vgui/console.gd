#--------------------------------------------------
# Copyright Strims Studio 2022 ©
#
# Purpuse : Reads the Command and execute it.
# DO NOT CHANGE UNLESS YOU KNOW WHAT TO DO!
#--------------------------------------------------
extends WindowDialog

onready var input_box = get_node("input")
onready var output_box = get_node("ColorRect/output")
onready var command_handler = get_node("command_handler")

# Called when the node enters the scene tree for the first time.
func _ready():
	input_box.grab_focus()
	output_text("Godot Engine v3.4.4.stable.mono.official.419e713a2 - https://godotengine.org")
	output_text("OpenGL ES 3.0 Renderer: ON")
	output_text("OpenGL ES Batching: ON")

func _process(delta):
	if Input.is_action_just_pressed("console"):
		popup()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func output_text(text):
	output_box.text = str(output_box.text, "\n", text)


func process_command(text):
	var words = text.split(" ")
	words = Array(words)
	for i in range(words.count("")):
		words.erase("")
	
	if words.size() == 0:
		return
	var command_word = words.pop_front()
	
	for c in command_handler.valid_command:
		if c[0] == command_word:
			if words.size() != c[1].size():
				
				output_text(str('Error executing command "', command_word, '", expected ', c[1].size(), ' parameters'))
				
				return
			for i in range(words.size()):
				if not check_type(words[i], c[1][i]):
					
					output_text(str('Error executing command "', command_word, '", prameter', (i+ 1),
							'("', words[i], '") is on the wrong type' ))
					
					return
			
			output_text(command_handler.callv(command_word, words))
			return
	
	output_text(str("Error: ", command_word, " doesnt exist!"))
func check_type(string, type):
	if type == command_handler.ARG_INT:
		return string.is_valid_integer()
	elif type == command_handler.ARG_FLOAT:
		return string.is_valid_float()
	elif type == command_handler.ARG_STRING:
		return true
	elif type == command_handler.ARG_BOOL:
		return (string == true or string == false)
	else:
		return false

func _on_input_text_entered(new_text):
	input_box.clear()
	process_command(new_text)
	


func _on_console_popup_hide():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
