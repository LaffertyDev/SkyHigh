extends Node



func _on_Game_Start():
	var res = get_tree().change_scene("res://skyhigh.tscn")
	if res != OK:
		print("There was a massive failure")


func _on_ExitButton_pressed():
	get_tree().quit()
