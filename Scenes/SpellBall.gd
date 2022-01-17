extends KinematicBody2D

var velocity = Vector2()
var colorpool = [Color("ffffff"),Color("32faff"),Color("fb7eff"),Color("b87eff")]

onready var destroy = $Destroy
onready var boom = $Boom
onready var poof = $Poof

var broken :bool = false

func _ready():
	$AnimatedSprite.visible = true
	boom.emitting = false
	# Setting a random color
	var color = int(rand_range(0,4))
	modulate = colorpool[color]
	destroy.start()

func _physics_process(delta):
	if !broken:
		velocity.x += 15
	elif broken:
		velocity.x -= 30
		
	move_and_slide(velocity)


func _on_Destroy_timeout():
	queue_free()

func _on_Detect_body_entered(body):
	if (body.is_in_group("Breakable")):
		body.destroy()
		boom()
	elif (body.is_in_group("Unbreakable")):
		body.hit()
		queue_free()
	
func boom():
	broken = true
	poof.play("Poof")
