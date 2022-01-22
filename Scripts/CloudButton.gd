extends TextureButton

onready var scene = get_parent().ScenePath
onready var back = get_parent().back
onready var quit = get_parent().quit
onready var customize = get_parent().customize
onready var customizent = get_parent().customizent
var parent = get_parent()
onready var tween: = $Tween

func _on_TextureButton_mouse_entered():
	if get_parent().on:
		tween.interpolate_property(self, "rect_scale", Vector2(2.5, 1.75), Vector2(2.0, 2.0), 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.start()
	
func _on_TextureButton_pressed():
	if get_parent().on:
		if !quit and !customize and !customizent:
			tween.interpolate_property(self, "rect_scale", Vector2(2.5, 1.75), Vector2(2.0, 2.0), 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
			tween.start()
			get_tree().change_scene(str(scene))
			if !back:
				$ButtonClick.play()
			elif back:
				$BackButton.play()
		elif quit:
			get_tree().quit()
		elif customize:
			get_parent().get_parent().get_parent().get_node("Transition").play("Customization")
		elif customizent:
			get_parent().get_parent().get_parent().get_node("Transition").play_backwards("Customization")
