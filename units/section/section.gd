extends TextureButton

func _on_Section_pressed():	
	if !_has_enough_gas_to_build():
		return

	get_tree().get_current_scene().whale_gas -= 100
	var balloon_scene = load("res://units/balloon/balloon.tscn")
	var instance = balloon_scene.instance()
	instance.position.x = 0
	instance.position.y = 25
	get_parent().add_child(instance)
	instance.connect("balloon_pop", self, "_on_Balloon_Pop")
	self.visible = false

func _process(delta):
	$NotAllowed.visible = !_has_enough_gas_to_build()

func _on_Balloon_Pop():
	self.visible = true

func _has_enough_gas_to_build():
	return get_tree().get_current_scene().whale_gas >= 100
