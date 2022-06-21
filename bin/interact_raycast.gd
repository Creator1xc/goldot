extends RayCast


var current_collider

func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is interactable:
		print("got interactable!")
		if current_collider != collider:
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			
	elif current_collider:
		current_collider = null
		print("got not interactable!")
