extends MarginContainer


func _on_City_city_move(height):
	var normalized_height = height * -1
	$HBoxContainer/Info/Height.text = "Height: " + str(normalized_height)
	
	pass # Replace with function body.
