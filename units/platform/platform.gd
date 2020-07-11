extends Node2D

export(int) var offset_x
export(int) var offset_y

func _ready():
	add_to_group("platforms")
