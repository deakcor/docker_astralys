extends Area2D

var rotation_angle = 50
var angle_from = 0
var angle_to = 360
export var center = Vector2(0, 0)
var color = Color(1.0, 0.9, 0.8,1.0) setget change_color
export var radius = 60 setget change_radius
var death=false
func _ready():
	if randi()%2==0:
		$anim_deplacement.set_speed_scale(0.3)
		$anim_deplacement.play("sinus")
		self.color=Color(1.0, 0.5, 0.0,1.0)
	else:
		$anim_deplacement.play("lineaire")
		self.color=Color(1.0, 0.2, 0.0,1.0)
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _draw():
	
	
	
	
	draw_circle_arc_poly( center, radius, angle_from, angle_to, color )

func die():
	death=true
	$anim_deplacement.play("death")
func change_radius(newradius:int):
	radius=newradius
	if has_node("CollisionShape2D"):
		get_node("CollisionShape2D").shape.radius=newradius
func change_color(newcolor:Color):
	color=newcolor
func _process(delta):
	update()


func _on_ennemi_body_entered(body):
	if (body is Projectile) and !death:
		die()
		body.queue_free()
		get_parent().get_parent().add_score()
	if (body is Player):
		body.die()
