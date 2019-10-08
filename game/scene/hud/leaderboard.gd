extends Control

var global
var rdy=false
func _ready():
	addto_ld({"name":"The site is down","score":"or bad port"})
	if OS.get_name()!="HTML5":
		insert_new()
		display_ld()
		rdy=true
	else:
		if global!=null:
			$HTTPRequest.request("http://localhost:8080/postld?name="+global.player_name+"&score="+str(global.score),PoolStringArray(),true,HTTPClient.METHOD_POST)
		else:
			$HTTPRequest.request("http://localhost:8080/postld?name=test&score=0",PoolStringArray(),true,HTTPClient.METHOD_POST)
func init(global):
	self.global=global
func insert_new():
	if global!=null:
		var query: String
		query = "INSERT INTO scores (name, score) VALUES ('"
		query += global.player_name
		query += "', " 
		query += str(global.score)
		query += ");"
		var result = bdd.query(query)

func display_ld():
	reset_ld()
	var lst: Array = bdd.array("SELECT * FROM scores ORDER BY score DESC")
	for i in lst:
		addto_ld(i)
func reset_ld():
	var scrollcont=$Control/NinePatchRect/VBoxContainer/ScrollContainer/VBoxContainer
	for k in scrollcont.get_children():
		k.queue_free()
func addto_ld(i:Dictionary):
	var scrollcont=$Control/NinePatchRect/VBoxContainer/ScrollContainer/VBoxContainer
	var tmp=preload("res://scene/hud/ld_entry.tscn").instance()
	tmp.get_node("nom").set_text(i.name)
	tmp.get_node("score").set_text(str(i.score))
	scrollcont.add_child(tmp)

func del_all():
	if OS.get_name()!="HTML5":
		var query = "DELETE FROM scores"
		bdd.query(query)
		display_ld()
	else:
		reset_ld()
		$HTTPRequest.request("http://localhost:8080/delldgd")
		
func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_button_reset_pressed():
	del_all()


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var res = JSON.parse(body.get_string_from_utf8()).result
	if res is Array:
		print(res)
		reset_ld()
		for i in res:
			addto_ld(i)
	elif res is bool:
		print(res)
		$HTTPRequest.request("http://localhost:8080/leaderboardgd")
