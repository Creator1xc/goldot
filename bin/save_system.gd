extends Node


const save_dir = "user://saves/"

onready var save_scene = save_dir + "save0.tscn"

func save():
	
	
	var dir = Directory.new()
	if !dir.dir_exists(save_dir):
		dir.make_dir_recursive(save_dir)
		
	var packed_scene = PackedScene.new()
	ResourceSaver.get_recognized_extensions(packed_scene)
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save(save_scene, packed_scene)
	
func load_file():
	var file = File.new()
	if file.file_exists(save_scene):
		Loading.load_map("save")
