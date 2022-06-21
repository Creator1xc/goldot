extends Node

class_name interactable

func get_interaction_text():
	return "Interact"

func interact():
	print("Interated with %s" % name)
