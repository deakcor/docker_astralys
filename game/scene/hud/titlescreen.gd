extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text("ok" if (bdd.test_DB()==true) else "nop")
	
