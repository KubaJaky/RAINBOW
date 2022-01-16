extends Node2D

onready var cooldown = $CD

var obstacle
var cloud = preload("Obstacle1.tscn")

func _ready():
	# Random Cooldown
	cooldown.wait_time = int(rand_range(1,4))
	cooldown.start()
	
func spawn():
	# rng for the obstacle spawned
	obstacle = int(rand_range(0,4))
	if obstacle == 1:
		var spawned = cloud.instance()
		self.add_child(spawned)
	cooldown.start()
	
	
	
	


func _on_CD_timeout():
	spawn()
