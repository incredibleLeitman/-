extends Node2D

var move_distance = -3000
var move = false
var moved = 0
var move_speed = 80

var moving = "left"
var arrived = false

onready var MoveRightArea = get_node("MoveRightArea")

var start_pos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	global.connect("item_give", self, "_on_item_give")
	global.connect("player_fall", self, "_on_player_fall")
	MoveRightArea.connect("body_entered", self, "_on_body_entered_area")

func _on_player_fall():
	position = start_pos
	moving = ""
	moved = 0

func _physics_process(delta):
	if not move: return
	
	var movement = move_speed * delta
	
	if moving == "left":
		moved -= movement
		position.x -= movement
	elif moving == "right":
		moved += movement
		position.x += movement
		
	if moved <= move_distance:
		moving = ""

func _on_item_give(item):
	if item == "ferry-item":
		move = true
		
func _on_body_entered_area(body):
	if body.name == "Player" and moving == "":
		if moved == 0:
			moving = "left"
		else:
			moving = "right"