extends StaticBody

signal use_function()
func use():
	emit_signal("use_function")
