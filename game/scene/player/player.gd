extends KinematicBody2D
class_name Player
export var max_speed:int=1000
var mouse_pos:Vector2
var shoot_rdy=false
var shoot_press=false
var death=false
func _ready():
	set_physics_process(false)

func set_rdy():
	set_physics_process(true)
	shoot_rdy=true

func _input(event):
	if event is InputEventMouseMotion:
		if event.position.x>0 and event.position.x<1920 and event.position.y>0 and event.position.y<1080:
			mouse_pos=event.position
	if event is InputEventMouseButton:
		if event.pressed:
			shoot_press=true
		else:
			shoot_press=false
			


func _physics_process(delta):
	var velocity=(mouse_pos-self.position)
	move_and_slide((velocity*3).clamped(max_speed))
	if shoot_press and shoot_rdy:
		shoot_rdy=false
		$timer_shoot.start()
		var proj=preload("res://scene/player/projectile.tscn").instance()
		proj.position=position
		get_parent().call_deferred("add_child",proj)
	if Engine.get_frames_per_second()<30:
		stopparticule()

func stopparticule():
	$reacteur_particle.emitting=false
	$reacteur_particle2.emitting=false
func die():
	if !death:
		death=true
		get_parent().get_parent().fin_partie()
		set_physics_process(false)
		$AnimationPlayer.play("die")
func _on_timer_shoot_timeout():
	shoot_rdy=true
