extends KinematicBody2D

var velocity = Vector2()
onready var movement = $Movement

# All Tracks and The Track you are currently on
var tracks = ["Red","Orange","Yellow","Green","Blue","Purple","Pink"]
var current_track_num = 4
var current_track = tracks[current_track_num]
var moving = false


func get_input():
	if Input.is_action_just_pressed("up"):
		if current_track_num < 1:
			return
		elif movement.is_playing() == false:
			movement.play(str(current_track_num)+"Up")
			current_track_num -= 1
	if Input.is_action_just_pressed("down"):
		if current_track_num > 5:
			return
		elif movement.is_playing() == false:
			movement.play(str(current_track_num)+"Down")
			current_track_num += 1

		
func _physics_process(delta):
	
	get_input()
	move_and_slide(velocity)
