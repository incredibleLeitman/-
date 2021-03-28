extends ColorRect

func _process(delta):
	var factor = global.get_distance_factor()

	material.set_shader_param("factor", factor / 15)