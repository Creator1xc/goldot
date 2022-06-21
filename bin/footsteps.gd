extends Spatial

onready var concrete1 = $concrete/concrete1
onready var concrete2 = $concrete/concrete2
onready var concrete3 = $concrete/concrete3
onready var concrete4 = $concrete/concrete4
onready var footstep_timer = $footstep_interval
export var footstep_interal = 0.3
var generator = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func play_footsteps():
	
	var random = generator.randi_range(1, 4)
	if footstep_timer.time_left <= 0:
		if random == 1:
			concrete1.play()
		elif random == 2:
			concrete2.play()
		elif random == 3:
			concrete3.play()
		elif random == 4:
			concrete4.play()
		footstep_timer.start(footstep_interal)
