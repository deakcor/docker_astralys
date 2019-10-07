extends Control

var global
var rdy=false
func _ready():
	insert_new()
	display_ld()
	rdy=true
func init(global):
	self.global=global
func insert_new():
	var query: String
	query = "INSERT INTO scores (name, score) VALUES ('"
	query += global.player_name
	query += "', " 
	query += str(global.score)
	query += ");"
	var result = bdd.query(query)

func display_ld():
	var scrollcont=$Control/NinePatchRect/VBoxContainer/ScrollContainer/VBoxContainer
	for k in scrollcont.get_children():
		k.queue_free()
	var lst: Array = bdd.array("SELECT * FROM scores ORDER BY score DESC")
	for i in lst:
		var tmp=preload("res://scene/hud/ld_entry.tscn").instance()
		tmp.get_node("nom").set_text(i.name)
		tmp.get_node("score").set_text(str(i.score))
		scrollcont.add_child(tmp)

func del_all():
	var query = "DELETE FROM scores"
	bdd.query(query)
	display_ld()
func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_button_reset_pressed():
	del_all()
