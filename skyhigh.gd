extends Node

export(int) var starting_height

export(int) var whale_gas = 200

export(int) var whale_worth = 25

func _ready():
	print("Game script ready")
	$City.position.y = starting_height * -1
	
func _process(_delta):
	$CanvasLayer/GUI.set_gas_text(whale_gas)

func _on_City_hit_ground():
	# hit the ground
	print("Game Over")
	var res = get_tree().change_scene("res://game_menu/main_menu.tscn")
	if res != OK:
		print("There was a massive failure")

func _on_Whale_Killed():
	whale_gas += whale_worth

func _on_Whale_Spawn():
	$Whale_Timer.wait_time = max($City.position.y / 1000, 1)
	var whale_resource = load("res://units/whale/whale.tscn")
	var whale_instance = whale_resource.instance()
	whale_instance.connect("whale_died", self, "_on_Whale_Killed")
	whale_instance.position.x = $City.global_position.x
	whale_instance.position.y = $City.global_position.y - 1000
	whale_instance.health = max(int(floor($City.position.y / -1500)), 1)
	
	self.add_child(whale_instance)
	pass # Replace with function body.
