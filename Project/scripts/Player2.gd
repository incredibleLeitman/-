extends KinematicBody2D

const GRAVITY = 30
const MOVE_SPEED = 300
const ACCELL_SPEED = 10
const JUMP_SPEED = 650
const VECTOR_UP = Vector2(0, -1)

var velocity = Vector2()
onready var tween = get_node("Tween")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Camera2D").free()
	global.connect("port_player", self, "_do_the_port")
	_rotate()

func _do_the_port(veci, player_name):
	if player_name == "Player2":	
		position = veci

func _rotate():
	tween.interpolate_property($".", "rotation_degrees", 90, 0, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _physics_process(delta):
	_movement(delta)
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, VECTOR_UP)
	global.second_player_pos = position

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