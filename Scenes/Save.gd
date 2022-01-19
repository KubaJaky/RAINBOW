extends Node2D

var save = {
	"BestTime":0,
	"BossKills":0,
	"Coins":0,
}

onready var player = get_parent().get_parent().get_node("Player")
onready var time = get_parent().get_node("DeathScreen2/Panel/BestTime")
onready var deathscreen = get_parent().get_node("DeathScreen2")

# do not try to save in _ready, it doesn't work
func _ready():
	if load_data():
		time.set_text(str("Best Time: ",int(save.BestTime)))


# saves everyhing in the "save" variable
func save_data():
	var file = File.new()
	file.open("user://save",file.WRITE_READ)
	file.store_var(save)
	file.close()
	
# and load
func load_data():
	var file = File.new()
	if not file.file_exists("user://save"):
		return false
	file.open("user://save",file.READ)
	save = file.get_var()
	file.close()
	return true
	
func Time():
	if player.time > save.BestTime:
		save.BestTime = player.time
		time.set_text(str("Best Time: ",int(save.BestTime)))
		deathscreen.highscore()
		save_data()
