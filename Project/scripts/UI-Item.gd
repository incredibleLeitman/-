extends MarginContainer

onready var TexRect = get_node("TextureRect")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_texture(tex):
	TexRect.texture = tex