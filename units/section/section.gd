extends Button

func _on_Section_pressed():
	_set_menu(!$Option_1.visible)

func _on_Option_pressed():
	print("option was pressed")
	_set_menu(false)
	
# check for outside click events
# and close the options
func _unhandled_input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var evLocal = make_input_local(event)
	#	var left = rect_size.
		if !Rect2(Vector2(0,0),rect_size).has_point(evLocal.position):
			_set_menu(false)


func _on_Option_Balloon_pressed():
	var balloon_scene = load("res://units/balloon/balloon.tscn")
	var instance = balloon_scene.instance()
	instance.position.x = 32 + 10
	instance.position.y = 0
	get_parent().add_child(instance)
	_set_menu(false)
	self.visible = false
	
func _set_menu(is_open):
	$Option_1.visible = is_open
	$Option_2.visible = is_open
	$Option_Balloon.visible = is_open
