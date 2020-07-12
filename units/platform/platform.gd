extends Node2D

export(int) var offset_x
export(int) var offset_y

export(float) var whale_default_mass = 5
export(float) var platform_default_mass = 7

var whales = 0

func _ready():
	add_to_group("platforms")


func _on_Platform_body_entered(body):
	if body.is_in_group("whales"):
		whales += 1
		body.queue_free()
		var resource = load("res://units/whale/whale_sprite.tscn")
		var instance = resource.instance()
		instance.position.y = randi() % 10 - 5
		instance.position.x = randi() % 10 - 5
		instance.rotation_degrees = randi() % 360
		add_child(instance)

func get_mass():
	return platform_default_mass + (whales * whale_default_mass)
