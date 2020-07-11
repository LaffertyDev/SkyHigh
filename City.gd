extends KinematicBody2D


signal hit_ground
signal city_move(height_meters, velocity_ms, accleration_ms2, mass_kg)

export(Vector2) var velocity = Vector2(0, 0)

var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

export(int) var balloon_lift_newtons : int = 10 # divide by 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	var position = self.global_position.y
	if (position > 0):
		emit_signal("hit_ground")

	emit_signal("city_move", position, velocity.y, _get_accel(), _get_platforms().size())
	
	
func _physics_process(delta):
	velocity.y += _get_accel() * delta;
	move_and_slide(velocity)
	
func _get_platforms():
	return get_tree().get_nodes_in_group("platforms")
	
func _get_balloons():
	return get_tree().get_nodes_in_group("balloons")

func _get_accel():
	var balloon_total_lift = (_get_balloons().size() * balloon_lift_newtons) / _get_platforms().size()
	var acceleration_delta = float((gravity_magnitude - balloon_total_lift)) / 10.0 
	return acceleration_delta
