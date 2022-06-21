extends Skeleton
onready var animation = $anims
onready var hit_sound_solid = $hit_solid
onready var miss = $miss
onready var cooldown = $cooldown



func main(hitbox):
	var got_hit = false
	if Input.is_action_pressed("fire"):
		if animation.current_animation == "idle3":
			animation.stop()
			animation.play("attack2")
			animation.queue("idle3")
			cooldown.start(0.5)
			miss.play()
			
		elif animation.current_animation == "attack2" or cooldown.time_left <= 0:
			for body in hitbox.get_overlapping_bodies():
				if body.is_in_group("Entity"):
					animation.play("attack1")
					animation.queue("idle3")
				elif body.is_in_group("NPC"):
					animation.play("attack1")
					animation.queue("idle3")
					body.damage(50)
				elif body.is_in_group("World"):
					animation.stop()
					animation.play("attack1")
					hit_sound_solid.play()
					miss.stop()
					animation.queue("idle3")
					cooldown.start(0.25)
			
		

