extends KinematicBody2D

var speed=1000
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(Vector2(speed,0))
