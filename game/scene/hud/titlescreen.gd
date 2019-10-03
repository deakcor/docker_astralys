extends Node

enum LOCATION{
	menu,
	game
}

onready var anim=$titlescreen/AnimationPlayer

var location=0
func _ready():
	bdd.test_DB()
	pass

func _input(event):
	if event is InputEventMouseButton:
		if location==LOCATION.menu:
			go()

func go():
	anim.play("go")
	location=LOCATION.game
	get_node("scene/player").set_rdy()
