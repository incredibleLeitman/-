extends Node

signal item_pickup
signal item_give
signal spawn_buddy
signal port_player
signal player_fall

var player_pos = Vector2(0, 0)
var second_player_pos = Vector2(0, 0)
const max_distance = 5000

var item_textures = {
	"ferry-item": preload("res://resources/Aufsammel.png"),
	"heart": preload("res://resources/Herz.png"),
	"star": preload("res://resources/fehlendeForm.png"),
}

func get_distance_factor():
	var fac = (player_pos - second_player_pos).length() / max_distance
	return min(fac, 1.2)

func _hide_textBubble (animated_sprite):
	if animated_sprite == null:
		printText("sprit was nall", MODE_VERBOSE_L1)
		return

	var tween = null
	if animated_sprite.get_children().size() != 0:
		tween = animated_sprite.get_node("twModulate")
	else:
		tween = Tween.new()
		tween.name = "twModulate"
		animated_sprite.add_child(tween)
		tween.connect("tween_completed", self, "_animation_complete")
	tween.interpolate_property(animated_sprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _show_textBubble (animated_sprite):
	if animated_sprite == null:
		printText("sprit was nall", MODE_VERBOSE_L1)
		return

	if animated_sprite.get_children().size() != 0:
		var tween = animated_sprite.get_node("twModulate")
		tween.stop(animated_sprite)
	animated_sprite.modulate = Color(1, 1, 1, 1)
	animated_sprite.frame = 0
	animated_sprite.show()
	animated_sprite.play()

func _animation_complete(object, key):
	#var da_booty = get_parent()
	#da_booty.free()
	#object.hide()
	pass

const DEBUG = true
const MODE_VERBOSE_L1 = 1
const MODE_VERBOSE_L2 = 2
const MODE_VERBOSE_L3 = 3
const VERBOSE_LEVEL = MODE_VERBOSE_L2

func printText (text, mode):
	if DEBUG && mode <= VERBOSE_LEVEL:
		print(text)


