extends Skeleton

export var health = 100
export var is_dead = false

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_dead == true:
		#$anims.play("diesimple")
		#$main.scale = Vector3(1, 1, 0)
		#$main.translation = Vector3(0, 0, -1)
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
func _process(delta: float) -> void:
	if health <= 0 and is_dead == false:
		$anims.play("diesimple")
		is_dead = true
		$main.scale = Vector3(1, 1, 0)
		$main.translation = Vector3(0, 0, -1)
		yield(get_tree().create_timer(2), "timeout")
		$main.queue_free()
		
