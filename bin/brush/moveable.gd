extends Node


export var move_sound : AudioStream
export var stop_sound : AudioStream
export var move_speed : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KinematicBody/move.stream = move_sound
	$KinematicBody/stop.stream = stop_sound


func open_door():
	if !$AnimationPlayer.is_playing():
		
		print("we moved our door")
		$AnimationPlayer.playback_speed = move_speed
		$AnimationPlayer.play("door_move")
		$KinematicBody/move.play()
		yield(get_tree().create_timer(move_speed), "timeout")
		$KinematicBody/stop.play()
		$KinematicBody/move.stop()

	


