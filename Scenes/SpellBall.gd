extends KinematicBody2D

var velocity = Vector2()
var colorpool = [Color("ffffff"),Color("32faff"),Color("fb7eff"),Color("b87eff")]
onready var destroy = $Destroy

func _ready():
	var color = int(rand_range(0,4))
	modulate = colorpool[color]
	destroy.start()

func _physics_process(delta):
	velocity.x += 15
	
	move_and_slide(velocity)


func _on_Destroy_timeout():
	queue_free()

func _on_Detect_body_entered(body):
	if (body.is_in_group("Breakable")):
		body.destroy()
		queue_free()
