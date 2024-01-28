extends Control



@export var dialog_path = ""
@export var text_speed: float = 0.005

@onready var timer = $CharDelay
@onready var text = $JokeText
@onready var audio = $Speak
@onready var load_delay = $LoadTimer
@onready var falling_punchlines = $"../FallingPunchlines"
@onready var audio_manager = $"/root/AudioEngine"
@onready var comedian = $"../../GamePlaceholder/Comedian"

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


func shuffle_joke_array():
	randomize()
	dialog.shuffle()


func next_phrase() -> void:
	comedian.change_and_anim_sprite(dialog[joke_number]["expression"], 55)
	audio.playing = true
	
	audio_manager.play_random_mumble_joke()
	finished = false
	comedian.change_and_anim_sprite("joke", 4)
	text.bbcode_text = dialog[joke_number]["joke"]
	
	text.visible_characters = 0
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		await timer.timeout
	
	audio.playing = false
	finished = true
	joke_number += 1
	falling_punchlines.spawn_punchlines()
	return


func _on_load_timer_timeout():
	dialog = get_dialog()
	shuffle_joke_array()
