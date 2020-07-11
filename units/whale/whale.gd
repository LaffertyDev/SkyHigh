extends Area2D

export(int) var health = 1

signal whale_died

func _ready():
	add_to_group("whales")

func _on_Whale_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		health -= 1
		if health <= 0:
			emit_signal("whale_died")
			get_parent().remove_child(self)
