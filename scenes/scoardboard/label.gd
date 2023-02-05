extends Node2D

onready var v_box_container = $ScrollContainer/VBoxContainer
var list = []
var http_request_get = HTTPRequest.new()
var http_request_post = HTTPRequest.new()

func _ready():
	add_child(http_request_get)
	add_child(http_request_post)
	http_request_get.connect("request_completed", self, "_on_request_completed")
	http_request_get.request("https://born2beroot-1efbb-default-rtdb.europe-west1.firebasedatabase.app/scoreboard.json")
	add_score("test2", 1234)

func customComparison(a, b):
	if typeof(a.score) != typeof(b.score):
		return typeof(a) > typeof(b)
	else:
		return a.score > b.score

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	
	var tab = []
	
	for key in json.result:
		var current = json.result[key]
		tab.append(current)
	
	tab.sort_custom(self, "customComparison")
	for current in tab:
		var label = Label.new()
		var string_res = "User {} score {}".format([current.nickname, current.score], "{}")
		label.set_text(string_res)
		v_box_container.add_child(label)

func add_score(name, score):
	var query = JSON.print({"nickname": name, "score": score})
	print(query)
	var headers = ["Content-Type: application/json"]
	var error = http_request_post.request("https://born2beroot-1efbb-default-rtdb.europe-west1.firebasedatabase.app/scoreboard.json", headers, true, HTTPClient.METHOD_POST, query)
	if error != OK:
		 push_error("An error occurred in the HTTP request.")
	print(error)
