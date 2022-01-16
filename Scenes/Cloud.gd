extends KinematicBody2D

var velocity = Vector2()
onready var destroyAnim = $Destroy
onready var timeout = $Timeout

func _ready():
	$Sprite.visible = true
	$CollisionShape2D.disabled = false
	$Collapse.emitting = false
	timeout.start()

func _physics_process(delta):
	velocity.x -= 25
	
	move_and_slide(velocity)
	
func destroy():
	destroyAnim.play("Destroy")
	
func breakdown():
	queue_free()

func _on_Timeout_timeout():
	breakdown()
