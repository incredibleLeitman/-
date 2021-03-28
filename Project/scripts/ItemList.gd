extends HBoxContainer

var item_scene = preload("res://scenes/UI-Item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("item_pickup", self, "add_item")
	global.connect("item_give", self, "remove_item")
	
func remove_item(item_name):
	if has_node(item_name):
		get_node(item_name).queue_free()

func add_item(item_name):
	if not has_node(item_name):
		var instanced = item_scene.instance()
		instanced.name = item_name
		add_child(instanced)
		
		get_node(item_name).set_texture(global.item_textures[item_name])
		
	if item_name == "test" and not has_node("test"):
		var instanced = item_scene.instance()
		instanced.name = "test"
		add_child(instanced)
		
		get_node("test").set_texture(load("res://resources/Herz.png"))
	
	if item_name == "ferry-item" and not has_node("ferry-item"):
		var instanced = item_scene.instance()
		instanced.name = "ferry-item"
		add_child(instanced)
		
		get_node("ferry-item").set_texture(load("res://resources/Aufsammel.png"))
		
	if item_name == "test2" and not has_node("test"):
		var instanced = item_scene.instance()
		instanced.name = "test2"
		add_child(instanced)
		
		get_node("test2").set_texture(load("res://resources/Herz.png"))