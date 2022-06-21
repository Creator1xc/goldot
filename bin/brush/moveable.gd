extends Node



export var move_speed : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func open_door():
	
	print("we moved our door")
	$AnimationPlayer.playback_speed = move_speed
	$AnimationPlayer.play("door_move")
