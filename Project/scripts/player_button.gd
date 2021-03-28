extends TextureButton

func _ready():
	var mama = get_parent().get_parent()
	mama.show()
	

func _pressed():
	# make all world assets visible 
	var world = get_tree().get_root().get_node("Root").get_node("World")

	#_show(world)
	world.show()
	
	# hide the button and replace with player
	hide()
	var scene = load("res://scenes/Player.tscn")
	scene = scene.instance()
	scene.set_name("Player")
	get_tree().get_root().add_child(scene)
	
	# fade in map and background
	var tween = Tween.new()
	
	world.add_child(tween)
	tween.interpolate_property(world, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	var parallax = world.get_node("ParallaxBackground")
	parallax.offset = Vector2(0, 0)

# sad :(
func _show(node):
	if node.get_children():
		for child_node in node.get_children():
			_show(child_node)
	node.show()