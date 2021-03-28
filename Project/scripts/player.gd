extends KinematicBody2D

const GRAVITY = 30
const MOVE_SPEED = 300
const ACCELL_SPEED = 10
const JUMP_SPEED = 650
const VECTOR_UP = Vector2(0, -1)
const START_POS = Vector2(100, 0)

var plus_rotation = true
var timer = 0
var wait = 0
var min_wait = 0.2
var velocity = Vector2()
var second_player_unlocked = false
onready var tween = get_node("Tween")

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("spawn_buddy", self, "_on_spawn_buddy")
	global.connect("port_player", self, "_do_the_port")
	_rotate()

func _do_the_port(veci, player_name):
	if player_name == "Player":
		position = veci
	
func _on_spawn_buddy():
	var scene = load("res://scenes/Player2.tscn")
	scene = scene.instance()
	scene.position = Vector2(position.x - 10, position.y)
	scene.get_node("Sprite").texture = load("res://resources/frienddreieck.png")
	get_tree().get_root().add_child(scene)

func _rotate():
	tween.interpolate_property($".", "rotation_degrees", 90, 0, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _physics_process(delta):	
	# Handle movement
	_movement(delta)
	velocity.y += GRAVITY

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.
	
	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	velocity = move_and_slide(velocity, VECTOR_UP)
	
	global.player_pos = position
	
	# wobling for when the triangle leaves home
	_yoshi_egg_wobble(delta)

	# for testing reasons
	#if Input.is_action_just_pressed("ui_down"):
	#	second_player_unlocked = true
		
	if second_player_unlocked == true: 
		var scene = load("res://scenes/Player2.tscn")
		scene = scene.instance()
		#scene.set_name("Player2") # not needed
		scene.position = Vector2(position.x - 10, position.y)
		#scene.modulate = Color(23, 1, 23, 1)
		scene.get_node("Sprite").texture = load("res://resources/frienddreieck.png")
		get_tree().get_root().add_child(scene)
		second_player_unlocked = false
	
	if position.y > 900:
		position = START_POS
		global.emit_signal("player_fall")

func _yoshi_egg_wobble(delta):
	timer += delta
	wait += delta
	if wait > 0.30: #wobbles for 0.3s, then waits with wobble until (1/(distance * 2 + 0.01)) + min_wait time has passed
		rotation_degrees = 0
		if wait > (1/((global.get_distance_factor() * 2 + 0.01))) + min_wait:
			wait = 0
	else:
		if timer > 0.05:
			timer = 0
			if plus_rotation == true:
				plus_rotation = false
				rotation_degrees = 10 * global.get_distance_factor()
				#rotation_degrees = rad2deg(asin(global.get_distance_factor()))
				global.printText(rotation_degrees, global.MODE_VERBOSE_L3)
			else:
				plus_rotation = true
				rotation_degrees = -10 * global.get_distance_factor()
				#rotation_degrees = -rad2deg(asin(global.get_distance_factor()))
		#tween.interpolate_property(sprite, "rotation_degrees", 5, 0, 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		
func _movement(delta):
	var target = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		target.x = -MOVE_SPEED
	elif Input.is_action_pressed("ui_right"):
		target.x = MOVE_SPEED
	else:
		target.x = 0

	var prev_vel = velocity
	var new_vel = prev_vel.linear_interpolate(target, ACCELL_SPEED * delta)
	
	velocity.x = new_vel.x
	
	if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_accept"):
		#jump
		if is_on_floor():
			velocity.y = -JUMP_SPEED

