extends RigidBody2D


signal hit_ground
signal city_move(height)

func _ready():
	pass # Replace with function body.

func _process(delta):
	var position = self.global_position.y
	if (position > 0):
		emit_signal("hit_ground")

	emit_signal("city_move", position)
