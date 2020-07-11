extends Node2D

export(int) var health = 100

signal balloon_pop

func _ready():
	add_to_group("balloons")

# core is 0 - 8/14.5 km
# stratosphere is up to 50 km
# mesophere is up to 85 km
# iss is 330 - 410 km
# thermosphere is up to 600 km
# 2000km is LEO
# 10k KM is the limit of the exosphere
# 35k km is GEO

func _process(delta):
	# 0 height, 0 health lost per second
	# 1km, 1 health lost per second
	# 10km, 10 health lost per second
	var health_lost = (-1 * self.global_position.y) / 1000 * delta
	health = health - health_lost
	$HealthBar.value = health
	if health < 0:
		get_parent().remove_child(self)
		emit_signal("balloon_pop")
		
	if health < 100:
		$HealthBar.visible = true
		
# get city height
# write exponential decay for health lost per tick
