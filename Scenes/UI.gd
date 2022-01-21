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
var retard :bool = false

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
		if boss_on and !boss.dead:
			bossbar.value = boss.hp
		elif boss_on and boss.dead:
			EndBossFight()
			
	if player.dead:
		if !game_ended:
			deathscreen.play("PlayerDeath")
			game_ended = true
		
func UpdateBossBar():
	if retard:
		bossprogress.min_value = int(player.time*100)
	bossprogress.max_value = int(player.boss_time*100) + 20
	bossname.text = boss.BossName
	
func BossFight():
	boss_on = true
	bossanimation.play("StartFight")
	
func EndBossFight():
	bossanimation.play("EndFight")
	
func NewBoss():
	boss_on = false
	player.BossReset()
	retard = true
	UpdateBossBar()
	

func DeathScreen():
	deathscreen.play("DeathScreen")
