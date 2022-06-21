extends Skeleton

onready var collision = $Collision

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	for body in collision.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.suit_pickup()
			body.show_hud()
			body.got_suit = true
			queue_free()
			
