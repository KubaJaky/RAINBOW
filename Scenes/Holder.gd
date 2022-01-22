extends Node2D

var holder = {
	"hatID":0,
	"wandID":0,
}

var hatID :int
export var menu :bool = false
export var game :bool = false

# do not try to save in _ready, it doesn't work
func _ready():
	load_data()
	hatequip()
	if menu:
		var Customize = get_parent().get_node("Customization/Hat")
		Customize.hatID = hatID
		Customize.hatUpdate()
	elif game:
		var Player = get_parent().get_node("Player")
		Player.hatID = hatID
		Player.hatUpdate()


# saves everyhing in the "save" variable
func save_data():
	var file = File.new()
	file.open("user://holder.json",file.WRITE_READ)
	file.store_var(holder)
	file.close()
	
# and load
func load_data():
	var file = File.new()
	if not file.file_exists("user://holder.json"):
		return false
	file.open("user://holder.json",file.READ)
	holder = file.get_var()
	file.close()
	return true

func hatequip():
	hatID = holder.hatID
	
func hatchange():
	hatID += 1
	if hatID > 5:
		hatID = 0
	holder.hatID = hatID
	save_data()
