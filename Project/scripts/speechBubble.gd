extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func _on_SpeechBubble_body_entered(body):
	global._show_textBubble(get_node("AnimatedSprite"))

func _on_SpeechBubble_body_exited(body):
	global._hide_textBubble(get_node("AnimatedSprite"))
