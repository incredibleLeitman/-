extends ParallaxBackground

onready var sprite1 = get_node("ParallaxLayer/Sprite")
onready var sprite2 = get_node("ParallaxLayer2/Sprite")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var factor = global.get_distance_factor()
	
	sprite1.modulate.r = 0.6 + factor * 0.6
	sprite2.modulate.r = 0.6 + factor * 0.6
	