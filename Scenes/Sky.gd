extends Sprite

onready var player_dead = get_parent().get_node("Player").dead

export var speed :float

func _physics_process(delta):
	if !player_dead:
		rotation_degrees += speed
