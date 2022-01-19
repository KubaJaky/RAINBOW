extends Node2D

onready var cooldown = $CD
onready var player = get_parent().get_node("Player")

var obstacle
var cloud = preload("Obstacle1.tscn")
var raincloud = preload("Obstacle2.tscn")

export var on :bool = true

func _ready():
	# Random Cooldown
	cooldown.wait_time = int(rand_range(1,4))
	cooldown.start()
	
func spawn():
	# rng for the obstacle spawned
	obstacle = int(rand_range(0,8))
	if obstacle > 1 and obstacle < 4:
		var spawned = cloud.instance()
		self.add_child(spawned)
	elif obstacle > 3 and obstacle < 5:
		var spawned = raincloud.instance()
		self.add_child(spawned)
	cooldown.start()
	
	
	
	


func _on_CD_timeout():
	if !player.dead and on:
		spawn()
