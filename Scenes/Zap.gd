extends Particles2D

func _on_Destroy_timeout():
	queue_free()
