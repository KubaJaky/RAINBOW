extends TextureButton

onready var tween: = $Tween
onready var playercustomize = get_parent().get_parent().get_parent().get_node("Not-A-Player")
onready var save = get_parent().get_parent().get_parent().get_node("Holder")

onready var hat = get_parent().hat
onready var hat_number :int = 5
var hatID :int = 0


func _on_TextureButton_mouse_entered():
	if get_parent().on:
		tween.interpolate_property(self, "rect_scale", Vector2(2.5, 1.75), Vector2(2.0, 2.0), 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.start()


func _on_TextureButton_pressed():
	if get_parent().on:
		if hat:
			hatID += 1
			if hatID > hat_number:
				hatID = 0
			playercustomize.get_node("Hat").texture = load("res://Sprites/Character/Hat" + str(hatID) + (".png"))
			save.hatchange()
			tween.interpolate_property(self, "rect_scale", Vector2(2.5, 1.75), Vector2(2.0, 2.0), 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
			tween.start()
			
func hatUpdate():
	hatID = get_parent().hatID
	playercustomize.get_node("Hat").texture = load("res://Sprites/Character/Hat" + str(hatID) + (".png"))
