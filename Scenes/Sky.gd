extends Sprite

onready var player_dead = get_parent().get_node("Player").dead

func _physics_process(delta):
	if !player_dead:
		rotation_degrees += 0.01
