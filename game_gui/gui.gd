extends MarginContainer


func _on_City_city_move(height, velocity, acceleration, mass_kg):
	var normalized_height = int(floor(height * -1))
	normalized_height = (normalized_height - (normalized_height % 100))
	if (normalized_height < 2000):
		$HBoxContainer/Info/Height.text = "Height: " + str(normalized_height) + " meters"
	else:
		$HBoxContainer/Info/Height.text = "Height: " + str(normalized_height / 1000) + " km"
	var normalized_velocity = floor(velocity * -1)
	var normalized_acceleration = acceleration * -1

	$HBoxContainer/Info/Velocity.text = "Velocity: " + str(normalized_velocity) + " m/s"
	$HBoxContainer/Info/Acceleration.text = "Acceleration: " + str(normalized_acceleration) + " m/s^2"
	$HBoxContainer/Info/Mass.text = "Mass: " + str(mass_kg) + " KG"
