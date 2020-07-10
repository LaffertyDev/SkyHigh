extends Node

export(int) var starting_height


func _ready():
	print("Game script ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_City_hit_ground():
	# hit the ground
	print("Game Over")
	var res = get_tree().change_scene("res://game_menu/MainMenu.tscn")
	if res != OK:
		print("There was a massive failure")
