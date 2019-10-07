extends Node
class_name Game
enum LOCATION{
	menu,
	game
}

onready var yourname=$titlescreen/yourname
onready var anim=$titlescreen/AnimationPlayer
var player_name="your_name"
var location=0
var score=0
func _ready():
	bdd.test_DB()
	pass

func go():
	anim.play("go")
	location=LOCATION.game


func _on_TextureButton_pressed():
	if yourname.text!="":
		player_name=yourname.text
	go()

func fin_partie():
	$control/score_label.queue_free()
	$scene/Timer.stop()
	var ld_tmp=preload("res://scene/hud/leaderboard.tscn").instance()
	ld_tmp.init(self)
	$control.add_child(ld_tmp)
func _on_Timer_timeout():
	var newennemi=preload("res://scene/player/ennemi.tscn").instance()
	newennemi.position.y=randi()%1000+80
	$scene.add_child(newennemi)
	$scene/Timer.start($scene/Timer.wait_time-$scene/Timer.wait_time/100)
	add_score()

func add_score():
	score+=1
	$control/score_label/score_nb.set_text("  "+str(score))
