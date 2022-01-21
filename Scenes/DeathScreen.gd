extends CanvasLayer

onready var player = get_parent().get_parent().get_node("Player")
onready var save = get_parent().get_node("Save")
onready var time = $Panel/Time
onready var besttime = $Panel/BestTime
onready var countsound = $Panel/Time/Count
var counting :int
var Iscounting :bool = false

func _physics_process(delta):
	time.text = "Time: "+str(counting)
	if Iscounting:
		count()
		
func new_boss_progress():
	$Panel/Progressed.restart()
	$Panel/Progressed/Trrr.play()
	$Panel/Progressed.emitting = true
		
func start_counting():
	Iscounting = true

func count():
	if counting == int(player.time):
		Iscounting = false
		save.Boss_Progress()
		save.Time()
	if counting < int(player.time):
		counting += 1
		countsound.play()
		counting = clamp(counting,0,int(player.time))
		
func highscore():
	$NewHighScore.play("HighScore")
