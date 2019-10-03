extends KinematicBody2D

export var max_speed:int=500
var mouse_pos:Vector2
var shoot_rdy=false
var shoot_press=false

func _ready():
	set_physics_process(false)

func set_rdy():
	set_physics_process(true)
	shoot_rdy=true

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos=event.position
	if event is InputEventMouseButton:
		if event.pressed:
			shoot_press=true
		else:
			shoot_press=false
			


func _physics_process(delta):
	var velocity=(mouse_pos-self.position)
	move_and_slide(velocity.clamped(max_speed))
	if shoot_press and shoot_rdy:
		shoot_rdy=false
		$timer_shoot.start()
		var proj=preload("res://scene/player/projectile.tscn").instance()
		proj.position=position+Vector2(0,60-60*(randi()%2)*2)
		get_parent().call_deferred("add_child",proj)


func _on_timer_shoot_timeout():
	shoot_rdy=true
