extends KinematicBody

export var speed = 20
var h_accerlation = 6
var alf_accelaeration = 1
var normal_acceleration = 6
var gravity = 30
var jump = 10
var full_contact = false



var mouse_senstitvity = 0.3


var direction = Vector3()
export var h_velocity = Vector3()
var movement = Vector3()
var gravtiy_vec = Vector3()

export var current_weapon = 1

onready var head = $Head
onready var groundcheck = $Groundcheck
onready var camera = $Head/Camera
onready var viemodel_camera = $Head/Camera/ViewportContainer/Viewport/Viewmodel_Camera
onready var crowbar = $Head/view/v_crowbar
onready var glock = $Head/view/v_9mmhandgun
onready var selection_audio = $selection
onready var flashlight = $Head/flashlight
#onready var audio = $AudioStreamPlayer3D

onready var meele_hitbox = $Head/Camera/melee_hitbox
onready var crowbar_animation = $Head/view/v_crowbar/anims

onready var aim_cast = $Head/Camera/aim_cast

onready var hud = $hud
onready var ammo_show = $hud/ammo
onready var ammo_counter = $hud/ammo/ammo_counter

onready var menu = $pause_menu

onready var use_cast = $Head/use_cast

onready var weapon_pickup_sound = $weapon_pickup
onready var health_display = $hud/health/health_count



export var flashlight_on = false

export var health = 100

#--- Weapon Register ---
export var got_crowbar = false
export var got_glock = false
export var got_any_weapons = false
#--- Suit Register ---
export var got_suit = false

#Weapon selection system
func weapon_select():
	if current_weapon == 2:

		crowbar.visible = true
		crowbar.main(meele_hitbox)
		ammo_show.visible = false
		
		
	else:
		crowbar.visible = false
		
	if current_weapon == 3:
		glock.visible = true
		glock.main(aim_cast)
		ammo_counter.text = str(glock.ammo)
		ammo_show.visible = true
	else:
		glock.visible = false
func weapon_check_up():
	# Check if we got the crowbar...
	if got_crowbar == false and current_weapon == 2:
		current_weapon = 3
	else:
		pass
	if got_glock == false and current_weapon == 3:
		current_weapon = 2
	else:
		pass
		
func weapon_check_down():
	if got_crowbar == false and current_weapon == 2:
		current_weapon = 3
	else:
		pass
	if got_glock == false and current_weapon == 3:
		current_weapon = 2
	else:
		pass


func sound_pickup():
	weapon_pickup_sound.play()
	
func suit_pickup():
	$suit_pickup.play()
	
func show_hud():
	$hud.visible = true

#Player Inputs
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if got_suit == true:
		$hud.visible = true
	

func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_senstitvity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_senstitvity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if got_any_weapons == true and got_suit == true:
					
					if current_weapon < 3:
						current_weapon += 1
						weapon_check_up()
					
					else:
						current_weapon = 2
						weapon_check_up()
					selection_audio.play()
					print(current_weapon)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				if got_any_weapons == true and got_suit == true:
					
					if current_weapon > 2:
						current_weapon -= 1
						weapon_check_down()
					else:
						current_weapon = 3
						weapon_check_down()
					
					selection_audio.play()
					print(current_weapon)
		
		




func _process(delta):
	viemodel_camera.global_transform = camera.global_transform
	
	
func play_footstep():
	if full_contact == true:
		
		$footsteps.play_footsteps()
			


func _physics_process(delta):
	weapon_select()
	direction = Vector3()
	
	
	health_display.text = str(health)
	
	if groundcheck.is_colliding():
		full_contact = true
	else:
		full_contact = false
	
	if not is_on_floor():
		gravtiy_vec += Vector3.DOWN * gravity * delta
		h_accerlation = alf_accelaeration
	elif is_on_floor() and full_contact == true:
		gravtiy_vec = -get_floor_normal()  * gravity
		h_accerlation = normal_acceleration
	else:
		gravtiy_vec = -get_floor_normal()
		h_accerlation = normal_acceleration
	if Input.is_action_just_pressed("jump") and is_on_floor():
		gravtiy_vec = Vector3.UP * jump
		$jump.play()
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
		play_footstep()
	if Input.is_action_pressed("move_backwards"):
		direction += transform.basis.z
		play_footstep()
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
		play_footstep()
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		play_footstep()
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_scene()
	if Input.is_action_just_pressed("interact"):
		if use_cast.is_colliding():
			var targed = use_cast.get_collider()
			if targed.is_in_group("Useable"):
				targed.use()
				$use.play()
			else:
				$not_use.play()
		else:
			$not_use.play()
			
	if Input.is_action_just_pressed("flashlight"):
		if flashlight_on == false:
			flashlight_on = true
			flashlight.visible = true
		elif flashlight_on == true:
			flashlight_on = false
			flashlight.visible = false
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_accerlation * delta)
	movement.z = h_velocity.z + gravtiy_vec.z
	movement.x = h_velocity.x + gravtiy_vec.x
	movement.y = gravtiy_vec.y
	
	move_and_slide(movement, Vector3.UP)
	
func save():
	var packed_scene = PackedScene.new()
	ResourceSaver.get_recognized_extensions(packed_scene)
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://bin/save_scene.tscn", packed_scene)


func load_scene():
	get_tree().change_scene_to(load("res://bin/save_scene.tscn"))
	#var packed_scene = load("res://bin/save_scene.tscn")
	#var load_scene = packed_scene.instance()
	#add_child(load_scene)
	
	


