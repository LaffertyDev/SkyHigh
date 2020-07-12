extends Node2D

var max_height = 0

func set_gas_text(gas):
	$WhaleGas.text = "Whale Gas: " + str(gas)

func _on_City_city_move(height, velocity, acceleration, mass_kg):
	var normalized_height = int(floor(height * -1))
	if (normalized_height > max_height):
		max_height = normalized_height
		$Max_Height.text = "Max Height: " + str(max_height) + " meters"

	normalized_height = (normalized_height - (normalized_height % 100))
	if (normalized_height < 2000):
		$Height.text = "Height: " + str(normalized_height) + " meters"
	else:
		$Height.text = "Height: " + str(normalized_height / 1000) + " km"
	var normalized_velocity = floor(velocity * -1)
	var normalized_acceleration = stepify(acceleration * -1, 0.01)
	
	$Acceleration/Up.visible = normalized_acceleration > 0
	$Acceleration/Down.visible = normalized_acceleration < 0
	$Acceleration/Value.text = str(normalized_acceleration)
	
	$Velocity/Up.visible = normalized_velocity > 0
	$Velocity/Down.visible = normalized_velocity < 0
	$Velocity/Value.text = str(normalized_velocity)
	
	$Mass/Value.text = str(mass_kg)
