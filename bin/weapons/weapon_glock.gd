extends Skeleton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in $hitbox.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.sound_pickup()
			queue_free()
			body.got_glock = true
			body.got_any_weapons = true
			body.current_weapon = 3
