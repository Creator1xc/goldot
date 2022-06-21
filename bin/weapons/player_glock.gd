extends Skeleton
onready var anims = $anims
onready var shoot = $shoot
onready var cooldown = $cooldown
var is_reloading : bool
var ammo = 16

func reload(seconds, set_ammo):
	is_reloading = true
	print(is_reloading)
	yield(get_tree().create_timer(seconds), "timeout")
	ammo = set_ammo
	is_reloading = false

func main(raycast: RayCast):
	if Input.is_action_pressed("fire"):
		
		if ammo > 0:
			if is_reloading == false:
				if cooldown.time_left <= 0:
					anims.stop()
					ammo -= 1
					shoot.play()
					cooldown.start(0.35)
					anims.play("shoot")

			
	if Input.is_action_pressed("second_fire"):
		if ammo > 0:
			if is_reloading == false:
				if cooldown.time_left <= 0:
					anims.stop()
					ammo -= 1
					shoot.play()
					cooldown.start(0.2)
					anims.play("shoot")

	
	if Input.is_action_just_pressed("reload"):
		if not ammo >= 16:
			
			anims.play("reload")
			anims.queue("idle3")
			reload(2.3, 16)
