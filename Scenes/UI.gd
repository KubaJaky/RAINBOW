extends CanvasLayer

onready var player = get_parent().get_node("Player")
onready var boss = get_parent().get_node("Boss")
var game_ended :bool = false
var boss_on :bool = false
onready var manacount = $ManaRingProgress/ManaCount
onready var manaring = $ManaRingProgress
onready var deathscreen = $DeathScreen
onready var bossprogress = $BossBarHolder/BossProgress
onready var bossanimation = get_parent().get_node("Boss_Animation")
onready var bossname = $BossBarHolder/TextureProgress/BossName
onready var bossbar = $BossBarHolder/TextureProgress

onready var time = $Time

func _ready():
	UpdateBossBar()

func _physics_process(delta):
	manacount.text = str(int(player.mana))+"%"
	manaring.value = int(player.mana)
	time.text = str(int(player.time))
	bossprogress.value = player.time*100
	if bossprogress.value == bossprogress.max_value:
		if !boss_on:
			BossFight()
		if boss_on:
			bossbar.value = boss.hp
	
	if player.dead:
		if !game_ended:
			deathscreen.play("PlayerDeath")
			game_ended = true
		
func UpdateBossBar():
	bossprogress.max_value = player.boss_time*100
	bossname.text = boss.BossName
	
func BossFight():
	boss_on = true
	bossanimation.play("StartFight")

func DeathScreen():
	deathscreen.play("DeathScreen")
