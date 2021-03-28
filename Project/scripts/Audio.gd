extends Node

onready var a1 = get_node("AudioStreamPlayer")
onready var a2 = get_node("AudioStreamPlayer2")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var factor = global.get_distance_factor()
	
	var factor_scaled = (factor - 0.1)
	
	if factor < 0.1:
		a1.volume_db = 1 - factor
		a2.volume_db = -1000 * (1-factor)
	elif factor < 0.2:
		a1.volume_db = -5
		a2.volume_db = -5
	else:
		a1.volume_db = -1000 * factor
		a2.volume_db = 0.7