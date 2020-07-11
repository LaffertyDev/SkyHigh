extends Node

export(int) var starting_height

func _ready():
	print("Game script ready")
	$City.position.y = starting_height * -1

func _on_City_hit_ground():
	# hit the ground
	print("Game Over")
	var res = get_tree().change_scene("res://game_menu/main_menu.tscn")
	if res != OK:
		print("There was a massive failure")
