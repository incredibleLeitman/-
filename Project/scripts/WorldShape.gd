extends StaticBody2D

var is_weird = false setget set_weirdness, get_weirdness
var friend_name = "Player2"

export(bool) var disable_weird_shadow = true

onready var nice = get_node("Sprites/NiceSprite")
onready var weird = get_node("Sprites/WeirdSprite")
onready var niceness = get_node("NicenessArea")
onready var occluder = get_node("LightOccluder2D")

func _ready():
	niceness.connect("body_entered", self, "_on_entered")
	niceness.connect("body_exited", self, "_on_exited")
	
	set_weirdness(true)
	
func _on_entered(body):
	if body.name == friend_name:
		set_weirdness(false)
	
func _on_exited(body):
	if body.name == friend_name:
		set_weirdness(true)
	
func get_weirdness():
	return is_weird

func set_weirdness(val):
	is_weird = val
	
	weird.visible = is_weird
	nice.visible = !is_weird
	
	if disable_weird_shadow:
		occluder.visible = !is_weird