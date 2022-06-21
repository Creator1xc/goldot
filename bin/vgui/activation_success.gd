extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$WindowDialog.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WindowDialog_popup_hide():
	$WindowDialog.popup()


func _on_Button_pressed():
	get_tree().change_scene_to(load("res://bin/menu.tscn"))
