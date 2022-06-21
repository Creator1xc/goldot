#--------------------------------------------------
# Copyright Strims Studio 2022 ©
#
# Purpuse : Handles the Command
# DO NOT CHANGE UNLESS YOU KNOW WHAT TO DO!
#--------------------------------------------------
extends Node

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}
# Validate the Commands listed here...
const valid_command = [
	["set_speed",
		[ARG_FLOAT]],
	["engine",
		[ARG_STRING]],
	["map",
		[ARG_STRING]],
	["sv_cheats",
		[ARG_INT]],
	["root_map",
		[ARG_STRING]]
]

# Here you can add your own commands here...
# Dont forget to add it in the "valid_command"

func set_speed(speed):
	return "Success!"
	
func engine(command):
	if command == "exit":
		get_tree().quit()
	elif command == "restart":
		get_tree().reload_current_scene()
	else:
		return str("Error: ", command, " is not a valid engine command")
	
func map(map):
	var map_dir = "user://maps/"
	var dir = Directory.new()
	if !dir.dir_exists(map_dir):
		dir.make_dir_recursive(map_dir)
	
	var file = File.new()
	if file.file_exists(map_dir + map + ".tscn"):
		get_tree().change_scene_to(load(map_dir + map + ".tscn"))
	else:
		return str("Error: ", map, " not found in User Directory. For Packed Maps try <root_map> instead!")

func sv_cheats(number):
	return "WHY??"
	
func root_map(root_map):
	var dir = "root://maps/"
	var file = File.new()
	if file.file_exists(dir + root_map + ".tscn"):
		get_tree().change_scene_to(load(dir + root_map + ".tscn"))
	else:
		return str("Error: Root Map ", root_map, " has not found. For Custom Maps try <map> instead!")
