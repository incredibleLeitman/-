extends Node2D

onready var area = get_node("Area2D")

export(String) var item_name = "test"

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "_on_area_entered")

func _on_area_entered(body):
	if (!body.name == "Player") and (!body.name == "Player2"): return
	
	global.emit_signal("item_pickup", item_name)
	queue_free()