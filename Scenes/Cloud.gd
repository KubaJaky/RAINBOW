extends KinematicBody2D

var velocity = Vector2()
onready var destroyAnim = $Destroy
onready var timeout = $Timeout
onready var collapse = $Collapse
onready var player = get_parent().get_parent().get_node("Player")
onready var sound = $sound
var destroyed :bool = false

var speed = 25
var soundID = int(rand_range(1,5))
var soundID2 = int(rand_range(1,4))

func _ready():
	$Sprite.visible = true
	$CollisionShape2D.set_deferred("disabled",false)
	collapse.emitting = false
	sound.start()
	timeout.start()

func _physics_process(delta):
	if !player.dead:
		velocity.x -= speed
	elif player.dead:
		destroy()
		
	move_and_slide(velocity)
	
# Breakable
func destroy():
	if !destroyed:
		destroyAnim.play("Destroy")
		get_node("Woosh"+str(soundID)).stop()
		get_node("Hit"+str(soundID2)).play()
		sound.stop()
		destroyed = true
		
func breakdown():
	queue_free()
	
# Unbreakable
func hit():
	collapse.restart()
	collapse.emitting = true
	get_node("Hit"+str(soundID2)).play()

func _on_Timeout_timeout():
	breakdown()


func _on_sound_timeout():
	get_node("Woosh"+str(soundID)).play()
	
	
