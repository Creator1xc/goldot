extends KinematicBody


# Declare member variables here. Examples:
# var a: int = 2


onready var main = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func damage(amount: int):
	main.health -= amount
	
