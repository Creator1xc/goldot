#--------------------------------------------------
# Copyright Strims Studio 2022 ©
#
# Purpuse : Handle the Activation for Retail or Beta Testing.
# DO NOT CHANGE UNLESS YOU KNOW WHAT TO DO!
#--------------------------------------------------
extends Control

export var activation_key = "XXXX-XXXX-XXXX-XXXX"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$WindowDialog.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_next_pressed():
	if $WindowDialog/key_input.text == activation_key:
		get_tree().change_scene_to(load("res://bin/vgui/activation_success.tscn"))
	else:
		$WindowDialog/error.text = "The key is not valid!" # Replace with function body.





func _on_WindowDialog_popup_hide():
	$WindowDialog.popup()


func _on_key_input_text_entered(new_text):
	if $WindowDialog/key_input.text == activation_key:
		get_tree().change_scene_to(load("res://bin/vgui/activation_success.tscn"))
	else:
		$WindowDialog/error.text = "The key is not valid!" # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene_to(load("res://bin/vgui/sua_window.tscn"))
