extends KinematicBody2D


signal hit_ground
signal city_move(height, velocity, accleration)

export(Vector2) var velocity = Vector2(0, 0)

var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

var balloons : int = 9
var balloon_lift_newtons : int = 10 # divide by 10

var current_mass_kg : int = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	var position = self.global_position.y
	if (position > 0):
		emit_signal("hit_ground")

	emit_signal("city_move", position, velocity.y, _get_accel())
	
	
func _physics_process(delta):
	velocity.y += _get_accel() * delta;
	move_and_slide(velocity)

func _get_accel():
	var balloon_total_lift = (balloons * balloon_lift_newtons) / current_mass_kg
	print(balloon_total_lift)
	var acceleration_delta = float((gravity_magnitude - balloon_total_lift)) / 10.0 
	return acceleration_delta
