extends KinematicBody2D


signal hit_ground
signal city_move(height_meters, velocity_ms, accleration_ms2, mass_kg)

export(Vector2) var velocity = Vector2(0, 0)

var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

export(int) var balloon_lift_newtons : int = 100 # divide by 10

func _ready():
	pass # Replace with function body.

func _process(_bdelta):
	var position = self.global_position.y
	if (position > 0):
		emit_signal("hit_ground")

	emit_signal("city_move", position, velocity.y, _get_accel(), _get_platforms().size())
	
	
func _physics_process(delta):
	velocity.y += _get_accel() * delta;
	var _result = move_and_slide(velocity)
	
func _get_platforms():
	return get_tree().get_nodes_in_group("platforms")
	
func _get_balloons():
	return get_tree().get_nodes_in_group("balloons")

func _get_build_platforms():
	return get_tree().get_nodes_in_group("build_platforms")

func _get_accel():
	var balloon_total_lift = (_get_balloons().size() * balloon_lift_newtons) / _get_platforms().size()
	var acceleration_delta = float((gravity_magnitude - balloon_total_lift)) / 10.0 
	return acceleration_delta

func _on_build_platform_built_platform(offset_x, offset_y):
	var build_platforms = _get_build_platforms()

	for b_plat in build_platforms:
		if (b_plat.offset_x == offset_x && b_plat.offset_y == offset_y):
			# replace build platform with a legit platform
			_handle_build_platform(b_plat)
			break;
			
func _handle_build_platform(build_platform):
	var platform_scene = load("res://units/platform/platform.tscn")
	var platform_instance = platform_scene.instance()
	platform_instance.set_name("platform" + str(build_platform.offset_x) + "_" + str(build_platform.offset_y))
	platform_instance.position.x = build_platform.offset_x * (64 + 30)
	platform_instance.position.y = build_platform.offset_y * (64 + 30)
	platform_instance.offset_x = build_platform.offset_x
	platform_instance.offset_y = build_platform.offset_y
	
	var section_scene = load("res://units/section/section.tscn")
	var section_instance1 = section_scene.instance()
	section_instance1.position.x = -24
	section_instance1.position.y = -32
	platform_instance.add_child(section_instance1)
	var section_instance2 = section_scene.instance()
	section_instance2.position.x = 24
	section_instance2.position.y = -32
	platform_instance.add_child(section_instance2)
	
	add_child(platform_instance)
	remove_child(build_platform)
	
	var should_build_left = build_platform.offset_x > -3 # cannot build more to the left
	var should_build_right = build_platform.offset_x < 3 # cannot build more to the right
	var platforms = _get_platforms()
	for plat in platforms:
		should_build_left = should_build_left && plat.offset_x != (build_platform.offset_x - 1)
		should_build_right = should_build_right && plat.offset_x != (build_platform.offset_x + 1)
	
	if should_build_left:
		var left = _generate_platform_ui(build_platform.offset_x - 1, build_platform.offset_y)
		add_child(left)
	if should_build_right:
		var right = _generate_platform_ui(build_platform.offset_x + 1, build_platform.offset_y)
		add_child(right)

func _generate_platform_ui(offset_x, offset_y):
	var build_plat_scene = load("res://units/build_platform/build_platform.tscn")
	var instance = build_plat_scene.instance()
	instance.set_name("platform")
	instance.connect("built_platform", self, "_on_build_platform_built_platform")
	instance.position.x = offset_x * (64 + 30)
	instance.position.y = offset_y * (64 + 30)
	instance.offset_x = offset_x
	instance.offset_y = offset_y
	return instance
