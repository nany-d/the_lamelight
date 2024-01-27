extends Node2D

# Spawn in correct option + 3 more incorrect from the JSON file
# if correct selected remove all, animations etc. happen then next joke new punchlines +comedy
# if incorrect remove all, animations etc. happen then next joke new punchlines, -comedy

const PunchLine = preload("res://game/punch_line.tscn")

@onready var joke = $"../Joke"
@onready var audio_manager = $"/root/AudioEngine"
@onready var joke_delay = $"../JokeDelay"

var comedy = GlobalSettings.comedy
var punch_number = GlobalSettings.punch_number

signal next_joke

func spawn_punchlines():
	var correct_punch_chosen = false
	var false_array = [2, 3]
	
	
	for i in range(punch_number):
		var p = PunchLine.instantiate()
		add_child(p)
		p.position += Vector2((i + 1) * 300, 0)
		if randi_range(i+1, punch_number) == punch_number and not correct_punch_chosen:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_1"])
			p.set_correct(true)
			correct_punch_chosen = true
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		else:
			p.set_punchline(joke.dialog[joke.joke_number - 1]["choice_" + str(false_array.pop_at(randi_range(0, (false_array.size() - 1))))])
			p.set_correct(false)
			p.punch_line_button.connect("pressed", punch_line_check.bind(p))
		p.visible_on_screen_notifier_2d.connect("screen_exited", fail_to_click)
			

func fail_to_click():
	audio_manager.play_random_audience_cough()
	comedy -= punch_number
	print(comedy)
	remove_punchlines()

func punch_line_check(punch_line):
	if (punch_line.is_correct):
		comedy += 1
		audio_manager.play_random_clap_laugh()
	else:
		comedy -= 1
		audio_manager.play_random_audience_disapproval()
	print(comedy)
	remove_punchlines()

func remove_punchlines():
	for child in get_children():
		child.queue_free()
	joke_delay.start()


func _on_joke_delay_timeout():
	emit_signal("next_joke")
