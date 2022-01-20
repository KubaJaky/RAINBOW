extends KinematicBody2D

onready var hurtsound = $Hurt
onready var gesture = $BossGestures

var Titles = ["Great", "Almighty", "Grand", 
"Big", "Invincible", "Fearless", "Sensual", 
"Mysterious", "Enchanting", "Vigorous", "Diligent", 
"Overwhelming", "Gorgeous", "Passionate", "Terrifying", 
"Beautiful", "Powerful", "Grey Prince", "Strong", "Sexual",
"Sussy", "Sticky", "Slimey", "Godlike", "Horny"]

var Names = ["Bob", "John", "Jihn", "Zote", "Papai", "Joe",
 "Giorno", "Rafiozo", "Lolo", "Susel", "Jake", "Arthur", "Glob",
"Blob", "Bum", "Xin", "John", "Heher", "Yun", "Tae", "Jin", 
"Hu", "Tao", "Hen", "Tai", "Gao", "Yur", "Ri", "Kee",
"Mih", "Wizychriusz", "Ciechan", "God", "Hed", "Ahe"]

var Surnames = ["Xina", "Gurr", "Tao", "Tae", "Ri", "Gao", "Tai",
"Geo", "Giovanna", "Baka", "Jin", "Impostor", "Al" , "Hoyo", 
"ot", "Brzęczyszczykiewicz", "", "", "", "", "", "", "", "", "",
"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

var Colors = ["ff7878", "ffc478", "fffd78", "afff78", "78ff7d",
"78ffd6", "78dfff", "7884ff", "9f78ff", "ce78ff", "ff78fd",
"ff78d7", "ff78ba", "ff78a1", "b4b4b4"]

var ShieldColors = ["ff5252", "ff9752", "fff452", "68ff52", "52ceff", "9052ff", "fe52ff"]

var nameId1 = int(rand_range(0,24))
var nameId2 = int(rand_range(0,34))
var nameId3 = int(rand_range(0,39))
var colorId = int(rand_range(0,14))

# Basic Boss States
var BossName :String
var hp :int = 100
var on :bool = true
export var unhitable :bool = false

# Boss Shield
export var shielded :bool = false
var shield_track :int
var shield_hp :int
var max_shield_hp :int = 10
onready var shield = $Shield
onready var shieldhit = $Shield/ShieldHit
onready var shieldanim = $ShieldAnimation

var laser_track :int
var double_laser_track1 :int
var double_laser_track2 :int
var mega_laser_track :int
onready var megalasertimer = $MegaLaser

# Actions, Attack etc.
onready var actionCD = $Action
var actionID :int

onready var player = get_parent().get_node("Player")

func _ready():
	BossName = Titles[nameId1] + " " + Names[nameId2] + " " + Surnames[nameId3]
	$Horns.modulate = Colors[colorId]
	$Wand.modulate = Colors[colorId]
	gesture.play("Idle")
	shield_hp = max_shield_hp
	
func Idle():
	gesture.play("Idle")
	
func hurt(var dmg, var track):
	if !unhitable and !shielded and on:
		hp -= dmg
		hurtsound.play()
	elif shielded and on:
		if track == shield_track:
			shield_hp -= dmg
			shieldhit.restart()
			shieldhit.emitting = true
			hurtsound.play()
		
func _physics_process(delta):
	if on:
		if shielded and shield_hp <= 0:
			shield_break()
		if player.dead:
			off()
		
func shield_on():
	shield_track = int(rand_range(0,7))
	shield.modulate = ShieldColors[shield_track]
	gesture.play("Action")
	shieldanim.play("Shield_On")
		
func shield_break():
	shield_hp = max_shield_hp
	shieldanim.play("Shield_Break")
	
func single_laser():
	gesture.play("Action")
	laser_track = player.current_track_num
	get_parent().get_node("Spawner"+str(laser_track)).laser()
	
func double_laser():
	gesture.play("Action")
	double_laser_track1 = int(rand_range(0,7))
	reset_double_laser2()
	double_laser_track2 = int(rand_range(0,7))
	while double_laser_track2 == double_laser_track1:
		reset_double_laser2()
		print("reset")
	get_parent().get_node("Spawner"+str(double_laser_track1)).laser()
	get_parent().get_node("Spawner"+str(double_laser_track2)).laser()
	
func reset_double_laser2():
	double_laser_track2 = int(rand_range(0,7))
	
func mega_laser():
	gesture.play("Action")
	if player.current_track_num == 0:
		mega_laser_track = player.current_track_num + 1
	elif player.current_track_num == 6:
		mega_laser_track = player.current_track_num - 1
	else: 
		var mega_laser_offset :int = int(rand_range(-1,2))
		mega_laser_track = player.current_track_num + mega_laser_offset
		
	get_parent().get_node("Spawner"+str(mega_laser_track)).laser_on = false
	megalasertimer.start()
	
	for n in 7:
		get_parent().get_node("Spawner" + str(n)).laser()
	
func Action_Reset():
	if on:
		actionCD.wait_time = int(rand_range(7,11))
		actionCD.start()

func _on_Action_timeout():
	if on:
		actionID = int(rand_range(0,4))
		# Single Laser
		if actionID == 0:
			single_laser()
		# Shield
		elif actionID == 1 and !shielded:
			shield_on()
		elif actionID == 1 and shielded:
			pass
		# Double Laser
		elif actionID == 2:
			double_laser()
		# Mega Laser
		elif actionID == 3:
			mega_laser()
		Action_Reset()
		
func off():
	actionCD.stop()
	on = false
	

func _on_MegaLaser_timeout():
	get_parent().get_node("Spawner"+str(mega_laser_track)).laser_on = true
