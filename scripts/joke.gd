extends Control

@export var dialog_path = ""
@export var text_speed: float = 0.005

@onready var timer = $CharDelay
@onready var text = $JokeText
@onready var audio = $Speak
@onready var load_delay = $LoadTimer

var dialog

var joke_number = 0
var finished = false


func _ready():
	timer.wait_time = text_speed
	load_delay.start()


func get_dialog() -> Array:
	var file = FileAccess.open(dialog_path,FileAccess.READ)
	var json = file.get_as_text()
	
	var json_object = JSON.new()
	var error = json_object.parse(json)

	if error == OK:
		var data_received = json_object.data
		if typeof(data_received) == TYPE_ARRAY:
			return data_received
		else:
			return []
	else:
		return []


func next_phrase() -> void:
	audio.playing = true
	
	finished = false
	
	text.bbcode_text = dialog[joke_number]["joke"]
	
	text.visible_characters = 0
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		await timer.timeout
	
	audio.playing = false
	finished = true
	joke_number += 1
	return


func _on_load_timer_timeout():
	dialog = get_dialog()
