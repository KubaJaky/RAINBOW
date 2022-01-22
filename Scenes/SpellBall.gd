extends KinematicBody2D

var velocity = Vector2()
var colorpool = [Color("ff1f1f"),Color("ff981f"),Color("ffe11f"),Color("50ff1f"), Color("1fcbff"), Color("9a1fff"), Color("ff1fb7")]

onready var player = get_parent().get_node("Player")
onready var destroy = $Destroy
onready var boom = $Boom
onready var poof = $Poof

var damage :int = 5

var broken :bool = false

var track :int

func _ready():
	track = player.current_track_num
	$AnimatedSprite.visible = true
	boom.emitting = false
	# Setting a color based on the track you're on
	modulate = colorpool[track]
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
	elif (body.is_in_group("Boss")):
		body.hurt(damage,track)
		boom()
	
func boom():
	broken = true
	poof.play("Poof")
