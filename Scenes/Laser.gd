extends KinematicBody2D

var zap = preload("res://Scenes/Zap.tscn")

func _ready():
	$LaserAnim.play("Shoot")

func destroy():
	var spawned = zap.instance()
	spawned.global_position = self.global_position
	spawned.restart()
	spawned.emitting = true
	get_parent().add_child(spawned)
	queue_free()
	
