extends Node

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("item_pickup", self, "_on_item_pickup")
	global.connect("item_give", self, "_on_item_give")

func _on_item_pickup(item_name):
	items.append(item_name)
	global.printText("adding to item_array: " + item_name, global.MODE_VERBOSE_L2)
	
func _on_item_give(item_name):
	if items.has(item_name):
		items.erase(item_name)