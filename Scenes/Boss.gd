extends KinematicBody2D

onready var hurtsound = $Hurt
onready var gesture = $BossGestures

var Titles = ["Great", "Almighty", "Grand", 
"Big", "Invincible", "Fearless", "Sensual", 
"Mysterious", "Enchanting", "Vigorous", "Diligent", 
"Overwhelming", "Gorgeous", "Passionate", "Terrifying", 
"Beautiful", "Powerful", "Grey Prince", "Strong", "Sexual",
"Sussy", "Sticky", "Slimey", "Horny", "Godlike"]

var Names = ["Bob", "John", "Jihn", "Zote", "Papai", "Joe",
 "Giorno", "Rafiozo", "Lolo", "Susel", "Jake", "Arthur", "Glob",
"Blob", "Bum", "Xin", "John", "Heher", "Yun", "Tae", "Jin", 
"Hu", "Tao", "Hen", "Tai", "Ahe", "Gao", "Yur", "Ri", "Kee",
"Mih", "Wizychriusz", "Ciechan", "God", "Hed"]

var Surnames = ["Xina", "Gurr", "Tao", "Tae", "Ri", "Gao", "Tai",
"Geo", "Giovanna", "Baka", "Jin", "Impostor", "Al" , "Hoyo", 
"ot", "Brzęczyszczykiewicz", "", "", "", "", "", "", "", "", "",
"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

var nameId1 = int(rand_range(0,25))
var nameId2 = int(rand_range(0,35))
var nameId3 = int(rand_range(0,40))

var BossName :String
var hp :int = 100

func _ready():
	BossName = Titles[nameId1] + " " + Names[nameId2] + " " + Surnames[nameId3]
	gesture.play("Idle")
	
func hurt(var dmg):
	hp -= dmg
	hurtsound.play()
	
