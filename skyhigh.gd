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

func _on_Whale_killed():
	print("Whale dead")

func _on_Whale_Spawn():
	var whale_resource = load("res://units/whale/whale.tscn")
	var whale_instance = whale_resource.instance()
	whale_instance.connect("whale_died", self, "_on_Whale_Killed")
	whale_instance.global_position.x = $City.global_position.x
	whale_instance.global_position.y = $City.global_position.y - 1000
	
	self.add_child(whale_instance)
	pass # Replace with function body.
