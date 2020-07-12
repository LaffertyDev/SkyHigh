extends TextureButton

func _on_Section_pressed():
	_set_menu(!$Option_Balloon.visible)

func _on_Option_pressed():
	print("option was pressed")
	_set_menu(false)

func _process(delta):
	$Option_Balloon/NotAllowed.visible = get_tree().get_current_scene().whale_gas < 100
	
# check for outside click events
# and close the options
func _unhandled_input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var evLocal = make_input_local(event)
	#	var left = rect_size.
		if !Rect2(Vector2(0,0),rect_size).has_point(evLocal.position):
			_set_menu(false)

func _on_Option_Balloon_pressed():
	var avail_gas = get_tree().get_current_scene().whale_gas
	if avail_gas < 100:
		print("Not enough gas")

	get_tree().get_current_scene().whale_gas -= 100
	var balloon_scene = load("res://units/balloon/balloon.tscn")
	var instance = balloon_scene.instance()
	instance.position.x = 0
	instance.position.y = 25
	get_parent().add_child(instance)
	instance.connect("balloon_pop", self, "_on_Balloon_Pop")
	_set_menu(false)
	self.visible = false
	
func _on_Balloon_Pop():
	self.visible = true

func _set_menu(is_open):
	$Option_Balloon.visible = is_open
