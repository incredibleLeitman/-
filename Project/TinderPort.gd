extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Area2D_body_entered")
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		global.emit_signal("port_player", Vector2(body.position.x, body.position.y), "Player2")
	elif body.name == "Player2":
		global.emit_signal("port_player", Vector2(body.position.x, body.position.y), "Player")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
