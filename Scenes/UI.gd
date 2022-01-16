extends CanvasLayer

onready var player = get_parent().get_node("Player")
onready var manacount = $ManaRingProgress/ManaCount
onready var manaring = $ManaRingProgress

func _physics_process(delta):
	manacount.text = str(int(player.mana))+"%"
	manaring.value = int(player.mana)
