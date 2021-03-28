extends Node2D

export(String) var wanted_item

var friend
var tween_status = 0

func _ready():
	friend = get_node(".")
	get_node("Area2D").connect("body_entered", self, "_on_Area2D_body_entered")
	get_node("Area2D").connect("body_exited", self, "_on_Area2D_body_exited")
	pass # Replace with function body.

func _on_Area2D_body_exited(body):
	if tween_status == 0:
		get_node("Area2D/AnimatedHeart").hide()
	
func _on_Area2D_body_entered(body):
	global.printText("on body entered for " + body.name, global.MODE_VERBOSE_L2)
	if body.name == "Player":
		get_node("Area2D/AnimatedHeart").show()
		if item_array.items.has(wanted_item):
			global.printText("having wanted item: " + wanted_item, global.MODE_VERBOSE_L2)
			_give_item(wanted_item, body)
			get_node("Area2D").disconnect("body_entered", self, "_on_Area2D_body_entered")

func _give_item(wanted_item, body):
	# spawn the texture of the wanted item
	var item_texture = Sprite.new()
	item_texture.scale = Vector2(0.05, 0.05)
	item_texture.set_texture(global.item_textures.star)
	item_texture.position = to_local(body.position)
	add_child(item_texture)
	
	var posTo = to_local(Vector2(position.x, position.y - 50))
	global.printText("tween to pos " + String(position), global.MODE_VERBOSE_L2)
	
	# animate the give
	var tw = Tween.new()
	tw.name = "my_tweeny"
	item_texture.add_child(tw)
	tw.interpolate_property(item_texture, "position",
		Vector2(item_texture.position.x, item_texture.position.y), posTo,
		1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.connect("tween_completed", self, "_on_tween_completed")
	tw.start()
	global.emit_signal("item_give", wanted_item)

func _on_tween_completed (object, key):
	if tween_status == 0:
		tween_status += 1
		#tween.interpolate_property(friend, "scale", Vector2(1, 1), Vector2(2, 2), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		#tween.start()
		var anim = get_node("Area2D/AnimatedHeart")
		anim.show()
		anim.stop()
		var tween = anim.get_node("TweenHeart")
		tween.connect("tween_completed", self, "_on_tween_completed")
		tween.interpolate_property(anim, "scale", Vector2(0.069, 0.069), Vector2(0.14, 0.14), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	elif tween_status == 1:
		#var tween = get_node("tween")
		#if tween == null:
		var tween = Tween.new()
		tween.name = "tween"
		add_child(tween)
		tween.connect("tween_completed", self, "_on_tween_completed")
		
		tween_status += 1
		tween.interpolate_property(friend, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	elif tween_status == 2:
		global.emit_signal("spawn_buddy")
		queue_free()
