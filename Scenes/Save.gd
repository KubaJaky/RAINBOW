extends Node2D

var save = {
	"BestTime":0,
	"BossKills":0,
	"BossProgress":0
}

onready var player = get_parent().get_parent().get_node("Player")
onready var time = get_parent().get_node("DeathScreen2/Panel/BestTime")
onready var deathscreen = get_parent().get_node("DeathScreen2")
onready var bossprogressed = get_parent().get_node("DeathScreen2/Panel/BossProgressed")
onready var bosskills = get_parent().get_node("DeathScreen2/Panel/BossKills")

# do not try to save in _ready, it doesn't work
func _ready():
	if load_data():
		time.set_text(str("Best Time: ",int(save.BestTime)))
		bosskills.set_text(str("Boss Kills: ",int(save.BossKills)))
		bossprogressed.set_text(str("Boss Progress: ",int(save.BossProgress)))


# saves everyhing in the "save" variable
func save_data():
	var file = File.new()
	file.open("user://save.json",file.WRITE_READ)
	file.store_var(save)
	file.close()
	
# and load
func load_data():
	var file = File.new()
	if not file.file_exists("user://save.json"):
		return false
	file.open("user://save.json",file.READ)
	save = file.get_var()
	file.close()
	return true
	
func Time():
	print(save.BestTime)
	if int(player.time) > int(save.BestTime):
		save.BestTime = player.time
		time.set_text(str("Best Time: ",int(save.BestTime)))
		deathscreen.highscore()
		save_data()
		
func add_kill():
	save.BossKills += 1
	bosskills.set_text(str("Boss Kills: ",int(save.BossKills)))
		
func Boss_Progress():
	if player.boss_progress > save.BossProgress:
		save.BossProgress = player.boss_progress
		bossprogressed.set_text(str("Boss Progress: ",int(save.BossProgress)))
		deathscreen.new_boss_progress()
		save_data()
