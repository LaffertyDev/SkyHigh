extends Node2D

signal built_platform(offset_x, offset_y)

export(int) var offset_x # x in grid location for where this build should occur
export(int) var offset_y # y in grid location for where this build should occur

func _ready():
	add_to_group("build_platforms")

func _on_Build_Clicked():
	print("clicked")
	emit_signal("built_platform", offset_x, offset_y)
