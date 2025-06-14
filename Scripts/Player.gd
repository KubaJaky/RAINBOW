extends KinematicBody2D

var velocity = Vector2(0,0)
onready var player = get_parent().get_node("Player")
onready var movement = $Movement
onready var PlayerAnim = $Idle
onready var Action = $Action
var WorldEnv 

# All Tracks and The Track you are currently on
var tracks = ["Red","Orange","Yellow","Green","Blue","Purple","Pink"]
var current_track_num = 4
var current_track = tracks[current_track_num]
var moving :bool = false

# Shooting and mana
onready var aim = $aim
var spellball = preload("res://Scenes/SpellBall.tscn")
var can_shoot :bool = true
var mana = 100
var shootcost = 10

var time = 0
var boss_time = 65
var boss_space = 85
var boss_progress :int = 0

# Dead State
var dead :bool = false

var hatID :int = 0

func _ready():
	randomize()
	WorldEnv = get_parent().get_node("WorldEnvironment/WorldEnvironmentAnim")
	WorldEnv.play("Reset")
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
		if can_shoot and mana >= shootcost:
			Action.stop()
			Action.play("Shoot")

func shoot():
	can_shoot = false
	var projectile = spellball.instance()
	get_parent().add_child(projectile)
	mana -= shootcost
	projectile.global_position = aim.global_position
		
func shoot_able():
	can_shoot = true
	
func mana_regen():
	if can_shoot:
		mana += 0.07
	
func _physics_process(delta):
	if !dead:
		
		# Time
		time += delta
		
		# Mana Regeneration
		mana = clamp(mana,0.0,100.0)
		mana_regen()
		
		# Movement
		get_input()
		move_and_slide(velocity)
		

# Death
func _on_Death_body_entered(body):
	if body.is_in_group("Obstacle"):
		body.destroy()
		Death()
		
func Death():
	dead = true
	Action.play("Death")
	DeathSound()
	
func DeathCamera():
	$Camera.play("DeathScreenCamera")
	
func DeathSound():
	var soundID = int(rand_range(1,5))
	get_node("Death/Hit"+str(soundID)).play()
	
func ShootSound():
	var soundID = int(rand_range(1,5))
	get_node("aim/Shoot"+str(soundID)).play()
	
func BossCamera():
	$Camera.play("BossCamera")
	
func BossReset():
	boss_time = int(time) + int(boss_space)
	$Camera.play_backwards("BossCamera")
	
func hatUpdate():
	$Hat.texture = load("res://Sprites/Character/Hat" + str(hatID) + (".png"))
