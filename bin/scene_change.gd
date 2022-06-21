extends Control

var loader
var loading_status
var root
var current_scene
var loadeded_map
var save_file

onready var progress_bar = $ProcessBar
var level_adresses = {
	"startmap": "res://maps/test.tscn",
	"save": "user://saves/save0.tscn"
}

func _ready():
	visible = false
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	
func load_map(map):
	
	progress_bar.value = 0
	current_scene = root.get_child(root.get_child_count()-1)
	current_scene.queue_free()
	loader = ResourceLoader.load_interactive(level_adresses[map])

	print(loader)
	
	if loader == null:
		get_tree().change_scene_to(load("res://bin/vgui/error_open_file.tscn"))
		return
	visible = true
	yield(get_tree().create_timer(0.4), "timeout")
	set_process(true)
	
	loadeded_map = map
	print(loadeded_map)
	
	
	
func _process(delta):
	
	if loader == null:
		set_process(false)
		
		return
	loading_status = loader.poll()
	if loading_status == ERR_FILE_EOF:
		var loaded_map = loader.get_resource()
		yield(get_tree().create_timer(0.4), "timeout")
		visible = false
		loader = null
		progress_bar.value = 100
		start_map(loaded_map, loadeded_map)
		
	elif loading_status == OK:
		update_progress()
		
	else:
		print("Critical Error")
		get_tree().change_scene_to(load("res://bin/vgui/error_open_file.tscn"))
		
func update_progress():
	var progress = float(loader.get_stage())/loader.get_stage_count()
	progress_bar.value = progress * 100

func start_map(loaded_map, level_adress):
	#why load and add as child, there is much easier than this...
	#current_scene = loaded_map.instance()
	#root.add_child(current_scene)
	print("loaded", level_adress)
	
	get_tree().change_scene_to(load(level_adresses[loadeded_map]))
	

	
	
