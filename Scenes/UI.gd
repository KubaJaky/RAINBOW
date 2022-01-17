extends CanvasLayer

onready var player = get_parent().get_node("Player")
onready var game_ended :bool = false
onready var manacount = $ManaRingProgress/ManaCount
onready var manaring = $ManaRingProgress
onready var deathscreen = $DeathScreen

onready var time = $Time

func _physics_process(delta):
	manacount.text = str(int(player.mana))+"%"
	manaring.value = int(player.mana)
	time.text = str(int(player.time))
	if player.dead:
		if !game_ended:
			deathscreen.play("PlayerDeath")
			game_ended = true
		

func DeathScreen():
	deathscreen.play("DeathScreen")
