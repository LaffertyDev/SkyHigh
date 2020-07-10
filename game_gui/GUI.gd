extends MarginContainer


func _on_City_city_move(height, velocity, acceleration):
	var normalized_height = floor(height * -1)
	var normalized_velocity = floor(velocity * -1)
	var normalized_acceleration = acceleration * -1
	$HBoxContainer/Info/Height.text = "Height: " + str(normalized_height)
	$HBoxContainer/Info/Velocity.text = "Velocity: " + str(normalized_velocity)
	$HBoxContainer/Info/Acceleration.text = "Acceleration: " + str(normalized_acceleration)
