extends KinematicBody2D

var velocity = Vector2(0,0)
onready var movement = $Movement
onready var PlayerAnim = $Idle
onready var Action = $Action

# All Tracks and The Track you are currently on
var tracks = ["Red","Orange","Yellow","Green","Blue","Purple","Pink"]
var current_track_num = 4
var current_track = tracks[current_track_num]
var moving :bool = false

onready var aim = $aim
var spellball = preload("res://Scenes/SpellBall.tscn")
var can_shoot :bool = true

var mana = 100

func _ready():
	PlayerAnim.play("Idle")
	#prevents the particles from emitting on the start 
	$Pew.emitting = false

func get_input():
	# Movement
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
	if Input.is_action_just_pressed("shoot"):
		if can_shoot and mana >= 5:
			Action.stop()
			Action.play("Shoot")

func shoot():
	can_shoot = false
	var projectile = spellball.instance()
	get_parent().add_child(projectile)
	mana -= 5
	projectile.global_position = aim.global_position
		
func shoot_able():
	can_shoot = true
	
func mana_regen():
	if can_shoot:
		mana += 0.1
	
func _physics_process(delta):
	
	mana = clamp(mana,0.0,99.9)
	mana_regen()
	
	get_input()
	move_and_slide(velocity)
