extends RigidBody2D

export(int) var health = 1
export(int) var min_speed = 10
export(int) var max_speed = 100

signal whale_died

func _ready():
	add_to_group("whales")
	$HealthBar.max_value = health
	$HealthBar.value = health
	$HealthBar.visible = false
	if randi() % 2 == 0:
		$AnimatedSprite.flip_h = true
		self.linear_velocity = Vector2(-rand_range(min_speed, max_speed), 0)
	else:
		self.linear_velocity = Vector2(rand_range(min_speed, max_speed), 0)


func _on_Whale_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		health -= 1
		$HealthBar.value = health
		$HealthBar.visible = true
		if health <= 0:
			emit_signal("whale_died")
			queue_free()
			#get_parent().remove_child(self)
