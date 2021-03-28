extends Area2D

export(String) var wanted_item

func _on_Area2D_body_exited(body):
	global._hide_textBubble(get_node("AnimatedSprite"))

func _on_Area2D_body_entered(body):
	if body.name == "Player" or body.name == "Player2":
		if item_array.items.has(wanted_item):
			_give_item(wanted_item, body)
			disconnect("body_entered", self, "_on_Area2D_body_entered")
			disconnect("body_exited", self, "_on_Area2D_body_exited")
			get_node("AnimatedSprite").free()
		else:
			global._show_textBubble(get_node("AnimatedSprite"))

func _give_item(wanted_item, body):
	# spawn the texture of the wanted item
	var item_texture = Sprite.new()
	item_texture.scale.x = 0.05
	item_texture.scale.y = 0.05
	item_texture.set_texture(global.item_textures[wanted_item])
	item_texture.position = to_local(body.position)
	add_child(item_texture)
	
	# animate the give
	var tw = Tween.new()
	tw.name = "my_tweeny"
	item_texture.add_child(tw)
	tw.interpolate_property(item_texture, "position",
		Vector2(item_texture.position.x, item_texture.position.y), Vector2(position.x, position.y),
		1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	
	global.emit_signal("item_give", wanted_item)